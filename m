Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372EDC35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E453206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E453206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b5J-00016j-68
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b31-0004PE-2b
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2z-0000cK-5R
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3230 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2t-0000RO-LK; Mon, 17 Feb 2020 02:42:24 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CEE603A42C8FA0934C31;
 Mon, 17 Feb 2020 15:42:19 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:09 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 10/16] hw/arm: split create_gic function
Date: Mon, 17 Feb 2020 02:51:22 -0500
Message-ID: <1581925888-103620-11-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: zhang.zhanghailiang@huawei.com, slp@redhat.com,
 Xu Yandong <xuyandong2@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split sharable GIC qdev create and sysbus initiatea codes as independent function.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/arm.c         | 106 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c        |  93 +------------------------------------
 include/hw/arm/arm.h |   4 ++
 3 files changed, 112 insertions(+), 91 deletions(-)

diff --git a/hw/arm/arm.c b/hw/arm/arm.c
index ecb99611ed..c51bf513d2 100644
--- a/hw/arm/arm.c
+++ b/hw/arm/arm.c
@@ -39,6 +39,112 @@
 #include "hw/intc/arm_gic.h"
 #include "kvm_arm.h"
 
+void qdev_create_gic(ArmMachineState *ams)
+{
+    MachineState *ms = MACHINE(ams);
+    /* We create a standalone GIC */
+    const char *gictype;
+    int type = ams->gic_version;
+    unsigned int smp_cpus = ms->smp.cpus;
+    uint32_t nb_redist_regions = 0;
+
+    gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
+
+    ams->gic = qdev_create(NULL, gictype);
+    qdev_prop_set_uint32(ams->gic, "revision", type);
+    qdev_prop_set_uint32(ams->gic, "num-cpu", smp_cpus);
+    /* Note that the num-irq property counts both internal and external
+     * interrupts; there are always 32 of the former (mandated by GIC spec).
+     */
+    qdev_prop_set_uint32(ams->gic, "num-irq", NUM_IRQS + 32);
+
+    if (type == 3) {
+        uint32_t redist0_capacity =
+                    ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
+        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
+
+        nb_redist_regions = virt_gicv3_redist_region_count(ams);
+
+        qdev_prop_set_uint32(ams->gic, "len-redist-region-count",
+                             nb_redist_regions);
+        qdev_prop_set_uint32(ams->gic, "redist-region-count[0]", redist0_count);
+
+        if (nb_redist_regions == 2) {
+            uint32_t redist1_capacity =
+                    ams->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
+
+            qdev_prop_set_uint32(ams->gic, "redist-region-count[1]",
+                MIN(smp_cpus - redist0_count, redist1_capacity));
+        }
+    }
+}
+
+void init_gic_sysbus(ArmMachineState *ams)
+{
+    MachineState *ms = MACHINE(ams);
+    /* We create a standalone GIC */
+    SysBusDevice *gicbusdev;
+    int type = ams->gic_version, i;
+    unsigned int smp_cpus = ms->smp.cpus;
+    uint32_t nb_redist_regions = 0;
+
+    gicbusdev = SYS_BUS_DEVICE(ams->gic);
+    sysbus_mmio_map(gicbusdev, 0, ams->memmap[VIRT_GIC_DIST].base);
+    if (type == 3) {
+        sysbus_mmio_map(gicbusdev, 1, ams->memmap[VIRT_GIC_REDIST].base);
+        if (nb_redist_regions == 2) {
+            sysbus_mmio_map(gicbusdev, 2,
+                            ams->memmap[VIRT_HIGH_GIC_REDIST2].base);
+        }
+    } else {
+        sysbus_mmio_map(gicbusdev, 1, ams->memmap[VIRT_GIC_CPU].base);
+    }
+
+    /* Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
+     */
+    for (i = 0; i < smp_cpus; i++) {
+        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
+        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int irq;
+        /* Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs we use for the virt board.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+        };
+
+        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(ams->gic,
+                                                   ppibase + timer_irq[irq]));
+        }
+
+        if (type == 3) {
+            qemu_irq irq = qdev_get_gpio_in(ams->gic,
+                                            ppibase + ARCH_GIC_MAINT_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+        }
+
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                    qdev_get_gpio_in(ams->gic, ppibase
+                                                     + VIRTUAL_PMU_IRQ));
+
+        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicbusdev, i + smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+}
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     ArmMachineState *ams = ARM_MACHINE(obj);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b9689b0f0c..f971f49bcf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -672,103 +672,14 @@ static void set_gic_virt_sysbus(VirtMachineState *vms)
 
 static void create_gic(VirtMachineState *vms)
 {
-    MachineState *ms = MACHINE(vms);
     ArmMachineState *ams = ARM_MACHINE(vms);
-    /* We create a standalone GIC */
-    SysBusDevice *gicbusdev;
-    const char *gictype;
-    int type = ams->gic_version, i;
-    unsigned int smp_cpus = ms->smp.cpus;
-    uint32_t nb_redist_regions = 0;
-
-    gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
-
-    ams->gic = qdev_create(NULL, gictype);
-    qdev_prop_set_uint32(ams->gic, "revision", type);
-    qdev_prop_set_uint32(ams->gic, "num-cpu", smp_cpus);
-    /* Note that the num-irq property counts both internal and external
-     * interrupts; there are always 32 of the former (mandated by GIC spec).
-     */
-    qdev_prop_set_uint32(ams->gic, "num-irq", NUM_IRQS + 32);
 
-    if (type == 3) {
-        uint32_t redist0_capacity =
-                    ams->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
-        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
-
-        nb_redist_regions = virt_gicv3_redist_region_count(ams);
-
-        qdev_prop_set_uint32(ams->gic, "len-redist-region-count",
-                             nb_redist_regions);
-        qdev_prop_set_uint32(ams->gic, "redist-region-count[0]", redist0_count);
-
-        if (nb_redist_regions == 2) {
-            uint32_t redist1_capacity =
-                    ams->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
-
-            qdev_prop_set_uint32(ams->gic, "redist-region-count[1]",
-                MIN(smp_cpus - redist0_count, redist1_capacity));
-        }
-    }
+    qdev_create_gic(ams);
     qdev_gic_set_secure_bit(vms);
     qdev_gic_set_virt_bit(vms);
     qdev_init_nofail(ams->gic);
-    gicbusdev = SYS_BUS_DEVICE(ams->gic);
-    sysbus_mmio_map(gicbusdev, 0, ams->memmap[VIRT_GIC_DIST].base);
-    if (type == 3) {
-        sysbus_mmio_map(gicbusdev, 1, ams->memmap[VIRT_GIC_REDIST].base);
-        if (nb_redist_regions == 2) {
-            sysbus_mmio_map(gicbusdev, 2,
-                            ams->memmap[VIRT_HIGH_GIC_REDIST2].base);
-        }
-    } else {
-        sysbus_mmio_map(gicbusdev, 1, ams->memmap[VIRT_GIC_CPU].base);
-    }
-
-    /* Wire the outputs from each CPU's generic timer and the GICv3
-     * maintenance interrupt signal to the appropriate GIC PPI inputs,
-     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
-     */
-    for (i = 0; i < smp_cpus; i++) {
-        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
-        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
-        int irq;
-        /* Mapping from the output timer irq lines from the CPU to the
-         * GIC PPI inputs we use for the virt board.
-         */
-        const int timer_irq[] = {
-            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
-            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
-            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
-            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
-        };
-
-        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-            qdev_connect_gpio_out(cpudev, irq,
-                                  qdev_get_gpio_in(ams->gic,
-                                                   ppibase + timer_irq[irq]));
-        }
-
-        if (type == 3) {
-            qemu_irq irq = qdev_get_gpio_in(ams->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
-            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
-                                        0, irq);
-        }
-
-        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(ams->gic, ppibase
-                                                     + VIRTUAL_PMU_IRQ));
-
-        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
-    }
 
+    init_gic_sysbus(ams);
     set_gic_virt_sysbus(vms);
     fdt_add_gic_node(vms);
     fdt_gic_set_virt_extension(vms);
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index f8bde03cc3..9ba51c4882 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -108,6 +108,10 @@ typedef struct {
 #define ARM_MACHINE_CLASS(klass) \
     OBJECT_CLASS_CHECK(ArmMachineClass, klass, TYPE_ARM_MACHINE)
 
+void qdev_create_gic(ArmMachineState *ams);
+
+void init_gic_sysbus(ArmMachineState *ams);
+
 /* Return the number of used redistributor regions  */
 static inline int virt_gicv3_redist_region_count(ArmMachineState *ams)
 {
-- 
2.18.1


