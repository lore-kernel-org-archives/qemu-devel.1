Received: from eggs.gnu.org ([2001:4830:134:3::10]:49982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LJ-00042Z-BF
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LG-0006R0-QB
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46426 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LG-0006Q2-Je
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:38 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:14 +0200
Message-Id: <1494586944-7253-7-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/16] linux-user: add support for
 rt_tgsigqueueinfo() system call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: Milos.Stojanovic@rt-rk.com

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

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>

Conflicts:
	linux-user/syscall.c
---
 linux-user/syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9ec7ccd..d3b769e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -238,6 +238,7 @@ static type name (type1 arg1,type2 arg2,type3 arg3,ty=
pe4 arg4,type5 arg5,	\
 #define __NR_sys_getdents64 __NR_getdents64
 #define __NR_sys_getpriority __NR_getpriority
 #define __NR_sys_rt_sigqueueinfo __NR_rt_sigqueueinfo
+#define __NR_sys_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
 #define __NR_sys_syslog __NR_syslog
 #define __NR_sys_futex __NR_futex
 #define __NR_sys_inotify_init __NR_inotify_init
@@ -275,6 +276,8 @@ _syscall5(int, _llseek,  uint,  fd, ulong, hi, ulong,=
 lo,
           loff_t *, res, uint, wh);
 #endif
 _syscall3(int, sys_rt_sigqueueinfo, pid_t, pid, int, sig, siginfo_t *, u=
info)
+_syscall4(int, sys_rt_tgsigqueueinfo, pid_t, pid, pid_t, tid, int, sig,
+          siginfo_t *, uinfo)
 _syscall3(int,sys_syslog,int,type,char*,bufp,int,len)
 #ifdef __NR_exit_group
 _syscall1(int,exit_group,int,error_code)
@@ -8843,6 +8846,19 @@ abi_long do_syscall(void *cpu_env, int num, abi_lo=
ng arg1,
             ret =3D get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
         }
         break;
+    case TARGET_NR_rt_tgsigqueueinfo:
+        {
+            siginfo_t uinfo;
+
+            p =3D lock_user(VERIFY_READ, arg4, sizeof(target_siginfo_t),=
 1);
+            if (!p) {
+                goto efault;
+            }
+            target_to_host_siginfo(&uinfo, p);
+            unlock_user(p, arg4, 0);
+            ret =3D get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &u=
info));
+        }
+        break;
 #ifdef TARGET_NR_sigreturn
     case TARGET_NR_sigreturn:
         if (block_signals()) {
--=20
1.9.1
