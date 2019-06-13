Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8F5C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2C720B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lnyco95W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2C720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPHM-0003Xk-Q8
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59131)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdR-00085b-JK
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdN-0004QP-A0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdL-0004Mq-By
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id w9so6496220wmd.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=n6lixbnjvJpGmbP+wJzw0YyYNuM8C0qvQLRRdQPH6UY=;
 b=Lnyco95WaHnU9n7B1RJc4kb4AqyZbhXBY9WPW+5ETnNyL4c2QJm7lnqJhKOZVAt0vx
 C9oUDSvQCm7LB7P2TksNuv6h0M2c9dQ4KcglPuZqIJX+bkcJ/27W91Pd/T8qkraWHEXg
 keKVbLsj5IA2J+CigRXqUQnm/tvSv+hO3FnjrYLApePECTr4Yt4N5OjvKboUrw0Iu/Q5
 g+WxLhv8zvff5Z0Ck2yXl87wReEZxbCxYU47MUp51v7939m+sYURC87BhHa81e3lLBZl
 +QZC6aHbpvJ6qXc3XY/51DKjz7F0XfwRUo9GfNvcctMBDnB0lsu1ybE1stqlhw/ndz0m
 KcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n6lixbnjvJpGmbP+wJzw0YyYNuM8C0qvQLRRdQPH6UY=;
 b=gD51Mc6DWK39VJMt8/+oJ+zmdjgoJ4RwMrB/oiMHeY7CAnefVHexd/6WvoHP7UADUv
 3heD3T15TWw4hxS4XMUDGkCLSFg9m8/wD5HYMgfySCPdVmMSoL81hArvil3PGQdCmBlL
 GyK9O51+yp1Pq7NcO7amroIqgf2RdW5vIirN0OL1yGZUq5vIVshWyMgzXsehmm+JiJFg
 CH6xgIAMNePUPWcVP06Hc19rdhniqlaxiUuROjM9xtMVWP2Xo9Qg37xeYZF9HOSTBTtu
 M40xceZ8xJVi49wmyEySyOaFJAawcwxRl8bMkmSHLSfgO3bsy1ovbj7cFiRJf9NJrbCf
 mBwg==
X-Gm-Message-State: APjAAAUktFXkb/Ujp56AxlBPbU2i4d4WjBheHoEBzQw7VzShMsvaCgtv
 G/MrxFKLWvjd6ZQQsDbH9zCeq1VCM058GQ==
X-Google-Smtp-Source: APXvYqzHhEA8dklqytjDCKFAJdqLuxRoCo9txKZS10VfZ7iRFugZ5S11O8eI8QdbKvl8HKczLt+LNQ==
X-Received: by 2002:a1c:3942:: with SMTP id g63mr3191936wma.61.1560428108976; 
 Thu, 13 Jun 2019 05:15:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:16 +0100
Message-Id: <20190613121433.5246-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 31/48] target/arm: Convert VSUB to decodetree
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

Convert the VSUB instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  6 +-----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 14aeb25f597..12da3b8acb8 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1461,3 +1461,13 @@ static bool trans_VADD_dp(DisasContext *s, arg_VADD_sp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
 }
+
+static bool trans_VSUB_sp(DisasContext *s, arg_VSUB_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_subs, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2341479a7c2..a7f79395e31 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1386,7 +1386,6 @@ static inline void gen_vfp_##name(int dp)                             \
     tcg_temp_free_ptr(fpst);                                          \
 }
 
-VFP_OP2(sub)
 VFP_OP2(div)
 
 #undef VFP_OP2
@@ -3110,7 +3109,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 6:
+            case 0 ... 7:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3296,9 +3295,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 7: /* sub: fn - fm */
-                    gen_vfp_sub(dp);
-                    break;
                 case 8: /* div: fn / fm */
                     gen_vfp_div(dp);
                     break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index d911f12dfd0..de56f44efc9 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -132,3 +132,8 @@ VADD_sp      ---- 1110 0.11 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VADD_dp      ---- 1110 0.11 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VSUB_sp      ---- 1110 0.11 .... .... 1010 .1.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


