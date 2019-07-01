Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE62CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 649DD206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649DD206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhy4c-0005tj-Lc
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hhxb0-000122-4g
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hhxaw-0006CJ-0q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:47:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hhxat-00064S-PR
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:47:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA76B316291C;
 Mon,  1 Jul 2019 14:47:45 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCECFBA4D;
 Mon,  1 Jul 2019 14:47:38 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, maran.wilson@oracle.com
Date: Mon,  1 Jul 2019 16:47:05 +0200
Message-Id: <20190701144705.102615-5-slp@redhat.com>
In-Reply-To: <20190701144705.102615-1-slp@redhat.com>
References: <20190701144705.102615-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 01 Jul 2019 14:47:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm machine
 type
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
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Microvm is a machine type inspired by both NEMU and Firecracker, and
constructed after the machine model implemented by the latter.

It's main purpose is providing users a KVM-only machine type with fast
boot times, minimal attack surface (measured as the number of IO ports
and MMIO regions exposed to the Guest) and small footprint (specially
when combined with the ongoing QEMU modularization effort).

Normally, other than the device support provided by KVM itself,
microvm only supports virtio-mmio devices. Microvm also includes a
legacy mode, which adds an ISA bus with a 16550A serial port, useful
for being able to see the early boot kernel messages.

Microvm only supports booting PVH-enabled Linux ELF images. Booting
other PVH-enabled kernels may be possible, but due to the lack of ACPI
and firmware, we're relying on the command line for specifying the
location of the virtio-mmio transports. If there's an interest on
using this machine type with other kernels, we'll try to find some
kind of middle ground solution.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 default-configs/i386-softmmu.mak |   1 +
 hw/i386/Kconfig                  |   4 +
 hw/i386/Makefile.objs            |   1 +
 hw/i386/microvm.c                | 500 +++++++++++++++++++++++++++++++
 include/hw/i386/microvm.h        |  77 +++++
 5 files changed, 583 insertions(+)
 create mode 100644 hw/i386/microvm.c
 create mode 100644 include/hw/i386/microvm.h

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index cd5ea391e8..338f07420f 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -26,3 +26,4 @@ CONFIG_ISAPC=3Dy
 CONFIG_I440FX=3Dy
 CONFIG_Q35=3Dy
 CONFIG_ACPI_PCI=3Dy
+CONFIG_MICROVM=3Dy
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 9817888216..94c565d8db 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -87,6 +87,10 @@ config Q35
     select VMMOUSE
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
index c5f20bbd72..7bffca413e 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -4,6 +4,7 @@ obj-y +=3D pvh.o
 obj-y +=3D pc.o
 obj-$(CONFIG_I440FX) +=3D pc_piix.o
 obj-$(CONFIG_Q35) +=3D pc_q35.o
+obj-$(CONFIG_MICROVM) +=3D mptable.o microvm.o
 obj-y +=3D fw_cfg.o pc_sysfw.o
 obj-y +=3D x86-iommu.o
 obj-$(CONFIG_VTD) +=3D intel_iommu.o
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
new file mode 100644
index 0000000000..8b5efe9e45
--- /dev/null
+++ b/hw/i386/microvm.c
@@ -0,0 +1,500 @@
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
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/cpus.h"
+#include "sysemu/numa.h"
+
+#include "hw/loader.h"
+#include "hw/nmi.h"
+#include "hw/kvm/clock.h"
+#include "hw/i386/microvm.h"
+#include "hw/i386/pc.h"
+#include "target/i386/cpu.h"
+#include "hw/timer/i8254.h"
+#include "hw/char/serial.h"
+#include "hw/i386/topology.h"
+#include "hw/virtio/virtio-mmio.h"
+#include "hw/i386/mptable.h"
+
+#include "cpu.h"
+#include "elf.h"
+#include "pvh.h"
+#include "kvm_i386.h"
+#include "hw/xen/start_info.h"
+
+static void microvm_gsi_handler(void *opaque, int n, int level)
+{
+    qemu_irq *ioapic_irq =3D opaque;
+
+    qemu_set_irq(ioapic_irq[n], level);
+}
+
+static void microvm_legacy_init(MicrovmMachineState *mms)
+{
+    ISABus *isa_bus;
+    GSIState *gsi_state;
+    qemu_irq *i8259;
+    int i;
+
+    assert(kvm_irqchip_in_kernel());
+    gsi_state =3D g_malloc0(sizeof(*gsi_state));
+    mms->gsi =3D qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS=
);
+
+    isa_bus =3D isa_bus_new(NULL, get_system_memory(), get_system_io(),
+                          &error_abort);
+    isa_bus_irqs(isa_bus, mms->gsi);
+
+    assert(kvm_pic_in_kernel());
+    i8259 =3D kvm_i8259_init(isa_bus);
+
+    for (i =3D 0; i < ISA_NUM_IRQS; i++) {
+        gsi_state->i8259_irq[i] =3D i8259[i];
+    }
+
+    kvm_pit_init(isa_bus, 0x40);
+
+    for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
+        int nirq =3D VIRTIO_IRQ_BASE + i;
+        ISADevice *isadev =3D isa_create(isa_bus, TYPE_ISA_SERIAL);
+        qemu_irq mmio_irq;
+
+        isa_init_irq(isadev, &mmio_irq, nirq);
+        sysbus_create_simple("virtio-mmio",
+                             VIRTIO_MMIO_BASE + i * 512,
+                             mms->gsi[VIRTIO_IRQ_BASE + i]);
+    }
+
+    g_free(i8259);
+
+    serial_hds_isa_init(isa_bus, 0, 1);
+}
+
+static void microvm_ioapic_init(MicrovmMachineState *mms)
+{
+    qemu_irq *ioapic_irq;
+    DeviceState *ioapic_dev;
+    SysBusDevice *d;
+    int i;
+
+    assert(kvm_irqchip_in_kernel());
+    ioapic_irq =3D g_new0(qemu_irq, IOAPIC_NUM_PINS);
+    kvm_pc_setup_irq_routing(true);
+
+    assert(kvm_ioapic_in_kernel());
+    ioapic_dev =3D qdev_create(NULL, "kvm-ioapic");
+
+    object_property_add_child(qdev_get_machine(),
+                              "ioapic", OBJECT(ioapic_dev), NULL);
+
+    qdev_init_nofail(ioapic_dev);
+    d =3D SYS_BUS_DEVICE(ioapic_dev);
+    sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
+
+    for (i =3D 0; i < IOAPIC_NUM_PINS; i++) {
+        ioapic_irq[i] =3D qdev_get_gpio_in(ioapic_dev, i);
+    }
+
+    mms->gsi =3D qemu_allocate_irqs(microvm_gsi_handler,
+                                  ioapic_irq, IOAPIC_NUM_PINS);
+
+    for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
+        sysbus_create_simple("virtio-mmio",
+                             VIRTIO_MMIO_BASE + i * 512,
+                             mms->gsi[VIRTIO_IRQ_BASE + i]);
+    }
+}
+
+static void microvm_memory_init(MicrovmMachineState *mms)
+{
+    MachineState *machine =3D MACHINE(mms);
+    MemoryRegion *ram, *ram_below_4g, *ram_above_4g;
+    MemoryRegion *system_memory =3D get_system_memory();
+
+    if (machine->ram_size > MICROVM_MAX_BELOW_4G) {
+        mms->above_4g_mem_size =3D machine->ram_size - MICROVM_MAX_BELOW=
_4G;
+        mms->below_4g_mem_size =3D MICROVM_MAX_BELOW_4G;
+    } else {
+        mms->above_4g_mem_size =3D 0;
+        mms->below_4g_mem_size =3D machine->ram_size;
+    }
+
+    ram =3D g_malloc(sizeof(*ram));
+    memory_region_allocate_system_memory(ram, NULL, "microvm.ram",
+                                         machine->ram_size);
+
+    ram_below_4g =3D g_malloc(sizeof(*ram_below_4g));
+    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
+                             0, mms->below_4g_mem_size);
+    memory_region_add_subregion(system_memory, 0, ram_below_4g);
+
+    e820_add_entry(0, mms->below_4g_mem_size, E820_RAM);
+
+    if (mms->above_4g_mem_size > 0) {
+        ram_above_4g =3D g_malloc(sizeof(*ram_above_4g));
+        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram=
,
+                                 mms->below_4g_mem_size,
+                                 mms->above_4g_mem_size);
+        memory_region_add_subregion(system_memory, 0x100000000ULL,
+                                    ram_above_4g);
+        e820_add_entry(0x100000000ULL, mms->above_4g_mem_size, E820_RAM)=
;
+    }
+}
+
+static void microvm_cpus_init(const char *typename, Error **errp)
+{
+    int i;
+
+    for (i =3D 0; i < smp_cpus; i++) {
+        Object *cpu =3D NULL;
+        Error *local_err =3D NULL;
+
+        cpu =3D object_new(typename);
+
+        object_property_set_uint(cpu, i, "apic-id", &local_err);
+        object_property_set_bool(cpu, true, "realized", &local_err);
+
+        object_unref(cpu);
+        error_propagate(errp, local_err);
+    }
+}
+
+static void microvm_machine_state_init(MachineState *machine)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
+    Error *local_err =3D NULL;
+
+    if (machine->kernel_filename =3D=3D NULL) {
+        error_report("missing kernel image file name, required by microv=
m");
+        exit(1);
+    }
+
+    microvm_memory_init(mms);
+
+    microvm_cpus_init(machine->cpu_type, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        exit(1);
+    }
+
+    if (mms->legacy) {
+        microvm_legacy_init(mms);
+    } else {
+        microvm_ioapic_init(mms);
+    }
+
+    kvmclock_create();
+
+    if (!pvh_load_elfboot(machine->kernel_filename, NULL, NULL)) {
+        error_report("Error while loading elf kernel");
+        exit(1);
+    }
+
+    mms->elf_entry =3D pvh_get_start_addr();
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
+static void microvm_setup_pvh(MicrovmMachineState *mms,
+                              const gchar *kernel_cmdline)
+{
+    struct hvm_memmap_table_entry *memmap_table;
+    struct hvm_start_info *start_info;
+    BusState *bus;
+    BusChild *kid;
+    gchar *cmdline;
+    int cmdline_len;
+    int memmap_entries;
+    int i;
+
+    cmdline =3D g_strdup(kernel_cmdline);
+
+    /*
+     * Find MMIO transports with attached devices, and add them to the k=
ernel
+     * command line.
+     */
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
+    cmdline_len =3D strlen(cmdline);
+
+    address_space_write(&address_space_memory,
+                        KERNEL_CMDLINE_START, MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *) cmdline, cmdline_len);
+
+    g_free(cmdline);
+
+    memmap_entries =3D e820_get_num_entries();
+    memmap_table =3D g_new0(struct hvm_memmap_table_entry, memmap_entrie=
s);
+    for (i =3D 0; i < memmap_entries; i++) {
+        uint64_t address, length;
+        struct hvm_memmap_table_entry *entry =3D &memmap_table[i];
+
+        if (e820_get_entry(i, E820_RAM, &address, &length)) {
+            entry->addr =3D address;
+            entry->size =3D length;
+            entry->type =3D E820_RAM;
+            entry->reserved =3D 0;
+        }
+    }
+
+    address_space_write(&address_space_memory,
+                        MEMMAP_START, MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *) memmap_table,
+                        memmap_entries * sizeof(struct hvm_memmap_table_=
entry));
+
+    g_free(memmap_table);
+
+    start_info =3D g_malloc0(sizeof(struct hvm_start_info));
+
+    start_info->magic =3D XEN_HVM_START_MAGIC_VALUE;
+    start_info->version =3D 1;
+    start_info->nr_modules =3D 0;
+    start_info->cmdline_paddr =3D KERNEL_CMDLINE_START;
+    start_info->memmap_entries =3D memmap_entries;
+    start_info->memmap_paddr =3D MEMMAP_START;
+
+    address_space_write(&address_space_memory,
+                        PVH_START_INFO, MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *) start_info,
+                        sizeof(struct hvm_start_info));
+
+    g_free(start_info);
+}
+
+static void microvm_init_page_tables(void)
+{
+    uint64_t val =3D 0;
+    int i;
+
+    val =3D PDPTE_START | 0x03;
+    address_space_write(&address_space_memory,
+                        PML4_START, MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *) &val, 8);
+    val =3D PDE_START | 0x03;
+    address_space_write(&address_space_memory,
+                        PDPTE_START, MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *) &val, 8);
+
+    for (i =3D 0; i < 512; i++) {
+        val =3D (i << 21) + 0x83;
+        address_space_write(&address_space_memory,
+                            PDE_START + (i * 8), MEMTXATTRS_UNSPECIFIED,
+                            (uint8_t *) &val, 8);
+    }
+}
+
+static void microvm_cpu_reset(CPUState *cs, uint64_t elf_entry)
+{
+    X86CPU *cpu =3D X86_CPU(cs);
+    CPUX86State *env =3D &cpu->env;
+    struct SegmentCache seg_code =3D { .selector =3D 0x8,
+                                     .base =3D 0x0,
+                                     .limit =3D 0xffffffff,
+                                     .flags =3D 0xc09b00 };
+    struct SegmentCache seg_data =3D { .selector =3D 0x10,
+                                     .base =3D 0x0,
+                                     .limit =3D 0xffffffff,
+                                     .flags =3D 0xc09300 };
+    struct SegmentCache seg_tr =3D { .selector =3D 0x18,
+                                   .base =3D 0x0,
+                                   .limit =3D 0xffff,
+                                   .flags =3D 0x8b00 };
+
+    memcpy(&env->segs[R_CS], &seg_code, sizeof(struct SegmentCache));
+    memcpy(&env->segs[R_DS], &seg_data, sizeof(struct SegmentCache));
+    memcpy(&env->segs[R_ES], &seg_data, sizeof(struct SegmentCache));
+    memcpy(&env->segs[R_FS], &seg_data, sizeof(struct SegmentCache));
+    memcpy(&env->segs[R_GS], &seg_data, sizeof(struct SegmentCache));
+    memcpy(&env->segs[R_SS], &seg_data, sizeof(struct SegmentCache));
+    memcpy(&env->tr, &seg_tr, sizeof(struct SegmentCache));
+
+    env->regs[R_EBX] =3D PVH_START_INFO;
+
+    cpu_set_pc(cs, elf_entry);
+    cpu_x86_update_cr3(env, 0);
+    cpu_x86_update_cr4(env, 0);
+    cpu_x86_update_cr0(env, CR0_PE_MASK);
+
+    x86_update_hflags(env);
+}
+
+static void microvm_mptable_setup(MicrovmMachineState *mms)
+{
+    char *mptable;
+    int size;
+
+    mptable =3D mptable_generate(smp_cpus, EBDA_START, &size);
+    address_space_write(&address_space_memory,
+                        EBDA_START, MEMTXATTRS_UNSPECIFIED,
+                        (uint8_t *) mptable, size);
+    g_free(mptable);
+}
+
+static bool microvm_machine_get_legacy(Object *obj, Error **errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    return mms->legacy;
+}
+
+static void microvm_machine_set_legacy(Object *obj, bool value, Error **=
errp)
+{
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(obj);
+
+    mms->legacy =3D value;
+}
+
+static void microvm_machine_reset(void)
+{
+    MachineState *machine =3D MACHINE(qdev_get_machine());
+    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
+    CPUState *cs;
+    X86CPU *cpu;
+
+    qemu_devices_reset();
+
+    microvm_mptable_setup(mms);
+    microvm_setup_pvh(mms, machine->kernel_cmdline);
+    microvm_init_page_tables();
+
+    CPU_FOREACH(cs) {
+        cpu =3D X86_CPU(cs);
+
+        if (cpu->apic_state) {
+            device_reset(cpu->apic_state);
+        }
+
+        microvm_cpu_reset(cs, mms->elf_entry);
+    }
+}
+
+static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        X86CPU *cpu =3D X86_CPU(cs);
+
+        if (!cpu->apic_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
+        } else {
+            apic_deliver_nmi(cpu->apic_state);
+        }
+    }
+}
+
+static void microvm_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    NMIClass *nc =3D NMI_CLASS(oc);
+
+    mc->init =3D microvm_machine_state_init;
+
+    mc->family =3D "microvm_i386";
+    mc->desc =3D "Microvm (i386)";
+    mc->units_per_default_bus =3D 1;
+    mc->no_floppy =3D 1;
+    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugcon");
+    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugexit");
+    mc->max_cpus =3D 288;
+    mc->has_hotpluggable_cpus =3D false;
+    mc->auto_enable_numa_with_memhp =3D false;
+    mc->default_cpu_type =3D X86_CPU_TYPE_NAME("host");
+    mc->nvdimm_supported =3D false;
+    mc->default_machine_opts =3D "accel=3Dkvm";
+
+    /* Machine class handlers */
+    mc->reset =3D microvm_machine_reset;
+
+    /* NMI handler */
+    nc->nmi_monitor_handler =3D x86_nmi;
+
+    object_class_property_add_bool(oc, MICROVM_MACHINE_LEGACY,
+                                   microvm_machine_get_legacy,
+                                   microvm_machine_set_legacy,
+                                   &error_abort);
+}
+
+static const TypeInfo microvm_machine_info =3D {
+    .name          =3D TYPE_MICROVM_MACHINE,
+    .parent        =3D TYPE_MACHINE,
+    .instance_size =3D sizeof(MicrovmMachineState),
+    .class_size    =3D sizeof(MicrovmMachineClass),
+    .class_init    =3D microvm_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+         { TYPE_NMI },
+         { }
+    },
+};
+
+static void microvm_machine_init(void)
+{
+    type_register_static(&microvm_machine_info);
+}
+type_init(microvm_machine_init);
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
new file mode 100644
index 0000000000..72c89db669
--- /dev/null
+++ b/include/hw/i386/microvm.h
@@ -0,0 +1,77 @@
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
+
+/* Microvm memory layout */
+#define PVH_START_INFO        0x6000
+#define MEMMAP_START          0x7000
+#define BOOT_STACK_POINTER    0x8ff0
+#define PML4_START            0x9000
+#define PDPTE_START           0xa000
+#define PDE_START             0xb000
+#define KERNEL_CMDLINE_START  0x20000
+#define EBDA_START            0x9fc00
+#define HIMEM_START           0x100000
+#define MICROVM_MAX_BELOW_4G  0xe0000000
+
+/* Platform virtio definitions */
+#define VIRTIO_MMIO_BASE      0xd0000000
+#define VIRTIO_IRQ_BASE       5
+#define VIRTIO_NUM_TRANSPORTS 8
+#define VIRTIO_CMDLINE_MAXLEN 64
+
+/* Machine type options */
+#define MICROVM_MACHINE_LEGACY "legacy"
+
+typedef struct {
+    MachineClass parent;
+    HotplugHandler *(*orig_hotplug_handler)(MachineState *machine,
+                                           DeviceState *dev);
+} MicrovmMachineClass;
+
+typedef struct {
+    MachineState parent;
+    qemu_irq *gsi;
+
+    /* RAM size */
+    ram_addr_t below_4g_mem_size;
+    ram_addr_t above_4g_mem_size;
+
+    /* Kernel ELF entry. On reset, vCPUs RIP will be set to this */
+    uint64_t elf_entry;
+
+    /* Legacy mode based on an ISA bus. Useful for debugging */
+    bool legacy;
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
--=20
2.21.0


