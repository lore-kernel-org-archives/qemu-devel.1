Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17342CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 03:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8300222C5
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 03:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpmnjFFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8300222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLfd7-0003LB-T0
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 23:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1iLfcR-0002vo-0t
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1iLfcO-00052R-Uf
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:41:30 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229]:36876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1iLfcO-00051z-Hu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 23:41:28 -0400
Received: by mail-lj1-x229.google.com with SMTP id l21so8106249lje.4
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 20:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NT76k4fAQO9YCxSXlYiFQXtcTrsn8lT6JV4xg1L/w8g=;
 b=KpmnjFFAmqFgPah6stt9Za+OTXi0uc9Q5Kp9tGYOIM5YyujtSRC1jKwVSvb/3Hl2N/
 zEZW4WDPXwwuilBtG7aFDf3Gu+vt6R8C2E2YMoORmTMdt27PYMGYU6yWyjnLnMv4+jZY
 fSXC6jW5sY+ZhMLz+/0Yr7CQTUyKQ0LJIMrnFKPDTIeZLRez7JLnfpeIWtjgSZqZrIHw
 Rc97w84eM8GWRYuL3AashWyL4Rie2EzUozvZ8ibfol45OYxxQEhY2EZtnxeoizGWjeXd
 hIUcasNEp7MKWJVqSiatU7Z5DJ3/qQUVfc4B1e3nX3EOySvF71RotAOo3aBB9GKXKuLh
 3HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NT76k4fAQO9YCxSXlYiFQXtcTrsn8lT6JV4xg1L/w8g=;
 b=a/OXEvLnmEMY3iq2FGylspdL51PvLidWaPIAXeF1hNiSbKKJRpNc2eW2HeJidAu12H
 EyFC9CARDnbNwzYF/BE7i7xWFVm2fbwEl1UoQEVAw8sWEybnAsT+zmq74ySYq1yqlo7L
 6s9ahUNgkJ5cXFnB6GW/ovnFxuhIwT0icVLXVajmgB93DpYiG2r3+isuALnJQq1Ouwwx
 mpB6RUk1T0JeFOJqUcf/xPjO8g5uTfVnfiQdvi0fyYSBbdFXw+G3kFK3Zv74Bmu5T52C
 bX29MuPg/VT+GcNLGtrumEW6gTceZiLHoc1eqW2ZutuszwvcuCe1pCyQh095bi2IdiD5
 CrPw==
X-Gm-Message-State: APjAAAWqchxqKqvAL3RCSMLlhxA5qLRWlvdfgCbNhSIKz85seB47+Q8c
 o5Qx8cDa77LUyxpZieDsDk8+FNrr
X-Google-Smtp-Source: APXvYqxO2jkNt9LP1t1NhfCp2NrSxL69kUXdW5KjfzSIcsHS9nfAv9Jof7+bKbUe3c48rmpk3n7Oeg==
X-Received: by 2002:a05:651c:1068:: with SMTP id
 y8mr4252074ljm.223.1571456485957; 
 Fri, 18 Oct 2019 20:41:25 -0700 (PDT)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id 3sm5543770ljs.20.2019.10.18.20.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 20:41:25 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/xtensa: add virt machine
Date: Fri, 18 Oct 2019 20:41:05 -0700
Message-Id: <20191019034105.17523-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::229
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virt machine is a sim machine with generic PCI host controller.
Make common parts of sim machine initialization reusable.
Add PCI controller at 0xf0000000 with PIO space at its base address,
ECAM space at base address + 1M and MMIO space at base address + 64M.
Connect IRQ lines to consecutive CPU external IRQ pins starting from 0.
Instantiate network interfaces on virt machine.

Xtensa linux kernel configuration virt_defconfig can successfully boot
on this machine.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 MAINTAINERS                        |   5 ++
 default-configs/xtensa-softmmu.mak |   1 +
 hw/xtensa/Kconfig                  |   6 ++
 hw/xtensa/Makefile.objs            |   1 +
 hw/xtensa/sim.c                    |  41 +++++----
 hw/xtensa/virt.c                   | 135 +++++++++++++++++++++++++++++
 hw/xtensa/xtensa_sim.h             |  34 ++++++++
 7 files changed, 208 insertions(+), 15 deletions(-)
 create mode 100644 hw/xtensa/virt.c
 create mode 100644 hw/xtensa/xtensa_sim.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 50eaf005f40e..7c2f35a2320f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1302,6 +1302,11 @@ M: Max Filippov <jcmvbkbc@gmail.com>
 S: Maintained
 F: hw/xtensa/sim.c
 
+virt
+M: Max Filippov <jcmvbkbc@gmail.com>
+S: Maintained
+F: hw/xtensa/virt.c
+
 XTFPGA (LX60, LX200, ML605, KC705)
 M: Max Filippov <jcmvbkbc@gmail.com>
 S: Maintained
diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
index 3aa20a47a7fb..4fe1bf00c94b 100644
--- a/default-configs/xtensa-softmmu.mak
+++ b/default-configs/xtensa-softmmu.mak
@@ -5,4 +5,5 @@ CONFIG_SEMIHOSTING=y
 # Boards:
 #
 CONFIG_XTENSA_SIM=y
+CONFIG_XTENSA_VIRT=y
 CONFIG_XTENSA_XTFPGA=y
diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
index d72817d012e3..0740657ea58f 100644
--- a/hw/xtensa/Kconfig
+++ b/hw/xtensa/Kconfig
@@ -1,6 +1,12 @@
 config XTENSA_SIM
     bool
 
+config XTENSA_VIRT
+    bool
+    select XTENSA_SIM
+    select PCI_EXPRESS_GENERIC_BRIDGE
+    select PCI_DEVICES
+
 config XTENSA_XTFPGA
     bool
     select OPENCORES_ETH
diff --git a/hw/xtensa/Makefile.objs b/hw/xtensa/Makefile.objs
index 0bbfccd6deae..2b40e1b60a0e 100644
--- a/hw/xtensa/Makefile.objs
+++ b/hw/xtensa/Makefile.objs
@@ -2,4 +2,5 @@ obj-y += mx_pic.o
 obj-y += pic_cpu.o
 obj-y += xtensa_memory.o
 obj-$(CONFIG_XTENSA_SIM) += sim.o
+obj-$(CONFIG_XTENSA_VIRT) += virt.o
 obj-$(CONFIG_XTENSA_XTFPGA) += xtfpga.o
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 981dbb7bbebb..a22743a3d61c 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -37,6 +37,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "xtensa_memory.h"
+#include "xtensa_sim.h"
 
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
@@ -52,12 +53,11 @@ static void sim_reset(void *opaque)
     cpu_reset(CPU(cpu));
 }
 
-static void xtensa_sim_init(MachineState *machine)
+XtensaCPU *xtensa_sim_common_init(MachineState *machine)
 {
     XtensaCPU *cpu = NULL;
     CPUXtensaState *env = NULL;
     ram_addr_t ram_size = machine->ram_size;
-    const char *kernel_filename = machine->kernel_filename;
     int n;
 
     for (n = 0; n < machine->smp.cpus; n++) {
@@ -89,30 +89,41 @@ static void xtensa_sim_init(MachineState *machine)
         xtensa_create_memory_regions(&sysram, "xtensa.sysram",
                                      get_system_memory());
     }
-
     if (serial_hd(0)) {
         xtensa_sim_open_console(serial_hd(0));
     }
-    if (kernel_filename) {
-        uint64_t elf_entry;
-        uint64_t elf_lowaddr;
+    return cpu;
+}
+
+void xtensa_sim_load_kernel(XtensaCPU *cpu, MachineState *machine)
+{
+    const char *kernel_filename = machine->kernel_filename;
 #ifdef TARGET_WORDS_BIGENDIAN
-        int success = load_elf(kernel_filename, NULL,
-                               translate_phys_addr, cpu,
-                               &elf_entry, &elf_lowaddr,
-                               NULL, 1, EM_XTENSA, 0, 0);
+    int big_endian = true;
 #else
-        int success = load_elf(kernel_filename, NULL,
-                               translate_phys_addr, cpu,
-                               &elf_entry, &elf_lowaddr,
-                               NULL, 0, EM_XTENSA, 0, 0);
+    int big_endian = false;
 #endif
+
+    if (kernel_filename) {
+        uint64_t elf_entry;
+        uint64_t elf_lowaddr;
+        int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
+                               &elf_entry, &elf_lowaddr, NULL, big_endian,
+                               EM_XTENSA, 0, 0);
+
         if (success > 0) {
-            env->pc = elf_entry;
+            cpu->env.pc = elf_entry;
         }
     }
 }
 
+static void xtensa_sim_init(MachineState *machine)
+{
+    XtensaCPU *cpu = xtensa_sim_common_init(machine);
+
+    xtensa_sim_load_kernel(cpu, machine);
+}
+
 static void xtensa_sim_machine_init(MachineClass *mc)
 {
     mc->desc = "sim machine (" XTENSA_DEFAULT_CPU_MODEL ")";
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
new file mode 100644
index 000000000000..b22dcf938a16
--- /dev/null
+++ b/hw/xtensa/virt.c
@@ -0,0 +1,135 @@
+/*
+ * Copyright (c) 2019, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "sysemu/reset.h"
+#include "sysemu/sysemu.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/pci-host/gpex.h"
+#include "net/net.h"
+#include "elf.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "qemu/error-report.h"
+#include "xtensa_memory.h"
+#include "xtensa_sim.h"
+
+static void create_pcie(CPUXtensaState *env, int irq_base, hwaddr addr_base)
+{
+    hwaddr base_ecam = addr_base + 0x00100000;
+    hwaddr size_ecam =             0x03f00000;
+    hwaddr base_pio  = addr_base + 0x00000000;
+    hwaddr size_pio  =             0x00010000;
+    hwaddr base_mmio = addr_base + 0x04000000;
+    hwaddr size_mmio =             0x08000000;
+
+    MemoryRegion *ecam_alias;
+    MemoryRegion *ecam_reg;
+    MemoryRegion *pio_alias;
+    MemoryRegion *pio_reg;
+    MemoryRegion *mmio_alias;
+    MemoryRegion *mmio_reg;
+
+    DeviceState *dev;
+    PCIHostState *pci;
+    qemu_irq *extints;
+    int i;
+
+    dev = qdev_create(NULL, TYPE_GPEX_HOST);
+    qdev_init_nofail(dev);
+
+    /* Map only the first size_ecam bytes of ECAM space. */
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
+                             ecam_reg, 0, size_ecam);
+    memory_region_add_subregion(get_system_memory(), base_ecam, ecam_alias);
+
+    /*
+     * Map the MMIO window into system address space so as to expose
+     * the section of PCI MMIO space which starts at the same base address
+     * (ie 1:1 mapping for that part of PCI MMIO space visible through
+     * the window).
+     */
+    mmio_alias = g_new0(MemoryRegion, 1);
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
+                             mmio_reg, base_mmio, size_mmio);
+    memory_region_add_subregion(get_system_memory(), base_mmio, mmio_alias);
+
+    /* Map IO port space. */
+    pio_alias = g_new0(MemoryRegion, 1);
+    pio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 2);
+    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
+                             pio_reg, 0, size_pio);
+    memory_region_add_subregion(get_system_memory(), base_pio, pio_alias);
+
+    /* Connect IRQ lines. */
+    extints = xtensa_get_extints(env);
+
+    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+        void *q = extints[irq_base + i];
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, q);
+        gpex_set_irq_num(GPEX_HOST(dev), i, irq_base + i);
+    }
+
+    pci = PCI_HOST_BRIDGE(dev);
+    if (pci->bus) {
+        for (i = 0; i < nb_nics; i++) {
+            NICInfo *nd = &nd_table[i];
+
+            if (!nd->model) {
+                nd->model = g_strdup("virtio");
+            }
+
+            pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
+        }
+    }
+}
+
+static void xtensa_virt_init(MachineState *machine)
+{
+    XtensaCPU *cpu = xtensa_sim_common_init(machine);
+    CPUXtensaState *env = &cpu->env;
+
+    create_pcie(env, 0, 0xf0000000);
+    xtensa_sim_load_kernel(cpu, machine);
+}
+
+static void xtensa_virt_machine_init(MachineClass *mc)
+{
+    mc->desc = "virt machine (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->init = xtensa_virt_init;
+    mc->max_cpus = 32;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+}
+
+DEFINE_MACHINE("virt", xtensa_virt_machine_init)
diff --git a/hw/xtensa/xtensa_sim.h b/hw/xtensa/xtensa_sim.h
new file mode 100644
index 000000000000..bdc92f3d2c39
--- /dev/null
+++ b/hw/xtensa/xtensa_sim.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2019, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef XTENSA_SIM_H
+#define XTENSA_SIM_H
+
+XtensaCPU *xtensa_sim_common_init(MachineState *machine);
+void xtensa_sim_load_kernel(XtensaCPU *cpu, MachineState *machine);
+
+#endif
-- 
2.20.1


