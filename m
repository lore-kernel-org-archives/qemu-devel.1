Received: from eggs.gnu.org ([2001:4830:134:3::10]:46870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGqUs-00030Q-J4
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGqUq-0004dP-Tq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:08:42 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 18:08:28 +0000
Message-Id: <1511201308-23580-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1511201308-23580-1-git-send-email-peter.maydell@linaro.org>
References: <1511201308-23580-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 for-2.11 2/2] accel/tcg: Handle atomic
 accesses to notdirty memory correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Stuart Monteith <stuart.monteith@linaro.org>

To do a write to memory that is marked as notdirty, we need
to invalidate any TBs we have cached for that memory, and
update the cpu physical memory dirty flags for VGA and migration.
The slowpath code in notdirty_mem_write() does all this correctly,
but the new atomic handling code in atomic_mmu_lookup() doesn't
do anything at all, it just clears the dirty bit in the TLB.

The effect of this bug is that if the first write to a notdirty
page for which we have cached TBs is by a guest atomic access,
we fail to invalidate the TBs and subsequently will execute
incorrect code. This can be seen by trying to run 'javac' on AArch64.

Use the new notdirty_call_before() and notdirty_call_after()
functions to correctly handle the update to notdirty memory
in the atomic codepath.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/atomic_template.h | 12 ++++++++++++
 accel/tcg/cputlb.c          | 38 +++++++++++++++++++++++++-------------
 accel/tcg/user-exec.c       |  1 +
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 1c7c175..e022df4 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -61,6 +61,7 @@
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
                               ABI_TYPE cmpv, ABI_TYPE newv EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
     ATOMIC_MMU_CLEANUP;
@@ -70,6 +71,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 #if DATA_SIZE >= 16
 ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
     __atomic_load(haddr, &val, __ATOMIC_RELAXED);
     ATOMIC_MMU_CLEANUP;
@@ -79,6 +81,7 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
                      ABI_TYPE val EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     __atomic_store(haddr, &val, __ATOMIC_RELAXED);
     ATOMIC_MMU_CLEANUP;
@@ -87,6 +90,7 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
                            ABI_TYPE val EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret = atomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
@@ -97,6 +101,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                  ABI_TYPE val EXTRA_ARGS)                           \
 {                                                                   \
+    ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret = atomic_##X(haddr, val);                         \
     ATOMIC_MMU_CLEANUP;                                             \
@@ -130,6 +135,7 @@ GEN_ATOMIC_HELPER(xor_fetch)
 ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
                               ABI_TYPE cmpv, ABI_TYPE newv EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
     ATOMIC_MMU_CLEANUP;
@@ -139,6 +145,7 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
 #if DATA_SIZE >= 16
 ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE val, *haddr = ATOMIC_MMU_LOOKUP;
     __atomic_load(haddr, &val, __ATOMIC_RELAXED);
     ATOMIC_MMU_CLEANUP;
@@ -148,6 +155,7 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulong addr EXTRA_ARGS)
 void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
                      ABI_TYPE val EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     val = BSWAP(val);
     __atomic_store(haddr, &val, __ATOMIC_RELAXED);
@@ -157,6 +165,7 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
                            ABI_TYPE val EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     ABI_TYPE ret = atomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
@@ -167,6 +176,7 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ulong addr,       \
                  ABI_TYPE val EXTRA_ARGS)                           \
 {                                                                   \
+    ATOMIC_MMU_DECLS;                                               \
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;                           \
     DATA_TYPE ret = atomic_##X(haddr, BSWAP(val));                  \
     ATOMIC_MMU_CLEANUP;                                             \
@@ -187,6 +197,7 @@ GEN_ATOMIC_HELPER(xor_fetch)
 ABI_TYPE ATOMIC_NAME(fetch_add)(CPUArchState *env, target_ulong addr,
                          ABI_TYPE val EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ldo, ldn, ret, sto;
 
@@ -206,6 +217,7 @@ ABI_TYPE ATOMIC_NAME(fetch_add)(CPUArchState *env, target_ulong addr,
 ABI_TYPE ATOMIC_NAME(add_fetch)(CPUArchState *env, target_ulong addr,
                          ABI_TYPE val EXTRA_ARGS)
 {
+    ATOMIC_MMU_DECLS;
     DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
     DATA_TYPE ldo, ldn, ret, sto;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d071ca4..8fd8420 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -946,7 +946,8 @@ void probe_write(CPUArchState *env, target_ulong addr, int mmu_idx,
 /* Probe for a read-modify-write atomic operation.  Do not allow unaligned
  * operations, or io operations to proceed.  Return the host address.  */
 static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
-                               TCGMemOpIdx oi, uintptr_t retaddr)
+                               TCGMemOpIdx oi, uintptr_t retaddr,
+                               NotDirtyInfo *ndi)
 {
     size_t mmu_idx = get_mmuidx(oi);
     size_t index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
@@ -955,6 +956,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     TCGMemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
     int s_bits = mop & MO_SIZE;
+    void *hostaddr;
 
     /* Adjust the given return address.  */
     retaddr -= GETPC_ADJ;
@@ -984,21 +986,15 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         tlb_addr = tlbe->addr_write & ~TLB_INVALID_MASK;
     }
 
-    /* Check notdirty */
-    if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
-        tlb_set_dirty(ENV_GET_CPU(env), addr);
-        tlb_addr = tlb_addr & ~TLB_NOTDIRTY;
-    }
-
     /* Notice an IO access  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+    if (unlikely(tlb_addr & TLB_MMIO)) {
         /* There's really nothing that can be done to
            support this apart from stop-the-world.  */
         goto stop_the_world;
     }
 
     /* Let the guest notice RMW on a write-only page.  */
-    if (unlikely(tlbe->addr_read != tlb_addr)) {
+    if (unlikely(tlbe->addr_read != (tlb_addr & ~TLB_NOTDIRTY))) {
         tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_LOAD, mmu_idx, retaddr);
         /* Since we don't support reads and writes to different addresses,
            and we do have the proper page loaded for write, this shouldn't
@@ -1006,7 +1002,17 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
         goto stop_the_world;
     }
 
-    return (void *)((uintptr_t)addr + tlbe->addend);
+    hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
+
+    ndi->active = false;
+    if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
+        ndi->active = true;
+        memory_notdirty_write_prepare(ndi, ENV_GET_CPU(env), addr,
+                                      qemu_ram_addr_from_host_nofail(hostaddr),
+                                      1 << s_bits);
+    }
+
+    return hostaddr;
 
  stop_the_world:
     cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
@@ -1040,8 +1046,14 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define EXTRA_ARGS     , TCGMemOpIdx oi, uintptr_t retaddr
 #define ATOMIC_NAME(X) \
     HELPER(glue(glue(glue(atomic_ ## X, SUFFIX), END), _mmu))
-#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, retaddr)
-#define ATOMIC_MMU_CLEANUP do { } while (0)
+#define ATOMIC_MMU_DECLS NotDirtyInfo ndi
+#define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr, &ndi)
+#define ATOMIC_MMU_CLEANUP                              \
+    do {                                                \
+        if (unlikely(ndi.active)) {                     \
+            memory_notdirty_write_complete(&ndi);       \
+        }                                               \
+    } while (0)
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
@@ -1069,7 +1081,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #undef ATOMIC_MMU_LOOKUP
 #define EXTRA_ARGS         , TCGMemOpIdx oi
 #define ATOMIC_NAME(X)     HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
-#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, GETPC())
+#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, oi, GETPC(), &ndi)
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 0324ba8..f42285e 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -624,6 +624,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 }
 
 /* Macro to call the above, with local variables from the use context.  */
+#define ATOMIC_MMU_DECLS do {} while (0)
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
 #define ATOMIC_MMU_CLEANUP do { helper_retaddr = 0; } while (0)
 
-- 
2.7.4
