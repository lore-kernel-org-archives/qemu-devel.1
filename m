Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C195CC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861EA21473
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qewI2yiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861EA21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUiF-0007dl-Qt
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53652)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlD-0003tp-7i
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSl8-0002o6-0G
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSl3-0002CR-JS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id v14so21495324wrr.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Qc/nXAc+oP8/OzVscPUxXsnQcb6vVHyqhqGzT5AlQo=;
 b=qewI2yiuf7OxI47ViAwCrSL6vlIUMlPRphHa+CD58aPei488RRc5XnoXgsvr5q2uMY
 nriXpz3ZEuc/W+P5R3mhNcJOzkTFnGRlCRHHGyvOrfg7EH5XCkdlByQyhR4O0iy2dO/I
 Q6TF1HFG3pmKl+/tv8EokOXWkofRuOWGqey6NueS5gRUZS4iKjPVisxoASmv84ux87zG
 5V1PqmXJ/nsrpcldoA8D31WtogZ5vAg3rnmLOZQ44vFDYHWei0y19qRJiL4gFo0f0uLr
 PdbRqERjnHlNHbO/5SN4q0DKfpntXlZtcBiAkqzIR6SNw9sloKpsWPwRJo5TBth7b8CI
 BoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Qc/nXAc+oP8/OzVscPUxXsnQcb6vVHyqhqGzT5AlQo=;
 b=YyyW5abrK5f9GfdsGMIYqJdeyF5r3jV23Ys5o9XZeoqfeiUUKjxOIbxUnTAZWPzBZ8
 C2L+W4ewET3JMoSxz2jsc4FLlWo/9zil9LwkFRYL5y9n5LzdOGXSSNU6Avx//VV0Hehj
 Dqe+bS6EMdb6NyCKJmeEnEeyFHz1TfvVT6rNTccRUBkFuTXdQw27pFJ6BFU6xzwn4BV7
 aNwmOVZ0oSsETu9ywIzDY2MOscGVqS7L6vQtcuf1bOxVxzybU2GvdnPqqwAC4pCsPEvA
 14rSb56zBXlQCmNuYgkOXGlGZnVCVKDg1UFZWZ8to23sR2AbGUbiJIVh1llw3pabLyKk
 +3Eg==
X-Gm-Message-State: APjAAAUxg0HZLBTBi82kVKdr4kzPK9udVl5XyC43nd0Jfi210DuRYdIo
 wgQJD5P9aosg4qo1anfwwGoMuQ==
X-Google-Smtp-Source: APXvYqwWRhNnvZ2XzcGrbqSyIQV9EqVGDfM2SDl1uIWHMKv3hC2BFqhihgwZM5EUoFPhXuHvio43lw==
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr13445032wrn.29.1560443964614; 
 Thu, 13 Jun 2019 09:39:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:10 +0100
Message-Id: <20190613163917.28589-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
References: <20190613163917.28589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 05/12] target/arm: Stop using cpu_F0s for
 NEON_2RM_VRINT*
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

Switch NEON_2RM_VRINT* away from using cpu_F0s.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a006ab498e7..243dbee8357 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4181,9 +4181,7 @@ static int neon_2rm_is_float_op(int op)
      * what we are asking here is "does the code for this case in
      * the Neon for-each-pass loop use cpu_F0s?".
      */
-    return ((op >= NEON_2RM_VRINTN && op <= NEON_2RM_VRINTZ) ||
-            op == NEON_2RM_VRINTM ||
-            (op >= NEON_2RM_VRINTP && op <= NEON_2RM_VCVTMS) ||
+    return ((op >= NEON_2RM_VCVTAU && op <= NEON_2RM_VCVTMS) ||
             op >= NEON_2RM_VRECPE_F);
 }
 
@@ -6786,7 +6784,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
                             gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
                                                       cpu_env);
-                            gen_helper_rints(cpu_F0s, cpu_F0s, fpstatus);
+                            gen_helper_rints(tmp, tmp, fpstatus);
                             gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
                                                       cpu_env);
                             tcg_temp_free_ptr(fpstatus);
@@ -6796,7 +6794,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case NEON_2RM_VRINTX:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_rints_exact(cpu_F0s, cpu_F0s, fpstatus);
+                            gen_helper_rints_exact(tmp, tmp, fpstatus);
                             tcg_temp_free_ptr(fpstatus);
                             break;
                         }
-- 
2.20.1


