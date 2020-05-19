Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2BCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8BF20756
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8BF20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jayNj-00071d-Dk
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jayMf-0006Eo-JK
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:16:45 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:48645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jayMd-00037F-9v
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:16:45 -0400
Received: from player694.ha.ovh.net (unknown [10.108.57.150])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 85E8B27FCE3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:16:40 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 4F918126C8305;
 Tue, 19 May 2020 09:16:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001e6ebdbc6-b6bb-4170-a941-45022525ee74,3DCE2E61E2D7C1BA27EF92566E0C35A5904F621F)
 smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] arm/aspeed: Compute the number of CPUs from the SoC definition
Date: Tue, 19 May 2020 11:16:31 +0200
Message-Id: <20200519091631.1006073-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11815193626044959505
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtjedgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeikeekleffteegleevveejheetuddviedvleejvedvueevtdfgieduieeviedugfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.182.191; envelope-from=clg@kaod.org;
 helo=13.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 05:16:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ece09beec457 ("aspeed: introduce a configurable number of CPU
per machine") was a convient change during bringup but the Aspeed SoCs
have a fixed number of CPUs : one for the AST2400 and AST2500, and two
for the AST2600.

Remove the "num-cpu" property from the SoC state and use the fixed
number of CPUs defined in the SoC class instead. Compute the default,
min, max number of CPUs of the machine directly from the SoC class
definition.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |  1 -
 hw/arm/aspeed.c             | 29 ++++++++++++++++++++++++-----
 hw/arm/aspeed_ast2600.c     | 20 +++++++-------------
 hw/arm/aspeed_soc.c         |  9 +--------
 4 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 78b9f6ae532f..914115f3ef77 100644
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
index 4d57d1e4363b..6f8f4b88f8ab 100644
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
                            "boot directly from CE0 flash device", &error_abort);
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
index c6e0ab84ac86..114b94f8f44d 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -256,17 +256,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
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
@@ -290,7 +284,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* A7MPCORE */
-    object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-cpu",
+    object_property_set_int(OBJECT(&s->a7mpcore), sc->num_cpus, "num-cpu",
                             &error_abort);
     object_property_set_int(OBJECT(&s->a7mpcore),
                             ASPEED_SOC_AST2600_MAX_IRQ + GIC_INTERNAL,
@@ -300,18 +294,18 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
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
index 696c7fda14b7..984d29087dce 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -243,14 +243,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
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
@@ -461,7 +455,6 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 }
 static Property aspeed_soc_properties[] = {
-    DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
     DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.25.4


