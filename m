Received: from eggs.gnu.org ([209.51.188.92]:34364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r6-4Q
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9en-0006jl-Pt
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9el-0006TW-91
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id z6so392902wmi.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.56
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:08 +0100
Message-Id: <20190429170030.11323-21-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/42] target/arm: Overlap VECSTRIDE and
 XSCALE_CPAR TB flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We are close to running out of TB flags for AArch32; we could
start using the cs_base word, but before we do that we can
economise on our usage by sharing the same bits for the VFP
VECSTRIDE field and the XScale XSCALE_CPAR field. This
works because no XScale CPU ever had VFP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-18-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 10 ++++++----
 target/arm/cpu.c       |  7 +++++++
 target/arm/helper.c    |  6 +++++-
 target/arm/translate.c |  9 +++++++--
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0ea448034b3..99ccb4824d4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3138,6 +3138,12 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
 FIELD(TBFLAG_A32, THUMB, 0, 1)
 FIELD(TBFLAG_A32, VECLEN, 1, 3)
 FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)
+/*
+ * We store the bottom two bits of the CPAR as TB flags and handle
+ * checks on the other bits at runtime. This shares the same bits as
+ * VECSTRIDE, which is OK as no XScale CPU has VFP.
+ */
+FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
 /*
  * Indicates whether cp register reads and writes by guest code should access
  * the secure or nonsecure bank of banked registers; note that this is not
@@ -3147,10 +3153,6 @@ FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
-/* We store the bottom two bits of the CPAR as TB flags and handle
- * checks on the other bits at runtime
- */
-FIELD(TBFLAG_A32, XSCALE_CPAR, 17, 2)
 /* For M profile only, Handler (ie not Thread) mode */
 FIELD(TBFLAG_A32, HANDLER, 21, 1)
 /* For M profile only, whether we should generate stack-limit checks */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index be81e197ee9..7deccda2404 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1034,6 +1034,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         set_feature(env, ARM_FEATURE_THUMB_DSP);
     }
 
+    /*
+     * We rely on no XScale CPU having VFP so we can use the same bits in the
+     * TB flags field for VECSTRIDE and XSCALE_CPAR.
+     */
+    assert(!(arm_feature(env, ARM_FEATURE_VFP) &&
+             arm_feature(env, ARM_FEATURE_XSCALE)));
+
     if (arm_feature(env, ARM_FEATURE_V7) &&
         !arm_feature(env, ARM_FEATURE_M) &&
         !arm_feature(env, ARM_FEATURE_PMSA)) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 14604f49a4c..9be5fe581df 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13370,7 +13370,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
-        flags = FIELD_DP32(flags, TBFLAG_A32, XSCALE_CPAR, env->cp15.c15_cpar);
+        /* Note that XSCALE_CPAR shares bits with VECSTRIDE */
+        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
+            flags = FIELD_DP32(flags, TBFLAG_A32,
+                               XSCALE_CPAR, env->cp15.c15_cpar);
+        }
     }
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(mmu_idx));
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0747f7847a9..ffaa4f1e095 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -13330,8 +13330,13 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->fp_excp_el = FIELD_EX32(tb_flags, TBFLAG_ANY, FPEXC_EL);
     dc->vfp_enabled = FIELD_EX32(tb_flags, TBFLAG_A32, VFPEN);
     dc->vec_len = FIELD_EX32(tb_flags, TBFLAG_A32, VECLEN);
-    dc->vec_stride = FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRIDE);
-    dc->c15_cpar = FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPAR);
+    if (arm_feature(env, ARM_FEATURE_XSCALE)) {
+        dc->c15_cpar = FIELD_EX32(tb_flags, TBFLAG_A32, XSCALE_CPAR);
+        dc->vec_stride = 0;
+    } else {
+        dc->vec_stride = FIELD_EX32(tb_flags, TBFLAG_A32, VECSTRIDE);
+        dc->c15_cpar = 0;
+    }
     dc->v7m_handler_mode = FIELD_EX32(tb_flags, TBFLAG_A32, HANDLER);
     dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         regime_is_secure(env, dc->mmu_idx);
-- 
2.20.1
