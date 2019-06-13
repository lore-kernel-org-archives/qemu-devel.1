Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE131C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A19E20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbuUBUqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A19E20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPIq-0005Q7-Qc
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdr-0008R2-UP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdX-0004hZ-4s
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdW-0004Xp-FM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id r16so1385014wrl.11
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cxBzWnFf3vKNg5qQ3a9HApwDlxGPwcmAzzGsAXBP4UY=;
 b=PbuUBUqezc+T6vHOIbxVAmL81mRLU0B9mLsCPjWH0zT6jYs5eSg2xNRSUTlsSgXXnU
 2TAwVGpOH3aNeF4hYe61Hp818v25cr2huC+WhEKWgc7SVheAXCoHypCpo9sV1qDt8mEd
 Fpxz5mVe6hEgM7NM5CiRpDCDPiCKdS/0PWhbZjhYzq+WtEPGxP0a/KIilyGLo9goKdjv
 0cXM+rCtKKbMS54s8FFw/c9AmGUAcIp5ED37w447dXW/cEzOudZpMVgGFJloG/vQdTJq
 KIRetGFuzVydXGz63NXxJTErrfSr9iIOsB7jxwqpOeS+kO2kfCBR6n/uEDiXSbBV7rZq
 7eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cxBzWnFf3vKNg5qQ3a9HApwDlxGPwcmAzzGsAXBP4UY=;
 b=U+Tj3n/XeLNwP77KBx/28NgJTLx3J16S4JRAacxkJhX6bNreYA6ydl9iTY/MPBjpb4
 f9lGOL28OsD0wTlIDm6lWZLeEnAlQMK9Gzv0F+xd+sKiozh0tGZRtxdasLAr6r9XzPSV
 H5q1pCSV02iKJPa+QLNwDxH1onGMTfmywNRmulNQkOWvWyHz9/XZLI4yBk0zWkfiPOUd
 lHB4Er6vLDJJ5GAPqYNRyMGUihYZvYJzX+lLDmhZLKsc//h9i6AinpcqrKvSdTLPqPtH
 2ZqJu1OGpOnmXR/Ua7PglV+iAZR07LagI42iNDqNchojPrONPsoJnK9sJGMjXZMyZ+5E
 voeA==
X-Gm-Message-State: APjAAAUu0sKM1yd/B332tUTORsVgFWcVdrtOBG59KIyOamsS/A4ZqIEZ
 aOe2eMkL69L+7P9wMEbZw7f6tIlP9SRLnQ==
X-Google-Smtp-Source: APXvYqxYUTRZ0sXcr4jRqoGQ7+9ea8C9OI+c4pi9z1aadkSwVaPKgY0eqGmbZV5fBOJO9lknvGaEeA==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr8612735wrp.280.1560428119249; 
 Thu, 13 Jun 2019 05:15:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:26 +0100
Message-Id: <20190613121433.5246-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 41/48] target/arm: Convert the VCVT-to-f16 insns
 to decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VCVTT and VCVTB instructions which convert from
f32 and f64 to f16 to decodetree.

Since we're no longer constrained to the old decoder's style
using cpu_F0s and cpu_F0d we can perform a direct 16 bit
store of the right half of the input single-precision register
rather than doing a load/modify/store sequence on the full
32 bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 62 ++++++++++++++++++++++++++
 target/arm/translate.c         | 79 +---------------------------------
 target/arm/vfp.decode          |  6 +++
 3 files changed, 69 insertions(+), 78 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 732bf6020a9..a19ede86719 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2095,3 +2095,65 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     tcg_temp_free_i64(vd);
     return true;
 }
+
+static bool trans_VCVT_f16_f32(DisasContext *s, arg_VCVT_f16_f32 *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 ahp_mode;
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_fp16_spconv, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(false);
+    ahp_mode = get_ahp_flag();
+    tmp = tcg_temp_new_i32();
+
+    neon_load_reg32(tmp, a->vm);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp_mode);
+    tcg_gen_st16_i32(tmp, cpu_env, vfp_f16_offset(a->vd, a->t));
+    tcg_temp_free_i32(ahp_mode);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
+static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 ahp_mode;
+    TCGv_i32 tmp;
+    TCGv_i64 vm;
+
+    if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vm  & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(false);
+    ahp_mode = get_ahp_flag();
+    tmp = tcg_temp_new_i32();
+    vm = tcg_temp_new_i64();
+
+    neon_load_reg64(vm, a->vm);
+    gen_helper_vfp_fcvt_f64_to_f16(tmp, vm, fpst, ahp_mode);
+    tcg_temp_free_i64(vm);
+    tcg_gen_st16_i32(tmp, cpu_env, vfp_f16_offset(a->vd, a->t));
+    tcg_temp_free_i32(ahp_mode);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a2cb2cdba58..21423b264fa 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2963,20 +2963,6 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
 #define VFP_SREG_M(insn) VFP_SREG(insn,  0,  5)
 #define VFP_DREG_M(reg, insn) VFP_DREG(reg, insn,  0,  5)
 
-/* Move between integer and VFP cores.  */
-static TCGv_i32 gen_vfp_mrs(void)
-{
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_mov_i32(tmp, cpu_F0s);
-    return tmp;
-}
-
-static void gen_vfp_msr(TCGv_i32 tmp)
-{
-    tcg_gen_mov_i32(cpu_F0s, tmp);
-    tcg_temp_free_i32(tmp);
-}
-
 static void gen_neon_dup_low16(TCGv_i32 var)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
@@ -3003,8 +2989,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t rd, rn, rm, op, delta_d, delta_m, bank_mask;
     int dp, veclen;
-    TCGv_i32 tmp;
-    TCGv_i32 tmp2;
 
     if (!arm_dc_feature(s, ARM_FEATURE_VFP)) {
         return 1;
@@ -3066,8 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 5:
-                case 8 ... 11:
+                case 0 ... 11:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3080,20 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x06: /* vcvtb.f16.f32, vcvtb.f16.f64 */
-                case 0x07: /* vcvtt.f16.f32, vcvtt.f16.f64 */
-                    if (dp) {
-                        if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
-                            return 1;
-                        }
-                    } else {
-                        if (!dc_isar_feature(aa32_fp16_spconv, s)) {
-                            return 1;
-                        }
-                    }
-                    rd_is_dp = false;
-                    break;
-
                 case 0x0c: /* vrintr */
                 case 0x0d: /* vrintz */
                 case 0x0e: /* vrintx */
@@ -3221,52 +3190,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 6: /* vcvtb.f16.f32, vcvtb.f16.f64 */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(false);
-                        TCGv_i32 ahp = get_ahp_flag();
-                        tmp = tcg_temp_new_i32();
-
-                        if (dp) {
-                            gen_helper_vfp_fcvt_f64_to_f16(tmp, cpu_F0d,
-                                                           fpst, ahp);
-                        } else {
-                            gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s,
-                                                           fpst, ahp);
-                        }
-                        tcg_temp_free_i32(ahp);
-                        tcg_temp_free_ptr(fpst);
-                        gen_mov_F0_vreg(0, rd);
-                        tmp2 = gen_vfp_mrs();
-                        tcg_gen_andi_i32(tmp2, tmp2, 0xffff0000);
-                        tcg_gen_or_i32(tmp, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                        gen_vfp_msr(tmp);
-                        break;
-                    }
-                    case 7: /* vcvtt.f16.f32, vcvtt.f16.f64 */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(false);
-                        TCGv_i32 ahp = get_ahp_flag();
-                        tmp = tcg_temp_new_i32();
-                        if (dp) {
-                            gen_helper_vfp_fcvt_f64_to_f16(tmp, cpu_F0d,
-                                                           fpst, ahp);
-                        } else {
-                            gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s,
-                                                           fpst, ahp);
-                        }
-                        tcg_temp_free_i32(ahp);
-                        tcg_temp_free_ptr(fpst);
-                        tcg_gen_shli_i32(tmp, tmp, 16);
-                        gen_mov_F0_vreg(0, rd);
-                        tmp2 = gen_vfp_mrs();
-                        tcg_gen_ext16u_i32(tmp2, tmp2);
-                        tcg_gen_or_i32(tmp, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                        gen_vfp_msr(tmp);
-                        break;
-                    }
                     case 12: /* vrintr */
                     {
                         TCGv_ptr fpst = get_fpstatus_ptr(0);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 53d9544f7cd..b88d1d06f02 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -187,3 +187,9 @@ VCVT_f32_f16 ---- 1110 1.11 0010 .... 1010 t:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_f64_f16 ---- 1110 1.11 0010 .... 1011 t:1 1.0 .... \
              vd=%vd_dp vm=%vm_sp
+
+# VCVTB and VCVTT to f16: Vd format is always vd_sp; Vm format depends on size bit
+VCVT_f16_f32 ---- 1110 1.11 0011 .... 1010 t:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VCVT_f16_f64 ---- 1110 1.11 0011 .... 1011 t:1 1.0 .... \
+             vd=%vd_sp vm=%vm_dp
-- 
2.20.1


