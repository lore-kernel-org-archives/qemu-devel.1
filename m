Received: from eggs.gnu.org ([2001:4830:134:3::10]:52603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foCY1-000303-JP
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 14:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foCXy-0004Jv-DM
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 14:54:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1foCXy-0004Ig-2o
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 14:54:02 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 10 Aug 2018 20:53:21 +0200
Message-Id: <20180810185321.20017-2-laurent@vivier.eu>
In-Reply-To: <20180810185321.20017-1-laurent@vivier.eu>
References: <20180810185321.20017-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: fix 32bit g2h()/h2g()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

sparc32plus has 64bit long type but only 32bit virtual address space.

For instance, "apt-get upgrade" failed because of a mmap()/msync()
sequence.

mmap() returned 0xff252000 but msync() used g2h(0xffffffffff252000)
to find the host address. The "(target_ulong)" in g2h() doesn't fix the
address because it is 64bit long.

This patch introduces a "target_ptr" that is set to uint32_t
if the virtual address space is addressed using 32bit in the linux-user
case. It stays set to target_ulong with softmmu case.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/cpu_ldst.h                   | 23 ++++++++++++++++++-----
 include/exec/cpu_ldst_useronly_template.h | 12 ++++++------
 linux-user/syscall.c                      |  2 +-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 0f2cb717b1..84c058e0f2 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -48,8 +48,19 @@
 #define CPU_LDST_H
 
 #if defined(CONFIG_USER_ONLY)
+/* sparc32plus has 64bit long but 32bit space address
+ * this can make bad result with g2h() and h2g()
+ */
+#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
+typedef uint32_t target_ptr;
+#define TARGET_ABI_FMT_ptr "%x"
+#else
+typedef uint64_t target_ptr;
+#define TARGET_ABI_FMT_ptr PRIx64
+#endif
+
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
-#define g2h(x) ((void *)((unsigned long)(target_ulong)(x) + guest_base))
+#define g2h(x) ((void *)((unsigned long)(target_ptr)(x) + guest_base))
 
 #define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
 #define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
@@ -61,7 +72,7 @@ static inline int guest_range_valid(unsigned long start, unsigned long len)
 
 #define h2g_nocheck(x) ({ \
     unsigned long __ret = (unsigned long)(x) - guest_base; \
-    (abi_ulong)__ret; \
+    (target_ptr)__ret; \
 })
 
 #define h2g(x) ({ \
@@ -69,7 +80,9 @@ static inline int guest_range_valid(unsigned long start, unsigned long len)
     assert(h2g_valid(x)); \
     h2g_nocheck(x); \
 })
-
+#else
+typedef target_ulong target_ptr;
+#define TARGET_ABI_FMT_ptr TARGET_ABI_FMT_lx
 #endif
 
 #if defined(CONFIG_USER_ONLY)
@@ -397,7 +410,7 @@ extern __thread uintptr_t helper_retaddr;
  * This is the equivalent of the initial fast-path code used by
  * TCG backends for guest load and store accesses.
  */
-static inline void *tlb_vaddr_to_host(CPUArchState *env, target_ulong addr,
+static inline void *tlb_vaddr_to_host(CPUArchState *env, target_ptr addr,
                                       int access_type, int mmu_idx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -405,7 +418,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *env, target_ulong addr,
 #else
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     CPUTLBEntry *tlbentry = &env->tlb_table[mmu_idx][index];
-    target_ulong tlb_addr;
+    target_ptr tlb_addr;
     uintptr_t haddr;
 
     switch (access_type) {
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index e30e58ed4a..5bb09d66c8 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -62,7 +62,7 @@
 #endif
 
 static inline RES_TYPE
-glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
+glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ptr ptr)
 {
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
@@ -74,7 +74,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 
 static inline RES_TYPE
 glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
+                                                  target_ptr ptr,
                                                   uintptr_t retaddr)
 {
     RES_TYPE ret;
@@ -86,7 +86,7 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 
 #if DATA_SIZE <= 2
 static inline int
-glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
+glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ptr ptr)
 {
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
@@ -98,7 +98,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 
 static inline int
 glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
+                                                  target_ptr ptr,
                                                   uintptr_t retaddr)
 {
     int ret;
@@ -111,7 +111,7 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 
 #ifndef CODE_ACCESS
 static inline void
-glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
+glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ptr ptr,
                                       RES_TYPE v)
 {
 #if !defined(CODE_ACCESS)
@@ -124,7 +124,7 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
 
 static inline void
 glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
+                                                  target_ptr ptr,
                                                   RES_TYPE v,
                                                   uintptr_t retaddr)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6db0e8b9fb..e5b410c839 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7664,7 +7664,7 @@ static int open_self_maps(void *cpu_env, int fd)
             if (h2g(min) == ts->info->stack_limit) {
                 pstrcpy(path, sizeof(path), "      [stack]");
             }
-            dprintf(fd, TARGET_ABI_FMT_lx "-" TARGET_ABI_FMT_lx
+            dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
                     " %c%c%c%c %08" PRIx64 " %02x:%02x %d %s%s\n",
                     h2g(min), h2g(max - 1) + 1, flag_r, flag_w,
                     flag_x, flag_p, offset, dev_maj, dev_min, inode,
-- 
2.17.1
