Received: from eggs.gnu.org ([2001:4830:134:3::10]:58214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVx-0004fl-26
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVv-0007rx-DE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:01 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVv-0007rO-26
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:21:59 -0500
Received: by mail-lf0-x243.google.com with SMTP id x68so11727102lff.0
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:21:58 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:36 +0200
Message-Id: <8bf8e9df4a7d82c7a47cc961c9cdee1615595de0.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/15] linux-user/syscall.c: Handle SH4's
 exceptional alignment for p{read, write}64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Clarke <jrtc27@jrtc27.com>

From: James Clarke <jrtc27@jrtc27.com>

Fixes: https://bugs.launchpad.net/qemu/+bug/1716767
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: James Clarke <jrtc27@jrtc27.com>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8047bf3aac..9268c3ef69 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -671,18 +671,32 @@ static inline int next_free_host_timer(void)
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
 #ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env) {
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
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
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
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
@@ -6870,7 +6884,7 @@ static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
                                          abi_long arg3,
                                          abi_long arg4)
 {
-    if (regpairs_aligned(cpu_env)) {
+    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
         arg2 = arg3;
         arg3 = arg4;
     }
@@ -6884,7 +6898,7 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
                                           abi_long arg3,
                                           abi_long arg4)
 {
-    if (regpairs_aligned(cpu_env)) {
+    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
         arg2 = arg3;
         arg3 = arg4;
     }
@@ -10508,7 +10522,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_pread64
     case TARGET_NR_pread64:
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
             arg5 = arg6;
         }
@@ -10518,7 +10532,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         unlock_user(p, arg2, ret);
         break;
     case TARGET_NR_pwrite64:
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             arg4 = arg5;
             arg5 = arg6;
         }
@@ -11288,7 +11302,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         arg6 = ret;
 #else
         /* 6 args: fd, offset (high, low), len (high, low), advice */
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             /* offset is in (3,4), len in (5,6) and advice in 7 */
             arg2 = arg3;
             arg3 = arg4;
@@ -11307,7 +11321,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_fadvise64
     case TARGET_NR_fadvise64:
         /* 5 args: fd, offset (high, low), len, advice */
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             /* offset is in (3,4), len in 5 and advice in 6 */
             arg2 = arg3;
             arg3 = arg4;
@@ -11420,7 +11434,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_readahead
     case TARGET_NR_readahead:
 #if TARGET_ABI_BITS == 32
-        if (regpairs_aligned(cpu_env)) {
+        if (regpairs_aligned(cpu_env, num)) {
             arg2 = arg3;
             arg3 = arg4;
             arg4 = arg5;
-- 
2.14.2
