Received: from eggs.gnu.org ([2001:4830:134:3::10]:42938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4c-0000hQ-57
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4Z-0002Sd-MI
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4Z-0002Ri-Ch
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:26 -0500
Message-Id: <20170313195547.21466-10-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/30] trace: Fix parameter types in
 linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Riku Voipio <riku.voipio@iki.fi>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces.  In this patch, we can't update the trace
definitions, because abi_ulong is not always available; and since
that type is variably-sized, the only solution to reliably pass it
through printf's varargs is an explicit cast at all callsites.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 linux-user/signal.c | 106 ++++++++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index a67db04..930240b 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1119,7 +1119,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_frame(env, frame_addr);
+    trace_user_setup_frame(env, (uint64_t) frame_addr);

     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto give_sigsegv;
@@ -1182,7 +1182,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);

     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto give_sigsegv;
@@ -1343,7 +1343,7 @@ long do_sigreturn(CPUX86State *env)
     sigset_t set;
     int i;

-    trace_user_do_sigreturn(env, frame_addr);
+    trace_user_do_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
         goto badframe;
     /* set blocked signals */
@@ -1375,7 +1375,7 @@ long do_rt_sigreturn(CPUX86State *env)
     sigset_t set;

     frame_addr = env->regs[R_ESP] - sizeof(abi_ulong);
-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
         goto badframe;
     target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
@@ -1581,7 +1581,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     abi_ulong frame_addr, return_addr;

     frame_addr = get_sigframe(ka, env);
-    trace_user_setup_frame(env, frame_addr);
+    trace_user_setup_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -1641,7 +1641,7 @@ long do_rt_sigreturn(CPUARMState *env)
     struct target_rt_sigframe *frame = NULL;
     abi_ulong frame_addr = env->xregs[31];

-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (frame_addr & 15) {
         goto badframe;
     }
@@ -1970,7 +1970,7 @@ static void setup_frame_v1(int usig, struct target_sigaction *ka,
     abi_ulong frame_addr = get_sigframe(ka, regs, sizeof(*frame));
     int i;

-    trace_user_setup_frame(regs, frame_addr);
+    trace_user_setup_frame(regs, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto sigsegv;
     }
@@ -1996,7 +1996,7 @@ static void setup_frame_v2(int usig, struct target_sigaction *ka,
     struct sigframe_v2 *frame;
     abi_ulong frame_addr = get_sigframe(ka, regs, sizeof(*frame));

-    trace_user_setup_frame(regs, frame_addr);
+    trace_user_setup_frame(regs, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto sigsegv;
     }
@@ -2033,7 +2033,7 @@ static void setup_rt_frame_v1(int usig, struct target_sigaction *ka,
     int i;
     abi_ulong info_addr, uc_addr;

-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto sigsegv;
     }
@@ -2078,7 +2078,7 @@ static void setup_rt_frame_v2(int usig, struct target_sigaction *ka,
     abi_ulong frame_addr = get_sigframe(ka, env, sizeof(*frame));
     abi_ulong info_addr, uc_addr;

-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto sigsegv;
     }
@@ -2158,7 +2158,7 @@ static long do_sigreturn_v1(CPUARMState *env)
      * not, then the user is trying to mess with us.
      */
     frame_addr = env->regs[13];
-    trace_user_do_sigreturn(env, frame_addr);
+    trace_user_do_sigreturn(env, (uint64_t) frame_addr);
     if (frame_addr & 7) {
         goto badframe;
     }
@@ -2301,7 +2301,7 @@ static long do_sigreturn_v2(CPUARMState *env)
      * not, then the user is trying to mess with us.
      */
     frame_addr = env->regs[13];
-    trace_user_do_sigreturn(env, frame_addr);
+    trace_user_do_sigreturn(env, (uint64_t) frame_addr);
     if (frame_addr & 7) {
         goto badframe;
     }
@@ -2347,7 +2347,7 @@ static long do_rt_sigreturn_v1(CPUARMState *env)
      * not, then the user is trying to mess with us.
      */
     frame_addr = env->regs[13];
-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (frame_addr & 7) {
         goto badframe;
     }
@@ -2391,7 +2391,7 @@ static long do_rt_sigreturn_v2(CPUARMState *env)
      * not, then the user is trying to mess with us.
      */
     frame_addr = env->regs[13];
-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (frame_addr & 7) {
         goto badframe;
     }
@@ -2593,7 +2593,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,

     sigframe_size = NF_ALIGNEDSZ;
     sf_addr = get_sigframe(ka, env, sigframe_size);
-    trace_user_setup_frame(env, sf_addr);
+    trace_user_setup_frame(env, (uint64_t) sf_addr);

     sf = lock_user(VERIFY_WRITE, sf_addr,
                    sizeof(struct target_signal_frame), 0);
@@ -2687,7 +2687,7 @@ long do_sigreturn(CPUSPARCState *env)
     int err=0, i;

     sf_addr = env->regwptr[UREG_FP];
-    trace_user_do_sigreturn(env, sf_addr);
+    trace_user_do_sigreturn(env, (uint64_t) sf_addr);
     if (!lock_user_struct(VERIFY_READ, sf, sf_addr, 1)) {
         goto segv_and_exit;
     }
@@ -2752,7 +2752,7 @@ segv_and_exit:

 long do_rt_sigreturn(CPUSPARCState *env)
 {
-    trace_user_do_rt_sigreturn(env, 0);
+    trace_user_do_rt_sigreturn(env, (uint64_t) 0);
     fprintf(stderr, "do_rt_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
@@ -3223,7 +3223,7 @@ static void setup_frame(int sig, struct target_sigaction * ka,
     int i;

     frame_addr = get_sigframe(ka, regs, sizeof(*frame));
-    trace_user_setup_frame(regs, frame_addr);
+    trace_user_setup_frame(regs, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -3272,7 +3272,7 @@ long do_sigreturn(CPUMIPSState *regs)
     int i;

     frame_addr = regs->active_tc.gpr[29];
-    trace_user_do_sigreturn(regs, frame_addr);
+    trace_user_do_sigreturn(regs, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
         goto badframe;

@@ -3319,7 +3319,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -3379,7 +3379,7 @@ long do_rt_sigreturn(CPUMIPSState *env)
     sigset_t blocked;

     frame_addr = env->active_tc.gpr[29];
-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
         goto badframe;
     }
@@ -3535,7 +3535,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
-    trace_user_setup_frame(regs, frame_addr);
+    trace_user_setup_frame(regs, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -3584,7 +3584,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(ka, regs->gregs[15], sizeof(*frame));
-    trace_user_setup_rt_frame(regs, frame_addr);
+    trace_user_setup_rt_frame(regs, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -3645,7 +3645,7 @@ long do_sigreturn(CPUSH4State *regs)
     int err = 0;

     frame_addr = regs->gregs[15];
-    trace_user_do_sigreturn(regs, frame_addr);
+    trace_user_do_sigreturn(regs, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
         goto badframe;
     }
@@ -3679,7 +3679,7 @@ long do_rt_sigreturn(CPUSH4State *regs)
     sigset_t blocked;

     frame_addr = regs->gregs[15];
-    trace_user_do_rt_sigreturn(regs, frame_addr);
+    trace_user_do_rt_sigreturn(regs, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
         goto badframe;
     }
@@ -3831,7 +3831,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(ka, env, sizeof *frame);
-    trace_user_setup_frame(env, frame_addr);
+    trace_user_setup_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto badframe;

@@ -3898,7 +3898,7 @@ long do_sigreturn(CPUMBState *env)
     int i;

     frame_addr = env->regs[R_SP];
-    trace_user_do_sigreturn(env, frame_addr);
+    trace_user_do_sigreturn(env, (uint64_t) frame_addr);
     /* Make sure the guest isn't playing games.  */
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1))
         goto badframe;
@@ -3925,7 +3925,7 @@ badframe:

 long do_rt_sigreturn(CPUMBState *env)
 {
-    trace_user_do_rt_sigreturn(env, 0);
+    trace_user_do_rt_sigreturn(env, (uint64_t) 0);
     fprintf(stderr, "Microblaze do_rt_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
@@ -4015,7 +4015,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(env, sizeof *frame);
-    trace_user_setup_frame(env, frame_addr);
+    trace_user_setup_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto badframe;

@@ -4069,7 +4069,7 @@ long do_sigreturn(CPUCRISState *env)
     int i;

     frame_addr = env->regs[R_SP];
-    trace_user_do_sigreturn(env, frame_addr);
+    trace_user_do_sigreturn(env, (uint64_t) frame_addr);
     /* Make sure the guest isn't playing games.  */
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1)) {
         goto badframe;
@@ -4093,7 +4093,7 @@ badframe:

 long do_rt_sigreturn(CPUCRISState *env)
 {
-    trace_user_do_rt_sigreturn(env, 0);
+    trace_user_do_rt_sigreturn(env, (uint64_t) 0);
     fprintf(stderr, "CRIS do_rt_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
@@ -4298,7 +4298,7 @@ give_sigsegv:

 long do_sigreturn(CPUNios2State *env)
 {
-    trace_user_do_sigreturn(env, 0);
+    trace_user_do_sigreturn(env, (uint64_t) 0);
     fprintf(stderr, "do_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
@@ -4470,7 +4470,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong info_addr, uc_addr;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -4529,14 +4529,14 @@ give_sigsegv:

 long do_sigreturn(CPUOpenRISCState *env)
 {
-    trace_user_do_sigreturn(env, 0);
+    trace_user_do_sigreturn(env, (uint64_t) 0);
     fprintf(stderr, "do_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }

 long do_rt_sigreturn(CPUOpenRISCState *env)
 {
-    trace_user_do_rt_sigreturn(env, 0);
+    trace_user_do_rt_sigreturn(env, (uint64_t) 0);
     fprintf(stderr, "do_rt_sigreturn: not implemented\n");
     return -TARGET_ENOSYS;
 }
@@ -4660,7 +4660,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_frame(env, frame_addr);
+    trace_user_setup_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -4717,7 +4717,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;

     frame_addr = get_sigframe(ka, env, sizeof *frame);
-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -4774,8 +4774,8 @@ restore_sigregs(CPUS390XState *env, target_sigregs *sc)
     }

     __get_user(env->psw.mask, &sc->regs.psw.mask);
-    trace_user_s390x_restore_sigregs(env, (unsigned long long)sc->regs.psw.addr,
-                                     (unsigned long long)env->psw.addr);
+    trace_user_s390x_restore_sigregs(env, (uint64_t) sc->regs.psw.addr,
+                                     (uint64_t) env->psw.addr);
     __get_user(env->psw.addr, &sc->regs.psw.addr);
     /* FIXME: 31-bit -> | PSW_ADDR_AMODE */

@@ -4796,7 +4796,7 @@ long do_sigreturn(CPUS390XState *env)
     target_sigset_t target_set;
     sigset_t set;

-    trace_user_do_sigreturn(env, frame_addr);
+    trace_user_do_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
         goto badframe;
     }
@@ -4823,7 +4823,7 @@ long do_rt_sigreturn(CPUS390XState *env)
     abi_ulong frame_addr = env->regs[15];
     sigset_t set;

-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
         goto badframe;
     }
@@ -5271,7 +5271,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     int err = 0;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_frame(env, frame_addr);
+    trace_user_setup_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1))
         goto sigsegv;
     sc = &frame->sctx;
@@ -5634,7 +5634,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(ka, env, sizeof *frame);
-    trace_user_setup_frame(env, frame_addr);
+    trace_user_setup_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -5751,7 +5751,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i;

     frame_addr = get_sigframe(ka, env, sizeof *frame);
-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -5820,7 +5820,7 @@ long do_sigreturn(CPUM68KState *env)
     sigset_t set;
     int i;

-    trace_user_do_sigreturn(env, frame_addr);
+    trace_user_do_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
         goto badframe;

@@ -5853,7 +5853,7 @@ long do_rt_sigreturn(CPUM68KState *env)
     abi_ulong frame_addr = env->aregs[7] - 4;
     sigset_t set;

-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
         goto badframe;

@@ -5993,7 +5993,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
     int err = 0;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_frame(env, frame_addr);
+    trace_user_setup_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -6036,7 +6036,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i, err = 0;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -6114,7 +6114,7 @@ long do_rt_sigreturn(CPUAlphaState *env)
     struct target_rt_sigframe *frame;
     sigset_t set;

-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
         goto badframe;
     }
@@ -6228,7 +6228,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     unsigned long restorer;

     frame_addr = get_sigframe(ka, env, sizeof(*frame));
-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
@@ -6279,7 +6279,7 @@ long do_rt_sigreturn(CPUTLGState *env)
     struct target_rt_sigframe *frame;
     sigset_t set;

-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
         goto badframe;
     }
@@ -6405,7 +6405,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
     frame_addr = QEMU_ALIGN_UP(sp, 64);
     sp = frame_addr + PARISC_RT_SIGFRAME_SIZE32;

-    trace_user_setup_rt_frame(env, frame_addr);
+    trace_user_setup_rt_frame(env, (uint64_t) frame_addr);

     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
@@ -6468,7 +6468,7 @@ long do_rt_sigreturn(CPUArchState *env)
     struct target_rt_sigframe *frame;
     sigset_t set;

-    trace_user_do_rt_sigreturn(env, frame_addr);
+    trace_user_do_rt_sigreturn(env, (uint64_t) frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
         goto badframe;
     }
-- 
2.9.3
