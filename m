Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CA4C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B9920B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZodAsV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B9920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPKP-00076Q-Tg
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOda-0008Hl-BS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdV-0004d4-Bi
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdU-0004M0-Rz
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id 207so2082006wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eYuZ4JfNpv8LMEYu119hBSFj+2/7pHYpoxLLGG2Y2VU=;
 b=SZodAsV8Mr+FemOgPqb1thHU4CE03OhOyF8GRtm8hvpuNipUfkkkScpoip3ZrWiWpF
 A3y7fUnTKppe7Dka6MiDphUxq86znav0/VPJXpS0YRMxItRUCPLWQgI+IZH/WNe2f8uR
 GyFyTN/l+P0jUDLtMEzDYMTkZBIspoH7UXv83u6l2Cn/zTnDI2GCL9pyz7sskoMCb5Wl
 1p/nl+6deTSNzrePLhYS5tJF534S7w2ByyBIYEL/PmshFLX6j0mRXvFuxdGc0PdYH+aF
 LfIRYfCQPGSF8oR2BcWOnOIAD9qD0FyfCKMRmJ6V5UBWG27hOTZCLWS6bgJVVVh/A30O
 KgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eYuZ4JfNpv8LMEYu119hBSFj+2/7pHYpoxLLGG2Y2VU=;
 b=c5j5f9p4abbpNeMAaoyq/t00l70bEP9AfyVwMcC6kIlKDeiNFMpSPr40c+J8xkeAv5
 83IPGP/CQhTlStOpl2HqjrJ6Mnn8F+xzMP0aelj5shEITS+WLqLRxcEPur5i6BbRChEp
 BBmAzHhPjz/89nq+Lh36L0aYwO7Ok8CoXRtjrPFTf8cV7XBfmh0FNKLtkEGLP3EV+pQr
 zj/UjOoIHnNCeDME8V3uCXn+HEKNxjHo3UrcV68Q1OXeqnSUgPMGiiXxZTodY27nIh90
 OGKm53cnze0DNURHx/PFWK8ugcFQ9oLqm6+F4gJtYrfqTClJuyslwwZ9dfbCbLRpX1NU
 ATZw==
X-Gm-Message-State: APjAAAUoYx9PWZxTeVNa3R4NIW7BZiPhs8E2GwmXRa+c/YrwI8ODXr/A
 PSdTOd2m7Hs/JSV25zUEB54YiI8RuEqq4w==
X-Google-Smtp-Source: APXvYqzMdBwzDIzoo9x3Wch6MFXaGYdiF1EIsUfTC0pVmrEz3MOOY5hFoT4f714pedSqOeVdInYPYA==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr3777869wmc.14.1560428108144;
 Thu, 13 Jun 2019 05:15:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:15 +0100
Message-Id: <20190613121433.5246-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 30/48] target/arm: Convert VADD to decodetree
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

Convert the VADD instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  6 +-----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 4c684f033b6..14aeb25f597 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1451,3 +1451,13 @@ static bool trans_VNMUL_dp(DisasContext *s, arg_VNMUL_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMUL_dp, a->vd, a->vn, a->vm, false);
 }
+
+static bool trans_VADD_sp(DisasContext *s, arg_VADD_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_adds, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VADD_dp(DisasContext *s, arg_VADD_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index cf03672db8c..2341479a7c2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1386,7 +1386,6 @@ static inline void gen_vfp_##name(int dp)                             \
     tcg_temp_free_ptr(fpst);                                          \
 }
 
-VFP_OP2(add)
 VFP_OP2(sub)
 VFP_OP2(div)
 
@@ -3111,7 +3110,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 5:
+            case 0 ... 6:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3297,9 +3296,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 6: /* add: fn + fm */
-                    gen_vfp_add(dp);
-                    break;
                 case 7: /* sub: fn - fm */
                     gen_vfp_sub(dp);
                     break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 3063fcac23f..d911f12dfd0 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -127,3 +127,8 @@ VNMUL_sp     ---- 1110 0.10 .... .... 1010 .1.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VNMUL_dp     ---- 1110 0.10 .... .... 1011 .1.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VADD_sp      ---- 1110 0.11 .... .... 1010 .0.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VADD_dp      ---- 1110 0.11 .... .... 1011 .0.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


