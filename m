Received: from eggs.gnu.org ([2001:4830:134:3::10]:41040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqev-0003ah-GM
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeu-00041P-Nd
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:49 -0400
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:43105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeu-00040q-IG
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:48 -0400
Received: by mail-pl0-x231.google.com with SMTP id c41-v6so10385516plj.10
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:38 -1000
Message-Id: <20180610030220.3777-67-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 066/108] linux-user: Split out arch_prctl
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
 linux-user/syscall.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ee3a31f06d..e3765069ab 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7680,6 +7680,17 @@ IMPL(alarm)
 }
 #endif
 
+#ifdef TARGET_NR_arch_prctl
+IMPL(arch_prctl)
+{
+# if defined(TARGET_I386) && !defined(TARGET_ABI32)
+    return do_arch_prctl(cpu_env, arg1, arg2);
+# else
+#  error unreachable
+# endif
+}
+#endif
+
 #ifdef TARGET_NR_bind
 IMPL(bind)
 {
@@ -11118,14 +11129,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_arch_prctl
-    case TARGET_NR_arch_prctl:
-#if defined(TARGET_I386) && !defined(TARGET_ABI32)
-        return do_arch_prctl(cpu_env, arg1, arg2);
-#else
-#error unreachable
-#endif
-#endif
 #ifdef TARGET_NR_pread64
     case TARGET_NR_pread64:
         if (regpairs_aligned(cpu_env, num)) {
@@ -12961,6 +12964,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_alarm
         SYSCALL(alarm);
 #endif
+#ifdef TARGET_NR_arch_prctl
+        SYSCALL(arch_prctl);
+#endif
 #ifdef TARGET_NR_bind
         SYSCALL(bind);
 #endif
-- 
2.17.1
