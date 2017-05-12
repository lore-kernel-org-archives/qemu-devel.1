Received: from eggs.gnu.org ([2001:4830:134:3::10]:50113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LM-000455-DH
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LI-0006Su-Dc
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46740 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LH-0006RY-Ts
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:40 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:22 +0200
Message-Id: <1494586944-7253-15-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/16] [RFC] linux-user: add functionality for
 tracking target signal mask
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
---
 linux-user/qemu.h    |   5 ++
 linux-user/signal.c  | 131 +++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 linux-user/syscall.c |  94 ++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+), 1 deletion(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 6ce0811..bf13db6 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -395,6 +395,11 @@ long do_sigreturn(CPUArchState *env);
 long do_rt_sigreturn(CPUArchState *env);
 abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulo=
ng sp);
 int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
+#ifdef TRACK_TARGET_SIGMASK
+int do_target_sigprocmask(int how, const target_sigset_t *target_set,
+                          target_sigset_t *target_oldset,
+                          const sigset_t *set, sigset_t *oldset);
+#endif
 /**
  * block_signals: block all signals while handling this guest syscall
  *
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 0c1e231..9d4ad43 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -296,17 +296,85 @@ int do_sigprocmask(int how, const sigset_t *set, si=
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
 #if !defined(TARGET_OPENRISC) && !defined(TARGET_UNICORE32) && \
     !defined(TARGET_NIOS2)
 /* Just set the guest's signal mask to the specified value; the
  * caller is assumed to have called block_signals() already.
  */
+#ifndef TRACK_TARGET_SIGMASK
 static void set_sigmask(const sigset_t *set)
 {
     TaskState *ts =3D (TaskState *)thread_cpu->opaque;
=20
     ts->signal_mask =3D *set;
 }
+#else
+static void target_set_sigmask(const sigset_t *set,
+                               const target_sigset_t *target_set)
+{
+    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
+
+    ts->signal_mask =3D *set;
+    ts->target_signal_mask =3D *target_set;
+}
+#endif
 #endif
=20
 /* siginfo conversion */
@@ -3315,6 +3383,9 @@ long do_sigreturn(CPUMIPSState *regs)
     abi_ulong frame_addr;
     sigset_t blocked;
     target_sigset_t target_set;
+#ifdef TRACK_TARGET_SIGMASK
+    target_sigset_t target_blocked;
+#endif
     int i;
=20
     frame_addr =3D regs->active_tc.gpr[29];
@@ -3327,7 +3398,12 @@ long do_sigreturn(CPUMIPSState *regs)
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
@@ -3423,6 +3499,9 @@ long do_rt_sigreturn(CPUMIPSState *env)
     struct target_rt_sigframe *frame;
     abi_ulong frame_addr;
     sigset_t blocked;
+#ifdef TRACK_TARGET_SIGMASK
+    target_sigset_t target_blocked;
+#endif
=20
     frame_addr =3D env->active_tc.gpr[29];
     trace_user_do_rt_sigreturn(env, frame_addr);
@@ -3431,7 +3510,12 @@ long do_rt_sigreturn(CPUMIPSState *env)
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
@@ -6574,6 +6658,9 @@ static void handle_pending_signal(CPUArchState *cpu=
_env, int sig,
     abi_ulong handler;
     sigset_t set;
     target_sigset_t target_old_set;
+#ifdef TRACK_TARGET_SIGMASK
+    target_sigset_t target_set;
+#endif
     struct target_sigaction *sa;
     TaskState *ts =3D cpu->opaque;
=20
@@ -6611,21 +6698,39 @@ static void handle_pending_signal(CPUArchState *c=
pu_env, int sig,
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
@@ -6661,7 +6766,11 @@ void process_pending_signals(CPUArchState *cpu_env=
)
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
@@ -6679,22 +6788,42 @@ void process_pending_signals(CPUArchState *cpu_en=
v)
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
index 94ecae3..f4ce6a8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8585,6 +8585,17 @@ abi_long do_syscall(void *cpu_env, int num, abi_lo=
ng arg1,
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
@@ -8592,12 +8603,26 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
                 host_to_target_old_sigset(&target_set, &cur_set);
                 ret =3D target_set;
             }
+#endif
         }
         break;
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
@@ -8606,6 +8631,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
                 host_to_target_old_sigset(&target_set, &oset);
                 ret =3D target_set;
             }
+#endif
         }
         break;
 #endif
@@ -8614,6 +8640,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         {
 #if defined(TARGET_ALPHA)
             sigset_t set, oldset;
+#ifdef TRACK_TARGET_SIGMASK
+            target_sigset_t target_set, target_oldset;
+#endif
             abi_ulong mask;
             int how;
=20
@@ -8634,14 +8663,26 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
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
@@ -8662,17 +8703,32 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
                 if (!(p =3D lock_user(VERIFY_READ, arg2, sizeof(target_s=
igset_t), 1)))
                     goto efault;
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
                     goto efault;
+#ifdef TRACK_TARGET_SIGMASK
+                target_to_abi_ulong_old_sigset(p, &target_oldset);
+#else
                 host_to_target_old_sigset(p, &oldset);
+#endif
                 unlock_user(p, arg3, sizeof(target_sigset_t));
             }
 #endif
@@ -8683,6 +8739,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         {
             int how =3D arg1;
             sigset_t set, oldset, *set_ptr;
+#ifdef TRACK_TARGET_SIGMASK
+            target_sigset_t target_set, target_oldset, *target_set_ptr;
+#endif
=20
             if (arg4 !=3D sizeof(target_sigset_t)) {
                 ret =3D -TARGET_EINVAL;
@@ -8707,17 +8766,32 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
                 if (!(p =3D lock_user(VERIFY_READ, arg2, sizeof(target_s=
igset_t), 1)))
                     goto efault;
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
                     goto efault;
+#ifdef TRACK_TARGET_SIGMASK
+                tswapal_target_sigset(p, &target_oldset);
+#else
                 host_to_target_sigset(p, &oldset);
+#endif
                 unlock_user(p, arg3, sizeof(target_sigset_t));
             }
         }
@@ -8766,10 +8840,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
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
                 goto efault;
             target_to_host_old_sigset(&ts->sigsuspend_mask, p);
+#ifdef TRACK_TARGET_SIGMASK
+            abi_ulong_to_target_old_sigset(&ts->target_sigsuspend_mask, =
p);
+#endif
             unlock_user(p, arg1, 0);
 #endif
             ret =3D get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
@@ -8791,6 +8871,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
             if (!(p =3D lock_user(VERIFY_READ, arg1, sizeof(target_sigse=
t_t), 1)))
                 goto efault;
             target_to_host_sigset(&ts->sigsuspend_mask, p);
+#ifdef TRACK_TARGET_SIGMASK
+            tswapal_target_sigset(&ts->target_sigsuspend_mask, p);
+#endif
             unlock_user(p, arg1, 0);
             ret =3D get_errno(safe_rt_sigsuspend(&ts->sigsuspend_mask,
                                                SIGSET_T_SIZE));
@@ -11030,6 +11113,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
             abi_ulong mask;
             int how;
             sigset_t set, oldset;
+#ifdef TRACK_TARGET_SIGMASK
+            target_sigset_t target_set, target_oldset;
+#endif
=20
             switch(arg1) {
             case TARGET_SIG_BLOCK:
@@ -11047,9 +11133,17 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
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
--=20
1.9.1
