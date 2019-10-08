Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A6AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B87206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B87206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHq6l-0002G9-QW
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iHq0O-0005Ep-Rp
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iHq0L-0005c7-HU
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iHq0L-0005bg-7d
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:58:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 734C330860DF;
 Tue,  8 Oct 2019 13:58:20 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3888600CE;
 Tue,  8 Oct 2019 13:58:12 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/12] hw/i386: Introduce the microvm machine type
Date: Tue,  8 Oct 2019 15:55:37 +0200
Message-Id: <20191008135537.197867-12-slp@redhat.com>
In-Reply-To: <20191008135537.197867-1-slp@redhat.com>
References: <20191008135537.197867-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 08 Oct 2019 13:58:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Microvm is a machine type inspired by Firecracker and constructed
after the its machine model.

It's a minimalist machine type without PCI nor ACPI support, designed
for short-lived guests. Microvm also establishes a baseline for
benchmarking and optimizing both QEMU and guest operating systems,
since it is optimized for both boot time and footprint.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 default-configs/i386-softmmu.mak |   1 +
 include/hw/i386/microvm.h        |  83 +++++
 hw/i386/microvm.c                | 572 +++++++++++++++++++++++++++++++
 hw/i386/Kconfig                  |   4 +
 hw/i386/Makefile.objs            |   1 +
 5 files changed, 661 insertions(+)
 create mode 100644 include/hw/i386/microvm.h
 create mode 100644 hw/i386/microvm.c

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index 4229900f57..4cc64dafa2 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -28,3 +28,4 @@
 CONFIG_ISAPC=3Dy
 CONFIG_I440FX=3Dy
 CONFIG_Q35=3Dy
+CONFIG_MICROVM=3Dy
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
new file mode 100644
index 0000000000..faaa2e60b8
--- /dev/null
+++ b/include/hw/i386/microvm.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (c) 2018 Intel Corporation
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_I386_MICROVM_H
+#define HW_I386_MICROVM_H
+
+#include "qemu-common.h"
+#include "exec/hwaddr.h"
+#include "qemu/notify.h"
+
+#include "hw/boards.h"
+#include "hw/i386/x86.h"
+
+/* Microvm memory layout */
+#define PVH_START_INFO        0x6000
+#define MEMMAP_START          0x7000
+#define MODLIST_START         0x7800
+#define BOOT_STACK_POINTER    0x8ff0
+#define PML4_START            0x9000
+#define PDPTE_START           0xa000
+#define PDE_START             0xb000
+#define KERNEL_CMDLINE_START  0x20000
+#define EBDA_START            0x9fc00
+#define HIMEM_START           0x100000
+
+/* Platform virtio definitions */
+#define VIRTIO_MMIO_BASE      0xc0000000
+#define VIRTIO_IRQ_BASE       5
+#define VIRTIO_NUM_TRANSPORTS 8
+#define VIRTIO_CMDLINE_MAXLEN 64
+
+/* Machine type options */
+#define MICROVM_MACHINE_PIT                 "pit"
+#define MICROVM_MACHINE_PIC                 "pic"
+#define MICROVM_MACHINE_RTC                 "rtc"
+#define MICROVM_MACHINE_ISA_SERIAL          "isa-serial"
+#define MICROVM_MACHINE_OPTION_ROMS         "x-option-roms"
+#define MICROVM_MACHINE_AUTO_KERNEL_CMDLINE "auto-kernel-cmdline"
+
+typedef struct {
+    X86MachineClass parent;
+    HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
+                                           DeviceState *dev);
+} MicrovmMachineClass;
+
+typedef struct {
+    X86MachineState parent;
+
+    /* Machine type options */
+    OnOffAuto pic;
+    OnOffAuto pit;
+    OnOffAuto rtc;
+    bool isa_serial;
+    bool option_roms;
+    bool auto_kernel_cmdline;
+
+    /* Machine state */
+    bool kernel_cmdline_fixed;
+} MicrovmMachineState;
+
+#define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
+#define MICROVM_MACHINE(obj) \
+    OBJECT_CHECK(MicrovmMachineState, (obj), TYPE_MICROVM_MACHINE)
+#define MICROVM_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MicrovmMachineClass, obj, TYPE_MICROVM_MACHINE)
+#define MICROVM_MACHINE_CLASS(class) \
+    OBJECT_CLASS_CHECK(MicrovmMachineClass, class, TYPE_MICROVM_MACHINE)
+
+#endif
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
new file mode 100644
index 0000000000..4fd933c001
--- /dev/null
+++ b/hw/i386/microvm.c
@@ -0,0 +1,572 @@
+/*
+ * Copyright (c) 2018 Intel Corporation
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/cutils.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qapi/qapi-visit-common.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/cpus.h"
+#include "sysemu/numa.h"
+#include "sysemu/reset.h"
+
+#include "hw/loader.h"
+#include "hw/irq.h"
+#include "hw/kvm/clock.h"
+#include "hw/i386/microvm.h"
+#include "hw/i386/x86.h"
+#include "hw/i386/pc.h"
+#include "target/i386/cpu.h"
+#include "hw/timer/i8254.h"
+#include "hw/timer/mc146818rtc.h"
+#include "hw/char/serial.h"
+#include "hw/i386/topology.h"
+#include "hw/i386/e820_memory_layout.h"
+#include "hw/i386/fw_cfg.h"
+#include "hw/virtio/virtio-mmio.h"
+
+#include "cpu.h"
+#include "elf.h"
+#include "kvm_i386.h"
+#include "hw/xen/start_info.h"
+
+#define MICROVM_BIOS_FILENAME "bios-microvm.bin"
+
+static void microvm_set_rtc(MicrovmMachineState *mms, ISADevice *s)
+{
+    X86MachineState *x86ms =3D X86_MACHINE(mms);
+    int val;
+
+    val =3D MIN(x86ms->below_4g_mem_size / KiB, 640);
+    rtc_set_memory(s, 0x15, val);
+    rtc_set_memory(s, 0x16, val >> 8);
+    /* extended memory (next 64MiB) */
+    if (x86ms->below_4g_mem_size > 1 * MiB) {
+        val =3D (x86ms->below_4g_mem_size - 1 * MiB) / KiB;
+    } else {
+        val =3D 0;
+    }
+    if (val > 65535) {
+        val =3D 65535;
+    }
+    rtc_set_memory(s, 0x17, val);
+    rtc_set_memory(s, 0x18, val >> 8);
+    rtc_set_memory(s, 0x30, val);
+    rtc_set_memory(s, 0x31, val >> 8);
+    /* memory between 16MiB and 4GiB */
+    if (x86ms->below_4g_mem_size > 16 * MiB) {
+        val =3D (x86ms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
+    } else {
+        val =3D 0;
+    }
+    if (val > 65535) {
+        val =3D 65535;
+    }
+    rtc_set_memory(s, 0x34, val);
+    rtc_set_memory(s, 0x35, val >> 8);
+    /* memory above 4GiB */
+    val =3D x86ms->above_4g_mem_size / 65536;
+    rtc_set_memory(s, 0x5b, val);
+    rtc_set_memory(s, 0x5c, val >> 8);
+    rtc_set_memory(s, 0x5d, val >> 16);
+}
+
+static void microvm_gsi_handler(void *opaque, int n, int level)
+{
+    GSIState *s =3D opaque;
+
+    qemu_set_irq(s->ioapic_irq[n], level);
+}
+
+static void microvm_devices_init(MicrovmMachineState *mms)
+{
+    X86MachineState *x86ms =3D X86_MACHINE(mms);
+    ISABus *isa_bus;
+    ISADevice *rtc_state;
+    GSIState *gsi_state;
+    int i;
+
+    /* Core components */
+
+    gsi_state =3D g_malloc0(sizeof(*gsi_state));
+    if (mms->pic =3D=3D ON_OFF_AUTO_ON || mms->pic =3D=3D ON_OFF_AUTO_AU=
TO) {
+        x86ms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NU=
M_PINS);
+    } else {
+        x86ms->gsi =3D qemu_allocate_irqs(microvm_gsi_handler,
+                                        gsi_state, GSI_NUM_PINS);
+    }
+
+    isa_bus =3D isa_bus_new(NULL, get_system_memory(), get_system_io(),
+                          &error_abort);
+    isa_bus_irqs(isa_bus, x86ms->gsi);
+
+    ioapic_init_gsi(gsi_state, "machine");
+
+    kvmclock_create();
+
+    for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
+        sysbus_create_simple("virtio-mmio",
+                             VIRTIO_MMIO_BASE + i * 512,
+                             x86ms->gsi[VIRTIO_IRQ_BASE + i]);
+    }
+
+    /* Optional and legacy devices */
+
+    if (mms->pic =3D=3D ON_OFF_AUTO_ON || mms->pic =3D=3D ON_OFF_AUTO_AU=
TO) {
+        qemu_irq *i8259;
+
+        i8259 =3D i8259_init(isa_bus, pc_allocate_cpu_irq());
+        for (i =3D 0; i < ISA_NUM_IRQS; i++) {
+            gsi_state->i8259_irq[i] =3D i8259[i];
+        }
+        g_free(i8259);
+    }
+
+    if (mms->pit =3D=3D ON_OFF_AUTO_ON || mms->pit =3D=3D ON_OFF_AUTO_AU=
TO) {
+        if (kvm_pit_in_kernel()) {
+            kvm_pit_init(isa_bus, 0x40);
+        } else {
+            i8254_pit_init(isa_bus, 0x40, 0, NULL);
+        }
+    }
+
+    if (mms->rtc =3D=3D ON_OFF_AUTO_ON ||
+        (mms->rtc =3D=3D ON_OFF_AUTO_AUTO && !kvm_enabled())) {
+        rtc_state =3D mc146818_rtc_init(isa_bus, 2000, NULL);
+        microvm_set_rtc(mms, rtc_state);
+    }
+
+    if (mms->isa_serial) {
+        serial_hds_isa_init(isa_bus, 0, 1);
+    }
+
+    if (bios_name =3D=3D NULL) {
+        bios_name =3D MICROVM_BIOS_FILENAME;
+    }
+    x86_bios_rom_init(get_system_memory(), true);
+}
+
+static void microvm_memory_init(MicrovmMachineState *mms)
+{
+    MachineState *machine =3D MACHINE(mms);
+    X86MachineState *x86ms =3D X86_MACHINE(mms);
+    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
+    MemoryRegion *system_memory =3D get_system_memory();
+    FWCfgState *fw_cfg;
+    ram_addr_t lowmem;
+    int i;
+
+    /*
+     * Check whether RAM fits below 4G (leaving 1/2 GByte for IO memory
+     * and 256 Mbytes for PCI Express Enhanced Configuration Access Mapp=
ing
+     * also known as MMCFG).
+     * If it doesn't, we need to split it in chunks below and above 4G.
+     * In any case, try to make sure that guest addresses aligned at
+     * 1G boundaries get mapped to host addresses aligned at 1G boundari=
es.
+     */
+    if (machine->ram_size >=3D 0xb0000000) {
+        lowmem =3D 0x80000000;
+    } else {
+        lowmem =3D 0xb0000000;
+    }
+
+    /*
+     * Handle the machine opt max-ram-below-4g.  It is basically doing
+     * min(qemu limit, user limit).
+     */
+    if (!x86ms->max_ram_below_4g) {
+        x86ms->max_ram_below_4g =3D 4 * GiB;
+    }
+    if (lowmem > x86ms->max_ram_below_4g) {
+        lowmem =3D x86ms->max_ram_below_4g;
+        if (machine->ram_size - lowmem > lowmem &&
+            lowmem & (1 * GiB - 1)) {
+            warn_report("There is possibly poor performance as the ram s=
ize "
+                        " (0x%" PRIx64 ") is more then twice the size of=
"
+                        " max-ram-below-4g (%"PRIu64") and"
+                        " max-ram-below-4g is not a multiple of 1G.",
+                        (uint64_t)machine->ram_size, x86ms->max_ram_belo=
w_4g);
+        }
+    }
+
+    if (machine->ram_size > lowmem) {
+        x86ms->above_4g_mem_size =3D machine->ram_size - lowmem;
+        x86ms->below_4g_mem_size =3D lowmem;
+    } else {
+        x86ms->above_4g_mem_size =3D 0;
+        x86ms->below_4g_mem_size =3D machine->ram_size;
+    }
+
+    ram =3D g_malloc(sizeof(*ram));
+    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
+                                         machine->ram_size);
+
+    ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
+    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
+                             0, x86ms->below_4g_mem_size);
+    memory_region_add_subregion(system_memory, 0, ram_below_4g);
+
+    e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
+
+    if (x86ms->above_4g_mem_size > 0) {
+        ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
+        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram=
,
+                                 x86ms->below_4g_mem_size,
+                                 x86ms->above_4g_mem_size);
+        memory_region_add_subregion(system_memory, 0x100000000ULL,
+                                    ram_above_4g);
+        e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RA=
M);
+    }
+
+    fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
+                                &address_space_memory);
+
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, machine->smp.cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, machine->smp.max_cpus);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size)=
;
+    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, kvm_allows_irq0_overrid=
e());
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
+                     &e820_reserve, sizeof(e820_reserve));
+    fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
+                    sizeof(struct e820_entry) * e820_get_num_entries());
+
+    rom_set_fw(fw_cfg);
+
+    if (machine->kernel_filename !=3D NULL) {
+        x86_load_linux(x86ms, fw_cfg, 0, true, true);
+    }
+
+    if (mms->option_roms) {
+        for (i =3D 0; i < nb_option_roms; i++) {
+            rom_add_option(option_rom[i].name, option_rom[i].bootindex);
+        }
+    }
+
+    x86ms->fw_cfg =3D fw_cfg;
+    x86ms->ioapic_as =3D &address_space_memory;
+}
+
+static gchar *microvm_get_mmio_cmdline(gchar *name)
+{
+    gchar *cmdline;
+    gchar *separator;
+    long int index;
+    int ret;
+
+    separator =3D g_strrstr(name, ".");
+    if (!separator) {
+        return NULL;
+    }
+
+    if (qemu_strtol(separator + 1, NULL, 10, &index) !=3D 0) {
+        return NULL;
+    }
+
+    cmdline =3D g_malloc0(VIRTIO_CMDLINE_MAXLEN);
+    ret =3D g_snprintf(cmdline, VIRTIO_CMDLINE_MAXLEN,
+                     " virtio_mmio.device=3D512@0x%lx:%ld",
+                     VIRTIO_MMIO_BASE + index * 512,
+                     VIRTIO_IRQ_BASE + index);
+    if (ret < 0 || ret >=3D VIRTIO_CMDLINE_MAXLEN) {
+        g_free(cmdline);
+        return NULL;
+    }
+
+    return cmdline;
+}
+
+static void microvm_fix_kernel_cmdline(MachineState *machine)
+{
+    X86MachineState *x86ms =3D X86_MACHINE(machine);
+    BusState *bus;
+    BusChild *kid;
+    char *cmdline;
+
+    /*
+     * Find MMIO transports with attached devices, and add them to the k=
ernel
+     * command line.
+     *
+     * Yes, this is a hack, but one that heavily improves the UX without
+     * introducing any significant issues.
+     */
+    cmdline =3D g_strdup(machine->kernel_cmdline);
+    bus =3D sysbus_get_default();
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev =3D kid->child;
+        ObjectClass *class =3D object_get_class(OBJECT(dev));
+
+        if (class =3D=3D object_class_by_name(TYPE_VIRTIO_MMIO)) {
+            VirtIOMMIOProxy *mmio =3D VIRTIO_MMIO(OBJECT(dev));
+            VirtioBusState *mmio_virtio_bus =3D &mmio->bus;
+            BusState *mmio_bus =3D &mmio_virtio_bus->parent_obj;
+
+            if (!QTAILQ_EMPTY(&mmio_bus->children)) {
+                gchar *mmio_cmdline =3D microvm_get_mmio_cmdline(mmio_bu=
s->name);
+                if (mmio_cmdline) {
+                    char *newcmd =3D g_strjoin(NULL, cmdline, mmio_cmdli=
ne, NULL);
+                    g_free(mmio_cmdline);
+                    g_free(cmdline);
+                    cmdline =3D newcmd;
+                }
+            }
+        }
+    }
+
+    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline=
) + 1);
+    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
+}
+
+static void microvm_machine_state_init(MachineState *machine)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
+    X86MachineState *x86ms =3D X86_MACHINE(machine);
+    Error *local_err =3D NULL;
+
+    microvm_memory_init(mms);
+
+    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
+    if (local_err) {
+        error_report_err(local_err);
+        exit(1);
+    }
+
+    microvm_devices_init(mms);
+}
+
+static void microvm_machine_reset(MachineState *machine)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
+    CPUState *cs;
+    X86CPU *cpu;
+
+    if (machine->kernel_filename !=3D NULL &&
+        mms->auto_kernel_cmdline && !mms->kernel_cmdline_fixed) {
+        microvm_fix_kernel_cmdline(machine);
+        mms->kernel_cmdline_fixed =3D true;
+    }
+
+    qemu_devices_reset();
+
+    CPU_FOREACH(cs) {
+        cpu =3D X86_CPU(cs);
+
+        if (cpu->apic_state) {
+            device_reset(cpu->apic_state);
+        }
+    }
+}
+
+static void microvm_machine_get_pic(Object *obj, Visitor *v, const char =
*name,
+                                    void *opaque, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+    OnOffAuto pic =3D mms->pic;
+
+    visit_type_OnOffAuto(v, name, &pic, errp);
+}
+
+static void microvm_machine_set_pic(Object *obj, Visitor *v, const char =
*name,
+                                    void *opaque, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &mms->pic, errp);
+}
+
+static void microvm_machine_get_pit(Object *obj, Visitor *v, const char =
*name,
+                                    void *opaque, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+    OnOffAuto pit =3D mms->pit;
+
+    visit_type_OnOffAuto(v, name, &pit, errp);
+}
+
+static void microvm_machine_set_pit(Object *obj, Visitor *v, const char =
*name,
+                                    void *opaque, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &mms->pit, errp);
+}
+
+static void microvm_machine_get_rtc(Object *obj, Visitor *v, const char =
*name,
+                                    void *opaque, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+    OnOffAuto rtc =3D mms->rtc;
+
+    visit_type_OnOffAuto(v, name, &rtc, errp);
+}
+
+static void microvm_machine_set_rtc(Object *obj, Visitor *v, const char =
*name,
+                                    void *opaque, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    visit_type_OnOffAuto(v, name, &mms->rtc, errp);
+}
+
+static bool microvm_machine_get_isa_serial(Object *obj, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    return mms->isa_serial;
+}
+
+static void microvm_machine_set_isa_serial(Object *obj, bool value,
+                                           Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    mms->isa_serial =3D value;
+}
+
+static bool microvm_machine_get_option_roms(Object *obj, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    return mms->option_roms;
+}
+
+static void microvm_machine_set_option_roms(Object *obj, bool value,
+                                            Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    mms->option_roms =3D value;
+}
+
+static bool microvm_machine_get_auto_kernel_cmdline(Object *obj, Error *=
*errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    return mms->auto_kernel_cmdline;
+}
+
+static void microvm_machine_set_auto_kernel_cmdline(Object *obj, bool va=
lue,
+                                                    Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    mms->auto_kernel_cmdline =3D value;
+}
+
+static void microvm_machine_initfn(Object *obj)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    /* Configuration */
+    mms->pic =3D ON_OFF_AUTO_AUTO;
+    mms->pit =3D ON_OFF_AUTO_AUTO;
+    mms->rtc =3D ON_OFF_AUTO_AUTO;
+    mms->isa_serial =3D true;
+    mms->option_roms =3D true;
+    mms->auto_kernel_cmdline =3D true;
+
+    /* State */
+    mms->kernel_cmdline_fixed =3D false;
+}
+
+static void microvm_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    mc->init =3D microvm_machine_state_init;
+
+    mc->family =3D "microvm_i386";
+    mc->desc =3D "Microvm (i386)";
+    mc->units_per_default_bus =3D 1;
+    mc->no_floppy =3D 1;
+    mc->max_cpus =3D 288;
+    mc->has_hotpluggable_cpus =3D false;
+    mc->auto_enable_numa_with_memhp =3D false;
+    mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
+    mc->nvdimm_supported =3D false;
+
+    /* Avoid relying too much on kernel components */
+    mc->default_kernel_irqchip_split =3D true;
+
+    /* Machine class handlers */
+    mc->reset =3D microvm_machine_reset;
+
+    object_class_property_add(oc, MICROVM_MACHINE_PIC, "OnOffAuto",
+                              microvm_machine_get_pic,
+                              microvm_machine_set_pic,
+                              NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, MICROVM_MACHINE_PIC,
+        "Enable i8259 PIC", &error_abort);
+
+    object_class_property_add(oc, MICROVM_MACHINE_PIT, "OnOffAuto",
+                              microvm_machine_get_pit,
+                              microvm_machine_set_pit,
+                              NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, MICROVM_MACHINE_PIT,
+        "Enable i8254 PIT", &error_abort);
+
+    object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
+                              microvm_machine_get_rtc,
+                              microvm_machine_set_rtc,
+                              NULL, NULL, &error_abort);
+    object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
+        "Enable MC146818 RTC", &error_abort);
+
+    object_class_property_add_bool(oc, MICROVM_MACHINE_ISA_SERIAL,
+                                   microvm_machine_get_isa_serial,
+                                   microvm_machine_set_isa_serial,
+                                   &error_abort);
+    object_class_property_set_description(oc, MICROVM_MACHINE_ISA_SERIAL=
,
+        "Set off to disable the instantiation an ISA serial port",
+        &error_abort);
+
+    object_class_property_add_bool(oc, MICROVM_MACHINE_OPTION_ROMS,
+                                   microvm_machine_get_option_roms,
+                                   microvm_machine_set_option_roms,
+                                   &error_abort);
+    object_class_property_set_description(oc, MICROVM_MACHINE_OPTION_ROM=
S,
+        "Set off to disable loading option ROMs", &error_abort);
+
+    object_class_property_add_bool(oc, MICROVM_MACHINE_AUTO_KERNEL_CMDLI=
NE,
+                                   microvm_machine_get_auto_kernel_cmdli=
ne,
+                                   microvm_machine_set_auto_kernel_cmdli=
ne,
+                                   &error_abort);
+    object_class_property_set_description(oc,
+        MICROVM_MACHINE_AUTO_KERNEL_CMDLINE,
+        "Set off to disable adding virtio-mmio devices to the kernel cmd=
line",
+        &error_abort);
+}
+
+static const TypeInfo microvm_machine_info =3D {
+    .name          =3D TYPE_MICROVM_MACHINE,
+    .parent        =3D TYPE_X86_MACHINE,
+    .instance_size =3D sizeof(MicrovmMachineState),
+    .instance_init =3D microvm_machine_initfn,
+    .class_size    =3D sizeof(MicrovmMachineClass),
+    .class_init    =3D microvm_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+         { }
+    },
+};
+
+static void microvm_machine_init(void)
+{
+    type_register_static(&microvm_machine_info);
+}
+type_init(microvm_machine_init);
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index c5c9d4900e..d399dcba52 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -92,6 +92,10 @@ config Q35
     select SMBIOS
     select FW_CFG_DMA
=20
+config MICROVM
+    bool
+    select VIRTIO_MMIO
+
 config VTD
     bool
=20
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 7ed80a4853..0d195b5210 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -4,6 +4,7 @@ obj-y +=3D x86.o
 obj-y +=3D pc.o
 obj-$(CONFIG_I440FX) +=3D pc_piix.o
 obj-$(CONFIG_Q35) +=3D pc_q35.o
+obj-$(CONFIG_MICROVM) +=3D microvm.o
 obj-y +=3D fw_cfg.o pc_sysfw.o
 obj-y +=3D x86-iommu.o
 obj-$(CONFIG_VTD) +=3D intel_iommu.o
--=20
2.21.0


