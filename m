Received: from eggs.gnu.org ([2001:4830:134:3::10]:59590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmt-0008Q0-Jx
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLms-00065R-59
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmr-00063U-TB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmm-00075E-CJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:05 +0000
Message-Id: <20180309172622.4277-9-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/25] aarch64-linux-user: Remove struct
 target_aux_context
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

This changes the qemu signal frame layout to be more like the kernel's,
in that the various records are dynamically allocated rather than fixed
in place by a structure.

For now, all of the allocation is out of uc.tuc_mcontext.__reserved,
so the allocation is actually trivial.  That will change with SVE support.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180303143823.27055-4-richard.henderson@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/signal.c | 89 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 28 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 761d6acbf3..0f2b155c33 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1446,20 +1446,12 @@ struct target_fpsimd_context {
     uint64_t vregs[32 * 2]; /* really uint128_t vregs[32] */
 };
 
-/*
- * Auxiliary context saved in the sigcontext.__reserved array. Not exported to
- * user space as it will change with the addition of new context. User space
- * should check the magic/size information.
- */
-struct target_aux_context {
-    struct target_fpsimd_context fpsimd;
-    /* additional context to be added before "end" */
-    struct target_aarch64_ctx end;
-};
-
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
+};
+
+struct target_rt_frame_record {
     uint64_t fp;
     uint64_t lr;
     uint32_t tramp[2];
@@ -1565,20 +1557,47 @@ static void target_restore_fpsimd_record(CPUARMState *env,
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
-    struct target_aux_context *aux
-        = (struct target_aux_context *)sf->uc.tuc_mcontext.__reserved;
-    uint32_t magic, size;
+    struct target_aarch64_ctx *ctx;
+    struct target_fpsimd_context *fpsimd = NULL;
 
     target_restore_general_frame(env, sf);
 
-    __get_user(magic, &aux->fpsimd.head.magic);
-    __get_user(size, &aux->fpsimd.head.size);
-    if (magic == TARGET_FPSIMD_MAGIC
-        && size == sizeof(struct target_fpsimd_context)) {
-        target_restore_fpsimd_record(env, &aux->fpsimd);
-    } else {
+    ctx = (struct target_aarch64_ctx *)sf->uc.tuc_mcontext.__reserved;
+    while (ctx) {
+        uint32_t magic, size;
+
+        __get_user(magic, &ctx->magic);
+        __get_user(size, &ctx->size);
+        switch (magic) {
+        case 0:
+            if (size != 0) {
+                return 1;
+            }
+            ctx = NULL;
+            continue;
+
+        case TARGET_FPSIMD_MAGIC:
+            if (fpsimd || size != sizeof(struct target_fpsimd_context)) {
+                return 1;
+            }
+            fpsimd = (struct target_fpsimd_context *)ctx;
+            break;
+
+        default:
+            /* Unknown record -- we certainly didn't generate it.
+             * Did we in fact get out of sync?
+             */
+            return 1;
+        }
+        ctx = (void *)ctx + size;
+    }
+
+    /* Require FPSIMD always.  */
+    if (!fpsimd) {
         return 1;
     }
+    target_restore_fpsimd_record(env, fpsimd);
+
     return 0;
 }
 
@@ -1604,20 +1623,33 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                target_siginfo_t *info, target_sigset_t *set,
                                CPUARMState *env)
 {
+    int size = offsetof(struct target_rt_sigframe, uc.tuc_mcontext.__reserved);
+    int fpsimd_ofs, end1_ofs, fr_ofs;
     struct target_rt_sigframe *frame;
-    struct target_aux_context *aux;
+    struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
 
+    fpsimd_ofs = size;
+    size += sizeof(struct target_fpsimd_context);
+    end1_ofs = size;
+    size += sizeof(struct target_aarch64_ctx);
+    fr_ofs = size;
+    size += sizeof(struct target_rt_frame_record);
+
     frame_addr = get_sigframe(ka, env);
     trace_user_setup_frame(env, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
-    aux = (struct target_aux_context *)frame->uc.tuc_mcontext.__reserved;
 
     target_setup_general_frame(frame, env, set);
-    target_setup_fpsimd_record(&aux->fpsimd, env);
-    target_setup_end_record(&aux->end);
+    target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
+    target_setup_end_record((void *)frame + end1_ofs);
+
+    /* Set up the stack frame for unwinding.  */
+    fr = (void *)frame + fr_ofs;
+    __put_user(env->xregs[29], &fr->fp);
+    __put_user(env->xregs[30], &fr->lr);
 
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         return_addr = ka->sa_restorer;
@@ -1627,13 +1659,14 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
          * Since these are instructions they need to be put as little-endian
          * regardless of target default or current CPU endianness.
          */
-        __put_user_e(0xd2801168, &frame->tramp[0], le);
-        __put_user_e(0xd4000001, &frame->tramp[1], le);
-        return_addr = frame_addr + offsetof(struct target_rt_sigframe, tramp);
+        __put_user_e(0xd2801168, &fr->tramp[0], le);
+        __put_user_e(0xd4000001, &fr->tramp[1], le);
+        return_addr = frame_addr + fr_ofs
+            + offsetof(struct target_rt_frame_record, tramp);
     }
     env->xregs[0] = usig;
     env->xregs[31] = frame_addr;
-    env->xregs[29] = env->xregs[31] + offsetof(struct target_rt_sigframe, fp);
+    env->xregs[29] = frame_addr + fr_ofs;
     env->pc = ka->_sa_handler;
     env->xregs[30] = return_addr;
     if (info) {
-- 
2.16.2
