Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B080C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207AD208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207AD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j792L-00012e-AV
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j791R-0007wl-Bg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j791Q-0001aO-AD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:35:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3173 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j791O-0001OE-0L; Wed, 26 Feb 2020 21:35:30 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8DEEA4DC289EFDFADFF7;
 Thu, 27 Feb 2020 10:35:26 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 10:35:18 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH v3 3/6] hw/arm/spitz: move timer_new from init() into
 realize() to avoid memleaks
Date: Thu, 27 Feb 2020 10:50:52 +0800
Message-ID: <20200227025055.14341-4-pannengyuan@huawei.com>
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
 hw/arm/spitz.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index e001088103..cbfa6934cf 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -524,11 +524,16 @@ static void spitz_keyboard_init(Object *obj)
 
     spitz_keyboard_pre_map(s);
 
-    s->kbdtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick, s);
     qdev_init_gpio_in(dev, spitz_keyboard_strobe, SPITZ_KEY_STROBE_NUM);
     qdev_init_gpio_out(dev, s->sense, SPITZ_KEY_SENSE_NUM);
 }
 
+static void spitz_keyboard_realize(DeviceState *dev, Error **errp)
+{
+    SpitzKeyboardState *s = SPITZ_KEYBOARD(dev);
+    s->kbdtimer = timer_new_ns(QEMU_CLOCK_VIRTUAL, spitz_keyboard_tick, s);
+}
+
 /* LCD backlight controller */
 
 #define LCDTG_RESCTL	0x00
@@ -1115,6 +1120,7 @@ static void spitz_keyboard_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_spitz_kbd;
+    dc->realize = spitz_keyboard_realize;
 }
 
 static const TypeInfo spitz_keyboard_info = {
-- 
2.18.2


