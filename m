Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98BBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5402528D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5402528D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSN8x-0001u9-GZ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSN7x-0001Ri-Sw
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:26:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:52070
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSN7v-0002Pb-LL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:26:17 -0400
Received: from host86-158-109-18.range86-158.btcentralplus.com
 ([86.158.109.18] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kSN7r-0006Rn-EC; Tue, 13 Oct 2020 17:26:16 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: ehabkost@redhat.com,
	laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Tue, 13 Oct 2020 17:26:03 +0100
Message-Id: <20201013162603.9485-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.18
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] mac_via: fix init() and realize() behaviour
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The mac_via device does not currently follow the rules for init() and realize() in
regard to the mos6522 child devices. These child devices must be initialised using
object_initialize_child() within the mac_via init() function and then realized as
part of the mac_via realize() function. Move object_initialize_child() from
realize() to init() which is where the iniitalisation of child devices should occur.

Similarly the realize() function creates alias properties to allow the VIA input
and output IRQs to be wired up to the interrupt controller during machine init, but
realize() should never alter object properties. Remove these aliases and instead
use object_resolve_path_component() to access the child objects from the mac_via
device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c    | 12 ++++++++----
 hw/misc/mac_via.c | 36 ++++++++++++------------------------
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ce4b47c3e3..773d75c1f8 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -174,6 +174,7 @@ static void q800_init(MachineState *machine)
     SysBusESPState *sysbus_esp;
     ESPState *esp;
     SysBusDevice *sysbus;
+    MOS6522State *ms;
     BusState *adb_bus;
     NubusBus *nubus;
     GLUEState *irq;
@@ -226,9 +227,11 @@ static void q800_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(via_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, VIA_BASE);
-    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0, pic[0]);
-    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1, pic[1]);
 
+    ms = MOS6522(object_resolve_path_component(OBJECT(via_dev), "via1"));
+    sysbus_connect_irq(SYS_BUS_DEVICE(ms), 0, pic[0]);
+    ms = MOS6522(object_resolve_path_component(OBJECT(via_dev), "via2"));
+    sysbus_connect_irq(SYS_BUS_DEVICE(ms), 0, pic[1]);
 
     adb_bus = qdev_get_child_bus(via_dev, "adb.0");
     dev = qdev_new(TYPE_ADB_KEYBOARD);
@@ -300,11 +303,12 @@ static void q800_init(MachineState *machine)
 
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in_named(via_dev,
+    ms = MOS6522(object_resolve_path_component(OBJECT(via_dev), "via2"));
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in_named(DEVICE(ms),
                                                          "via2-irq",
                                                          VIA2_IRQ_SCSI_BIT));
     sysbus_connect_irq(sysbus, 1,
-                       qdev_get_gpio_in_named(via_dev, "via2-irq",
+                       qdev_get_gpio_in_named(DEVICE(ms), "via2-irq",
                                               VIA2_IRQ_SCSI_DATA_BIT));
     sysbus_mmio_map(sysbus, 0, ESP_BASE);
     sysbus_mmio_map(sysbus, 1, ESP_PDMA);
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 6db62dab7d..7c2c943d3f 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1016,40 +1016,21 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     struct tm tm;
     int ret;
 
-    /* Init VIAs 1 and 2 */
-    object_initialize_child(OBJECT(dev), "via1", &m->mos6522_via1,
-                            TYPE_MOS6522_Q800_VIA1);
-
-    object_initialize_child(OBJECT(dev), "via2", &m->mos6522_via2,
-                            TYPE_MOS6522_Q800_VIA2);
-
-    /* Pass through mos6522 output IRQs */
-    ms = MOS6522(&m->mos6522_via1);
-    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
-                              SYSBUS_DEVICE_GPIO_IRQ "[0]");
-    ms = MOS6522(&m->mos6522_via2);
-    object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
-                              SYSBUS_DEVICE_GPIO_IRQ "[0]");
-
+    /* Realize VIAs */
     sysbus_realize(SYS_BUS_DEVICE(&m->mos6522_via1), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&m->mos6522_via2), &error_abort);
 
-    /* Pass through mos6522 input IRQs */
-    qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
-    qdev_pass_gpios(DEVICE(&m->mos6522_via2), dev, "via2-irq");
-
     /* VIA 1 */
+    ms = MOS6522(&m->mos6522_via1);
     m->mos6522_via1.one_second_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                                     via1_one_second,
-                                                     &m->mos6522_via1);
-    m->mos6522_via1.VBL_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via1_VBL,
-                                              &m->mos6522_via1);
+                                                     via1_one_second, ms);
+    m->mos6522_via1.VBL_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via1_VBL, ms);
 
     qemu_get_timedate(&tm, 0);
     m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
 
     adb_register_autopoll_callback(adb_bus, adb_via_poll, m);
-    m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
+    m->adb_data_ready = qdev_get_gpio_in_named(DEVICE(ms), "via1-irq",
                                                VIA1_IRQ_ADB_READY_BIT);
 
     if (m->blk) {
@@ -1080,6 +1061,13 @@ static void mac_via_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MacVIAState *m = MAC_VIA(obj);
 
+    /* Init VIAs 1 and 2 */
+    object_initialize_child(obj, "via1", &m->mos6522_via1,
+                            TYPE_MOS6522_Q800_VIA1);
+
+    object_initialize_child(obj, "via2", &m->mos6522_via2,
+                            TYPE_MOS6522_Q800_VIA2);
+
     /* MMIO */
     memory_region_init(&m->mmio, obj, "mac-via", 2 * VIA_SIZE);
     sysbus_init_mmio(sbd, &m->mmio);
-- 
2.20.1


