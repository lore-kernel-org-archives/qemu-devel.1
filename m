Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C8C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7993B208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVN4s7HR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7993B208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuJM-00011W-QE
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcu4d-0004Ss-75
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcu4c-0005xM-6Z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:01:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcu4b-0005vV-Uk
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:01:34 -0400
Received: by mail-wm1-x342.google.com with SMTP id s15so9712757wmj.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GBKRxJrHCawiQUYyR7sgJjC2fNXOZCCtdwiyy0fAiko=;
 b=bVN4s7HRjge84dc4IGG81AnrfbHosBSh5+BGZvbLhXtnNkUUqpeSXEz/nCFCpUym8w
 x6QQqHGIwE8bMA0LDwhK89Hzleac0QNTwN/aUx4hT+DB0LjlGJdOrPppvT1rOyuhvRRc
 tNmv5gmtAtLApxER4Wwr/4CPJWKd6dssPK9g0TBj97Uwk7Da4FXTfxhKidqlQlUrVEfZ
 8z8eE0gI1IAyyQHZYCEBwjwXOvLJm17ByOpo7MWrmm72bI/n8BjuzZR2pEU6kW7PQCkG
 1jlO2K9IcZ4HyYrkOUTTiBwK5fv3RHFzGhexhC/0pADG1iU7kHNlDZDVy67jPpR8vTF8
 J1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GBKRxJrHCawiQUYyR7sgJjC2fNXOZCCtdwiyy0fAiko=;
 b=iQAoH5bkGG9ZNdqFglMstm1qwIPdsaiUOxjmLkZ0nDuQf6HjFNkUQofYoLoELHGD2j
 eYerVdlEoePMntYBo6/aShHWQW+qd3Xw09IztCnA50tN8hGhsVoAAWyFPxXNY0Cea5Sg
 vRi1U2Ga8LuJoK8agOzbH4KrrvKM1xtRwQm1Ww2ebD0HdbMcxHkVdS6W6HwvachJFwvo
 pMVvafPmWkyOg9gLqm0KMkTZNcuCpi6M79qKxcLnsfxRc9tRGJoMCylhZEZG5ImleInF
 xpp3/ePvW9B4/OPHhw3rY77KiLSODFmEDojy9k4XAvxCcmzvwC6hdAaG5zeQ45VKHN91
 5T7A==
X-Gm-Message-State: APjAAAWZHWhQNDlGP5D+RW0bbrl2ShIKJg4nj8gnJA3LjMcWWrK/fXKj
 iPz1aiudYjyEQRaTVthePvNoFQ==
X-Google-Smtp-Source: APXvYqyWduhiLSzdoeKrsLvUXnl58Uj47uxjPNVuMJoOG6gJojLxKpXBlFFBeexVLYfIgIgdvfJV0g==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr18971384wmb.119.1560787292656; 
 Mon, 17 Jun 2019 09:01:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x11sm15545416wmg.23.2019.06.17.09.01.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:01:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 17:01:30 +0100
Message-Id: <20190617160130.3207-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH] target/arm: Check for dp support for dp VFM,
 not sp
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

In commit 1120827fa182f0e7622 we accidentally put the
"UNDEF unless FPU has double-precision support" check in
the single-precision VFM function. Put it in the dp
function where it belongs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I just merged the pullreq with 1120827fa182f0e7622 an hour
ago and then I spotted this bug in it...

 target/arm/translate-vfp.inc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 348173d6026..deaddb04421 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1771,10 +1771,6 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
         return false;
     }
 
-    if (!dc_isar_feature(aa32_fpdp, s)) {
-        return false;
-    }
-
     if (!vfp_access_check(s)) {
         return true;
     }
@@ -1838,6 +1834,10 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
         return false;
     }
 
+    if (!dc_isar_feature(aa32_fpdp, s)) {
+        return false;
+    }
+
     if (!vfp_access_check(s)) {
         return true;
     }
-- 
2.20.1


