Received: from eggs.gnu.org ([2001:4830:134:3::10]:51760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTN-0007eD-Kr
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTJ-0003Gy-Qb
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:37 -0500
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:34179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNTJ-0003Fz-IZ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:47:33 -0500
Received: by mail-qk0-x22d.google.com with SMTP id m193so4290966qke.1
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:47:33 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:53 -0300
Message-Id: <20180108024558.17983-25-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 24/29] hw/i386: extract i440fx code from piix.c
 into i440fx.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/pci-host/i440fx.c               | 543 +++++++++++++++++++++++++++++++++++++
 hw/pci-host/piix.c                 | 522 +----------------------------------
 MAINTAINERS                        |   1 +
 hw/pci-host/Makefile.objs          |   1 +
 6 files changed, 552 insertions(+), 517 deletions(-)
 create mode 100644 hw/pci-host/i440fx.c

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 95ac4b464a..c7e4af01a5 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -38,6 +38,7 @@ CONFIG_I8259=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_TPM_TIS=$(CONFIG_TPM)
 CONFIG_MC146818RTC=y
+CONFIG_PCI_I440FX=y
 CONFIG_PCI_PIIX=y
 CONFIG_WDT_IB700=y
 CONFIG_ISA_DEBUG=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 0221236825..926997fe60 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -38,6 +38,7 @@ CONFIG_I8259=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_TPM_TIS=$(CONFIG_TPM)
 CONFIG_MC146818RTC=y
+CONFIG_PCI_I440FX=y
 CONFIG_PCI_PIIX=y
 CONFIG_WDT_IB700=y
 CONFIG_ISA_DEBUG=y
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
new file mode 100644
index 0000000000..76968f8fbf
--- /dev/null
+++ b/hw/pci-host/i440fx.c
@@ -0,0 +1,543 @@
+/*
+ * QEMU i440FX North Bridge Emulation
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/hw.h"
+#include "hw/i386/pc.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci-host/pam.h"
+#include "hw/pci-host/i440fx.h"
+#include "hw/southbridge/i82371_piix.h"
+
+/*
+ * I440FX chipset data sheet.
+ * http://download.intel.com/design/chipsets/datashts/29054901.pdf
+ */
+
+#define I440FX_PCI_HOST_BRIDGE(obj) \
+    OBJECT_CHECK(I440FXState, (obj), TYPE_I440FX_PCI_HOST_BRIDGE)
+
+typedef struct I440FXState {
+    PCIHostState parent_obj;
+    Range pci_hole;
+    uint64_t pci_hole64_size;
+    bool pci_hole64_fix;
+    uint32_t short_root_bus;
+} I440FXState;
+
+#define I440FX_PCI_DEVICE(obj) \
+    OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
+
+struct PCII440FXState {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion *system_memory;
+    MemoryRegion *pci_address_space;
+    MemoryRegion *ram_memory;
+    PAMMemoryRegion pam_regions[13];
+    MemoryRegion smram_region;
+    MemoryRegion smram, low_smram;
+};
+
+
+#define I440FX_PAM      0x59
+#define I440FX_PAM_SIZE 7
+#define I440FX_SMRAM    0x72
+
+/* Keep it 2G to comply with older win32 guests */
+#define I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 31)
+
+/* Older coreboot versions (4.0 and older) read a config register that doesn't
+ * exist in real hardware, to get the RAM size from QEMU.
+ */
+#define I440FX_COREBOOT_RAM_SIZE 0x57
+
+static void i440fx_update_memory_mappings(PCII440FXState *d)
+{
+    int i;
+    PCIDevice *pd = PCI_DEVICE(d);
+
+    memory_region_transaction_begin();
+    for (i = 0; i < 13; i++) {
+        pam_update(&d->pam_regions[i], i,
+                   pd->config[I440FX_PAM + (DIV_ROUND_UP(i, 2))]);
+    }
+    memory_region_set_enabled(&d->smram_region,
+                              !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN));
+    memory_region_set_enabled(&d->smram,
+                              pd->config[I440FX_SMRAM] & SMRAM_G_SMRAME);
+    memory_region_transaction_commit();
+}
+
+
+static void i440fx_write_config(PCIDevice *dev,
+                                uint32_t address, uint32_t val, int len)
+{
+    PCII440FXState *d = I440FX_PCI_DEVICE(dev);
+
+    /* XXX: implement SMRAM.D_LOCK */
+    pci_default_write_config(dev, address, val, len);
+    if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE) ||
+        range_covers_byte(address, len, I440FX_SMRAM)) {
+        i440fx_update_memory_mappings(d);
+    }
+}
+
+static int i440fx_load_old(QEMUFile *f, void *opaque, int version_id)
+{
+    PCII440FXState *d = opaque;
+    PCIDevice *pd = PCI_DEVICE(d);
+    int ret, i;
+    uint8_t smm_enabled;
+
+    ret = pci_device_load(pd, f);
+    if (ret < 0) {
+        return ret;
+    }
+    i440fx_update_memory_mappings(d);
+    qemu_get_8s(f, &smm_enabled);
+
+    if (version_id == 2) {
+        for (i = 0; i < PIIX_NUM_PIRQS; i++) {
+            qemu_get_be32(f); /* dummy load for compatibility */
+        }
+    }
+
+    return 0;
+}
+
+static int i440fx_post_load(void *opaque, int version_id)
+{
+    PCII440FXState *d = opaque;
+
+    i440fx_update_memory_mappings(d);
+    return 0;
+}
+
+static const VMStateDescription vmstate_i440fx = {
+    .name = "I440FX",
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .minimum_version_id_old = 1,
+    .load_state_old = i440fx_load_old,
+    .post_load = i440fx_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState),
+        /* Used to be smm_enabled, which was basically always zero because
+         * SeaBIOS hardly uses SMM.  SMRAM is now handled by CPU code.
+         */
+        VMSTATE_UNUSED(1),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
+                                              const char *name, void *opaque,
+                                              Error **errp)
+{
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
+    uint64_t val64;
+    uint32_t value;
+
+    val64 = range_is_empty(&s->pci_hole) ? 0 : range_lob(&s->pci_hole);
+    value = val64;
+    assert(value == val64);
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void i440fx_pcihost_get_pci_hole_end(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
+    uint64_t val64;
+    uint32_t value;
+
+    val64 = range_is_empty(&s->pci_hole) ? 0 : range_upb(&s->pci_hole) + 1;
+    value = val64;
+    assert(value == val64);
+    visit_type_uint32(v, name, &value, errp);
+}
+
+/*
+ * The 64bit PCI hole start is set by the Guest firmware
+ * as the address of the first 64bit PCI MEM resource.
+ * If no PCI device has resources on the 64bit area,
+ * the 64bit PCI hole will start after "over 4G RAM" and the
+ * reserved space for memory hotplug if any.
+ */
+static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
+                                                const char *name,
+                                                void *opaque, Error **errp)
+{
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
+    Range w64;
+    uint64_t value;
+
+    pci_bus_get_w64_range(h->bus, &w64);
+    value = range_is_empty(&w64) ? 0 : range_lob(&w64);
+    if (!value && s->pci_hole64_fix) {
+        value = pc_pci_hole64_start();
+    }
+    visit_type_uint64(v, name, &value, errp);
+}
+
+/*
+ * The 64bit PCI hole end is set by the Guest firmware
+ * as the address of the last 64bit PCI MEM resource.
+ * Then it is expanded to the PCI_HOST_PROP_PCI_HOLE64_SIZE
+ * that can be configured by the user.
+ */
+static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
+                                              const char *name, void *opaque,
+                                              Error **errp)
+{
+    PCIHostState *h = PCI_HOST_BRIDGE(obj);
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
+    uint64_t hole64_start = pc_pci_hole64_start();
+    Range w64;
+    uint64_t value, hole64_end;
+
+    pci_bus_get_w64_range(h->bus, &w64);
+    value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
+    hole64_end = ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 30);
+    if (s->pci_hole64_fix && value < hole64_end) {
+        value = hole64_end;
+    }
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void i440fx_pcihost_initfn(Object *obj)
+{
+    PCIHostState *s = PCI_HOST_BRIDGE(obj);
+
+    memory_region_init_io(&s->conf_mem, obj, &pci_host_conf_le_ops, s,
+                          "pci-conf-idx", 4);
+    memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
+                          "pci-conf-data", 4);
+
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
+                        i440fx_pcihost_get_pci_hole_start,
+                        NULL, NULL, NULL, NULL);
+
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
+                        i440fx_pcihost_get_pci_hole_end,
+                        NULL, NULL, NULL, NULL);
+
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
+                        i440fx_pcihost_get_pci_hole64_start,
+                        NULL, NULL, NULL, NULL);
+
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
+                        i440fx_pcihost_get_pci_hole64_end,
+                        NULL, NULL, NULL, NULL);
+}
+
+static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
+{
+    PCIHostState *s = PCI_HOST_BRIDGE(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    sysbus_add_io(sbd, 0xcf8, &s->conf_mem);
+    sysbus_init_ioports(sbd, 0xcf8, 4);
+
+    sysbus_add_io(sbd, 0xcfc, &s->data_mem);
+    sysbus_init_ioports(sbd, 0xcfc, 4);
+}
+
+static void i440fx_realize(PCIDevice *dev, Error **errp)
+{
+    dev->config[I440FX_SMRAM] = 0x02;
+
+    if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
+        warn_report("i440fx doesn't support emulated iommu");
+    }
+}
+
+PCIBus *i440fx_init(const char *host_type, const char *pci_type,
+                    PCII440FXState **pi440fx_state,
+                    int *piix3_devfn,
+                    ISABus **isa_bus, qemu_irq *pic,
+                    MemoryRegion *address_space_mem,
+                    MemoryRegion *address_space_io,
+                    ram_addr_t ram_size,
+                    ram_addr_t below_4g_mem_size,
+                    ram_addr_t above_4g_mem_size,
+                    MemoryRegion *pci_address_space,
+                    MemoryRegion *ram_memory)
+{
+    DeviceState *dev;
+    PCIBus *b;
+    PCIDevice *d;
+    PCIHostState *s;
+    PCII440FXState *f;
+    unsigned i;
+    I440FXState *i440fx;
+
+    dev = qdev_create(NULL, host_type);
+    s = PCI_HOST_BRIDGE(dev);
+    b = pci_bus_new(dev, NULL, pci_address_space,
+                    address_space_io, 0, TYPE_PCI_BUS);
+    s->bus = b;
+    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
+
+    d = pci_create_simple(b, 0, pci_type);
+    *pi440fx_state = I440FX_PCI_DEVICE(d);
+    f = *pi440fx_state;
+    f->system_memory = address_space_mem;
+    f->pci_address_space = pci_address_space;
+    f->ram_memory = ram_memory;
+
+    i440fx = I440FX_PCI_HOST_BRIDGE(dev);
+    range_set_bounds(&i440fx->pci_hole, below_4g_mem_size,
+                     IO_APIC_DEFAULT_ADDRESS - 1);
+
+    /* setup pci memory mapping */
+    pc_pci_as_mapping_init(OBJECT(f), f->system_memory,
+                           f->pci_address_space);
+
+    /* if *disabled* show SMRAM to all CPUs */
+    memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
+                             f->pci_address_space, 0xa0000, 0x20000);
+    memory_region_add_subregion_overlap(f->system_memory, 0xa0000,
+                                        &f->smram_region, 1);
+    memory_region_set_enabled(&f->smram_region, true);
+
+    /* smram, as seen by SMM CPUs */
+    memory_region_init(&f->smram, OBJECT(d), "smram", 1ull << 32);
+    memory_region_set_enabled(&f->smram, true);
+    memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
+                             f->ram_memory, 0xa0000, 0x20000);
+    memory_region_set_enabled(&f->low_smram, true);
+    memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
+    object_property_add_const_link(qdev_get_machine(), "smram",
+                                   OBJECT(&f->smram), &error_abort);
+
+    init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
+             &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
+    for (i = 0; i < 12; ++i) {
+        init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
+                 &f->pam_regions[i + 1], PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE,
+                 PAM_EXPAN_SIZE);
+    }
+
+    piix3_init(b, isa_bus, pic, piix3_devfn);
+
+    ram_size = ram_size / 8 / 1024 / 1024;
+    if (ram_size > 255) {
+        ram_size = 255;
+    }
+    d->config[I440FX_COREBOOT_RAM_SIZE] = ram_size;
+
+    i440fx_update_memory_mappings(f);
+
+    return b;
+}
+
+PCIBus *find_i440fx(void)
+{
+    PCIHostState *s = OBJECT_CHECK(PCIHostState,
+                                   object_resolve_path("/machine/i440fx", NULL),
+                                   TYPE_PCI_HOST_BRIDGE);
+    return s ? s->bus : NULL;
+}
+
+static void i440fx_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = i440fx_realize;
+    k->config_write = i440fx_write_config;
+    k->vendor_id = PCI_VENDOR_ID_INTEL;
+    k->device_id = PCI_DEVICE_ID_INTEL_82441;
+    k->revision = 0x02;
+    k->class_id = PCI_CLASS_BRIDGE_HOST;
+    dc->desc = "Host bridge";
+    dc->vmsd = &vmstate_i440fx;
+    /*
+     * PCI-facing part of the host bridge, not usable without the
+     * host-facing part, which can't be device_add'ed, yet.
+     */
+    dc->user_creatable = false;
+    dc->hotpluggable   = false;
+}
+
+static const TypeInfo i440fx_info = {
+    .name          = TYPE_I440FX_PCI_DEVICE,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCII440FXState),
+    .class_init    = i440fx_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+/* IGD Passthrough Host Bridge. */
+typedef struct {
+    uint8_t offset;
+    uint8_t len;
+} IGDHostInfo;
+
+/* Here we just expose minimal host bridge offset subset. */
+static const IGDHostInfo igd_host_bridge_infos[] = {
+    {0x08, 2},  /* revision id */
+    {0x2c, 2},  /* sybsystem vendor id */
+    {0x2e, 2},  /* sybsystem id */
+    {0x50, 2},  /* SNB: processor graphics control register */
+    {0x52, 2},  /* processor graphics control register */
+    {0xa4, 4},  /* SNB: graphics base of stolen memory */
+    {0xa8, 4},  /* SNB: base of GTT stolen memory */
+};
+
+static int host_pci_config_read(int pos, int len, uint32_t *val)
+{
+    char path[PATH_MAX];
+    int config_fd;
+    ssize_t size = sizeof(path);
+    /* Access real host bridge. */
+    int rc = snprintf(path, size, "/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
+                      0, 0, 0, 0, "config");
+    int ret = 0;
+
+    if (rc >= size || rc < 0) {
+        return -ENODEV;
+    }
+
+    config_fd = open(path, O_RDWR);
+    if (config_fd < 0) {
+        return -ENODEV;
+    }
+
+    if (lseek(config_fd, pos, SEEK_SET) != pos) {
+        ret = -errno;
+        goto out;
+    }
+
+    do {
+        rc = read(config_fd, (uint8_t *)val, len);
+    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
+    if (rc != len) {
+        ret = -errno;
+    }
+
+out:
+    close(config_fd);
+    return ret;
+}
+
+static int igd_pt_i440fx_initfn(struct PCIDevice *pci_dev)
+{
+    uint32_t val = 0;
+    int rc, i, num;
+    int pos, len;
+
+    num = ARRAY_SIZE(igd_host_bridge_infos);
+    for (i = 0; i < num; i++) {
+        pos = igd_host_bridge_infos[i].offset;
+        len = igd_host_bridge_infos[i].len;
+        rc = host_pci_config_read(pos, len, &val);
+        if (rc) {
+            return -ENODEV;
+        }
+        pci_default_write_config(pci_dev, pos, val, len);
+    }
+
+    return 0;
+}
+
+static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->init = igd_pt_i440fx_initfn;
+    dc->desc = "IGD Passthrough Host bridge";
+}
+
+static const TypeInfo igd_passthrough_i440fx_info = {
+    .name          = TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE,
+    .parent        = TYPE_I440FX_PCI_DEVICE,
+    .instance_size = sizeof(PCII440FXState),
+    .class_init    = igd_passthrough_i440fx_class_init,
+};
+
+static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
+                                                PCIBus *rootbus)
+{
+    I440FXState *s = I440FX_PCI_HOST_BRIDGE(host_bridge);
+
+    /* For backwards compat with old device paths */
+    if (s->short_root_bus) {
+        return "0000";
+    }
+    return "0000:00";
+}
+
+static Property i440fx_props[] = {
+    DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
+                     pci_hole64_size, I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT),
+    DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
+    DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
+
+    hc->root_bus_path = i440fx_pcihost_root_bus_path;
+    dc->realize = i440fx_pcihost_realize;
+    dc->fw_name = "pci";
+    dc->props = i440fx_props;
+    /* Reason: needs to be wired up by pc_init1 */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo i440fx_pcihost_info = {
+    .name          = TYPE_I440FX_PCI_HOST_BRIDGE,
+    .parent        = TYPE_PCI_HOST_BRIDGE,
+    .instance_size = sizeof(I440FXState),
+    .instance_init = i440fx_pcihost_initfn,
+    .class_init    = i440fx_pcihost_class_init,
+};
+
+static void i440fx_register_types(void)
+{
+    type_register_static(&i440fx_info);
+    type_register_static(&igd_passthrough_i440fx_info);
+    type_register_static(&i440fx_pcihost_info);
+}
+
+type_init(i440fx_register_types)
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 6f963b5a07..df08d94a59 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -1,5 +1,5 @@
 /*
- * QEMU i440FX/PIIX3 PCI Bridge Emulation
+ * QEMU PIIX South Bridge Emulation
  *
  * Copyright (c) 2006 Fabrice Bellard
  *
@@ -23,38 +23,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
+#include "sysemu/sysemu.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
-#include "hw/pci/pci.h"
-#include "hw/pci/pci_host.h"
-#include "hw/pci-host/i440fx.h"
 #include "hw/southbridge/i82371_piix.h"
-#include "hw/isa/isa.h"
-#include "hw/sysbus.h"
-#include "qapi/error.h"
-#include "qemu/range.h"
 #include "hw/xen/xen.h"
-#include "hw/pci-host/pam.h"
-#include "sysemu/sysemu.h"
-#include "hw/i386/ioapic.h"
-#include "qapi/visitor.h"
-#include "qemu/error-report.h"
-
-/*
- * I440FX chipset data sheet.
- * http://download.intel.com/design/chipsets/datashts/29054901.pdf
- */
-
-#define I440FX_PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(I440FXState, (obj), TYPE_I440FX_PCI_HOST_BRIDGE)
-
-typedef struct I440FXState {
-    PCIHostState parent_obj;
-    Range pci_hole;
-    uint64_t pci_hole64_size;
-    bool pci_hole64_fix;
-    uint32_t short_root_bus;
-} I440FXState;
 
 #define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
 #define XEN_PIIX_NUM_PIRQS      128ULL
@@ -93,35 +66,6 @@ typedef struct PIIX3State {
 #define PIIX3_PCI_DEVICE(obj) \
     OBJECT_CHECK(PIIX3State, (obj), TYPE_PIIX3_PCI_DEVICE)
 
-#define I440FX_PCI_DEVICE(obj) \
-    OBJECT_CHECK(PCII440FXState, (obj), TYPE_I440FX_PCI_DEVICE)
-
-struct PCII440FXState {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion *system_memory;
-    MemoryRegion *pci_address_space;
-    MemoryRegion *ram_memory;
-    PAMMemoryRegion pam_regions[13];
-    MemoryRegion smram_region;
-    MemoryRegion smram, low_smram;
-};
-
-
-#define I440FX_PAM      0x59
-#define I440FX_PAM_SIZE 7
-#define I440FX_SMRAM    0x72
-
-/* Keep it 2G to comply with older win32 guests */
-#define I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 31)
-
-/* Older coreboot versions (4.0 and older) read a config register that doesn't
- * exist in real hardware, to get the RAM size from QEMU.
- */
-#define I440FX_COREBOOT_RAM_SIZE 0x57
-
 /* return the global irq number corresponding to a given device irq
    pin. We could also use the bus number to have a more precise
    mapping. */
@@ -132,297 +76,6 @@ static int pci_slot_get_pirq(PCIDevice *pci_dev, int pci_intx)
     return (pci_intx + slot_addend) & 3;
 }
 
-static void i440fx_update_memory_mappings(PCII440FXState *d)
-{
-    int i;
-    PCIDevice *pd = PCI_DEVICE(d);
-
-    memory_region_transaction_begin();
-    for (i = 0; i < 13; i++) {
-        pam_update(&d->pam_regions[i], i,
-                   pd->config[I440FX_PAM + (DIV_ROUND_UP(i, 2))]);
-    }
-    memory_region_set_enabled(&d->smram_region,
-                              !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN));
-    memory_region_set_enabled(&d->smram,
-                              pd->config[I440FX_SMRAM] & SMRAM_G_SMRAME);
-    memory_region_transaction_commit();
-}
-
-
-static void i440fx_write_config(PCIDevice *dev,
-                                uint32_t address, uint32_t val, int len)
-{
-    PCII440FXState *d = I440FX_PCI_DEVICE(dev);
-
-    /* XXX: implement SMRAM.D_LOCK */
-    pci_default_write_config(dev, address, val, len);
-    if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE) ||
-        range_covers_byte(address, len, I440FX_SMRAM)) {
-        i440fx_update_memory_mappings(d);
-    }
-}
-
-static int i440fx_load_old(QEMUFile* f, void *opaque, int version_id)
-{
-    PCII440FXState *d = opaque;
-    PCIDevice *pd = PCI_DEVICE(d);
-    int ret, i;
-    uint8_t smm_enabled;
-
-    ret = pci_device_load(pd, f);
-    if (ret < 0)
-        return ret;
-    i440fx_update_memory_mappings(d);
-    qemu_get_8s(f, &smm_enabled);
-
-    if (version_id == 2) {
-        for (i = 0; i < PIIX_NUM_PIRQS; i++) {
-            qemu_get_be32(f); /* dummy load for compatibility */
-        }
-    }
-
-    return 0;
-}
-
-static int i440fx_post_load(void *opaque, int version_id)
-{
-    PCII440FXState *d = opaque;
-
-    i440fx_update_memory_mappings(d);
-    return 0;
-}
-
-static const VMStateDescription vmstate_i440fx = {
-    .name = "I440FX",
-    .version_id = 3,
-    .minimum_version_id = 3,
-    .minimum_version_id_old = 1,
-    .load_state_old = i440fx_load_old,
-    .post_load = i440fx_post_load,
-    .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState),
-        /* Used to be smm_enabled, which was basically always zero because
-         * SeaBIOS hardly uses SMM.  SMRAM is now handled by CPU code.
-         */
-        VMSTATE_UNUSED(1),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
-                                              const char *name, void *opaque,
-                                              Error **errp)
-{
-    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
-    uint64_t val64;
-    uint32_t value;
-
-    val64 = range_is_empty(&s->pci_hole) ? 0 : range_lob(&s->pci_hole);
-    value = val64;
-    assert(value == val64);
-    visit_type_uint32(v, name, &value, errp);
-}
-
-static void i440fx_pcihost_get_pci_hole_end(Object *obj, Visitor *v,
-                                            const char *name, void *opaque,
-                                            Error **errp)
-{
-    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
-    uint64_t val64;
-    uint32_t value;
-
-    val64 = range_is_empty(&s->pci_hole) ? 0 : range_upb(&s->pci_hole) + 1;
-    value = val64;
-    assert(value == val64);
-    visit_type_uint32(v, name, &value, errp);
-}
-
-/*
- * The 64bit PCI hole start is set by the Guest firmware
- * as the address of the first 64bit PCI MEM resource.
- * If no PCI device has resources on the 64bit area,
- * the 64bit PCI hole will start after "over 4G RAM" and the
- * reserved space for memory hotplug if any.
- */
-static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
-                                                const char *name,
-                                                void *opaque, Error **errp)
-{
-    PCIHostState *h = PCI_HOST_BRIDGE(obj);
-    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
-    Range w64;
-    uint64_t value;
-
-    pci_bus_get_w64_range(h->bus, &w64);
-    value = range_is_empty(&w64) ? 0 : range_lob(&w64);
-    if (!value && s->pci_hole64_fix) {
-        value = pc_pci_hole64_start();
-    }
-    visit_type_uint64(v, name, &value, errp);
-}
-
-/*
- * The 64bit PCI hole end is set by the Guest firmware
- * as the address of the last 64bit PCI MEM resource.
- * Then it is expanded to the PCI_HOST_PROP_PCI_HOLE64_SIZE
- * that can be configured by the user.
- */
-static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
-                                              const char *name, void *opaque,
-                                              Error **errp)
-{
-    PCIHostState *h = PCI_HOST_BRIDGE(obj);
-    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
-    uint64_t hole64_start = pc_pci_hole64_start();
-    Range w64;
-    uint64_t value, hole64_end;
-
-    pci_bus_get_w64_range(h->bus, &w64);
-    value = range_is_empty(&w64) ? 0 : range_upb(&w64) + 1;
-    hole64_end = ROUND_UP(hole64_start + s->pci_hole64_size, 1ULL << 30);
-    if (s->pci_hole64_fix && value < hole64_end) {
-        value = hole64_end;
-    }
-    visit_type_uint64(v, name, &value, errp);
-}
-
-static void i440fx_pcihost_initfn(Object *obj)
-{
-    PCIHostState *s = PCI_HOST_BRIDGE(obj);
-
-    memory_region_init_io(&s->conf_mem, obj, &pci_host_conf_le_ops, s,
-                          "pci-conf-idx", 4);
-    memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
-                          "pci-conf-data", 4);
-
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
-                        i440fx_pcihost_get_pci_hole_start,
-                        NULL, NULL, NULL, NULL);
-
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
-                        i440fx_pcihost_get_pci_hole_end,
-                        NULL, NULL, NULL, NULL);
-
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
-                        i440fx_pcihost_get_pci_hole64_start,
-                        NULL, NULL, NULL, NULL);
-
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
-                        i440fx_pcihost_get_pci_hole64_end,
-                        NULL, NULL, NULL, NULL);
-}
-
-static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
-{
-    PCIHostState *s = PCI_HOST_BRIDGE(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-
-    sysbus_add_io(sbd, 0xcf8, &s->conf_mem);
-    sysbus_init_ioports(sbd, 0xcf8, 4);
-
-    sysbus_add_io(sbd, 0xcfc, &s->data_mem);
-    sysbus_init_ioports(sbd, 0xcfc, 4);
-}
-
-static void i440fx_realize(PCIDevice *dev, Error **errp)
-{
-    dev->config[I440FX_SMRAM] = 0x02;
-
-    if (object_property_get_bool(qdev_get_machine(), "iommu", NULL)) {
-        warn_report("i440fx doesn't support emulated iommu");
-    }
-}
-
-PCIBus *i440fx_init(const char *host_type, const char *pci_type,
-                    PCII440FXState **pi440fx_state,
-                    int *piix3_devfn,
-                    ISABus **isa_bus, qemu_irq *pic,
-                    MemoryRegion *address_space_mem,
-                    MemoryRegion *address_space_io,
-                    ram_addr_t ram_size,
-                    ram_addr_t below_4g_mem_size,
-                    ram_addr_t above_4g_mem_size,
-                    MemoryRegion *pci_address_space,
-                    MemoryRegion *ram_memory)
-{
-    DeviceState *dev;
-    PCIBus *b;
-    PCIDevice *d;
-    PCIHostState *s;
-    PCII440FXState *f;
-    unsigned i;
-    I440FXState *i440fx;
-
-    dev = qdev_create(NULL, host_type);
-    s = PCI_HOST_BRIDGE(dev);
-    b = pci_bus_new(dev, NULL, pci_address_space,
-                    address_space_io, 0, TYPE_PCI_BUS);
-    s->bus = b;
-    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev), NULL);
-    qdev_init_nofail(dev);
-
-    d = pci_create_simple(b, 0, pci_type);
-    *pi440fx_state = I440FX_PCI_DEVICE(d);
-    f = *pi440fx_state;
-    f->system_memory = address_space_mem;
-    f->pci_address_space = pci_address_space;
-    f->ram_memory = ram_memory;
-
-    i440fx = I440FX_PCI_HOST_BRIDGE(dev);
-    range_set_bounds(&i440fx->pci_hole, below_4g_mem_size,
-                     IO_APIC_DEFAULT_ADDRESS - 1);
-
-    /* setup pci memory mapping */
-    pc_pci_as_mapping_init(OBJECT(f), f->system_memory,
-                           f->pci_address_space);
-
-    /* if *disabled* show SMRAM to all CPUs */
-    memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
-                             f->pci_address_space, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(f->system_memory, 0xa0000,
-                                        &f->smram_region, 1);
-    memory_region_set_enabled(&f->smram_region, true);
-
-    /* smram, as seen by SMM CPUs */
-    memory_region_init(&f->smram, OBJECT(d), "smram", 1ull << 32);
-    memory_region_set_enabled(&f->smram, true);
-    memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
-                             f->ram_memory, 0xa0000, 0x20000);
-    memory_region_set_enabled(&f->low_smram, true);
-    memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
-    object_property_add_const_link(qdev_get_machine(), "smram",
-                                   OBJECT(&f->smram), &error_abort);
-
-    init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
-             &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < 12; ++i) {
-        init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
-                 &f->pam_regions[i+1], PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE,
-                 PAM_EXPAN_SIZE);
-    }
-
-    piix3_init(b, isa_bus, pic, piix3_devfn);
-
-    ram_size = ram_size / 8 / 1024 / 1024;
-    if (ram_size > 255) {
-        ram_size = 255;
-    }
-    d->config[I440FX_COREBOOT_RAM_SIZE] = ram_size;
-
-    i440fx_update_memory_mappings(f);
-
-    return b;
-}
-
-PCIBus *find_i440fx(void)
-{
-    PCIHostState *s = OBJECT_CHECK(PCIHostState,
-                                   object_resolve_path("/machine/i440fx", NULL),
-                                   TYPE_PCI_HOST_BRIDGE);
-    return s ? s->bus : NULL;
-}
-
 /* PIIX3 PCI to ISA bridge */
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
@@ -761,176 +414,11 @@ static const TypeInfo piix3_xen_info = {
     .class_init    = piix3_xen_class_init,
 };
 
-static void i440fx_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = i440fx_realize;
-    k->config_write = i440fx_write_config;
-    k->vendor_id = PCI_VENDOR_ID_INTEL;
-    k->device_id = PCI_DEVICE_ID_INTEL_82441;
-    k->revision = 0x02;
-    k->class_id = PCI_CLASS_BRIDGE_HOST;
-    dc->desc = "Host bridge";
-    dc->vmsd = &vmstate_i440fx;
-    /*
-     * PCI-facing part of the host bridge, not usable without the
-     * host-facing part, which can't be device_add'ed, yet.
-     */
-    dc->user_creatable = false;
-    dc->hotpluggable   = false;
-}
-
-static const TypeInfo i440fx_info = {
-    .name          = TYPE_I440FX_PCI_DEVICE,
-    .parent        = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(PCII440FXState),
-    .class_init    = i440fx_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
-/* IGD Passthrough Host Bridge. */
-typedef struct {
-    uint8_t offset;
-    uint8_t len;
-} IGDHostInfo;
-
-/* Here we just expose minimal host bridge offset subset. */
-static const IGDHostInfo igd_host_bridge_infos[] = {
-    {0x08, 2},  /* revision id */
-    {0x2c, 2},  /* sybsystem vendor id */
-    {0x2e, 2},  /* sybsystem id */
-    {0x50, 2},  /* SNB: processor graphics control register */
-    {0x52, 2},  /* processor graphics control register */
-    {0xa4, 4},  /* SNB: graphics base of stolen memory */
-    {0xa8, 4},  /* SNB: base of GTT stolen memory */
-};
-
-static int host_pci_config_read(int pos, int len, uint32_t *val)
-{
-    char path[PATH_MAX];
-    int config_fd;
-    ssize_t size = sizeof(path);
-    /* Access real host bridge. */
-    int rc = snprintf(path, size, "/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
-                      0, 0, 0, 0, "config");
-    int ret = 0;
-
-    if (rc >= size || rc < 0) {
-        return -ENODEV;
-    }
-
-    config_fd = open(path, O_RDWR);
-    if (config_fd < 0) {
-        return -ENODEV;
-    }
-
-    if (lseek(config_fd, pos, SEEK_SET) != pos) {
-        ret = -errno;
-        goto out;
-    }
-
-    do {
-        rc = read(config_fd, (uint8_t *)val, len);
-    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
-    if (rc != len) {
-        ret = -errno;
-    }
-
-out:
-    close(config_fd);
-    return ret;
-}
-
-static int igd_pt_i440fx_initfn(struct PCIDevice *pci_dev)
-{
-    uint32_t val = 0;
-    int rc, i, num;
-    int pos, len;
-
-    num = ARRAY_SIZE(igd_host_bridge_infos);
-    for (i = 0; i < num; i++) {
-        pos = igd_host_bridge_infos[i].offset;
-        len = igd_host_bridge_infos[i].len;
-        rc = host_pci_config_read(pos, len, &val);
-        if (rc) {
-            return -ENODEV;
-        }
-        pci_default_write_config(pci_dev, pos, val, len);
-    }
-
-    return 0;
-}
-
-static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->init = igd_pt_i440fx_initfn;
-    dc->desc = "IGD Passthrough Host bridge";
-}
-
-static const TypeInfo igd_passthrough_i440fx_info = {
-    .name          = TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE,
-    .parent        = TYPE_I440FX_PCI_DEVICE,
-    .instance_size = sizeof(PCII440FXState),
-    .class_init    = igd_passthrough_i440fx_class_init,
-};
-
-static const char *i440fx_pcihost_root_bus_path(PCIHostState *host_bridge,
-                                                PCIBus *rootbus)
-{
-    I440FXState *s = I440FX_PCI_HOST_BRIDGE(host_bridge);
-
-    /* For backwards compat with old device paths */
-    if (s->short_root_bus) {
-        return "0000";
-    }
-    return "0000:00";
-}
-
-static Property i440fx_props[] = {
-    DEFINE_PROP_SIZE(PCI_HOST_PROP_PCI_HOLE64_SIZE, I440FXState,
-                     pci_hole64_size, I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT),
-    DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0),
-    DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, true),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
-
-    hc->root_bus_path = i440fx_pcihost_root_bus_path;
-    dc->realize = i440fx_pcihost_realize;
-    dc->fw_name = "pci";
-    dc->props = i440fx_props;
-    /* Reason: needs to be wired up by pc_init1 */
-    dc->user_creatable = false;
-}
-
-static const TypeInfo i440fx_pcihost_info = {
-    .name          = TYPE_I440FX_PCI_HOST_BRIDGE,
-    .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(I440FXState),
-    .instance_init = i440fx_pcihost_initfn,
-    .class_init    = i440fx_pcihost_class_init,
-};
-
-static void i440fx_register_types(void)
+static void piix_register_types(void)
 {
-    type_register_static(&i440fx_info);
-    type_register_static(&igd_passthrough_i440fx_info);
     type_register_static(&piix3_pci_type_info);
     type_register_static(&piix3_info);
     type_register_static(&piix3_xen_info);
-    type_register_static(&i440fx_pcihost_info);
 }
 
-type_init(i440fx_register_types)
+type_init(piix_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index c3efcd2316..a4dc72a47b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -849,6 +849,7 @@ S: Supported
 F: include/hw/i386/
 F: hw/i386/
 F: hw/pci-host/piix.c
+F: hw/pci-host/i440fx.c
 F: hw/pci-host/q35.c
 F: hw/pci-host/pam.c
 F: include/hw/pci-host/q35.h
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 9c7909cf44..acf61023b5 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -14,6 +14,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
 common-obj-$(CONFIG_PCI_APB) += apb.o
 common-obj-$(CONFIG_FULONG) += bonito.o
 common-obj-$(CONFIG_PCI_PIIX) += piix.o
+common-obj-$(CONFIG_PCI_I440FX) += i440fx.o
 common-obj-$(CONFIG_PCI_Q35) += q35.o
 common-obj-$(CONFIG_PCI_GENERIC) += gpex.o
 common-obj-$(CONFIG_PCI_XILINX) += xilinx-pcie.o
-- 
2.15.1
