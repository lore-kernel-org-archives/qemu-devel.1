Received: from eggs.gnu.org ([2001:4830:134:3::10]:57388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWi-0005Sh-FM
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOeWg-0000LO-AC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:08 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:47103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOeWg-0000Kc-5G
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 03:31:06 -0400
Received: by mail-pl0-x243.google.com with SMTP id 30-v6so14801187pld.13
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 00:31:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  1 Jun 2018 00:30:25 -0700
Message-Id: <20180601073050.8054-9-richard.henderson@linaro.org>
In-Reply-To: <20180601073050.8054-1-richard.henderson@linaro.org>
References: <20180601073050.8054-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/33] linux-user: Make syscall number unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h    |  2 +-
 linux-user/syscall.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 05a82a3628..623a8d8b7a 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -231,7 +231,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
 void target_set_brk(abi_ulong new_brk);
 abi_long do_brk(abi_ulong new_brk);
 void syscall_init(void);
-abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
+abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a413aad658..e2e2d58e84 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -719,20 +719,20 @@ static inline int next_free_host_timer(void)
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
 #ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env, int num)
+static inline int regpairs_aligned(void *cpu_env, unsigned num)
 {
     return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
 }
 #elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+static inline int regpairs_aligned(void *cpu_env, unsigned num) { return 1; }
 #elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
 /* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
  * of registers which translates to the same as ARM/MIPS, because we start with
  * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+static inline int regpairs_aligned(void *cpu_env, unsigned num) { return 1; }
 #elif defined(TARGET_SH4)
 /* SH4 doesn't align register pairs, except for p{read,write}64 */
-static inline int regpairs_aligned(void *cpu_env, int num)
+static inline int regpairs_aligned(void *cpu_env, unsigned num)
 {
     switch (num) {
     case TARGET_NR_pread64:
@@ -744,9 +744,9 @@ static inline int regpairs_aligned(void *cpu_env, int num)
     }
 }
 #elif defined(TARGET_XTENSA)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+static inline int regpairs_aligned(void *cpu_env, unsigned num) { return 1; }
 #else
-static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
+static inline int regpairs_aligned(void *cpu_env, unsigned num) { return 0; }
 #endif
 
 #define ERRNO_TABLE_SIZE 1200
@@ -7962,9 +7962,9 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
     return 0;
 }
 
-static abi_long do_unimplemented(int num)
+static abi_long do_unimplemented(unsigned num)
 {
-    gemu_log("qemu: Unsupported syscall: %d\n", num);
+    gemu_log("qemu: Unsupported syscall: %u\n", num);
     return -TARGET_ENOSYS;
 }
 
@@ -7973,7 +7973,7 @@ static abi_long do_unimplemented(int num)
  * of syscall results, can be performed.
  * All errnos that do_syscall() returns must be -TARGET_<errcode>.
  */
-static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
+static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
@@ -12880,7 +12880,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     return ret;
 }
 
-abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
+abi_long do_syscall(void *cpu_env, unsigned num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8)
-- 
2.17.0
