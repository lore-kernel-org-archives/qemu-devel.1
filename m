Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6063C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD0420645
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD0420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49645 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWQb-0001UM-IO
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 14:57:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWOX-00086e-6G
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWHn-0002Zc-8Z
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:48:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47945 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hTWHm-00020j-UX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:48:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 33BEC1A4545;
	Wed, 22 May 2019 20:47:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 1A2F01A2238;
	Wed, 22 May 2019 20:47:20 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 20:46:24 +0200
Message-Id: <1558550785-20098-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 4/5] linux-user: Add support for multiplexing
 larger target signals
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
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/signal.c       | 32 ++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h | 20 ++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 9a73bfa..601de3e 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -291,6 +291,15 @@ int do_target_sigprocmask(int how, const target_sigs=
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
@@ -331,6 +340,15 @@ int do_target_sigprocmask(int how, const target_sigs=
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
@@ -355,6 +373,10 @@ void target_set_sigmask(const sigset_t *set,
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
@@ -929,6 +951,12 @@ int do_sigaction(int sig, const struct target_sigact=
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
@@ -1141,6 +1169,10 @@ void process_pending_signals(CPUArchState *cpu_env=
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
index 64edec2..0c72509 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -387,6 +387,26 @@ struct target_dirent64 {
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
2.7.4


