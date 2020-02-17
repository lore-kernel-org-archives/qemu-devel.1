Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B23DC7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E624520702
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E624520702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3b3t-00063L-Vi
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 02:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2w-0004IP-Lv
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xuyandong2@huawei.com>) id 1j3b2u-0000Us-Fl
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 02:42:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36468 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
 id 1j3b2q-0000JC-FD; Mon, 17 Feb 2020 02:42:21 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 01E78AE914653679CE4E;
 Mon, 17 Feb 2020 15:42:14 +0800 (CST)
Received: from localhost (10.175.124.177) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 15:42:07 +0800
From: Xu Yandong <xuyandong2@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [PATCH RFC 07/16] hw/arm/virt: split virt extension related codes
 from create_gic
Date: Mon, 17 Feb 2020 02:51:19 -0500
Message-ID: <1581925888-103620-8-git-send-email-xuyandong2@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
References: <1581925888-103620-1-git-send-email-xuyandong2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.177]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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

EL2 extension is not always needed.

Signed-off-by: Xu Yandong <xuyandong2@huawei.com>
---
 hw/arm/virt.c | 116 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 39 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 32c3977e32..afaf143888 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -426,6 +426,45 @@ static void fdt_add_v2m_gic_node(VirtMachineState *vms)
     g_free(nodename);
 }
 
+static void fdt_gic_set_virt_extension(VirtMachineState *vms)
+{
+    char *nodename;
+    ArmMachineState *ams = ARM_MACHINE(vms);
+
+    nodename = g_strdup_printf("/intc@%" PRIx64,
+                               ams->memmap[VIRT_GIC_DIST].base);
+
+
+    if (vms->gic_version == 3) {
+        if (vms->virt) {
+            qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
+                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
+                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        }
+    } else {
+        if (!vms->virt) {
+            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
+                                         2, ams->memmap[VIRT_GIC_DIST].base,
+                                         2, ams->memmap[VIRT_GIC_DIST].size,
+                                         2, ams->memmap[VIRT_GIC_CPU].base,
+                                         2, ams->memmap[VIRT_GIC_CPU].size);
+        } else {
+            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
+                                         2, ams->memmap[VIRT_GIC_DIST].base,
+                                         2, ams->memmap[VIRT_GIC_DIST].size,
+                                         2, ams->memmap[VIRT_GIC_CPU].base,
+                                         2, ams->memmap[VIRT_GIC_CPU].size,
+                                         2, ams->memmap[VIRT_GIC_HYP].base,
+                                         2, ams->memmap[VIRT_GIC_HYP].size,
+                                         2, ams->memmap[VIRT_GIC_VCPU].base,
+                                         2, ams->memmap[VIRT_GIC_VCPU].size);
+            qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
+                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
+                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        }
+    }
+}
+
 static void fdt_add_gic_node(VirtMachineState *vms)
 {
     char *nodename;
@@ -466,36 +505,10 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                  2, ams->memmap[VIRT_HIGH_GIC_REDIST2].base,
                                  2, ams->memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
-
-        if (vms->virt) {
-            qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
-                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
-                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        }
     } else {
         /* 'cortex-a15-gic' means 'GIC v2' */
         qemu_fdt_setprop_string(ams->fdt, nodename, "compatible",
                                 "arm,cortex-a15-gic");
-        if (!vms->virt) {
-            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                         2, ams->memmap[VIRT_GIC_DIST].base,
-                                         2, ams->memmap[VIRT_GIC_DIST].size,
-                                         2, ams->memmap[VIRT_GIC_CPU].base,
-                                         2, ams->memmap[VIRT_GIC_CPU].size);
-        } else {
-            qemu_fdt_setprop_sized_cells(ams->fdt, nodename, "reg",
-                                         2, ams->memmap[VIRT_GIC_DIST].base,
-                                         2, ams->memmap[VIRT_GIC_DIST].size,
-                                         2, ams->memmap[VIRT_GIC_CPU].base,
-                                         2, ams->memmap[VIRT_GIC_CPU].size,
-                                         2, ams->memmap[VIRT_GIC_HYP].base,
-                                         2, ams->memmap[VIRT_GIC_HYP].size,
-                                         2, ams->memmap[VIRT_GIC_VCPU].base,
-                                         2, ams->memmap[VIRT_GIC_VCPU].size);
-            qemu_fdt_setprop_cells(ams->fdt, nodename, "interrupts",
-                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
-                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        }
     }
 
     qemu_fdt_setprop_cell(ams->fdt, nodename, "phandle", vms->gic_phandle);
@@ -614,6 +627,40 @@ static void gic_set_msi_interrupt(VirtMachineState *vms)
     }
 }
 
+static void qdev_gic_set_virt_bit(VirtMachineState *vms)
+{
+    if (vms->gic_version != 3 && !kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
+                          vms->virt);
+    }
+}
+
+static void set_gic_virt_sysbus(VirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    ArmMachineState *ams = ARM_MACHINE(vms);
+    SysBusDevice *gicbusdev;
+    int type = vms->gic_version, i;
+    unsigned int smp_cpus = ms->smp.cpus;
+
+    if (!vms->virt) {
+        return;
+    }
+
+    gicbusdev = SYS_BUS_DEVICE(vms->gic);
+    if (type != 3) {
+        sysbus_mmio_map(gicbusdev, 2, ams->memmap[VIRT_GIC_HYP].base);
+        sysbus_mmio_map(gicbusdev, 3, ams->memmap[VIRT_GIC_VCPU].base);
+    }
+
+    for (i = 0; i < smp_cpus; i++) {
+        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        qemu_irq irq = qdev_get_gpio_in(vms->gic,
+                                        ppibase + ARCH_GIC_MAINT_IRQ);
+        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+    }
+}
+
 static void create_gic(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
@@ -656,12 +703,8 @@ static void create_gic(VirtMachineState *vms)
             qdev_prop_set_uint32(vms->gic, "redist-region-count[1]",
                 MIN(smp_cpus - redist0_count, redist1_capacity));
         }
-    } else {
-        if (!kvm_irqchip_in_kernel()) {
-            qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
-                              vms->virt);
-        }
     }
+    qdev_gic_set_virt_bit(vms);
     qdev_init_nofail(vms->gic);
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
     sysbus_mmio_map(gicbusdev, 0, ams->memmap[VIRT_GIC_DIST].base);
@@ -673,10 +716,6 @@ static void create_gic(VirtMachineState *vms)
         }
     } else {
         sysbus_mmio_map(gicbusdev, 1, ams->memmap[VIRT_GIC_CPU].base);
-        if (vms->virt) {
-            sysbus_mmio_map(gicbusdev, 2, ams->memmap[VIRT_GIC_HYP].base);
-            sysbus_mmio_map(gicbusdev, 3, ams->memmap[VIRT_GIC_VCPU].base);
-        }
     }
 
     /* Wire the outputs from each CPU's generic timer and the GICv3
@@ -708,10 +747,6 @@ static void create_gic(VirtMachineState *vms)
                                             ppibase + ARCH_GIC_MAINT_IRQ);
             qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
                                         0, irq);
-        } else if (vms->virt) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            ppibase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
@@ -727,7 +762,10 @@ static void create_gic(VirtMachineState *vms)
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 
+    set_gic_virt_sysbus(vms);
     fdt_add_gic_node(vms);
+    fdt_gic_set_virt_extension(vms);
+
     gic_set_msi_interrupt(vms);
 }
 
-- 
2.18.1


