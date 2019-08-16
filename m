Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE4C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934C421721
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcGt2eOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934C421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycNv-0006I2-I9
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc73-0003Xt-Ob
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc72-0005lK-Pk
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc72-0005kV-Jy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:48 -0400
Received: by mail-wm1-x334.google.com with SMTP id m125so4047403wmm.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2z9eRXxGkGDLfMKepMdpB0DZoxXwzKF1DXZHdT7+7v4=;
 b=JcGt2eOV0a+xUTT7te5LNFg+sF0Hbmz1RatopA65YqiCjcPARH5xKEaQV+uh+be/vt
 suRNg6IoEabN4Ct8zZh2FQCBE2RGAJwvlsy9qYcYvD3JEjR1N4GcSWCYscL2oIPuXUWZ
 +orwrP6ygI0WlzCL95hXT7K297rsEU8xcbJW9DbjvpKf+0NAqBvTKJAfxnUjf62bND2o
 T9gk+g6xVNO5LX3sTVm1WjTYSOLW0pyLxmNKfvGk/SJcGJDYJHbQJuWBJjtctZsCvyLu
 0s03Y3euldlfJRcByfKuhgGjnyBgNYTvQ8zbTjhQ5feNBbQCqrJS4Db6+5L70G9WIyAW
 n0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2z9eRXxGkGDLfMKepMdpB0DZoxXwzKF1DXZHdT7+7v4=;
 b=Cn/9bppDZtuPZQip0bI4XOg6iEovjA0HzGAjpbBx1Revpo6eOipLUGKTnDkhIRj07S
 NecO9FHaSSkSRejldzPrpCsLyZknwYaIHVRwhBu5Aj/1vMZxMZNSVTgdYF0hYdGtd2xM
 p6H/hvi6JnWhW8JqkO4UYJA8OlK8ZKLZ/bhUcNyXys0eg9qP6a4Fjoim7Gwbf6cbfM6M
 E4akzn78TFcYCM8K+5uueH1rvBO2rwIq4tsjAMIZ7uRk9+anplOwYUG7h4Dj6L9BqL+k
 E/FY6Sji7R76XcPTrZi8Lwn5o9GASh8lK1/vWoXVGfsHJn/vzGwbuq3pCE7Zr04roHkY
 UdLg==
X-Gm-Message-State: APjAAAVDly7suwGxcjFEP+85iuihma5Ag9rVRaYui7Pmg1rQBtVwDEn0
 cNfWA4klVC/lp0YbcIda0/sMYkGgMyjMAw==
X-Google-Smtp-Source: APXvYqz0uzCnfQ105gpJZOEg9x3b9P+zA3WpKeJ3Y1PIlaxjV4Qr+0XEnQaCY0mWttKXif/9+UVSSA==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr7184869wmj.174.1565961467468; 
 Fri, 16 Aug 2019 06:17:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:13 +0100
Message-Id: <20190816131719.28244-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 23/29] target/arm: Use tcg_gen_extract_i32 for
 shifter_out_im
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

From: Richard Henderson <richard.henderson@linaro.org>

Extract is a compact combination of shift + and.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190808202616.13782-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 34e65cd80c0..14d6b6d4d28 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -605,14 +605,7 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
 
 static void shifter_out_im(TCGv_i32 var, int shift)
 {
-    if (shift == 0) {
-        tcg_gen_andi_i32(cpu_CF, var, 1);
-    } else {
-        tcg_gen_shri_i32(cpu_CF, var, shift);
-        if (shift != 31) {
-            tcg_gen_andi_i32(cpu_CF, cpu_CF, 1);
-        }
-    }
+    tcg_gen_extract_i32(cpu_CF, var, shift, 1);
 }
 
 /* Shift by immediate.  Includes special handling for shift == 0.  */
-- 
2.20.1


