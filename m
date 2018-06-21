Received: from eggs.gnu.org ([2001:4830:134:3::10]:54957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fW3Vm-0000rF-Qu
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fW3Vk-0004Mx-H9
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:46 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:38833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fW3Vk-0004MK-9X
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:36:44 -0400
Received: by mail-pf0-x241.google.com with SMTP id b74-v6so1876655pfl.5
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 10:36:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Jun 2018 07:36:34 -1000
Message-Id: <20180621173635.21537-2-richard.henderson@linaro.org>
In-Reply-To: <20180621173635.21537-1-richard.henderson@linaro.org>
References: <20180621173635.21537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] exec: Split mmap_lock to
 mmap_rdlock/mmap_wrlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, cota@braap.org, qemu-arm@nongnu.org

Do not yet change the backing implementation, but split intent
of users for reading or modification of the memory map.

Uses within accel/tcg/ and exec.c are expecting exclusivity
while manipulating TranslationBlock data structures, so consider
those writers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h    |  6 ++++--
 accel/tcg/cpu-exec.c       |  8 ++++----
 accel/tcg/translate-all.c  |  4 ++--
 bsd-user/mmap.c            | 18 ++++++++++++++----
 exec.c                     |  6 +++---
 linux-user/elfload.c       |  2 +-
 linux-user/mips/cpu_loop.c |  2 +-
 linux-user/mmap.c          | 22 ++++++++++++++++------
 linux-user/ppc/cpu_loop.c  |  2 +-
 linux-user/syscall.c       |  4 ++--
 target/arm/sve_helper.c    | 10 +++-------
 target/xtensa/op_helper.c  |  2 +-
 12 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 25a6f28ab8..a57764b693 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -468,7 +468,8 @@ void tlb_fill(CPUState *cpu, target_ulong addr, int size,
 #endif
 
 #if defined(CONFIG_USER_ONLY)
-void mmap_lock(void);
+void mmap_rdlock(void);
+void mmap_wrlock(void);
 void mmap_unlock(void);
 bool have_mmap_lock(void);
 
@@ -477,7 +478,8 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong
     return addr;
 }
 #else
-static inline void mmap_lock(void) {}
+static inline void mmap_rdlock(void) {}
+static inline void mmap_wrlock(void) {}
 static inline void mmap_unlock(void) {}
 
 /* cputlb.c */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c738b7f7d6..59bdedb6c7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -212,7 +212,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
        We only end up here when an existing TB is too long.  */
     cflags |= MIN(max_cycles, CF_COUNT_MASK);
 
-    mmap_lock();
+    mmap_wrlock();
     tb = tb_gen_code(cpu, orig_tb->pc, orig_tb->cs_base,
                      orig_tb->flags, cflags);
     tb->orig_tb = orig_tb;
@@ -222,7 +222,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
     trace_exec_tb_nocache(tb, tb->pc);
     cpu_tb_exec(cpu, tb);
 
-    mmap_lock();
+    mmap_wrlock();
     tb_phys_invalidate(tb, -1);
     mmap_unlock();
     tcg_tb_remove(tb);
@@ -243,7 +243,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
         tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
         if (tb == NULL) {
-            mmap_lock();
+            mmap_wrlock();
             tb = tb_gen_code(cpu, pc, cs_base, flags, cflags);
             mmap_unlock();
         }
@@ -397,7 +397,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
 
     tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
     if (tb == NULL) {
-        mmap_lock();
+        mmap_wrlock();
         tb = tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
         mmap_unlock();
         /* We add the TB in the virtual pc hash table for the fast lookup */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f0c3fd4d03..48a71af392 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1214,7 +1214,7 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
-    mmap_lock();
+    mmap_wrlock();
     /* If it is already been done on request of another CPU,
      * just retry.
      */
@@ -2563,7 +2563,7 @@ int page_unprotect(target_ulong address, uintptr_t pc)
     /* Technically this isn't safe inside a signal handler.  However we
        know this only ever happens in a synchronous SEGV handler, so in
        practice it seems to be ok.  */
-    mmap_lock();
+    mmap_wrlock();
 
     p = page_find(address >> TARGET_PAGE_BITS);
     if (!p) {
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 17f4cd80aa..4f6fe3cf4e 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -28,13 +28,23 @@
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
 
-void mmap_lock(void)
+static void mmap_lock_internal(void)
 {
     if (mmap_lock_count++ == 0) {
         pthread_mutex_lock(&mmap_mutex);
     }
 }
 
+void mmap_rdlock(void)
+{
+    mmap_lock_internal();
+}
+
+void mmap_wrlock(void)
+{
+    mmap_lock_internal();
+}
+
 void mmap_unlock(void)
 {
     if (--mmap_lock_count == 0) {
@@ -87,7 +97,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
     if (len == 0)
         return 0;
 
-    mmap_lock();
+    mmap_wrlock();
     host_start = start & qemu_host_page_mask;
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
@@ -248,7 +258,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len;
     unsigned long host_start;
 
-    mmap_lock();
+    mmap_wrlock();
 #ifdef DEBUG_MMAP
     {
         printf("mmap: start=0x" TARGET_FMT_lx
@@ -424,7 +434,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     len = TARGET_PAGE_ALIGN(len);
     if (len == 0)
         return -EINVAL;
-    mmap_lock();
+    mmap_wrlock();
     end = start + len;
     real_start = start & qemu_host_page_mask;
     real_end = HOST_PAGE_ALIGN(end);
diff --git a/exec.c b/exec.c
index 28f9bdcbf9..27d9c2ab0c 100644
--- a/exec.c
+++ b/exec.c
@@ -1030,7 +1030,7 @@ const char *parse_cpu_model(const char *cpu_model)
 #if defined(CONFIG_USER_ONLY)
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
-    mmap_lock();
+    mmap_wrlock();
     tb_invalidate_phys_page_range(pc, pc + 1, 0);
     mmap_unlock();
 }
@@ -2743,7 +2743,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
                 }
                 cpu->watchpoint_hit = wp;
 
-                mmap_lock();
+                mmap_wrlock();
                 tb_check_watchpoint(cpu);
                 if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                     cpu->exception_index = EXCP_DEBUG;
@@ -3143,7 +3143,7 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     }
     if (dirty_log_mask & (1 << DIRTY_MEMORY_CODE)) {
         assert(tcg_enabled());
-        mmap_lock();
+        mmap_wrlock();
         tb_invalidate_phys_range(addr, addr + length);
         mmap_unlock();
         dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bdb023b477..9ef8ab972a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2196,7 +2196,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->nsegs = 0;
     info->pt_dynamic_addr = 0;
 
-    mmap_lock();
+    mmap_wrlock();
 
     /* Find the maximum size of the image and allocate an appropriate
        amount of memory to handle that.  */
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 084ad6a041..9d7399c6d1 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -405,7 +405,7 @@ static int do_store_exclusive(CPUMIPSState *env)
     addr = env->lladdr;
     page_addr = addr & TARGET_PAGE_MASK;
     start_exclusive();
-    mmap_lock();
+    mmap_rdlock();
     flags = page_get_flags(page_addr);
     if ((flags & PAGE_READ) == 0) {
         segv = 1;
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 9168a2051c..71b6bed5e2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -27,13 +27,23 @@
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
 
-void mmap_lock(void)
+static void mmap_lock_internal(void)
 {
     if (mmap_lock_count++ == 0) {
         pthread_mutex_lock(&mmap_mutex);
     }
 }
 
+void mmap_rdlock(void)
+{
+    mmap_lock_internal();
+}
+
+void mmap_wrlock(void)
+{
+    mmap_lock_internal();
+}
+
 void mmap_unlock(void)
 {
     if (--mmap_lock_count == 0) {
@@ -87,7 +97,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
     if (len == 0)
         return 0;
 
-    mmap_lock();
+    mmap_wrlock();
     host_start = start & qemu_host_page_mask;
     host_end = HOST_PAGE_ALIGN(end);
     if (start > host_start) {
@@ -251,7 +261,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
 /*
  * Find and reserve a free memory area of size 'size'. The search
  * starts at 'start'.
- * It must be called with mmap_lock() held.
+ * It must be called with mmap_wrlock() held.
  * Return -1 if error.
  */
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
@@ -364,7 +374,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
 {
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len;
 
-    mmap_lock();
+    mmap_wrlock();
 #ifdef DEBUG_MMAP
     {
         printf("mmap: start=0x" TARGET_ABI_FMT_lx
@@ -627,7 +637,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
         return -TARGET_EINVAL;
     }
 
-    mmap_lock();
+    mmap_wrlock();
     end = start + len;
     real_start = start & qemu_host_page_mask;
     real_end = HOST_PAGE_ALIGN(end);
@@ -688,7 +698,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         return -1;
     }
 
-    mmap_lock();
+    mmap_wrlock();
 
     if (flags & MREMAP_FIXED) {
         host_addr = mremap(g2h(old_addr), old_size, new_size,
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 2fb516cb00..d7cd5f4a50 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -76,7 +76,7 @@ static int do_store_exclusive(CPUPPCState *env)
     addr = env->reserve_ea;
     page_addr = addr & TARGET_PAGE_MASK;
     start_exclusive();
-    mmap_lock();
+    mmap_rdlock();
     flags = page_get_flags(page_addr);
     if ((flags & PAGE_READ) == 0) {
         segv = 1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2117fb13b4..4104444764 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4989,7 +4989,7 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
         return -TARGET_EINVAL;
     }
 
-    mmap_lock();
+    mmap_wrlock();
 
     if (shmaddr)
         host_raddr = shmat(shmid, (void *)g2h(shmaddr), shmflg);
@@ -5034,7 +5034,7 @@ static inline abi_long do_shmdt(abi_ulong shmaddr)
     int i;
     abi_long rv;
 
-    mmap_lock();
+    mmap_wrlock();
 
     for (i = 0; i < N_SHM_REGIONS; ++i) {
         if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index cd3dfc8b26..086547c7e5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4071,10 +4071,6 @@ record_fault(CPUARMState *env, intptr_t i, intptr_t oprsz)
  * between page_check_range and the load operation.  We expect the
  * usual case to have no faults at all, so we check the whole range
  * first and if successful defer to the normal load operation.
- *
- * TODO: Change mmap_lock to a rwlock so that multiple readers
- * can run simultaneously.  This will probably help other uses
- * within QEMU as well.
  */
 #define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                             \
 static void do_sve_ldff1##PART(CPUARMState *env, void *vd, void *vg,    \
@@ -4107,7 +4103,7 @@ void HELPER(sve_ldff1##PART)(CPUARMState *env, void *vg,                \
     intptr_t oprsz = simd_oprsz(desc);                                  \
     unsigned rd = simd_data(desc);                                      \
     void *vd = &env->vfp.zregs[rd];                                     \
-    mmap_lock();                                                        \
+    mmap_rdlock();                                                      \
     if (likely(page_check_range(addr, oprsz, PAGE_READ) == 0)) {        \
         do_sve_ld1##PART(env, vd, vg, addr, oprsz, GETPC());            \
     } else {                                                            \
@@ -4126,7 +4122,7 @@ void HELPER(sve_ldnf1##PART)(CPUARMState *env, void *vg,                \
     intptr_t oprsz = simd_oprsz(desc);                                  \
     unsigned rd = simd_data(desc);                                      \
     void *vd = &env->vfp.zregs[rd];                                     \
-    mmap_lock();                                                        \
+    mmap_rdlock();                                                      \
     if (likely(page_check_range(addr, oprsz, PAGE_READ) == 0)) {        \
         do_sve_ld1##PART(env, vd, vg, addr, oprsz, GETPC());            \
     } else {                                                            \
@@ -4500,7 +4496,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
     unsigned scale = simd_data(desc);                                   \
     uintptr_t ra = GETPC();                                             \
     bool first = true;                                                  \
-    mmap_lock();                                                        \
+    mmap_rdlock();                                                      \
     for (i = 0; i < oprsz; i++) {                                       \
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
         do {                                                            \
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 8a8c763c63..251fa27d43 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -114,7 +114,7 @@ static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
 
 static void tb_invalidate_virtual_addr(CPUXtensaState *env, uint32_t vaddr)
 {
-    mmap_lock();
+    mmap_wrlock();
     tb_invalidate_phys_range(vaddr, vaddr + 1);
     mmap_unlock();
 }
-- 
2.17.1
