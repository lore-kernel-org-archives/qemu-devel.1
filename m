Received: from eggs.gnu.org ([2001:4830:134:3::10]:39106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHbs-0005xe-Lm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHbo-0007Pr-Ax
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:08:32 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47600 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1dAHbn-0007PS-VS
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:08:28 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Mon, 15 May 2017 16:59:55 +0200
Message-Id: <1494860396-24930-16-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/16] [RFC] linux-user: add support for
 multiplexing larger target signals
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

Add MUX_SIG as a multiplex signal number for all target signals which are
out of the host range. Add support for multiplexing in do_sigaction(),
process_pending_signals(), target_set_sigmask() and do_target_sigprocmask=
().

This patch solves the problem of unusable target signals which are out of
the host range. This is done by enabling the usage of one of the host
signals (MUX_SIG) as a multiplex for all the target signals that are out
of range. In order to have the target signal masks available
TRACK_TARGET_MASK is defined which enables the tracking of the target
signals masks.

The table of signal handlers already supports the whole range of target
signals. In the do_sigaction() function the signal number of signals whic=
h
are out of range are replaced by MUX_SIG which bypasses the error from th=
e
host system and doesn't interfere with signal handling on the target.
Since the MUX_SIG is used as a multiplex, it must never be blocked on hos=
t,
so support for emulating the blocking of this signal is added. This is do=
ne
by only blocking MUX_SIG in the target mask and retrieving its status fro=
m
there when it's needed.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/signal.c       | 32 ++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h | 20 ++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 006b45b..ceaccab 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -308,6 +308,15 @@ int do_target_sigprocmask(int how, const target_sigs=
et_t *target_set,
     }
     if (oldset) {
         *oldset =3D ts->signal_mask;
+#ifdef MUX_SIG
+        /*
+         * The emulation of MUX_SIG being blocked is done using the
+         * target_signal_mask, so the status of MUX_SIG is taken from th=
ere.
+         */
+        if (target_sigismember(&ts->target_signal_mask, MUX_SIG) =3D=3D =
1) {
+            sigaddset(oldset, MUX_SIG);
+        }
+#endif
     }
=20
     if (target_set && set) {
@@ -348,6 +357,15 @@ int do_target_sigprocmask(int how, const target_sigs=
et_t *target_set,
         target_sigdelset(&ts->target_signal_mask, SIGSTOP);
         sigdelset(&ts->signal_mask, SIGKILL);
         sigdelset(&ts->signal_mask, SIGSTOP);
+#ifdef MUX_SIG
+        /*
+         * Since MUX_SIG is used for all the target signals out of the h=
ost
+         * range it must never be blocked on host. The emulation of MUX_=
SIG
+         * being blocked is done using the target_signal_mask. The statu=
s
+         * of MUX_SIG is taken form the target_signal_mask.
+         */
+        sigdelset(&ts->signal_mask, MUX_SIG);
+#endif
     }
     return 0;
 }
@@ -373,6 +391,10 @@ static void target_set_sigmask(const sigset_t *set,
=20
     ts->signal_mask =3D *set;
     ts->target_signal_mask =3D *target_set;
+#ifdef MUX_SIG
+    /* MUX_SIG can't be blocked on host */
+    sigdelset(&ts->signal_mask, MUX_SIG);
+#endif
 }
 #endif
 #endif
@@ -909,6 +931,12 @@ int do_sigaction(int sig, const struct target_sigact=
ion *act,
=20
         /* we update the host linux signal state */
         host_sig =3D target_to_host_signal(sig);
+#ifdef MUX_SIG
+        /* put the out of host range signal into the multiplex */
+        if (sig >=3D _NSIG && sig < TARGET_NSIG) {
+            host_sig =3D MUX_SIG;
+        }
+#endif
         if (host_sig !=3D SIGSEGV && host_sig !=3D SIGBUS) {
             sigfillset(&act1.sa_mask);
             act1.sa_flags =3D SA_SIGINFO;
@@ -6842,6 +6870,10 @@ void process_pending_signals(CPUArchState *cpu_env=
)
         set =3D ts->signal_mask;
         sigdelset(&set, SIGSEGV);
         sigdelset(&set, SIGBUS);
+#ifdef MUX_SIG
+        /* MUX_SIG can't be blocked on host */
+        sigdelset(&ts->signal_mask, MUX_SIG);
+#endif
         sigprocmask(SIG_SETMASK, &set, 0);
     }
     ts->in_sigsuspend =3D 0;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7eec420..42089fc 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -394,6 +394,26 @@ struct target_dirent64 {
 #define TARGET_NSIG_BPW	   TARGET_ABI_BITS
 #define TARGET_NSIG_WORDS  (TARGET_NSIG / TARGET_NSIG_BPW)
=20
+#if _NSIG <=3D TARGET_NSIG
+/*
+ * MUX_SIG is used as a multiplex signal number - signals that are
+ * out of the host range and in the target range are sent through it.
+ * It is defined as the maximal available real-time signal in order to
+ * comply with the rule that low-numbered signals have highest priority.
+ * (signals using it will have the same priority but it will be smaller
+ * than all the other real-time signals)
+ * SIGRMTAX is avoided so it doesn't interfere with the hack of reversin=
g
+ * __SIGRTMIN and __SIGRTMAX in the host_to_target_signal_table.
+ */
+#define MUX_SIG     (SIGRTMAX - 1)
+
+/*
+ * The target signal masks must be tracked since they are larger than
+ * the host signal masks.
+ */
+#define TRACK_TARGET_SIGMASK
+#endif
+
 typedef struct {
     abi_ulong sig[TARGET_NSIG_WORDS];
 } target_sigset_t;
--=20
1.9.1
