Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36B1C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC67F20862
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC67F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWXJ-00008p-R0
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:04:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWOX-00086f-Gk
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWHi-0002X7-MT
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:48:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47937 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hTWHi-0001xk-Ak
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:48:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 587261A4531;
	Wed, 22 May 2019 20:47:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 379261A2238;
	Wed, 22 May 2019 20:47:15 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 20:46:23 +0200
Message-Id: <1558550785-20098-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 3/5] linux-user: Add functionality for tracking
 target signal mask
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

Add two inline functions that work with the signal set of the target.

target_sigdelset() removes a signal from target_sigset_t.
target_sigorset() creates a union of two target_sigset_t.

These functions will be used for introducing support for tracking the
target signal set. Functions for emptying and adding into a target signal
set already exist so this commit will serve as a supplement.

Add functions tswapal_target_sigset(), target_to_abi_ulong_old_sigset()
and abi_ulong_to_target_old_sigset().

The tswapal_target_sigset() function transforms target signal sets
from target to host endianness. This is helpful for tracking and working
with the target signal masks in the host endianness rather then keeping
it in the target endianness.

The target_to_abi_ulong_old_sigset() and abi_ulong_to_target_old_sigset()
functions are used for translating the signal set between the old way of
storing it in abi_ulong and the new target_sigset_t structure. They can
be used for expanding old implementations of certain system calls to
include the tracking of the target signal masks.

Add support for tracking the larger target signal mask in system calls
sigprocmask()/rt_sigprocmask(), sigsuspend()/rt_sigsuspend(),
sgetmask()/ssetmask() and in functions do_sigreturn(), do_rt_sigreturn(),
handle_pending_signal(), process_pending_signals().
Add a new function do_target_sigprocmask() which is based on
do_sigprocmask() and extends its functionallity.

It can happen that the host machine has a smaller range of signals
compared to the target machine that it's emulating. Currently the signals
that are in the target range but out of the host range are treated like
faulty signals and can't be used. In this patch, support is added for
tracking the target signal mask, alongside and in the same manner as the
host signal mask.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/mips/signal.c   |  16 +++++
 linux-user/qemu.h          |   6 ++
 linux-user/signal-common.h |   5 ++
 linux-user/signal.c        | 158 +++++++++++++++++++++++++++++++++++++++=
+++++-
 linux-user/syscall.c       |  94 +++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |   4 ++
 6 files changed, 282 insertions(+), 1 deletion(-)

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index 6aa303e..37922d9 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -253,6 +253,9 @@ long do_sigreturn(CPUMIPSState *regs)
     abi_ulong frame_addr;
     sigset_t blocked;
     target_sigset_t target_set;
+#ifdef TRACK_TARGET_SIGMASK
+    target_sigset_t target_blocked;
+#endif
     int i;
=20
     frame_addr =3D regs->active_tc.gpr[29];
@@ -265,7 +268,12 @@ long do_sigreturn(CPUMIPSState *regs)
     }
=20
     target_to_host_sigset_internal(&blocked, &target_set);
+#ifdef TRACK_TARGET_SIGMASK
+    tswapal_target_sigset(&target_blocked, &target_set);
+    target_set_sigmask(&blocked, &target_blocked);
+#else
     set_sigmask(&blocked);
+#endif
=20
     restore_sigcontext(regs, &frame->sf_sc);
=20
@@ -358,6 +366,9 @@ long do_rt_sigreturn(CPUMIPSState *env)
     struct target_rt_sigframe *frame;
     abi_ulong frame_addr;
     sigset_t blocked;
+#ifdef TRACK_TARGET_SIGMASK
+    target_sigset_t target_blocked;
+#endif
=20
     frame_addr =3D env->active_tc.gpr[29];
     trace_user_do_rt_sigreturn(env, frame_addr);
@@ -366,7 +377,12 @@ long do_rt_sigreturn(CPUMIPSState *env)
     }
=20
     target_to_host_sigset(&blocked, &frame->rs_uc.tuc_sigmask);
+#ifdef TRACK_TARGET_SIGMASK
+    tswapal_target_sigset(&target_blocked, &frame->rs_uc.tuc_sigmask);
+    target_set_sigmask(&blocked, &target_blocked);
+#else
     set_sigmask(&blocked);
+#endif
=20
     restore_sigcontext(env, &frame->rs_uc.tuc_mcontext);
=20
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 9f70996..75ba2a5 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -401,12 +401,18 @@ void host_to_target_siginfo(target_siginfo_t *tinfo=
, const siginfo_t *info);
 void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tin=
fo);
 int target_to_host_signal(int sig);
 int host_to_target_signal(int sig);
+void tswapal_target_sigset(target_sigset_t *d, const target_sigset_t *s)=
;
 long do_sigreturn(CPUArchState *env);
 long do_rt_sigreturn(CPUArchState *env);
 abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulo=
ng sp);
 int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
 abi_long do_swapcontext(CPUArchState *env, abi_ulong uold_ctx,
                         abi_ulong unew_ctx, abi_long ctx_size);
+#ifdef TRACK_TARGET_SIGMASK
+int do_target_sigprocmask(int how, const target_sigset_t *target_set,
+                          target_sigset_t *target_oldset,
+                          const sigset_t *set, sigset_t *oldset);
+#endif
 /**
  * block_signals: block all signals while handling this guest syscall
  *
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 51030a9..6332931 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -37,7 +37,12 @@ void target_to_host_sigset_internal(sigset_t *d,
                                     const target_sigset_t *s);
 void tswap_siginfo(target_siginfo_t *tinfo,
                    const target_siginfo_t *info);
+#ifndef TRACK_TARGET_SIGMASK
 void set_sigmask(const sigset_t *set);
+#else
+void target_set_sigmask(const sigset_t *set,
+                        const target_sigset_t *target_set);
+#endif
 void force_sig(int sig);
 void force_sigsegv(int oldsig);
 #if defined(TARGET_ARCH_HAS_SETUP_FRAME)
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 954aef8..9a73bfa 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -103,6 +103,12 @@ static inline void target_sigaddset(target_sigset_t =
*set, int signum)
     set->sig[signum / TARGET_NSIG_BPW] |=3D mask;
 }
=20
+static inline void target_sigdelset(target_sigset_t *set, int signum)
+{
+    abi_ulong mask =3D (abi_ulong)1 << (--signum % TARGET_NSIG_BPW);
+    set->sig[signum / TARGET_NSIG_BPW] &=3D ~mask;
+}
+
 static inline int target_sigismember(const target_sigset_t *set, int sig=
num)
 {
     signum--;
@@ -110,6 +116,16 @@ static inline int target_sigismember(const target_si=
gset_t *set, int signum)
     return ((set->sig[signum / TARGET_NSIG_BPW] & mask) !=3D 0);
 }
=20
+static inline void target_sigorset(target_sigset_t *set,
+                                   const target_sigset_t *left,
+                                   const target_sigset_t *right)
+{
+    int i;
+    for (i =3D 0; i < TARGET_NSIG_WORDS; i++) {
+        set->sig[i] =3D left->sig[i] | right->sig[i];
+    }
+}
+
 void host_to_target_sigset_internal(target_sigset_t *d,
                                     const sigset_t *s)
 {
@@ -174,6 +190,33 @@ void target_to_host_old_sigset(sigset_t *sigset,
     target_to_host_sigset(sigset, &d);
 }
=20
+void target_to_abi_ulong_old_sigset(abi_ulong *old_sigset,
+                                    const target_sigset_t *target_sigset=
)
+{
+    target_sigset_t d;
+    tswapal_target_sigset(&d, target_sigset);
+
+    memcpy(old_sigset, &d.sig, sizeof(target_sigset_t));
+}
+
+void abi_ulong_to_target_old_sigset(target_sigset_t *target_sigset,
+                                    const abi_ulong *old_sigset)
+{
+    target_sigset_t d;
+
+    memcpy(&d.sig, old_sigset, sizeof(target_sigset_t));
+    tswapal_target_sigset(target_sigset, &d);
+}
+
+void tswapal_target_sigset(target_sigset_t *d, const target_sigset_t *s)
+{
+    int i;
+
+    for (i =3D 0; i < TARGET_NSIG_WORDS; i++) {
+        d->sig[i] =3D tswapal(s->sig[i]);
+    }
+}
+
 int block_signals(void)
 {
     TaskState *ts =3D (TaskState *)thread_cpu->opaque;
@@ -236,16 +279,84 @@ int do_sigprocmask(int how, const sigset_t *set, si=
gset_t *oldset)
     return 0;
 }
=20
+#ifdef TRACK_TARGET_SIGMASK
+int do_target_sigprocmask(int how, const target_sigset_t *target_set,
+                          target_sigset_t *target_oldset,
+                          const sigset_t *set, sigset_t *oldset)
+{
+    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
+
+    if (target_oldset) {
+        *target_oldset =3D ts->target_signal_mask;
+    }
+    if (oldset) {
+        *oldset =3D ts->signal_mask;
+    }
+
+    if (target_set && set) {
+        int i;
+
+        if (block_signals()) {
+            return -TARGET_ERESTARTSYS;
+        }
+
+        switch (how) {
+        case SIG_BLOCK:
+            target_sigorset(&ts->target_signal_mask, &ts->target_signal_=
mask,
+                            target_set);
+            sigorset(&ts->signal_mask, &ts->signal_mask, set);
+            break;
+        case SIG_UNBLOCK:
+            for (i =3D 1; i <=3D TARGET_NSIG; ++i) {
+                if (target_sigismember(target_set, i) =3D=3D 1) {
+                    target_sigdelset(&ts->target_signal_mask, i);
+                }
+            }
+            for (i =3D 1; i <=3D NSIG; ++i) {
+                if (sigismember(set, i) =3D=3D 1) {
+                    sigdelset(&ts->signal_mask, i);
+                }
+            }
+            break;
+        case SIG_SETMASK:
+            ts->target_signal_mask =3D *target_set;
+            ts->signal_mask =3D *set;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        /* Silently ignore attempts to change blocking status of KILL or=
 STOP */
+        target_sigdelset(&ts->target_signal_mask, SIGKILL);
+        target_sigdelset(&ts->target_signal_mask, SIGSTOP);
+        sigdelset(&ts->signal_mask, SIGKILL);
+        sigdelset(&ts->signal_mask, SIGSTOP);
+    }
+    return 0;
+}
+#endif
+
 #if !defined(TARGET_NIOS2)
 /* Just set the guest's signal mask to the specified value; the
  * caller is assumed to have called block_signals() already.
  */
+#ifndef TRACK_TARGET_SIGMASK
 void set_sigmask(const sigset_t *set)
 {
     TaskState *ts =3D (TaskState *)thread_cpu->opaque;
=20
     ts->signal_mask =3D *set;
 }
+#else
+void target_set_sigmask(const sigset_t *set,
+                        const target_sigset_t *target_set)
+{
+    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
+
+    ts->signal_mask =3D *set;
+    ts->target_signal_mask =3D *target_set;
+}
+#endif
 #endif
=20
 /* sigaltstack management */
@@ -849,6 +960,9 @@ static void handle_pending_signal(CPUArchState *cpu_e=
nv, int sig,
     abi_ulong handler;
     sigset_t set;
     target_sigset_t target_old_set;
+#ifdef TRACK_TARGET_SIGMASK
+    target_sigset_t target_set;
+#endif
     struct target_sigaction *sa;
     TaskState *ts =3D cpu->opaque;
=20
@@ -886,21 +1000,39 @@ static void handle_pending_signal(CPUArchState *cp=
u_env, int sig,
     } else {
         /* compute the blocked signals during the handler execution */
         sigset_t *blocked_set;
+#ifdef TRACK_TARGET_SIGMASK
+        target_sigset_t *target_blocked_set;
=20
+        tswapal_target_sigset(&target_set, &sa->sa_mask);
+#endif
         target_to_host_sigset(&set, &sa->sa_mask);
         /* SA_NODEFER indicates that the current signal should not be
            blocked during the handler */
-        if (!(sa->sa_flags & TARGET_SA_NODEFER))
+        if (!(sa->sa_flags & TARGET_SA_NODEFER)) {
+#ifdef TRACK_TARGET_SIGMASK
+            target_sigaddset(&target_set, sig);
+#endif
             sigaddset(&set, target_to_host_signal(sig));
+        }
=20
         /* save the previous blocked signal state to restore it at the
            end of the signal execution (see do_sigreturn) */
+#ifdef TRACK_TARGET_SIGMASK
+        target_old_set =3D ts->target_signal_mask;
+#else
         host_to_target_sigset_internal(&target_old_set, &ts->signal_mask=
);
+#endif
=20
         /* block signals in the handler */
         blocked_set =3D ts->in_sigsuspend ?
             &ts->sigsuspend_mask : &ts->signal_mask;
         sigorset(&ts->signal_mask, blocked_set, &set);
+#ifdef TRACK_TARGET_SIGMASK
+        target_blocked_set =3D ts->in_sigsuspend ?
+            &ts->target_sigsuspend_mask : &ts->target_signal_mask;
+        target_sigorset(&ts->target_signal_mask, target_blocked_set,
+                        &target_set);
+#endif
         ts->in_sigsuspend =3D 0;
=20
         /* if the CPU is in VM86 mode, we restore the 32 bit values */
@@ -934,7 +1066,11 @@ void process_pending_signals(CPUArchState *cpu_env)
     int sig;
     TaskState *ts =3D cpu->opaque;
     sigset_t set;
+#ifdef TRACK_TARGET_SIGMASK
+    target_sigset_t *target_blocked_set;
+#else
     sigset_t *blocked_set;
+#endif
=20
     while (atomic_read(&ts->signal_pending)) {
         /* FIXME: This is not threadsafe.  */
@@ -952,22 +1088,42 @@ void process_pending_signals(CPUArchState *cpu_env=
)
              * to block a synchronous signal since it could then just en=
d up
              * looping round and round indefinitely.
              */
+#ifdef TRACK_TARGET_SIGMASK
+            if (sigismember(&ts->signal_mask, target_to_host_signal(sig)=
) =3D=3D 1
+                || target_sigismember(&ts->target_signal_mask, sig) =3D=3D=
 1
+                || sigact_table[sig - 1]._sa_handler =3D=3D TARGET_SIG_I=
GN) {
+                sigdelset(&ts->signal_mask, target_to_host_signal(sig));
+                target_sigdelset(&ts->target_signal_mask, sig);
+                sigact_table[sig - 1]._sa_handler =3D TARGET_SIG_DFL;
+            }
+#else
             if (sigismember(&ts->signal_mask, target_to_host_signal_tabl=
e[sig])
                 || sigact_table[sig - 1]._sa_handler =3D=3D TARGET_SIG_I=
GN) {
                 sigdelset(&ts->signal_mask, target_to_host_signal_table[=
sig]);
                 sigact_table[sig - 1]._sa_handler =3D TARGET_SIG_DFL;
             }
+#endif
=20
             handle_pending_signal(cpu_env, sig, &ts->sync_signal);
         }
=20
         for (sig =3D 1; sig <=3D TARGET_NSIG; sig++) {
+#ifdef TRACK_TARGET_SIGMASK
+            target_blocked_set =3D ts->in_sigsuspend ?
+                &ts->target_sigsuspend_mask : &ts->target_signal_mask;
+#else
             blocked_set =3D ts->in_sigsuspend ?
                 &ts->sigsuspend_mask : &ts->signal_mask;
+#endif
=20
+#ifdef TRACK_TARGET_SIGMASK
+            if (ts->sigtab[sig - 1].pending &&
+                (!target_sigismember(target_blocked_set, sig))) {
+#else
             if (ts->sigtab[sig - 1].pending &&
                 (!sigismember(blocked_set,
                               target_to_host_signal_table[sig]))) {
+#endif
                 handle_pending_signal(cpu_env, sig, &ts->sigtab[sig - 1]=
);
                 /* Restart scan from the beginning, as handle_pending_si=
gnal
                  * might have resulted in a new synchronous signal (eg S=
IGSEGV).
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 115ab13..dede443 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7871,6 +7871,17 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,
 #ifdef TARGET_NR_sgetmask /* not on alpha */
     case TARGET_NR_sgetmask:
         {
+#ifdef TRACK_TARGET_SIGMASK
+            sigset_t cur_set;
+            target_sigset_t target_set_mask;
+            abi_ulong target_set;
+            ret =3D do_target_sigprocmask(0, NULL, &target_set_mask,
+                                        NULL, &cur_set);
+            if (!ret) {
+                target_to_abi_ulong_old_sigset(&target_set, &target_set_=
mask);
+                ret =3D target_set;
+            }
+#else
             sigset_t cur_set;
             abi_ulong target_set;
             ret =3D do_sigprocmask(0, NULL, &cur_set);
@@ -7878,12 +7889,26 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
                 host_to_target_old_sigset(&target_set, &cur_set);
                 ret =3D target_set;
             }
+#endif
         }
         return ret;
 #endif
 #ifdef TARGET_NR_ssetmask /* not on alpha */
     case TARGET_NR_ssetmask:
         {
+#ifdef TRACK_TARGET_SIGMASK
+            sigset_t set, oset;
+            target_sigset_t target_set_mask, target_oset;
+            abi_ulong target_set =3D arg1;
+            target_to_host_old_sigset(&set, &target_set);
+            abi_ulong_to_target_old_sigset(&target_set_mask, &target_set=
);
+            ret =3D do_target_sigprocmask(SIG_SETMASK, &target_set_mask,
+                                        &target_oset, &set, &oset);
+            if (!ret) {
+                target_to_abi_ulong_old_sigset(&target_set, &target_oset=
);
+                ret =3D target_set;
+            }
+#else
             sigset_t set, oset;
             abi_ulong target_set =3D arg1;
             target_to_host_old_sigset(&set, &target_set);
@@ -7892,6 +7917,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
                 host_to_target_old_sigset(&target_set, &oset);
                 ret =3D target_set;
             }
+#endif
         }
         return ret;
 #endif
@@ -7900,6 +7926,9 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
         {
 #if defined(TARGET_ALPHA)
             sigset_t set, oldset;
+#ifdef TRACK_TARGET_SIGMASK
+            target_sigset_t target_set, target_oldset;
+#endif
             abi_ulong mask;
             int how;
=20
@@ -7919,14 +7948,26 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
             mask =3D arg2;
             target_to_host_old_sigset(&set, &mask);
=20
+#ifdef TRACK_TARGET_SIGMASK
+            abi_ulong_to_target_old_sigset(&target_set, &mask);
+
+            ret =3D do_target_sigprocmask(how, &target_set, &target_olds=
et,
+                                        &set, &oldset);
+            if (!is_error(ret)) {
+                target_to_abi_ulong_old_sigset(&mask, &target_oldset);
+#else
             ret =3D do_sigprocmask(how, &set, &oldset);
             if (!is_error(ret)) {
                 host_to_target_old_sigset(&mask, &oldset);
+#endif
                 ret =3D mask;
                 ((CPUAlphaState *)cpu_env)->ir[IR_V0] =3D 0; /* force no=
 error */
             }
 #else
             sigset_t set, oldset, *set_ptr;
+#ifdef TRACK_TARGET_SIGMASK
+            target_sigset_t target_set, target_oldset, *target_set_ptr;
+#endif
             int how;
=20
             if (arg2) {
@@ -7946,17 +7987,32 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
                 if (!(p =3D lock_user(VERIFY_READ, arg2, sizeof(target_s=
igset_t), 1)))
                     return -TARGET_EFAULT;
                 target_to_host_old_sigset(&set, p);
+#ifdef TRACK_TARGET_SIGMASK
+                abi_ulong_to_target_old_sigset(&target_set, p);
+                target_set_ptr =3D &target_set;
+#endif
                 unlock_user(p, arg2, 0);
                 set_ptr =3D &set;
             } else {
                 how =3D 0;
                 set_ptr =3D NULL;
+#ifdef TRACK_TARGET_SIGMASK
+                target_set_ptr =3D NULL;
+            }
+            ret =3D do_target_sigprocmask(how, target_set_ptr, &target_o=
ldset,
+                                        set_ptr, &oldset);
+#else
             }
             ret =3D do_sigprocmask(how, set_ptr, &oldset);
+#endif
             if (!is_error(ret) && arg3) {
                 if (!(p =3D lock_user(VERIFY_WRITE, arg3, sizeof(target_=
sigset_t), 0)))
                     return -TARGET_EFAULT;
+#ifdef TRACK_TARGET_SIGMASK
+                target_to_abi_ulong_old_sigset(p, &target_oldset);
+#else
                 host_to_target_old_sigset(p, &oldset);
+#endif
                 unlock_user(p, arg3, sizeof(target_sigset_t));
             }
 #endif
@@ -7967,6 +8023,9 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
         {
             int how =3D arg1;
             sigset_t set, oldset, *set_ptr;
+#ifdef TRACK_TARGET_SIGMASK
+            target_sigset_t target_set, target_oldset, *target_set_ptr;
+#endif
=20
             if (arg4 !=3D sizeof(target_sigset_t)) {
                 return -TARGET_EINVAL;
@@ -7989,17 +8048,32 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
                 if (!(p =3D lock_user(VERIFY_READ, arg2, sizeof(target_s=
igset_t), 1)))
                     return -TARGET_EFAULT;
                 target_to_host_sigset(&set, p);
+#ifdef TRACK_TARGET_SIGMASK
+                tswapal_target_sigset(&target_set, p);
+                target_set_ptr =3D &target_set;
+#endif
                 unlock_user(p, arg2, 0);
                 set_ptr =3D &set;
             } else {
                 how =3D 0;
                 set_ptr =3D NULL;
+#ifdef TRACK_TARGET_SIGMASK
+                target_set_ptr =3D NULL;
+            }
+            ret =3D do_target_sigprocmask(how, target_set_ptr, &target_o=
ldset,
+                                        set_ptr, &oldset);
+#else
             }
             ret =3D do_sigprocmask(how, set_ptr, &oldset);
+#endif
             if (!is_error(ret) && arg3) {
                 if (!(p =3D lock_user(VERIFY_WRITE, arg3, sizeof(target_=
sigset_t), 0)))
                     return -TARGET_EFAULT;
+#ifdef TRACK_TARGET_SIGMASK
+                tswapal_target_sigset(p, &target_oldset);
+#else
                 host_to_target_sigset(p, &oldset);
+#endif
                 unlock_user(p, arg3, sizeof(target_sigset_t));
             }
         }
@@ -8047,10 +8121,16 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
 #if defined(TARGET_ALPHA)
             abi_ulong mask =3D arg1;
             target_to_host_old_sigset(&ts->sigsuspend_mask, &mask);
+#ifdef TRACK_TARGET_SIGMASK
+            abi_ulong_to_target_old_sigset(&ts->target_sigsuspend_mask, =
&mask);
+#endif
 #else
             if (!(p =3D lock_user(VERIFY_READ, arg1, sizeof(target_sigse=
t_t), 1)))
                 return -TARGET_EFAULT;
             target_to_host_old_sigset(&ts->sigsuspend_mask, p);
+#ifdef TRACK_TARGET_SIGMASK
+            abi_ulong_to_target_old_sigset(&ts->target_sigsuspend_mask, =
p);
+#endif
             unlock_user(p, arg1, 0);
 #endif
             ret =3D get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
@@ -8071,6 +8151,9 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
             if (!(p =3D lock_user(VERIFY_READ, arg1, sizeof(target_sigse=
t_t), 1)))
                 return -TARGET_EFAULT;
             target_to_host_sigset(&ts->sigsuspend_mask, p);
+#ifdef TRACK_TARGET_SIGMASK
+            tswapal_target_sigset(&ts->target_sigsuspend_mask, p);
+#endif
             unlock_user(p, arg1, 0);
             ret =3D get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
                                                SIGSET_T_SIZE));
@@ -10351,6 +10434,9 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
             abi_ulong mask;
             int how;
             sigset_t set, oldset;
+#ifdef TRACK_TARGET_SIGMASK
+            target_sigset_t target_set, target_oldset;
+#endif
=20
             switch(arg1) {
             case TARGET_SIG_BLOCK:
@@ -10367,9 +10453,17 @@ static abi_long do_syscall1(void *cpu_env, int n=
um, abi_long arg1,
             }
             mask =3D arg2;
             target_to_host_old_sigset(&set, &mask);
+#ifdef TRACK_TARGET_SIGMASK
+            abi_ulong_to_target_old_sigset(&target_set, &mask);
+            ret =3D do_target_sigprocmask(how, &target_set, &target_olds=
et,
+                                        &set, &oldset);
+            if (!ret) {
+                target_to_abi_ulong_old_sigset(&mask, &target_oldset);
+#else
             ret =3D do_sigprocmask(how, &set, &oldset);
             if (!ret) {
                 host_to_target_old_sigset(&mask, &oldset);
+#endif
                 ret =3D mask;
             }
         }
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 1f5b2d1..64edec2 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -419,6 +419,10 @@ void host_to_target_old_sigset(abi_ulong *old_sigset=
,
                                const sigset_t *sigset);
 void target_to_host_old_sigset(sigset_t *sigset,
                                const abi_ulong *old_sigset);
+void target_to_abi_ulong_old_sigset(abi_ulong *old_sigset,
+                                    const target_sigset_t *target_sigset=
);
+void abi_ulong_to_target_old_sigset(target_sigset_t *target_sigset,
+                                    const abi_ulong *old_sigset);
 struct target_sigaction;
 int do_sigaction(int sig, const struct target_sigaction *act,
                  struct target_sigaction *oact);
--=20
2.7.4


