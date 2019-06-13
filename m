Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8894C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F7E2173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaiXqWA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F7E2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPHt-0004OO-TH
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59259)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdW-0008BC-21
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdT-0004XM-SC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdR-0004KJ-Li
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so20488068wre.12
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4keYJTShaE3kyMWHr8Guw8e7EydlG5N8a+TAXs29Ato=;
 b=KaiXqWA1SqB2S3kxrhKzGXmCGCCuv8j078OreQRhYMQM2exCWTCM/iPdJNPZuQZp1/
 vDRB+0zuPHp8upJUY5VbqPXrOadmfD0p9eXIHB9fJahHL5HtfItjv3svdVkY5cxn1cRu
 F0LGTCh3cLB70a2kNpY2wnSLBv/ZedrvAOXxNa1FDfZr1yPedsZgY2vWid6DAuK9yQIB
 ePzGXSlEbTrD92T5/78iCkYEbkQD+5lJAfnwRMemIDbh1d4oaMrrbwfcFklxaZSj1ZCv
 qwJwZK8IhuBVpF/Ww6/j5j0IUsWO2003WMtr4sRxjkDApPZKCVonnFzlEYXF3mwj7/ic
 uGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4keYJTShaE3kyMWHr8Guw8e7EydlG5N8a+TAXs29Ato=;
 b=lIhBxcOEcGkoHHUX45v7bbzYSkmPr2D6Zrj4LCX74mZlr3VKWJCNNG5Z0xPYIpD6C+
 k6ntnsn4PfOapjCaOkjbEosQoygJag2uO6LvYybY5ljdZA2YOCQNtVX1GQM5MGMQH3m1
 r0IpggZUJIXmr2AobPW/aB9puFPx89JjF/jnXzXi139jDGI+vmdwWbnb6leisBHcKkmK
 nrSrbbnfkyOGcQcg5BgDmRCwsiU+H/ZCicgQR4WzOAzyzsvcYSBz5DcLLWt5VVlAaB9u
 lmQsJLt/y8/GVbJWqQTj0oHyZCKnonkHNWVQi/e4dxFrIRmfKpD5UVn+xpd1MjTJI78d
 vOsA==
X-Gm-Message-State: APjAAAWhkxhokvOz+T56HCl55r+PzsBGXm5lNUcghnev2TkwNNDVl0yO
 7n8rFwpYC9gjZGzLQGlrglduilW1HAx82Q==
X-Google-Smtp-Source: APXvYqzQeSaRmgzVuXBH3JwYNR8p0kIaQci1jh7QYRl95w93Coixzo+pX8KHXJ5xfyxh4ZkT3CvJcw==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr31277546wrn.285.1560428106361; 
 Thu, 13 Jun 2019 05:15:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:13 +0100
Message-Id: <20190613121433.5246-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 28/48] target/arm: Convert VMUL to decodetree
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

Convert the VMUL instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  5 +----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 8532bf4abcd..a2afe82b349 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1417,3 +1417,13 @@ static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
 }
+
+static bool trans_VMUL_sp(DisasContext *s, arg_VMUL_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_muls, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_muld, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0b998552df2..34be68fb8cb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3112,7 +3112,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 3:
+            case 0 ... 4:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3298,9 +3298,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 4: /* mul: fn * fm */
-                    gen_vfp_mul(dp);
-                    break;
                 case 5: /* nmul: -(fn * fm) */
                     gen_vfp_mul(dp);
                     gen_vfp_neg(dp);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index c50d2c3ebf3..d7fcb9709a9 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -117,3 +117,8 @@ VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VMUL_sp      ---- 1110 0.10 .... .... 1010 .0.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VMUL_dp      ---- 1110 0.10 .... .... 1011 .0.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


