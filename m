Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C50C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F306221721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hv8q4ECJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F306221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPSJ-0002wS-8R
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOda-0008HH-1S
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdU-0004aT-LF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdU-0004JZ-5r
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id g135so9952515wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=u8F8E/4POHXbij/G30GWx/MM7QuKTGRas6m/d3Ld7BI=;
 b=hv8q4ECJI0kn/dKaUJ/V2EDBMd9xap7BMtRUlXo7sd/6YHRIY18qVgulRE/iQ18+4R
 aLpYboJJO3+CuXoifsNuTwapX+SB5Fw3tCjAEAu7GqqWizCvWoEFLqJgrFIyxYWQdO7f
 2Y6IPUlJitrVO23V93i7An1sinUeFhwMfYqPkNZzacLGoGCe0l6MDqE1LKwKH5LUbjsu
 6MI3KkYqfBR17no6Fx7Azs5J1TLZzqt/sz/iYHNzbJJ52mtPLyFpvcogCHoBd1PhCvbF
 Kz7ZUZ8Nxp2O1Qewm1cKH90+DBO5tdmlASCyQf9JKx4ybC4Xiud3OqwBLTZUEDeweRhY
 Cftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u8F8E/4POHXbij/G30GWx/MM7QuKTGRas6m/d3Ld7BI=;
 b=Zw/57moVCEhuownYwLfZoP4/bDKN/YpKI8Z9ZWA1cCV5HSmfwIDVge27mloBHBZ+Yl
 LwKnV2sBV1pSjBYEGCpB2b1/cuH+0EHFilmgZ9tsTsHh9zLBPq3LFNr2eTN5OEpES+Bl
 Ohq5vl6DBsKV9M04lDvtvpLyK8oG9blPT5c1ISGe4opTrQzYN/9GFpWvfJbxDuh5mmfP
 4D112hoaqxlMjbFLsQQ+WBY1qR0Ofn6Fvh2uoRm1nUxhlwRI7OWr09N/A6/sya7785n2
 uiaOLKmd73k+F/UGfQGWat0vGd9GBZXsHlDG/2Bj9tKE9qeKv2tHkOgwV4/WxC1R4LkN
 LNHg==
X-Gm-Message-State: APjAAAU5H/It2aMvDM5LSPUGfV6votFPL1c/K1TlKn2H1kBePKxg3NHs
 15/j05CT+XRNiDvnY3TlhX/ogk3KBP6CQA==
X-Google-Smtp-Source: APXvYqybgWPJnwfhzOh0p5hI4LZOtwD7mVAN+we1owgWPe8QXbFHXBNPeRZqqRXqw1BuuPNu+3+A/w==
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr3267469wmd.24.1560428105331; 
 Thu, 13 Jun 2019 05:15:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:12 +0100
Message-Id: <20190613121433.5246-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 27/48] target/arm: Convert VFP VNMLA to
 decodetree
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

Convert the VFP VNMLA instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 19 +------------------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 1d7100debe4..8532bf4abcd 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1383,3 +1383,37 @@ static bool trans_VNMLS_dp(DisasContext *s, arg_VNMLS_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLS_dp, a->vd, a->vn, a->vm, true);
 }
+
+static void gen_VNMLA_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
+{
+    /* VNMLA: -fd + -(fn * fm) */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    gen_helper_vfp_muls(tmp, vn, vm, fpst);
+    gen_helper_vfp_negs(tmp, tmp);
+    gen_helper_vfp_negs(vd, vd);
+    gen_helper_vfp_adds(vd, vd, tmp, fpst);
+    tcg_temp_free_i32(tmp);
+}
+
+static bool trans_VNMLA_sp(DisasContext *s, arg_VNMLA_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_VNMLA_sp, a->vd, a->vn, a->vm, true);
+}
+
+static void gen_VNMLA_dp(TCGv_i64 vd, TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst)
+{
+    /* VNMLA: -fd + (fn * fm) */
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_helper_vfp_muld(tmp, vn, vm, fpst);
+    gen_helper_vfp_negd(tmp, tmp);
+    gen_helper_vfp_negd(vd, vd);
+    gen_helper_vfp_addd(vd, vd, tmp, fpst);
+    tcg_temp_free_i64(tmp);
+}
+
+static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 42701884101..0b998552df2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1393,16 +1393,6 @@ VFP_OP2(div)
 
 #undef VFP_OP2
 
-static inline void gen_vfp_F1_neg(int dp)
-{
-    /* Like gen_vfp_neg() but put result in F1 */
-    if (dp) {
-        gen_helper_vfp_negd(cpu_F1d, cpu_F0d);
-    } else {
-        gen_helper_vfp_negs(cpu_F1s, cpu_F0s);
-    }
-}
-
 static inline void gen_vfp_abs(int dp)
 {
     if (dp)
@@ -3122,7 +3112,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 2:
+            case 0 ... 3:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3308,13 +3298,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 3: /* VNMLA: -fd + -(fn * fm) */
-                    gen_vfp_mul(dp);
-                    gen_vfp_F1_neg(dp);
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_neg(dp);
-                    gen_vfp_add(dp);
-                    break;
                 case 4: /* mul: fn * fm */
                     gen_vfp_mul(dp);
                     break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 08e4f427408..c50d2c3ebf3 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -112,3 +112,8 @@ VNMLS_sp     ---- 1110 0.01 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


