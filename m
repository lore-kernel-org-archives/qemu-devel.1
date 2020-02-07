Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEEC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C359A214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgSKrEJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C359A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0588-0008Pn-Sy
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iL-0001ZF-8l
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iK-0003ey-3x
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:37 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iJ-0003cG-T9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:36 -0500
Received: by mail-wr1-x42d.google.com with SMTP id a6so2914592wrx.12
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Uk+6MfSy1xJAjRHyCw9qUpcoTRYgUYoWZjo2KJmyMU4=;
 b=cgSKrEJtSc/kVcDrRuXnyA180r2o0rJkNWBz/SDTSn90Vm8c6/iJEVFu7d6X372zDj
 Fri63tSUX2kHAEU2SnjICHx4FtSdtXywOSaVjl9NM0gowDRx1/j0CxpzvDtJXuF4qy7L
 yKfKW2Q57gMvBK562p/XckOeXBEuxLJyzR5lXHkTMCVqls838/I87IixmD24MSxiE39m
 JQFHmu91aaaGtYuoQU8tcIkqg33ad0aAl3otLYRxWSqGgxEygtA1pAl5Gkejr8BxeHp0
 zUT1o6/aLrJmYyPGxZb/F1ZZ1IoXxgNgZgvXDneFEXNEntCpmMSHLkiZEoV2jDLIeOnb
 nQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uk+6MfSy1xJAjRHyCw9qUpcoTRYgUYoWZjo2KJmyMU4=;
 b=pbnnI7BOQeAYaDZ1wb4iQLnIl4nQhwmQngohVlEI7tAIBQHTxFopmyMonU0k92tSoK
 3DJyNSoC7vBETGYVB2gvGeyeDMzsmPoKhvlcJLDRQaoplTET2/eDy/w2mGV0PmNqvVVh
 CZ6lyyOXUUgtLXqwcr0Hy3U+kiklZfC6X240g6RqrMZ7F1z7IX2cP2LmsY/CbuIQE8ou
 0ldfJfvmbaFNkUXfoiC5D84LnusQMqDv2JsnUMLGysaVaROT2mxD/7tt1xqSI0tTg8jP
 3Yj7DBtNP17/6c1+zPfdRg5q67ILukdsRI0S/AX533f/lSlCbb4U+CTSV68NOOv/7L17
 dPWQ==
X-Gm-Message-State: APjAAAX0aSHj35t0K/3GHPdGPzxGesJu2UB6MpdGDRYwM0jN0ajoXAxw
 CyHc5H60BphqW8ipIcKdrD7I78BQXYI=
X-Google-Smtp-Source: APXvYqxhK3h5jRt2dIuT2lsnA0a4VpDceEyLQP5Xqxnuh4pI2nk/9MDNRDwkUDTWtJB5u86sPlNXmA==
X-Received: by 2002:adf:f4cb:: with SMTP id h11mr5159432wrp.90.1581086074659; 
 Fri, 07 Feb 2020 06:34:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/48] armv7m_systick: delay timer_new to avoid memleaks
Date: Fri,  7 Feb 2020 14:33:41 +0000
Message-Id: <20200207143343.30322-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

From: Pan Nengyuan <pannengyuan@huawei.com>

There is a memory leak when we call 'device_list_properties' with typename = armv7m_systick. It's easy to reproduce as follow:

  virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-properties", "arguments": {"typename": "armv7m_systick"}}'

This patch delay timer_new to fix this memleaks.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-id: 20200205070659.22488-2-pannengyuan@huawei.com
Cc: qemu-arm@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/armv7m_systick.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 85d122dbcbc..74c58bcf245 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -216,6 +216,11 @@ static void systick_instance_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &systick_ops, s, "systick", 0xe0);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
+}
+
+static void systick_realize(DeviceState *dev, Error **errp)
+{
+    SysTickState *s = SYSTICK(dev);
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, systick_timer_tick, s);
 }
 
@@ -238,6 +243,7 @@ static void systick_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_systick;
     dc->reset = systick_reset;
+    dc->realize = systick_realize;
 }
 
 static const TypeInfo armv7m_systick_info = {
-- 
2.20.1


