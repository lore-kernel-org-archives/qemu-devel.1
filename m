Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5405D2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJEXAuh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5405D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPYa-000241-9y
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifPU9-0005jO-U9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifPU8-0008HS-5s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:33 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifPU3-0008BY-Jv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:30:32 -0500
Received: by mail-wm1-x341.google.com with SMTP id f4so3748511wmj.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9EDJH/BxPkKlhLjKsWHknM6vk0Y8bYaWTnGtJKPkwqA=;
 b=JJEXAuh2pZssLNJEJY0y+N1djE2rGkTr5dDpfrFrlt/b1iIM/99Ytr69xV6yXfuT8S
 FDcp707k5l/70HeDFUJvRYjxMr5gD/03uPVIGH0bJfyH0s638OjUw2II/lRoYQHeEEjK
 GQoByIUJgH0/ZQRoQVDq7pBER3+F6TZ04SvxrfTytJRX/YLM3O+6a4R8oz0JIrogVgXF
 aezy6Iv6Oc0rIQ3e1ZSaRXslruiXDtk/0G1/QA0Kbz0LLzmaMMyZ8TzxLojSH4yezALI
 R0Tqn2aB8L4H1gWcqBapvLR7EeHbuNjRaOB92FHkK6sFXeJEfamex0+3+pDoRDarfDeE
 iW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=9EDJH/BxPkKlhLjKsWHknM6vk0Y8bYaWTnGtJKPkwqA=;
 b=LyXaPX/lGxjaU3KqbFSmDN4XyD/uk85FORAQL0gZyhGqil/uJ2hzGOdQ45y+VL6W0F
 W8ZTnHYv/4bxwyFKDfIfMR7W0EFmTTY8sYCekCuA8wWeanml08dxWXVuevQUh56t/f5x
 OwYvfoKpE9U0N/vEPHUgE8Xt+8evOPDG7Fr11F3qYFIgdFaSQNJQ4c60/Ho1Lxcch7Z/
 PMX5LA0xV4CMCXAe6ReEGySEAv6+Ii98X1SYCtfV/eFtUX9NoPfjJMnLxf2h0lYFE/bT
 82lXT3se5/W3FHiWKe2U/WNPC5YR1DmlxHYgMFqV8GDsSgWZJrfVyAWhnPh5WMiHZId9
 kR6w==
X-Gm-Message-State: APjAAAVlRlJWX4zGFuFujB6S6IxJir0Tqys8vgRGVdJ33928+ztXjFzG
 B3tQrzrz8CmkmivuA4lzR1Ct9P9G
X-Google-Smtp-Source: APXvYqxK9ivQbr6rzDsczuHIBj602drLKASadsEvrPkAi6usJNZki99iULJweMKzdaH5R+zmXzyV2w==
X-Received: by 2002:a1c:1d8c:: with SMTP id d134mr7303447wmd.16.1576161026205; 
 Thu, 12 Dec 2019 06:30:26 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c9sm6140505wmc.47.2019.12.12.06.30.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 06:30:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] x86: move more functions to X86MachineState and x86.c
Date: Thu, 12 Dec 2019 15:30:19 +0100
Message-Id: <1576161021-5359-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: philmd@redhat.com, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are needed by microvm too, so move them outside of PC-specific files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c          |  99 -------------------------------------------------
 hw/i386/x86.c         | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h  |  12 ------
 include/hw/i386/x86.h |  13 +++++++
 4 files changed, 114 insertions(+), 111 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d2c5d8..308248d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -342,17 +342,6 @@ GlobalProperty pc_compat_1_4[] = {
 };
 const size_t pc_compat_1_4_len = G_N_ELEMENTS(pc_compat_1_4);
 
-void gsi_handler(void *opaque, int n, int level)
-{
-    GSIState *s = opaque;
-
-    DPRINTF("pc: %s GSI %d\n", level ? "raising" : "lowering", n);
-    if (n < ISA_NUM_IRQS) {
-        qemu_set_irq(s->i8259_irq[n], level);
-    }
-    qemu_set_irq(s->ioapic_irq[n], level);
-}
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -392,55 +381,6 @@ static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
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
-    DPRINTF("pic_irqs: %s irq %d\n", level? "raise" : "lower", irq);
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
@@ -884,16 +824,6 @@ void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd)
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
@@ -1289,11 +1219,6 @@ uint64_t pc_pci_hole64_start(void)
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
@@ -1480,30 +1405,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
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
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 394edc2..028bbf4 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -41,11 +41,15 @@
 #include "hw/i386/fw_cfg.h"
 
 #include "hw/acpi/cpu_hotplug.h"
+#include "hw/i386/pc.h"
+#include "hw/irq.h"
 #include "hw/nmi.h"
 #include "hw/loader.h"
 #include "multiboot.h"
 #include "elf.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "config-devices.h"
+#include "kvm_i386.h"
 
 #define BIOS_FILENAME "bios.bin"
 
@@ -220,6 +224,103 @@ static long get_file_size(FILE *f)
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
+qemu_irq pc_allocate_cpu_irq(void)
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
index 1f86eba..0ab4a2a 100644
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
@@ -144,15 +142,6 @@ int pic_get_output(DeviceState *d);
 
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
 void gsi_handler(void *opaque, int n, int level);
 
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
@@ -217,7 +206,6 @@ void pc_pci_device_init(PCIBus *pci_bus);
 typedef void (*cpu_set_smm_t)(int smm, void *arg);
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
-void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
 
 ISADevice *pc_find_fdc0(void);
 int cmos_get_fd_drive_type(FloppyDriveType fd0);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 4b84917..a6c23ef 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -23,6 +23,8 @@
 
 #include "hw/boards.h"
 #include "hw/nmi.h"
+#include "hw/isa/isa.h"
+#include "hw/i386/ioapic.h"
 
 typedef struct {
     /*< private >*/
@@ -95,4 +97,15 @@ void x86_load_linux(X86MachineState *x86ms,
                     bool pvh_enabled,
                     bool linuxboot_dma_enabled);
 
+/* Global System Interrupts */
+
+#define GSI_NUM_PINS IOAPIC_NUM_PINS
+
+typedef struct GSIState {
+    qemu_irq i8259_irq[ISA_NUM_IRQS];
+    qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
+} GSIState;
+
+void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
+
 #endif
-- 
1.8.3.1



