Received: from eggs.gnu.org ([2001:4830:134:3::10]:40504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekyiG-0006uy-HG
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekyiE-0004O8-Ax
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:59:04 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekyiD-0004MX-Ph
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:59:02 -0500
Received: by mail-pg0-x242.google.com with SMTP id o1so6150600pgn.4
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 12:59:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 11 Feb 2018 12:58:47 -0800
Message-Id: <20180211205848.4568-7-richard.henderson@linaro.org>
In-Reply-To: <20180211205848.4568-1-richard.henderson@linaro.org>
References: <20180211205848.4568-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 6/7] linux-user: Support SVE in aarch64
 signal frames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 348 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 283 insertions(+), 65 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 9a380b9e31..af953175db 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1443,35 +1443,61 @@ struct target_fpsimd_context {
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
+#define TARGET_EXTRA_MAGIC  0x45585401
+
+struct target_extra_context {
+    struct target_aarch64_ctx head;
+    uint64_t datap; /* 16-byte aligned pointer to extra space cast to __u64 */
+    uint32_t size; /* size in bytes of the extra space */
+    uint32_t reserved[3];
+};
+
+#define TARGET_SVE_MAGIC    0x53564501
+
+struct target_sve_context {
+    struct target_aarch64_ctx head;
+    uint16_t vl;
+    uint16_t reserved[3];
 };
 
+#define TARGET_SVE_VQ_BYTES  16
+
+#define TARGET_SVE_SIG_ZREG_SIZE(VQ)  ((VQ) * TARGET_SVE_VQ_BYTES)
+#define TARGET_SVE_SIG_PREG_SIZE(VQ)  ((VQ) * (TARGET_SVE_VQ_BYTES / 8))
+
+#define TARGET_SVE_SIG_REGS_OFFSET \
+    QEMU_ALIGN_UP(sizeof(struct target_sve_context), TARGET_SVE_VQ_BYTES)
+#define TARGET_SVE_SIG_ZREG_OFFSET(VQ, N) \
+    (TARGET_SVE_SIG_REGS_OFFSET + TARGET_SVE_SIG_ZREG_SIZE(VQ) * (N))
+#define TARGET_SVE_SIG_PREG_OFFSET(VQ, N) \
+    (TARGET_SVE_SIG_ZREG_OFFSET(VQ, 32) + TARGET_SVE_SIG_PREG_SIZE(VQ) * (N))
+#define TARGET_SVE_SIG_FFR_OFFSET(VQ) \
+    (TARGET_SVE_SIG_PREG_OFFSET(VQ, 16))
+#define TARGET_SVE_SIG_CONTEXT_SIZE(VQ) \
+    (TARGET_SVE_SIG_PREG_OFFSET(VQ, 17))
+
 struct target_rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
+};
+
+struct target_rt_frame_record {
     uint64_t fp;
     uint64_t lr;
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
@@ -1485,39 +1511,79 @@ static int target_setup_sigframe(struct target_rt_sigframe *sf,
     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &sf->uc.tuc_sigmask.sig[i]);
     }
+}
+
+static void target_setup_end_record(struct target_aarch64_ctx *end)
+{
+    __put_user(0, &end->magic);
+    __put_user(0, &end->size);
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
+}
 
-    /* set the "end" magic */
-    __put_user(0, &aux->end.magic);
-    __put_user(0, &aux->end.size);
+static void target_setup_extra_record(struct target_extra_context *extra,
+                                      uint64_t datap, uint32_t extra_size)
+{
+    __put_user(TARGET_EXTRA_MAGIC, &extra->head.magic);
+    __put_user(sizeof(struct target_extra_context), &extra->head.size);
+    __put_user(datap, &extra->datap);
+    __put_user(extra_size, &extra->size);
+}
 
-    return 0;
+static void target_setup_sve_record(struct target_sve_context *sve,
+                                    CPUARMState *env, int vq, int size)
+{
+    int i, j;
+
+    __put_user(TARGET_SVE_MAGIC, &sve->head.magic);
+    __put_user(size, &sve->head.size);
+    __put_user(vq * TARGET_SVE_VQ_BYTES, &sve->vl);
+
+    /* Note that SVE regs are stored as a byte stream, with each byte element
+     * at a subsequent address.  This corresponds to a little-endian store
+     * of our 64-bit hunks.
+     */
+    for (i = 0; i < 32; ++i) {
+        uint64_t *z = (void *)sve + TARGET_SVE_SIG_ZREG_OFFSET(vq, i);
+        for (j = 0; j < vq * 2; ++j) {
+            __put_user_e(env->vfp.zregs[i].d[j], z + j, le);
+        }
+    }
+    for (i = 0; i <= 16; ++i) {
+        uint16_t *p = (void *)sve + TARGET_SVE_SIG_PREG_OFFSET(vq, i);
+        for (j = 0; j < vq; ++j) {
+            uint64_t r = env->vfp.pregs[i].p[j >> 2];
+            __put_user_e(r >> ((j & 3) * 16), p + j, le);
+        }
+    }
 }
 
-static int target_restore_sigframe(CPUARMState *env,
-                                   struct target_rt_sigframe *sf)
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
@@ -1530,34 +1596,134 @@ static int target_restore_sigframe(CPUARMState *env,
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
+
+static void target_restore_sve_record(CPUARMState *env,
+                                      struct target_sve_context *sve, int vq)
+{
+    int i, j;
+
+    /* Note that SVE regs are stored as a byte stream, with each byte element
+     * at a subsequent address.  This corresponds to a little-endian store
+     * of our 64-bit hunks.
+     */
+    for (i = 0; i < 32; ++i) {
+        uint64_t *z = (void *)sve + TARGET_SVE_SIG_ZREG_OFFSET(vq, i);
+        for (j = 0; j < vq * 2; ++j) {
+            __get_user_e(env->vfp.zregs[i].d[j], z + j, le);
+        }
+    }
+    for (i = 0; i <= 16; ++i) {
+        uint16_t *p = (void *)sve + TARGET_SVE_SIG_PREG_OFFSET(vq, i);
+        for (j = 0; j < vq; ++j) {
+            uint16_t r;
+            __get_user_e(r, p + j, le);
+            if (j & 3) {
+                env->vfp.pregs[i].p[j >> 2] |= (uint64_t)r << ((j & 3) * 16);
+            } else {
+                env->vfp.pregs[i].p[j >> 2] = r;
+            }
+        }
+    }
+}
+
+static int target_restore_sigframe(CPUARMState *env,
+                                   struct target_rt_sigframe *sf)
+{
+    struct target_aarch64_ctx *ctx, *extra = NULL;
+    struct target_fpsimd_context *fpsimd = NULL;
+    struct target_sve_context *sve = NULL;
+    int vq = 0, sve_size = 0;
+
+    target_restore_general_frame(env, sf);
+
+    ctx = (struct target_aarch64_ctx *)sf->uc.tuc_mcontext.__reserved;
+    while (ctx) {
+        uint32_t magic, size;
+
+        __get_user(magic, &ctx->magic);
+        __get_user(size, &ctx->size);
+        switch (magic) {
+        case TARGET_FPSIMD_MAGIC:
+            if (fpsimd || size != sizeof(struct target_fpsimd_context)) {
+                return 1;
+            }
+            fpsimd = (struct target_fpsimd_context *)ctx;
+            break;
+
+        case TARGET_SVE_MAGIC:
+            if (arm_feature(env, ARM_FEATURE_SVE)) {
+                vq = (env->vfp.zcr_el[1] & 0xf) + 1;
+                sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
+                if (!sve && size == sve_size) {
+                    sve = (struct target_sve_context *)ctx;
+                    break;
+                }
+            }
+            return 1;
+
+        case TARGET_EXTRA_MAGIC:
+            if (size != sizeof(struct target_extra_context)) {
+                return 1;
+            }
+            extra = (void *)((struct target_extra_context *)ctx)->datap;
+            break;
+
+        default:
+            /* Unknown record -- we certainly didn't generate it.
+               Did we in fact get out of sync?  */
+            return 1;
+
+        case 0:
+            if (size != 0) {
+                return 1;
+            }
+            ctx = extra;
+            extra = NULL;
+            continue;
+        }
+        ctx = (void *)ctx + size;
+    }
+
+    /* Require FPSIMD always, since we always restore FPSR/FPCR from there.  */
+    if (!fpsimd) {
+        return 1;
+    }
+    target_restore_fpsimd_record(env, fpsimd);
+
+    /* SVE data, if present, overwrites FPSIMD data.  */
+    if (sve) {
+        target_restore_sve_record(env, sve, vq);
+    }
 
     return 0;
 }
 
-static abi_ulong get_sigframe(struct target_sigaction *ka, CPUARMState *env)
+static abi_ulong get_sigframe(struct target_sigaction *ka,
+                              CPUARMState *env, int size)
 {
     abi_ulong sp;
 
@@ -1570,7 +1736,7 @@ static abi_ulong get_sigframe(struct target_sigaction *ka, CPUARMState *env)
         sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
     }
 
-    sp = (sp - sizeof(struct target_rt_sigframe)) & ~15;
+    sp = (sp - size) & ~15;
 
     return sp;
 }
@@ -1579,25 +1745,76 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                target_siginfo_t *info, target_sigset_t *set,
                                CPUARMState *env)
 {
+    int std_size = sizeof(struct target_rt_sigframe);
+    int size = offsetof(struct target_rt_sigframe, uc.tuc_mcontext.__reserved);
+    int fpsimd_ofs, end1_ofs, fr_ofs;
+    int sve_ofs = 0, extra_ofs = 0, end2_ofs = 0;
+    int vq = 0, sve_size = 0, extra_size = 0;
     struct target_rt_sigframe *frame;
+    struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
 
-    frame_addr = get_sigframe(ka, env);
+    /* Reserve space for standard exit marker.  */
+    std_size -= sizeof(struct target_aarch64_ctx);
+
+    /* FPSIMD record is always in the standard space.  */
+    fpsimd_ofs = size;
+    size += sizeof(struct target_fpsimd_context);
+    end1_ofs = size;
+
+    /* SVE state needs saving only if it exists.  */
+    if (arm_feature(env, ARM_FEATURE_SVE)) {
+        vq = (env->vfp.zcr_el[1] & 0xf) + 1;
+        sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
+
+        /* For VQ <= 6, there is room in the standard space.  */
+        if (sve_size <= std_size) {
+            sve_ofs = size;
+            size += sve_size;
+            end1_ofs = size;
+        } else {
+            /* Otherwise we need to allocate extra space.  */
+            extra_ofs = size;
+            size += sizeof(struct target_extra_context);
+            end1_ofs = size;
+            size += QEMU_ALIGN_UP(sizeof(struct target_aarch64_ctx), 16);
+
+            extra_size = sve_size + sizeof(struct target_aarch64_ctx);
+            sve_ofs = size;
+            size += sve_size;
+            end2_ofs = size;
+        }
+    }
+    size += sizeof(struct target_aarch64_ctx);
+
+    fr_ofs = size;
+    size += sizeof(struct target_rt_frame_record);
+
+    frame_addr = get_sigframe(ka, env, size);
     trace_user_setup_frame(env, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
     }
 
-    __put_user(0, &frame->uc.tuc_flags);
-    __put_user(0, &frame->uc.tuc_link);
+    target_setup_general_frame(frame, env, set);
+    target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
+    if (extra_ofs) {
+        target_setup_extra_record((void *)frame + extra_ofs,
+                                  frame_addr + sve_ofs, extra_size);
+    }
+    target_setup_end_record((void *)frame + end1_ofs);
+    if (sve_ofs) {
+        target_setup_sve_record((void *)frame + sve_ofs, env, vq, sve_size);
+    }
+    if (end2_ofs) {
+        target_setup_end_record((void *)frame + end2_ofs);
+    }
+
+    /* set up the stack frame for unwinding */
+    fr = (void *)frame + fr_ofs;
+    __put_user(env->xregs[29], &fr->fp);
+    __put_user(env->xregs[30], &fr->lr);
 
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
@@ -1606,13 +1823,14 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
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
2.14.3
