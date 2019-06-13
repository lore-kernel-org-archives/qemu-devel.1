Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45039C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1873C20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UK8vLKLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1873C20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39560 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPKS-0007Bd-BE
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59359)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdZ-0008GV-QG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdU-0004aA-LM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdU-0004Ro-36
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id w9so6496388wmd.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AWW9PYoqGFrrUdmPkFR1zqFQl9klTG/mXKnSCy19Aj8=;
 b=UK8vLKLsSwwci+QKStlpX9wExGCcwQIOoeokNN/QRdTJps0GL31OzlP/7oQuIm7Kd8
 Vg+oArs6FH2M2T8cYvo97IB49tvUSU2Gfgz/pQ5AEPQI3fW8nTYIJ6MmueZ1kMxEif8d
 Jnac6IhI+Lmt1Q2M8YQoblgliBYbOLobqX5oC+P1wTK8mNrdZcmO1b4PTQjzjceRrxP4
 /1YFeyxYefUZwkkMZqVsLZAdcGzjIRktzytfB//vpsqUcZkvfa8hH2iLtQ3LJ8Wv7j+M
 w6QUkRJ35FHQqazS7IQywaO5ttZ75S8yvYO7YX7YvVoa70tLqAh0gmGp+CofNgQIxp/x
 RbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AWW9PYoqGFrrUdmPkFR1zqFQl9klTG/mXKnSCy19Aj8=;
 b=p+dw4So71VS1b4iQRzGskFcCvV6Aa1is3/oCEsNRqT+W2bN2yobolbTWi8fkqqoDEw
 1meWZzEWH9nrIYXc2WVIswvd5YzSZ9nzep9CuT4i/IwO03Uz9qAshIZWkNbVY63FKVU/
 /e3gj+oJBoqSUtgs2JeyGu4ZXHRR2nVoY/flOUDRutMvokunsqmG2kZhtNxtZnB49E7z
 st+0jJW1JIGD+K/bkgl8ZDCz/xgEHIJenPUjuIQrpRMYWQBOR46cyP1SwUPdPMOJR0Ub
 j7y4dU9j5lrQlFYP/vhzUGEIdCpAtQO0LA6+37oaKHX1qB8LmcHNt6U06dA8Z0Fuu3/A
 yx/Q==
X-Gm-Message-State: APjAAAXccVnK7eXmlCCCVV9r513DVf6ybeq2wxD3QfFf//Z6Zq/rGL+h
 sYjPNvPSUD0HrC2MJXDEZIGtfJy63FaDYw==
X-Google-Smtp-Source: APXvYqwezfzSea+QA8HZih3ZWDdsmhSeuUFasj6L9Mnmxm97vm9q25m4menxNHJUQq5k7ZvWwRaVhA==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr3438305wmb.167.1560428114057; 
 Thu, 13 Jun 2019 05:15:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:21 +0100
Message-Id: <20190613121433.5246-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 36/48] target/arm: Convert VNEG to decodetree
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

Convert the VNEG instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  6 +-----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index d0282f1f921..6e06b2a130a 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1898,3 +1898,13 @@ static bool trans_VABS_dp(DisasContext *s, arg_VABS_dp *a)
 {
     return do_vfp_2op_dp(s, gen_helper_vfp_absd, a->vd, a->vm);
 }
+
+static bool trans_VNEG_sp(DisasContext *s, arg_VNEG_sp *a)
+{
+    return do_vfp_2op_sp(s, gen_helper_vfp_negs, a->vd, a->vm);
+}
+
+static bool trans_VNEG_dp(DisasContext *s, arg_VNEG_dp *a)
+{
+    return do_vfp_2op_dp(s, gen_helper_vfp_negd, a->vd, a->vm);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 010dc32c5f7..3baf2baec3f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3098,7 +3098,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 1:
+                case 1 ... 2:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3112,7 +3112,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
                 case 0x00: /* vmov */
-                case 0x02: /* vneg */
                 case 0x03: /* vsqrt */
                     break;
 
@@ -3291,9 +3290,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 0: /* cpy */
                         /* no-op */
                         break;
-                    case 2: /* neg */
-                        gen_vfp_neg(dp);
-                        break;
                     case 3: /* sqrt */
                         gen_vfp_sqrt(dp);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 7035861c270..79e41963be4 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -161,3 +161,8 @@ VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 .... \
              vd=%vd_sp vm=%vm_sp
 VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1


