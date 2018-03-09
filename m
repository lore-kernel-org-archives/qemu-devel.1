Received: from eggs.gnu.org ([2001:4830:134:3::10]:59562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLms-0008Or-Kw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmq-00064L-Rg
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:34 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1euLmq-00060G-Gu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:26:32 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1euLmn-00075g-N4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:26:29 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Mar 2018 17:26:07 +0000
Message-Id: <20180309172622.4277-11-peter.maydell@linaro.org>
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/25] aarch64-linux-user: Add support for SVE
 signal frame records
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

Depending on the currently selected size of the SVE vector registers,
we can either store the data within the "standard" allocation, or we
may beedn to allocate additional space with an EXTRA record.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180303143823.27055-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/signal.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 192 insertions(+), 18 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index f8bc0aa397..2ce5d7a3c7 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1455,6 +1455,34 @@ struct target_extra_context {
     uint32_t reserved[3];
 };
 
+#define TARGET_SVE_MAGIC    0x53564501
+
+struct target_sve_context {
+    struct target_aarch64_ctx head;
+    uint16_t vl;
+    uint16_t reserved[3];
+    /* The actual SVE data immediately follows.  It is layed out
+     * according to TARGET_SVE_SIG_{Z,P}REG_OFFSET, based off of
+     * the original struct pointer.
+     */
+};
+
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
@@ -1529,6 +1557,34 @@ static void target_setup_end_record(struct target_aarch64_ctx *end)
     __put_user(0, &end->size);
 }
 
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
+}
+
 static void target_restore_general_frame(CPUARMState *env,
                                          struct target_rt_sigframe *sf)
 {
@@ -1572,14 +1628,45 @@ static void target_restore_fpsimd_record(CPUARMState *env,
     }
 }
 
+static void target_restore_sve_record(CPUARMState *env,
+                                      struct target_sve_context *sve, int vq)
+{
+    int i, j;
+
+    /* Note that SVE regs are stored as a byte stream, with each byte element
+     * at a subsequent address.  This corresponds to a little-endian load
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
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
     struct target_aarch64_ctx *ctx, *extra = NULL;
     struct target_fpsimd_context *fpsimd = NULL;
+    struct target_sve_context *sve = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
     bool err = false;
+    int vq = 0, sve_size = 0;
 
     target_restore_general_frame(env, sf);
 
@@ -1611,6 +1698,18 @@ static int target_restore_sigframe(CPUARMState *env,
             fpsimd = (struct target_fpsimd_context *)ctx;
             break;
 
+        case TARGET_SVE_MAGIC:
+            if (arm_feature(env, ARM_FEATURE_SVE)) {
+                vq = (env->vfp.zcr_el[1] & 0xf) + 1;
+                sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
+                if (!sve && size == sve_size) {
+                    sve = (struct target_sve_context *)ctx;
+                    break;
+                }
+            }
+            err = true;
+            goto exit;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 err = true;
@@ -1640,12 +1739,18 @@ static int target_restore_sigframe(CPUARMState *env,
         err = true;
     }
 
+    /* SVE data, if present, overwrites FPSIMD data.  */
+    if (sve) {
+        target_restore_sve_record(env, sve, vq);
+    }
+
  exit:
     unlock_user(extra, extra_datap, 0);
     return err;
 }
 
-static abi_ulong get_sigframe(struct target_sigaction *ka, CPUARMState *env)
+static abi_ulong get_sigframe(struct target_sigaction *ka,
+                              CPUARMState *env, int size)
 {
     abi_ulong sp;
 
@@ -1658,30 +1763,97 @@ static abi_ulong get_sigframe(struct target_sigaction *ka, CPUARMState *env)
         sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
     }
 
-    sp = (sp - sizeof(struct target_rt_sigframe)) & ~15;
+    sp = (sp - size) & ~15;
 
     return sp;
 }
 
+typedef struct {
+    int total_size;
+    int extra_base;
+    int extra_size;
+    int std_end_ofs;
+    int extra_ofs;
+    int extra_end_ofs;
+} target_sigframe_layout;
+
+static int alloc_sigframe_space(int this_size, target_sigframe_layout *l)
+{
+    /* Make sure there will always be space for the end marker.  */
+    const int std_size = sizeof(struct target_rt_sigframe)
+                         - sizeof(struct target_aarch64_ctx);
+    int this_loc = l->total_size;
+
+    if (l->extra_base) {
+        /* Once we have begun an extra space, all allocations go there.  */
+        l->extra_size += this_size;
+    } else if (this_size + this_loc > std_size) {
+        /* This allocation does not fit in the standard space.  */
+        /* Allocate the extra record.  */
+        l->extra_ofs = this_loc;
+        l->total_size += sizeof(struct target_extra_context);
+
+        /* Allocate the standard end record.  */
+        l->std_end_ofs = l->total_size;
+        l->total_size += sizeof(struct target_aarch64_ctx);
+
+        /* Allocate the requested record.  */
+        l->extra_base = this_loc = l->total_size;
+        l->extra_size = this_size;
+    }
+    l->total_size += this_size;
+
+    return this_loc;
+}
+
 static void target_setup_frame(int usig, struct target_sigaction *ka,
                                target_siginfo_t *info, target_sigset_t *set,
                                CPUARMState *env)
 {
-    int size = offsetof(struct target_rt_sigframe, uc.tuc_mcontext.__reserved);
-    int fpsimd_ofs, end1_ofs, fr_ofs, end2_ofs = 0;
-    int extra_ofs = 0, extra_base = 0, extra_size = 0;
+    target_sigframe_layout layout = {
+        /* Begin with the size pointing to the reserved space.  */
+        .total_size = offsetof(struct target_rt_sigframe,
+                               uc.tuc_mcontext.__reserved),
+    };
+    int fpsimd_ofs, fr_ofs, sve_ofs = 0, vq = 0, sve_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
 
-    fpsimd_ofs = size;
-    size += sizeof(struct target_fpsimd_context);
-    end1_ofs = size;
-    size += sizeof(struct target_aarch64_ctx);
-    fr_ofs = size;
-    size += sizeof(struct target_rt_frame_record);
+    /* FPSIMD record is always in the standard space.  */
+    fpsimd_ofs = alloc_sigframe_space(sizeof(struct target_fpsimd_context),
+                                      &layout);
 
-    frame_addr = get_sigframe(ka, env);
+    /* SVE state needs saving only if it exists.  */
+    if (arm_feature(env, ARM_FEATURE_SVE)) {
+        vq = (env->vfp.zcr_el[1] & 0xf) + 1;
+        sve_size = QEMU_ALIGN_UP(TARGET_SVE_SIG_CONTEXT_SIZE(vq), 16);
+        sve_ofs = alloc_sigframe_space(sve_size, &layout);
+    }
+
+    if (layout.extra_ofs) {
+        /* Reserve space for the extra end marker.  The standard end marker
+         * will have been allocated when we allocated the extra record.
+         */
+        layout.extra_end_ofs
+            = alloc_sigframe_space(sizeof(struct target_aarch64_ctx), &layout);
+    } else {
+        /* Reserve space for the standard end marker.
+         * Do not use alloc_sigframe_space because we cheat
+         * std_size therein to reserve space for this.
+         */
+        layout.std_end_ofs = layout.total_size;
+        layout.total_size += sizeof(struct target_aarch64_ctx);
+    }
+
+    /* Reserve space for the return code.  On a real system this would
+     * be within the VDSO.  So, despite the name this is not a "real"
+     * record within the frame.
+     */
+    fr_ofs = layout.total_size;
+    layout.total_size += sizeof(struct target_rt_frame_record);
+
+    frame_addr = get_sigframe(ka, env, layout.total_size);
     trace_user_setup_frame(env, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
@@ -1689,13 +1861,15 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     target_setup_general_frame(frame, env, set);
     target_setup_fpsimd_record((void *)frame + fpsimd_ofs, env);
-    if (extra_ofs) {
-        target_setup_extra_record((void *)frame + extra_ofs,
-                                  frame_addr + extra_base, extra_size);
+    target_setup_end_record((void *)frame + layout.std_end_ofs);
+    if (layout.extra_ofs) {
+        target_setup_extra_record((void *)frame + layout.extra_ofs,
+                                  frame_addr + layout.extra_base,
+                                  layout.extra_size);
+        target_setup_end_record((void *)frame + layout.extra_end_ofs);
     }
-    target_setup_end_record((void *)frame + end1_ofs);
-    if (end2_ofs) {
-        target_setup_end_record((void *)frame + end2_ofs);
+    if (sve_ofs) {
+        target_setup_sve_record((void *)frame + sve_ofs, env, vq, sve_size);
     }
 
     /* Set up the stack frame for unwinding.  */
-- 
2.16.2
