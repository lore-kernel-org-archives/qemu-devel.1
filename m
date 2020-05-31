Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891FC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E745B20723
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E745B20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfQr8-00052F-59
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1jfQlM-0004E4-P4
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:40 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:58732)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jfQlJ-0004K5-V1
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:40 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id 17590EB8BA;
 Mon,  1 Jun 2020 01:24:34 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id A25511C0DB3;
 Mon,  1 Jun 2020 01:24:33 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] hw/rx: RX MCU and target
Date: Mon,  1 Jun 2020 01:24:22 +0900
Message-Id: <20200531162427.57410-6-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200531162427.57410-1-ysato@users.sourceforge.jp>
References: <20200531162427.57410-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.14;
 envelope-from=ysato@users.sourceforge.jp; helo=mail02.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:24:33
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

rx62n - RX62N MCU.
rx-virt - RX QEMU virtual target.
 This has the same specifications as the gdb simulator.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/rx/rx.h    |   7 ++
 include/hw/rx/rx62n.h |  91 ++++++++++++++++
 hw/rx/rx-virt.c       | 143 +++++++++++++++++++++++++
 hw/rx/rx62n.c         | 240 ++++++++++++++++++++++++++++++++++++++++++
 hw/rx/Kconfig         |  13 +++
 hw/rx/Makefile.objs   |   2 +
 6 files changed, 496 insertions(+)
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 hw/rx/rx-virt.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs

diff --git a/include/hw/rx/rx.h b/include/hw/rx/rx.h
new file mode 100644
index 0000000000..ff5924b81f
--- /dev/null
+++ b/include/hw/rx/rx.h
@@ -0,0 +1,7 @@
+#ifndef QEMU_RX_H
+#define QEMU_RX_H
+/* Definitions for RX board emulation.  */
+
+#include "target/rx/cpu-qom.h"
+
+#endif
diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
new file mode 100644
index 0000000000..11176eadf3
--- /dev/null
+++ b/include/hw/rx/rx62n.h
@@ -0,0 +1,91 @@
+/*
+ * RX62N MCU Object
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ * (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_RX_RX62N_H
+#define HW_RX_RX62N_H
+
+#include "hw/sysbus.h"
+#include "hw/intc/rx_icu.h"
+#include "hw/timer/renesas_8timer.h"
+#include "hw/timer/renesas_timer.h"
+#include "hw/char/renesas_sci.h"
+#include "target/rx/cpu.h"
+#include "qemu/units.h"
+
+#define TYPE_RX62N "rx62n"
+#define RX62N(obj) OBJECT_CHECK(RX62NState, (obj), TYPE_RX62N)
+
+#define RX62N_NR_TMR    2
+#define RX62N_NR_CMT    2
+#define RX62N_NR_SCI    6
+
+typedef struct RX62NState {
+    SysBusDevice parent_obj;
+
+    RXCPU cpu;
+    RXICUState icu;
+    RTMRState tmr[RX62N_NR_TMR];
+    RTIMERState cmt[RX62N_NR_CMT];
+    RSCIState sci[RX62N_NR_SCI];
+
+    MemoryRegion *sysmem;
+    bool kernel;
+
+    MemoryRegion iram;
+    MemoryRegion iomem1;
+    MemoryRegion d_flash;
+    MemoryRegion iomem2;
+    MemoryRegion iomem3;
+    MemoryRegion c_flash;
+    qemu_irq irq[NR_IRQS];
+} RX62NState;
+
+/*
+ * RX62N Peripheral Address
+ * See users manual section 5
+ */
+#define RX62N_ICUBASE 0x00087000
+#define RX62N_TMRBASE 0x00088200
+#define RX62N_CMTBASE 0x00088000
+#define RX62N_SCIBASE 0x00088240
+
+/*
+ * RX62N Peripheral IRQ
+ * See users manual section 11
+ */
+#define RX62N_TMR_IRQBASE 174
+#define RX62N_CMT_IRQBASE 28
+#define RX62N_SCI_IRQBASE 214
+
+/*
+ * RX62N Internal Memory
+ * It is the value of R5F562N8.
+ * Please change the size for R5F562N7.
+ */
+#define RX62N_IRAM_BASE 0x00000000
+#define RX62N_IRAM_SIZE (96 * KiB)
+#define RX62N_DFLASH_BASE 0x00100000
+#define RX62N_DFLASH_SIZE (32 * KiB)
+#define RX62N_CFLASH_BASE 0xfff80000
+#define RX62N_CFLASH_SIZE (512 * KiB)
+
+#define RX62N_PCLK (48 * 1000 * 1000)
+#endif
diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
new file mode 100644
index 0000000000..3168a85b83
--- /dev/null
+++ b/hw/rx/rx-virt.c
@@ -0,0 +1,143 @@
+/*
+ * RX QEMU virtual platform
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/loader.h"
+#include "hw/rx/rx62n.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "sysemu/device_tree.h"
+#include "hw/boards.h"
+
+/* Same address of GDB integrated simulator */
+#define SDRAM_BASE 0x01000000
+
+static void rx_load_image(RXCPU *cpu, const char *filename,
+                          uint32_t start, uint32_t size)
+{
+    static uint32_t extable[32];
+    long kernel_size;
+    int i;
+
+    kernel_size = load_image_targphys(filename, start, size);
+    if (kernel_size < 0) {
+        fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
+        exit(1);
+    }
+    cpu->env.pc = start;
+
+    /* setup exception trap trampoline */
+    /* linux kernel only works little-endian mode */
+    for (i = 0; i < ARRAY_SIZE(extable); i++) {
+        extable[i] = cpu_to_le32(0x10 + i * 4);
+    }
+    rom_add_blob_fixed("extable", extable, sizeof(extable), 0xffffff80);
+}
+
+static void rxvirt_init(MachineState *machine)
+{
+    RX62NState *s = g_new(RX62NState, 1);
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *sdram = g_new(MemoryRegion, 1);
+    const char *kernel_filename = machine->kernel_filename;
+    const char *dtb_filename = machine->dtb;
+    void *dtb = NULL;
+    int dtb_size;
+    ram_addr_t kernel_offset;
+    ram_addr_t dtb_offset;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    if (machine->ram_size < mc->default_ram_size) {
+        error_report("Invalid RAM size, should be more than %" PRIi64 " Bytes",
+                     mc->default_ram_size);
+    }
+
+    /* Allocate memory space */
+    memory_region_init_ram(sdram, NULL, "rx-virt.sdram", machine->ram_size,
+                           &error_fatal);
+    memory_region_add_subregion(sysmem, SDRAM_BASE, sdram);
+
+    /* Initialize MCU */
+    object_initialize_child(OBJECT(machine), "mcu", s,
+                            sizeof(RX62NState), TYPE_RX62N,
+                            &error_fatal, NULL);
+    object_property_set_link(OBJECT(s), OBJECT(sysmem),
+                             "memory", &error_abort);
+    object_property_set_bool(OBJECT(s), kernel_filename != NULL,
+                             "load-kernel", &error_abort);
+    object_property_set_bool(OBJECT(s), true, "realized", &error_abort);
+
+    /* Load kernel and dtb */
+    if (kernel_filename) {
+        /*
+         * The kernel image is loaded into
+         * the latter half of the SDRAM space.
+         */
+        kernel_offset = machine->ram_size / 2;
+        rx_load_image(RXCPU(first_cpu), kernel_filename,
+                      SDRAM_BASE + kernel_offset, kernel_offset);
+        if (dtb_filename) {
+            dtb = load_device_tree(dtb_filename, &dtb_size);
+            if (dtb == NULL) {
+                error_report("Couldn't open dtb file %s", dtb_filename);
+                exit(1);
+            }
+            if (machine->kernel_cmdline &&
+                qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
+                                        machine->kernel_cmdline) < 0) {
+                error_report("Couldn't set /chosen/bootargs");
+                exit(1);
+            }
+            /* DTB is located at the end of SDRAM space. */
+            dtb_offset = machine->ram_size - dtb_size;
+            rom_add_blob_fixed("dtb", dtb, dtb_size,
+                               SDRAM_BASE + dtb_offset);
+            /* Set dtb address to R1 */
+            RXCPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
+        }
+    }
+}
+
+static void rxvirt_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RX QEMU Virtual Target";
+    mc->init = rxvirt_init;
+    mc->is_default = 1;
+    mc->default_cpu_type = TYPE_RX62N_CPU;
+    mc->default_ram_size = 16 * MiB;
+}
+
+static const TypeInfo rxvirt_type = {
+    .name = MACHINE_TYPE_NAME("rx-virt"),
+    .parent = TYPE_MACHINE,
+    .class_init = rxvirt_class_init,
+};
+
+static void rxvirt_machine_init(void)
+{
+    type_register_static(&rxvirt_type);
+}
+
+type_init(rxvirt_machine_init)
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
new file mode 100644
index 0000000000..effd6d4f12
--- /dev/null
+++ b/hw/rx/rx62n.c
@@ -0,0 +1,240 @@
+/*
+ * RX62N Microcontroller
+ *
+ * Datasheet: RX62N Group, RX621 Group User's Manual: Hardware
+ * (Rev.1.40 R01UH0033EJ0140)
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/rx/rx62n.h"
+#include "hw/loader.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
+#include "sysemu/sysemu.h"
+#include "cpu.h"
+
+/*
+ * IRQ -> IPR mapping table
+ * 0x00 - 0x91: IPR no (IPR00 to IPR91)
+ * 0xff: IPR not assigned
+ * See "11.3.1 Interrupt Vector Table" in hardware manual.
+ */
+static const int ipr_table[NR_IRQS] = {
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 15 */
+    0x00, 0xff, 0xff, 0xff, 0xff, 0x01, 0xff, 0x02,
+    0xff, 0xff, 0xff, 0x03, 0x04, 0x05, 0x06, 0x07, /* 31 */
+    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+    0x10, 0x11, 0x12, 0x13, 0x14, 0x14, 0x14, 0x14, /* 47 */
+    0x15, 0x15, 0x15, 0x15, 0xff, 0xff, 0xff, 0xff,
+    0x18, 0x18, 0x18, 0x18, 0x18, 0x1d, 0x1e, 0x1f, /* 63 */
+    0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+    0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, /* 79 */
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0x3a, 0x3b, 0x3c, 0xff, 0xff, 0xff, /* 95 */
+    0x40, 0xff, 0x44, 0x45, 0xff, 0xff, 0x48, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 111 */
+    0xff, 0xff, 0x51, 0x51, 0x51, 0x51, 0x52, 0x52,
+    0x52, 0x53, 0x53, 0x54, 0x54, 0x55, 0x55, 0x56, /* 127 */
+    0x56, 0x57, 0x57, 0x57, 0x57, 0x58, 0x59, 0x59,
+    0x59, 0x59, 0x5a, 0x5b, 0x5b, 0x5b, 0x5c, 0x5c, /* 143 */
+    0x5c, 0x5c, 0x5d, 0x5d, 0x5d, 0x5e, 0x5e, 0x5f,
+    0x5f, 0x60, 0x60, 0x61, 0x61, 0x62, 0x62, 0x62, /* 159 */
+    0x62, 0x63, 0x64, 0x64, 0x64, 0x64, 0x65, 0x66,
+    0x66, 0x66, 0x67, 0x67, 0x67, 0x67, 0x68, 0x68, /* 175 */
+    0x68, 0x69, 0x69, 0x69, 0x6a, 0x6a, 0x6a, 0x6b,
+    0x6b, 0x6b, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 191 */
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x70, 0x71,
+    0x72, 0x73, 0x74, 0x75, 0xff, 0xff, 0xff, 0xff, /* 207 */
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x80, 0x80,
+    0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x82, 0x82, /* 223 */
+    0x82, 0x82, 0x83, 0x83, 0x83, 0x83, 0xff, 0xff,
+    0xff, 0xff, 0x85, 0x85, 0x85, 0x85, 0x86, 0x86, /* 239 */
+    0x86, 0x86, 0xff, 0xff, 0xff, 0xff, 0x88, 0x89,
+    0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, /* 255 */
+};
+
+/*
+ * Level triggerd IRQ list
+ * Not listed IRQ is Edge trigger.
+ * See "11.3.1 Interrupt Vector Table" in hardware manual.
+ */
+static const uint32_t levelirq[] = {
+     16,  21,  32,  44,  47,  48,  51,  64,  65,  66,
+     67,  68,  69,  70,  71,  72,  73,  74,  75,  76,
+     77,  78,  79,  90,  91, 170, 171, 172, 173, 214,
+    217, 218, 221, 222, 225, 226, 229, 234, 237, 238,
+    241, 246, 249, 250, 253,
+};
+
+static void register_icu(RX62NState *s)
+{
+    int i;
+    SysBusDevice *icu;
+
+    object_initialize_child(OBJECT(s), "icu", &s->icu, sizeof(RXICUState),
+                            TYPE_RXICU, &error_abort, NULL);
+
+    icu = SYS_BUS_DEVICE(&s->icu);
+    sysbus_mmio_map(SYS_BUS_DEVICE(icu), 0, RX62N_ICUBASE);
+    qdev_prop_set_uint32(DEVICE(icu), "len-ipr-map", NR_IRQS);
+    for (i = 0; i < NR_IRQS; i++) {
+        char propname[32];
+        snprintf(propname, sizeof(propname), "ipr-map[%d]", i);
+        qdev_prop_set_uint32(DEVICE(icu), propname, ipr_table[i]);
+    }
+    qdev_prop_set_uint32(DEVICE(icu), "len-trigger-level",
+                         ARRAY_SIZE(levelirq));
+    for (i = 0; i < ARRAY_SIZE(levelirq); i++) {
+        char propname[32];
+        snprintf(propname, sizeof(propname), "trigger-level[%d]", i);
+        qdev_prop_set_uint32(DEVICE(icu), propname, levelirq[i]);
+    }
+
+    for (i = 0; i < NR_IRQS; i++) {
+        s->irq[i] = qdev_get_gpio_in(DEVICE(icu), i);
+    }
+
+    qdev_init_nofail(DEVICE(icu));
+    sysbus_connect_irq(icu, 0, qdev_get_gpio_in(DEVICE(&s->cpu), RX_CPU_IRQ));
+    sysbus_connect_irq(icu, 1, qdev_get_gpio_in(DEVICE(&s->cpu), RX_CPU_FIR));
+    sysbus_connect_irq(icu, 2, s->irq[SWI]);
+
+}
+
+static void register_tmr(RX62NState *s, int unit)
+{
+    SysBusDevice *tmr;
+    int i, irqbase;
+
+    object_initialize_child(OBJECT(s), "tmr[*]", &s->tmr[unit],
+                            sizeof(RTMRState), TYPE_RENESAS_8TMR,
+                            &error_abort, NULL);
+
+    tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
+    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", RX62N_PCLK);
+
+    qdev_init_nofail(DEVICE(tmr));
+    sysbus_mmio_map(tmr, 0, RX62N_TMRBASE + unit * 0x10);
+    irqbase = RX62N_TMR_IRQBASE + TMR_NR_IRQ * unit;
+    for (i = 0; i < TMR_NR_IRQ; i++) {
+        sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
+    }
+}
+
+static void register_cmt(RX62NState *s, int unit)
+{
+    SysBusDevice *cmt;
+    int i, irqbase;
+
+    object_initialize_child(OBJECT(s), "cmt[*]", &s->cmt[unit],
+                            sizeof(RTIMERState), TYPE_RENESAS_TIMER,
+                            &error_abort, NULL);
+
+    cmt = SYS_BUS_DEVICE(&s->cmt[unit]);
+    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", RX62N_PCLK);
+    qdev_prop_set_int32(DEVICE(cmt), "feature", RTIMER_FEAT_CMT);
+    qdev_init_nofail(DEVICE(cmt));
+    sysbus_mmio_map(cmt, 0, RX62N_CMTBASE + unit * 0x10);
+    irqbase = RX62N_CMT_IRQBASE + TIMER_CH_CMT * unit;
+    for (i = 0; i < TIMER_CH_CMT; i++) {
+        sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
+    }
+}
+
+static void register_sci(RX62NState *s, int unit)
+{
+    SysBusDevice *sci;
+    int i, irqbase;
+
+    object_initialize_child(OBJECT(s), "sci[*]", &s->sci[unit],
+                            sizeof(RSCIState), TYPE_RENESAS_SCI,
+                            &error_abort, NULL);
+    sci = SYS_BUS_DEVICE(&s->sci[unit]);
+
+    qdev_prop_set_chr(DEVICE(sci), "chardev", serial_hd(unit));
+    qdev_prop_set_uint64(DEVICE(sci), "input-freq", RX62N_PCLK);
+    qdev_prop_set_int32(DEVICE(sci), "feature", SCI_FEAT_SCIA);
+    qdev_prop_set_int32(DEVICE(sci), "register-size", 8);
+    qdev_init_nofail(DEVICE(sci));
+    sysbus_mmio_map(sci, 0, RX62N_SCIBASE + unit * 0x08);
+    irqbase = RX62N_SCI_IRQBASE + SCI_NR_IRQ * unit;
+    for (i = 0; i < SCI_NR_IRQ; i++) {
+        sysbus_connect_irq(sci, i, s->irq[irqbase + i]);
+    }
+}
+
+static void rx62n_realize(DeviceState *dev, Error **errp)
+{
+    RX62NState *s = RX62N(dev);
+
+    memory_region_init_ram(&s->iram, NULL, "iram", RX62N_IRAM_SIZE, errp);
+    memory_region_add_subregion(s->sysmem, RX62N_IRAM_BASE, &s->iram);
+    memory_region_init_rom(&s->d_flash, NULL, "dataflash",
+                           RX62N_DFLASH_SIZE, errp);
+    memory_region_add_subregion(s->sysmem, RX62N_DFLASH_BASE, &s->d_flash);
+    memory_region_init_rom(&s->c_flash, NULL, "codeflash",
+                           RX62N_CFLASH_SIZE, errp);
+    memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flash);
+    if (!s->kernel) {
+        rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
+    }
+
+    /* Initialize CPU */
+    object_initialize_child(OBJECT(s), "cpu", &s->cpu, sizeof(RXCPU),
+                            TYPE_RX62N_CPU, errp, NULL);
+
+    register_icu(s);
+    s->cpu.env.ack = qdev_get_gpio_in_named(DEVICE(&s->icu), "ack", 0);
+    register_tmr(s, 0);
+    register_tmr(s, 1);
+    register_cmt(s, 0);
+    register_cmt(s, 1);
+    register_sci(s, 0);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
+}
+
+static Property rx62n_properties[] = {
+    DEFINE_PROP_LINK("memory", RX62NState, sysmem, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void rx62n_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rx62n_realize;
+    device_class_set_props(dc, rx62n_properties);
+}
+
+static const TypeInfo rx62n_info = {
+    .name = TYPE_RX62N,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RX62NState),
+    .class_init = rx62n_class_init,
+};
+
+static void rx62n_register_types(void)
+{
+    type_register_static(&rx62n_info);
+}
+
+type_init(rx62n_register_types)
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
new file mode 100644
index 0000000000..43af11be46
--- /dev/null
+++ b/hw/rx/Kconfig
@@ -0,0 +1,13 @@
+config RX
+    bool
+
+config RX62N
+    bool
+    select RX
+    select RENESAS_8TMR
+    select RENESAS_TIMER
+    select RENESAS_SCI
+
+config RX_VIRT
+    bool
+    select RX62N
diff --git a/hw/rx/Makefile.objs b/hw/rx/Makefile.objs
new file mode 100644
index 0000000000..63f8be0e82
--- /dev/null
+++ b/hw/rx/Makefile.objs
@@ -0,0 +1,2 @@
+obj-$(CONFIG_RX62N) += rx62n.o
+obj-$(CONFIG_RX_VIRT) += rx-virt.o
-- 
2.20.1


