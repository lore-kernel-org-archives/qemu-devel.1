Received: from eggs.gnu.org ([2001:4830:134:3::10]:46085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpX-0002wv-1o
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpT-0001v0-OR
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:06 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:55139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvgpT-0001uA-Dr
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:03 -0400
Received: from player168.ha.ovh.net (unknown [10.109.159.68])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 34B8CC400F
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 12:39:02 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 31 Aug 2018 12:38:11 +0200
Message-Id: <20180831103816.13479-5-clg@kaod.org>
In-Reply-To: <20180831103816.13479-1-clg@kaod.org>
References: <20180831103816.13479-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/11] hw/arm/aspeed: add a 'mmio-exec'
 property to boot from the FMC flash module
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

Now that MMIO execution is supported, introduce a 'mmio-exec' property
to boot directly from CE0 of the FMC controller using a memory region
alias.

The overhead for the current firmware images using a custom U-Boot is
around 2 seconds, which is fine, but with a U-Boot from mainline, it
takes an extra 50 seconds or so to reach Linux. This might be related
to the fact that a device tree is used.

MMIO execution is not activated by default because until boot time is
improved.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed.h |  2 ++
 hw/arm/aspeed.c         | 43 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 2b77f8d2b3c8..d079f4d6e5db 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -30,6 +30,8 @@ typedef struct AspeedBoardConfig {
=20
 typedef struct AspeedMachine {
     MachineState parent_obj;
+
+    bool mmio_exec;
 } AspeedMachine;
=20
 #define ASPEED_MACHINE_CLASS(klass) \
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6b33ecd5aa43..3a66c2dedc3e 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -216,11 +216,18 @@ static void aspeed_board_init(MachineState *machine=
,
          * SoC and 128MB for the AST2500 SoC, which is twice as big as
          * needed by the flash modules of the Aspeed machines.
          */
-        memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_rom",
-                               fl->size, &error_abort);
-        memory_region_add_subregion(get_system_memory(), FIRMWARE_ADDR,
-                                    boot_rom);
-        write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort);
+        if (ASPEED_MACHINE(machine)->mmio_exec) {
+            memory_region_init_alias(boot_rom, OBJECT(bmc), "aspeed.boot=
_rom",
+                                     &fl->mmio, 0, fl->size);
+            memory_region_add_subregion(get_system_memory(), FIRMWARE_AD=
DR,
+                                        boot_rom);
+        } else {
+            memory_region_init_rom(boot_rom, OBJECT(bmc), "aspeed.boot_r=
om",
+                                   fl->size, &error_abort);
+            memory_region_add_subregion(get_system_memory(), FIRMWARE_AD=
DR,
+                                        boot_rom);
+            write_boot_rom(drive0, FIRMWARE_ADDR, fl->size, &error_abort=
);
+        }
     }
=20
     aspeed_board_binfo.kernel_filename =3D machine->kernel_filename;
@@ -313,6 +320,29 @@ static void aspeed_machine_init(MachineState *machin=
e)
     aspeed_board_init(machine, amc->board);
 }
=20
+static bool aspeed_get_mmio_exec(Object *obj, Error **errp)
+{
+    return ASPEED_MACHINE(obj)->mmio_exec;
+}
+
+static void aspeed_set_mmio_exec(Object *obj, bool value, Error **errp)
+{
+    ASPEED_MACHINE(obj)->mmio_exec =3D value;
+}
+
+static void aspeed_machine_instance_init(Object *obj)
+{
+    ASPEED_MACHINE(obj)->mmio_exec =3D false;
+}
+
+static void aspeed_machine_class_props_init(ObjectClass *oc)
+{
+    object_class_property_add_bool(oc, "mmio-exec", aspeed_get_mmio_exec=
,
+                                   aspeed_set_mmio_exec, &error_abort);
+    object_class_property_set_description(oc, "mmio-exec",
+                              "boot using MMIO execution", &error_abort)=
;
+}
+
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -327,6 +357,8 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
     mc->no_cdrom =3D 1;
     mc->no_parallel =3D 1;
     amc->board =3D board;
+
+    aspeed_machine_class_props_init(oc);
 }
=20
 static const TypeInfo aspeed_machine_type =3D {
@@ -334,6 +366,7 @@ static const TypeInfo aspeed_machine_type =3D {
     .parent =3D TYPE_MACHINE,
     .instance_size =3D sizeof(AspeedMachine),
     .class_size =3D sizeof(AspeedMachineClass),
+    .instance_init =3D aspeed_machine_instance_init,
     .abstract =3D true,
 };
=20
--=20
2.17.1
