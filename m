Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE1AC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53262084A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53262084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHhB-0004R4-W1
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdHMx-0008AS-82
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdHMv-0003zg-ME
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:03 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:39909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdHMv-0003xb-Fq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:01 -0400
Received: from player157.ha.ovh.net (unknown [10.108.35.240])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id E9A805E048
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:53:59 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 679836EB51A4;
 Tue, 18 Jun 2019 16:53:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 18:52:55 +0200
Message-Id: <20190618165311.27066-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618165311.27066-1-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1668302190663994129
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.42.102
Subject: [Qemu-devel] [PATCH v2 05/21] aspeed: introduce a configurable
 number of CPU per machine
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current models of the Aspeed SoCs only have one CPU but future
ones will support SMP. Introduce a new num_cpus field at the SoC class
level to define the number of available CPUs per SoC and also
introduce a 'num-cpus' property to activate the CPUs configured for
the machine.

The max_cpus limit of the machine should depend on the SoC definition
but, unfortunately, these values are not available when the machine
class is initialized. This is the reason why we add a check on
num_cpus in the AspeedSoC realize handler.

SMP support will be activated when models for such SoCs are implemented.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes sinve v1:

  - reworked the logic to put the number of CPUs under the SoC

 include/hw/arm/aspeed_soc.h |  5 ++++-
 hw/arm/aspeed.c             |  7 +++++--
 hw/arm/aspeed_soc.c         | 33 +++++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index fa0ba957a611..b613b00600fc 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -24,13 +24,15 @@
=20
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
+#define ASPEED_CPUS_NUM  2
=20
 typedef struct AspeedSoCState {
     /*< private >*/
     DeviceState parent;
=20
     /*< public >*/
-    ARMCPU cpu;
+    ARMCPU cpu[ASPEED_CPUS_NUM];
+    uint32_t num_cpus;
     MemoryRegion sram;
     AspeedVICState vic;
     AspeedRtcState rtc;
@@ -58,6 +60,7 @@ typedef struct AspeedSoCInfo {
     int wdts_num;
     const int *irqmap;
     const hwaddr *memmap;
+    uint32_t num_cpus;
 } AspeedSoCInfo;
=20
 typedef struct AspeedSoCClass {
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index c692ca1dba90..96de4f5c2a87 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -22,13 +22,13 @@
 #include "hw/misc/tmp105.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/sysemu.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
=20
 static struct arm_boot_info aspeed_board_binfo =3D {
     .board_id =3D -1, /* device-tree-only board */
-    .nb_cpus =3D 1,
 };
=20
 struct AspeedBoardState {
@@ -171,6 +171,8 @@ static void aspeed_board_init(MachineState *machine,
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
                             &error_abort);
+    object_property_set_int(OBJECT(&bmc->soc), smp_cpus, "num-cpus",
+                            &error_abort);
     if (machine->kernel_filename) {
         /*
          * When booting with a -kernel command line there is no u-boot
@@ -230,6 +232,7 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
     aspeed_board_binfo.ram_size =3D ram_size;
     aspeed_board_binfo.loader_start =3D sc->info->memmap[ASPEED_SDRAM];
+    aspeed_board_binfo.nb_cpus =3D bmc->soc.num_cpus;
=20
     if (cfg->i2c_init) {
         cfg->i2c_init(bmc);
@@ -326,7 +329,7 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
=20
     mc->desc =3D board->desc;
     mc->init =3D aspeed_machine_init;
-    mc->max_cpus =3D 1;
+    mc->max_cpus =3D ASPEED_CPUS_NUM;
     mc->no_sdcard =3D 1;
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5faa78d81fd6..d38fb0aaa0f5 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -19,6 +19,7 @@
 #include "hw/char/serial.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "net/net.h"
=20
@@ -123,6 +124,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .wdts_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2400_irqmap,
         .memmap       =3D aspeed_soc_ast2400_memmap,
+        .num_cpus     =3D 1,
     }, {
         .name         =3D "ast2400-a1",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
@@ -134,6 +136,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .wdts_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2400_irqmap,
         .memmap       =3D aspeed_soc_ast2400_memmap,
+        .num_cpus     =3D 1,
     }, {
         .name         =3D "ast2400",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm926"),
@@ -145,6 +148,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .wdts_num     =3D 2,
         .irqmap       =3D aspeed_soc_ast2400_irqmap,
         .memmap       =3D aspeed_soc_ast2400_memmap,
+        .num_cpus     =3D 1,
     }, {
         .name         =3D "ast2500-a1",
         .cpu_type     =3D ARM_CPU_TYPE_NAME("arm1176"),
@@ -156,6 +160,7 @@ static const AspeedSoCInfo aspeed_socs[] =3D {
         .wdts_num     =3D 3,
         .irqmap       =3D aspeed_soc_ast2500_irqmap,
         .memmap       =3D aspeed_soc_ast2500_memmap,
+        .num_cpus     =3D 1,
     },
 };
=20
@@ -172,8 +177,11 @@ static void aspeed_soc_init(Object *obj)
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
     int i;
=20
-    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cpu),
-                            sc->info->cpu_type, &error_abort, NULL);
+    for (i =3D 0; i < sc->info->num_cpus; i++) {
+        object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
+                                sizeof(s->cpu[i]), sc->info->cpu_type,
+                                &error_abort, NULL);
+    }
=20
     sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
                           TYPE_ASPEED_SCU);
@@ -241,11 +249,19 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
     create_unimplemented_device("aspeed_soc.io", sc->info->memmap[ASPEED=
_IOMEM],
                                 ASPEED_SOC_IOMEM_SIZE);
=20
+    if (s->num_cpus > sc->info->num_cpus) {
+        warn_report("%s: invalid number of CPUs %d, using default %d",
+                    sc->info->name, s->num_cpus, sc->info->num_cpus);
+        s->num_cpus =3D sc->info->num_cpus;
+    }
+
     /* CPU */
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
+    for (i =3D 0; i < s->num_cpus; i++) {
+        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &=
err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
     }
=20
     /* SRAM */
@@ -380,6 +396,10 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
                        aspeed_soc_get_irq(s, ASPEED_ETH1));
 }
+static Property aspeed_soc_properties[] =3D {
+    DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
=20
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 {
@@ -390,6 +410,7 @@ static void aspeed_soc_class_init(ObjectClass *oc, vo=
id *data)
     dc->realize =3D aspeed_soc_realize;
     /* Reason: Uses serial_hds and nd_table in realize() directly */
     dc->user_creatable =3D false;
+    dc->props =3D aspeed_soc_properties;
 }
=20
 static const TypeInfo aspeed_soc_type_info =3D {
--=20
2.21.0


