Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EFB206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNAzZOVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EFB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhRo-00054s-AA
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH0-0002sr-0T
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGx-0003Ea-Kw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id 22so1815527wmg.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EbAMYnBR5x80vBOVUJf+lpOcPdDdY4fY3H9ve06NRgo=;
 b=LNAzZOVEG5bqGshKMuLm31N3ChkPN+xta16nZsWMbP3kzlepFFJeRxNQhkZR2kKPG3
 Wvhv7BqJCA/e3CqmhWmYhZUwauA6n3y2jI9OOC+SXAdlNBfUjDriRJhUomrDFDM8lEia
 nBckp5MGXxtPj34Flp58vE1BDuOZ1gI/Z0gZhcx4lCac2MX4OEztdGBEdOfkdyfwog4C
 71lfEmPpId2nxnN/VsY80VCJLefOGEgMssP2l823HvWZ5guUQfDolqwtgKhOmog9KB0j
 mTtm+QJyj0Q3il1y/GYYpSlYlOKGFcY8eLCgcl42WIr74rkeGvzB1/IYZ9uZvPxPxYX2
 L97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EbAMYnBR5x80vBOVUJf+lpOcPdDdY4fY3H9ve06NRgo=;
 b=b3R6GMupWrv+LCASpweydmGrHFxjMMLrJKXMWDRoO5EukbPw5WZD+/Gj0/XrdIOvXS
 OkXLfF40oudi33CgLlHJrvQzT1QHdfTvadygvzDLl8HrGavLCkoG9gfwA5EZKNtnzqQX
 PGvI3oOfToiV82+xqNdJAW1UQVEdHbL5Ghx3noFIlSh6wh/HjRbcHxvMh1U1fxCabO0J
 ECQjFvF8zHAS283L0Kzg5LMuDFcQ26zhNEsbXaNVOxe+V02O2ZCKqtaTBS9k2tHeLtS+
 VcgYVBH35sJTrh2gcDLInAIF70lBqBX4KMHBRkvlQlejilZevDTFIDRghVgtDr0G9UAu
 O7mQ==
X-Gm-Message-State: AOAM530kWi8MT4g8kip5xpuPvcH2NmtWmElARhNqUGwIfVGFgH9Qxtaj
 RWuqHcdrJvfdZoSeGj6ZvcHMiRcfPobV6Q==
X-Google-Smtp-Source: ABdhPJxY6gBqL2kyxhmgzspqkFOqMDVLPRMxCht2Fv+IGimrywG3zJaz5n61znfLSyZ1CqGzRHpeAQ==
X-Received: by 2002:a1c:4343:: with SMTP id q64mr12172536wma.20.1592912365912; 
 Tue, 23 Jun 2020 04:39:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/42] target/arm: Convert simple fp Neon 2-reg-misc insns
Date: Tue, 23 Jun 2020 12:38:39 +0100
Message-Id: <20200623113904.28805-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon 2-reg-misc insns which are implemented with
simple calls to functions that take the input, output and
fpstatus pointer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-16-peter.maydell@linaro.org
---
 target/arm/translate.h          |  1 +
 target/arm/neon-dp.decode       |  8 +++++
 target/arm/translate-neon.inc.c | 62 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 56 ++++-------------------------
 4 files changed, 78 insertions(+), 49 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 4dbeee4c89f..19650a9e2d7 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -373,6 +373,7 @@ typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
 typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
 typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
 typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
+typedef void NeonGenOneSingleOpFn(TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoSingleOpFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoDoubleOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOne64OpFn(TCGv_i64, TCGv_i64);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index f0bb34a49eb..ea8d5fd99c3 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -497,11 +497,19 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     SHA1SU1      1111 001 11 . 11 .. 10 .... 0 0111 0 . 0 .... @2misc_q1
     SHA256SU0    1111 001 11 . 11 .. 10 .... 0 0111 1 . 0 .... @2misc_q1
 
+    VRINTX       1111 001 11 . 11 .. 10 .... 0 1001 . . 0 .... @2misc
+
     VCVT_F16_F32 1111 001 11 . 11 .. 10 .... 0 1100 0 . 0 .... @2misc_q0
     VCVT_F32_F16 1111 001 11 . 11 .. 10 .... 0 1110 0 . 0 .... @2misc_q0
 
     VRECPE       1111 001 11 . 11 .. 11 .... 0 1000 . . 0 .... @2misc
     VRSQRTE      1111 001 11 . 11 .. 11 .... 0 1001 . . 0 .... @2misc
+    VRECPE_F     1111 001 11 . 11 .. 11 .... 0 1010 . . 0 .... @2misc
+    VRSQRTE_F    1111 001 11 . 11 .. 11 .... 0 1011 . . 0 .... @2misc
+    VCVT_FS      1111 001 11 . 11 .. 11 .... 0 1100 . . 0 .... @2misc
+    VCVT_FU      1111 001 11 . 11 .. 11 .... 0 1101 . . 0 .... @2misc
+    VCVT_SF      1111 001 11 . 11 .. 11 .... 0 1110 . . 0 .... @2misc
+    VCVT_UF      1111 001 11 . 11 .. 11 .... 0 1111 . . 0 .... @2misc
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 2b5dc86f628..ab183e47d7d 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3706,3 +3706,65 @@ static bool trans_VQNEG(DisasContext *s, arg_2misc *a)
     };
     return do_2misc(s, a, fn[a->size]);
 }
+
+static bool do_2misc_fp(DisasContext *s, arg_2misc *a,
+                        NeonGenOneSingleOpFn *fn)
+{
+    int pass;
+    TCGv_ptr fpst;
+
+    /* Handle a 2-reg-misc operation by iterating 32 bits at a time */
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->size != 2) {
+        /* TODO: FP16 will be the size == 1 case */
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(1);
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        fn(tmp, tmp, fpst);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
+
+#define DO_2MISC_FP(INSN, FUNC)                                 \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
+    {                                                           \
+        return do_2misc_fp(s, a, FUNC);                         \
+    }
+
+DO_2MISC_FP(VRECPE_F, gen_helper_recpe_f32)
+DO_2MISC_FP(VRSQRTE_F, gen_helper_rsqrte_f32)
+DO_2MISC_FP(VCVT_FS, gen_helper_vfp_sitos)
+DO_2MISC_FP(VCVT_FU, gen_helper_vfp_uitos)
+DO_2MISC_FP(VCVT_SF, gen_helper_vfp_tosizs)
+DO_2MISC_FP(VCVT_UF, gen_helper_vfp_touizs)
+
+static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+    return do_2misc_fp(s, a, gen_helper_rints_exact);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3cbd2ab0c96..48377860c75 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4947,6 +4947,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VRSQRTE:
                 case NEON_2RM_VQABS:
                 case NEON_2RM_VQNEG:
+                case NEON_2RM_VRECPE_F:
+                case NEON_2RM_VRSQRTE_F:
+                case NEON_2RM_VCVT_FS:
+                case NEON_2RM_VCVT_FU:
+                case NEON_2RM_VCVT_SF:
+                case NEON_2RM_VCVT_UF:
+                case NEON_2RM_VRINTX:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -5052,13 +5059,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             tcg_temp_free_i32(tcg_rmode);
                             break;
                         }
-                        case NEON_2RM_VRINTX:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_rints_exact(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
                         case NEON_2RM_VCVTAU:
                         case NEON_2RM_VCVTAS:
                         case NEON_2RM_VCVTNU:
@@ -5093,48 +5093,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             tcg_temp_free_ptr(fpst);
                             break;
                         }
-                        case NEON_2RM_VRECPE_F:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_recpe_f32(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VRSQRTE_F:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_rsqrte_f32(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VCVT_FS: /* VCVT.F32.S32 */
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_vfp_sitos(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VCVT_FU: /* VCVT.F32.U32 */
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_vfp_uitos(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VCVT_SF: /* VCVT.S32.F32 */
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_vfp_tosizs(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VCVT_UF: /* VCVT.U32.F32 */
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_vfp_touizs(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
                         default:
                             /* Reserved op values were caught by the
                              * neon_2rm_sizes[] check earlier.
-- 
2.20.1


