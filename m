Received: from eggs.gnu.org ([2001:4830:134:3::10]:59617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmu-0008R2-IQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLms-000666-Rf
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLms-00064P-IB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLml-000750-NW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:04 +0000
Message-Id: <20180309172622.4277-8-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/25] aarch64-linux-user: Split out helpers for
 guest signal handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Split out helpers from target_setup_frame and target_restore_sigframe
for dealing with general registers, fpsimd registers, and the end record.

When we add support for sve registers, the relative positions of
these will change.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180303143823.27055-3-richard.henderson@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/signal.c | 120 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 51 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 4d3f244612..761d6acbf3 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1465,16 +1465,17 @@ struct target_rt_sigframe {
     uint32_t tramp[2];
 };
 
-static int target_setup_sigframe(struct target_rt_sigframe *sf,
-                                 CPUARMState *env, target_sigset_t *set)
+static void target_setup_general_frame(struct target_rt_sigframe *sf,
+                                       CPUARMState *env, target_sigset_t *set)
 {
     int i;
-    struct target_aux_context *aux =
-        (struct target_aux_context *)sf->uc.tuc_mcontext.__reserved;
 
-    /* set up the stack frame for unwinding */
-    __put_user(env->xregs[29], &sf->fp);
-    __put_user(env->xregs[30], &sf->lr);
+    __put_user(0, &sf->uc.tuc_flags);
+    __put_user(0, &sf->uc.tuc_link);
+
+    __put_user(target_sigaltstack_used.ss_sp, &sf->uc.tuc_stack.ss_sp);
+    __put_user(sas_ss_flags(env->xregs[31]), &sf->uc.tuc_stack.ss_flags);
+    __put_user(target_sigaltstack_used.ss_size, &sf->uc.tuc_stack.ss_size);
 
     for (i = 0; i < 31; i++) {
         __put_user(env->xregs[i], &sf->uc.tuc_mcontext.regs[i]);
@@ -1488,39 +1489,42 @@ static int target_setup_sigframe(struct target_rt_sigframe *sf,
     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &sf->uc.tuc_sigmask.sig[i]);
     }
+}
+
+static void target_setup_fpsimd_record(struct target_fpsimd_context *fpsimd,
+                                       CPUARMState *env)
+{
+    int i;
+
+    __put_user(TARGET_FPSIMD_MAGIC, &fpsimd->head.magic);
+    __put_user(sizeof(struct target_fpsimd_context), &fpsimd->head.size);
+    __put_user(vfp_get_fpsr(env), &fpsimd->fpsr);
+    __put_user(vfp_get_fpcr(env), &fpsimd->fpcr);
 
     for (i = 0; i < 32; i++) {
         uint64_t *q = aa64_vfp_qreg(env, i);
 #ifdef TARGET_WORDS_BIGENDIAN
-        __put_user(q[0], &aux->fpsimd.vregs[i * 2 + 1]);
-        __put_user(q[1], &aux->fpsimd.vregs[i * 2]);
+        __put_user(q[0], &fpsimd->vregs[i * 2 + 1]);
+        __put_user(q[1], &fpsimd->vregs[i * 2]);
 #else
-        __put_user(q[0], &aux->fpsimd.vregs[i * 2]);
-        __put_user(q[1], &aux->fpsimd.vregs[i * 2 + 1]);
+        __put_user(q[0], &fpsimd->vregs[i * 2]);
+        __put_user(q[1], &fpsimd->vregs[i * 2 + 1]);
 #endif
     }
-    __put_user(vfp_get_fpsr(env), &aux->fpsimd.fpsr);
-    __put_user(vfp_get_fpcr(env), &aux->fpsimd.fpcr);
-    __put_user(TARGET_FPSIMD_MAGIC, &aux->fpsimd.head.magic);
-    __put_user(sizeof(struct target_fpsimd_context),
-            &aux->fpsimd.head.size);
-
-    /* set the "end" magic */
-    __put_user(0, &aux->end.magic);
-    __put_user(0, &aux->end.size);
-
-    return 0;
 }
 
-static int target_restore_sigframe(CPUARMState *env,
-                                   struct target_rt_sigframe *sf)
+static void target_setup_end_record(struct target_aarch64_ctx *end)
+{
+    __put_user(0, &end->magic);
+    __put_user(0, &end->size);
+}
+
+static void target_restore_general_frame(CPUARMState *env,
+                                         struct target_rt_sigframe *sf)
 {
     sigset_t set;
-    int i;
-    struct target_aux_context *aux =
-        (struct target_aux_context *)sf->uc.tuc_mcontext.__reserved;
-    uint32_t magic, size, fpsr, fpcr;
     uint64_t pstate;
+    int i;
 
     target_to_host_sigset(&set, &sf->uc.tuc_sigmask);
     set_sigmask(&set);
@@ -1533,30 +1537,48 @@ static int target_restore_sigframe(CPUARMState *env,
     __get_user(env->pc, &sf->uc.tuc_mcontext.pc);
     __get_user(pstate, &sf->uc.tuc_mcontext.pstate);
     pstate_write(env, pstate);
+}
 
-    __get_user(magic, &aux->fpsimd.head.magic);
-    __get_user(size, &aux->fpsimd.head.size);
+static void target_restore_fpsimd_record(CPUARMState *env,
+                                         struct target_fpsimd_context *fpsimd)
+{
+    uint32_t fpsr, fpcr;
+    int i;
 
-    if (magic != TARGET_FPSIMD_MAGIC
-        || size != sizeof(struct target_fpsimd_context)) {
-        return 1;
-    }
+    __get_user(fpsr, &fpsimd->fpsr);
+    vfp_set_fpsr(env, fpsr);
+    __get_user(fpcr, &fpsimd->fpcr);
+    vfp_set_fpcr(env, fpcr);
 
     for (i = 0; i < 32; i++) {
         uint64_t *q = aa64_vfp_qreg(env, i);
 #ifdef TARGET_WORDS_BIGENDIAN
-        __get_user(q[0], &aux->fpsimd.vregs[i * 2 + 1]);
-        __get_user(q[1], &aux->fpsimd.vregs[i * 2]);
+        __get_user(q[0], &fpsimd->vregs[i * 2 + 1]);
+        __get_user(q[1], &fpsimd->vregs[i * 2]);
 #else
-        __get_user(q[0], &aux->fpsimd.vregs[i * 2]);
-        __get_user(q[1], &aux->fpsimd.vregs[i * 2 + 1]);
+        __get_user(q[0], &fpsimd->vregs[i * 2]);
+        __get_user(q[1], &fpsimd->vregs[i * 2 + 1]);
 #endif
     }
-    __get_user(fpsr, &aux->fpsimd.fpsr);
-    vfp_set_fpsr(env, fpsr);
-    __get_user(fpcr, &aux->fpsimd.fpcr);
-    vfp_set_fpcr(env, fpcr);
+}
 
+static int target_restore_sigframe(CPUARMState *env,
+                                   struct target_rt_sigframe *sf)
+{
+    struct target_aux_context *aux
+        = (struct target_aux_context *)sf->uc.tuc_mcontext.__reserved;
+    uint32_t magic, size;
+
+    target_restore_general_frame(env, sf);
+
+    __get_user(magic, &aux->fpsimd.head.magic);
+    __get_user(size, &aux->fpsimd.head.size);
+    if (magic == TARGET_FPSIMD_MAGIC
+        && size == sizeof(struct target_fpsimd_context)) {
+        target_restore_fpsimd_record(env, &aux->fpsimd);
+    } else {
+        return 1;
+    }
     return 0;
 }
 
@@ -1583,6 +1605,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                CPUARMState *env)
 {
     struct target_rt_sigframe *frame;
+    struct target_aux_context *aux;
     abi_ulong frame_addr, return_addr;
 
     frame_addr = get_sigframe(ka, env);
@@ -1590,17 +1613,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
+    aux = (struct target_aux_context *)frame->uc.tuc_mcontext.__reserved;
 
-    __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, &frame->uc.tuc_link);
+    target_setup_general_frame(frame, env, set);
+    target_setup_fpsimd_record(&aux->fpsimd, env);
+    target_setup_end_record(&aux->end);
 
-    __put_user(target_sigaltstack_used.ss_sp,
-                      &frame->uc.tuc_stack.ss_sp);
-    __put_user(sas_ss_flags(env->xregs[31]),
-                      &frame->uc.tuc_stack.ss_flags);
-    __put_user(target_sigaltstack_used.ss_size,
-                      &frame->uc.tuc_stack.ss_size);
-    target_setup_sigframe(frame, env, set);
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         return_addr = ka->sa_restorer;
     } else {
-- 
2.16.2
