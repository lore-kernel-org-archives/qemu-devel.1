Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92509C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BD720792
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BD720792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkE9Q-000127-49
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDyY-0007XF-IW; Sat, 13 Jun 2020 17:46:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3709 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDyW-0003SP-1z; Sat, 13 Jun 2020 17:46:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7C39C247F741223B5826;
 Sun, 14 Jun 2020 05:46:01 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:45:52 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 17/22] arm/cpuhp: Changes to (un)wire GICC<->VCPU IRQs
 during hot-(un)plug
Date: Sat, 13 Jun 2020 22:36:24 +0100
Message-ID: <20200613213629.21984-18-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, sudeep.holla@arm.com,
 gshan@redhat.com, mst@redhat.com, jiakernel2@gmail.com, maz@kernel.org,
 zhukeqian1@huawei.com, david@redhat.com, richard.henderson@linaro.org,
 linuxarm@huawei.com, eric.auger@redhat.com, james.morse@arm.com,
 catalin.marinas@arm.com, imammedo@redhat.com,
 Salil Mehta <salil.mehta@huawei.com>, pbonzini@redhat.com,
 mehta.salil.lnk@gmail.com, maran.wilson@oracle.com, will@kernel.org,
 wangxiongfeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Refactors the existing gic create code to extract common code to wire the
vcpu<->gic interrupts. This function could be used with cold-plug case and also
used when vcpu is hot-plugged. It also introduces a new function to unwire the
vcpu>->gic interrupts for the vcpu hot-unplug cases.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c          | 144 +++++++++++++++++++++++++++++------------
 hw/core/qdev.c         |   2 +-
 include/hw/qdev-core.h |   2 +
 3 files changed, 104 insertions(+), 44 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ac2941159a..f0295e940e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -615,6 +615,103 @@ static void create_v2m(VirtMachineState *vms)
     fdt_add_v2m_gic_node(vms);
 }
 
+static void unwire_gic_cpu_irqs(VirtMachineState *vms, CPUState *cs)
+{
+    unsigned int max_cpus = vms->max_cpus;
+    DeviceState *cpudev = DEVICE(cs);
+    DeviceState *gicdev = vms->gic;
+    int cpu = CPU(cs)->cpu_index;
+    int type = vms->gic_version;
+    int irq;
+
+    /* Mapping from the output timer irq lines from the CPU to the
+     * GIC PPI inputs we use for the virt board.
+     */
+    const int timer_irq[] = {
+        [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+        [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+        [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+        [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+    };
+
+    for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+        qdev_disconnect_gpio_out_named(cpudev, NULL, irq);
+    }
+
+    if (type == 3) {
+        qdev_disconnect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0);
+    } else if (vms->virt) {
+        qdev_disconnect_gpio_out_named(gicdev, SYSBUS_DEVICE_GPIO_IRQ, cpu + 4 * max_cpus);
+    }
+
+    /*
+     * RFC: Question: This currently does not takes care of intimating the devices
+     * which might be sitting on system bus. Do we need a sysbus_disconnect_irq()
+     * which also does the job of notification beside disconnection?
+     */
+    qdev_disconnect_gpio_out_named(cpudev, "pmu-interrupt", 0);
+    qdev_disconnect_gpio_out_named(gicdev, SYSBUS_DEVICE_GPIO_IRQ, cpu);
+    qdev_disconnect_gpio_out_named(gicdev,
+                                   SYSBUS_DEVICE_GPIO_IRQ, cpu + max_cpus);
+    qdev_disconnect_gpio_out_named(gicdev, SYSBUS_DEVICE_GPIO_IRQ,
+                                   cpu + 2 * max_cpus);
+    qdev_disconnect_gpio_out_named(gicdev, SYSBUS_DEVICE_GPIO_IRQ,
+                                   cpu + 3 * max_cpus);
+}
+
+static void wire_gic_cpu_irqs(VirtMachineState *vms, CPUState *cs)
+{
+    unsigned int max_cpus = vms->max_cpus;
+    DeviceState *cpudev = DEVICE(cs);
+    DeviceState *gicdev = vms->gic;
+    int cpu = CPU(cs)->cpu_index;
+    int type = vms->gic_version;
+    SysBusDevice *gicbusdev;
+    int ppibase;
+    int irq;
+
+    ppibase = NUM_IRQS + cpu * GIC_INTERNAL + GIC_NR_SGIS;
+
+    /* Mapping from the output timer irq lines from the CPU to the
+     * GIC PPI inputs we use for the virt board.
+     */
+    const int timer_irq[] = {
+        [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+        [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+        [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+        [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+    };
+
+    for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+        qdev_connect_gpio_out(cpudev, irq,
+                              qdev_get_gpio_in(gicdev,
+                                               ppibase + timer_irq[irq]));
+    }
+
+    gicbusdev = SYS_BUS_DEVICE(gicdev);
+    if (type == 3) {
+        qemu_irq irq = qdev_get_gpio_in(gicdev,
+                                        ppibase + ARCH_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                    0, irq);
+    } else if (vms->virt) {
+        qemu_irq irq = qdev_get_gpio_in(gicdev,
+                                        ppibase + ARCH_GIC_MAINT_IRQ);
+        sysbus_connect_irq(gicbusdev, cpu + 4 * max_cpus, irq);
+    }
+
+    qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                qdev_get_gpio_in(gicdev,
+                                                 ppibase + VIRTUAL_PMU_IRQ));
+    sysbus_connect_irq(gicbusdev, cpu, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+    sysbus_connect_irq(gicbusdev, cpu + max_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+    sysbus_connect_irq(gicbusdev, cpu + 2 * max_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+    sysbus_connect_irq(gicbusdev, cpu + 3 * max_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+}
+
 static void create_gic(VirtMachineState *vms)
 {
     /* We create a standalone GIC */
@@ -684,47 +781,7 @@ static void create_gic(VirtMachineState *vms)
      * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
      */
     for (i = 0; i < smp_cpus; i++) {
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
-                                  qdev_get_gpio_in(vms->gic,
-                                                   ppibase + timer_irq[irq]));
-        }
-
-        if (type == 3) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
-            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
-                                        0, irq);
-        } else if (vms->virt) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * max_cpus, irq);
-        }
-
-        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(vms->gic, ppibase
-                                                     + VIRTUAL_PMU_IRQ));
-
-        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + max_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * max_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * max_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+        wire_gic_cpu_irqs(vms, qemu_get_cpu(i));
     }
 
     fdt_add_gic_node(vms);
@@ -2382,6 +2439,7 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                           Error **errp)
 {
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(hotplug_dev);
     ARMCPU *cpu = ARM_CPU(dev);
     CPUState *cs = CPU(dev);
@@ -2392,7 +2450,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     cpu_slot->cpu = OBJECT(dev);
 
     if (dev->hotplugged) {
-        /* TODO: wire the gic-cpu irqs */
+        wire_gic_cpu_irqs(vms, cs);
         /* TODO: update acpi hotplug state and send cpu hotplug event to guest */
         /* TODO: register this cpu for reset & update F/W info for the next boot */
     }
@@ -2447,7 +2505,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     /* TODO: update the acpi cpu hotplug state for cpu hot-unplug */
 
-    /* TODO: unwire the gic-cpu irqs here */
+    unwire_gic_cpu_irqs(vms, cs);
     /* TODO: update the GIC about this hot unplug change */
 
     /* TODO: unregister this cpu for reset & update F/W info for the next boot */
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9e5538aeae..65b3ec7c8f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -563,7 +563,7 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
 
 /* disconnect a GPIO output, returning the disconnected input (if any) */
 
-static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
+qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
                                                const char *name, int n)
 {
     char *propname = g_strdup_printf("%s[%d]",
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b870b27966..8434cc5a3e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -355,6 +355,8 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
 qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n);
 qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
                                  const char *name, int n);
+qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
+                                               const char *name, int n);
 
 BusState *qdev_get_child_bus(DeviceState *dev, const char *name);
 
-- 
2.17.1



