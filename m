Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD85DC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B80A2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qW7pyOpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B80A2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4PU-0000OG-PQ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44174)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4HU-000802-97
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4HS-0002AM-3g
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:20 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:46243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4HQ-00026z-Ck
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:16 -0400
Received: by mail-wr1-x42d.google.com with SMTP id z1so2539230wru.13
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yj2MtKDVZXdSKXJUOki1opdC2pkjoIjecllTKPnecKA=;
 b=qW7pyOplwRLn1LKQJRwt3ABOlbmEVfj3WNS2lEDnWNv/raBsnO7br6KaY7WsyTqqwJ
 Y/wUYA8NqiGlNYvRrns3fv1E3vTaaXFE0WAq9o/pJAL7uY6M2H+RUZ8Cdplm4Dv8+yAu
 mrhyr7vxhwwsvNgThg3xyoQsH0q9j86+eRmk8icBumpOMrzq6GmDDe2+uA+SAAKbZdTe
 umul4btJVy/ZYCEIeG7l131bzXTQMUaMgOZ4npM0chCLA0Na660UyzHvVxRemEBhoUou
 rHaEJ8OROYzcRvOXDfTAGggIqhN1g3KWZ9SoI17bPReOM27u/j0cgzo8z8wGBq6qp/Pk
 qb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yj2MtKDVZXdSKXJUOki1opdC2pkjoIjecllTKPnecKA=;
 b=SXG/J4Qh204mNeCht5YU0uvDIPiJoripE/DxsPSGdhDD5XHcYL54CyWjHh4Td7kfXs
 s1rvwyDh9dXoptmaKarmBx8GmFqvaMdFXok0G6wgP4gFtr2Jly5WgmdeCYE/v/PgXETA
 D6kqJ4wqj/qrNjhWCRgYsQiwCkObCD/sIRCZWA5dxXTloPXLMzY7vNEEEoXf+bH0R21k
 0Wg0Yem7SOd0k/nG6PzerYzD1IWPbM6VpPOvUlXhxRDsWzCs0aldXKAtn64stJW3aOJn
 i9BiDrYioF3hqtXFlcy33p5mIJ3rVBco3bi85E3Y4WQYDsUbE0AhZizwyg68IfpgyOOY
 SNlQ==
X-Gm-Message-State: APjAAAWcccKjy+08mGATJtpJizRgzm6gNg8LoXdvnG9moD3UZUdo+kbP
 sSE/Z8PCBECTYGb018V+PJtC9x29yS9eyw==
X-Google-Smtp-Source: APXvYqyCnk/ZUVWb0raidbfK6aysKYbIj/GEeWm/kxvRJBLRsWwzvzgAqMjjgorVdiPA4R/9qVPPZg==
X-Received: by 2002:a5d:5186:: with SMTP id k6mr37209531wrv.30.1562256493932; 
 Thu, 04 Jul 2019 09:08:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s2sm3849690wmj.33.2019.07.04.09.08.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:08:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 17:07:58 +0100
Message-Id: <20190704160802.12419-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
References: <20190704160802.12419-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 5/9] target/arm: v8M: Check state of exception
 being returned from
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

In v8M, an attempt to return from an exception which is not
active is an illegal exception return. For this purpose,
exceptions which can configurably target either Secure or
NonSecure are not considered to be active if they are
configured for the opposite security state for the one
we're trying to return from (eg attempt to return from
an NS NMI but NMI targets Secure). In the pseudocode this
is handled by IsActiveForState().

Detect this case rather than counting an active exception
possibly of the wrong security state as being sufficient.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190617175317.27557-4-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 330eb728dd5..9f8f0d3ff55 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -860,7 +860,19 @@ int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure)
         return -1;
     }
 
-    ret = nvic_rettobase(s);
+    /*
+     * If this is a configurable exception and it is currently
+     * targeting the opposite security state from the one we're trying
+     * to complete it for, this counts as an illegal exception return.
+     * We still need to deactivate whatever vector the logic above has
+     * selected, though, as it might not be the same as the one for the
+     * requested exception number.
+     */
+    if (!exc_is_banked(irq) && exc_targets_secure(s, irq) != secure) {
+        ret = -1;
+    } else {
+        ret = nvic_rettobase(s);
+    }
 
     vec->active = 0;
     if (vec->level) {
-- 
2.20.1


