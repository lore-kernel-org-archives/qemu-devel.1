Received: from eggs.gnu.org ([2001:4830:134:3::10]:41559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg4-0004j4-3R
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqg0-0004oL-UM
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:06:00 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqg0-0004o4-Nw
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:05:56 -0400
Received: by mail-pl0-x242.google.com with SMTP id b14-v6so10402273pls.5
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:05:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:02:15 -1000
Message-Id: <20180610030220.3777-104-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 103/108] linux-user: Split out
 atomic_cmpxchg_32
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

At the same time, make it atomic.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 47 ++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f898e70e98..5d60872587 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7560,6 +7560,29 @@ IMPL(atomic_barrier)
 }
 #endif
 
+#ifdef TARGET_NR_atomic_cmpxchg_32
+IMPL(atomic_cmpxchg_32)
+{
+    /* This is m68k specific.  */
+    uint32_t newval = arg1;
+    uint32_t oldval = arg2;
+    abi_ulong target_addr = arg6;
+    uint32_t *host_addr;
+
+    if (!access_ok(VERIFY_WRITE, target_addr, 4)) {
+        target_siginfo_t info;
+        info.si_signo = SIGSEGV;
+        info.si_errno = 0;
+        info.si_code = TARGET_SEGV_MAPERR;
+        info._sifields._sigfault._addr = target_addr;
+        queue_signal(cpu_env, info.si_signo, QEMU_SI_FAULT, &info);
+        return 0xdeadbeef;
+    }
+    host_addr = g2h(target_addr);
+    return atomic_cmpxchg(host_addr, oldval, newval);
+}
+#endif
+
 #ifdef TARGET_NR_bind
 IMPL(bind)
 {
@@ -13025,27 +13048,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     abi_long ret;
 
     switch(num) {
-#ifdef TARGET_NR_atomic_cmpxchg_32
-    case TARGET_NR_atomic_cmpxchg_32:
-    {
-        /* should use start_exclusive from main.c */
-        abi_ulong mem_value;
-        if (get_user_u32(mem_value, arg6)) {
-            target_siginfo_t info;
-            info.si_signo = SIGSEGV;
-            info.si_errno = 0;
-            info.si_code = TARGET_SEGV_MAPERR;
-            info._sifields._sigfault._addr = arg6;
-            queue_signal((CPUArchState *)cpu_env, info.si_signo,
-                         QEMU_SI_FAULT, &info);
-            ret = 0xdeadbeef;
-
-        }
-        if (mem_value == arg2)
-            put_user_u32(arg1, arg6);
-        return mem_value;
-    }
-#endif
 #ifdef TARGET_NR_timer_create
     case TARGET_NR_timer_create:
     {
@@ -13299,6 +13301,9 @@ static impl_fn *syscall_table(unsigned num)
 #endif
 #ifdef TARGET_NR_atomic_barrier
         SYSCALL(atomic_barrier);
+#endif
+#ifdef TARGET_NR_atomic_cmpxchg_32
+        SYSCALL(atomic_cmpxchg_32);
 #endif
         SYSCALL(brk);
 #ifdef TARGET_NR_cacheflush
-- 
2.17.1
