Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D44C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF21220707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNsNj4kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF21220707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefiV-0004hf-20
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKc-0003MQ-NT
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30411
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKN-00079T-Ob
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dez8N1nBjGK0F/XtZ9p/O0jTT81SAysn/zGA04vVbbU=;
 b=DNsNj4kjpU8HgjqaUPyyKUKY4QdWfAf45IQd7RhcJOIHZnhygF+VO/IInOFblWY/FD10Ck
 B5qntmCr5OXKS5Gt4GblYJtaLCxbNBTYwlSiKUB0uZRuMh6eRhxsEc80IlGzGy0E1tucAP
 heZDUrk71g3l9ahz/3lwP9OYChYnVr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-pPxQ2hU_MBePfFFR4qZusw-1; Fri, 29 May 2020 09:45:34 -0400
X-MC-Unique: pPxQ2hU_MBePfFFR4qZusw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1214460;
 Fri, 29 May 2020 13:45:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 271E91001925;
 Fri, 29 May 2020 13:45:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 887C81135242; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 47/58] sysbus: Convert qdev_set_parent_bus() use with
 Coccinelle, part 1
Date: Fri, 29 May 2020 15:45:12 +0200
Message-Id: <20200529134523.8477-48-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm converting from qdev_set_parent_bus()/realize to qdev_realize();
recent commit "qdev: Convert uses of qdev_set_parent_bus() with
Coccinelle" explains why.

sysbus_init_child_obj() is a wrapper around
object_initialize_child_with_props() and qdev_set_parent_bus().  It
passes no properties.

Convert sysbus_init_child_obj()/realize to object_initialize_child()/
qdev_realize().

Coccinelle script:

    @@
    expression parent, name, size, type, errp;
    expression child;
    symbol true;
    @@
    -    sysbus_init_child_obj(parent, name, &child, size, type);
    +    sysbus_init_child_XXX(parent, name, &child, size, type);
         ...
    -    object_property_set_bool(OBJECT(&child), true, "realized", errp);
    +    sysbus_realize(SYS_BUS_DEVICE(&child), errp);

    @@
    expression parent, name, size, type, errp;
    expression child;
    symbol true;
    @@
    -    sysbus_init_child_obj(parent, name, child, size, type);
    +    sysbus_init_child_XXX(parent, name, child, size, type);
         ...
    -    object_property_set_bool(OBJECT(child), true, "realized", errp);
    +    sysbus_realize(SYS_BUS_DEVICE(child), errp);

    @@
    expression parent, name, size, type;
    expression child;
    expression dev;
    expression expr;
    @@
    -    sysbus_init_child_obj(parent, name, child, size, type);
    +    sysbus_init_child_XXX(parent, name, child, size, type);
         ...
         dev = DEVICE(child);
         ... when != dev = expr;
    -    qdev_init_nofail(dev);
    +    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);

    @@
    expression parent, propname, type;
    expression child;
    @@
    -    sysbus_init_child_XXX(parent, propname, child, sizeof(*child), type)
    +    object_initialize_child(parent, propname, child, type)

    @@
    expression parent, propname, type;
    expression child;
    @@
    -    sysbus_init_child_XXX(parent, propname, &child, sizeof(child), type)
    +    object_initialize_child(parent, propname, &child, type)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/arm/bcm2835_peripherals.c |  5 ++--
 hw/arm/exynos4_boards.c      |  7 +++--
 hw/arm/mps2-tz.c             | 50 ++++++++++++++++--------------------
 hw/arm/mps2.c                | 19 +++++---------
 hw/arm/musca.c               | 37 ++++++++++++--------------
 hw/arm/xlnx-versal-virt.c    |  6 ++---
 hw/arm/xlnx-versal.c         | 36 +++++++++++---------------
 hw/intc/armv7m_nvic.c        |  8 +++---
 hw/mips/boston.c             |  6 ++---
 hw/mips/cps.c                | 20 ++++++---------
 hw/mips/malta.c              |  6 ++---
 hw/misc/mac_via.c            | 14 +++++-----
 hw/riscv/spike.c             | 21 +++++++--------
 hw/riscv/virt.c              |  7 +++--
 14 files changed, 102 insertions(+), 140 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 49bfabee9b..9f2ecc25ed 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -27,11 +27,10 @@ static void create_unimp(BCM2835PeripheralState *ps,
                          UnimplementedDeviceState *uds,
                          const char *name, hwaddr ofs, hwaddr size)
 {
-    sysbus_init_child_obj(OBJECT(ps), name, uds, sizeof(*uds),
-                          TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(OBJECT(ps), name, uds, TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
     qdev_prop_set_uint64(DEVICE(uds), "size", size);
-    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(uds), &error_fatal);
     memory_region_add_subregion_overlap(&ps->peri_mr, ofs,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0), -1000);
 }
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 326122abff..56b729141b 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -128,10 +128,9 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
 
-    sysbus_init_child_obj(OBJECT(machine), "soc",
-                          &s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                             &error_fatal);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_EXYNOS4210_SOC);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     return s;
 }
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 4c49512e0b..a2b20fff37 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -174,11 +174,10 @@ static MemoryRegion *make_unimp_dev(MPS2TZMachineState *mms,
      */
     UnimplementedDeviceState *uds = opaque;
 
-    sysbus_init_child_obj(OBJECT(mms), name, uds, sizeof(*uds),
-                          TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(OBJECT(mms), name, uds, TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
     qdev_prop_set_uint64(DEVICE(uds), "size", size);
-    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(uds), &error_fatal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0);
 }
 
@@ -193,11 +192,10 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
     SysBusDevice *s;
     DeviceState *orgate_dev = DEVICE(&mms->uart_irq_orgate);
 
-    sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(*uart),
-                          TYPE_CMSDK_APB_UART);
+    object_initialize_child(OBJECT(mms), name, uart, TYPE_CMSDK_APB_UART);
     qdev_prop_set_chr(DEVICE(uart), "chardev", serial_hd(i));
     qdev_prop_set_uint32(DEVICE(uart), "pclk-frq", SYSCLK_FRQ);
-    object_property_set_bool(OBJECT(uart), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(uart), &error_fatal);
     s = SYS_BUS_DEVICE(uart);
     sysbus_connect_irq(s, 0, get_sse_irq_in(mms, txirqno));
     sysbus_connect_irq(s, 1, get_sse_irq_in(mms, rxirqno));
@@ -214,13 +212,12 @@ static MemoryRegion *make_scc(MPS2TZMachineState *mms, void *opaque,
     DeviceState *sccdev;
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_GET_CLASS(mms);
 
-    sysbus_init_child_obj(OBJECT(mms), "scc", scc, sizeof(*scc),
-                          TYPE_MPS2_SCC);
+    object_initialize_child(OBJECT(mms), "scc", scc, TYPE_MPS2_SCC);
     sccdev = DEVICE(scc);
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
     qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
-    object_property_set_bool(OBJECT(scc), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(scc), &error_fatal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(sccdev), 0);
 }
 
@@ -229,9 +226,8 @@ static MemoryRegion *make_fpgaio(MPS2TZMachineState *mms, void *opaque,
 {
     MPS2FPGAIO *fpgaio = opaque;
 
-    sysbus_init_child_obj(OBJECT(mms), "fpgaio", fpgaio, sizeof(*fpgaio),
-                          TYPE_MPS2_FPGAIO);
-    object_property_set_bool(OBJECT(fpgaio), true, "realized", &error_fatal);
+    object_initialize_child(OBJECT(mms), "fpgaio", fpgaio, TYPE_MPS2_FPGAIO);
+    sysbus_realize(SYS_BUS_DEVICE(fpgaio), &error_fatal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(fpgaio), 0);
 }
 
@@ -267,11 +263,10 @@ static MemoryRegion *make_mpc(MPS2TZMachineState *mms, void *opaque,
 
     memory_region_init_ram(ssram, NULL, name, ramsize[i], &error_fatal);
 
-    sysbus_init_child_obj(OBJECT(mms), mpcname, mpc, sizeof(*mpc),
-                          TYPE_TZ_MPC);
+    object_initialize_child(OBJECT(mms), mpcname, mpc, TYPE_TZ_MPC);
     object_property_set_link(OBJECT(mpc), OBJECT(ssram),
                              "downstream", &error_fatal);
-    object_property_set_bool(OBJECT(mpc), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(mpc), &error_fatal);
     /* Map the upstream end of the MPC into system memory */
     upstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 1);
     memory_region_add_subregion(get_system_memory(), rambase[i], upstream);
@@ -310,13 +305,13 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
      * the MSC connects to the IoTKit AHB Slave Expansion port, so the
      * DMA devices can see all devices and memory that the CPU does.
      */
-    sysbus_init_child_obj(OBJECT(mms), mscname, msc, sizeof(*msc), TYPE_TZ_MSC);
+    object_initialize_child(OBJECT(mms), mscname, msc, TYPE_TZ_MSC);
     msc_downstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(&mms->iotkit), 0);
     object_property_set_link(OBJECT(msc), OBJECT(msc_downstream),
                              "downstream", &error_fatal);
     object_property_set_link(OBJECT(msc), OBJECT(mms),
                              "idau", &error_fatal);
-    object_property_set_bool(OBJECT(msc), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(msc), &error_fatal);
 
     qdev_connect_gpio_out_named(DEVICE(msc), "irq", 0,
                                 qdev_get_gpio_in_named(iotkitdev,
@@ -333,10 +328,10 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
                                                  "cfg_sec_resp", 0));
     msc_upstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(msc), 0);
 
-    sysbus_init_child_obj(OBJECT(mms), name, dma, sizeof(*dma), TYPE_PL081);
+    object_initialize_child(OBJECT(mms), name, dma, TYPE_PL081);
     object_property_set_link(OBJECT(dma), OBJECT(msc_upstream),
                              "downstream", &error_fatal);
-    object_property_set_bool(OBJECT(dma), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dma), &error_fatal);
 
     s = SYS_BUS_DEVICE(dma);
     /* Wire up DMACINTR, DMACINTERR, DMACINTTC */
@@ -363,8 +358,8 @@ static MemoryRegion *make_spi(MPS2TZMachineState *mms, void *opaque,
     int i = spi - &mms->spi[0];
     SysBusDevice *s;
 
-    sysbus_init_child_obj(OBJECT(mms), name, spi, sizeof(*spi), TYPE_PL022);
-    object_property_set_bool(OBJECT(spi), true, "realized", &error_fatal);
+    object_initialize_child(OBJECT(mms), name, spi, TYPE_PL022);
+    sysbus_realize(SYS_BUS_DEVICE(spi), &error_fatal);
     s = SYS_BUS_DEVICE(spi);
     sysbus_connect_irq(s, 0, get_sse_irq_in(mms, 51 + i));
     return sysbus_mmio_get_region(s, 0);
@@ -393,15 +388,14 @@ static void mps2tz_common_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    sysbus_init_child_obj(OBJECT(machine), TYPE_IOTKIT, &mms->iotkit,
-                          sizeof(mms->iotkit), mmc->armsse_type);
+    object_initialize_child(OBJECT(machine), TYPE_IOTKIT, &mms->iotkit,
+                            mmc->armsse_type);
     iotkitdev = DEVICE(&mms->iotkit);
     object_property_set_link(OBJECT(&mms->iotkit), OBJECT(system_memory),
                              "memory", &error_abort);
     qdev_prop_set_uint32(iotkitdev, "EXP_NUMIRQ", MPS2TZ_NUMIRQ);
     qdev_prop_set_uint32(iotkitdev, "MAINCLK", SYSCLK_FRQ);
-    object_property_set_bool(OBJECT(&mms->iotkit), true, "realized",
-                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->iotkit), &error_fatal);
 
     /*
      * The AN521 needs us to create splitters to feed the IRQ inputs
@@ -549,8 +543,8 @@ static void mps2tz_common_init(MachineState *machine)
         int port;
         char *gpioname;
 
-        sysbus_init_child_obj(OBJECT(machine), ppcinfo->name, ppc,
-                              sizeof(*ppc), TYPE_TZ_PPC);
+        object_initialize_child(OBJECT(machine), ppcinfo->name, ppc,
+                                TYPE_TZ_PPC);
         ppcdev = DEVICE(ppc);
 
         for (port = 0; port < TZ_NUM_PORTS; port++) {
@@ -569,7 +563,7 @@ static void mps2tz_common_init(MachineState *machine)
             g_free(portname);
         }
 
-        object_property_set_bool(OBJECT(ppc), true, "realized", &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(ppc), &error_fatal);
 
         for (port = 0; port < TZ_NUM_PORTS; port++) {
             const PPCPortInfo *pinfo = &ppcinfo->ports[port];
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index f246213206..735f44c7a3 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -180,8 +180,7 @@ static void mps2_common_init(MachineState *machine)
         g_assert_not_reached();
     }
 
-    sysbus_init_child_obj(OBJECT(mms), "armv7m", &mms->armv7m,
-                          sizeof(mms->armv7m), TYPE_ARMV7M);
+    object_initialize_child(OBJECT(mms), "armv7m", &mms->armv7m, TYPE_ARMV7M);
     armv7m = DEVICE(&mms->armv7m);
     switch (mmc->fpga_type) {
     case FPGA_AN385:
@@ -197,8 +196,7 @@ static void mps2_common_init(MachineState *machine)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&mms->armv7m), OBJECT(system_memory),
                              "memory", &error_abort);
-    object_property_set_bool(OBJECT(&mms->armv7m), true, "realized",
-                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->armv7m), &error_fatal);
 
     create_unimplemented_device("zbtsmram mirror", 0x00400000, 0x00400000);
     create_unimplemented_device("RESERVED 1", 0x00800000, 0x00800000);
@@ -305,23 +303,20 @@ static void mps2_common_init(MachineState *machine)
     cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
     cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
 
-    sysbus_init_child_obj(OBJECT(mms), "dualtimer", &mms->dualtimer,
-                          sizeof(mms->dualtimer), TYPE_CMSDK_APB_DUALTIMER);
+    object_initialize_child(OBJECT(mms), "dualtimer", &mms->dualtimer,
+                            TYPE_CMSDK_APB_DUALTIMER);
     qdev_prop_set_uint32(DEVICE(&mms->dualtimer), "pclk-frq", SYSCLK_FRQ);
-    object_property_set_bool(OBJECT(&mms->dualtimer), true, "realized",
-                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->dualtimer), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
 
-    sysbus_init_child_obj(OBJECT(mms), "scc", &mms->scc,
-                          sizeof(mms->scc), TYPE_MPS2_SCC);
+    object_initialize_child(OBJECT(mms), "scc", &mms->scc, TYPE_MPS2_SCC);
     sccdev = DEVICE(&mms->scc);
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
     qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
-    object_property_set_bool(OBJECT(&mms->scc), true, "realized",
-                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->scc), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index a1a6e887ed..d74042356d 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -142,11 +142,10 @@ static MemoryRegion *make_unimp_dev(MuscaMachineState *mms,
      */
     UnimplementedDeviceState *uds = opaque;
 
-    sysbus_init_child_obj(OBJECT(mms), name, uds, sizeof(*uds),
-                          TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(OBJECT(mms), name, uds, TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
     qdev_prop_set_uint64(DEVICE(uds), "size", size);
-    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(uds), &error_fatal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0);
 }
 
@@ -245,22 +244,21 @@ static MemoryRegion *make_mpc(MuscaMachineState *mms, void *opaque,
     case MPC_CRYPTOISLAND:
         /* We don't implement the CryptoIsland yet */
         uds = &mms->cryptoisland;
-        sysbus_init_child_obj(OBJECT(mms), name, uds, sizeof(*uds),
-                              TYPE_UNIMPLEMENTED_DEVICE);
+        object_initialize_child(OBJECT(mms), name, uds,
+                                TYPE_UNIMPLEMENTED_DEVICE);
         qdev_prop_set_string(DEVICE(uds), "name", mpcinfo[i].name);
         qdev_prop_set_uint64(DEVICE(uds), "size", mpcinfo[i].size);
-        object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(uds), &error_fatal);
         downstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0);
         break;
     default:
         g_assert_not_reached();
     }
 
-    sysbus_init_child_obj(OBJECT(mms), mpcname, mpc, sizeof(*mpc),
-                          TYPE_TZ_MPC);
+    object_initialize_child(OBJECT(mms), mpcname, mpc, TYPE_TZ_MPC);
     object_property_set_link(OBJECT(mpc), OBJECT(downstream),
                              "downstream", &error_fatal);
-    object_property_set_bool(OBJECT(mpc), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(mpc), &error_fatal);
     /* Map the upstream end of the MPC into system memory */
     upstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 1);
     memory_region_add_subregion(get_system_memory(), mpcinfo[i].addr, upstream);
@@ -279,8 +277,8 @@ static MemoryRegion *make_rtc(MuscaMachineState *mms, void *opaque,
 {
     PL031State *rtc = opaque;
 
-    sysbus_init_child_obj(OBJECT(mms), name, rtc, sizeof(*rtc), TYPE_PL031);
-    object_property_set_bool(OBJECT(rtc), true, "realized", &error_fatal);
+    object_initialize_child(OBJECT(mms), name, rtc, TYPE_PL031);
+    sysbus_realize(SYS_BUS_DEVICE(rtc), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(rtc), 0, get_sse_irq_in(mms, 39));
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(rtc), 0);
 }
@@ -293,9 +291,9 @@ static MemoryRegion *make_uart(MuscaMachineState *mms, void *opaque,
     int irqbase = 7 + i * 6;
     SysBusDevice *s;
 
-    sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(*uart), TYPE_PL011);
+    object_initialize_child(OBJECT(mms), name, uart, TYPE_PL011);
     qdev_prop_set_chr(DEVICE(uart), "chardev", serial_hd(i));
-    object_property_set_bool(OBJECT(uart), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(uart), &error_fatal);
     s = SYS_BUS_DEVICE(uart);
     sysbus_connect_irq(s, 0, get_sse_irq_in(mms, irqbase + 5)); /* combined */
     sysbus_connect_irq(s, 1, get_sse_irq_in(mms, irqbase + 0)); /* RX */
@@ -373,8 +371,8 @@ static void musca_init(MachineState *machine)
         exit(1);
     }
 
-    sysbus_init_child_obj(OBJECT(machine), "sse-200", &mms->sse,
-                          sizeof(mms->sse), TYPE_SSE200);
+    object_initialize_child(OBJECT(machine), "sse-200", &mms->sse,
+                            TYPE_SSE200);
     ssedev = DEVICE(&mms->sse);
     object_property_set_link(OBJECT(&mms->sse), OBJECT(system_memory),
                              "memory", &error_fatal);
@@ -390,8 +388,7 @@ static void musca_init(MachineState *machine)
         qdev_prop_set_bit(ssedev, "CPU0_FPU", true);
         qdev_prop_set_bit(ssedev, "CPU0_DSP", true);
     }
-    object_property_set_bool(OBJECT(&mms->sse), true, "realized",
-                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->sse), &error_fatal);
 
     /*
      * We need to create splitters to feed the IRQ inputs
@@ -531,8 +528,8 @@ static void musca_init(MachineState *machine)
         int port;
         char *gpioname;
 
-        sysbus_init_child_obj(OBJECT(machine), ppcinfo->name, ppc,
-                              sizeof(*ppc), TYPE_TZ_PPC);
+        object_initialize_child(OBJECT(machine), ppcinfo->name, ppc,
+                                TYPE_TZ_PPC);
         ppcdev = DEVICE(ppc);
 
         for (port = 0; port < TZ_NUM_PORTS; port++) {
@@ -551,7 +548,7 @@ static void musca_init(MachineState *machine)
             g_free(portname);
         }
 
-        object_property_set_bool(OBJECT(ppc), true, "realized", &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(ppc), &error_fatal);
 
         for (port = 0; port < TZ_NUM_PORTS; port++) {
             const PPCPortInfo *pinfo = &ppcinfo->ports[port];
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 3d8431dbcf..5bcca7f95b 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -500,13 +500,13 @@ static void versal_virt_init(MachineState *machine)
         psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     }
 
-    sysbus_init_child_obj(OBJECT(machine), "xlnx-versal", &s->soc,
-                          sizeof(s->soc), TYPE_XLNX_VERSAL);
+    object_initialize_child(OBJECT(machine), "xlnx-versal", &s->soc,
+                            TYPE_XLNX_VERSAL);
     object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
                              "ddr", &error_abort);
     object_property_set_int(OBJECT(&s->soc), psci_conduit,
                             "psci-conduit", &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
     create_virtio_regions(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 38d6b91d15..a27c315a6b 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -62,9 +62,8 @@ static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
     int nr_apu_cpus = ARRAY_SIZE(s->fpd.apu.cpu);
     int i;
 
-    sysbus_init_child_obj(OBJECT(s), "apu-gic",
-                          &s->fpd.apu.gic, sizeof(s->fpd.apu.gic),
-                          gicv3_class_name());
+    object_initialize_child(OBJECT(s), "apu-gic", &s->fpd.apu.gic,
+                            gicv3_class_name());
     gicbusdev = SYS_BUS_DEVICE(&s->fpd.apu.gic);
     gicdev = DEVICE(&s->fpd.apu.gic);
     qdev_prop_set_uint32(gicdev, "revision", 3);
@@ -74,8 +73,7 @@ static void versal_create_apu_gic(Versal *s, qemu_irq *pic)
     qdev_prop_set_uint32(gicdev, "redist-region-count[0]", 2);
     qdev_prop_set_bit(gicdev, "has-security-extensions", true);
 
-    object_property_set_bool(OBJECT(&s->fpd.apu.gic), true, "realized",
-                                    &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->fpd.apu.gic), &error_fatal);
 
     for (i = 0; i < ARRAY_SIZE(addrs); i++) {
         MemoryRegion *mr;
@@ -133,12 +131,11 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        sysbus_init_child_obj(OBJECT(s), name,
-                              &s->lpd.iou.uart[i], sizeof(s->lpd.iou.uart[i]),
-                              TYPE_PL011);
+        object_initialize_child(OBJECT(s), name, &s->lpd.iou.uart[i],
+                                TYPE_PL011);
         dev = DEVICE(&s->lpd.iou.uart[i]);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        qdev_init_nofail(dev);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
@@ -160,9 +157,8 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        sysbus_init_child_obj(OBJECT(s), name,
-                              &s->lpd.iou.gem[i], sizeof(s->lpd.iou.gem[i]),
-                              TYPE_CADENCE_GEM);
+        object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
+                                TYPE_CADENCE_GEM);
         dev = DEVICE(&s->lpd.iou.gem[i]);
         if (nd->used) {
             qemu_check_nic_model(nd, "cadence_gem");
@@ -174,7 +170,7 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         object_property_set_link(OBJECT(dev),
                                  OBJECT(&s->mr_ps), "dma",
                                  &error_abort);
-        qdev_init_nofail(dev);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
@@ -193,12 +189,11 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        sysbus_init_child_obj(OBJECT(s), name,
-                              &s->lpd.iou.adma[i], sizeof(s->lpd.iou.adma[i]),
-                              TYPE_XLNX_ZDMA);
+        object_initialize_child(OBJECT(s), name, &s->lpd.iou.adma[i],
+                                TYPE_XLNX_ZDMA);
         dev = DEVICE(&s->lpd.iou.adma[i]);
         object_property_set_int(OBJECT(dev), 128, "bus-width", &error_abort);
-        qdev_init_nofail(dev);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps,
@@ -218,9 +213,8 @@ static void versal_create_sds(Versal *s, qemu_irq *pic)
         DeviceState *dev;
         MemoryRegion *mr;
 
-        sysbus_init_child_obj(OBJECT(s), "sd[*]",
-                              &s->pmc.iou.sd[i], sizeof(s->pmc.iou.sd[i]),
-                              TYPE_SYSBUS_SDHCI);
+        object_initialize_child(OBJECT(s), "sd[*]", &s->pmc.iou.sd[i],
+                                TYPE_SYSBUS_SDHCI);
         dev = DEVICE(&s->pmc.iou.sd[i]);
 
         object_property_set_uint(OBJECT(dev),
@@ -228,7 +222,7 @@ static void versal_create_sds(Versal *s, qemu_irq *pic)
         object_property_set_uint(OBJECT(dev), SDHCI_CAPABILITIES, "capareg",
                                  &error_fatal);
         object_property_set_uint(OBJECT(dev), UHS_I, "uhs", &error_fatal);
-        qdev_init_nofail(dev);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->mr_ps,
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 1ad35e5529..f035079168 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2655,12 +2655,10 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
          * as we didn't know then if the CPU had the security extensions;
          * so we have to do it here.
          */
-        sysbus_init_child_obj(OBJECT(dev), "systick-reg-s",
-                              &s->systick[M_REG_S],
-                              sizeof(s->systick[M_REG_S]), TYPE_SYSTICK);
+        object_initialize_child(OBJECT(dev), "systick-reg-s",
+                                &s->systick[M_REG_S], TYPE_SYSTICK);
 
-        object_property_set_bool(OBJECT(&s->systick[M_REG_S]), true,
-                                 "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_S]), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 03008b5581..f5d4ac8cd4 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -454,14 +454,12 @@ static void boston_mach_init(MachineState *machine)
 
     is_64b = cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
 
-    sysbus_init_child_obj(OBJECT(machine), "cps", &s->cps, sizeof(s->cps),
-                          TYPE_MIPS_CPS);
+    object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-type",
                             &error_fatal);
     object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp",
                             &error_fatal);
-    object_property_set_bool(OBJECT(&s->cps), true, "realized",
-                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 92b9b1a5f6..cdfab19826 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -99,8 +99,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
     /* Inter-Thread Communication Unit */
     if (itu_present) {
-        sysbus_init_child_obj(OBJECT(dev), "itu", &s->itu, sizeof(s->itu),
-                              TYPE_MIPS_ITU);
+        object_initialize_child(OBJECT(dev), "itu", &s->itu, TYPE_MIPS_ITU);
         object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", &err);
         object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", &err);
         object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
@@ -108,7 +107,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         if (saar_present) {
             s->itu.saar = &env->CP0_SAAR;
         }
-        object_property_set_bool(OBJECT(&s->itu), true, "realized", &err);
+        sysbus_realize(SYS_BUS_DEVICE(&s->itu), &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -119,11 +118,10 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     }
 
     /* Cluster Power Controller */
-    sysbus_init_child_obj(OBJECT(dev), "cpc", &s->cpc, sizeof(s->cpc),
-                          TYPE_MIPS_CPC);
+    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_MIPS_CPC);
     object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp", &err);
     object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running", &err);
-    object_property_set_bool(OBJECT(&s->cpc), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpc), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -133,11 +131,10 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc), 0));
 
     /* Global Interrupt Controller */
-    sysbus_init_child_obj(OBJECT(dev), "gic", &s->gic, sizeof(s->gic),
-                          TYPE_MIPS_GIC);
+    object_initialize_child(OBJECT(dev), "gic", &s->gic, TYPE_MIPS_GIC);
     object_property_set_int(OBJECT(&s->gic), s->num_vp, "num-vp", &err);
     object_property_set_int(OBJECT(&s->gic), 128, "num-irq", &err);
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
@@ -149,14 +146,13 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     /* Global Configuration Registers */
     gcr_base = env->CP0_CMGCRBase << 4;
 
-    sysbus_init_child_obj(OBJECT(dev), "gcr", &s->gcr, sizeof(s->gcr),
-                          TYPE_MIPS_GCR);
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
     object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp", &err);
     object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev", &err);
     object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base", &err);
     object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->gic.mr), "gic", &err);
     object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc", &err);
-    object_property_set_bool(OBJECT(&s->gcr), true, "realized", &err);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 5115adfa22..29e6a2fa33 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1183,14 +1183,12 @@ static void create_cpu_without_cps(MachineState *ms,
 static void create_cps(MachineState *ms, MaltaState *s,
                        qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
-    sysbus_init_child_obj(OBJECT(s), "cps", &s->cps, sizeof(s->cps),
-                          TYPE_MIPS_CPS);
+    object_initialize_child(OBJECT(s), "cps", &s->cps, TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type",
                             &error_fatal);
     object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp",
                             &error_fatal);
-    object_property_set_bool(OBJECT(&s->cps), true, "realized",
-                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 82614c155a..9cd313c812 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -876,11 +876,11 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     int ret;
 
     /* Init VIAs 1 and 2 */
-    sysbus_init_child_obj(OBJECT(dev), "via1", &m->mos6522_via1,
-                          sizeof(m->mos6522_via1), TYPE_MOS6522_Q800_VIA1);
+    object_initialize_child(OBJECT(dev), "via1", &m->mos6522_via1,
+                            TYPE_MOS6522_Q800_VIA1);
 
-    sysbus_init_child_obj(OBJECT(dev), "via2", &m->mos6522_via2,
-                          sizeof(m->mos6522_via2), TYPE_MOS6522_Q800_VIA2);
+    object_initialize_child(OBJECT(dev), "via2", &m->mos6522_via2,
+                            TYPE_MOS6522_Q800_VIA2);
 
     /* Pass through mos6522 output IRQs */
     ms = MOS6522(&m->mos6522_via1);
@@ -890,10 +890,8 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
                               SYSBUS_DEVICE_GPIO_IRQ "[0]");
 
-    object_property_set_bool(OBJECT(&m->mos6522_via1), true, "realized",
-                             &error_abort);
-    object_property_set_bool(OBJECT(&m->mos6522_via2), true, "realized",
-                             &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&m->mos6522_via1), &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&m->mos6522_via2), &error_abort);
 
     /* Pass through mos6522 input IRQs */
     qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 01d52e758e..841e20d4e4 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -169,14 +169,13 @@ static void spike_board_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
 
     /* Initialize SOC */
-    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                          TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_HART_ARRAY);
     object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_abort);
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
@@ -275,14 +274,13 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     }
 
     /* Initialize SOC */
-    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                          TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_HART_ARRAY);
     object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_abort);
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
@@ -365,14 +363,13 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     }
 
     /* Initialize SOC */
-    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                          TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_HART_ARRAY);
     object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_abort);
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 802da232df..a88c8c4548 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -485,14 +485,13 @@ static void riscv_virt_board_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
 
     /* Initialize SOC */
-    sysbus_init_child_obj(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                          TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            TYPE_RISCV_HART_ARRAY);
     object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_abort);
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv_virt_board.ram",
-- 
2.21.3


