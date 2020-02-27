Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE85C4BA37
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6328E24679
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6328E24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j794G-0003wG-K3
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j791S-0007xg-AV
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j791R-0001dc-7F
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:35:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3172 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j791O-0001O8-JC; Wed, 26 Feb 2020 21:35:30 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 89955B16684D25F05FF8;
 Thu, 27 Feb 2020 10:35:26 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 10:35:17 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH v3 2/6] hw/arm/pxa2xx: move timer_new from init() into
 realize() to avoid memleaks
Date: Thu, 27 Feb 2020 10:50:51 +0800
Message-ID: <20200227025055.14341-3-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200227025055.14341-1-pannengyuan@huawei.com>
References: <20200227025055.14341-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: Andrzej Zaborowski <balrogg@gmail.com>
---
 hw/arm/pxa2xx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index b33f8f1351..56a36202d7 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1134,18 +1134,22 @@ static void pxa2xx_rtc_init(Object *obj)
     s->last_rtcpicr = 0;
     s->last_hz = s->last_sw = s->last_pi = qemu_clock_get_ms(rtc_clock);
 
+    sysbus_init_irq(dev, &s->rtc_irq);
+
+    memory_region_init_io(&s->iomem, obj, &pxa2xx_rtc_ops, s,
+                          "pxa2xx-rtc", 0x10000);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static void pxa2xx_rtc_realize(DeviceState *dev, Error **errp)
+{
+    PXA2xxRTCState *s = PXA2XX_RTC(dev);
     s->rtc_hz    = timer_new_ms(rtc_clock, pxa2xx_rtc_hz_tick,    s);
     s->rtc_rdal1 = timer_new_ms(rtc_clock, pxa2xx_rtc_rdal1_tick, s);
     s->rtc_rdal2 = timer_new_ms(rtc_clock, pxa2xx_rtc_rdal2_tick, s);
     s->rtc_swal1 = timer_new_ms(rtc_clock, pxa2xx_rtc_swal1_tick, s);
     s->rtc_swal2 = timer_new_ms(rtc_clock, pxa2xx_rtc_swal2_tick, s);
     s->rtc_pi    = timer_new_ms(rtc_clock, pxa2xx_rtc_pi_tick,    s);
-
-    sysbus_init_irq(dev, &s->rtc_irq);
-
-    memory_region_init_io(&s->iomem, obj, &pxa2xx_rtc_ops, s,
-                          "pxa2xx-rtc", 0x10000);
-    sysbus_init_mmio(dev, &s->iomem);
 }
 
 static int pxa2xx_rtc_pre_save(void *opaque)
@@ -1203,6 +1207,7 @@ static void pxa2xx_rtc_sysbus_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "PXA2xx RTC Controller";
     dc->vmsd = &vmstate_pxa2xx_rtc_regs;
+    dc->realize = pxa2xx_rtc_realize;
 }
 
 static const TypeInfo pxa2xx_rtc_sysbus_info = {
-- 
2.18.2


