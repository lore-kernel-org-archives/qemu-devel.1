Received: from eggs.gnu.org ([2001:4830:134:3::10]:40742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1emnzS-0006nh-Rt
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1emnzR-0007Qq-FY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:22 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1emnzR-0007Qa-74
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:56:21 -0500
Received: by mail-pg0-x242.google.com with SMTP id l24so3444121pgc.5
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 13:56:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Feb 2018 13:56:08 -0800
Message-Id: <20180216215608.13227-6-richard.henderson@linaro.org>
In-Reply-To: <20180216215608.13227-1-richard.henderson@linaro.org>
References: <20180216215608.13227-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 5/5] aarch64-linux-user: Add support for SVE
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
Cc: peter.maydell@linaro.org

Depending on the currently selected size of the SVE vector registers,
we can either store the data within the "standard" allocation, or we
may beedn to allocate additional space with an EXTRA record.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 3 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index ca0ba28c98..4c9fef4bb2 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1452,6 +1452,30 @@ struct target_extra_context {
     uint32_t reserved[3];
 };
 
+#define TARGET_SVE_MAGIC    0x53564501
+
+struct target_sve_context {
+    struct target_aarch64_ctx head;
+    uint16_t vl;
+    uint16_t reserved[3];
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
@@ -1526,6 +1550,34 @@ static void target_setup_end_record(struct target_aarch64_ctx *end)
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
@@ -1569,13 +1621,44 @@ static void target_restore_fpsimd_record(CPUARMState *env,
     }
 }
 
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
 static int target_restore_sigframe(CPUARMState *env,
                                    struct target_rt_sigframe *sf)
 {
     struct target_aarch64_ctx *ctx, *extra = NULL;
     struct target_fpsimd_context *fpsimd = NULL;
+    struct target_sve_context *sve = NULL;
     uint64_t extra_datap = 0;
     bool used_extra = false;
+    int vq = 0, sve_size = 0;
 
     target_restore_general_frame(env, sf);
 
@@ -1605,6 +1688,17 @@ static int target_restore_sigframe(CPUARMState *env,
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
+            return 1;
+
         case TARGET_EXTRA_MAGIC:
             if (extra || size != sizeof(struct target_extra_context)) {
                 return 1;
@@ -1631,13 +1725,19 @@ static int target_restore_sigframe(CPUARMState *env,
     }
     target_restore_fpsimd_record(env, fpsimd);
 
+    /* SVE data, if present, overwrites FPSIMD data.  */
+    if (sve) {
+        target_restore_sve_record(env, sve, vq);
+    }
+
     if (extra) {
         unlock_user(extra, extra_datap, 0);
     }
     return 0;
 }
 
-static abi_ulong get_sigframe(struct target_sigaction *ka, CPUARMState *env)
+static abi_ulong get_sigframe(struct target_sigaction *ka,
+                              CPUARMState *env, int size)
 {
     abi_ulong sp;
 
@@ -1650,7 +1750,7 @@ static abi_ulong get_sigframe(struct target_sigaction *ka, CPUARMState *env)
         sp = target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
     }
 
-    sp = (sp - sizeof(struct target_rt_sigframe)) & ~15;
+    sp = (sp - size) & ~15;
 
     return sp;
 }
@@ -1659,21 +1759,53 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                target_siginfo_t *info, target_sigset_t *set,
                                CPUARMState *env)
 {
+    int std_size = sizeof(struct target_rt_sigframe);
     int size = offsetof(struct target_rt_sigframe, uc.tuc_mcontext.__reserved);
     int fpsimd_ofs, end1_ofs, fr_ofs, end2_ofs = 0;
     int extra_ofs = 0, extra_base = 0, extra_size = 0;
+    int sve_ofs = 0, vq = 0, sve_size = 0;
     struct target_rt_sigframe *frame;
     struct target_rt_frame_record *fr;
     abi_ulong frame_addr, return_addr;
 
+    /* Reserve space for standard exit marker.  */
+    std_size -= sizeof(struct target_aarch64_ctx);
+
+    /* FPSIMD record is always in the standard space.  */
     fpsimd_ofs = size;
     size += sizeof(struct target_fpsimd_context);
     end1_ofs = size;
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
+            extra_base = size;
+            extra_size = sve_size + sizeof(struct target_aarch64_ctx);
+
+            sve_ofs = size;
+            size += sve_size;
+            end2_ofs = size;
+        }
+    }
     size += sizeof(struct target_aarch64_ctx);
+
     fr_ofs = size;
     size += sizeof(struct target_rt_frame_record);
 
-    frame_addr = get_sigframe(ka, env);
+    frame_addr = get_sigframe(ka, env, size);
     trace_user_setup_frame(env, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
         goto give_sigsegv;
@@ -1686,6 +1818,9 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
                                   frame_addr + extra_base, extra_size);
     }
     target_setup_end_record((void *)frame + end1_ofs);
+    if (sve_ofs) {
+        target_setup_sve_record((void *)frame + sve_ofs, env, vq, sve_size);
+    }
     if (end2_ofs) {
         target_setup_end_record((void *)frame + end2_ofs);
     }
-- 
2.14.3
