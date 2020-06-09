Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F2AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D5B2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IC8ajy0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D5B2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihd8-00026T-Ao
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHz-0004HI-RW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHs-0003DN-24
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JV4Y/vtGLCBT77Wo1IIP2KtX7DxxCrx4zcZEtQ7eNEc=;
 b=IC8ajy0RLn5r6GUzHNvzAwuvWjbG/PGyZ28lyW4xw9sJs7Tem8J2rsxaAUxLNqCNprCImL
 87RYBRqQ3mh2jVIAkCLswa4qMJFYi9lmWI0H8GO/8JIdFH7whV4DPAHZP0fi7JH9Lw9zgS
 Hgj11HXN8GJdqdW7lqYOd0K10t9FcNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-BaG-m9XBO0ykrlk5JQLxsg-1; Tue, 09 Jun 2020 12:39:40 -0400
X-MC-Unique: BaG-m9XBO0ykrlk5JQLxsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC30107ACF6;
 Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 661B77B5F9;
 Tue,  9 Jun 2020 16:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06D27113846C; Tue,  9 Jun 2020 18:39:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 23/39] ssi: Convert uses of ssi_create_slave_no_init() with
 Coccinelle
Date: Tue,  9 Jun 2020 18:39:16 +0200
Message-Id: <20200609163932.1566209-24-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace

    dev = ssi_create_slave_no_init(bus, type_name);
    ...
    qdev_init_nofail(dev);

by

    dev = qdev_new(type_name);
    ...
    qdev_realize_and_unref(dev, bus, &error_fatal);

Recent commit "qdev: New qdev_new(), qdev_realize(), etc." explains
why.

    @@
    type SSIBus;
    identifier bus;
    expression dev, qbus, expr;
    expression list args;
    @@
    -    bus = (SSIBus *)qbus;
    +    bus = qbus; // TODO fix up decl
         ...
    -    dev = ssi_create_slave_no_init(bus, args);
    +    dev = qdev_new(args);
         ... when != dev = expr
    -    qdev_init_nofail(dev);
    +    qdev_realize_and_unref(dev, bus, &error_fatal);

    @@
    expression dev, bus, expr;
    expression list args;
    @@
    -    dev = ssi_create_slave_no_init(bus, args);
    +    dev = qdev_new(args);
         ... when != dev = expr
    -    qdev_init_nofail(dev);
    +    qdev_realize_and_unref(dev, BUS(bus), &error_fatal);

Bus declarations fixed up manually.

Cc: Alistair Francis <alistair@alistair23.me>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/aspeed.c                     |  4 ++--
 hw/arm/msf2-som.c                   |  8 ++++----
 hw/arm/sabrelite.c                  |  4 ++--
 hw/arm/xilinx_zynq.c                |  4 ++--
 hw/arm/xlnx-zcu102.c                | 16 ++++++++--------
 hw/microblaze/petalogix_ml605_mmu.c |  4 ++--
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 63a7105e8b..9c25d5da96 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -225,12 +225,12 @@ static void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
         DriveInfo *dinfo = drive_get_next(IF_MTD);
         qemu_irq cs_line;
 
-        fl->flash = ssi_create_slave_no_init(s->spi, flashtype);
+        fl->flash = qdev_new(flashtype);
         if (dinfo) {
             qdev_prop_set_drive(fl->flash, "drive", blk_by_legacy_dinfo(dinfo),
                                 errp);
         }
-        qdev_init_nofail(fl->flash);
+        qdev_realize_and_unref(fl->flash, BUS(s->spi), &error_fatal);
 
         cs_line = qdev_get_gpio_in_named(fl->flash, SSI_GPIO_CS, 0);
         sysbus_connect_irq(SYS_BUS_DEVICE(s), i + 1, cs_line);
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index e398703742..ca9cbe1acb 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -47,7 +47,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     DriveInfo *dinfo = drive_get_next(IF_MTD);
     qemu_irq cs_line;
-    SSIBus *spi_bus;
+    BusState *spi_bus;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ddr = g_new(MemoryRegion, 1);
 
@@ -82,14 +82,14 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     soc = MSF2_SOC(dev);
 
     /* Attach SPI flash to SPI0 controller */
-    spi_bus = (SSIBus *)qdev_get_child_bus(dev, "spi0");
-    spi_flash = ssi_create_slave_no_init(spi_bus, "s25sl12801");
+    spi_bus = qdev_get_child_bus(dev, "spi0");
+    spi_flash = qdev_new("s25sl12801");
     qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 1);
     if (dinfo) {
         qdev_prop_set_drive(spi_flash, "drive", blk_by_legacy_dinfo(dinfo),
                                     &error_fatal);
     }
-    qdev_init_nofail(spi_flash);
+    qdev_realize_and_unref(spi_flash, spi_bus, &error_fatal);
     cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
 
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 96cb30aa3c..33d731549d 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -75,13 +75,13 @@ static void sabrelite_init(MachineState *machine)
                 qemu_irq cs_line;
                 DriveInfo *dinfo = drive_get_next(IF_MTD);
 
-                flash_dev = ssi_create_slave_no_init(spi_bus, "sst25vf016b");
+                flash_dev = qdev_new("sst25vf016b");
                 if (dinfo) {
                     qdev_prop_set_drive(flash_dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
                                         &error_fatal);
                 }
-                qdev_init_nofail(flash_dev);
+                qdev_realize_and_unref(flash_dev, BUS(spi_bus), &error_fatal);
 
                 cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
                 sysbus_connect_irq(SYS_BUS_DEVICE(spi_dev), 1, cs_line);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 5fbd2b2e31..0e0f0976c4 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -157,12 +157,12 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 
         for (j = 0; j < num_ss; ++j) {
             DriveInfo *dinfo = drive_get_next(IF_MTD);
-            flash_dev = ssi_create_slave_no_init(spi, "n25q128");
+            flash_dev = qdev_new("n25q128");
             if (dinfo) {
                 qdev_prop_set_drive(flash_dev, "drive",
                                     blk_by_legacy_dinfo(dinfo), &error_fatal);
             }
-            qdev_init_nofail(flash_dev);
+            qdev_realize_and_unref(flash_dev, BUS(spi), &error_fatal);
 
             cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
             sysbus_connect_irq(busdev, i * num_ss + j + 1, cs_line);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4229b2d936..77c84b82ab 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -149,21 +149,21 @@ static void xlnx_zcu102_init(MachineState *machine)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
-        SSIBus *spi_bus;
+        BusState *spi_bus;
         DeviceState *flash_dev;
         qemu_irq cs_line;
         DriveInfo *dinfo = drive_get_next(IF_MTD);
         gchar *bus_name = g_strdup_printf("spi%d", i);
 
-        spi_bus = (SSIBus *)qdev_get_child_bus(DEVICE(&s->soc), bus_name);
+        spi_bus = qdev_get_child_bus(DEVICE(&s->soc), bus_name);
         g_free(bus_name);
 
-        flash_dev = ssi_create_slave_no_init(spi_bus, "sst25wf080");
+        flash_dev = qdev_new("sst25wf080");
         if (dinfo) {
             qdev_prop_set_drive(flash_dev, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         }
-        qdev_init_nofail(flash_dev);
+        qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
 
         cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
 
@@ -171,22 +171,22 @@ static void xlnx_zcu102_init(MachineState *machine)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_QSPI_FLASH; i++) {
-        SSIBus *spi_bus;
+        BusState *spi_bus;
         DeviceState *flash_dev;
         qemu_irq cs_line;
         DriveInfo *dinfo = drive_get_next(IF_MTD);
         int bus = i / XLNX_ZYNQMP_NUM_QSPI_BUS_CS;
         gchar *bus_name = g_strdup_printf("qspi%d", bus);
 
-        spi_bus = (SSIBus *)qdev_get_child_bus(DEVICE(&s->soc), bus_name);
+        spi_bus = qdev_get_child_bus(DEVICE(&s->soc), bus_name);
         g_free(bus_name);
 
-        flash_dev = ssi_create_slave_no_init(spi_bus, "n25q512a11");
+        flash_dev = qdev_new("n25q512a11");
         if (dinfo) {
             qdev_prop_set_drive(flash_dev, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
         }
-        qdev_init_nofail(flash_dev);
+        qdev_realize_and_unref(flash_dev, spi_bus, &error_fatal);
 
         cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 2e7a3fa119..d4bfa233c9 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -186,12 +186,12 @@ petalogix_ml605_init(MachineState *machine)
             DriveInfo *dinfo = drive_get_next(IF_MTD);
             qemu_irq cs_line;
 
-            dev = ssi_create_slave_no_init(spi, "n25q128");
+            dev = qdev_new("n25q128");
             if (dinfo) {
                 qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
                                     &error_fatal);
             }
-            qdev_init_nofail(dev);
+            qdev_realize_and_unref(dev, BUS(spi), &error_fatal);
 
             cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
             sysbus_connect_irq(busdev, i+1, cs_line);
-- 
2.26.2


