Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5CC20756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb6+X5fQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5CC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYK90-0006Mz-VF
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7V-0004yj-Cq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:25 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYK7T-0005uD-Es
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:26:25 -0400
Received: by mail-pl1-x643.google.com with SMTP id f21so2248346plr.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 19:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pKwAEGss07SFEqvTkuenDxl2hW2mchkMUugv+tWaYr8=;
 b=Pb6+X5fQwVWKsS3DbmfE6X7NPWGv8SEqx+8vr4/g5N2W7xi8DAgrDCwWKO84/WgNjw
 Qu9M0l7Rdd439+CNt0gc3s3OEIyv7P4ivgUG3cUe9m8wvAIpshePRM7qh89w7tReP2UM
 iaEgFSMBekfUkpEJIBfDTzo0CNByF5PW79NYTGewhfQenrLTfjlcdKZXN6MqRz/LzwF5
 vupJHxAcgxpQD/gAD83Nd8Tvfl7caLNua68tX2DbQWteSzrpInIyQgm5pDn19L92zsgw
 lL9epjZYvWKi89N19lFPwmSYlsMsBGmalYK4CBs1cAzH3tbUXpWSCepStgc6EaCh+yQ8
 YEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pKwAEGss07SFEqvTkuenDxl2hW2mchkMUugv+tWaYr8=;
 b=aIeamkedfAj7u0oMKhQL47BYOjYGm5GHdHqT4Rk4/vstdqEMt1DBSB7QP32SyJCy6E
 YO+OpIdpMM7w3Doiforzeky2zXyKiVJ2AFd5ZduLQ4B65udUmiNE46BTEwcgBWsmnGXU
 9dsRz8QRUSd6TOiIxGdmWHcsIQYThiH27LpDFOBDfAZ9LI4l2J7m9EyQm6Sjk9pB800Y
 gxF1/4F1c0U1SFnwTrn/Z2qwY+nRj5M6bTUncAilYgWlqSZW7gy1rSVVUR+HoSBR7iS3
 Lo34NVdvd/yuZF/J40JidkSDCUg3iGNwQdAsMnKFdQIKh/56jbFGMP5k+aIweQ+3xVdn
 qXzg==
X-Gm-Message-State: AOAM5314DKKH9NEShshPkXA0IDumIvsACcLQzFK0uxs20hsShb1VDFUH
 ue6QMi3TIH2XtONx+ObT7B/HTC6mm/YJew==
X-Google-Smtp-Source: ABdhPJz37YwmI8uZx2I6CdTCbtKz+ZVBx2CE8wjGPRXirDTiBN1R8y3ViTJI6dwjq5ZXFmOSB6vc1Q==
X-Received: by 2002:a17:902:fe07:b029:d6:88c5:f5d5 with SMTP id
 g7-20020a170902fe07b02900d688c5f5d5mr6013516plj.63.1604024781479; 
 Thu, 29 Oct 2020 19:26:21 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b7sm4446517pfr.171.2020.10.29.19.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 19:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/11] target/arm: Introduce neon_full_reg_offset
Date: Thu, 29 Oct 2020 19:26:08 -0700
Message-Id: <20201030022618.785675-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030022618.785675-1-richard.henderson@linaro.org>
References: <20201030022618.785675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function makes it clear that we're talking about the whole
register, and not the 32-bit piece at index 0.  This fixes a bug
when running on a big-endian host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c          |  8 ++++++
 target/arm/translate-neon.c.inc | 44 ++++++++++++++++-----------------
 target/arm/translate-vfp.c.inc  |  2 +-
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 38371db540..1b61e50f9c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1094,6 +1094,14 @@ static inline void gen_hlt(DisasContext *s, int imm)
     unallocated_encoding(s);
 }
 
+/*
+ * Return the offset of a "full" NEON Dreg.
+ */
+static long neon_full_reg_offset(unsigned reg)
+{
+    return offsetof(CPUARMState, vfp.zregs[reg >> 1].d[reg & 1]);
+}
+
 static inline long vfp_reg_offset(bool dp, unsigned reg)
 {
     if (dp) {
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 4d1a292981..e259e24c05 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -76,7 +76,7 @@ neon_element_offset(int reg, int element, MemOp size)
         ofs ^= 8 - element_size;
     }
 #endif
-    return neon_reg_offset(reg, 0) + ofs;
+    return neon_full_reg_offset(reg) + ofs;
 }
 
 static void neon_load_element(TCGv_i32 var, int reg, int ele, MemOp mop)
@@ -585,12 +585,12 @@ static bool trans_VLD_all_lanes(DisasContext *s, arg_VLD_all_lanes *a)
              * We cannot write 16 bytes at once because the
              * destination is unaligned.
              */
-            tcg_gen_gvec_dup_i32(size, neon_reg_offset(vd, 0),
+            tcg_gen_gvec_dup_i32(size, neon_full_reg_offset(vd),
                                  8, 8, tmp);
-            tcg_gen_gvec_mov(0, neon_reg_offset(vd + 1, 0),
-                             neon_reg_offset(vd, 0), 8, 8);
+            tcg_gen_gvec_mov(0, neon_full_reg_offset(vd + 1),
+                             neon_full_reg_offset(vd), 8, 8);
         } else {
-            tcg_gen_gvec_dup_i32(size, neon_reg_offset(vd, 0),
+            tcg_gen_gvec_dup_i32(size, neon_full_reg_offset(vd),
                                  vec_size, vec_size, tmp);
         }
         tcg_gen_addi_i32(addr, addr, 1 << size);
@@ -691,9 +691,9 @@ static bool trans_VLDST_single(DisasContext *s, arg_VLDST_single *a)
 static bool do_3same(DisasContext *s, arg_3same *a, GVecGen3Fn fn)
 {
     int vec_size = a->q ? 16 : 8;
-    int rd_ofs = neon_reg_offset(a->vd, 0);
-    int rn_ofs = neon_reg_offset(a->vn, 0);
-    int rm_ofs = neon_reg_offset(a->vm, 0);
+    int rd_ofs = neon_full_reg_offset(a->vd);
+    int rn_ofs = neon_full_reg_offset(a->vn);
+    int rm_ofs = neon_full_reg_offset(a->vm);
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -1177,8 +1177,8 @@ static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 {
     /* Handle a 2-reg-shift insn which can be vectorized. */
     int vec_size = a->q ? 16 : 8;
-    int rd_ofs = neon_reg_offset(a->vd, 0);
-    int rm_ofs = neon_reg_offset(a->vm, 0);
+    int rd_ofs = neon_full_reg_offset(a->vd);
+    int rm_ofs = neon_full_reg_offset(a->vm);
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -1620,8 +1620,8 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
 {
     /* FP operations in 2-reg-and-shift group */
     int vec_size = a->q ? 16 : 8;
-    int rd_ofs = neon_reg_offset(a->vd, 0);
-    int rm_ofs = neon_reg_offset(a->vm, 0);
+    int rd_ofs = neon_full_reg_offset(a->vd);
+    int rm_ofs = neon_full_reg_offset(a->vm);
     TCGv_ptr fpst;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -1756,7 +1756,7 @@ static bool do_1reg_imm(DisasContext *s, arg_1reg_imm *a,
         return true;
     }
 
-    reg_ofs = neon_reg_offset(a->vd, 0);
+    reg_ofs = neon_full_reg_offset(a->vd);
     vec_size = a->q ? 16 : 8;
     imm = asimd_imm_const(a->imm, a->cmode, a->op);
 
@@ -2300,9 +2300,9 @@ static bool trans_VMULL_P_3d(DisasContext *s, arg_3diff *a)
         return true;
     }
 
-    tcg_gen_gvec_3_ool(neon_reg_offset(a->vd, 0),
-                       neon_reg_offset(a->vn, 0),
-                       neon_reg_offset(a->vm, 0),
+    tcg_gen_gvec_3_ool(neon_full_reg_offset(a->vd),
+                       neon_full_reg_offset(a->vn),
+                       neon_full_reg_offset(a->vm),
                        16, 16, 0, fn_gvec);
     return true;
 }
@@ -2445,8 +2445,8 @@ static bool do_2scalar_fp_vec(DisasContext *s, arg_2scalar *a,
 {
     /* Two registers and a scalar, using gvec */
     int vec_size = a->q ? 16 : 8;
-    int rd_ofs = neon_reg_offset(a->vd, 0);
-    int rn_ofs = neon_reg_offset(a->vn, 0);
+    int rd_ofs = neon_full_reg_offset(a->vd);
+    int rn_ofs = neon_full_reg_offset(a->vn);
     int rm_ofs;
     int idx;
     TCGv_ptr fpstatus;
@@ -2477,7 +2477,7 @@ static bool do_2scalar_fp_vec(DisasContext *s, arg_2scalar *a,
     /* a->vm is M:Vm, which encodes both register and index */
     idx = extract32(a->vm, a->size + 2, 2);
     a->vm = extract32(a->vm, 0, a->size + 2);
-    rm_ofs = neon_reg_offset(a->vm, 0);
+    rm_ofs = neon_full_reg_offset(a->vm);
 
     fpstatus = fpstatus_ptr(a->size == 1 ? FPST_STD_F16 : FPST_STD);
     tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, fpstatus,
@@ -2923,7 +2923,7 @@ static bool trans_VDUP_scalar(DisasContext *s, arg_VDUP_scalar *a)
         return true;
     }
 
-    tcg_gen_gvec_dup_mem(a->size, neon_reg_offset(a->vd, 0),
+    tcg_gen_gvec_dup_mem(a->size, neon_full_reg_offset(a->vd),
                          neon_element_offset(a->vm, a->index, a->size),
                          a->q ? 16 : 8, a->q ? 16 : 8);
     return true;
@@ -3412,8 +3412,8 @@ static bool trans_VCVT_F32_F16(DisasContext *s, arg_2misc *a)
 static bool do_2misc_vec(DisasContext *s, arg_2misc *a, GVecGen2Fn *fn)
 {
     int vec_size = a->q ? 16 : 8;
-    int rd_ofs = neon_reg_offset(a->vd, 0);
-    int rm_ofs = neon_reg_offset(a->vm, 0);
+    int rd_ofs = neon_full_reg_offset(a->vd);
+    int rm_ofs = neon_full_reg_offset(a->vm);
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index a7ed9bc81b..368bae0a73 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -653,7 +653,7 @@ static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
     }
 
     tmp = load_reg(s, a->rt);
-    tcg_gen_gvec_dup_i32(size, neon_reg_offset(a->vn, 0),
+    tcg_gen_gvec_dup_i32(size, neon_full_reg_offset(a->vn),
                          vec_size, vec_size, tmp);
     tcg_temp_free_i32(tmp);
 
-- 
2.25.1


