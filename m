Received: from eggs.gnu.org ([2001:4830:134:3::10]:47887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpR-0005z2-Oh
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpJ-0005kg-2p
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpI-0005kJ-T4
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:34 -0400
Message-Id: <1502149958-23381-19-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/22] translate-all: protect TB jumps with a
 per-destination-TB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

This applies to both user-mode and !user-mode emulation.

Instead of relying on a global lock, protect the list of incoming
jumps with tb->jmp_lock.

In order to find the destination TB (and therefore its jmp_lock)
from the origin TB, we introduce tb->jmp_dest[]. This results
in TranslationBlock using 3 cache lines on many systems instead
of 2, but benchmarking doesn't seem to suffer much because of it.

I considered not using a linked list of jumps, which simplifies
code and keeps the struct under two cache lines. However, it
unnecessarily increases memory usage, which results in a performance
decrease. See for instance these numbers booting+shutting down
debian-arm:
                      Time (s)  Rel. err (%)  Abs. err (s)  Rel. slowdown (%)
------------------------------------------------------------------------------
 before                  20.88          0.74      0.154512                 0.
 after                   20.81          0.38      0.079078        -0.33524904
 GTree                   21.02          0.28      0.058856         0.67049808
 GHashTable + xxhash     21.63          1.08      0.233604          3.5919540

Using a hash table or a binary tree to keep track of the jumps
doesn't really pay off, not only due to the increased memory usage,
but also because most TBs have only 0 or 1 jumps to them. The maximum
number of jumps when booting debian-arm that I measured is 35, but
as we can see in the histogram below a TB with that many incoming jumps
is extremely rare; the average TB has 0.80 incoming jumps.

n_jumps: 379208; avg jumps/tb: 0.801099
dist: [0.0,1.0)|▄█▁▁▁▁▁▁▁▁▁▁▁ ▁▁▁▁▁▁ ▁▁▁  ▁▁▁     ▁|[34.0,35.0]

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 docs/devel/multi-thread-tcg.txt |   6 ++-
 include/exec/exec-all.h         |  76 ++++++++++++++++++---------
 accel/tcg/cpu-exec.c            |   4 +-
 accel/tcg/translate-all.c       | 110 +++++++++++++++++++++++++---------------
 4 files changed, 126 insertions(+), 70 deletions(-)

diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
index faf8918..36da1f1 100644
--- a/docs/devel/multi-thread-tcg.txt
+++ b/docs/devel/multi-thread-tcg.txt
@@ -131,8 +131,10 @@ DESIGN REQUIREMENT: Safely handle invalidation of TBs
 
 The direct jump themselves are updated atomically by the TCG
 tb_set_jmp_target() code. Modification to the linked lists that allow
-searching for linked pages are done under the protect of the
-tb_lock().
+searching for linked pages are done under the protection of tb->jmp_lock,
+where tb is the destination block of a jump. Each origin block keeps a
+pointer to its destinations so that the appropriate lock can be acquired before
+iterating over a jump list.
 
 The global page table is a lockless radix tree; cmpxchg is used
 to atomically insert new elements.
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 495efdb..64753a0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -367,7 +367,7 @@ struct TranslationBlock {
 #define CF_NOCACHE     0x10000 /* To be freed after execution */
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
-#define CF_INVALID     0x80000 /* TB is stale. Setters must acquire tb_lock */
+#define CF_INVALID     0x80000 /* TB is stale. Protected by tb->jmp_lock */
 #define CF_PARALLEL    0x100000 /* Generate code for a parallel context */
 /* cflags' mask for hashing/comparison */
 #define CF_HASH_MASK (CF_COUNT_MASK | CF_PARALLEL)
@@ -399,20 +399,27 @@ struct TranslationBlock {
 #else
     uintptr_t jmp_target_addr[2]; /* target address for indirect jump */
 #endif
-    /* Each TB has an associated circular list of TBs jumping to this one.
-     * jmp_list_first points to the first TB jumping to this one.
-     * jmp_list_next is used to point to the next TB in a list.
-     * Since each TB can have two jumps, it can participate in two lists.
-     * jmp_list_first and jmp_list_next are 4-byte aligned pointers to a
-     * TranslationBlock structure, but the two least significant bits of
-     * them are used to encode which data field of the pointed TB should
-     * be used to traverse the list further from that TB:
-     * 0 => jmp_list_next[0], 1 => jmp_list_next[1], 2 => jmp_list_first.
-     * In other words, 0/1 tells which jump is used in the pointed TB,
-     * and 2 means that this is a pointer back to the target TB of this list.
+    /*
+     * Each TB has a NULL-terminated list (jmp_list_head) of incoming jumps.
+     * Each TB can have two outgoing jumps, and therefore can participate
+     * in two lists. The list entries are kept in jmp_list_next[2]. The least
+     * significant bit (LSB) of the pointers in these lists is used to encode
+     * which of the two list entries is to be used in the pointed TB.
+     *
+     * List traversals are protected by jmp_lock. The destination TB of each
+     * outgoing jump is kept in jmp_dest[] so that the appropriate jmp_lock
+     * can be acquired from any origin TB.
+     *
+     * jmp_dest[] are tagged pointers as well. The LSB is set when the TB is
+     * being invalidated, so that no further outgoing jumps from it can be set.
+     *
+     * jmp_lock also protects the CF_INVALID cflag; a jump must not be chained
+     * to a destination TB that has CF_INVALID set.
      */
+    uintptr_t jmp_list_head;
     uintptr_t jmp_list_next[2];
-    uintptr_t jmp_list_first;
+    uintptr_t jmp_dest[2];
+    QemuSpin jmp_lock;
 };
 
 extern bool parallel_cpus;
@@ -489,28 +496,47 @@ static inline void tb_set_jmp_target(TranslationBlock *tb,
 
 #endif
 
-/* Called with tb_lock held.  */
 static inline void tb_add_jump(TranslationBlock *tb, int n,
                                TranslationBlock *tb_next)
 {
-    assert(n < ARRAY_SIZE(tb->jmp_list_next));
-    if (tb->jmp_list_next[n]) {
-        /* Another thread has already done this while we were
-         * outside of the lock; nothing to do in this case */
-        return;
+    uintptr_t old;
+
+    qemu_spin_lock(&tb_next->jmp_lock);
+
+    /* make sure the destination TB is valid */
+    if (tb_next->cflags & CF_INVALID) {
+        goto out_unlock_next;
+    }
+    /*
+     * Atomically claim the jump destination slot only if it was NULL.
+     * This implies a full barrier that pairs with the write barrier before
+     * setting jmp_dest[n] to NULL in tb_jmp_unlink, thereby guaranteeing that
+     * we see jmp_target/addr in a consistent state.
+     */
+    old = atomic_cmpxchg(&tb->jmp_dest[n], (uintptr_t)NULL, (uintptr_t)tb_next);
+    if (old) {
+        goto out_unlock_next;
     }
+
+    /* patch the native jump address */
+    tb_set_jmp_target(tb, n, (uintptr_t)tb_next->tc.ptr);
+
+    /* add in TB jmp list */
+    tb->jmp_list_next[n] = tb_next->jmp_list_head;
+    tb_next->jmp_list_head = (uintptr_t)tb | n;
+
+    qemu_spin_unlock(&tb_next->jmp_lock);
+
     qemu_log_mask_and_addr(CPU_LOG_EXEC, tb->pc,
                            "Linking TBs %p [" TARGET_FMT_lx
                            "] index %d -> %p [" TARGET_FMT_lx "]\n",
                            tb->tc.ptr, tb->pc, n,
                            tb_next->tc.ptr, tb_next->pc);
+    return;
 
-    /* patch the native jump address */
-    tb_set_jmp_target(tb, n, (uintptr_t)tb_next->tc.ptr);
-
-    /* add in TB jmp circular list */
-    tb->jmp_list_next[n] = tb_next->jmp_list_first;
-    tb_next->jmp_list_first = (uintptr_t)tb | n;
+ out_unlock_next:
+    qemu_spin_unlock(&tb_next->jmp_lock);
+    return;
 }
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d86081a..766dcb5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -366,9 +366,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
             tb_lock();
             acquired_tb_lock = true;
         }
-        if (!(tb->cflags & CF_INVALID)) {
-            tb_add_jump(last_tb, tb_exit, tb);
-        }
+        tb_add_jump(last_tb, tb_exit, tb);
     }
     if (acquired_tb_lock) {
         tb_unlock();
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4fc5c76..30c3fba 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -187,6 +187,12 @@ struct page_collection {
 #define page_for_each_tb_safe(pagedesc, tb, n, prev)                    \
     tb_for_each_tagged_safe((pagedesc)->first_tb, tb, n, page_next, prev)
 
+#define tb_for_each_jmp(head_tb, tb, n)                                 \
+    tb_for_each_tagged((head_tb)->jmp_list_head, tb, n, jmp_list_next)
+
+#define tb_for_each_jmp_safe(dest, tb, n, prev)                         \
+    tb_for_each_tagged_safe((dest)->jmp_list_head, tb, n, jmp_list_next, prev)
+
 /* In system mode we want L1_MAP to be based on ram offsets,
    while in user mode we want it to be based on virtual addresses.  */
 #if !defined(CONFIG_USER_ONLY)
@@ -1271,33 +1277,50 @@ static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
 }
 
 /* remove the TB from a list of TBs jumping to the n-th jump target of the TB */
-static inline void tb_remove_from_jmp_list(TranslationBlock *tb, int n)
+static inline void tb_remove_from_jmp_list(TranslationBlock *orig, int n_orig)
 {
-    TranslationBlock *tb1;
-    uintptr_t *ptb, ntb;
-    unsigned int n1;
+    uintptr_t ptr, ptr_locked;
+    TranslationBlock *dest;
+    TranslationBlock *tb;
+    uintptr_t *prev;
+    int n;
 
-    ptb = &tb->jmp_list_next[n];
-    if (*ptb) {
-        /* find tb(n) in circular list */
-        for (;;) {
-            ntb = *ptb;
-            n1 = ntb & 3;
-            tb1 = (TranslationBlock *)(ntb & ~3);
-            if (n1 == n && tb1 == tb) {
-                break;
-            }
-            if (n1 == 2) {
-                ptb = &tb1->jmp_list_first;
-            } else {
-                ptb = &tb1->jmp_list_next[n1];
-            }
-        }
-        /* now we can suppress tb(n) from the list */
-        *ptb = tb->jmp_list_next[n];
+    /* mark the LSB of jmp_dest[] so that no further jumps can be inserted */
+    ptr = atomic_or_fetch(&orig->jmp_dest[n_orig], 1);
 
-        tb->jmp_list_next[n] = (uintptr_t)NULL;
+    dest = (TranslationBlock *)(ptr & ~1);
+    if (dest == NULL) {
+        return;
+    }
+
+    qemu_spin_lock(&dest->jmp_lock);
+    /*
+     * While acquiring the lock, the jump might have been removed if the
+     * destination TB was invalidated; check again.
+     */
+    ptr_locked = atomic_read(&orig->jmp_dest[n_orig]);
+    if (ptr_locked != ptr) {
+        qemu_spin_unlock(&dest->jmp_lock);
+        /*
+         * The only possibility is that the jump was invalidated. Another
+         * insertion would be a bug, because we set the LSB above.
+         */
+        g_assert(ptr_locked == 1);
+        return;
+    }
+    /*
+     * We first acquired the lock, and since the destination pointer matches,
+     * we know for sure that @orig is in the jmp list.
+     */
+    tb_for_each_jmp_safe(dest, tb, n, prev) {
+        if (tb == orig && n == n_orig) {
+            *prev = tb->jmp_list_next[n];
+            /* no need to set tb->jmp_dest[n]; setting the LSB was enough */
+            qemu_spin_unlock(&dest->jmp_lock);
+            return;
+        }
     }
+    g_assert_not_reached();
 }
 
 /* reset the jump entry 'n' of a TB so that it is not chained to
@@ -1309,24 +1332,26 @@ static inline void tb_reset_jump(TranslationBlock *tb, int n)
 }
 
 /* remove any jumps to the TB */
-static inline void tb_jmp_unlink(TranslationBlock *tb)
+static inline void tb_jmp_unlink(TranslationBlock *dest)
 {
-    TranslationBlock *tb1;
-    uintptr_t *ptb, ntb;
-    unsigned int n1;
+    TranslationBlock *tb;
+    int n;
 
-    ptb = &tb->jmp_list_first;
-    for (;;) {
-        ntb = *ptb;
-        n1 = ntb & 3;
-        tb1 = (TranslationBlock *)(ntb & ~3);
-        if (n1 == 2) {
-            break;
-        }
-        tb_reset_jump(tb1, n1);
-        *ptb = tb1->jmp_list_next[n1];
-        tb1->jmp_list_next[n1] = (uintptr_t)NULL;
+    qemu_spin_lock(&dest->jmp_lock);
+
+    tb_for_each_jmp(dest, tb, n) {
+        tb_reset_jump(tb, n);
+        /*
+         * The write barrier here pairs with cmpxchg's full barrier in
+         * tb_add_jump, thereby ensuring that the jmp_target/addr will be in a
+         * consistent state right before NULL is set.
+         */
+        atomic_rcu_set(&tb->jmp_dest[n], (uintptr_t)NULL);
+        /* setting the dest ptr is enough; no need to clear the list entry */
     }
+    dest->jmp_list_head = (uintptr_t)NULL;
+
+    qemu_spin_unlock(&dest->jmp_lock);
 }
 
 /* If @rm_from_page_list is set, call with the TB's pages' locks held */
@@ -1339,7 +1364,10 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 
     assert_tb_locked();
 
+    /* make sure no further incoming jumps will be chained to this TB */
+    qemu_spin_lock(&tb->jmp_lock);
     atomic_set(&tb->cflags, tb->cflags | CF_INVALID);
+    qemu_spin_unlock(&tb->jmp_lock);
 
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
@@ -1673,10 +1701,12 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                  CODE_GEN_ALIGN));
 
     /* init jump list */
-    assert(((uintptr_t)tb & 3) == 0);
-    tb->jmp_list_first = (uintptr_t)tb | 2;
+    qemu_spin_init(&tb->jmp_lock);
+    tb->jmp_list_head = (uintptr_t)NULL;
     tb->jmp_list_next[0] = (uintptr_t)NULL;
     tb->jmp_list_next[1] = (uintptr_t)NULL;
+    tb->jmp_dest[0] = (uintptr_t)NULL;
+    tb->jmp_dest[1] = (uintptr_t)NULL;
 
     /* init original jump addresses wich has been set during tcg_gen_code() */
     if (tb->jmp_reset_offset[0] != TB_JMP_RESET_OFFSET_INVALID) {
-- 
2.7.4
