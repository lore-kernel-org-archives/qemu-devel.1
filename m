Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4584BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1570B20C09
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCbxYBdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1570B20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF7s-0007r4-BD
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF51-0001DR-M2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4z-0007Se-Qp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id x13so21549221wrv.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Sp05zSviKK/vex9tstJEZpczFuX6qw9ndOqIxUFQRg=;
 b=gCbxYBdAGWZ+mXkZAWZFO3kyxY2u0IO+FMn/5EZoKKIgUXRU0V7qgFP0MJpox7XOJq
 BkXqe8e8FPzapEQVnVJGoujWwPVr7FkEXIpSqY8vuFB9zUxi4a9oU5MEUH3EcOYeX5df
 xyHPWipBAvYaWKfdplxJwIoxZOjfmPAdonZEh6ku20/EMs6uXWbGe8J4dkNKz+Ce9J0Y
 Tlm/5+WJ+eFhM/AQfJASZDoxPTENIFDStdZlC30D80tz+kERRjuVotJm1JtkXOLTchoA
 PsQS5LVjYuRh7mtIlDaKshKaCSLr7RMcjePz1ZOWy8c+ivhaIMXXMgjjKT8lbZ9hcVJV
 sXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Sp05zSviKK/vex9tstJEZpczFuX6qw9ndOqIxUFQRg=;
 b=c/EWtSzXsDx7kYwOrjeCnCyh3lK3iESLim/ZqOJPDt+Bm+RzpFeA1CC713d9D2O6od
 gm0R5VumuKHE+Ld6a0itBU4IN4kgTNxPcO/KDMrPDe64wdVwJpovxBi3EsDshhpdg3Os
 cw3Kb8SAo/cvEgDjzY+7dZaIVV/k47akgzc3hwSnKPEAhJKAefkLpxazHKjvVlyx2ovX
 9qd3IBCYgs4/oetFfRWtqRl4gRdSbwhOD+p0V7BSSevBbfjyvCjjqZM5ZwhnYy8KAaOw
 lobTPnHQkL5cAZYRTt15FUn1F97o4KYD2rQhs07H5n/DI8sZ5eCAV3CNOKaTZiwX4bcT
 4K0w==
X-Gm-Message-State: AOAM530GBbHQ8B+op9T+UDXw6T1Rnw6vphcrbIW+1saEU+YHOXfaS4+k
 gpa6xa9OebZDL+i7c4UMFj4eO5EAhqStvQ==
X-Google-Smtp-Source: ABdhPJzg/tqdIjApk9oeRvJ2zGNr6ihY/bxf0jIntTNO7vMhGM46ohLuQ8s0zhmHWR6SZZgHd39RHQ==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr4147375wrv.106.1592327336310; 
 Tue, 16 Jun 2020 10:08:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/21] target/arm: Convert Neon VCVT f16/f32 insns to
 decodetree
Date: Tue, 16 Jun 2020 18:08:29 +0100
Message-Id: <20200616170844.13318-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon insns in the 2-reg-misc group which are
VCVT between f32 and f16 to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  3 ++
 target/arm/translate-neon.inc.c | 96 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 65 ++--------------------
 3 files changed, 102 insertions(+), 62 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 0102aa7254b..8174f2f92f4 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -461,6 +461,9 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VQMOVN_U     1111 001 11 . 11 .. 10 .... 0 0101 1 . 0 .... @2misc_q0
 
     VSHLL        1111 001 11 . 11 .. 10 .... 0 0110 0 . 0 .... @2misc_q0
+
+    VCVT_F16_F32 1111 001 11 . 11 .. 10 .... 0 1100 0 . 0 .... @2misc_q0
+    VCVT_F32_F16 1111 001 11 . 11 .. 10 .... 0 1110 0 . 0 .... @2misc_q0
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 78239ec1c1b..d37be597cf4 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3354,3 +3354,99 @@ static bool trans_VSHLL(DisasContext *s, arg_2misc *a)
     tcg_temp_free_i32(rm1);
     return true;
 }
+
+static bool trans_VCVT_F16_F32(DisasContext *s, arg_2misc *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 ahp, tmp, tmp2, tmp3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_fp16_spconv, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vm & 1) || (a->size != 1)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(true);
+    ahp = get_ahp_flag();
+    tmp = neon_load_reg(a->vm, 0);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+    tmp2 = neon_load_reg(a->vm, 1);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp2, tmp2, fpst, ahp);
+    tcg_gen_shli_i32(tmp2, tmp2, 16);
+    tcg_gen_or_i32(tmp2, tmp2, tmp);
+    tcg_temp_free_i32(tmp);
+    tmp = neon_load_reg(a->vm, 2);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+    tmp3 = neon_load_reg(a->vm, 3);
+    neon_store_reg(a->vd, 0, tmp2);
+    gen_helper_vfp_fcvt_f32_to_f16(tmp3, tmp3, fpst, ahp);
+    tcg_gen_shli_i32(tmp3, tmp3, 16);
+    tcg_gen_or_i32(tmp3, tmp3, tmp);
+    neon_store_reg(a->vd, 1, tmp3);
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(ahp);
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
+
+static bool trans_VCVT_F32_F16(DisasContext *s, arg_2misc *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 ahp, tmp, tmp2, tmp3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
+        !dc_isar_feature(aa32_fp16_spconv, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd & 1) || (a->size != 1)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fpst = get_fpstatus_ptr(true);
+    ahp = get_ahp_flag();
+    tmp3 = tcg_temp_new_i32();
+    tmp = neon_load_reg(a->vm, 0);
+    tmp2 = neon_load_reg(a->vm, 1);
+    tcg_gen_ext16u_i32(tmp3, tmp);
+    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
+    neon_store_reg(a->vd, 0, tmp3);
+    tcg_gen_shri_i32(tmp, tmp, 16);
+    gen_helper_vfp_fcvt_f16_to_f32(tmp, tmp, fpst, ahp);
+    neon_store_reg(a->vd, 1, tmp);
+    tmp3 = tcg_temp_new_i32();
+    tcg_gen_ext16u_i32(tmp3, tmp2);
+    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
+    neon_store_reg(a->vd, 2, tmp3);
+    tcg_gen_shri_i32(tmp2, tmp2, 16);
+    gen_helper_vfp_fcvt_f16_to_f32(tmp2, tmp2, fpst, ahp);
+    neon_store_reg(a->vd, 3, tmp2);
+    tcg_temp_free_i32(ahp);
+    tcg_temp_free_ptr(fpst);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 94d5e34fff4..1ea09695546 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4860,7 +4860,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int pass;
     int u;
     int vec_size;
-    TCGv_i32 tmp, tmp2, tmp3;
+    TCGv_i32 tmp, tmp2;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return 1;
@@ -4927,6 +4927,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VZIP:
                 case NEON_2RM_VMOVN: case NEON_2RM_VQMOVN:
                 case NEON_2RM_VSHLL:
+                case NEON_2RM_VCVT_F16_F32:
+                case NEON_2RM_VCVT_F32_F16:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4942,67 +4944,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         goto elementwise;
                     }
                     break;
-                case NEON_2RM_VCVT_F16_F32:
-                {
-                    TCGv_ptr fpst;
-                    TCGv_i32 ahp;
-
-                    if (!dc_isar_feature(aa32_fp16_spconv, s) ||
-                        q || (rm & 1)) {
-                        return 1;
-                    }
-                    fpst = get_fpstatus_ptr(true);
-                    ahp = get_ahp_flag();
-                    tmp = neon_load_reg(rm, 0);
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-                    tmp2 = neon_load_reg(rm, 1);
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, tmp2, fpst, ahp);
-                    tcg_gen_shli_i32(tmp2, tmp2, 16);
-                    tcg_gen_or_i32(tmp2, tmp2, tmp);
-                    tcg_temp_free_i32(tmp);
-                    tmp = neon_load_reg(rm, 2);
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-                    tmp3 = neon_load_reg(rm, 3);
-                    neon_store_reg(rd, 0, tmp2);
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp3, tmp3, fpst, ahp);
-                    tcg_gen_shli_i32(tmp3, tmp3, 16);
-                    tcg_gen_or_i32(tmp3, tmp3, tmp);
-                    neon_store_reg(rd, 1, tmp3);
-                    tcg_temp_free_i32(tmp);
-                    tcg_temp_free_i32(ahp);
-                    tcg_temp_free_ptr(fpst);
-                    break;
-                }
-                case NEON_2RM_VCVT_F32_F16:
-                {
-                    TCGv_ptr fpst;
-                    TCGv_i32 ahp;
-                    if (!dc_isar_feature(aa32_fp16_spconv, s) ||
-                        q || (rd & 1)) {
-                        return 1;
-                    }
-                    fpst = get_fpstatus_ptr(true);
-                    ahp = get_ahp_flag();
-                    tmp3 = tcg_temp_new_i32();
-                    tmp = neon_load_reg(rm, 0);
-                    tmp2 = neon_load_reg(rm, 1);
-                    tcg_gen_ext16u_i32(tmp3, tmp);
-                    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
-                    neon_store_reg(rd, 0, tmp3);
-                    tcg_gen_shri_i32(tmp, tmp, 16);
-                    gen_helper_vfp_fcvt_f16_to_f32(tmp, tmp, fpst, ahp);
-                    neon_store_reg(rd, 1, tmp);
-                    tmp3 = tcg_temp_new_i32();
-                    tcg_gen_ext16u_i32(tmp3, tmp2);
-                    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
-                    neon_store_reg(rd, 2, tmp3);
-                    tcg_gen_shri_i32(tmp2, tmp2, 16);
-                    gen_helper_vfp_fcvt_f16_to_f32(tmp2, tmp2, fpst, ahp);
-                    neon_store_reg(rd, 3, tmp2);
-                    tcg_temp_free_i32(ahp);
-                    tcg_temp_free_ptr(fpst);
-                    break;
-                }
                 case NEON_2RM_AESE: case NEON_2RM_AESMC:
                     if (!dc_isar_feature(aa32_aes, s) || ((rm | rd) & 1)) {
                         return 1;
-- 
2.20.1


