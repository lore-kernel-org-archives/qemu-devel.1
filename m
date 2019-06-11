Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A62EC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373882080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJKAF51z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373882080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haelP-0000ZE-Ge
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39416)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQ7-0007O8-Qx
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQ1-0007b1-Cx
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQ0-0007Zt-Tb
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so12476791wrm.8
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mVemKtw+NqwwNaXEIQeiOSqrKqr9sziHV25BKLiiWOk=;
 b=UJKAF51z6h32ovZB0thLmYg+cw9qKp+oCkoCfCNPq6Tj6PVm4tVs+biYqJ7NrjoO0d
 Dph/kFiP2wqGvLGpPKt1nh8lAfkAj8A4UDcC0KWT+0MdizjUjwACqLrPskp0Yie6Poqe
 A1Lte8ba/9/EdBCvN1l7CJcsMDGzCjCknhTHc6TymuhiC/qqLVF3MllvblGtJtCqRphQ
 cyJZcqNZAwHYKg0vHzvfM1O5wUo+a2NP7JrvXztvprsMUvEh1pcLtKDRv89gACq63Fby
 e79Joo7FjZaaSV2CPgAYHDbdApvYZ3Z+f6K0nr2rC8RJg9JdMua3XTrypD2iXNzVU3i5
 uHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mVemKtw+NqwwNaXEIQeiOSqrKqr9sziHV25BKLiiWOk=;
 b=Fc/AQ+ZbfofPqftgH4n7IQlpsV9nfZ6HEOzv/4KXkgeYTQj1gwZ3pbKqSkvil8fHJ6
 x4xwhj8ZfBjClEyVxt/Paj1LbTaWf+QAYhR+vcJZfZfl8n1N7qsFXXOCcrLM+dhMhJNO
 xd09ildMVHe6J3TADRqbQqFgdBLgcHZSxYUNeWnC4FTjsrLE6EXuxrJvQWHDFs8Bd+5d
 d36p1ozpq1p/0SDKR0W44ku8KUpuTo0wd8n1lAv/1q/iBFuEouUU9lBlwjqyEBJYruwm
 QGDxHU89p9JFYkyY8TdyXNlinwEHfq0ZsytR9nLlA5/r9k/stVhWjcQWuO82neBrR7Zo
 U2dg==
X-Gm-Message-State: APjAAAWx2qaD8jMJTWj8MKCkJ9QNpVstqBSz1Fb5BybtdrkIunjoBG5E
 wJUtmLcldUKiLyVxts+HKSHsqMpQh+AIcA==
X-Google-Smtp-Source: APXvYqzE0ea0DLqG1KkskH7QW4nc7jU83i7ugqOAwz0SIjAiijEIQPKAFuqk9dcQ8SsNBKs86Ksxtw==
X-Received: by 2002:adf:e691:: with SMTP id r17mr33139791wrm.67.1560250459975; 
 Tue, 11 Jun 2019 03:54:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:33 +0100
Message-Id: <20190611105351.9871-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 24/42] target/arm: Convert VADD to decodetree
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
index 1f9fa6b03a1..cd1f24798b1 100644
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


