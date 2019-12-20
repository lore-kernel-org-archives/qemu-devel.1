Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE71C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6933F2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srUpsPMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6933F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJTb-0001Pb-Jb
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF9-0004xe-Vt
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF8-0007Zh-J2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:03 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJF8-0007Ug-6E
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:02 -0500
Received: by mail-wm1-x333.google.com with SMTP id f129so9434446wmf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WZI/13hDCT0fjFRzl2cTIlf4noZlFhqAIkSEplRevfg=;
 b=srUpsPMlg5gFrn06gUCIoOXh6sETLJIP7oNITjY5LITZ4o6hCZJXTVzona6erGujzh
 JrOWvcTI6sm7Xh/VJCUo3wPX0wkSJrKsqE1VWvU4feSN0tCAU48Ycdn5/nGI856GOr2d
 lieNJ6Si6BaCBpx1G5Cepl9CY+vzWwIjZWz21zkud0oZ+7LyNXmoI38boGG+XzSmrmhX
 c5WdrPuKXb8M5zFbUjDrRPqOfVLhE3jETWcNFlaa/mMfIqOfEiiiOnB9l8vv3Yko9gDq
 zgDaM9AbJpqkdkc32VqyVpVgXu8VgNwUspQRdmopzdnYpezfdniLQe5r7uj9vw92Brwi
 q9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WZI/13hDCT0fjFRzl2cTIlf4noZlFhqAIkSEplRevfg=;
 b=lXoF5yddV60AEyc1RbfiyUrmPBxrel0l34dX08npsL/eGCafEtzwZePaBxtWMo2EN8
 +VQ6lZcw0rh36Q9JUc5aXWG7Syk8OF6b142j7j/DpMy1mCugQX+Yi+CwjPlRy23BW/Iv
 XARTxF2Nr3kJS4z6zNAsbGLmweY3rP7F30rnqG842TIjlO9cbHHyQCQj3CkNYrM9AEed
 fSY9fCwGfY0kl/qA+E4ZmBdKu1cGdDPvBcSUSX1Ewslkcyg9lzQfyg7H3Z02r2RYx8Q2
 kZjoGnW3cPSIGzoFP/OqMTfEruHjpv6hY1YOCvJsjo23gY49P3/Fc8nuxcwRRdMejPTi
 jGSg==
X-Gm-Message-State: APjAAAWv4G6aCsTzuQZM9VSegy/oFFkQL/BKKF1iSrbRPfnIR0M0+sQd
 S1axWZilgBmf4gmYlskrF2L04Sz5B8AoQQ==
X-Google-Smtp-Source: APXvYqz4CB4e7QfykI0zuZ9nWUzbw7kpOxOFFFvEXau47d9HLC/x2ahzFuGf4L1BanuYPrOeJQ1oXg==
X-Received: by 2002:a1c:1fd0:: with SMTP id
 f199mr16893618wmf.113.1576852020839; 
 Fri, 20 Dec 2019 06:27:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:27:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] hw/arm/smmuv3: Report F_STE_FETCH fault address in
 correct word position
Date: Fri, 20 Dec 2019 14:26:42 +0000
Message-Id: <20191220142644.31076-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

From: Simon Veith <sveith@amazon.de>

The smmuv3_record_event() function that generates the F_STE_FETCH error
uses the EVT_SET_ADDR macro to record the fetch address, placing it in
32-bit words 4 and 5.

The correct position for this address is in words 6 and 7, per the
SMMUv3 Architecture Specification.

Update the function to use the EVT_SET_ADDR2 macro instead, which is the
macro intended for writing to these words.

ref. ARM IHI 0070C, section 7.3.4.

Signed-off-by: Simon Veith <sveith@amazon.de>
Acked-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1576509312-13083-7-git-send-email-sveith@amazon.de
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Acked-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 31ac3ca32eb..8b5f157dc70 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -172,7 +172,7 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
     case SMMU_EVT_F_STE_FETCH:
         EVT_SET_SSID(&evt, info->u.f_ste_fetch.ssid);
         EVT_SET_SSV(&evt,  info->u.f_ste_fetch.ssv);
-        EVT_SET_ADDR(&evt, info->u.f_ste_fetch.addr);
+        EVT_SET_ADDR2(&evt, info->u.f_ste_fetch.addr);
         break;
     case SMMU_EVT_C_BAD_STE:
         EVT_SET_SSID(&evt, info->u.c_bad_ste.ssid);
-- 
2.20.1


