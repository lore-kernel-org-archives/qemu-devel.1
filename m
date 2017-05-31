Received: from eggs.gnu.org ([2001:4830:134:3::10]:36835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mp-0007eU-4Z
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Mo-0003fj-20
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:51 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:36000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3Mn-0003fb-Qp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:49 -0400
Received: by mail-lf0-x22e.google.com with SMTP id h4so8619342lfj.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:49 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:24 +0300
Message-Id: <cf8b8bfc5049c10f70b3a17f66c7d2698a5dcff5.1496234767.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/15] linux-user: add support for
 rt_tgsigqueueinfo() system call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>

From: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

Add a new system call: rt_tgsigqueueinfo().

This system call is similar to rt_sigqueueinfo(), but instead of
sending the signal and data to the whole thread group with the ID
equal to the argument tgid, it sends it to a single thread within
that thread group. The ID of the thread is specified by the tid
argument.

The implementation is based on the rt_sigqueueinfo() in linux-user
mode, where the tid is added as the second argument and the
previous second and third argument become arguments three and four,
respectively.

Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

Conflicts:
	linux-user/syscall.c
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3373853bb9..925ae11ea6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -238,6 +238,7 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_getdents64 __NR_getdents64
 #define __NR_sys_getpriority __NR_getpriority
 #define __NR_sys_rt_sigqueueinfo __NR_rt_sigqueueinfo
+#define __NR_sys_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
 #define __NR_sys_syslog __NR_syslog
 #define __NR_sys_futex __NR_futex
 #define __NR_sys_inotify_init __NR_inotify_init
@@ -275,6 +276,8 @@ _syscall5(int, _llseek,  uint,  fd, ulong, hi, ulong, lo,
           loff_t *, res, uint, wh);
 #endif
 _syscall3(int, sys_rt_sigqueueinfo, pid_t, pid, int, sig, siginfo_t *, uinfo)
+_syscall4(int, sys_rt_tgsigqueueinfo, pid_t, pid, pid_t, tid, int, sig,
+          siginfo_t *, uinfo)
 _syscall3(int,sys_syslog,int,type,char*,bufp,int,len)
 #ifdef __NR_exit_group
 _syscall1(int,exit_group,int,error_code)
@@ -8872,6 +8875,19 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             ret = get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
         }
         break;
+    case TARGET_NR_rt_tgsigqueueinfo:
+        {
+            siginfo_t uinfo;
+
+            p = lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t), 1);
+            if (!p) {
+                goto efault;
+            }
+            target_to_host_siginfo(&uinfo, p);
+            unlock_user(p, arg4, 0);
+            ret = get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &uinfo));
+        }
+        break;
 #ifdef TARGET_NR_sigreturn
     case TARGET_NR_sigreturn:
         if (block_signals()) {
-- 
2.11.0
