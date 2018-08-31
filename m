Received: from eggs.gnu.org ([2001:4830:134:3::10]:46026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpO-0002nk-MK
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpL-0001m9-Er
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:58 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:60576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvgpL-0001kL-7J
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:38:55 -0400
Received: from player168.ha.ovh.net (unknown [10.109.143.208])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id ECB56C454A
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 12:38:53 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 31 Aug 2018 12:38:10 +0200
Message-Id: <20180831103816.13479-4-clg@kaod.org>
In-Reply-To: <20180831103816.13479-1-clg@kaod.org>
References: <20180831103816.13479-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/11] hw/arm/aspeed: Add an Aspeed machine
 class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The code looks better, it removes duplicated lines and it will ease
the introduction of common properties for the Aspeed machines.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed.h |  46 +++++++++
 hw/arm/aspeed.c         | 212 +++++++++++++---------------------------
 2 files changed, 116 insertions(+), 142 deletions(-)
 create mode 100644 include/hw/arm/aspeed.h

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
new file mode 100644
index 000000000000..2b77f8d2b3c8
--- /dev/null
+++ b/include/hw/arm/aspeed.h
@@ -0,0 +1,46 @@
+/*
+ * Aspeed Machines
+ *
+ * Copyright 2018 IBM Corp.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef _ARM_ASPEED_H
+#define _ARM_ASPEED_H
+
+#include "hw/boards.h"
+
+typedef struct AspeedBoardState AspeedBoardState;
+
+typedef struct AspeedBoardConfig {
+    const char *name;
+    const char *desc;
+    const char *soc_name;
+    uint32_t hw_strap1;
+    const char *fmc_model;
+    const char *spi_model;
+    uint32_t num_cs;
+    void (*i2c_init)(AspeedBoardState *bmc);
+} AspeedBoardConfig;
+
+#define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
+#define ASPEED_MACHINE(obj) \
+    OBJECT_CHECK(AspeedMachine, (obj), TYPE_ASPEED_MACHINE)
+
+typedef struct AspeedMachine {
+    MachineState parent_obj;
+} AspeedMachine;
+
+#define ASPEED_MACHINE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedMachineClass, (klass), TYPE_ASPEED_MACHINE=
)
+#define ASPEED_MACHINE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedMachineClass, (obj), TYPE_ASPEED_MACHINE)
+
+typedef struct AspeedMachineClass {
+    MachineClass parent_obj;
+    const AspeedBoardConfig *board;
+} AspeedMachineClass;
+
+
+#endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f2d64e45511a..6b33ecd5aa43 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/arm.h"
+#include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/boards.h"
 #include "hw/i2c/smbus.h"
@@ -34,22 +35,6 @@ typedef struct AspeedBoardState {
     MemoryRegion max_ram;
 } AspeedBoardState;
=20
-typedef struct AspeedBoardConfig {
-    const char *soc_name;
-    uint32_t hw_strap1;
-    const char *fmc_model;
-    const char *spi_model;
-    uint32_t num_cs;
-    void (*i2c_init)(AspeedBoardState *bmc);
-} AspeedBoardConfig;
-
-enum {
-    PALMETTO_BMC,
-    AST2500_EVB,
-    ROMULUS_BMC,
-    WITHERSPOON_BMC,
-};
-
 /* Palmetto hardware value: 0x120CE416 */
 #define PALMETTO_BMC_HW_STRAP1 (                                        =
\
         SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_256MB) |               =
\
@@ -88,46 +73,6 @@ enum {
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
=20
-static void palmetto_bmc_i2c_init(AspeedBoardState *bmc);
-static void ast2500_evb_i2c_init(AspeedBoardState *bmc);
-static void romulus_bmc_i2c_init(AspeedBoardState *bmc);
-static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc);
-
-static const AspeedBoardConfig aspeed_boards[] =3D {
-    [PALMETTO_BMC] =3D {
-        .soc_name  =3D "ast2400-a1",
-        .hw_strap1 =3D PALMETTO_BMC_HW_STRAP1,
-        .fmc_model =3D "n25q256a",
-        .spi_model =3D "mx25l25635e",
-        .num_cs    =3D 1,
-        .i2c_init  =3D palmetto_bmc_i2c_init,
-    },
-    [AST2500_EVB]  =3D {
-        .soc_name  =3D "ast2500-a1",
-        .hw_strap1 =3D AST2500_EVB_HW_STRAP1,
-        .fmc_model =3D "w25q256",
-        .spi_model =3D "mx25l25635e",
-        .num_cs    =3D 1,
-        .i2c_init  =3D ast2500_evb_i2c_init,
-    },
-    [ROMULUS_BMC]  =3D {
-        .soc_name  =3D "ast2500-a1",
-        .hw_strap1 =3D ROMULUS_BMC_HW_STRAP1,
-        .fmc_model =3D "n25q256a",
-        .spi_model =3D "mx66l1g45g",
-        .num_cs    =3D 2,
-        .i2c_init  =3D romulus_bmc_i2c_init,
-    },
-    [WITHERSPOON_BMC]  =3D {
-        .soc_name  =3D "ast2500-a1",
-        .hw_strap1 =3D WITHERSPOON_BMC_HW_STRAP1,
-        .fmc_model =3D "mx25l25635e",
-        .spi_model =3D "mx66l1g45g",
-        .num_cs    =3D 2,
-        .i2c_init  =3D witherspoon_bmc_i2c_init,
-    },
-};
-
 /*
  * The max ram region is for firmwares that scan the address space
  * with load/store to guess how much RAM the SoC has.
@@ -313,30 +258,6 @@ static void palmetto_bmc_i2c_init(AspeedBoardState *=
bmc)
     object_property_set_int(OBJECT(dev), 110000, "temperature3", &error_=
abort);
 }
=20
-static void palmetto_bmc_init(MachineState *machine)
-{
-    aspeed_board_init(machine, &aspeed_boards[PALMETTO_BMC]);
-}
-
-static void palmetto_bmc_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc =3D MACHINE_CLASS(oc);
-
-    mc->desc =3D "OpenPOWER Palmetto BMC (ARM926EJ-S)";
-    mc->init =3D palmetto_bmc_init;
-    mc->max_cpus =3D 1;
-    mc->no_sdcard =3D 1;
-    mc->no_floppy =3D 1;
-    mc->no_cdrom =3D 1;
-    mc->no_parallel =3D 1;
-}
-
-static const TypeInfo palmetto_bmc_type =3D {
-    .name =3D MACHINE_TYPE_NAME("palmetto-bmc"),
-    .parent =3D TYPE_MACHINE,
-    .class_init =3D palmetto_bmc_class_init,
-};
-
 static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
@@ -353,30 +274,6 @@ static void ast2500_evb_i2c_init(AspeedBoardState *b=
mc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338"=
, 0x32);
 }
=20
-static void ast2500_evb_init(MachineState *machine)
-{
-    aspeed_board_init(machine, &aspeed_boards[AST2500_EVB]);
-}
-
-static void ast2500_evb_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc =3D MACHINE_CLASS(oc);
-
-    mc->desc =3D "Aspeed AST2500 EVB (ARM1176)";
-    mc->init =3D ast2500_evb_init;
-    mc->max_cpus =3D 1;
-    mc->no_sdcard =3D 1;
-    mc->no_floppy =3D 1;
-    mc->no_cdrom =3D 1;
-    mc->no_parallel =3D 1;
-}
-
-static const TypeInfo ast2500_evb_type =3D {
-    .name =3D MACHINE_TYPE_NAME("ast2500-evb"),
-    .parent =3D TYPE_MACHINE,
-    .class_init =3D ast2500_evb_class_init,
-};
-
 static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
@@ -386,30 +283,6 @@ static void romulus_bmc_i2c_init(AspeedBoardState *b=
mc)
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338"=
, 0x32);
 }
=20
-static void romulus_bmc_init(MachineState *machine)
-{
-    aspeed_board_init(machine, &aspeed_boards[ROMULUS_BMC]);
-}
-
-static void romulus_bmc_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc =3D MACHINE_CLASS(oc);
-
-    mc->desc =3D "OpenPOWER Romulus BMC (ARM1176)";
-    mc->init =3D romulus_bmc_init;
-    mc->max_cpus =3D 1;
-    mc->no_sdcard =3D 1;
-    mc->no_floppy =3D 1;
-    mc->no_cdrom =3D 1;
-    mc->no_parallel =3D 1;
-}
-
-static const TypeInfo romulus_bmc_type =3D {
-    .name =3D MACHINE_TYPE_NAME("romulus-bmc"),
-    .parent =3D TYPE_MACHINE,
-    .class_init =3D romulus_bmc_class_init,
-};
-
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc =3D &bmc->soc;
@@ -433,36 +306,91 @@ static void witherspoon_bmc_i2c_init(AspeedBoardSta=
te *bmc)
                      0x60);
 }
=20
-static void witherspoon_bmc_init(MachineState *machine)
+static void aspeed_machine_init(MachineState *machine)
 {
-    aspeed_board_init(machine, &aspeed_boards[WITHERSPOON_BMC]);
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_GET_CLASS(machine);
+
+    aspeed_board_init(machine, amc->board);
 }
=20
-static void witherspoon_bmc_class_init(ObjectClass *oc, void *data)
+static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
+    const AspeedBoardConfig *board =3D data;
=20
-    mc->desc =3D "OpenPOWER Witherspoon BMC (ARM1176)";
-    mc->init =3D witherspoon_bmc_init;
+    mc->desc =3D board->desc;
+    mc->init =3D aspeed_machine_init;
     mc->max_cpus =3D 1;
     mc->no_sdcard =3D 1;
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
+    amc->board =3D board;
 }
=20
-static const TypeInfo witherspoon_bmc_type =3D {
-    .name =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
+static const TypeInfo aspeed_machine_type =3D {
+    .name =3D TYPE_ASPEED_MACHINE,
     .parent =3D TYPE_MACHINE,
-    .class_init =3D witherspoon_bmc_class_init,
+    .instance_size =3D sizeof(AspeedMachine),
+    .class_size =3D sizeof(AspeedMachineClass),
+    .abstract =3D true,
+};
+
+static const AspeedBoardConfig aspeed_boards[] =3D {
+    {
+        .name      =3D MACHINE_TYPE_NAME("palmetto-bmc"),
+        .desc      =3D "OpenPOWER Palmetto BMC (ARM926EJ-S)",
+        .soc_name  =3D "ast2400-a1",
+        .hw_strap1 =3D PALMETTO_BMC_HW_STRAP1,
+        .fmc_model =3D "n25q256a",
+        .spi_model =3D "mx25l25635e",
+        .num_cs    =3D 1,
+        .i2c_init  =3D palmetto_bmc_i2c_init,
+    }, {
+        .name      =3D MACHINE_TYPE_NAME("ast2500-evb"),
+        .desc      =3D "Aspeed AST2500 EVB (ARM1176)",
+        .soc_name  =3D "ast2500-a1",
+        .hw_strap1 =3D AST2500_EVB_HW_STRAP1,
+        .fmc_model =3D "w25q256",
+        .spi_model =3D "mx25l25635e",
+        .num_cs    =3D 1,
+        .i2c_init  =3D ast2500_evb_i2c_init,
+    }, {
+        .name      =3D MACHINE_TYPE_NAME("romulus-bmc"),
+        .desc      =3D "OpenPOWER Romulus BMC (ARM1176)",
+        .soc_name  =3D "ast2500-a1",
+        .hw_strap1 =3D ROMULUS_BMC_HW_STRAP1,
+        .fmc_model =3D "n25q256a",
+        .spi_model =3D "mx66l1g45g",
+        .num_cs    =3D 2,
+        .i2c_init  =3D romulus_bmc_i2c_init,
+    }, {
+        .name      =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
+        .desc      =3D "OpenPOWER Witherspoon BMC (ARM1176)",
+        .soc_name  =3D "ast2500-a1",
+        .hw_strap1 =3D WITHERSPOON_BMC_HW_STRAP1,
+        .fmc_model =3D "mx25l25635e",
+        .spi_model =3D "mx66l1g45g",
+        .num_cs    =3D 2,
+        .i2c_init  =3D witherspoon_bmc_i2c_init,
+    },
 };
=20
-static void aspeed_machine_init(void)
+static void aspeed_machine_types(void)
 {
-    type_register_static(&palmetto_bmc_type);
-    type_register_static(&ast2500_evb_type);
-    type_register_static(&romulus_bmc_type);
-    type_register_static(&witherspoon_bmc_type);
+    int i;
+
+    type_register_static(&aspeed_machine_type);
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_boards); ++i) {
+        TypeInfo ti =3D {
+            .name       =3D aspeed_boards[i].name,
+            .parent     =3D TYPE_ASPEED_MACHINE,
+            .class_init =3D aspeed_machine_class_init,
+            .class_data =3D (void *)&aspeed_boards[i],
+        };
+        type_register(&ti);
+    }
 }
=20
-type_init(aspeed_machine_init)
+type_init(aspeed_machine_types)
--=20
2.17.1
