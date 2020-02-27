Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC921C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A4F24679
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A4F24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7964-0005gQ-Tk
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j791V-00083v-FG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j791U-0001lG-Cn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:35:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3174 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j791R-0001ZC-MH; Wed, 26 Feb 2020 21:35:33 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9D6DC12A53F73219C1E5;
 Thu, 27 Feb 2020 10:35:31 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 10:35:21 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH v3 5/6] hw/misc/mos6522: move timer_new from init() into
 realize() to avoid memleaks
Date: Thu, 27 Feb 2020 10:50:54 +0800
Message-ID: <20200227025055.14341-6-pannengyuan@huawei.com>
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
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are some memleaks when we call 'device_list_properties'. This patch move timer_new from init into realize to fix it.
Meanwhile, add calls to mos6522_realize() in mac_via_realize to make this move to be valid.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
---
v2->v1:
- no changes in this patch.
v3->v2:
- remove null check in reset, and add calls to mos6522_realize() in mac_via_realize to make this move to be valid.
---
 hw/misc/mac_via.c | 5 +++++
 hw/misc/mos6522.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index b7d0012794..1d72d4ef35 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -879,6 +879,11 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
                           sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
 
+    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized",
+                             &error_abort);
+    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized",
+                             &error_abort);
+
     /* Pass through mos6522 output IRQs */
     ms = MOS6522(&m->mos6522_via1);
     object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 19e154b870..c1cd154a84 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -485,6 +485,11 @@ static void mos6522_init(Object *obj)
     for (i = 0; i < ARRAY_SIZE(s->timers); i++) {
         s->timers[i].index = i;
     }
+}
+
+static void mos6522_realize(DeviceState *dev, Error **errp)
+{
+    MOS6522State *s = MOS6522(dev);
 
     s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer1, s);
     s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, mos6522_timer2, s);
@@ -502,6 +507,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
 
     dc->reset = mos6522_reset;
     dc->vmsd = &vmstate_mos6522;
+    dc->realize = mos6522_realize;
     device_class_set_props(dc, mos6522_properties);
     mdc->parent_reset = dc->reset;
     mdc->set_sr_int = mos6522_set_sr_int;
-- 
2.18.2


