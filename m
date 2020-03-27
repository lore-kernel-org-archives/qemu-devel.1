Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DAC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 23:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9436D2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 23:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/eYcrFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9436D2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHyI2-0008P1-P1
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 19:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHyHP-0007wD-Ri
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHyHO-00016D-BF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:20:47 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHyHN-00014n-Ka
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:20:45 -0400
Received: by mail-pf1-x442.google.com with SMTP id k15so105547pfh.6
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WaeqFFIY+sHy+HH5PfzjAZUCxfNQ0e2bmW0/SuykGPQ=;
 b=D/eYcrFWS6m1oHAhPRy6WGavZuZ+g0qF3Vy+lYNY1Pg/2PexGtjjTSGFyYST9f1TRG
 6urx44POx5fd2Y4i7EXxu8mp3bsZEcMBJJAUQ7O875tpsrmIqkjh0STXRPBA+ng4Udpk
 lgDYy/TfgGARtjbVIXPZi7YW1BODeMY1BJ2z39dfAcouk9lxfOcJhV+XKDuH+TarpTX4
 wiy183yc1GrYo0nfQ56h9dtXC5VoOI0omRcFBC9DcMeBQV6lgl61QIoHf3U655R/g4TU
 C9i5del6/9RN85kAW0YnhezhVjA83v1oKZ6geGZ26bXHA0LDhD3dwMuEz/joRWoi8jkj
 oqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WaeqFFIY+sHy+HH5PfzjAZUCxfNQ0e2bmW0/SuykGPQ=;
 b=IieufEJdIQFasaBjd3RB3HD5r1ZoO2M0EM8vN1df6xoCUJ+PZzNiSEPaIWYbdrMfxv
 zgwNLN94YVwfx7ZDzMDjzMrVqb8xKu6bIApmRsv0OpCC+QOaSQ/NtpKqDFXlGxyk1hbs
 /axk3A+jtn1nDWccJe1aGY7NhMLGUmmZnIyCidZaZM3y5abtm61IOhuTpZmSS+YMW50R
 /RLF/8cwK22aUgDZBeBOOTxsv95kWCP45IazYvr1838zNHUm7HTiFl4B69xG/kSjeG9+
 yGvGwIw5+58xZlOl9SotHGzduQt9bl42nbmSHXtzEyPLH7b6QdDrraJdKuTQwGmzTg3Q
 KrfA==
X-Gm-Message-State: ANhLgQ0yyJstRsUFUaM/LYTaQ6cYYeDLalBIgJhObgbM2YkTRqoe+bAu
 RdmidsoRdIPrrz/ecH5+IuzZG6689p8=
X-Google-Smtp-Source: ADFU+vtmm1iIoz68y4mbNs7DcgKCq6rNVdRtYnBpEojLVnVKOnZsOtQlcXWxlSxN/q/aRIulBLcbrQ==
X-Received: by 2002:a63:9143:: with SMTP id l64mr1647877pge.75.1585351243864; 
 Fri, 27 Mar 2020 16:20:43 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i4sm4933665pfq.82.2020.03.27.16.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 16:20:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] softfloat: Fix BAD_SHIFT from normalizeFloatx80Subnormal
Date: Fri, 27 Mar 2020 16:20:42 -0700
Message-Id: <20200327232042.10008-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All other calls to normalize*Subnormal detect zero input before
the call -- this is the only outlier.  This case can happen with
+0.0 + +0.0 = +0.0 or -0.0 + -0.0 = -0.0, so return a zero of
the correct sign.

Reported-by: Coverity (CID 1421991)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 301ce3b537..ae6ba71854 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
         zSig1 = 0;
         zSig0 = aSig + bSig;
         if ( aExp == 0 ) {
+            if (zSig0 == 0) {
+                return packFloatx80(zSign, 0, 0);
+            }
             normalizeFloatx80Subnormal( zSig0, &zExp, &zSig0 );
             goto roundAndPack;
         }
-- 
2.20.1


