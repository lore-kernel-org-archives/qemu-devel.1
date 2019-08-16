Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A6CC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073A92086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhqT884d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073A92086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycNm-0006BM-HO
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc78-0003eS-Bb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc77-0005rW-8o
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc77-0005qS-2U
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id p17so1513477wrf.11
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YHhjNjwiuTlgJOKTQ/7AOJdELYDLE8lxn/VDkIb25Mo=;
 b=DhqT884dKMwlY57TG8JWuxdJ6/LNehvNpY8gGSqzVD2TQri67uVzmAt7k02ejJ9Vqy
 X4OaLclfVoUpCGCBGB9pC9KioyBaDi/rhJgpPhmVjp5T+32Vfqiai9JUXsYrsLGoVwv6
 j1oqg6CA2OPZmtYd7RjAR2o399hmNaanpeuOmXinQzrt8NXMn7qMWpymW/6QFIuOSnIt
 qUSrY9lGb4NW9d1R+EkEsQ4DK1WVIuqYm8KjPAX0iRBiOSQlg0quFk7Mu7DHc3FWt2n0
 xGeTg6HmAilgSJLDIW+Hkn0oGg2ZHzvV4EwUCXbFJlGT+8A7rdrryeuHa1g5NIkSbOpu
 5wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YHhjNjwiuTlgJOKTQ/7AOJdELYDLE8lxn/VDkIb25Mo=;
 b=GEpSG71l5UmJRI5XdzLZ5mXEviqvuVTFwd3sDc26Au/IjIkRsudKF/fyxU/XkQZAm8
 QW9PnDp15rcoL+eI375Jm7WeYD/3qUVYQSd/uUuXRdvftoMWrgI7jNV2RPQ6i757dxhe
 7N/hkL2TyJs5Q9HFFPLfuv6qTDCarbqaYR992FJZsI4Kmd7MA0YUNWjck23e5HJ7e/Al
 1My1nsoOqP07va89bXgULJZkvqiNBZTplNxTORgyUnIH8O/Aet8mzhu6LVyAM4KXP47L
 LR9CC7Kmp9D5w1Sb9oZ6lH+i4sFIq2Xf8Ksqsak1guiwSd7Ud2XDcIrzntYAKpSyzmdt
 ibGQ==
X-Gm-Message-State: APjAAAW9M0PMgs0WhYVJk+8jodjd8Vk+M46SX4Ggq3uY6/IZ/H3lfhL0
 +ipLvgWX3S2ababDrd6BkGnzRtMDmTNRmw==
X-Google-Smtp-Source: APXvYqxRCKxCjQ7PM2ZqXsKpAmGeHCPZBJStU1vWVwVnfKXqREj7TIvqK5nqirNkSuyABGTDAYppMA==
X-Received: by 2002:adf:d1b4:: with SMTP id w20mr11084969wrc.301.1565961471798; 
 Fri, 16 Aug 2019 06:17:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:17 +0100
Message-Id: <20190816131719.28244-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 27/29] target/arm: Use tcg_gen_rotri_i32 for
 gen_swap_half
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

Rotate is the more compact and obvious way to swap 16-bit
elements of a 32-bit word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190808202616.13782-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 02ce8d44fa1..2e160646206 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -444,11 +444,7 @@ static TCGv_i64 gen_muls_i64_i32(TCGv_i32 a, TCGv_i32 b)
 /* Swap low and high halfwords.  */
 static void gen_swap_half(TCGv_i32 var)
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shri_i32(tmp, var, 16);
-    tcg_gen_shli_i32(var, var, 16);
-    tcg_gen_or_i32(var, var, tmp);
-    tcg_temp_free_i32(tmp);
+    tcg_gen_rotri_i32(var, var, 16);
 }
 
 /* Dual 16-bit add.  Result placed in t0 and t1 is marked as dead.
-- 
2.20.1


