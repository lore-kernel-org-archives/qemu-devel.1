Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847E7C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE262082E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 01:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxVMEH1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE262082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiTBT-0003ke-UX
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 20:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAI-0002QT-SA
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAH-0006NP-RM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iiTAH-0006Ig-Jh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 20:02:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so11066240wrt.6
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kfmw6Uf2kP9Qr8LqH5cHUDPYAsKSSyoM6o3xZGkGFTM=;
 b=gxVMEH1o8hLK4X1OroQKSWLUqSH27r8ah7WLeG96qmNuwbRES7ycmeMwAw+ybSjlrP
 qszIfVVfluKAwSZYPdtQAgC0NHMq0vDy5UK3AF+eGOz1zIUygqQAARxqy3YGVajCkZyr
 QfES6VEoQb17RHHblQArmJo+oi/e1edptF4QNFALm+F1DDhbSQWnO5C1r18WjCUiD+rZ
 fPsO77FJTFmEuKdG31uGADO/JzykMFT7PzsPD0CVK1yEnBy+OUquRzzp6JTCRCrmQk50
 cSJp7ZKrkZA70GzV6YAEiYkXQjaJUHXNQvPhgH4Cjn0XHt/+hESHlBA0cXR5KhZWofnw
 tGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kfmw6Uf2kP9Qr8LqH5cHUDPYAsKSSyoM6o3xZGkGFTM=;
 b=euNdzwbs0FJjvYcay3h4CmcHiXuxyeZHILvtGd2UkRqXBacGlvQtBzjdKRGXyPeKrn
 f4evaR98eopBb6MZmueOpV++MVkEsjTi3c8GQSGZxA8c+dNj2CGT3lCL/fOCGBJQzIdb
 QmtP1YqTFOuYyhTgVgrunLKsZKrAAwBMGJn2qOngRu4hjPcRZBeBXN2phC/pLKHRIc4/
 krta4jFc52a25JlqymGWXYXzkQFoJSNH4+2SA6UjSF3WirtcNjcL//dlu/f2GFnC+XgZ
 cqf/7uFNnvr7rua1BOQ3KO/lSX2D0iSrCwvVo93SrZQ72DIruODmgXaBq9URcSWvHwGV
 U0fA==
X-Gm-Message-State: APjAAAVwv6+O09nMs095ztQOZVv1OpUlo2qHmvqvrKoXNPWZAVOSdzdU
 SdclcbemW5uGwO7/urv6vCM2JbvF
X-Google-Smtp-Source: APXvYqwhka/VCdlQhlOXb2ZfIz2GEHkTABIDQsB5FPROSL+cxHn9HayzTjO4VslfB5b921t4vvScEg==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr17536943wrx.393.1576890160380; 
 Fri, 20 Dec 2019 17:02:40 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t125sm8449596wmf.17.2019.12.20.17.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 17:02:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 1/8] hw/char/avr: Reduce USART I/O size
Date: Sat, 21 Dec 2019 02:02:19 +0100
Message-Id: <20191221010226.9230-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191221010226.9230-1-f4bug@amsat.org>
References: <20191221010226.9230-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the datasheet the USART uses 7 consecutive 8-bit registers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/avr_usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index cb307fe23d..becdb87847 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -280,7 +280,7 @@ static void avr_usart_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
-    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 8);
+    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 7);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
     s->enabled = true;
-- 
2.21.0


