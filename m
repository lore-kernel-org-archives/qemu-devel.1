Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D383DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF6B2158A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p50P8t8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF6B2158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia8yv-0007lP-Kd
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x9-00062h-Jy
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x7-0004Ih-Ji
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x7-0004HD-Dl
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id n5so9963121wmc.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jb2tbtaquf5VPvDAi0c6Lc2EAVperS+YrEI9rjM8y3s=;
 b=p50P8t8KmQXkFd4gXWDe51BHDwBJQeIarz6PfZ7ZE4rJMcJuAJ6ckTovmFHNa4TvEk
 FGi2jtnZV8pu7egesd7HeK2vfE4UB2uIcNK95r/8Imb8hysTrgV5DELmWtgZQ9wNHdN6
 nvVkTLaw8WwOj//4xC/a7/I29vOOaMHXWOp2MYrXoQ7iFY8usyFhbwcn3B60qQmmcBJf
 rx9u/ylfTyno66P7ATNHnk04HVrbP359AbXAxAqHX7r9Y9o2VVpmRwA5PZdParTJ3ejz
 cwB82d6WHaHfT/VfpTfELi1t7+7eWMUFKUQ2cw2dCJM9IyvNDip9IwrrZrjBg9ejCttT
 N4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jb2tbtaquf5VPvDAi0c6Lc2EAVperS+YrEI9rjM8y3s=;
 b=iDckRlyfEBGb8bQFg3krRrTUSkC37Ltr5T6ASI1CNw8ZG/jqQJ7Yb5n99HRx9eTz/q
 9laEO53R6e+VauE6qiBpZndWOtCQnxepEf9Sg8qQZtSOYG0Wt532epMXp/Map9iQ3qSY
 CMBCPRdSd0tWIQv7QS4OA6ruL76sNMgtVwGcaHe01MpbVS/oh5Mwv1lNYCT5FDs+QuXR
 CqMw7klYNpnaGPlmpgR+jplZE3MYaemGY/AeIVJ4hA50yYtPKfmIg6s03x1Vb5xyHedm
 dGvig5mYyrrJLD3Qj6bKXbwomaIoxZd0lpzAgB8GeaUwaDoT66VMP3QaZqheEqlgSwxm
 HwYQ==
X-Gm-Message-State: APjAAAVTqd/LWgKkZtg3zbgTff0YWInNRvveh3x9ht4sDOZj1jjg75Nu
 8yUC0wE/bZb6Orf+55Ado5pgfJRB
X-Google-Smtp-Source: APXvYqxbBzJYE08XuYkn3WvaGb5yc4wXkxMSc4VG3aOGwn3uCVC4M/bILGZOMqQYPJzdhsY4sqSizQ==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr7471477wmh.161.1574905840352; 
 Wed, 27 Nov 2019 17:50:40 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH 05/10] hw/char/avr: Reduce USART I/O size
Date: Thu, 28 Nov 2019 02:50:25 +0100
Message-Id: <20191128015030.27543-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the datasheet the USART uses 6 consecutive 8-bit registers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/avr_usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index d039689c56..ba17bdd470 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -284,7 +284,7 @@ static void avr_usart_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
-    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 8);
+    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 6);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
     s->enabled = true;
-- 
2.21.0


