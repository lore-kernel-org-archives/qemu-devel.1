Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775A8C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A562089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3rUufnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A562089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haf3e-0000WX-Fa
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39342)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQ3-0007N0-RW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePz-0007Yk-7s
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePy-0007Y0-SI
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id z23so2380319wma.4
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Re3Rqp+76+/FOhH4NrXDuyW0zbLxDuCIwdDqY4GSpxA=;
 b=h3rUufntCtQj8CL09lEs84BRqUreCI9ffxDlFGY09Fn1UKqdBoRqXP9ByEuegCcMde
 A3veoIw9W8ubydh3CVW+3CQXt4PDsOYqtctgh1S8xJWI75TcEuq1kaioeTaReevJniMO
 kzbVseB1dcvg2gGZzmYGTv8pPwFZparlPAsxtWPy3zNY1HHdujrZ/Fq19/jCb8U+zoN4
 MGL9UeAr4+jqy8OcLwgHXbl4jBkWTg8XiDE6kKmF4/szCt8XLPHeXdtBxh/SGcVa2Ty/
 7QQ2IwKMCfkxENBiof+caFHpCOpmqRGdExDVIvX6UzHkuiK9zOBbNiEkaHN001xfEs9A
 8BDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Re3Rqp+76+/FOhH4NrXDuyW0zbLxDuCIwdDqY4GSpxA=;
 b=UoMUU/yZhjIzpcWV62+YiNb+8mEwBABT++LOnZ2vgJAtnpC5wuAlni6diOxW9sVc83
 U3jThiM4s9hfHburO9QFqrYMYViQUtrIlaNJW/u0mqkCE1Uqm2hcJ3suPZuhv7GRE4zM
 t1v/Yt1oTmcROU3Rzv+kRnuJ9XHUGOb/4hYkOwJWQ8BTRNFN4wdw8Up6kt8N0ObOzefE
 eW+qoVn44YHVLch7odpXIaA/gIB8UXoroF6+oVRT8dmhC4cZQKfNYZtQbS1v92dF2I6K
 uTwNYXDy++n/JoL3/CF/iUBkhtNaOV94hIC4t2Jj7rKKPVgqu8bKXmV0mQktUnOLkF6b
 BSJg==
X-Gm-Message-State: APjAAAWYhzPEQxxTxmrpgMjR7aUpenfjHQfRlucsrvVOKmzcVXCR8yNs
 NgCEbeD790LlsieZfbPBcdHw9y1ZzSWZXQ==
X-Google-Smtp-Source: APXvYqzhUaSWdoO0A1HfgZEXByN438VHfd3vp5gvcZOKPJPu1hlhg9YX0AJEpTnMGimVL6COIPbviA==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr9243045wmh.68.1560250457857;
 Tue, 11 Jun 2019 03:54:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:31 +0100
Message-Id: <20190611105351.9871-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 22/42] target/arm: Convert VMUL to decodetree
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
index 1f83723b81a..96790e65c6f 100644
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


