Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564DBC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD37206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVz8/vrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD37206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAeC-0007Qy-9A
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaZ-0000Sn-NE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaY-0002yR-Fp
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAaY-0002n0-85
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id z13so5011808wml.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mMeVBvXlMaaa/OKSczXDTF+WMf2stZl9iIzAXVliKXU=;
 b=TVz8/vrniLSGvQUUqxkB7fJr3f5f8+SL3+7oncsZWaubu2IPu9FjM2dP002Z/vE/Iy
 uPVEx1bvaPmGDb/idnH4zHpjCegk6sbWgBpg+kD6LcPTKVFUm+EK593A880lPbOT1txC
 nf6ssEO6594+liYvyhDby5ChjAmzGKX/qLq1X+wGaV8YZtyxnUBwb6J0EPNakQm/g/Og
 rvzlccByC3nuj7AsSICIl+IlbZORDj+7+Q5BkcXxiDUjURKOyeWTG9ynBxN9yjnlozEv
 cgvzdsRx0teBaM8DFcp915WQBnY1TZ8eYAar1EG7r4BZQkSPChVohAQuO5NIj9hF+nMs
 NLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mMeVBvXlMaaa/OKSczXDTF+WMf2stZl9iIzAXVliKXU=;
 b=sGXqEfqg0EFvzTUcQFaVKtErkhE/snZG+v8bHOeLkCrBLdQQjFTIlRKsODAQH0jOcJ
 5ptEvDa1YISMeRuH31IEfjhwf8PfqYWY7Lv+ngFtaZmAdSdGOJ+1MENhHEaHcRfZ/n6q
 JAtiLgWjfdSvBLOZeBrR7XUpHlBrgvtOKmlTB1U3NssVikN7SB65ReUSJqkMNT3Jqz37
 Y2xl+fNE6FH9X82qhOUVoDauLxpFrAHEjEHB9J7mNExUqmEvP4p1vry0n58zioIUT9pY
 NA7Mf03+IqZ16weqrcJnrWuCf4aDrd3DJNp0cEgBR3HffptRDjKrrmUbWXv7bR9IqHYH
 sBLg==
X-Gm-Message-State: ANhLgQ3EDnQV7LhznCOgWuy9zKv5mRvh25wGRSCJqeskkVJjM+MkWlzN
 aF9Fpq5IXDJ8CeQatQtW3eC486WYJWVuSw==
X-Google-Smtp-Source: ADFU+vtky0W0KZxhChVU1MXIn27EvriV+qOStnPQpY7qauCNvjeqliLpZmiA0D1gSOf0wbC3bAb1BA==
X-Received: by 2002:a1c:984a:: with SMTP id a71mr5124175wme.185.1584445248897; 
 Tue, 17 Mar 2020 04:40:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()
Date: Tue, 17 Mar 2020 11:40:34 +0000
Message-Id: <20200317114039.26914-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

From: Chen Qun <kuhn.chenqun@huawei.com>

The current code causes clang static code analyzer generate warning:
hw/net/imx_fec.c:858:9: warning: Value stored to 'value' is never read
        value = value & 0x0000000f;
        ^       ~~~~~~~~~~~~~~~~~~
hw/net/imx_fec.c:864:9: warning: Value stored to 'value' is never read
        value = value & 0x000000fd;
        ^       ~~~~~~~~~~~~~~~~~~

According to the definition of the function, the two “value” assignments
 should be written to registers.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Message-id: 20200313123242.13236-1-kuhn.chenqun@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/imx_fec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 6a124a154a8..5c145a8197e 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -855,13 +855,15 @@ static void imx_enet_write(IMXFECState *s, uint32_t index, uint32_t value)
         break;
     case ENET_TGSR:
         /* implement clear timer flag */
-        value = value & 0x0000000f;
+        s->regs[index] &= ~(value & 0x0000000f); /* all bits W1C */
         break;
     case ENET_TCSR0:
     case ENET_TCSR1:
     case ENET_TCSR2:
     case ENET_TCSR3:
-        value = value & 0x000000fd;
+        s->regs[index] &= ~(value & 0x00000080); /* W1C bits */
+        s->regs[index] &= ~0x0000007d; /* writable fields */
+        s->regs[index] |= (value & 0x0000007d);
         break;
     case ENET_TCCR0:
     case ENET_TCCR1:
-- 
2.20.1


