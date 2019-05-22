Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30179C282DD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD7D20645
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD7D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49649 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWQe-0001Wh-58
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 14:57:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWOY-00086d-Rt
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWHO-0002KH-MQ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:48:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48035 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hTWHO-0002J4-C4
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:47:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id B9A1A1A4547;
	Wed, 22 May 2019 20:47:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 9F0E51A2238;
	Wed, 22 May 2019 20:47:21 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 20:46:25 +0200
Message-Id: <1558550785-20098-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 5/5] linux-user: Add support for multiplexing
 signals in more syscalls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com,
	=?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>,
	amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>

Add support for multiplexing in the host_signal_handler() function and in
system calls rt_sigqueueinfo()/rt_tgsigqueueinfo(), tgkill(), kill() for
the case when pid > 0.

The rt_sigqueueinfo()/rt_tgsigqueueinfo() system calls multiplex target
signals which are out of the host range by setting the si_errno value to
the actual value of the signal and sending the signal to the MUX_SIG
signal number. The host_signal_handler() will pull out the multiplexed
signals and set their signal number to the correct value. That value
should be in the si_errno field of the siginfo_t structure. The si_errno
field is used here but this implementation can be replaced with any other
unused field in the uinfo structure.

The emulation of larger target signal range is done by spoofing the syste=
m
call info, adding the signal number to the si_errno field, and sending it
to the host multiplex queue via rt_sigqueueinfo()/rt_tgsigqueueinfo().
In order to send a signal using rt_sigqueueinfo()/rt_tgsigqueueinfo() wit=
h
si_code SI_USER or SI_TKILL to another thread or process, we need to
disguise it as some other signal from the kernel range because the host
kernel doesn't allow direct impersonations of those signals. This is done
with SIG_SPOOF which moves the si_code to the nearest unused kernel si_co=
de
value. After the signal is successfully sent the host_signal_handler() of
the receiving thread/process will turn it back into the proper kill/tgkil=
l
signal, before it gets processed.

The tkill() system call as well as kill() with the argument pid <=3D 0
couldn't be implemented simply using this method because it requires
acquiring information about, and sending simultaneous signals to multiple
threads or processes. These functionalities are out of the scope of
rt_sigqueueinfo()/rt_tgsigqueueinfo().

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/signal.c       | 22 +++++++++++++
 linux-user/syscall.c      | 81 +++++++++++++++++++++++++++++++++++++++++=
++++++
 linux-user/syscall_defs.h |  8 +++++
 3 files changed, 111 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 601de3e..885ceab 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -807,6 +807,28 @@ static void host_signal_handler(int host_signum, sig=
info_t *info,
     sig =3D host_to_target_signal(host_signum);
     if (sig < 1 || sig > TARGET_NSIG)
         return;
+
+#ifdef MUX_SIG
+    if (sig =3D=3D MUX_SIG) {
+        /* return the spoofed kill/tgkill signals into standard form */
+        if (info->si_code =3D=3D SIG_SPOOF(SI_USER)) {
+            info->si_code =3D SI_USER;
+        } else if (info->si_code =3D=3D SIG_SPOOF(SI_TKILL)) {
+            info->si_code =3D SI_TKILL;
+        }
+
+        /*
+         * We assume that si_errno field will remain intact during signa=
l
+         * processing on the host. If it changes, the signal will be sen=
t to
+         * the wrong number (most likely to MUX_SIG).
+         */
+        /* get the actual target signal number */
+        int target_sig =3D info->si_errno;
+        if (target_sig >=3D _NSIG && target_sig < TARGET_NSIG) {
+            sig =3D target_sig;
+        }
+    }
+#endif
     trace_user_host_signal(env, host_signum, sig);
=20
     rewind_if_in_safe_syscall(puc);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dede443..2e3c951 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6448,6 +6448,24 @@ static inline abi_long host_to_target_stat64(void =
*cpu_env,
 }
 #endif
=20
+#ifdef MUX_SIG
+static inline int multiplex(abi_long *arg, siginfo_t *uinfo)
+{
+    if (*arg >=3D _NSIG && *arg < TARGET_NSIG) {
+        /*
+         * Using si_errno to transfer the signal number assumes that the=
 field
+         * doesn't change its value before it gets handled in the
+         * host_signal_handler().
+         */
+        uinfo->si_errno =3D *arg;
+        *arg =3D MUX_SIG;
+        uinfo->si_signo =3D MUX_SIG;
+    }
+
+    return 0;
+}
+#endif
+
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
    futexes locally would make futexes shared between multiple processes
@@ -7535,7 +7553,42 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,
         return get_errno(syncfs(arg1));
 #endif
     case TARGET_NR_kill:
+#ifdef MUX_SIG
+        if (arg2 >=3D _NSIG && arg2 < TARGET_NSIG) {
+            siginfo_t info;
+
+            info.si_errno =3D arg2;
+            info.si_signo =3D MUX_SIG;
+            info.si_code =3D SIG_SPOOF(SI_USER);
+            info.si_pid =3D getpid();
+            info.si_uid =3D getuid();
+
+            /* pid > 0 */
+            if (arg1 > 0) {
+                return get_errno(sys_rt_sigqueueinfo(arg1, MUX_SIG, &inf=
o));
+            } else {
+                return -TARGET_EINVAL;
+            }
+            /*
+             * TODO: In order to implement kill with rt_tgsigqueueinfo()=
 for
+             * cases where pid <=3D 0 one needs to get a list of all the=
 relevant
+             * processes and simultaniously send the signal to them.
+             * Missing:
+             * (pid =3D 0):
+             *     send to every process in the process group of
+             *     the calling process
+             * (pid =3D -1):
+             *     send to every process for which the calling process
+             *     has permission to send signals, except for process 1 =
(init)
+             * (pid < -1):
+             *     send to every process in the process group whose ID i=
s -pid
+             */
+        } else {
+            return get_errno(safe_kill(arg1, target_to_host_signal(arg2)=
));
+        }
+#else
         return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
+#endif
 #ifdef TARGET_NR_rename
     case TARGET_NR_rename:
         {
@@ -8208,6 +8261,9 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
             }
             target_to_host_siginfo(&uinfo, p);
             unlock_user(p, arg3, 0);
+#ifdef MUX_SIG
+            multiplex(&arg2, &uinfo);
+#endif
             ret =3D get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
         }
         return ret;
@@ -8221,6 +8277,9 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
             }
             target_to_host_siginfo(&uinfo, p);
             unlock_user(p, arg4, 0);
+#ifdef MUX_SIG
+            multiplex(&arg3, &uinfo);
+#endif
             ret =3D get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &u=
info));
         }
         return ret;
@@ -11037,11 +11096,33 @@ static abi_long do_syscall1(void *cpu_env, int =
num, abi_long arg1,
 #endif
=20
     case TARGET_NR_tkill:
+        /*
+         * TODO: In order to implement tkill with rt_sigqueueinfo() one =
needs
+         * to get a list of all the threads with the specifiend tid and
+         * simultaniously send the signal to them.
+         */
         return get_errno(safe_tkill((int)arg1, target_to_host_signal(arg=
2)));
=20
     case TARGET_NR_tgkill:
+#ifdef MUX_SIG
+        if (arg3 >=3D _NSIG && arg3 < TARGET_NSIG) {
+            siginfo_t info;
+
+            info.si_errno =3D arg3;
+            info.si_signo =3D MUX_SIG;
+            info.si_code =3D SIG_SPOOF(SI_TKILL);
+            info.si_pid =3D getpid();
+            info.si_uid =3D getuid();
+
+            return get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, MUX_SIG, =
&info));
+        } else {
+            return get_errno(safe_tgkill((int)arg1, (int)arg2,
+                             target_to_host_signal(arg3)));
+        }
+#else
         return get_errno(safe_tgkill((int)arg1, (int)arg2,
                          target_to_host_signal(arg3)));
+#endif
=20
 #ifdef TARGET_NR_set_robust_list
     case TARGET_NR_set_robust_list:
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0c72509..ca97f67 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -405,6 +405,14 @@ struct target_dirent64 {
  * the host signal masks.
  */
 #define TRACK_TARGET_SIGMASK
+
+/*
+ * This macro is used to change a kill/tgkill signal so it can be sent t=
hrough
+ * rt_sigqueueinfo()/rt_tgsigqueueinfo(), since the host kernel doesn't =
allow
+ * direct impersonations of those signals. Subtracting 8 from the code m=
oves
+ * it to the nearest unused kernel si_code value.
+ */
+#define SIG_SPOOF(code)  ((code) - 8)
 #endif
=20
 typedef struct {
--=20
2.7.4


