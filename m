Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC9C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2964205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2964205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO3JG-00075f-3r
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 12:51:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO35b-0002sT-5h
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO35Z-0003wA-WC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hO35X-0003rT-3q; Tue, 07 May 2019 12:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22DDF99DBA;
	Tue,  7 May 2019 16:37:06 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AAE28162;
	Tue,  7 May 2019 16:36:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  7 May 2019 18:34:09 +0200
Message-Id: <20190507163416.24647-10-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-1-philmd@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 07 May 2019 16:37:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 09/16] hw/mips: Use object_initialize() on
 MIPSCPSState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Joel Stanley <joel@jms.id.au>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initialize the MIPSCPSState with object_initialize() instead of
object_new(). This will allow us to add it as children of the
machine container.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/boston.c     | 25 ++++++++++++-------------
 hw/mips/mips_malta.c | 17 ++++++++---------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index a8b29f62f5b..cb3ea85fdc1 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -49,7 +49,7 @@ typedef struct {
     SysBusDevice parent_obj;
=20
     MachineState *mach;
-    MIPSCPSState *cps;
+    MIPSCPSState cps;
     SerialState *uart;
=20
     CharBackend lcd_display;
@@ -188,7 +188,7 @@ static uint64_t boston_platreg_read(void *opaque, hwa=
ddr addr,
     case PLAT_DDR3_STATUS:
         return PLAT_DDR3_STATUS_LOCKED | PLAT_DDR3_STATUS_CALIBRATED;
     case PLAT_MMCM_DIV:
-        gic_freq =3D mips_gictimer_get_freq(s->cps->gic.gic_timer) / 100=
0000;
+        gic_freq =3D mips_gictimer_get_freq(s->cps.gic.gic_timer) / 1000=
000;
         val =3D gic_freq << PLAT_MMCM_DIV_INPUT_SHIFT;
         val |=3D 1 << PLAT_MMCM_DIV_MUL_SHIFT;
         val |=3D 1 << PLAT_MMCM_DIV_CLK0DIV_SHIFT;
@@ -455,20 +455,19 @@ static void boston_mach_init(MachineState *machine)
=20
     is_64b =3D cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
=20
-    s->cps =3D MIPS_CPS(object_new(TYPE_MIPS_CPS));
-    qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
-
-    object_property_set_str(OBJECT(s->cps), machine->cpu_type, "cpu-type=
",
+    object_initialize(&s->cps, sizeof(s->cps), TYPE_MIPS_CPS);
+    qdev_set_parent_bus(DEVICE(&s->cps), sysbus_get_default());
+    object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-typ=
e",
                             &err);
-    object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
-    object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
+    object_property_set_int(OBJECT(&s->cps), smp_cpus, "num-vp", &err);
+    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
=20
     if (err !=3D NULL) {
         error_report("%s", error_get_pretty(err));
         exit(1);
     }
=20
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
=20
     flash =3D  g_new(MemoryRegion, 1);
     memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err)=
;
@@ -487,17 +486,17 @@ static void boston_mach_init(MachineState *machine)
     xilinx_pcie_init(sys_mem, 0,
                      0x10000000, 32 * MiB,
                      0x40000000, 1 * GiB,
-                     get_cps_irq(s->cps, 2), false);
+                     get_cps_irq(&s->cps, 2), false);
=20
     xilinx_pcie_init(sys_mem, 1,
                      0x12000000, 32 * MiB,
                      0x20000000, 512 * MiB,
-                     get_cps_irq(s->cps, 1), false);
+                     get_cps_irq(&s->cps, 1), false);
=20
     pcie2 =3D xilinx_pcie_init(sys_mem, 2,
                              0x14000000, 32 * MiB,
                              0x16000000, 1 * MiB,
-                             get_cps_irq(s->cps, 0), true);
+                             get_cps_irq(&s->cps, 0), true);
=20
     platreg =3D g_new(MemoryRegion, 1);
     memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
@@ -505,7 +504,7 @@ static void boston_mach_init(MachineState *machine)
     memory_region_add_subregion_overlap(sys_mem, 0x17ffd000, platreg, 0)=
;
=20
     s->uart =3D serial_mm_init(sys_mem, 0x17ffe000, 2,
-                             get_cps_irq(s->cps, 3), 10000000,
+                             get_cps_irq(&s->cps, 3), 10000000,
                              serial_hd(0), DEVICE_NATIVE_ENDIAN);
=20
     lcd =3D g_new(MemoryRegion, 1);
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 439665ab45e..04f2117d71e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -94,7 +94,7 @@ typedef struct {
 typedef struct {
     SysBusDevice parent_obj;
=20
-    MIPSCPSState *cps;
+    MIPSCPSState cps;
     qemu_irq *i8259;
 } MaltaState;
=20
@@ -1151,20 +1151,19 @@ static void create_cps(MaltaState *s, const char =
*cpu_type,
 {
     Error *err =3D NULL;
=20
-    s->cps =3D MIPS_CPS(object_new(TYPE_MIPS_CPS));
-    qdev_set_parent_bus(DEVICE(s->cps), sysbus_get_default());
-
-    object_property_set_str(OBJECT(s->cps), cpu_type, "cpu-type", &err);
-    object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
-    object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
+    object_initialize(&s->cps, sizeof(s->cps), TYPE_MIPS_CPS);
+    qdev_set_parent_bus(DEVICE(&s->cps), sysbus_get_default());
+    object_property_set_str(OBJECT(&s->cps), cpu_type, "cpu-type", &err)=
;
+    object_property_set_int(OBJECT(&s->cps), smp_cpus, "num-vp", &err);
+    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
     if (err !=3D NULL) {
         error_report("%s", error_get_pretty(err));
         exit(1);
     }
=20
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
=20
-    *i8259_irq =3D get_cps_irq(s->cps, 3);
+    *i8259_irq =3D get_cps_irq(&s->cps, 3);
     *cbus_irq =3D NULL;
 }
=20
--=20
2.20.1


