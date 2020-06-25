Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D859C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 23:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394B320767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 23:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="kibJPPa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394B320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joaz0-0000t9-Gw
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 19:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1joayQ-0000N7-4J; Thu, 25 Jun 2020 19:08:02 -0400
Received: from home.keithp.com ([63.227.221.253]:39444 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1joayN-0007Gf-Hi; Thu, 25 Jun 2020 19:08:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 9C59A3F2CB6C;
 Thu, 25 Jun 2020 16:07:54 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id pSeNJChwUhd4; Thu, 25 Jun 2020 16:07:53 -0700 (PDT)
Received: from keithp.com (168-103-152-72.tukw.qwest.net [168.103.152.72])
 by elaine.keithp.com (Postfix) with ESMTPSA id 676063F2CB6A;
 Thu, 25 Jun 2020 16:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1593126473; bh=B3D6iPyP1jH0LIZnd+CMsCai+RzYgkvxsG4oF0ueQG4=;
 h=From:To:Cc:Subject:Date:From;
 b=kibJPPa7u0FAux5UhvOQG0Hnpcb7xk5P0TzQXlAvZcS6PKDFWOAAz8Alf3xP8VUVD
 JWqWPp8MJh+nPTO4ts4Q3Yero2R797rOUp6YsFbt6zEep3RvFqYEKUBuEF/dTMo1z5
 kCR5jvdFwmrrPZiTo/jWQuXLVDVCpFNnPN0ItbZE5jjOrzyWBaHJK3gokwKi+Aj9Vs
 m/WZtbKzemytEMV/WseZBFVda4d5HOOjSFgsZeBv0gQ87ytb4T+XR1cOeW1HPvVJJm
 xkaHCNfdnAITkEu7S/e53q80oYcJDEiFRGXOInBpnebK4ifHFnqMYE7w/cRdckCoEt
 iHn4hrkb3ZFag==
Received: by keithp.com (Postfix, from userid 1000)
 id 633851582167; Thu, 25 Jun 2020 16:07:51 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Keith Packard <keithp@keithp.com>, qemu-arm@nongnu.org
Subject: [PATCH] hw/arm: Add 'virtm' hardware
Date: Thu, 25 Jun 2020 16:07:40 -0700
Message-Id: <20200625230740.549114-1-keithp@keithp.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 19:07:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Keith Packard <keithp@keithp.com>
From: Keith Packard via <qemu-devel@nongnu.org>

'virtm' is a hardware target that is designed to be used for compiler
and library testing on Cortex-M processors. It supports all cortex-m
processors and includes sufficient memory to run even large test
cases.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 MAINTAINERS          |   9 +++-
 hw/arm/Makefile.objs |   2 +-
 hw/arm/virtm.c       | 112 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 hw/arm/virtm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b40446c73..4c7e394dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -850,9 +850,16 @@ Virt
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
-F: hw/arm/virt*
+F: hw/arm/virt.c
+F: hw/arm/virt-acpi-build.c
 F: include/hw/arm/virt.h
 
+Virt M
+M: Keith Packard <keithp@keithp.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/virtm.c
+
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 534a6a119e..54be15b40a 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,6 +1,6 @@
 obj-y += boot.o
 obj-$(CONFIG_PLATFORM_BUS) += sysbus-fdt.o
-obj-$(CONFIG_ARM_VIRT) += virt.o
+obj-$(CONFIG_ARM_VIRT) += virt.o virtm.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
diff --git a/hw/arm/virtm.c b/hw/arm/virtm.c
new file mode 100644
index 0000000000..beda3644f5
--- /dev/null
+++ b/hw/arm/virtm.c
@@ -0,0 +1,112 @@
+/*
+ * Virtual ARM Cortex M
+ *
+ * Copyright © 2020, Keith Packard <keithp@keithp.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/boot.h"
+#include "hw/boards.h"
+#include "exec/address-spaces.h"
+#include "hw/arm/armv7m.h"
+#include "hw/misc/unimp.h"
+#include "cpu.h"
+
+#define NUM_IRQ_LINES 32
+#define ROM_BASE  0x00000000
+#define ROM_SIZE  0x20000000
+#define RAM_BASE    0x20000000
+#define RAM_SIZE    0x20000000
+
+static const char *valid_cpus[] = {
+    ARM_CPU_TYPE_NAME("cortex-m0"),
+    ARM_CPU_TYPE_NAME("cortex-m3"),
+    ARM_CPU_TYPE_NAME("cortex-m33"),
+    ARM_CPU_TYPE_NAME("cortex-m4"),
+    ARM_CPU_TYPE_NAME("cortex-m7"),
+};
+
+static bool cpu_type_valid(const char *cpu)
+{
+    int i;
+
+    return true;
+    for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
+        if (strcmp(cpu, valid_cpus[i]) == 0) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void machvirtm_init(MachineState *ms)
+{
+    DeviceState *nvic;
+
+    if (!cpu_type_valid(ms->cpu_type)) {
+        error_report("virtm: CPU type %s not supported", ms->cpu_type);
+        exit(1);
+    }
+
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    MemoryRegion *rom = g_new(MemoryRegion, 1);
+    MemoryRegion *system_memory = get_system_memory();
+
+    /* Flash programming is done via the SCU, so pretend it is ROM.  */
+    memory_region_init_rom(rom, NULL, "virtm.rom", ROM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, ROM_BASE, rom);
+
+    memory_region_init_ram(ram, NULL, "virtm.ram", RAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, RAM_BASE, ram);
+
+    nvic = qdev_new(TYPE_ARMV7M);
+    qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
+    qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
+    qdev_prop_set_bit(nvic, "enable-bitband", true);
+    object_property_set_link(OBJECT(nvic), OBJECT(get_system_memory()),
+                                     "memory", &error_abort);
+    /* This will exit with an error if the user passed us a bad cpu_type */
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(nvic), &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, ROM_SIZE);
+}
+
+static void virtm_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Virtual Cortex-M";
+    mc->init = machvirtm_init;
+    mc->ignore_memory_transaction_failures = true;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+}
+
+static const TypeInfo virtm_type = {
+    .name = MACHINE_TYPE_NAME("virtm"),
+    .parent = TYPE_MACHINE,
+    .class_init = virtm_class_init,
+};
+
+static void virtm_machine_init(void)
+{
+    type_register_static(&virtm_type);
+}
+
+type_init(virtm_machine_init)
-- 
2.27.0


