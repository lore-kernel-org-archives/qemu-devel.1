Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBA0C1975A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21942073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21942073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2JI-00026H-Un
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HC-0006cx-SH
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1jD2HB-0004bk-H5
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53340 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1jD2HA-0004M2-QT
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:36:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 07CC86648574A9F8CC6D;
 Sat, 14 Mar 2020 16:36:03 +0800 (CST)
Received: from localhost.huawei.com (10.175.104.216) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 14 Mar 2020 16:35:53 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v5 2/4] mac_via: fix incorrect creation of mos6522 device in
 mac_via
Date: Sat, 14 Mar 2020 16:47:28 +0800
Message-ID: <20200314084730.25876-3-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200314084730.25876-1-pannengyuan@huawei.com>
References: <20200314084730.25876-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent
 Vivier <laurent@vivier.eu>, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fix a bug in mac_via where it failed to actually realize devices it was using.
And move the init codes which inits the mos6522 objects and properties on them from realize()
into init(). However, we keep qdev_set_parent_bus in realize(), otherwise it will cause
device-introspect-test test fail. Then do the realize mos6522 device in the mac_vir_realize.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
v4->v3:
- split v3 into two patches, this patch fix incorrect creation of mos6522, move inits and props
  from realize into init.
v5->v4:
- remove redundant code.
- As discussion in https://patchwork.kernel.org/patch/11421229/, we still keep 
  qdev_set_parent_bus in realize().
---
 hw/misc/mac_via.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index b7d0012794..d208f0b18a 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -868,24 +868,24 @@ static void mac_via_reset(DeviceState *dev)
 static void mac_via_realize(DeviceState *dev, Error **errp)
 {
     MacVIAState *m = MAC_VIA(dev);
-    MOS6522State *ms;
     struct tm tm;
     int ret;
+    Error *err = NULL;
 
-    /* Init VIAs 1 and 2 */
-    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
-                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
+    qdev_set_parent_bus(DEVICE(&m->mos6522_via1), sysbus_get_default());
+    qdev_set_parent_bus(DEVICE(&m->mos6522_via2), sysbus_get_default());
 
-    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
-                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
+    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
 
-    /* Pass through mos6522 output IRQs */
-    ms = MOS6522(&m->mos6522_via1);
-    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
-                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
-    ms = MOS6522(&m->mos6522_via2);
-    object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
-                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
+    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
 
     /* Pass through mos6522 input IRQs */
     qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
@@ -948,6 +948,20 @@ static void mac_via_init(Object *obj)
     /* ADB */
     qbus_create_inplace((BusState *)&m->adb_bus, sizeof(m->adb_bus),
                         TYPE_ADB_BUS, DEVICE(obj), "adb.0");
+
+    /* Init VIAs 1 and 2 */
+    object_initialize_child(OBJECT(m), "via1", &m->mos6522_via1,
+                            sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1,
+                            &error_abort, NULL);
+    object_initialize_child(OBJECT(m), "via2", &m->mos6522_via2,
+                            sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2,
+                            &error_abort, NULL);
+
+    /* Pass through mos6522 output IRQs */
+    object_property_add_alias(OBJECT(m), "irq[0]", OBJECT(&m->mos6522_via1),
+                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
+    object_property_add_alias(OBJECT(m), "irq[1]", OBJECT(&m->mos6522_via2),
+                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
 }
 
 static void postload_update_cb(void *opaque, int running, RunState state)
-- 
2.18.2


