Received: from eggs.gnu.org ([2001:4830:134:3::10]:40518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdo-0002Vj-CA
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqdn-0003XV-Et
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:40 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:35908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqdn-0003XN-72
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:03:39 -0400
Received: by mail-pl0-x244.google.com with SMTP id a7-v6so7899198plp.3
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:03:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:05 -1000
Message-Id: <20180610030220.3777-34-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 033/108] linux-user: Split out rt_sigreturn,
 sethostname, setrlimit, sigreturn
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
 linux-user/syscall.c | 85 +++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 94dc773b4c..ac3592d776 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8782,6 +8782,14 @@ IMPL(rt_sigqueueinfo)
     return get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
 }
 
+IMPL(rt_sigreturn)
+{
+    if (block_signals()) {
+        return -TARGET_ERESTARTSYS;
+    }
+    return do_rt_sigreturn(cpu_env);
+}
+
 IMPL(rt_sigsuspend)
 {
     CPUState *cpu = ENV_GET_CPU(cpu_env);
@@ -8869,11 +8877,39 @@ IMPL(sgetmask)
 }
 #endif
 
+IMPL(sethostname)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sethostname(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 IMPL(setpgid)
 {
     return get_errno(setpgid(arg1, arg2));
 }
 
+IMPL(setrlimit)
+{
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+
+    if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1)) {
+        return -TARGET_EFAULT;
+    }
+    rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
+    rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
+    unlock_user_struct(target_rlim, arg2, 0);
+    return get_errno(setrlimit(resource, &rlim));
+}
+
 IMPL(setsid)
 {
     return get_errno(setsid());
@@ -9055,6 +9091,16 @@ IMPL(sigprocmask)
 }
 #endif
 
+#ifdef TARGET_NR_sigreturn
+IMPL(sigreturn)
+{
+    if (block_signals()) {
+        return -TARGET_ERESTARTSYS;
+    }
+    return do_sigreturn(cpu_env);
+}
+#endif
+
 #ifdef TARGET_NR_sigsuspend
 IMPL(sigsuspend)
 {
@@ -9339,39 +9385,6 @@ static abi_long do_syscall1(void *cpu_env, unsigned num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_sigreturn
-    case TARGET_NR_sigreturn:
-        if (block_signals()) {
-            ret = -TARGET_ERESTARTSYS;
-        } else {
-            ret = do_sigreturn(cpu_env);
-        }
-        return ret;
-#endif
-    case TARGET_NR_rt_sigreturn:
-        if (block_signals()) {
-            return -TARGET_ERESTARTSYS;
-        } else {
-            return do_rt_sigreturn(cpu_env);
-        }
-    case TARGET_NR_sethostname:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(sethostname(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-    case TARGET_NR_setrlimit:
-        {
-            int resource = target_to_host_resource(arg1);
-            struct target_rlimit *target_rlim;
-            struct rlimit rlim;
-            if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1))
-                return -TARGET_EFAULT;
-            rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
-            rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
-            unlock_user_struct(target_rlim, arg2, 0);
-            return get_errno(setrlimit(resource, &rlim));
-        }
     case TARGET_NR_getrlimit:
         {
             int resource = target_to_host_resource(arg1);
@@ -12778,13 +12791,16 @@ static impl_fn *syscall_table(unsigned num)
         SYSCALL(rt_sigpending);
         SYSCALL(rt_sigprocmask);
         SYSCALL(rt_sigqueueinfo);
+        SYSCALL(rt_sigreturn);
         SYSCALL(rt_sigsuspend);
         SYSCALL(rt_sigtimedwait);
         SYSCALL(rt_tgsigqueueinfo);
 #ifdef TARGET_NR_sgetmask
         SYSCALL(sgetmask);
 #endif
+        SYSCALL(sethostname);
         SYSCALL(setpgid);
+        SYSCALL(setrlimit);
         SYSCALL(setsid);
 #ifdef TARGET_NR_sigaction
         SYSCALL(sigaction);
@@ -12795,6 +12811,9 @@ static impl_fn *syscall_table(unsigned num)
 #ifdef TARGET_NR_sigprocmask
         SYSCALL(sigprocmask);
 #endif
+#ifdef TARGET_NR_sigreturn
+        SYSCALL(sigreturn);
+#endif
 #ifdef TARGET_NR_sigsuspend
         SYSCALL(sigsuspend);
 #endif
-- 
2.17.1
