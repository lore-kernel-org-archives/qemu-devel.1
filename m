Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D0BC3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E5220674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W38PuHII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E5220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtnc-0006c4-H2
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFd-0005ti-NN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFb-0000I4-M9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:41 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFb-0000Gl-Dx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:39 -0500
Received: by mail-wr1-x431.google.com with SMTP id y11so8036755wrt.6
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=J8EuXOaFv77zXVZ+gvJ8EQAA3UR6OUHvj5oaQV1ueAE=;
 b=W38PuHIIuIOkRoTX4aCzkyhJO0RQwlepsvQLgGqLPHVIhwch+gIe9/nxWbUZGBlN24
 e9cOgXCvLwifiz9IW8Y/nEEYpHo6lFb/O+geZZT9bZMywjjh+If8jRQO1i5wKq1Skuis
 OdCue1kTM1z8NvzrXQ45InKtSEN2uJm9Rs+Azu7oYaByMchcNxGFtV+4wX0kV6KWXMBs
 kxikWxv9m4kd4SzYR6z8udMYCtOXzU/MA63Hmjv4VsykXU3ydXKl8uqPEJFIH0NHC3IS
 U1BuUfgkjIqtXHidYEvQn6gTMoHyF5x3+mJMPz57QekjGQRUoQNTZtksCOrxgwDuH8d5
 k0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=J8EuXOaFv77zXVZ+gvJ8EQAA3UR6OUHvj5oaQV1ueAE=;
 b=PChsnTpaC5+yTi0nYUkWCsNLnrQbYQ7JatudE1iSZMzYz0agEgKK9pmPkzVSiYFc9N
 0SimkvEvffuqBbLkXxbS34tcrPTFmC1nr/gKPlgrfRoPvofaAu0oBe5EO7qxKdEyqTmX
 yvGf0xELNzfEuXc5yVRps6kHms+GCDEQwfMaJxvzwyx06ltrDmZjthZAP4A65yGZuQPk
 3mTtiuyQaSss04prkrPCLDRM81fEK5GX4K5x5/vt6zA7ebUQ2YcScO6xRrfY+azc41Sp
 yHZ59/GGZ1FUfMa8poyQAWDtBzwrza5dtDZsr6iC8M5Fu3UcYTBMao2Q579/GH3aBZ/d
 i6ew==
X-Gm-Message-State: APjAAAXT9iqAJfHkWCjzTrGvLDuzwfRS8ptVQBjGqYbQSgW0yV+F/v9F
 meWN1ceTZKmtU9LZGDmNgEKsp7Av
X-Google-Smtp-Source: APXvYqy5ghhD6SZqVaITr+odcDl/K9w42rccHBxKn+Kbu/CINlyjJLTfQ0yKgK1++uqwFsaZqHJFeA==
X-Received: by 2002:adf:e984:: with SMTP id h4mr30483525wrm.275.1576513778051; 
 Mon, 16 Dec 2019 08:29:38 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/62] x86: move more x86-generic functions out of PC files
Date: Mon, 16 Dec 2019 17:28:34 +0100
Message-Id: <1576513726-53700-51-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

These are needed by microvm too, so move them outside of PC-specific files.
With this patch, microvm.c need not include pc.h anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/acpi-build.c  |   1 +
 hw/i386/fw_cfg.c      |   1 -
 hw/i386/fw_cfg.h      |   2 +
 hw/i386/kvm/ioapic.c  |   2 +-
 hw/i386/microvm.c     |   3 +-
 hw/i386/pc.c          | 101 +------------------------------------------------
 hw/i386/trace-events  |   6 ++-
 hw/i386/x86.c         | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h  |  20 ----------
 include/hw/i386/x86.h |  18 +++++++++
 target/i386/kvm.c     |   2 +-
 target/i386/machine.c |   2 +-
 12 files changed, 133 insertions(+), 128 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 12ff55f..7b8da62 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -53,6 +53,7 @@
 /* Supported chipsets: */
 #include "hw/southbridge/piix.h"
 #include "hw/acpi/pcihp.h"
+#include "hw/i386/fw_cfg.h"
 #include "hw/i386/ich9.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/q35.h"
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 326e33e..da60ada 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -16,7 +16,6 @@
 #include "sysemu/numa.h"
 #include "hw/acpi/acpi.h"
 #include "hw/firmware/smbios.h"
-#include "hw/i386/pc.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/timer/hpet.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
index e0856a3..9e74278 100644
--- a/hw/i386/fw_cfg.h
+++ b/hw/i386/fw_cfg.h
@@ -12,6 +12,8 @@
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 
+#define FW_CFG_IO_BASE     0x510
+
 #define FW_CFG_ACPI_TABLES      (FW_CFG_ARCH_LOCAL + 0)
 #define FW_CFG_SMBIOS_ENTRIES   (FW_CFG_ARCH_LOCAL + 1)
 #define FW_CFG_IRQ0_OVERRIDE    (FW_CFG_ARCH_LOCAL + 2)
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index f94729c..8703f19 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "hw/i386/pc.h"
+#include "hw/i386/x86.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/ioapic_internal.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 2068319..827ce29 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -32,7 +32,6 @@
 #include "hw/kvm/clock.h"
 #include "hw/i386/microvm.h"
 #include "hw/i386/x86.h"
-#include "hw/i386/pc.h"
 #include "target/i386/cpu.h"
 #include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
@@ -133,7 +132,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
         qemu_irq *i8259;
 
-        i8259 = i8259_init(isa_bus, pc_allocate_cpu_irq());
+        i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             gsi_state->i8259_irq[i] = i8259[i];
         }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 907fc16..f571fe7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -334,17 +334,6 @@ GlobalProperty pc_compat_1_4[] = {
 };
 const size_t pc_compat_1_4_len = G_N_ELEMENTS(pc_compat_1_4);
 
-void gsi_handler(void *opaque, int n, int level)
-{
-    GSIState *s = opaque;
-
-    trace_pc_gsi_interrupt(n, level);
-    if (n < ISA_NUM_IRQS) {
-        qemu_set_irq(s->i8259_irq[n], level);
-    }
-    qemu_set_irq(s->ioapic_irq[n], level);
-}
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -384,55 +373,6 @@ static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
     return 0xffffffffffffffffULL;
 }
 
-/* TSC handling */
-uint64_t cpu_get_tsc(CPUX86State *env)
-{
-    return cpu_get_ticks();
-}
-
-/* IRQ handling */
-int cpu_get_pic_interrupt(CPUX86State *env)
-{
-    X86CPU *cpu = env_archcpu(env);
-    int intno;
-
-    if (!kvm_irqchip_in_kernel()) {
-        intno = apic_get_interrupt(cpu->apic_state);
-        if (intno >= 0) {
-            return intno;
-        }
-        /* read the irq from the PIC */
-        if (!apic_accept_pic_intr(cpu->apic_state)) {
-            return -1;
-        }
-    }
-
-    intno = pic_read_irq(isa_pic);
-    return intno;
-}
-
-static void pic_irq_request(void *opaque, int irq, int level)
-{
-    CPUState *cs = first_cpu;
-    X86CPU *cpu = X86_CPU(cs);
-
-    trace_pc_pic_interrupt(irq, level);
-    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
-        CPU_FOREACH(cs) {
-            cpu = X86_CPU(cs);
-            if (apic_accept_pic_intr(cpu->apic_state)) {
-                apic_deliver_pic_intr(cpu->apic_state, level);
-            }
-        }
-    } else {
-        if (level) {
-            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-        } else {
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        }
-    }
-}
-
 /* PC cmos mappings */
 
 #define REG_EQUIPMENT_BYTE          0x14
@@ -876,16 +816,6 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd)
     nb_ne2k++;
 }
 
-DeviceState *cpu_get_current_apic(void)
-{
-    if (current_cpu) {
-        X86CPU *cpu = X86_CPU(current_cpu);
-        return cpu->apic_state;
-    } else {
-        return NULL;
-    }
-}
-
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
 {
     X86CPU *cpu = opaque;
@@ -1281,11 +1211,6 @@ uint64_t pc_pci_hole64_start(void)
     return ROUND_UP(hole64_start, 1 * GiB);
 }
 
-qemu_irq pc_allocate_cpu_irq(void)
-{
-    return qemu_allocate_irq(pic_irq_request, NULL, 0);
-}
-
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
 {
     DeviceState *dev = NULL;
@@ -1462,7 +1387,7 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     } else if (xen_enabled()) {
         i8259 = xen_interrupt_controller_init();
     } else {
-        i8259 = i8259_init(isa_bus, pc_allocate_cpu_irq());
+        i8259 = i8259_init(isa_bus, x86_allocate_cpu_irq());
     }
 
     for (size_t i = 0; i < ISA_NUM_IRQS; i++) {
@@ -1472,30 +1397,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
     g_free(i8259);
 }
 
-void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
-{
-    DeviceState *dev;
-    SysBusDevice *d;
-    unsigned int i;
-
-    if (kvm_ioapic_in_kernel()) {
-        dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
-    } else {
-        dev = qdev_create(NULL, TYPE_IOAPIC);
-    }
-    if (parent_name) {
-        object_property_add_child(object_resolve_path(parent_name, NULL),
-                                  "ioapic", OBJECT(dev), NULL);
-    }
-    qdev_init_nofail(dev);
-    d = SYS_BUS_DEVICE(dev);
-    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
-
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        gsi_state->ioapic_irq[i] = qdev_get_gpio_in(dev, i);
-    }
-}
-
 static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 43f33cf..a9b6437 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -112,8 +112,10 @@ amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
 vmport_command(unsigned char command) "command: 0x%02x"
 
+# x86.c
+x86_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
+x86_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
+
 # pc.c
-pc_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
-pc_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
 port92_read(uint8_t val) "port92: read 0x%02x"
 port92_write(uint8_t val) "port92: write 0x%02x"
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 6fb01e4..80e33be 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -34,6 +34,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/replay.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
 
 #include "hw/i386/x86.h"
 #include "target/i386/cpu.h"
@@ -42,11 +43,14 @@
 #include "hw/intc/i8259.h"
 
 #include "hw/acpi/cpu_hotplug.h"
+#include "hw/irq.h"
 #include "hw/nmi.h"
 #include "hw/loader.h"
 #include "multiboot.h"
 #include "elf.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "config-devices.h"
+#include "kvm_i386.h"
 
 #define BIOS_FILENAME "bios.bin"
 
@@ -221,6 +225,105 @@ static long get_file_size(FILE *f)
     return size;
 }
 
+/* TSC handling */
+uint64_t cpu_get_tsc(CPUX86State *env)
+{
+    return cpu_get_ticks();
+}
+
+/* IRQ handling */
+static void pic_irq_request(void *opaque, int irq, int level)
+{
+    CPUState *cs = first_cpu;
+    X86CPU *cpu = X86_CPU(cs);
+
+    trace_x86_pic_interrupt(irq, level);
+    if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
+        CPU_FOREACH(cs) {
+            cpu = X86_CPU(cs);
+            if (apic_accept_pic_intr(cpu->apic_state)) {
+                apic_deliver_pic_intr(cpu->apic_state, level);
+            }
+        }
+    } else {
+        if (level) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+qemu_irq x86_allocate_cpu_irq(void)
+{
+    return qemu_allocate_irq(pic_irq_request, NULL, 0);
+}
+
+int cpu_get_pic_interrupt(CPUX86State *env)
+{
+    X86CPU *cpu = env_archcpu(env);
+    int intno;
+
+    if (!kvm_irqchip_in_kernel()) {
+        intno = apic_get_interrupt(cpu->apic_state);
+        if (intno >= 0) {
+            return intno;
+        }
+        /* read the irq from the PIC */
+        if (!apic_accept_pic_intr(cpu->apic_state)) {
+            return -1;
+        }
+    }
+
+    intno = pic_read_irq(isa_pic);
+    return intno;
+}
+
+DeviceState *cpu_get_current_apic(void)
+{
+    if (current_cpu) {
+        X86CPU *cpu = X86_CPU(current_cpu);
+        return cpu->apic_state;
+    } else {
+        return NULL;
+    }
+}
+
+void gsi_handler(void *opaque, int n, int level)
+{
+    GSIState *s = opaque;
+
+    trace_x86_gsi_interrupt(n, level);
+    if (n < ISA_NUM_IRQS) {
+        qemu_set_irq(s->i8259_irq[n], level);
+    }
+    qemu_set_irq(s->ioapic_irq[n], level);
+}
+
+void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
+{
+    DeviceState *dev;
+    SysBusDevice *d;
+    unsigned int i;
+
+    if (kvm_ioapic_in_kernel()) {
+        dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
+    } else {
+        dev = qdev_create(NULL, TYPE_IOAPIC);
+    }
+    if (parent_name) {
+        object_property_add_child(object_resolve_path(parent_name, NULL),
+                                  "ioapic", OBJECT(dev), NULL);
+    }
+    qdev_init_nofail(dev);
+    d = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
+
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        gsi_state->ioapic_irq[i] = qdev_get_gpio_in(dev, i);
+    }
+}
+
 struct setup_data {
     uint64_t next;
     uint32_t type;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ca641e8..e512838 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -3,11 +3,9 @@
 
 #include "exec/memory.h"
 #include "hw/boards.h"
-#include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
 #include "hw/block/flash.h"
 #include "net/net.h"
-#include "hw/i386/ioapic.h"
 #include "hw/i386/x86.h"
 
 #include "qemu/range.h"
@@ -134,17 +132,6 @@ typedef struct PCMachineClass {
 
 /* ioapic.c */
 
-/* Global System Interrupts */
-
-#define GSI_NUM_PINS IOAPIC_NUM_PINS
-
-typedef struct GSIState {
-    qemu_irq i8259_irq[ISA_NUM_IRQS];
-    qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
-} GSIState;
-
-void gsi_handler(void *opaque, int n, int level);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 
 /* vmport.c */
@@ -188,7 +175,6 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *rom_memory,
                     MemoryRegion **ram_memory);
 uint64_t pc_pci_hole64_start(void);
-qemu_irq pc_allocate_cpu_irq(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
@@ -206,18 +192,12 @@ void pc_pci_device_init(PCIBus *pci_bus);
 typedef void (*cpu_set_smm_t)(int smm, void *arg);
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
-void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
 
 ISADevice *pc_find_fdc0(void);
 int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
-#define FW_CFG_IO_BASE     0x510
-
 #define PORT92_A20_LINE "a20"
 
-/* hpet.c */
-extern int no_hpet;
-
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 97d1575..41fe37b 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -23,6 +23,8 @@
 
 #include "hw/boards.h"
 #include "hw/nmi.h"
+#include "hw/isa/isa.h"
+#include "hw/i386/ioapic.h"
 
 typedef struct {
     /*< private >*/
@@ -100,4 +102,20 @@ void x86_load_linux(X86MachineState *x86ms,
 
 bool x86_machine_is_smm_enabled(X86MachineState *x86ms);
 
+/* Global System Interrupts */
+
+#define GSI_NUM_PINS IOAPIC_NUM_PINS
+
+typedef struct GSIState {
+    qemu_irq i8259_irq[ISA_NUM_IRQS];
+    qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
+} GSIState;
+
+qemu_irq x86_allocate_cpu_irq(void);
+void gsi_handler(void *opaque, int n, int level);
+void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
+
+/* hpet.c */
+extern int no_hpet;
+
 #endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c7ff67a..55e6265 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -35,7 +35,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "hw/i386/pc.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/i386/apic-msidef.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 2699eed..b6720d8 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1,10 +1,10 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
 #include "hyperv.h"
+#include "hw/i386/x86.h"
 #include "kvm_i386.h"
 
 #include "sysemu/kvm.h"
-- 
1.8.3.1



