Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jrtc27@jrtc27.com>) id 1dsvyp-00086t-AZ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jrtc27@jrtc27.com>) id 1dsvym-0007gq-41
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:08:47 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:49430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jrtc27@jrtc27.com>) id 1dsvyl-0007fo-Q2
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:08:44 -0400
Received: by mail-wm0-x22f.google.com with SMTP id e71so10626443wmg.4
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 12:08:43 -0700 (PDT)
From: James Clarke <jrtc27@jrtc27.com>
Date: Fri, 15 Sep 2017 20:07:48 +0100
Message-Id: <20170915190748.82389-1-jrtc27@jrtc27.com>
In-Reply-To: <cc5d79bb-a56a-08a6-c054-b194e6a5a833@linaro.org>
References: <cc5d79bb-a56a-08a6-c054-b194e6a5a833@linaro.org>
References: <20170915065821.16600-1-jrtc27@jrtc27.com>
	<2f7283ca-6ecd-165f-c572-a0f2a781aba7@amsat.org>
Subject: [Qemu-devel] [PATCH v2] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: James Clarke <jrtc27@jrtc27.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---

Changes since v1:
 * Removed all changes in v1 :)
 * Added syscall num argument to regpairs_aligned
 * Added SH4-specific implementation of regpairs_aligned to return 1 for
   p{read,write}64

 linux-user/syscall.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..492c654970 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -667,18 +667,30 @@ static inline int next_free_host_timer(void)
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
 #ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env) {
+static inline int regpairs_aligned(void *cpu_env, int num) {
     return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
 }
 #elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env) { return 1; }
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
 #elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
 /* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
  * of registers which translates to the same as ARM/MIPS, because we start with
  * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env) { return 1; }
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_SH4)
+/* SH4 doesn't align register pairs, except for p{read,write}64 */
+static inline int regpairs_aligned(void *cpu_env, int num) {
+    switch (num) {
+    case TARGET_NR_pread64:
+    case TARGET_NR_pwrite64:
+        return 1;
+
+    default:
+        return 0;
+    }
+}
 #else
-static inline int regpairs_aligned(void *cpu_env) { return 0; }
+static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
 #endif
 
 #define ERRNO_TABLE_SIZE 1200
@@ -6857,7 +6869,7 @@ static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
                                          abi_long arg3,
                                          abi_long arg4)
 {
-    if (regpairs_aligned(cpu_env)) {
+    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
         arg2 = arg3;
         arg3 = arg4;
     }
@@ -6871,7 +6883,7 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
                                           abi_long arg3,
                                           abi_long arg4)
 {
-    if (regpairs_aligned(cpu_env)) {
+    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
         arg2 = arg3;
         arg3 = arg4;
     }
@@ -10495,7 +10507,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_pread64
     case TARGET_NR_pread64:
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
             arg5 = arg6;
         }
@@ -10505,7 +10517,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg2, ret);
         break;
     case TARGET_NR_pwrite64:
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
             arg5 = arg6;
         }
@@ -11275,7 +11287,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         arg6 = ret;
 #else
         /* 6 args: fd, offset (high, low), len (high, low), advice */
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             /* offset is in (3,4), len in (5,6) and advice in 7 */
             arg2 = arg3;
             arg3 = arg4;
@@ -11294,7 +11306,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_fadvise64
     case TARGET_NR_fadvise64:
         /* 5 args: fd, offset (high, low), len, advice */
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             /* offset is in (3,4), len in 5 and advice in 6 */
             arg2 = arg3;
             arg3 = arg4;
@@ -11407,7 +11419,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_readahead
     case TARGET_NR_readahead:
 #if TARGET_ABI_BITS == 32
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             arg2 = arg3;
             arg3 = arg4;
             arg4 = arg5;
-- 
2.13.2
