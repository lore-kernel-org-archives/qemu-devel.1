Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E748BC35655
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B638C24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oi8PnEj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B638C24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5831-0008J6-VU
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5820-0006Ts-Rk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j581z-0002Tc-SA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:48 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j581z-0002T9-M3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:47 -0500
Received: by mail-wr1-x434.google.com with SMTP id w15so1996176wru.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LnZwcALAQoLYwtLg7hngxVlKU2Xi0Rug4qNNkDV9UPk=;
 b=oi8PnEj8oSnxe9G6eaPjm6z7AAaUB77jlRhs87NTI4MZR9S5mLP1PAvzXEFA58AZic
 h+dkWtOC58rvvEPpehoJlEBXd6xge+fg84/rkCqwc9XlhKs93kBX22Ddz/Mx/Ei7iHig
 kmJMzqhRiXvatS72dRpZqVbxne5BDV3GBuImMNyCyb37vli1tM7X4dYx9sC2DpOPzD2+
 wqXLvDKsZ9hc+F4ogk/OGzYmYtoXZcFZzPzXSl6ND/GGseZ6DDwHN7l8z2YYtY6J7QSD
 34sTetIoRSxm/G6r5f7Yudf4fLOej1HK1DNxAzsrrD2wbV6CQdsi1NphKPWWkgsySP71
 zPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LnZwcALAQoLYwtLg7hngxVlKU2Xi0Rug4qNNkDV9UPk=;
 b=mZEKf+WxAKXFpraY0Z7qwrCXOBDZOs449IH22/s+RH5rcYlGFtxguYmk1Gww88Vrpu
 1MRAmVsXOnuMI56sVSsiZq6BsTMx9VVYLwF6KxeZHGvsn0hAn5yxKZMqRa79D17ccQ8E
 bAn3IeVXeGAwkNOLfd89TsVvFjLAzGcFhSF+5zbYnAKVyMeka3CTAYL3BVfjzKxe24+N
 NUedCaW0a2q/Zd3K6gwFF0KSPrxJHHIWQqBTmEejhGFmjljWYaJIwMLSAf1peXZTA9v7
 9SUDODs/h3cMtqRgpomFYn5ZUnoAUZXCIg0QmewAFgMEe9iPc1qQSAfMaLU+PofPo1a/
 g3DA==
X-Gm-Message-State: APjAAAWtsBkj8c+5LaF9G0We5RfhtFSu1RKrwRtfvepPuqk7cX63orSv
 Xuq5Q57kMAgNURFEltcatjeFY7wydjwbLQ==
X-Google-Smtp-Source: APXvYqxoDFtzxcohHAYxsNP/Z6z+V68R3ci6PT+sYafanxsIRT2cqDggdSmEm+aSIyI0iT4R4B8CEw==
X-Received: by 2002:a5d:65c6:: with SMTP id e6mr21378938wrw.45.1582290466416; 
 Fri, 21 Feb 2020 05:07:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/52] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt
 Clear' register
Date: Fri, 21 Feb 2020 13:06:51 +0000
Message-Id: <20200221130740.7583-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/misc/iotkit-secctl.o
  hw/misc/iotkit-secctl.c:343:9: warning: Value stored to 'value' is never read
          value &= 0x00f000f3;
          ^        ~~~~~~~~~~

Fixes: b3717c23e1c
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200217132922.24607-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/iotkit-secctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 609869821a1..9fdb82056a8 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -340,7 +340,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
         break;
     case A_SECPPCINTCLR:
-        value &= 0x00f000f3;
+        s->secppcintstat &= ~(value & 0x00f000f3);
         foreach_ppc(s, iotkit_secctl_ppc_update_irq_clear);
         break;
     case A_SECPPCINTEN:
-- 
2.20.1


