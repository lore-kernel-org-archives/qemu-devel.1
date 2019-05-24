Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA0AC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18432217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18432217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58867 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFIC-0003XB-Aq
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:51:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFCR-0007JL-Ow
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFCQ-0006d8-DT
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUFCQ-0006ai-4M
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F736A705;
	Fri, 24 May 2019 18:45:46 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7AF211001DED;
	Fri, 24 May 2019 18:45:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 24 May 2019 15:44:43 -0300
Message-Id: <20190524184447.16678-14-ehabkost@redhat.com>
In-Reply-To: <20190524184447.16678-1-ehabkost@redhat.com>
References: <20190524184447.16678-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 24 May 2019 18:45:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/17] hw/microblaze/zynqmp: Let the SoC manage
 the IPI devices
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The Inter Processor Interrupt is a block part of the SoC, not the
"machine" (See Zynq UltraScale+ Device TRM UG1085, "Platform
Management Unit", Power Domains and Islands).

Move the IPI management from the machine to the SoC.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190507163416.24647-13-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/microblaze/xlnx-zynqmp-pmu.c | 36 +++++++++++++++------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-=
pmu.c
index eba9945c19..20e973edf5 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -68,6 +68,13 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
=20
     sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
                           TYPE_XLNX_PMU_IO_INTC);
+
+    /* Create the IPI device */
+    for (int i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        object_initialize(&s->ipi[i], sizeof(XlnxZynqMPIPI),
+                          TYPE_XLNX_ZYNQMP_IPI);
+        qdev_set_parent_bus(DEVICE(&s->ipi[i]), sysbus_get_default());
+    }
 }
=20
 static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
@@ -113,6 +120,15 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState =
*dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_AD=
DR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->intc), 0,
                        qdev_get_gpio_in(DEVICE(&s->cpu), MB_CPU_IRQ));
+
+    /* Connect the IPI device */
+    for (int i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        object_property_set_bool(OBJECT(&s->ipi[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi[i]), 0, ipi_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->intc), ipi_irq[i]=
));
+    }
 }
=20
 static void xlnx_zynqmp_pmu_soc_class_init(ObjectClass *oc, void *data)
@@ -145,8 +161,6 @@ static void xlnx_zynqmp_pmu_init(MachineState *machin=
e)
     MemoryRegion *address_space_mem =3D get_system_memory();
     MemoryRegion *pmu_rom =3D g_new(MemoryRegion, 1);
     MemoryRegion *pmu_ram =3D g_new(MemoryRegion, 1);
-    qemu_irq irq[32];
-    int i;
=20
     /* Create the ROM */
     memory_region_init_rom(pmu_rom, NULL, "xlnx-zynqmp-pmu.rom",
@@ -166,24 +180,6 @@ static void xlnx_zynqmp_pmu_init(MachineState *machi=
ne)
                               &error_abort);
     object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal=
);
=20
-    for (i =3D 0; i < 32; i++) {
-        irq[i] =3D qdev_get_gpio_in(DEVICE(&pmu->intc), i);
-    }
-
-    /* Create and connect the IPI device */
-    for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
-        object_initialize(&pmu->ipi[i], sizeof(XlnxZynqMPIPI),
-                          TYPE_XLNX_ZYNQMP_IPI);
-        qdev_set_parent_bus(DEVICE(&pmu->ipi[i]), sysbus_get_default());
-    }
-
-    for (i =3D 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
-        object_property_set_bool(OBJECT(&pmu->ipi[i]), true, "realized",
-                                 &error_abort);
-        sysbus_mmio_map(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, ipi_addr[i]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(&pmu->ipi[i]), 0, irq[ipi_irq[=
i]]);
-    }
-
     /* Load the kernel */
     microblaze_load_kernel(&pmu->cpu, XLNX_ZYNQMP_PMU_RAM_ADDR,
                            machine->ram_size,
--=20
2.18.0.rc1.1.g3f1ff2140


