Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034D1C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7AE2083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOSoUsYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7AE2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36291 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwqT-0002iP-Vj
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:10:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU9-0004XV-Ko
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU6-0004B3-V8
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU6-0003Jm-Jv
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id v14so3347080wrr.4
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=46/bfSh4qTs1HLqCmXNVzF6OG+uw62+U38VNlBMJ2qI=;
	b=cOSoUsYM+G2KfYZGf4O4+ZCJ0BrLVsGeHhwA7/LaH9nT2CjN81UD++uN+YUsy1IrKG
	/zgWsHljek2DtOL+8qspdf7ZL8G7qSyQIGJsuzcdUVhdl4TY9FCMcu7MQQd75VngW0L2
	oMxhW8O841JZf5ydfZghNxx6+YCAPLKg3WBIuYAueYShWppk0RpHXRlQYuudKBHN2wcd
	JEn9h5V4c8hTOlssDbCFwQHdvtOzGmpzNPDyXnYxoBc3Bh6ppjxDfOM7R/fHns8Ip7Ex
	uEYxeH8ZFLG1OcniK+gqLYCc2YIBDTSOP7kQ5QGBNPiQs/Ajd+B3IEDT8pE2dFMeUnDp
	2RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=46/bfSh4qTs1HLqCmXNVzF6OG+uw62+U38VNlBMJ2qI=;
	b=YgFoGtDqzo65DUKU80+AQvy1qPW+sEA5ANq9T9MbUe2DGnWZN4oSP++yu0EdejRiFb
	zrhUtGrCgwXQgIQAUpEPU16kGhnU/XMf1Et2SH6TbJRuttzFHzoT9cdumsiIWR4V4BIn
	W6yb1/4As4PLw+k7rG78XNzu1zgmzgq9XLSmmiFFa7tTNkK/SL88rO+Y0iaECN61zYmK
	WlH/7iXL670jxCSycPEP2uyF/h5us7G6FR3i69t5ikqasQ73IYkOEd1tqlYtxgCWBvN6
	fccsk2K66hlRnVQLBc0kcEAQxRd2y8GUQhXuPRtFQGr6dlhSe1PF2Qk/edP1L0HavV80
	50Vg==
X-Gm-Message-State: APjAAAUxuzxw9/aPo73a5jnwBy/Q5JLpFyEAX4kjmXR4RWpAa/eprFSq
	amNwI01TlMPseV+rfbZV/elyDg==
X-Google-Smtp-Source: APXvYqwRJgtSe5qWJ4fapndd9iXgRDGdj4jGQGZAnQhvzZKjCCza7ubmMiApDf4gtqoCiIgSOXvNpA==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr21176615wrq.251.1559843211397;
	Thu, 06 Jun 2019 10:46:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:46:03 +0100
Message-Id: <20190606174609.20487-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 36/42] target/arm: Convert VFP round insns to
 decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP round-to-integer instructions VRINTR, VRINTZ and
VRINTX to decodetree.

These instructions were only introduced as part of the "VFP misc"
additions in v8A, so we check this. The old decoder's implementation
was incorrectly providing them even for v7A CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 163 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  45 +--------
 target/arm/vfp.decode          |  15 +++
 3 files changed, 179 insertions(+), 44 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index d2ae148ca69..5768be40c3e 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -2149,3 +2149,166 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     tcg_temp_free_i32(tmp);
     return true;
 }
+
+static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    gen_helper_rints(tmp, tmp, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
+static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i64 tmp;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i64();
+    neon_load_reg64(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    gen_helper_rintd(tmp, tmp, fpst);
+    neon_store_reg64(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
+
+static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+    TCGv_i32 tcg_rmode;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    tcg_rmode = tcg_const_i32(float_round_to_zero);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    gen_helper_rints(tmp, tmp, fpst);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tcg_rmode);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
+static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i64 tmp;
+    TCGv_i32 tcg_rmode;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i64();
+    neon_load_reg64(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    tcg_rmode = tcg_const_i32(float_round_to_zero);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    gen_helper_rintd(tmp, tmp, fpst);
+    gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
+    neon_store_reg64(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i32(tcg_rmode);
+    return true;
+}
+
+static bool trans_VRINTX_sp(DisasContext *s, arg_VRINTX_sp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i32();
+    neon_load_reg32(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    gen_helper_rints_exact(tmp, tmp, fpst);
+    neon_store_reg32(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
+
+static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
+{
+    TCGv_ptr fpst;
+    TCGv_i64 tmp;
+
+    if (!dc_isar_feature(aa32_vrint, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = tcg_temp_new_i64();
+    neon_load_reg64(tmp, a->vm);
+    fpst = get_fpstatus_ptr(false);
+    gen_helper_rintd_exact(tmp, tmp, fpst);
+    neon_store_reg64(tmp, a->vd);
+    tcg_temp_free_ptr(fpst);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3edcd7beff3..e7831bf8abb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3050,7 +3050,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 0 ... 11:
+                case 0 ... 14:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3063,11 +3063,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             if (op == 15) {
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
-                case 0x0c: /* vrintr */
-                case 0x0d: /* vrintz */
-                case 0x0e: /* vrintx */
-                    break;
-
                 case 0x0f: /* vcvt double<->single */
                     rd_is_dp = !dp;
                     break;
@@ -3190,44 +3185,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 switch (op) {
                 case 15: /* extension space */
                     switch (rn) {
-                    case 12: /* vrintr */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(0);
-                        if (dp) {
-                            gen_helper_rintd(cpu_F0d, cpu_F0d, fpst);
-                        } else {
-                            gen_helper_rints(cpu_F0s, cpu_F0s, fpst);
-                        }
-                        tcg_temp_free_ptr(fpst);
-                        break;
-                    }
-                    case 13: /* vrintz */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(0);
-                        TCGv_i32 tcg_rmode;
-                        tcg_rmode = tcg_const_i32(float_round_to_zero);
-                        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-                        if (dp) {
-                            gen_helper_rintd(cpu_F0d, cpu_F0d, fpst);
-                        } else {
-                            gen_helper_rints(cpu_F0s, cpu_F0s, fpst);
-                        }
-                        gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
-                        tcg_temp_free_i32(tcg_rmode);
-                        tcg_temp_free_ptr(fpst);
-                        break;
-                    }
-                    case 14: /* vrintx */
-                    {
-                        TCGv_ptr fpst = get_fpstatus_ptr(0);
-                        if (dp) {
-                            gen_helper_rintd_exact(cpu_F0d, cpu_F0d, fpst);
-                        } else {
-                            gen_helper_rints_exact(cpu_F0s, cpu_F0s, fpst);
-                        }
-                        tcg_temp_free_ptr(fpst);
-                        break;
-                    }
                     case 15: /* single<->double conversion */
                         if (dp) {
                             gen_helper_vfp_fcvtsd(cpu_F0s, cpu_F0d, cpu_env);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index b88d1d06f02..9942d2ae7ad 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -193,3 +193,18 @@ VCVT_f16_f32 ---- 1110 1.11 0011 .... 1010 t:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_f16_f64 ---- 1110 1.11 0011 .... 1011 t:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
+
+VRINTR_sp    ---- 1110 1.11 0110 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VRINTR_dp    ---- 1110 1.11 0110 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
+
+VRINTZ_sp    ---- 1110 1.11 0110 .... 1010 11.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VRINTZ_dp    ---- 1110 1.11 0110 .... 1011 11.0 .... \
+             vd=%vd_dp vm=%vm_dp
+
+VRINTX_sp    ---- 1110 1.11 0111 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VRINTX_dp    ---- 1110 1.11 0111 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1


