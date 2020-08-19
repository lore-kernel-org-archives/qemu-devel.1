Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD33C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F52E2063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F52E2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Hxl-0004hF-VZ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1k8HxE-0004Gd-7k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:52:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1k8HxC-0006c6-4M
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:52:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22so17209266edy.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 23:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+Ry/DktSl5XfwDZgy3PJpnKHT/LG80fCdmSr74IK76o=;
 b=WzX7dhnHsejM0x7AjjHJanJn4kruc/ZoEVgSAVp69m3Ya5lAjBttepEkguR28BJw5g
 Vwf8ZGMQize9jI0gs4jfEOVdRCD14VMSgn+Ku9uYwPZtezVp7xCvB6tYibcIqs06tZTc
 /Lc88WYj7iJj7pefCFboboj8zPFP4IgIavHtUOn1i4kBzQp2SU2bLNEuEwLOLa4LgfHP
 omEmkeBuxlD2lb/EAnAb+vZo9ezZaIkceRpnIWBRvqknfLL1+nhiIWCE3n2MOgtcgc1s
 pNgGACEQ4Koz+EQP9MeDFBq9Wxh0s1ifPSZiKT7hmSxLhqxCjPWOR9qHFMEAbtwFE1Mi
 cQvA==
X-Gm-Message-State: AOAM5331My/2Wi7gbztvmJskx0NMHiQ2ou6mnPRkXoVLhnGE23eTHhV+
 R5opr5KKn/1Cc7itj+Qyx5ogJZBq8lM=
X-Google-Smtp-Source: ABdhPJz485dU4e9hLlVyL+9e3qyNuunT+k5zscqzivvph3Y8xZmwipyZnHKha5EiEuALKp2RHyjSlw==
X-Received: by 2002:aa7:dc44:: with SMTP id g4mr23609077edu.273.1597819927148; 
 Tue, 18 Aug 2020 23:52:07 -0700 (PDT)
Received: from thl530.multi.box (pd9e839dc.dip0.t-ipconnect.de.
 [217.232.57.220])
 by smtp.gmail.com with ESMTPSA id l3sm16948063edv.3.2020.08.18.23.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 23:52:06 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/m68k: QOMify the mcf5206 system integration module
Date: Wed, 19 Aug 2020 08:52:01 +0200
Message-Id: <20200819065201.4045-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.66; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 02:52:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mcf5206 system integration module should be a proper device.
Let's finally QOMify it.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/an5206.c      | 14 ++++++++++++--
 hw/m68k/mcf5206.c     | 44 ++++++++++++++++++++++++++++++++++---------
 include/hw/m68k/mcf.h |  3 +--
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 846f4e40c6..673898b0ea 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -21,7 +21,17 @@
 #define AN5206_MBAR_ADDR 0x10000000
 #define AN5206_RAMBAR_ADDR 0x20000000
 
-/* Board init.  */
+static void mcf5206_init(MemoryRegion *sysmem, uint32_t base)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_new(TYPE_MCF5206_MBAR);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(s, &error_fatal);
+
+    memory_region_add_subregion(sysmem, base, sysbus_mmio_get_region(s, 0));
+}
 
 static void an5206_init(MachineState *machine)
 {
@@ -51,7 +61,7 @@ static void an5206_init(MachineState *machine)
     memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
     memory_region_add_subregion(address_space_mem, AN5206_RAMBAR_ADDR, sram);
 
-    mcf5206_init(address_space_mem, AN5206_MBAR_ADDR, cpu);
+    mcf5206_init(address_space_mem, AN5206_MBAR_ADDR);
 
     /* Load kernel.  */
     if (!kernel_filename) {
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 94a37a1a46..51d2e0da1c 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -15,6 +15,7 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
 
 /* General purpose timer module.  */
 typedef struct {
@@ -159,6 +160,8 @@ static m5206_timer_state *m5206_timer_init(qemu_irq irq)
 /* System Integration Module.  */
 
 typedef struct {
+    SysBusDevice parent_obj;
+
     M68kCPU *cpu;
     MemoryRegion iomem;
     m5206_timer_state *timer[2];
@@ -174,6 +177,8 @@ typedef struct {
     uint8_t uivr[2];
 } m5206_mbar_state;
 
+#define MCF5206_MBAR(obj) OBJECT_CHECK(m5206_mbar_state, (obj), TYPE_MCF5206_MBAR)
+
 /* Interrupt controller.  */
 
 static int m5206_find_pending_irq(m5206_mbar_state *s)
@@ -257,8 +262,10 @@ static void m5206_mbar_set_irq(void *opaque, int irq, int level)
 
 /* System Integration Module.  */
 
-static void m5206_mbar_reset(m5206_mbar_state *s)
+static void m5206_mbar_reset(DeviceState *dev)
 {
+    m5206_mbar_state *s = MCF5206_MBAR(dev);
+
     s->scr = 0xc0;
     s->icr[1] = 0x04;
     s->icr[2] = 0x08;
@@ -578,24 +585,43 @@ static const MemoryRegionOps m5206_mbar_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-qemu_irq *mcf5206_init(MemoryRegion *sysmem, uint32_t base, M68kCPU *cpu)
+static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
 {
-    m5206_mbar_state *s;
+    m5206_mbar_state *s = MCF5206_MBAR(dev);
     qemu_irq *pic;
 
-    s = g_new0(m5206_mbar_state, 1);
-
     memory_region_init_io(&s->iomem, NULL, &m5206_mbar_ops, s,
                           "mbar", 0x00001000);
-    memory_region_add_subregion(sysmem, base, &s->iomem);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
     pic = qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
     s->timer[0] = m5206_timer_init(pic[9]);
     s->timer[1] = m5206_timer_init(pic[10]);
     s->uart[0] = mcf_uart_init(pic[12], serial_hd(0));
     s->uart[1] = mcf_uart_init(pic[13], serial_hd(1));
-    s->cpu = cpu;
+    s->cpu = M68K_CPU(qemu_get_cpu(0));
+}
+
+static void mcf5206_mbar_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
-    m5206_mbar_reset(s);
-    return pic;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "MCF5206 system integration module";
+    dc->realize = mcf5206_mbar_realize;
+    dc->reset = m5206_mbar_reset;
 }
+
+static const TypeInfo mcf5206_mbar_info = {
+    .name          = TYPE_MCF5206_MBAR,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(m5206_mbar_state),
+    .class_init    = mcf5206_mbar_class_init,
+};
+
+static void mcf5206_mbar_register_types(void)
+{
+    type_register_static(&mcf5206_mbar_info);
+}
+
+type_init(mcf5206_mbar_register_types)
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index 0db49c5e60..decf17ce42 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -18,7 +18,6 @@ qemu_irq *mcf_intc_init(struct MemoryRegion *sysmem,
                         M68kCPU *cpu);
 
 /* mcf5206.c */
-qemu_irq *mcf5206_init(struct MemoryRegion *sysmem,
-                       uint32_t base, M68kCPU *cpu);
+#define TYPE_MCF5206_MBAR "mcf5206-mbar"
 
 #endif
-- 
2.26.2


