Received: from eggs.gnu.org ([2001:4830:134:3::10]:38891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frW1N-0001qk-Hh
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1frW1K-000387-8t
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1frW1J-00037b-Vq
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 18:18:02 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 20 Aug 2018 00:17:03 +0200
Message-Id: <20180819221707.20693-3-laurent@vivier.eu>
In-Reply-To: <20180819221707.20693-1-laurent@vivier.eu>
References: <20180819221707.20693-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 2/6] linux-user: fix 32bit g2h()/h2g()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

sparc32plus has 64bit long type but only 32bit virtual address space.

For instance, "apt-get upgrade" failed because of a mmap()/msync()
sequence.

mmap() returned 0xff252000 but msync() used g2h(0xffffffffff252000)
to find the host address. The "(target_ulong)" in g2h() doesn't fix the
address because it is 64bit long.

This patch introduces an "abi_ptr" that is set to uint32_t
if the virtual address space is addressed using 32bit in the linux-user
case. It stays set to target_ulong with softmmu case.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180814171217.14680-1-laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[lv: added "%" in TARGET_ABI_FMT_ptr "%"PRIx64]
---
 include/exec/cpu_ldst.h                   | 23 ++++++++++++++++++-----
 include/exec/cpu_ldst_useronly_template.h | 12 ++++++------
 linux-user/syscall.c                      |  2 +-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 0f2cb717b1..41ed0526e2 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -48,8 +48,19 @@
 #define CPU_LDST_H
 
 #if defined(CONFIG_USER_ONLY)
+/* sparc32plus has 64bit long but 32bit space address
+ * this can make bad result with g2h() and h2g()
+ */
+#if TARGET_VIRT_ADDR_SPACE_BITS <= 32
+typedef uint32_t abi_ptr;
+#define TARGET_ABI_FMT_ptr "%x"
+#else
+typedef uint64_t abi_ptr;
+#define TARGET_ABI_FMT_ptr "%"PRIx64
+#endif
+
 /* All direct uses of g2h and h2g need to go away for usermode softmmu.  */
-#define g2h(x) ((void *)((unsigned long)(target_ulong)(x) + guest_base))
+#define g2h(x) ((void *)((unsigned long)(abi_ptr)(x) + guest_base))
 
 #define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
 #define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
@@ -61,7 +72,7 @@ static inline int guest_range_valid(unsigned long start, unsigned long len)
 
 #define h2g_nocheck(x) ({ \
     unsigned long __ret = (unsigned long)(x) - guest_base; \
-    (abi_ulong)__ret; \
+    (abi_ptr)__ret; \
 })
 
 #define h2g(x) ({ \
@@ -69,7 +80,9 @@ static inline int guest_range_valid(unsigned long start, unsigned long len)
     assert(h2g_valid(x)); \
     h2g_nocheck(x); \
 })
-
+#else
+typedef target_ulong abi_ptr;
+#define TARGET_ABI_FMT_ptr TARGET_ABI_FMT_lx
 #endif
 
 #if defined(CONFIG_USER_ONLY)
@@ -397,7 +410,7 @@ extern __thread uintptr_t helper_retaddr;
  * This is the equivalent of the initial fast-path code used by
  * TCG backends for guest load and store accesses.
  */
-static inline void *tlb_vaddr_to_host(CPUArchState *env, target_ulong addr,
+static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
                                       int access_type, int mmu_idx)
 {
 #if defined(CONFIG_USER_ONLY)
@@ -405,7 +418,7 @@ static inline void *tlb_vaddr_to_host(CPUArchState *env, target_ulong addr,
 #else
     int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
     CPUTLBEntry *tlbentry = &env->tlb_table[mmu_idx][index];
-    target_ulong tlb_addr;
+    abi_ptr tlb_addr;
     uintptr_t haddr;
 
     switch (access_type) {
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index e30e58ed4a..0fd6019af0 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -62,7 +62,7 @@
 #endif
 
 static inline RES_TYPE
-glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
+glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
@@ -74,7 +74,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 
 static inline RES_TYPE
 glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
+                                                  abi_ptr ptr,
                                                   uintptr_t retaddr)
 {
     RES_TYPE ret;
@@ -86,7 +86,7 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 
 #if DATA_SIZE <= 2
 static inline int
-glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
+glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
@@ -98,7 +98,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 
 static inline int
 glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
+                                                  abi_ptr ptr,
                                                   uintptr_t retaddr)
 {
     int ret;
@@ -111,7 +111,7 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 
 #ifndef CODE_ACCESS
 static inline void
-glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
+glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
 #if !defined(CODE_ACCESS)
@@ -124,7 +124,7 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
 
 static inline void
 glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
+                                                  abi_ptr ptr,
                                                   RES_TYPE v,
                                                   uintptr_t retaddr)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bb42a225eb..1806b33b02 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7644,7 +7644,7 @@ static int open_self_maps(void *cpu_env, int fd)
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
