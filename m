Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ECBC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5728820661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+leqigJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5728820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Zcg-00039V-G1
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTw-0006CP-5g
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTv-0004cH-8S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:56 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTv-0004FX-2G
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:55 -0500
Received: by mail-wr1-x444.google.com with SMTP id w15so13493860wru.4
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QC2sj7hRnULzZHQ/M270NTSzgdnZq80bFajxC6Weuc8=;
 b=o+leqigJNWcFqwtsJhWALp7Y5vmlcJFbosiZSHof164p8ZMOLigeyVPjCKtYGEtQzM
 a5OqoFFz4+HmGrmMZCsCINSWcob29qU/P6x/yJEg/vQztpBBmjPPaAQOe4fmDtqN0TL2
 0TI7h0nTrFVkKCtlv4zSBhGjI4VlY9ZD7yOg1DV6Yq/Y+NlON53bmKFeQtW67krmq/3h
 rKJAMm/5reOI7gpLqCVwKj5S+2q2gjI6rFG+MBYIhYLa0lvjmiAagTXbpVwpd88v6qcj
 shHvU+Pqa+pGQcWD2+aqKZkq1s1g/EOldp6ykIrsz17Tbr+9HGlk59S7oHs/jWfu6CQa
 Y9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QC2sj7hRnULzZHQ/M270NTSzgdnZq80bFajxC6Weuc8=;
 b=V7Qy0R0TOY+w1SobzbGBEDSQNOApr5vZAXSeMFm06kLFrr9TytGzglDgqOk3ZKH3DR
 Pr3FunCDkWXyPHps0DWg5LYGzTwlZ16+JR65rFHFpff9DpVqxZQI5TCR0Q2HC5I4Ql64
 SfaVG62ICqURapHtFBCe3VT1YEkWkgmaM47F+Uh79nCt9fnXTGc67JealB7jcVYOil8j
 NRRV6185QeS90nwPaVnBMrwmYuG4rcIozelQrtUHA/Ahta7gVlg1r8FMVY/Vj42n+wPG
 lmFeickZv+2Q5ibzeTDZtrFFFhokz+Y+CLQUpndBYP4d3A3U21ZxlotlQrK+wtl1+cCQ
 atOQ==
X-Gm-Message-State: APjAAAVRvdVQHfbLNysgBWikjZq4u6tEGJa9Sg0e/eHdBf/CjovWchgH
 gJAIcryP/B7SYyW2z+wcyG73VQ==
X-Google-Smtp-Source: APXvYqy3+vOVRopjenWuO69A+GCgmGMlB+78AKUNX+r94f/3SpcoEJoFgVaPefTU8KnvwuIRYQgDEA==
X-Received: by 2002:adf:f302:: with SMTP id i2mr9605140wro.21.1581442664016;
 Tue, 11 Feb 2020 09:37:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/13] target/arm: Correct definition of PMCRDP
Date: Tue, 11 Feb 2020 17:37:25 +0000
Message-Id: <20200211173726.22541-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PMCR_EL0.DP bit is bit 5, which is 0x20, not 0x10.  0x10 is 'X'.
Correct our #define of PMCRDP and add the missing PMCRX.

We do have the correct behaviour for handling the DP bit being
set, so this fixes a guest-visible bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index cb3c30f1725..c6758bfbeb5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1017,7 +1017,8 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
 #define PMCRN_MASK  0xf800
 #define PMCRN_SHIFT 11
 #define PMCRLC  0x40
-#define PMCRDP  0x10
+#define PMCRDP  0x20
+#define PMCRX   0x10
 #define PMCRD   0x8
 #define PMCRC   0x4
 #define PMCRP   0x2
-- 
2.20.1


