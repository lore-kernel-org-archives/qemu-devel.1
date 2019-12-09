Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1ADC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0669F20692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAN2KEtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0669F20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieEy7-0006z0-02
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieEwq-00063Z-BQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieEwn-0001In-RS
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:03:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieEwn-0001Ht-N3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575882197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z3pUryutP47DJBp6MpKLuTkGvVAsdwEI/VzhLyro1Js=;
 b=NAN2KEtdeQzMbD2QsQafykZP2tARuF/cPyEYZ9kNqyfVCL6nObHVLPpxl7uB19Q3c/Je0h
 i5l/6D4Tm4a/XDM/CEh3qnydatOEjb7TmNj0s81PKLHMIpnmgkiyy7ftaVK4F9SgYpYCAE
 bNf2QnZE4BKrOA4I529V1TtlFu5Lqog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-o89xQ_UbMGaL8URnCxKhCA-1; Mon, 09 Dec 2019 04:03:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B07E8DB65;
 Mon,  9 Dec 2019 09:03:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-142.brq.redhat.com [10.40.205.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 655B960BEC;
 Mon,  9 Dec 2019 09:03:09 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/virt: Simplify by moving the gic in the machine state
Date: Mon,  9 Dec 2019 10:03:06 +0100
Message-Id: <20191209090306.20433-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: o89xQ_UbMGaL8URnCxKhCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the gic a field in the machine state, and instead of filling
an array of qemu_irq and passing it around, directly call
qdev_get_gpio_in() on the gic field.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/arm/virt.h |   1 +
 hw/arm/virt.c         | 109 +++++++++++++++++++++---------------------
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 0b41083e9d..38f0c33c77 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -136,6 +136,7 @@ typedef struct {
     uint32_t iommu_phandle;
     int psci_conduit;
     hwaddr highest_gpa;
+    DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
 } VirtMachineState;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bedc2607..67d031c051 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -531,7 +531,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *v=
ms)
     }
 }
=20
-static inline DeviceState *create_acpi_ged(VirtMachineState *vms, qemu_irq=
 *pic)
+static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 {
     DeviceState *dev;
     MachineState *ms =3D MACHINE(vms);
@@ -547,14 +547,14 @@ static inline DeviceState *create_acpi_ged(VirtMachin=
eState *vms, qemu_irq *pic)
=20
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].bas=
e);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].=
base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, =
irq));
=20
     qdev_init_nofail(dev);
=20
     return dev;
 }
=20
-static void create_its(VirtMachineState *vms, DeviceState *gicdev)
+static void create_its(VirtMachineState *vms)
 {
     const char *itsclass =3D its_class_name();
     DeviceState *dev;
@@ -566,7 +566,7 @@ static void create_its(VirtMachineState *vms, DeviceSta=
te *gicdev)
=20
     dev =3D qdev_create(NULL, itsclass);
=20
-    object_property_set_link(OBJECT(dev), OBJECT(gicdev), "parent-gicv3",
+    object_property_set_link(OBJECT(dev), OBJECT(vms->gic), "parent-gicv3"=
,
                              &error_abort);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base=
);
@@ -574,7 +574,7 @@ static void create_its(VirtMachineState *vms, DeviceSta=
te *gicdev)
     fdt_add_its_gic_node(vms);
 }
=20
-static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
+static void create_v2m(VirtMachineState *vms)
 {
     int i;
     int irq =3D vms->irqmap[VIRT_GIC_V2M];
@@ -587,17 +587,17 @@ static void create_v2m(VirtMachineState *vms, qemu_ir=
q *pic)
     qdev_init_nofail(dev);
=20
     for (i =3D 0; i < NUM_GICV2M_SPIS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
     }
=20
     fdt_add_v2m_gic_node(vms);
 }
=20
-static void create_gic(VirtMachineState *vms, qemu_irq *pic)
+static void create_gic(VirtMachineState *vms)
 {
     MachineState *ms =3D MACHINE(vms);
     /* We create a standalone GIC */
-    DeviceState *gicdev;
     SysBusDevice *gicbusdev;
     const char *gictype;
     int type =3D vms->gic_version, i;
@@ -606,15 +606,15 @@ static void create_gic(VirtMachineState *vms, qemu_ir=
q *pic)
=20
     gictype =3D (type =3D=3D 3) ? gicv3_class_name() : gic_class_name();
=20
-    gicdev =3D qdev_create(NULL, gictype);
-    qdev_prop_set_uint32(gicdev, "revision", type);
-    qdev_prop_set_uint32(gicdev, "num-cpu", smp_cpus);
+    vms->gic =3D qdev_create(NULL, gictype);
+    qdev_prop_set_uint32(vms->gic, "revision", type);
+    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec=
).
      */
-    qdev_prop_set_uint32(gicdev, "num-irq", NUM_IRQS + 32);
+    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
     if (!kvm_irqchip_in_kernel()) {
-        qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
+        qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure=
);
     }
=20
     if (type =3D=3D 3) {
@@ -624,25 +624,25 @@ static void create_gic(VirtMachineState *vms, qemu_ir=
q *pic)
=20
         nb_redist_regions =3D virt_gicv3_redist_region_count(vms);
=20
-        qdev_prop_set_uint32(gicdev, "len-redist-region-count",
+        qdev_prop_set_uint32(vms->gic, "len-redist-region-count",
                              nb_redist_regions);
-        qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_cou=
nt);
+        qdev_prop_set_uint32(vms->gic, "redist-region-count[0]", redist0_c=
ount);
=20
         if (nb_redist_regions =3D=3D 2) {
             uint32_t redist1_capacity =3D
                     vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST=
_SIZE;
=20
-            qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
+            qdev_prop_set_uint32(vms->gic, "redist-region-count[1]",
                 MIN(smp_cpus - redist0_count, redist1_capacity));
         }
     } else {
         if (!kvm_irqchip_in_kernel()) {
-            qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
+            qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
                               vms->virt);
         }
     }
-    qdev_init_nofail(gicdev);
-    gicbusdev =3D SYS_BUS_DEVICE(gicdev);
+    qdev_init_nofail(vms->gic);
+    gicbusdev =3D SYS_BUS_DEVICE(vms->gic);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     if (type =3D=3D 3) {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
@@ -678,23 +678,23 @@ static void create_gic(VirtMachineState *vms, qemu_ir=
q *pic)
=20
         for (irq =3D 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
-                                  qdev_get_gpio_in(gicdev,
+                                  qdev_get_gpio_in(vms->gic,
                                                    ppibase + timer_irq[irq=
]));
         }
=20
         if (type =3D=3D 3) {
-            qemu_irq irq =3D qdev_get_gpio_in(gicdev,
+            qemu_irq irq =3D qdev_get_gpio_in(vms->gic,
                                             ppibase + ARCH_GIC_MAINT_IRQ);
             qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interru=
pt",
                                         0, irq);
         } else if (vms->virt) {
-            qemu_irq irq =3D qdev_get_gpio_in(gicdev,
+            qemu_irq irq =3D qdev_get_gpio_in(vms->gic,
                                             ppibase + ARCH_GIC_MAINT_IRQ);
             sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
         }
=20
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(gicdev, ppibase
+                                    qdev_get_gpio_in(vms->gic, ppibase
                                                      + VIRTUAL_PMU_IRQ));
=20
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_=
IRQ));
@@ -706,20 +706,16 @@ static void create_gic(VirtMachineState *vms, qemu_ir=
q *pic)
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
=20
-    for (i =3D 0; i < NUM_IRQS; i++) {
-        pic[i] =3D qdev_get_gpio_in(gicdev, i);
-    }
-
     fdt_add_gic_node(vms);
=20
     if (type =3D=3D 3 && vms->its) {
-        create_its(vms, gicdev);
+        create_its(vms);
     } else if (type =3D=3D 2) {
-        create_v2m(vms, pic);
+        create_v2m(vms);
     }
 }
=20
-static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int ua=
rt,
+static void create_uart(const VirtMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
     char *nodename;
@@ -735,7 +731,7 @@ static void create_uart(const VirtMachineState *vms, qe=
mu_irq *pic, int uart,
     qdev_init_nofail(dev);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
-    sysbus_connect_irq(s, 0, pic[irq]);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
=20
     nodename =3D g_strdup_printf("/pl011@%" PRIx64, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
@@ -767,7 +763,7 @@ static void create_uart(const VirtMachineState *vms, qe=
mu_irq *pic, int uart,
     g_free(nodename);
 }
=20
-static void create_rtc(const VirtMachineState *vms, qemu_irq *pic)
+static void create_rtc(const VirtMachineState *vms)
 {
     char *nodename;
     hwaddr base =3D vms->memmap[VIRT_RTC].base;
@@ -775,7 +771,7 @@ static void create_rtc(const VirtMachineState *vms, qem=
u_irq *pic)
     int irq =3D vms->irqmap[VIRT_RTC];
     const char compat[] =3D "arm,pl031\0arm,primecell";
=20
-    sysbus_create_simple("pl031", base, pic[irq]);
+    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
=20
     nodename =3D g_strdup_printf("/pl031@%" PRIx64, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
@@ -803,7 +799,7 @@ static void virt_powerdown_req(Notifier *n, void *opaqu=
e)
     }
 }
=20
-static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
+static void create_gpio(const VirtMachineState *vms)
 {
     char *nodename;
     DeviceState *pl061_dev;
@@ -812,7 +808,8 @@ static void create_gpio(const VirtMachineState *vms, qe=
mu_irq *pic)
     int irq =3D vms->irqmap[VIRT_GPIO];
     const char compat[] =3D "arm,pl061\0arm,primecell";
=20
-    pl061_dev =3D sysbus_create_simple("pl061", base, pic[irq]);
+    pl061_dev =3D sysbus_create_simple("pl061", base,
+                                     qdev_get_gpio_in(vms->gic, irq));
=20
     uint32_t phandle =3D qemu_fdt_alloc_phandle(vms->fdt);
     nodename =3D g_strdup_printf("/pl061@%" PRIx64, base);
@@ -846,7 +843,7 @@ static void create_gpio(const VirtMachineState *vms, qe=
mu_irq *pic)
     g_free(nodename);
 }
=20
-static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *p=
ic)
+static void create_virtio_devices(const VirtMachineState *vms)
 {
     int i;
     hwaddr size =3D vms->memmap[VIRT_MMIO].size;
@@ -882,7 +879,8 @@ static void create_virtio_devices(const VirtMachineStat=
e *vms, qemu_irq *pic)
         int irq =3D vms->irqmap[VIRT_MMIO] + i;
         hwaddr base =3D vms->memmap[VIRT_MMIO].base + i * size;
=20
-        sysbus_create_simple("virtio-mmio", base, pic[irq]);
+        sysbus_create_simple("virtio-mmio", base,
+                             qdev_get_gpio_in(vms->gic, irq));
     }
=20
     /* We add dtb nodes in reverse order so that they appear in the finish=
ed
@@ -1131,7 +1129,7 @@ static void create_pcie_irq_map(const VirtMachineStat=
e *vms,
                            0x7           /* PCI irq */);
 }
=20
-static void create_smmu(const VirtMachineState *vms, qemu_irq *pic,
+static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
     char *node;
@@ -1154,7 +1152,8 @@ static void create_smmu(const VirtMachineState *vms, =
qemu_irq *pic,
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i =3D 0; i < NUM_SMMU_IRQS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
     }
=20
     node =3D g_strdup_printf("/smmuv3@%" PRIx64, base);
@@ -1181,7 +1180,7 @@ static void create_smmu(const VirtMachineState *vms, =
qemu_irq *pic,
     g_free(node);
 }
=20
-static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
+static void create_pcie(VirtMachineState *vms)
 {
     hwaddr base_mmio =3D vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio =3D vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1241,7 +1240,8 @@ static void create_pcie(VirtMachineState *vms, qemu_i=
rq *pic)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
=20
     for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
=20
@@ -1301,7 +1301,7 @@ static void create_pcie(VirtMachineState *vms, qemu_i=
rq *pic)
     if (vms->iommu) {
         vms->iommu_phandle =3D qemu_fdt_alloc_phandle(vms->fdt);
=20
-        create_smmu(vms, pic, pci->bus);
+        create_smmu(vms, pci->bus);
=20
         qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
                                0x0, vms->iommu_phandle, 0x0, 0x10000);
@@ -1310,7 +1310,7 @@ static void create_pcie(VirtMachineState *vms, qemu_i=
rq *pic)
     g_free(nodename);
 }
=20
-static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
+static void create_platform_bus(VirtMachineState *vms)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -1326,8 +1326,8 @@ static void create_platform_bus(VirtMachineState *vms=
, qemu_irq *pic)
=20
     s =3D SYS_BUS_DEVICE(dev);
     for (i =3D 0; i < PLATFORM_BUS_NUM_IRQS; i++) {
-        int irqn =3D vms->irqmap[VIRT_PLATFORM_BUS] + i;
-        sysbus_connect_irq(s, i, pic[irqn]);
+        int irq =3D vms->irqmap[VIRT_PLATFORM_BUS] + i;
+        sysbus_connect_irq(s, i, qdev_get_gpio_in(vms->gic, irq));
     }
=20
     memory_region_add_subregion(sysmem,
@@ -1509,7 +1509,6 @@ static void machvirt_init(MachineState *machine)
     VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(machine);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus;
-    qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem =3D get_system_memory();
     MemoryRegion *secure_sysmem =3D NULL;
     int n, virt_max_cpus;
@@ -1712,27 +1711,27 @@ static void machvirt_init(MachineState *machine)
=20
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
=20
-    create_gic(vms, pic);
+    create_gic(vms);
=20
     fdt_add_pmu_nodes(vms);
=20
-    create_uart(vms, pic, VIRT_UART, sysmem, serial_hd(0));
+    create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
=20
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
-        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1=
));
+        create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
     }
=20
     vms->highmem_ecam &=3D vms->highmem && (!firmware_loaded || aarch64);
=20
-    create_rtc(vms, pic);
+    create_rtc(vms);
=20
-    create_pcie(vms, pic);
+    create_pcie(vms);
=20
     if (has_ged && aarch64 && firmware_loaded && acpi_enabled) {
-        vms->acpi_dev =3D create_acpi_ged(vms, pic);
+        vms->acpi_dev =3D create_acpi_ged(vms);
     } else {
-        create_gpio(vms, pic);
+        create_gpio(vms);
     }
=20
      /* connect powerdown request */
@@ -1743,12 +1742,12 @@ static void machvirt_init(MachineState *machine)
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
      */
-    create_virtio_devices(vms, pic);
+    create_virtio_devices(vms);
=20
     vms->fw_cfg =3D create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(vms->fw_cfg);
=20
-    create_platform_bus(vms, pic);
+    create_platform_bus(vms);
=20
     vms->bootinfo.ram_size =3D machine->ram_size;
     vms->bootinfo.nb_cpus =3D smp_cpus;
--=20
2.21.0


