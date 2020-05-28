Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC18C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E982088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baIkFSnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E982088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGXu-0006kE-T9
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLU-0005xI-CL
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLG-0006lt-Gu
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rj45n46WUCAqRh7Zlf2j8Mdh4o2jliFJ8nTamCOHIks=;
 b=baIkFSnRgI1DTLn+HU7ph+TF2EVpM8Dav91qpvWQGT2fu7NCbUQpnzPGu6H94YTEdwA8y+
 1mVcLA+oh95Ey6dcK3KPJACIN4q7pAG3SYcmmKqemnrQnJpbUgrGqNOUMZeg88/gfwjLqm
 5nk8Pr8DdEJ0EmkamxZDXmRiWh7vEnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-ZuPaI6YyPnaDxO1tHsRwrA-1; Thu, 28 May 2020 07:04:47 -0400
X-MC-Unique: ZuPaI6YyPnaDxO1tHsRwrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA9048015D2;
 Thu, 28 May 2020 11:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CE851001268;
 Thu, 28 May 2020 11:04:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C25F61138611; Thu, 28 May 2020 13:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/24] arm/aspeed: Compute the number of CPUs from the SoC
 definition
Date: Thu, 28 May 2020 13:04:24 +0200
Message-Id: <20200528110444.20456-5-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

Commit ece09beec457 ("aspeed: introduce a configurable number of CPU
per machine") was a convient change during bringup but the Aspeed SoCs
have a fixed number of CPUs : one for the AST2400 and AST2500, and two
for the AST2600.

When the number of CPUs configured with -smp is less than the SoC's
fixed number, the "unconfigured" CPUs are left unrealized. This can
happen for machines ast2600-evb and tacoma-bmc, where the SoC's fixed
number is 2. To get virtual hardware that matches the physical
hardware, you have to pass -smp cpus=2 (or its sugared form -smp 2).

We normally reject -smp cpus=N when N exceeds the machine's limit.
Except we ignore cpus=2 (and only cpus=2) with a warning for machines
ast2500-evb, palmetto-bmc, romulus-bmc, sonorapass-bmc, swift-bmc, and
witherspoon-bmc.

Remove the "num-cpu" property from the SoC state and use the fixed
number of CPUs defined in the SoC class instead. Compute the default,
min, max number of CPUs of the machine directly from the SoC class
definition.

Machines ast2600-evb and tacoma-bmc now always get their second CPU as
they should. Visible in "info qom-tree"; here's the change for
ast2600-evb:

     /machine (ast2600-evb-machine)
       /peripheral (container)
       /peripheral-anon (container)
       /soc (ast2600-a1)
         /a7mpcore (a15mpcore_priv)
           /a15mp-priv-container[0] (qemu:memory-region)
           /gic (arm_gic)
             /gic_cpu[0] (qemu:memory-region)
             /gic_cpu[1] (qemu:memory-region)
    +        /gic_cpu[2] (qemu:memory-region)
             /gic_dist[0] (qemu:memory-region)
             /gic_vcpu[0] (qemu:memory-region)
             /gic_viface[0] (qemu:memory-region)
             /gic_viface[1] (qemu:memory-region)
    +        /gic_viface[2] (qemu:memory-region)
             /unnamed-gpio-in[0] (irq)
             [...]
    +        /unnamed-gpio-in[160] (irq)
             [same for 161 to 190...]
    +        /unnamed-gpio-in[191] (irq)

Also visible in "info qtree"; here's the change for ast2600-evb:

     bus: main-system-bus
       type System
       dev: a15mpcore_priv, id ""
         gpio-in "" 128
    -    gpio-out "sysbus-irq" 5
    -    num-cpu = 1 (0x1)
    +    gpio-out "sysbus-irq" 10
    +    num-cpu = 2 (0x2)
         num-irq = 160 (0xa0)
         mmio 0000000040460000/0000000000008000
       dev: arm_gic, id ""
    -    gpio-in "" 160
    -    num-cpu = 1 (0x1)
    +    gpio-in "" 192
    +    num-cpu = 2 (0x2)
         num-irq = 160 (0xa0)
         revision = 2 (0x2)
         has-security-extensions = true
         has-virtualization-extensions = true
         num-priority-bits = 8 (0x8)
         mmio ffffffffffffffff/0000000000001000
         mmio ffffffffffffffff/0000000000002000
         mmio ffffffffffffffff/0000000000001000
         mmio ffffffffffffffff/0000000000002000
         mmio ffffffffffffffff/0000000000000100
    +    mmio ffffffffffffffff/0000000000000100
    +    mmio ffffffffffffffff/0000000000000200
         mmio ffffffffffffffff/0000000000000200

The other machines now reject -smp cpus=2 just like -smp cpus=3 and up.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200519091631.1006073-1-clg@kaod.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message expanded]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/arm/aspeed_soc.h |  1 -
 hw/arm/aspeed.c             | 29 ++++++++++++++++++++++++-----
 hw/arm/aspeed_ast2600.c     | 20 +++++++-------------
 hw/arm/aspeed_soc.c         |  9 +--------
 4 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 78b9f6ae53..914115f3ef 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -40,7 +40,6 @@ typedef struct AspeedSoCState {
 
     /*< public >*/
     ARMCPU cpu[ASPEED_CPUS_NUM];
-    uint32_t num_cpus;
     A15MPPrivState     a7mpcore;
     MemoryRegion *dram_mr;
     MemoryRegion sram;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 2c23297edf..fd5cc542a5 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -283,8 +283,6 @@ static void aspeed_machine_init(MachineState *machine)
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), amc->num_cs, "num-cs",
                             &error_abort);
-    object_property_set_int(OBJECT(&bmc->soc), machine->smp.cpus, "num-cpus",
-                            &error_abort);
     object_property_set_link(OBJECT(&bmc->soc), OBJECT(&bmc->ram_container),
                              "dram", &error_abort);
     if (machine->kernel_filename) {
@@ -337,7 +335,7 @@ static void aspeed_machine_init(MachineState *machine)
         }
     }
 
-    if (machine->kernel_filename && bmc->soc.num_cpus > 1) {
+    if (machine->kernel_filename && sc->num_cpus > 1) {
         /* With no u-boot we must set up a boot stub for the secondary CPU */
         MemoryRegion *smpboot = g_new(MemoryRegion, 1);
         memory_region_init_ram(smpboot, OBJECT(bmc), "aspeed.smpboot",
@@ -352,7 +350,7 @@ static void aspeed_machine_init(MachineState *machine)
 
     aspeed_board_binfo.ram_size = ram_size;
     aspeed_board_binfo.loader_start = sc->memmap[ASPEED_SDRAM];
-    aspeed_board_binfo.nb_cpus = bmc->soc.num_cpus;
+    aspeed_board_binfo.nb_cpus = sc->num_cpus;
 
     if (amc->i2c_init) {
         amc->i2c_init(bmc);
@@ -549,12 +547,17 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
                            "boot directly from CE0 flash device");
 }
 
+static int aspeed_soc_num_cpus(const char *soc_name)
+{
+   AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(soc_name));
+   return sc->num_cpus;
+}
+
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->init = aspeed_machine_init;
-    mc->max_cpus = ASPEED_CPUS_NUM;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
@@ -576,6 +579,8 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 1;
     amc->i2c_init  = palmetto_bmc_i2c_init;
     mc->default_ram_size       = 256 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
@@ -591,6 +596,8 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 1;
     amc->i2c_init  = ast2500_evb_i2c_init;
     mc->default_ram_size       = 512 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
@@ -606,6 +613,8 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->i2c_init  = romulus_bmc_i2c_init;
     mc->default_ram_size       = 512 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
@@ -621,6 +630,8 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->i2c_init  = sonorapass_bmc_i2c_init;
     mc->default_ram_size       = 512 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_swift_class_init(ObjectClass *oc, void *data)
@@ -636,6 +647,8 @@ static void aspeed_machine_swift_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->i2c_init  = swift_bmc_i2c_init;
     mc->default_ram_size       = 512 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
@@ -651,6 +664,8 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init;
     mc->default_ram_size = 512 * MiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
@@ -667,6 +682,8 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 1;
     amc->i2c_init  = ast2600_evb_i2c_init;
     mc->default_ram_size = 1 * GiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
@@ -683,6 +700,8 @@ static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
     mc->default_ram_size = 1 * GiB;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus =
+        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static const TypeInfo aspeed_machine_types[] = {
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 71a0acfe26..c6821b3322 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -255,17 +255,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_VIDEO],
                                 0x1000);
 
-    if (s->num_cpus > sc->num_cpus) {
-        warn_report("%s: invalid number of CPUs %d, using default %d",
-                    sc->name, s->num_cpus, sc->num_cpus);
-        s->num_cpus = sc->num_cpus;
-    }
-
     /* CPU */
-    for (i = 0; i < s->num_cpus; i++) {
+    for (i = 0; i < sc->num_cpus; i++) {
         object_property_set_int(OBJECT(&s->cpu[i]), QEMU_PSCI_CONDUIT_SMC,
                                 "psci-conduit", &error_abort);
-        if (s->num_cpus > 1) {
+        if (sc->num_cpus > 1) {
             object_property_set_int(OBJECT(&s->cpu[i]),
                                     ASPEED_A7MPCORE_ADDR,
                                     "reset-cbar", &error_abort);
@@ -289,7 +283,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* A7MPCORE */
-    object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-cpu",
+    object_property_set_int(OBJECT(&s->a7mpcore), sc->num_cpus, "num-cpu",
                             &error_abort);
     object_property_set_int(OBJECT(&s->a7mpcore),
                             ASPEED_SOC_AST2600_MAX_IRQ + GIC_INTERNAL,
@@ -299,18 +293,18 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
 
-    for (i = 0; i < s->num_cpus; i++) {
+    for (i = 0; i < sc->num_cpus; i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
         DeviceState  *d   = DEVICE(qemu_get_cpu(i));
 
         irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
         sysbus_connect_irq(sbd, i, irq);
         irq = qdev_get_gpio_in(d, ARM_CPU_FIQ);
-        sysbus_connect_irq(sbd, i + s->num_cpus, irq);
+        sysbus_connect_irq(sbd, i + sc->num_cpus, irq);
         irq = qdev_get_gpio_in(d, ARM_CPU_VIRQ);
-        sysbus_connect_irq(sbd, i + 2 * s->num_cpus, irq);
+        sysbus_connect_irq(sbd, i + 2 * sc->num_cpus, irq);
         irq = qdev_get_gpio_in(d, ARM_CPU_VFIQ);
-        sysbus_connect_irq(sbd, i + 3 * s->num_cpus, irq);
+        sysbus_connect_irq(sbd, i + 3 * sc->num_cpus, irq);
     }
 
     /* SRAM */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index cf6b6dd116..e6f4b59134 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -242,14 +242,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_VIDEO],
                                 0x1000);
 
-    if (s->num_cpus > sc->num_cpus) {
-        warn_report("%s: invalid number of CPUs %d, using default %d",
-                    sc->name, s->num_cpus, sc->num_cpus);
-        s->num_cpus = sc->num_cpus;
-    }
-
     /* CPU */
-    for (i = 0; i < s->num_cpus; i++) {
+    for (i = 0; i < sc->num_cpus; i++) {
         object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
@@ -460,7 +454,6 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 }
 static Property aspeed_soc_properties[] = {
-    DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
     DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.21.3


