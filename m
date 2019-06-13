Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1FC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F4E2147A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLQA8r7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F4E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPBB-0004co-FC
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59025)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdL-00080Z-Ce
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdH-0004Kj-FG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:10 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdF-0004GR-Bq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id k11so2349590wrl.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IRZuW3taWPCfJ37rwCt/vodP6fN4Yy7faj6/F0vMpBk=;
 b=oLQA8r7UuXmNoTYEPEC6QiGnVdR3Zc2aIIXxn27myZqylPWNSxqWsCg4nvMWQ+n4xl
 XjMGrKl84vH/c6iRM7YL99EuU67nCat1bZbnDz367Dhh7kqbKm0F1wJCdbvl6svdjn5L
 gNen86jGdt2uUTUFfu9sS/tn5QZd2UwrJNrg0m0yhty1y0oYj47nlV2/kuM44JsjiRTD
 pERp1BAIgZsFy5u4/Wkcp34pr/SRbb7RUOZblMR3SJsspuoF/4LeEOI5dSB2whFq79T8
 1H/Df1y+nPPcutC3FNNN0Utc0mwvGX9GuICypDfJ1eTFvNnMCaGHGPalLqpAc9k6Jsss
 4XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IRZuW3taWPCfJ37rwCt/vodP6fN4Yy7faj6/F0vMpBk=;
 b=kUhqxBpH+jCSaoY2Yh0PsaXQ51URrUqEVKe6XIWPrzPF9fCntPSVlNpOqOIW47r6o4
 UQHU+Ff8TouiBipOP2GUcionNVDx/l46/0JilTwCyCc4DRi1wkmlQJh38xJ7a7BhybGs
 nmPjcrqRM6Ufi/e5l+ob0YgIYNzo4G8wab5MlmU6B9qW77dPMLgi2FLhtmSPWQ+jpCVi
 3/D5gn5kN22O7iQGoSgcxMDfeS4+UuIYWsAdnWF5rTao+0IK7bnM01XPpcPTB2kXlrhN
 IjbMyai5ZNst3Gyxvmds17ka6rOalNjJo3Nkm0pPdh7BnX4GU+cVQCNKQe3anWH9F8h7
 PknA==
X-Gm-Message-State: APjAAAXrTor5Q9jBWNoUJ3N7ySVALk+20fV0ehMNrq6awnOOJ2mmrvDy
 PrOSwKvDzJ32uClf1lYp+642kHoAk024Nw==
X-Google-Smtp-Source: APXvYqyg97mIgrOsBv9muTI6Z81BwHMo/nXzvVfM1/EFR27aFTu97SFtWQGIluuWjCegbu26+MNrQA==
X-Received: by 2002:adf:a18a:: with SMTP id u10mr37082207wru.351.1560428103352; 
 Thu, 13 Jun 2019 05:15:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:10 +0100
Message-Id: <20190613121433.5246-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 25/48] target/arm: Convert VFP VMLS to decodetree
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

Convert the VFP VMLS instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 38 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  8 +------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 4f922dc8405..00f64401dda 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1303,3 +1303,41 @@ static bool trans_VMLA_dp(DisasContext *s, arg_VMLA_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VMLA_dp, a->vd, a->vn, a->vm, true);
 }
+
+static void gen_VMLS_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /*
+     * VMLS: vd = vd + -(vn * vm)
+     * Note that order of inputs to the add matters for NaNs.
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_muls(tmp, vn, vm, fpst);
+    gen_helper_vfp_negs(tmp, tmp);
+    gen_helper_vfp_adds(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VMLS_sp(DisasContext *s, arg_VMLS_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_VMLS_sp, a->vd, a->vn, a->vm, true);
+}
+
+static void gen_VMLS_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
+{
+    /*
+     * VMLS: vd = vd + -(vn * vm)
+     * Note that order of inputs to the add matters for NaNs.
+     */
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_helper_vfp_muld(tmp, vn, vm, fpst);
+    gen_helper_vfp_negd(tmp, tmp);
+    gen_helper_vfp_addd(vd, vd, tmp, fpst);
+    tcg_temp_free_i64(tmp);
+}
+
+static bool trans_VMLS_dp(DisasContext *s, arg_VMLS_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_VMLS_dp, a->vd, a->vn, a->vm, true);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ad8f947a13b..2afab7fbc20 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3134,7 +3134,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0:
+            case 0 ... 1:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3320,12 +3320,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 1: /* VMLS: fd + -(fn * fm) */
-                    gen_vfp_mul(dp);
-                    gen_vfp_F1_neg(dp);
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_add(dp);
-                    break;
                 case 2: /* VNMLS: -fd + (fn * fm) */
                     /* Note that it isn't valid to replace (-A + B) with (B - A)
                      * or similar plausible looking simplifications
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 9530e17ae02..7bcf2260eec 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -102,3 +102,8 @@ VMLA_sp      ---- 1110 0.00 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VMLA_dp      ---- 1110 0.00 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VMLS_sp      ---- 1110 0.00 .... .... 1010 .1.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VMLS_dp      ---- 1110 0.00 .... .... 1011 .1.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


