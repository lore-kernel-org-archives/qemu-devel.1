Received: from eggs.gnu.org ([2001:4830:134:3::10]:51681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTue7-0000Zi-Un
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTue5-0002fg-HG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:31 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTue5-0002ew-7R
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:29 -0400
Received: by mail-pl0-x241.google.com with SMTP id 30-v6so5845036pld.13
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:44:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Jun 2018 09:43:50 -1000
Message-Id: <20180615194354.12489-16-richard.henderson@linaro.org>
In-Reply-To: <20180615194354.12489-1-richard.henderson@linaro.org>
References: <20180615194354.12489-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 15/19] translate-all: protect TB jumps with a
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This applies to both user-mode and !user-mode emulation.

Instead of relying on a global lock, protect the list of incoming
jumps with tb->jmp_lock. This lock also protects tb->cflags,
so update all tb->cflags readers outside tb->jmp_lock to use
atomic reads via tb_cflags().

In order to find the destination TB (and therefore its jmp_lock)
from the origin TB, we introduce tb->jmp_dest[].

I considered not using a linked list of jumps, which simplifies
code and makes the struct smaller. However, it unnecessarily increases
memory usage, which results in a performance decrease. See for
instance these numbers booting+shutting down debian-arm:
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h         |  35 ++++++----
 accel/tcg/cpu-exec.c            |  41 +++++++----
 accel/tcg/translate-all.c       | 120 +++++++++++++++++++-------------
 docs/devel/multi-thread-tcg.txt |   6 +-
 4 files changed, 125 insertions(+), 77 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4f07a17052..3c2a0efb55 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -345,7 +345,7 @@ struct TranslationBlock {
 #define CF_LAST_IO     0x00008000 /* Last insn may be an IO access.  */
 #define CF_NOCACHE     0x00010000 /* To be freed after execution */
 #define CF_USE_ICOUNT  0x00020000
-#define CF_INVALID     0x00040000 /* TB is stale. Setters need tb_lock */
+#define CF_INVALID     0x00040000 /* TB is stale. Set with @jmp_lock held */
 #define CF_PARALLEL    0x00080000 /* Generate code for a parallel context */
 /* cflags' mask for hashing/comparison */
 #define CF_HASH_MASK   \
@@ -364,6 +364,9 @@ struct TranslationBlock {
     uintptr_t page_next[2];
     tb_page_addr_t page_addr[2];
 
+    /* jmp_lock placed here to fill a 4-byte hole. Its documentation is below */
+    QemuSpin jmp_lock;
+
     /* The following data are used to directly call another TB from
      * the code of this one. This can be done either by emitting direct or
      * indirect native jump instructions. These jumps are reset so that the TB
@@ -375,20 +378,26 @@ struct TranslationBlock {
 #define TB_JMP_RESET_OFFSET_INVALID 0xffff /* indicates no jump generated */
     uintptr_t jmp_target_arg[2];  /* target address or offset */
 
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
 };
 
 extern bool parallel_cpus;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 45f6ebc65e..c482008bc7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -352,28 +352,43 @@ void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr)
     }
 }
 
-/* Called with tb_lock held.  */
 static inline void tb_add_jump(TranslationBlock *tb, int n,
                                TranslationBlock *tb_next)
 {
+    uintptr_t old;
+
     assert(n < ARRAY_SIZE(tb->jmp_list_next));
-    if (tb->jmp_list_next[n]) {
-        /* Another thread has already done this while we were
-         * outside of the lock; nothing to do in this case */
-        return;
+    qemu_spin_lock(&tb_next->jmp_lock);
+
+    /* make sure the destination TB is valid */
+    if (tb_next->cflags & CF_INVALID) {
+        goto out_unlock_next;
     }
+    /* Atomically claim the jump destination slot only if it was NULL */
+    old = atomic_cmpxchg(&tb->jmp_dest[n], (uintptr_t)NULL, (uintptr_t)tb_next);
+    if (old) {
+        goto out_unlock_next;
+    }
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
 
 static inline TranslationBlock *tb_find(CPUState *cpu,
@@ -416,9 +431,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
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
index 3f977532bf..55c9e1b196 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -170,6 +170,9 @@ struct page_collection {
 #define PAGE_FOR_EACH_TB(pagedesc, tb, n)                       \
     TB_FOR_EACH_TAGGED((pagedesc)->first_tb, tb, n, page_next)
 
+#define TB_FOR_EACH_JMP(head_tb, tb, n)                                 \
+    TB_FOR_EACH_TAGGED((head_tb)->jmp_list_head, tb, n, jmp_list_next)
+
 /* In system mode we want L1_MAP to be based on ram offsets,
    while in user mode we want it to be based on virtual addresses.  */
 #if !defined(CONFIG_USER_ONLY)
@@ -389,7 +392,7 @@ static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
     return -1;
 
  found:
-    if (reset_icount && (tb->cflags & CF_USE_ICOUNT)) {
+    if (reset_icount && (tb_cflags(tb) & CF_USE_ICOUNT)) {
         assert(use_icount);
         /* Reset the cycle counter to the start of the block
            and shift if to the number of actually executed instructions */
@@ -432,7 +435,7 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
         tb = tcg_tb_lookup(host_pc);
         if (tb) {
             cpu_restore_state_from_tb(cpu, tb, host_pc, will_exit);
-            if (tb->cflags & CF_NOCACHE) {
+            if (tb_cflags(tb) & CF_NOCACHE) {
                 /* one-shot translation, invalidate it immediately */
                 tb_phys_invalidate(tb, -1);
                 tcg_tb_remove(tb);
@@ -1360,34 +1363,53 @@ static inline void tb_page_remove(PageDesc *pd, TranslationBlock *tb)
     g_assert_not_reached();
 }
 
-/* remove the TB from a list of TBs jumping to the n-th jump target of the TB */
-static inline void tb_remove_from_jmp_list(TranslationBlock *tb, int n)
+/* remove @orig from its @n_orig-th jump list */
+static inline void tb_remove_from_jmp_list(TranslationBlock *orig, int n_orig)
 {
-    TranslationBlock *tb1;
-    uintptr_t *ptb, ntb;
-    unsigned int n1;
+    uintptr_t ptr, ptr_locked;
+    TranslationBlock *dest;
+    TranslationBlock *tb;
+    uintptr_t *pprev;
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
-
-        tb->jmp_list_next[n] = (uintptr_t)NULL;
+    /* mark the LSB of jmp_dest[] so that no further jumps can be inserted */
+    ptr = atomic_or_fetch(&orig->jmp_dest[n_orig], 1);
+    dest = (TranslationBlock *)(ptr & ~1);
+    if (dest == NULL) {
+        return;
     }
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
+         * The only possibility is that the jump was unlinked via
+         * tb_jump_unlink(dest). Seeing here another destination would be a bug,
+         * because we set the LSB above.
+         */
+        g_assert(ptr_locked == 1 && dest->cflags & CF_INVALID);
+        return;
+    }
+    /*
+     * We first acquired the lock, and since the destination pointer matches,
+     * we know for sure that @orig is in the jmp list.
+     */
+    pprev = &dest->jmp_list_head;
+    TB_FOR_EACH_JMP(dest, tb, n) {
+        if (tb == orig && n == n_orig) {
+            *pprev = tb->jmp_list_next[n];
+            /* no need to set orig->jmp_dest[n]; setting the LSB was enough */
+            qemu_spin_unlock(&dest->jmp_lock);
+            return;
+        }
+        pprev = &tb->jmp_list_next[n];
+    }
+    g_assert_not_reached();
 }
 
 /* reset the jump entry 'n' of a TB so that it is not chained to
@@ -1399,24 +1421,21 @@ static inline void tb_reset_jump(TranslationBlock *tb, int n)
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
+    TB_FOR_EACH_JMP(dest, tb, n) {
+        tb_reset_jump(tb, n);
+        atomic_and(&tb->jmp_dest[n], (uintptr_t)NULL | 1);
+        /* No need to clear the list entry; setting the dest ptr is enough */
     }
+    dest->jmp_list_head = (uintptr_t)NULL;
+
+    qemu_spin_unlock(&dest->jmp_lock);
 }
 
 /* If @rm_from_page_list is set, call with the TB's pages' locks held */
@@ -1429,11 +1448,14 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
 
     assert_tb_locked();
 
+    /* make sure no further incoming jumps will be chained to this TB */
+    qemu_spin_lock(&tb->jmp_lock);
     atomic_set(&tb->cflags, tb->cflags | CF_INVALID);
+    qemu_spin_unlock(&tb->jmp_lock);
 
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
-    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
+    h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb_cflags(tb) & CF_HASH_MASK,
                      tb->trace_vcpu_dstate);
     if (!qht_remove(&tb_ctx.htable, tb, h)) {
         return;
@@ -1773,10 +1795,12 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
@@ -1868,7 +1892,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
                 }
             }
             if (current_tb == tb &&
-                (current_tb->cflags & CF_COUNT_MASK) != 1) {
+                (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
                 /* If we are modifying the current TB, we must stop
                 its execution. We could be more precise by checking
                 that the modification is after the current PC, but it
@@ -2067,7 +2091,7 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
     PAGE_FOR_EACH_TB(p, tb, n) {
 #ifdef TARGET_HAS_PRECISE_SMC
         if (current_tb == tb &&
-            (current_tb->cflags & CF_COUNT_MASK) != 1) {
+            (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
                 /* If we are modifying the current TB, we must stop
                    its execution. We could be more precise by checking
                    that the modification is after the current PC, but it
@@ -2192,7 +2216,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     /* Generate a new TB executing the I/O insn.  */
     cpu->cflags_next_tb = curr_cflags() | CF_LAST_IO | n;
 
-    if (tb->cflags & CF_NOCACHE) {
+    if (tb_cflags(tb) & CF_NOCACHE) {
         if (tb->orig_tb) {
             /* Invalidate original TB if this TB was generated in
              * cpu_exec_nocache() */
diff --git a/docs/devel/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
index faf09c6069..df83445ccf 100644
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
-- 
2.17.1
