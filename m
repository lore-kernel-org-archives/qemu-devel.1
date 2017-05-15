Received: from eggs.gnu.org ([2001:4830:134:3::10]:39305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHcP-0006Qt-Kw
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHcL-0007aO-Lo
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:09:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47715 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1dAHcL-0007Zm-9C
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:09:01 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Mon, 15 May 2017 16:59:56 +0200
Message-Id: <1494860396-24930-17-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 16/16] [RFC] linux-user: add support for
 multiplexing signals in rt_sigqueueinfo(), rt_tgsigqueueinfo(),
 kill() and tgkill() syscalls.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: laurent@vivier.eu, Miodrag.Dinic@rt-rk.com, Aleksandar.Markovic@rt-rk.com, Petar.Jovanovic@rt-rk.com, yongbok.kim@imgtec.com, Milos.Stojanovic@rt-rk.com

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
---
 linux-user/signal.c       | 22 +++++++++++++
 linux-user/syscall.c      | 81 +++++++++++++++++++++++++++++++++++++++++=
++++++
 linux-user/syscall_defs.h |  8 +++++
 3 files changed, 111 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index ceaccab..f80a462 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -787,6 +787,28 @@ static void host_signal_handler(int host_signum, sig=
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
index f4ce6a8..8190575 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7123,6 +7123,24 @@ static inline abi_long host_to_target_stat64(void =
*cpu_env,
     return 0;
 }
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
@@ -8258,7 +8276,42 @@ abi_long do_syscall(void *cpu_env, int num, abi_lo=
ng arg1,
         break;
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
+                ret =3D get_errno(sys_rt_sigqueueinfo(arg1, MUX_SIG, &in=
fo));
+            } else {
+                ret =3D -TARGET_EINVAL;
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
+            ret =3D get_errno(safe_kill(arg1, target_to_host_signal(arg2=
)));
+        }
+#else
         ret =3D get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
+#endif
         break;
 #ifdef TARGET_NR_rename
     case TARGET_NR_rename:
@@ -8929,6 +8982,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
             }
             target_to_host_siginfo(&uinfo, p);
             unlock_user(p, arg3, 0);
+#ifdef MUX_SIG
+            multiplex(&arg2, &uinfo);
+#endif
             ret =3D get_errno(sys_rt_sigqueueinfo(arg1, arg2, &uinfo));
         }
         break;
@@ -8942,6 +8998,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
             }
             target_to_host_siginfo(&uinfo, p);
             unlock_user(p, arg4, 0);
+#ifdef MUX_SIG
+            multiplex(&arg3, &uinfo);
+#endif
             ret =3D get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, arg3, &u=
info));
         }
         break;
@@ -11743,12 +11802,34 @@ abi_long do_syscall(void *cpu_env, int num, abi=
_long arg1,
 #endif
=20
     case TARGET_NR_tkill:
+        /*
+         * TODO: In order to implement tkill with rt_sigqueueinfo() one =
needs
+         * to get a list of all the threads with the specifiend tid and
+         * simultaniously send the signal to them.
+         */
         ret =3D get_errno(safe_tkill((int)arg1, target_to_host_signal(ar=
g2)));
         break;
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
+            ret =3D get_errno(sys_rt_tgsigqueueinfo(arg1, arg2, MUX_SIG,=
 &info));
+        } else {
+            ret =3D get_errno(safe_tgkill((int)arg1, (int)arg2,
+                            target_to_host_signal(arg3)));
+        }
+#else
         ret =3D get_errno(safe_tgkill((int)arg1, (int)arg2,
                         target_to_host_signal(arg3)));
+#endif
         break;
=20
 #ifdef TARGET_NR_set_robust_list
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 42089fc..16cab53 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -412,6 +412,14 @@ struct target_dirent64 {
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
1.9.1
