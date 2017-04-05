Received: from eggs.gnu.org ([2001:4830:134:3::10]:41457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvpqj-00064S-TD
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cvpqc-0000CW-5w
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:40:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:25500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cvpqb-0000By-Dv
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:40:02 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 5 Apr 2017 18:39:58 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A4F5EA@ORSMSX112.amr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel]  [PATCH 2/3] move xen-hvm.c to hw/i386/xen/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony.perard@citrix.com" <anthony.perard@citrix.com>, 'Paolo Bonzini' <pbonzini@redhat.com>

move xen-hvm.c to hw/i386/xen/


Signed-off -by: Anthony Xu <anthony.xu@intel.com>


---
 Makefile.target           |    5 +-
 hw/i386/xen/Makefile.objs |    2 +-
 hw/i386/xen/trace-events  |   11 +
 hw/i386/xen/xen-hvm.c     | 1422 +++++++++++++++++++++++++++++++++++++++++=
++++
 hw/xen/Makefile.objs      |    2 +-
 stubs/Makefile.objs       |    2 +
 stubs/xen-hvm.c           |   63 ++
 trace-events              |   11 -
 xen-hvm-stub.c            |   63 --
 xen-hvm.c                 | 1422 -----------------------------------------=
----
 10 files changed, 1501 insertions(+), 1502 deletions(-)
 create mode 100644 hw/i386/xen/xen-hvm.c
 create mode 100644 stubs/xen-hvm.c
 delete mode 100644 xen-hvm-stub.c
 delete mode 100644 xen-hvm.c

diff --git a/Makefile.target b/Makefile.target
index 7df2b8c..d5ff0c7 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,10 +150,7 @@ obj-y +=3D migration/ram.o migration/savevm.o
 LIBS :=3D $(libs_softmmu) $(LIBS)
=20
 # xen support
-obj-$(CONFIG_XEN) +=3D xen-common.o
-obj-$(CONFIG_XEN_I386) +=3D xen-hvm.o xen-mapcache.o
-obj-$(call lnot,$(CONFIG_XEN)) +=3D xen-common-stub.o
-obj-$(call lnot,$(CONFIG_XEN_I386)) +=3D xen-hvm-stub.o
+obj-$(CONFIG_XEN_I386) +=3D xen-mapcache.o
=20
 # Hardware support
 ifeq ($(TARGET_NAME), sparc64)
diff --git a/hw/i386/xen/Makefile.objs b/hw/i386/xen/Makefile.objs
index 801a68d..daf4f53 100644
--- a/hw/i386/xen/Makefile.objs
+++ b/hw/i386/xen/Makefile.objs
@@ -1 +1 @@
-obj-y +=3D xen_platform.o xen_apic.o xen_pvdevice.o
+obj-y +=3D xen_platform.o xen_apic.o xen_pvdevice.o xen-hvm.o
diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
index 321fe60..f25d622 100644
--- a/hw/i386/xen/trace-events
+++ b/hw/i386/xen/trace-events
@@ -4,3 +4,14 @@ xen_platform_log(char *s) "xen platform: %s"
 # hw/i386/xen/xen_pvdevice.c
 xen_pv_mmio_read(uint64_t addr) "WARNING: read from Xen PV Device MMIO spa=
ce (address %"PRIx64")"
 xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO spa=
ce (address %"PRIx64")"
+
+# xen-hvm.c
+xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: %#lx=
, size %#lx"
+xen_client_set_memory(uint64_t start_addr, unsigned long size, bool log_di=
rty) "%#"PRIx64" size %#lx, log_dirty %i"
+handle_ioreq(void *req, uint32_t type, uint32_t dir, uint32_t df, uint32_t=
 data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) =
"I/O=3D%p type=3D%d dir=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"P=
RIx64" count=3D%d size=3D%d"
+handle_ioreq_read(void *req, uint32_t type, uint32_t df, uint32_t data_is_=
ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%p=
 read type=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" count=
=3D%d size=3D%d"
+handle_ioreq_write(void *req, uint32_t type, uint32_t df, uint32_t data_is=
_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%=
p write type=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" coun=
t=3D%d size=3D%d"
+cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, =
uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%p pio =
dir=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" count=3D%d si=
ze=3D%d"
+cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t s=
ize) "I/O=3D%p pio read reg data=3D%#"PRIx64" port=3D%#"PRIx64" size=3D%d"
+cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t =
size) "I/O=3D%p pio write reg data=3D%#"PRIx64" port=3D%#"PRIx64" size=3D%d=
"
+cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr,=
 uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%p cop=
y dir=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" count=3D%d =
size=3D%d"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
new file mode 100644
index 0000000..0892361
--- /dev/null
+++ b/hw/i386/xen/xen-hvm.c
@@ -0,0 +1,1422 @@
+/*
+ * Copyright (C) 2010       Citrix Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "hw/pci/pci.h"
+#include "hw/i386/pc.h"
+#include "hw/i386/apic-msidef.h"
+#include "hw/xen/xen_common.h"
+#include "hw/xen/xen_backend.h"
+#include "qmp-commands.h"
+
+#include "sysemu/char.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "sysemu/xen-mapcache.h"
+#include "trace.h"
+#include "exec/address-spaces.h"
+
+#include <xen/hvm/ioreq.h>
+#include <xen/hvm/params.h>
+#include <xen/hvm/e820.h>
+
+//#define DEBUG_XEN_HVM
+
+#ifdef DEBUG_XEN_HVM
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+    do { } while (0)
+#endif
+
+static MemoryRegion ram_memory, ram_640k, ram_lo, ram_hi;
+static MemoryRegion *framebuffer;
+static bool xen_in_migration;
+
+/* Compatibility with older version */
+
+/* This allows QEMU to build on a system that has Xen 4.5 or earlier
+ * installed.  This here (not in hw/xen/xen_common.h) because xen/hvm/iore=
q.h
+ * needs to be included before this block and hw/xen/xen_common.h needs to
+ * be included before xen/hvm/ioreq.h
+ */
+#ifndef IOREQ_TYPE_VMWARE_PORT
+#define IOREQ_TYPE_VMWARE_PORT  3
+struct vmware_regs {
+    uint32_t esi;
+    uint32_t edi;
+    uint32_t ebx;
+    uint32_t ecx;
+    uint32_t edx;
+};
+typedef struct vmware_regs vmware_regs_t;
+
+struct shared_vmport_iopage {
+    struct vmware_regs vcpu_vmport_regs[1];
+};
+typedef struct shared_vmport_iopage shared_vmport_iopage_t;
+#endif
+
+static inline uint32_t xen_vcpu_eport(shared_iopage_t *shared_page, int i)
+{
+    return shared_page->vcpu_ioreq[i].vp_eport;
+}
+static inline ioreq_t *xen_vcpu_ioreq(shared_iopage_t *shared_page, int vc=
pu)
+{
+    return &shared_page->vcpu_ioreq[vcpu];
+}
+
+#define BUFFER_IO_MAX_DELAY  100
+
+typedef struct XenPhysmap {
+    hwaddr start_addr;
+    ram_addr_t size;
+    const char *name;
+    hwaddr phys_offset;
+
+    QLIST_ENTRY(XenPhysmap) list;
+} XenPhysmap;
+
+typedef struct XenIOState {
+    ioservid_t ioservid;
+    shared_iopage_t *shared_page;
+    shared_vmport_iopage_t *shared_vmport_page;
+    buffered_iopage_t *buffered_io_page;
+    QEMUTimer *buffered_io_timer;
+    CPUState **cpu_by_vcpu_id;
+    /* the evtchn port for polling the notification, */
+    evtchn_port_t *ioreq_local_port;
+    /* evtchn local port for buffered io */
+    evtchn_port_t bufioreq_local_port;
+    /* the evtchn fd for polling */
+    xenevtchn_handle *xce_handle;
+    /* which vcpu we are serving */
+    int send_vcpu;
+
+    struct xs_handle *xenstore;
+    MemoryListener memory_listener;
+    MemoryListener io_listener;
+    DeviceListener device_listener;
+    QLIST_HEAD(, XenPhysmap) physmap;
+    hwaddr free_phys_offset;
+    const XenPhysmap *log_for_dirtybit;
+
+    Notifier exit;
+    Notifier suspend;
+    Notifier wakeup;
+} XenIOState;
+
+/* Xen specific function for piix pci */
+
+int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
+{
+    return irq_num + ((pci_dev->devfn >> 3) << 2);
+}
+
+void xen_piix3_set_irq(void *opaque, int irq_num, int level)
+{
+    xc_hvm_set_pci_intx_level(xen_xc, xen_domid, 0, 0, irq_num >> 2,
+                              irq_num & 3, level);
+}
+
+void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int =
len)
+{
+    int i;
+
+    /* Scan for updates to PCI link routes (0x60-0x63). */
+    for (i =3D 0; i < len; i++) {
+        uint8_t v =3D (val >> (8 * i)) & 0xff;
+        if (v & 0x80) {
+            v =3D 0;
+        }
+        v &=3D 0xf;
+        if (((address + i) >=3D 0x60) && ((address + i) <=3D 0x63)) {
+            xc_hvm_set_pci_link_route(xen_xc, xen_domid, address + i - 0x6=
0, v);
+        }
+    }
+}
+
+int xen_is_pirq_msi(uint32_t msi_data)
+{
+    /* If vector is 0, the msi is remapped into a pirq, passed as
+     * dest_id.
+     */
+    return ((msi_data & MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT) =
=3D=3D 0;
+}
+
+void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
+{
+    xc_hvm_inject_msi(xen_xc, xen_domid, addr, data);
+}
+
+static void xen_suspend_notifier(Notifier *notifier, void *data)
+{
+    xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 3);
+}
+
+/* Xen Interrupt Controller */
+
+static void xen_set_irq(void *opaque, int irq, int level)
+{
+    xc_hvm_set_isa_irq_level(xen_xc, xen_domid, irq, level);
+}
+
+qemu_irq *xen_interrupt_controller_init(void)
+{
+    return qemu_allocate_irqs(xen_set_irq, NULL, 16);
+}
+
+/* Memory Ops */
+
+static void xen_ram_init(PCMachineState *pcms,
+                         ram_addr_t ram_size, MemoryRegion **ram_memory_p)
+{
+    MemoryRegion *sysmem =3D get_system_memory();
+    ram_addr_t block_len;
+    uint64_t user_lowmem =3D object_property_get_int(qdev_get_machine(),
+                                                   PC_MACHINE_MAX_RAM_BELO=
W_4G,
+                                                   &error_abort);
+
+    /* Handle the machine opt max-ram-below-4g.  It is basically doing
+     * min(xen limit, user limit).
+     */
+    if (!user_lowmem) {
+        user_lowmem =3D HVM_BELOW_4G_RAM_END; /* default */
+    }
+    if (HVM_BELOW_4G_RAM_END <=3D user_lowmem) {
+        user_lowmem =3D HVM_BELOW_4G_RAM_END;
+    }
+
+    if (ram_size >=3D user_lowmem) {
+        pcms->above_4g_mem_size =3D ram_size - user_lowmem;
+        pcms->below_4g_mem_size =3D user_lowmem;
+    } else {
+        pcms->above_4g_mem_size =3D 0;
+        pcms->below_4g_mem_size =3D ram_size;
+    }
+    if (!pcms->above_4g_mem_size) {
+        block_len =3D ram_size;
+    } else {
+        /*
+         * Xen does not allocate the memory continuously, it keeps a
+         * hole of the size computed above or passed in.
+         */
+        block_len =3D (1ULL << 32) + pcms->above_4g_mem_size;
+    }
+    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
+                           &error_fatal);
+    *ram_memory_p =3D &ram_memory;
+    vmstate_register_ram_global(&ram_memory);
+
+    memory_region_init_alias(&ram_640k, NULL, "xen.ram.640k",
+                             &ram_memory, 0, 0xa0000);
+    memory_region_add_subregion(sysmem, 0, &ram_640k);
+    /* Skip of the VGA IO memory space, it will be registered later by the=
 VGA
+     * emulated device.
+     *
+     * The area between 0xc0000 and 0x100000 will be used by SeaBIOS to lo=
ad
+     * the Options ROM, so it is registered here as RAM.
+     */
+    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo",
+                             &ram_memory, 0xc0000,
+                             pcms->below_4g_mem_size - 0xc0000);
+    memory_region_add_subregion(sysmem, 0xc0000, &ram_lo);
+    if (pcms->above_4g_mem_size > 0) {
+        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi",
+                                 &ram_memory, 0x100000000ULL,
+                                 pcms->above_4g_mem_size);
+        memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
+    }
+}
+
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
+                   Error **errp)
+{
+    unsigned long nr_pfn;
+    xen_pfn_t *pfn_list;
+    int i;
+
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        /* RAM already populated in Xen */
+        fprintf(stderr, "%s: do not alloc "RAM_ADDR_FMT
+                " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGRAT=
E\n",
+                __func__, size, ram_addr);=20
+        return;
+    }
+
+    if (mr =3D=3D &ram_memory) {
+        return;
+    }
+
+    trace_xen_ram_alloc(ram_addr, size);
+
+    nr_pfn =3D size >> TARGET_PAGE_BITS;
+    pfn_list =3D g_malloc(sizeof (*pfn_list) * nr_pfn);
+
+    for (i =3D 0; i < nr_pfn; i++) {
+        pfn_list[i] =3D (ram_addr >> TARGET_PAGE_BITS) + i;
+    }
+
+    if (xc_domain_populate_physmap_exact(xen_xc, xen_domid, nr_pfn, 0, 0, =
pfn_list)) {
+        error_setg(errp, "xen: failed to populate ram at " RAM_ADDR_FMT,
+                   ram_addr);
+    }
+
+    g_free(pfn_list);
+}
+
+static XenPhysmap *get_physmapping(XenIOState *state,
+                                   hwaddr start_addr, ram_addr_t size)
+{
+    XenPhysmap *physmap =3D NULL;
+
+    start_addr &=3D TARGET_PAGE_MASK;
+
+    QLIST_FOREACH(physmap, &state->physmap, list) {
+        if (range_covers_byte(physmap->start_addr, physmap->size, start_ad=
dr)) {
+            return physmap;
+        }
+    }
+    return NULL;
+}
+
+static hwaddr xen_phys_offset_to_gaddr(hwaddr start_addr,
+                                                   ram_addr_t size, void *=
opaque)
+{
+    hwaddr addr =3D start_addr & TARGET_PAGE_MASK;
+    XenIOState *xen_io_state =3D opaque;
+    XenPhysmap *physmap =3D NULL;
+
+    QLIST_FOREACH(physmap, &xen_io_state->physmap, list) {
+        if (range_covers_byte(physmap->phys_offset, physmap->size, addr)) =
{
+            return physmap->start_addr;
+        }
+    }
+
+    return start_addr;
+}
+
+static int xen_add_to_physmap(XenIOState *state,
+                              hwaddr start_addr,
+                              ram_addr_t size,
+                              MemoryRegion *mr,
+                              hwaddr offset_within_region)
+{
+    unsigned long i =3D 0;
+    int rc =3D 0;
+    XenPhysmap *physmap =3D NULL;
+    hwaddr pfn, start_gpfn;
+    hwaddr phys_offset =3D memory_region_get_ram_addr(mr);
+    char path[80], value[17];
+    const char *mr_name;
+
+    if (get_physmapping(state, start_addr, size)) {
+        return 0;
+    }
+    if (size <=3D 0) {
+        return -1;
+    }
+
+    /* Xen can only handle a single dirty log region for now and we want
+     * the linear framebuffer to be that region.
+     * Avoid tracking any regions that is not videoram and avoid tracking
+     * the legacy vga region. */
+    if (mr =3D=3D framebuffer && start_addr > 0xbffff) {
+        goto go_physmap;
+    }
+    return -1;
+
+go_physmap:
+    DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
+            start_addr, start_addr + size);
+
+    pfn =3D phys_offset >> TARGET_PAGE_BITS;
+    start_gpfn =3D start_addr >> TARGET_PAGE_BITS;
+    for (i =3D 0; i < size >> TARGET_PAGE_BITS; i++) {
+        unsigned long idx =3D pfn + i;
+        xen_pfn_t gpfn =3D start_gpfn + i;
+
+        rc =3D xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE=
_gmfn, idx, gpfn);
+        if (rc) {
+            DPRINTF("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
+                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc,=
 errno);
+            return -rc;
+        }
+    }
+
+    mr_name =3D memory_region_name(mr);
+
+    physmap =3D g_malloc(sizeof (XenPhysmap));
+
+    physmap->start_addr =3D start_addr;
+    physmap->size =3D size;
+    physmap->name =3D mr_name;
+    physmap->phys_offset =3D phys_offset;
+
+    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
+
+    xc_domain_pin_memory_cacheattr(xen_xc, xen_domid,
+                                   start_addr >> TARGET_PAGE_BITS,
+                                   (start_addr + size - 1) >> TARGET_PAGE_=
BITS,
+                                   XEN_DOMCTL_MEM_CACHEATTR_WB);
+
+    snprintf(path, sizeof(path),
+            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/start_addr"=
,
+            xen_domid, (uint64_t)phys_offset);
+    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)start_addr);
+    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
+        return -1;
+    }
+    snprintf(path, sizeof(path),
+            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
+            xen_domid, (uint64_t)phys_offset);
+    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)size);
+    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
+        return -1;
+    }
+    if (mr_name) {
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name",
+                xen_domid, (uint64_t)phys_offset);
+        if (!xs_write(state->xenstore, 0, path, mr_name, strlen(mr_name)))=
 {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int xen_remove_from_physmap(XenIOState *state,
+                                   hwaddr start_addr,
+                                   ram_addr_t size)
+{
+    unsigned long i =3D 0;
+    int rc =3D 0;
+    XenPhysmap *physmap =3D NULL;
+    hwaddr phys_offset =3D 0;
+
+    physmap =3D get_physmapping(state, start_addr, size);
+    if (physmap =3D=3D NULL) {
+        return -1;
+    }
+
+    phys_offset =3D physmap->phys_offset;
+    size =3D physmap->size;
+
+    DPRINTF("unmapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx", at "
+            "%"HWADDR_PRIx"\n", start_addr, start_addr + size, phys_offset=
);
+
+    size >>=3D TARGET_PAGE_BITS;
+    start_addr >>=3D TARGET_PAGE_BITS;
+    phys_offset >>=3D TARGET_PAGE_BITS;
+    for (i =3D 0; i < size; i++) {
+        xen_pfn_t idx =3D start_addr + i;
+        xen_pfn_t gpfn =3D phys_offset + i;
+
+        rc =3D xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE=
_gmfn, idx, gpfn);
+        if (rc) {
+            fprintf(stderr, "add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
+                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc,=
 errno);
+            return -rc;
+        }
+    }
+
+    QLIST_REMOVE(physmap, list);
+    if (state->log_for_dirtybit =3D=3D physmap) {
+        state->log_for_dirtybit =3D NULL;
+    }
+    g_free(physmap);
+
+    return 0;
+}
+
+static void xen_set_memory(struct MemoryListener *listener,
+                           MemoryRegionSection *section,
+                           bool add)
+{
+    XenIOState *state =3D container_of(listener, XenIOState, memory_listen=
er);
+    hwaddr start_addr =3D section->offset_within_address_space;
+    ram_addr_t size =3D int128_get64(section->size);
+    bool log_dirty =3D memory_region_is_logging(section->mr, DIRTY_MEMORY_=
VGA);
+    hvmmem_type_t mem_type;
+
+    if (section->mr =3D=3D &ram_memory) {
+        return;
+    } else {
+        if (add) {
+            xen_map_memory_section(xen_xc, xen_domid, state->ioservid,
+                                   section);
+        } else {
+            xen_unmap_memory_section(xen_xc, xen_domid, state->ioservid,
+                                     section);
+        }
+    }
+
+    if (!memory_region_is_ram(section->mr)) {
+        return;
+    }
+
+    if (log_dirty !=3D add) {
+        return;
+    }
+
+    trace_xen_client_set_memory(start_addr, size, log_dirty);
+
+    start_addr &=3D TARGET_PAGE_MASK;
+    size =3D TARGET_PAGE_ALIGN(size);
+
+    if (add) {
+        if (!memory_region_is_rom(section->mr)) {
+            xen_add_to_physmap(state, start_addr, size,
+                               section->mr, section->offset_within_region)=
;
+        } else {
+            mem_type =3D HVMMEM_ram_ro;
+            if (xc_hvm_set_mem_type(xen_xc, xen_domid, mem_type,
+                                    start_addr >> TARGET_PAGE_BITS,
+                                    size >> TARGET_PAGE_BITS)) {
+                DPRINTF("xc_hvm_set_mem_type error, addr: "TARGET_FMT_plx"=
\n",
+                        start_addr);
+            }
+        }
+    } else {
+        if (xen_remove_from_physmap(state, start_addr, size) < 0) {
+            DPRINTF("physmapping does not exist at "TARGET_FMT_plx"\n", st=
art_addr);
+        }
+    }
+}
+
+static void xen_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    memory_region_ref(section->mr);
+    xen_set_memory(listener, section, true);
+}
+
+static void xen_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    xen_set_memory(listener, section, false);
+    memory_region_unref(section->mr);
+}
+
+static void xen_io_add(MemoryListener *listener,
+                       MemoryRegionSection *section)
+{
+    XenIOState *state =3D container_of(listener, XenIOState, io_listener);
+    MemoryRegion *mr =3D section->mr;
+
+    if (mr->ops =3D=3D &unassigned_io_ops) {
+        return;
+    }
+
+    memory_region_ref(mr);
+
+    xen_map_io_section(xen_xc, xen_domid, state->ioservid, section);
+}
+
+static void xen_io_del(MemoryListener *listener,
+                       MemoryRegionSection *section)
+{
+    XenIOState *state =3D container_of(listener, XenIOState, io_listener);
+    MemoryRegion *mr =3D section->mr;
+
+    if (mr->ops =3D=3D &unassigned_io_ops) {
+        return;
+    }
+
+    xen_unmap_io_section(xen_xc, xen_domid, state->ioservid, section);
+
+    memory_region_unref(mr);
+}
+
+static void xen_device_realize(DeviceListener *listener,
+			       DeviceState *dev)
+{
+    XenIOState *state =3D container_of(listener, XenIOState, device_listen=
er);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        PCIDevice *pci_dev =3D PCI_DEVICE(dev);
+
+        xen_map_pcidev(xen_xc, xen_domid, state->ioservid, pci_dev);
+    }
+}
+
+static void xen_device_unrealize(DeviceListener *listener,
+				 DeviceState *dev)
+{
+    XenIOState *state =3D container_of(listener, XenIOState, device_listen=
er);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        PCIDevice *pci_dev =3D PCI_DEVICE(dev);
+
+        xen_unmap_pcidev(xen_xc, xen_domid, state->ioservid, pci_dev);
+    }
+}
+
+static void xen_sync_dirty_bitmap(XenIOState *state,
+                                  hwaddr start_addr,
+                                  ram_addr_t size)
+{
+    hwaddr npages =3D size >> TARGET_PAGE_BITS;
+    const int width =3D sizeof(unsigned long) * 8;
+    unsigned long bitmap[DIV_ROUND_UP(npages, width)];
+    int rc, i, j;
+    const XenPhysmap *physmap =3D NULL;
+
+    physmap =3D get_physmapping(state, start_addr, size);
+    if (physmap =3D=3D NULL) {
+        /* not handled */
+        return;
+    }
+
+    if (state->log_for_dirtybit =3D=3D NULL) {
+        state->log_for_dirtybit =3D physmap;
+    } else if (state->log_for_dirtybit !=3D physmap) {
+        /* Only one range for dirty bitmap can be tracked. */
+        return;
+    }
+
+    rc =3D xc_hvm_track_dirty_vram(xen_xc, xen_domid,
+                                 start_addr >> TARGET_PAGE_BITS, npages,
+                                 bitmap);
+    if (rc < 0) {
+#ifndef ENODATA
+#define ENODATA  ENOENT
+#endif
+        if (errno =3D=3D ENODATA) {
+            memory_region_set_dirty(framebuffer, 0, size);
+            DPRINTF("xen: track_dirty_vram failed (0x" TARGET_FMT_plx
+                    ", 0x" TARGET_FMT_plx "): %s\n",
+                    start_addr, start_addr + size, strerror(errno));
+        }
+        return;
+    }
+
+    for (i =3D 0; i < ARRAY_SIZE(bitmap); i++) {
+        unsigned long map =3D bitmap[i];
+        while (map !=3D 0) {
+            j =3D ctzl(map);
+            map &=3D ~(1ul << j);
+            memory_region_set_dirty(framebuffer,
+                                    (i * width + j) * TARGET_PAGE_SIZE,
+                                    TARGET_PAGE_SIZE);
+        };
+    }
+}
+
+static void xen_log_start(MemoryListener *listener,
+                          MemoryRegionSection *section,
+                          int old, int new)
+{
+    XenIOState *state =3D container_of(listener, XenIOState, memory_listen=
er);
+
+    if (new & ~old & (1 << DIRTY_MEMORY_VGA)) {
+        xen_sync_dirty_bitmap(state, section->offset_within_address_space,
+                              int128_get64(section->size));
+    }
+}
+
+static void xen_log_stop(MemoryListener *listener, MemoryRegionSection *se=
ction,
+                         int old, int new)
+{
+    XenIOState *state =3D container_of(listener, XenIOState, memory_listen=
er);
+
+    if (old & ~new & (1 << DIRTY_MEMORY_VGA)) {
+        state->log_for_dirtybit =3D NULL;
+        /* Disable dirty bit tracking */
+        xc_hvm_track_dirty_vram(xen_xc, xen_domid, 0, 0, NULL);
+    }
+}
+
+static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *se=
ction)
+{
+    XenIOState *state =3D container_of(listener, XenIOState, memory_listen=
er);
+
+    xen_sync_dirty_bitmap(state, section->offset_within_address_space,
+                          int128_get64(section->size));
+}
+
+static void xen_log_global_start(MemoryListener *listener)
+{
+    if (xen_enabled()) {
+        xen_in_migration =3D true;
+    }
+}
+
+static void xen_log_global_stop(MemoryListener *listener)
+{
+    xen_in_migration =3D false;
+}
+
+static MemoryListener xen_memory_listener =3D {
+    .region_add =3D xen_region_add,
+    .region_del =3D xen_region_del,
+    .log_start =3D xen_log_start,
+    .log_stop =3D xen_log_stop,
+    .log_sync =3D xen_log_sync,
+    .log_global_start =3D xen_log_global_start,
+    .log_global_stop =3D xen_log_global_stop,
+    .priority =3D 10,
+};
+
+static MemoryListener xen_io_listener =3D {
+    .region_add =3D xen_io_add,
+    .region_del =3D xen_io_del,
+    .priority =3D 10,
+};
+
+static DeviceListener xen_device_listener =3D {
+    .realize =3D xen_device_realize,
+    .unrealize =3D xen_device_unrealize,
+};
+
+/* get the ioreq packets from share mem */
+static ioreq_t *cpu_get_ioreq_from_shared_memory(XenIOState *state, int vc=
pu)
+{
+    ioreq_t *req =3D xen_vcpu_ioreq(state->shared_page, vcpu);
+
+    if (req->state !=3D STATE_IOREQ_READY) {
+        DPRINTF("I/O request not ready: "
+                "%x, ptr: %x, port: %"PRIx64", "
+                "data: %"PRIx64", count: %u, size: %u\n",
+                req->state, req->data_is_ptr, req->addr,
+                req->data, req->count, req->size);
+        return NULL;
+    }
+
+    xen_rmb(); /* see IOREQ_READY /then/ read contents of ioreq */
+
+    req->state =3D STATE_IOREQ_INPROCESS;
+    return req;
+}
+
+/* use poll to get the port notification */
+/* ioreq_vec--out,the */
+/* retval--the number of ioreq packet */
+static ioreq_t *cpu_get_ioreq(XenIOState *state)
+{
+    int i;
+    evtchn_port_t port;
+
+    port =3D xenevtchn_pending(state->xce_handle);
+    if (port =3D=3D state->bufioreq_local_port) {
+        timer_mod(state->buffered_io_timer,
+                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIM=
E));
+        return NULL;
+    }
+
+    if (port !=3D -1) {
+        for (i =3D 0; i < max_cpus; i++) {
+            if (state->ioreq_local_port[i] =3D=3D port) {
+                break;
+            }
+        }
+
+        if (i =3D=3D max_cpus) {
+            hw_error("Fatal error while trying to get io event!\n");
+        }
+
+        /* unmask the wanted port again */
+        xenevtchn_unmask(state->xce_handle, port);
+
+        /* get the io packet from shared memory */
+        state->send_vcpu =3D i;
+        return cpu_get_ioreq_from_shared_memory(state, i);
+    }
+
+    /* read error or read nothing */
+    return NULL;
+}
+
+static uint32_t do_inp(uint32_t addr, unsigned long size)
+{
+    switch (size) {
+        case 1:
+            return cpu_inb(addr);
+        case 2:
+            return cpu_inw(addr);
+        case 4:
+            return cpu_inl(addr);
+        default:
+            hw_error("inp: bad size: %04x %lx", addr, size);
+    }
+}
+
+static void do_outp(uint32_t addr,
+        unsigned long size, uint32_t val)
+{
+    switch (size) {
+        case 1:
+            return cpu_outb(addr, val);
+        case 2:
+            return cpu_outw(addr, val);
+        case 4:
+            return cpu_outl(addr, val);
+        default:
+            hw_error("outp: bad size: %04x %lx", addr, size);
+    }
+}
+
+/*
+ * Helper functions which read/write an object from/to physical guest
+ * memory, as part of the implementation of an ioreq.
+ *
+ * Equivalent to
+ *   cpu_physical_memory_rw(addr + (req->df ? -1 : +1) * req->size * i,
+ *                          val, req->size, 0/1)
+ * except without the integer overflow problems.
+ */
+static void rw_phys_req_item(hwaddr addr,
+                             ioreq_t *req, uint32_t i, void *val, int rw)
+{
+    /* Do everything unsigned so overflow just results in a truncated resu=
lt
+     * and accesses to undesired parts of guest memory, which is up
+     * to the guest */
+    hwaddr offset =3D (hwaddr)req->size * i;
+    if (req->df) {
+        addr -=3D offset;
+    } else {
+        addr +=3D offset;
+    }
+    cpu_physical_memory_rw(addr, val, req->size, rw);
+}
+
+static inline void read_phys_req_item(hwaddr addr,
+                                      ioreq_t *req, uint32_t i, void *val)
+{
+    rw_phys_req_item(addr, req, i, val, 0);
+}
+static inline void write_phys_req_item(hwaddr addr,
+                                       ioreq_t *req, uint32_t i, void *val=
)
+{
+    rw_phys_req_item(addr, req, i, val, 1);
+}
+
+
+static void cpu_ioreq_pio(ioreq_t *req)
+{
+    uint32_t i;
+
+    trace_cpu_ioreq_pio(req, req->dir, req->df, req->data_is_ptr, req->add=
r,
+                         req->data, req->count, req->size);
+
+    if (req->size > sizeof(uint32_t)) {
+        hw_error("PIO: bad size (%u)", req->size);
+    }
+
+    if (req->dir =3D=3D IOREQ_READ) {
+        if (!req->data_is_ptr) {
+            req->data =3D do_inp(req->addr, req->size);
+            trace_cpu_ioreq_pio_read_reg(req, req->data, req->addr,
+                                         req->size);
+        } else {
+            uint32_t tmp;
+
+            for (i =3D 0; i < req->count; i++) {
+                tmp =3D do_inp(req->addr, req->size);
+                write_phys_req_item(req->data, req, i, &tmp);
+            }
+        }
+    } else if (req->dir =3D=3D IOREQ_WRITE) {
+        if (!req->data_is_ptr) {
+            trace_cpu_ioreq_pio_write_reg(req, req->data, req->addr,
+                                          req->size);
+            do_outp(req->addr, req->size, req->data);
+        } else {
+            for (i =3D 0; i < req->count; i++) {
+                uint32_t tmp =3D 0;
+
+                read_phys_req_item(req->data, req, i, &tmp);
+                do_outp(req->addr, req->size, tmp);
+            }
+        }
+    }
+}
+
+static void cpu_ioreq_move(ioreq_t *req)
+{
+    uint32_t i;
+
+    trace_cpu_ioreq_move(req, req->dir, req->df, req->data_is_ptr, req->ad=
dr,
+                         req->data, req->count, req->size);
+
+    if (req->size > sizeof(req->data)) {
+        hw_error("MMIO: bad size (%u)", req->size);
+    }
+
+    if (!req->data_is_ptr) {
+        if (req->dir =3D=3D IOREQ_READ) {
+            for (i =3D 0; i < req->count; i++) {
+                read_phys_req_item(req->addr, req, i, &req->data);
+            }
+        } else if (req->dir =3D=3D IOREQ_WRITE) {
+            for (i =3D 0; i < req->count; i++) {
+                write_phys_req_item(req->addr, req, i, &req->data);
+            }
+        }
+    } else {
+        uint64_t tmp;
+
+        if (req->dir =3D=3D IOREQ_READ) {
+            for (i =3D 0; i < req->count; i++) {
+                read_phys_req_item(req->addr, req, i, &tmp);
+                write_phys_req_item(req->data, req, i, &tmp);
+            }
+        } else if (req->dir =3D=3D IOREQ_WRITE) {
+            for (i =3D 0; i < req->count; i++) {
+                read_phys_req_item(req->data, req, i, &tmp);
+                write_phys_req_item(req->addr, req, i, &tmp);
+            }
+        }
+    }
+}
+
+static void regs_to_cpu(vmware_regs_t *vmport_regs, ioreq_t *req)
+{
+    X86CPU *cpu;
+    CPUX86State *env;
+
+    cpu =3D X86_CPU(current_cpu);
+    env =3D &cpu->env;
+    env->regs[R_EAX] =3D req->data;
+    env->regs[R_EBX] =3D vmport_regs->ebx;
+    env->regs[R_ECX] =3D vmport_regs->ecx;
+    env->regs[R_EDX] =3D vmport_regs->edx;
+    env->regs[R_ESI] =3D vmport_regs->esi;
+    env->regs[R_EDI] =3D vmport_regs->edi;
+}
+
+static void regs_from_cpu(vmware_regs_t *vmport_regs)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    CPUX86State *env =3D &cpu->env;
+
+    vmport_regs->ebx =3D env->regs[R_EBX];
+    vmport_regs->ecx =3D env->regs[R_ECX];
+    vmport_regs->edx =3D env->regs[R_EDX];
+    vmport_regs->esi =3D env->regs[R_ESI];
+    vmport_regs->edi =3D env->regs[R_EDI];
+}
+
+static void handle_vmport_ioreq(XenIOState *state, ioreq_t *req)
+{
+    vmware_regs_t *vmport_regs;
+
+    assert(state->shared_vmport_page);
+    vmport_regs =3D
+        &state->shared_vmport_page->vcpu_vmport_regs[state->send_vcpu];
+    QEMU_BUILD_BUG_ON(sizeof(*req) < sizeof(*vmport_regs));
+
+    current_cpu =3D state->cpu_by_vcpu_id[state->send_vcpu];
+    regs_to_cpu(vmport_regs, req);
+    cpu_ioreq_pio(req);
+    regs_from_cpu(vmport_regs);
+    current_cpu =3D NULL;
+}
+
+static void handle_ioreq(XenIOState *state, ioreq_t *req)
+{
+    trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr=
,
+                       req->addr, req->data, req->count, req->size);
+
+    if (!req->data_is_ptr && (req->dir =3D=3D IOREQ_WRITE) &&
+            (req->size < sizeof (target_ulong))) {
+        req->data &=3D ((target_ulong) 1 << (8 * req->size)) - 1;
+    }
+
+    if (req->dir =3D=3D IOREQ_WRITE)
+        trace_handle_ioreq_write(req, req->type, req->df, req->data_is_ptr=
,
+                                 req->addr, req->data, req->count, req->si=
ze);
+
+    switch (req->type) {
+        case IOREQ_TYPE_PIO:
+            cpu_ioreq_pio(req);
+            break;
+        case IOREQ_TYPE_COPY:
+            cpu_ioreq_move(req);
+            break;
+        case IOREQ_TYPE_VMWARE_PORT:
+            handle_vmport_ioreq(state, req);
+            break;
+        case IOREQ_TYPE_TIMEOFFSET:
+            break;
+        case IOREQ_TYPE_INVALIDATE:
+            xen_invalidate_map_cache();
+            break;
+        case IOREQ_TYPE_PCI_CONFIG: {
+            uint32_t sbdf =3D req->addr >> 32;
+            uint32_t val;
+
+            /* Fake a write to port 0xCF8 so that
+             * the config space access will target the
+             * correct device model.
+             */
+            val =3D (1u << 31) |
+                  ((req->addr & 0x0f00) << 16) |
+                  ((sbdf & 0xffff) << 8) |
+                  (req->addr & 0xfc);
+            do_outp(0xcf8, 4, val);
+
+            /* Now issue the config space access via
+             * port 0xCFC
+             */
+            req->addr =3D 0xcfc | (req->addr & 0x03);
+            cpu_ioreq_pio(req);
+            break;
+        }
+        default:
+            hw_error("Invalid ioreq type 0x%x\n", req->type);
+    }
+    if (req->dir =3D=3D IOREQ_READ) {
+        trace_handle_ioreq_read(req, req->type, req->df, req->data_is_ptr,
+                                req->addr, req->data, req->count, req->siz=
e);
+    }
+}
+
+static int handle_buffered_iopage(XenIOState *state)
+{
+    buffered_iopage_t *buf_page =3D state->buffered_io_page;
+    buf_ioreq_t *buf_req =3D NULL;
+    ioreq_t req;
+    int qw;
+
+    if (!buf_page) {
+        return 0;
+    }
+
+    memset(&req, 0x00, sizeof(req));
+    req.state =3D STATE_IOREQ_READY;
+    req.count =3D 1;
+    req.dir =3D IOREQ_WRITE;
+
+    for (;;) {
+        uint32_t rdptr =3D buf_page->read_pointer, wrptr;
+
+        xen_rmb();
+        wrptr =3D buf_page->write_pointer;
+        xen_rmb();
+        if (rdptr !=3D buf_page->read_pointer) {
+            continue;
+        }
+        if (rdptr =3D=3D wrptr) {
+            break;
+        }
+        buf_req =3D &buf_page->buf_ioreq[rdptr % IOREQ_BUFFER_SLOT_NUM];
+        req.size =3D 1U << buf_req->size;
+        req.addr =3D buf_req->addr;
+        req.data =3D buf_req->data;
+        req.type =3D buf_req->type;
+        xen_rmb();
+        qw =3D (req.size =3D=3D 8);
+        if (qw) {
+            if (rdptr + 1 =3D=3D wrptr) {
+                hw_error("Incomplete quad word buffered ioreq");
+            }
+            buf_req =3D &buf_page->buf_ioreq[(rdptr + 1) %
+                                           IOREQ_BUFFER_SLOT_NUM];
+            req.data |=3D ((uint64_t)buf_req->data) << 32;
+            xen_rmb();
+        }
+
+        handle_ioreq(state, &req);
+
+        /* Only req.data may get updated by handle_ioreq(), albeit even th=
at
+         * should not happen as such data would never make it to the guest=
 (we
+         * can only usefully see writes here after all).
+         */
+        assert(req.state =3D=3D STATE_IOREQ_READY);
+        assert(req.count =3D=3D 1);
+        assert(req.dir =3D=3D IOREQ_WRITE);
+        assert(!req.data_is_ptr);
+
+        atomic_add(&buf_page->read_pointer, qw + 1);
+    }
+
+    return req.count;
+}
+
+static void handle_buffered_io(void *opaque)
+{
+    XenIOState *state =3D opaque;
+
+    if (handle_buffered_iopage(state)) {
+        timer_mod(state->buffered_io_timer,
+                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIM=
E));
+    } else {
+        timer_del(state->buffered_io_timer);
+        xenevtchn_unmask(state->xce_handle, state->bufioreq_local_port);
+    }
+}
+
+static void cpu_handle_ioreq(void *opaque)
+{
+    XenIOState *state =3D opaque;
+    ioreq_t *req =3D cpu_get_ioreq(state);
+
+    handle_buffered_iopage(state);
+    if (req) {
+        ioreq_t copy =3D *req;
+
+        xen_rmb();
+        handle_ioreq(state, &copy);
+        req->data =3D copy.data;
+
+        if (req->state !=3D STATE_IOREQ_INPROCESS) {
+            fprintf(stderr, "Badness in I/O request ... not in service?!: =
"
+                    "%x, ptr: %x, port: %"PRIx64", "
+                    "data: %"PRIx64", count: %u, size: %u, type: %u\n",
+                    req->state, req->data_is_ptr, req->addr,
+                    req->data, req->count, req->size, req->type);
+            destroy_hvm_domain(false);
+            return;
+        }
+
+        xen_wmb(); /* Update ioreq contents /then/ update state. */
+
+        /*
+         * We do this before we send the response so that the tools
+         * have the opportunity to pick up on the reset before the
+         * guest resumes and does a hlt with interrupts disabled which
+         * causes Xen to powerdown the domain.
+         */
+        if (runstate_is_running()) {
+            if (qemu_shutdown_requested_get()) {
+                destroy_hvm_domain(false);
+            }
+            if (qemu_reset_requested_get()) {
+                qemu_system_reset(VMRESET_REPORT);
+                destroy_hvm_domain(true);
+            }
+        }
+
+        req->state =3D STATE_IORESP_READY;
+        xenevtchn_notify(state->xce_handle,
+                         state->ioreq_local_port[state->send_vcpu]);
+    }
+}
+
+static void xen_main_loop_prepare(XenIOState *state)
+{
+    int evtchn_fd =3D -1;
+
+    if (state->xce_handle !=3D NULL) {
+        evtchn_fd =3D xenevtchn_fd(state->xce_handle);
+    }
+
+    state->buffered_io_timer =3D timer_new_ms(QEMU_CLOCK_REALTIME, handle_=
buffered_io,
+                                                 state);
+
+    if (evtchn_fd !=3D -1) {
+        CPUState *cpu_state;
+
+        DPRINTF("%s: Init cpu_by_vcpu_id\n", __func__);
+        CPU_FOREACH(cpu_state) {
+            DPRINTF("%s: cpu_by_vcpu_id[%d]=3D%p\n",
+                    __func__, cpu_state->cpu_index, cpu_state);
+            state->cpu_by_vcpu_id[cpu_state->cpu_index] =3D cpu_state;
+        }
+        qemu_set_fd_handler(evtchn_fd, cpu_handle_ioreq, NULL, state);
+    }
+}
+
+
+static void xen_hvm_change_state_handler(void *opaque, int running,
+                                         RunState rstate)
+{
+    XenIOState *state =3D opaque;
+
+    if (running) {
+        xen_main_loop_prepare(state);
+    }
+
+    xen_set_ioreq_server_state(xen_xc, xen_domid,
+                               state->ioservid,
+                               (rstate =3D=3D RUN_STATE_RUNNING));
+}
+
+static void xen_exit_notifier(Notifier *n, void *data)
+{
+    XenIOState *state =3D container_of(n, XenIOState, exit);
+
+    xenevtchn_close(state->xce_handle);
+    xs_daemon_close(state->xenstore);
+}
+
+static void xen_read_physmap(XenIOState *state)
+{
+    XenPhysmap *physmap =3D NULL;
+    unsigned int len, num, i;
+    char path[80], *value =3D NULL;
+    char **entries =3D NULL;
+
+    snprintf(path, sizeof(path),
+            "/local/domain/0/device-model/%d/physmap", xen_domid);
+    entries =3D xs_directory(state->xenstore, 0, path, &num);
+    if (entries =3D=3D NULL)
+        return;
+
+    for (i =3D 0; i < num; i++) {
+        physmap =3D g_malloc(sizeof (XenPhysmap));
+        physmap->phys_offset =3D strtoull(entries[i], NULL, 16);
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%s/start_addr",
+                xen_domid, entries[i]);
+        value =3D xs_read(state->xenstore, 0, path, &len);
+        if (value =3D=3D NULL) {
+            g_free(physmap);
+            continue;
+        }
+        physmap->start_addr =3D strtoull(value, NULL, 16);
+        free(value);
+
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%s/size",
+                xen_domid, entries[i]);
+        value =3D xs_read(state->xenstore, 0, path, &len);
+        if (value =3D=3D NULL) {
+            g_free(physmap);
+            continue;
+        }
+        physmap->size =3D strtoull(value, NULL, 16);
+        free(value);
+
+        snprintf(path, sizeof(path),
+                "/local/domain/0/device-model/%d/physmap/%s/name",
+                xen_domid, entries[i]);
+        physmap->name =3D xs_read(state->xenstore, 0, path, &len);
+
+        QLIST_INSERT_HEAD(&state->physmap, physmap, list);
+    }
+    free(entries);
+}
+
+static void xen_wakeup_notifier(Notifier *notifier, void *data)
+{
+    xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
+}
+
+void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
+{
+    int i, rc;
+    xen_pfn_t ioreq_pfn;
+    xen_pfn_t bufioreq_pfn;
+    evtchn_port_t bufioreq_evtchn;
+    XenIOState *state;
+
+    state =3D g_malloc0(sizeof (XenIOState));
+
+    state->xce_handle =3D xenevtchn_open(NULL, 0);
+    if (state->xce_handle =3D=3D NULL) {
+        perror("xen: event channel open");
+        goto err;
+    }
+
+    state->xenstore =3D xs_daemon_open();
+    if (state->xenstore =3D=3D NULL) {
+        perror("xen: xenstore open");
+        goto err;
+    }
+
+    xen_create_ioreq_server(xen_xc, xen_domid, &state->ioservid);
+
+    state->exit.notify =3D xen_exit_notifier;
+    qemu_add_exit_notifier(&state->exit);
+
+    state->suspend.notify =3D xen_suspend_notifier;
+    qemu_register_suspend_notifier(&state->suspend);
+
+    state->wakeup.notify =3D xen_wakeup_notifier;
+    qemu_register_wakeup_notifier(&state->wakeup);
+
+    rc =3D xen_get_ioreq_server_info(xen_xc, xen_domid, state->ioservid,
+                                   &ioreq_pfn, &bufioreq_pfn,
+                                   &bufioreq_evtchn);
+    if (rc < 0) {
+        error_report("failed to get ioreq server info: error %d handle=3D%=
p",
+                     errno, xen_xc);
+        goto err;
+    }
+
+    DPRINTF("shared page at pfn %lx\n", ioreq_pfn);
+    DPRINTF("buffered io page at pfn %lx\n", bufioreq_pfn);
+    DPRINTF("buffered io evtchn is %x\n", bufioreq_evtchn);
+
+    state->shared_page =3D xenforeignmemory_map(xen_fmem, xen_domid,
+                                              PROT_READ|PROT_WRITE,
+                                              1, &ioreq_pfn, NULL);
+    if (state->shared_page =3D=3D NULL) {
+        error_report("map shared IO page returned error %d handle=3D%p",
+                     errno, xen_xc);
+        goto err;
+    }
+
+    rc =3D xen_get_vmport_regs_pfn(xen_xc, xen_domid, &ioreq_pfn);
+    if (!rc) {
+        DPRINTF("shared vmport page at pfn %lx\n", ioreq_pfn);
+        state->shared_vmport_page =3D
+            xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PROT_WRITE=
,
+                                 1, &ioreq_pfn, NULL);
+        if (state->shared_vmport_page =3D=3D NULL) {
+            error_report("map shared vmport IO page returned error %d hand=
le=3D%p",
+                         errno, xen_xc);
+            goto err;
+        }
+    } else if (rc !=3D -ENOSYS) {
+        error_report("get vmport regs pfn returned error %d, rc=3D%d",
+                     errno, rc);
+        goto err;
+    }
+
+    state->buffered_io_page =3D xenforeignmemory_map(xen_fmem, xen_domid,
+                                                   PROT_READ|PROT_WRITE,
+                                                   1, &bufioreq_pfn, NULL)=
;
+    if (state->buffered_io_page =3D=3D NULL) {
+        error_report("map buffered IO page returned error %d", errno);
+        goto err;
+    }
+
+    /* Note: cpus is empty at this point in init */
+    state->cpu_by_vcpu_id =3D g_malloc0(max_cpus * sizeof(CPUState *));
+
+    rc =3D xen_set_ioreq_server_state(xen_xc, xen_domid, state->ioservid, =
true);
+    if (rc < 0) {
+        error_report("failed to enable ioreq server info: error %d handle=
=3D%p",
+                     errno, xen_xc);
+        goto err;
+    }
+
+    state->ioreq_local_port =3D g_malloc0(max_cpus * sizeof (evtchn_port_t=
));
+
+    /* FIXME: how about if we overflow the page here? */
+    for (i =3D 0; i < max_cpus; i++) {
+        rc =3D xenevtchn_bind_interdomain(state->xce_handle, xen_domid,
+                                        xen_vcpu_eport(state->shared_page,=
 i));
+        if (rc =3D=3D -1) {
+            error_report("shared evtchn %d bind error %d", i, errno);
+            goto err;
+        }
+        state->ioreq_local_port[i] =3D rc;
+    }
+
+    rc =3D xenevtchn_bind_interdomain(state->xce_handle, xen_domid,
+                                    bufioreq_evtchn);
+    if (rc =3D=3D -1) {
+        error_report("buffered evtchn bind error %d", errno);
+        goto err;
+    }
+    state->bufioreq_local_port =3D rc;
+
+    /* Init RAM management */
+    xen_map_cache_init(xen_phys_offset_to_gaddr, state);
+    xen_ram_init(pcms, ram_size, ram_memory);
+
+    qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
+
+    state->memory_listener =3D xen_memory_listener;
+    QLIST_INIT(&state->physmap);
+    memory_listener_register(&state->memory_listener, &address_space_memor=
y);
+    state->log_for_dirtybit =3D NULL;
+
+    state->io_listener =3D xen_io_listener;
+    memory_listener_register(&state->io_listener, &address_space_io);
+
+    state->device_listener =3D xen_device_listener;
+    device_listener_register(&state->device_listener);
+
+    /* Initialize backend core & drivers */
+    if (xen_be_init() !=3D 0) {
+        error_report("xen backend core setup failed");
+        goto err;
+    }
+    xen_be_register_common();
+    xen_read_physmap(state);
+
+    /* Disable ACPI build because Xen handles it */
+    pcms->acpi_build_enabled =3D false;
+
+    return;
+
+err:
+    error_report("xen hardware virtual machine initialisation failed");
+    exit(1);
+}
+
+void destroy_hvm_domain(bool reboot)
+{
+    xc_interface *xc_handle;
+    int sts;
+
+    xc_handle =3D xc_interface_open(0, 0, 0);
+    if (xc_handle =3D=3D NULL) {
+        fprintf(stderr, "Cannot acquire xenctrl handle\n");
+    } else {
+        sts =3D xc_domain_shutdown(xc_handle, xen_domid,
+                                 reboot ? SHUTDOWN_reboot : SHUTDOWN_power=
off);
+        if (sts !=3D 0) {
+            fprintf(stderr, "xc_domain_shutdown failed to issue %s, "
+                    "sts %d, %s\n", reboot ? "reboot" : "poweroff",
+                    sts, strerror(errno));
+        } else {
+            fprintf(stderr, "Issued domain %d %s\n", xen_domid,
+                    reboot ? "reboot" : "poweroff");
+        }
+        xc_interface_close(xc_handle);
+    }
+}
+
+void xen_register_framebuffer(MemoryRegion *mr)
+{
+    framebuffer =3D mr;
+}
+
+void xen_shutdown_fatal_error(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vfprintf(stderr, fmt, ap);
+    va_end(ap);
+    fprintf(stderr, "Will destroy the domain.\n");
+    /* destroy the domain */
+    qemu_system_shutdown_request();
+}
+
+void xen_modified_memory(ram_addr_t start, ram_addr_t length)
+{
+    if (unlikely(xen_in_migration)) {
+        int rc;
+        ram_addr_t start_pfn, nb_pages;
+
+        if (length =3D=3D 0) {
+            length =3D TARGET_PAGE_SIZE;
+        }
+        start_pfn =3D start >> TARGET_PAGE_BITS;
+        nb_pages =3D ((start + length + TARGET_PAGE_SIZE - 1) >> TARGET_PA=
GE_BITS)
+            - start_pfn;
+        rc =3D xc_hvm_modified_memory(xen_xc, xen_domid, start_pfn, nb_pag=
es);
+        if (rc) {
+            fprintf(stderr,
+                    "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s=
\n",
+                    __func__, start, nb_pages, rc, strerror(-rc));
+        }
+    }
+}
+
+void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
+{
+    if (enable) {
+        memory_global_dirty_log_start();
+    } else {
+        memory_global_dirty_log_stop();
+    }
+}
diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
index 4be3ec9..64a70bc 100644
--- a/hw/xen/Makefile.objs
+++ b/hw/xen/Makefile.objs
@@ -1,5 +1,5 @@
 # xen backend driver support
-common-obj-$(CONFIG_XEN) +=3D xen_backend.o xen_devconfig.o xen_pvdev.o
+common-obj-$(CONFIG_XEN) +=3D xen_backend.o xen_devconfig.o xen_pvdev.o xe=
n-common.o
=20
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) +=3D xen-host-pci-device.o
 obj-$(CONFIG_XEN_PCI_PASSTHROUGH) +=3D xen_pt.o xen_pt_config_init.o xen_p=
t_graphics.o xen_pt_msi.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 224f04b..f5b47bf 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -37,3 +37,5 @@ stub-obj-y +=3D target-monitor-defs.o
 stub-obj-y +=3D target-get-monitor-def.o
 stub-obj-y +=3D pc_madt_cpu_entry.o
 stub-obj-y +=3D vmgenid.o
+stub-obj-y +=3D xen-common.o
+stub-obj-y +=3D xen-hvm.o
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
new file mode 100644
index 0000000..c500325
--- /dev/null
+++ b/stubs/xen-hvm.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2010       Citrix Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/xen/xen.h"
+#include "exec/memory.h"
+#include "qmp-commands.h"
+
+int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
+{
+    return -1;
+}
+
+void xen_piix3_set_irq(void *opaque, int irq_num, int level)
+{
+}
+
+void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int =
len)
+{
+}
+
+void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
+{
+}
+
+int xen_is_pirq_msi(uint32_t msi_data)
+{
+    return 0;
+}
+
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
+                   Error **errp)
+{
+}
+
+qemu_irq *xen_interrupt_controller_init(void)
+{
+    return NULL;
+}
+
+void xen_register_framebuffer(MemoryRegion *mr)
+{
+}
+
+void xen_modified_memory(ram_addr_t start, ram_addr_t length)
+{
+}
+
+void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
+{
+}
+
+void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
+{
+}
diff --git a/trace-events b/trace-events
index b07a09b..4e14487 100644
--- a/trace-events
+++ b/trace-events
@@ -48,17 +48,6 @@ spice_vmc_register_interface(void *scd) "spice vmc regis=
tered interface %p"
 spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interfac=
e %p"
 spice_vmc_event(int event) "spice vmc event %d"
=20
-# xen-hvm.c
-xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: %#lx=
, size %#lx"
-xen_client_set_memory(uint64_t start_addr, unsigned long size, bool log_di=
rty) "%#"PRIx64" size %#lx, log_dirty %i"
-handle_ioreq(void *req, uint32_t type, uint32_t dir, uint32_t df, uint32_t=
 data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) =
"I/O=3D%p type=3D%d dir=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"P=
RIx64" count=3D%d size=3D%d"
-handle_ioreq_read(void *req, uint32_t type, uint32_t df, uint32_t data_is_=
ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%p=
 read type=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" count=
=3D%d size=3D%d"
-handle_ioreq_write(void *req, uint32_t type, uint32_t df, uint32_t data_is=
_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%=
p write type=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" coun=
t=3D%d size=3D%d"
-cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, =
uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%p pio =
dir=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" count=3D%d si=
ze=3D%d"
-cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr, uint32_t s=
ize) "I/O=3D%p pio read reg data=3D%#"PRIx64" port=3D%#"PRIx64" size=3D%d"
-cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t addr, uint32_t =
size) "I/O=3D%p pio write reg data=3D%#"PRIx64" port=3D%#"PRIx64" size=3D%d=
"
-cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr,=
 uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=3D%p cop=
y dir=3D%d df=3D%d ptr=3D%d port=3D%#"PRIx64" data=3D%#"PRIx64" count=3D%d =
size=3D%d"
-
 # xen-mapcache.c
 xen_map_cache(uint64_t phys_addr) "want %#"PRIx64
 xen_remap_bucket(uint64_t index) "index %#"PRIx64
diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
deleted file mode 100644
index c500325..0000000
--- a/xen-hvm-stub.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Copyright (C) 2010       Citrix Ltd.
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "hw/xen/xen.h"
-#include "exec/memory.h"
-#include "qmp-commands.h"
-
-int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
-{
-    return -1;
-}
-
-void xen_piix3_set_irq(void *opaque, int irq_num, int level)
-{
-}
-
-void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int =
len)
-{
-}
-
-void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
-{
-}
-
-int xen_is_pirq_msi(uint32_t msi_data)
-{
-    return 0;
-}
-
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
-                   Error **errp)
-{
-}
-
-qemu_irq *xen_interrupt_controller_init(void)
-{
-    return NULL;
-}
-
-void xen_register_framebuffer(MemoryRegion *mr)
-{
-}
-
-void xen_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-}
-
-void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
-{
-}
-
-void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
-{
-}
diff --git a/xen-hvm.c b/xen-hvm.c
deleted file mode 100644
index 5043beb..0000000
--- a/xen-hvm.c
+++ /dev/null
@@ -1,1422 +0,0 @@
-/*
- * Copyright (C) 2010       Citrix Ltd.
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-
-#include "cpu.h"
-#include "hw/pci/pci.h"
-#include "hw/i386/pc.h"
-#include "hw/i386/apic-msidef.h"
-#include "hw/xen/xen_common.h"
-#include "hw/xen/xen_backend.h"
-#include "qmp-commands.h"
-
-#include "sysemu/char.h"
-#include "qemu/error-report.h"
-#include "qemu/range.h"
-#include "sysemu/xen-mapcache.h"
-#include "trace-root.h"
-#include "exec/address-spaces.h"
-
-#include <xen/hvm/ioreq.h>
-#include <xen/hvm/params.h>
-#include <xen/hvm/e820.h>
-
-//#define DEBUG_XEN_HVM
-
-#ifdef DEBUG_XEN_HVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "xen: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
-static MemoryRegion ram_memory, ram_640k, ram_lo, ram_hi;
-static MemoryRegion *framebuffer;
-static bool xen_in_migration;
-
-/* Compatibility with older version */
-
-/* This allows QEMU to build on a system that has Xen 4.5 or earlier
- * installed.  This here (not in hw/xen/xen_common.h) because xen/hvm/iore=
q.h
- * needs to be included before this block and hw/xen/xen_common.h needs to
- * be included before xen/hvm/ioreq.h
- */
-#ifndef IOREQ_TYPE_VMWARE_PORT
-#define IOREQ_TYPE_VMWARE_PORT  3
-struct vmware_regs {
-    uint32_t esi;
-    uint32_t edi;
-    uint32_t ebx;
-    uint32_t ecx;
-    uint32_t edx;
-};
-typedef struct vmware_regs vmware_regs_t;
-
-struct shared_vmport_iopage {
-    struct vmware_regs vcpu_vmport_regs[1];
-};
-typedef struct shared_vmport_iopage shared_vmport_iopage_t;
-#endif
-
-static inline uint32_t xen_vcpu_eport(shared_iopage_t *shared_page, int i)
-{
-    return shared_page->vcpu_ioreq[i].vp_eport;
-}
-static inline ioreq_t *xen_vcpu_ioreq(shared_iopage_t *shared_page, int vc=
pu)
-{
-    return &shared_page->vcpu_ioreq[vcpu];
-}
-
-#define BUFFER_IO_MAX_DELAY  100
-
-typedef struct XenPhysmap {
-    hwaddr start_addr;
-    ram_addr_t size;
-    const char *name;
-    hwaddr phys_offset;
-
-    QLIST_ENTRY(XenPhysmap) list;
-} XenPhysmap;
-
-typedef struct XenIOState {
-    ioservid_t ioservid;
-    shared_iopage_t *shared_page;
-    shared_vmport_iopage_t *shared_vmport_page;
-    buffered_iopage_t *buffered_io_page;
-    QEMUTimer *buffered_io_timer;
-    CPUState **cpu_by_vcpu_id;
-    /* the evtchn port for polling the notification, */
-    evtchn_port_t *ioreq_local_port;
-    /* evtchn local port for buffered io */
-    evtchn_port_t bufioreq_local_port;
-    /* the evtchn fd for polling */
-    xenevtchn_handle *xce_handle;
-    /* which vcpu we are serving */
-    int send_vcpu;
-
-    struct xs_handle *xenstore;
-    MemoryListener memory_listener;
-    MemoryListener io_listener;
-    DeviceListener device_listener;
-    QLIST_HEAD(, XenPhysmap) physmap;
-    hwaddr free_phys_offset;
-    const XenPhysmap *log_for_dirtybit;
-
-    Notifier exit;
-    Notifier suspend;
-    Notifier wakeup;
-} XenIOState;
-
-/* Xen specific function for piix pci */
-
-int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
-{
-    return irq_num + ((pci_dev->devfn >> 3) << 2);
-}
-
-void xen_piix3_set_irq(void *opaque, int irq_num, int level)
-{
-    xc_hvm_set_pci_intx_level(xen_xc, xen_domid, 0, 0, irq_num >> 2,
-                              irq_num & 3, level);
-}
-
-void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int =
len)
-{
-    int i;
-
-    /* Scan for updates to PCI link routes (0x60-0x63). */
-    for (i =3D 0; i < len; i++) {
-        uint8_t v =3D (val >> (8 * i)) & 0xff;
-        if (v & 0x80) {
-            v =3D 0;
-        }
-        v &=3D 0xf;
-        if (((address + i) >=3D 0x60) && ((address + i) <=3D 0x63)) {
-            xc_hvm_set_pci_link_route(xen_xc, xen_domid, address + i - 0x6=
0, v);
-        }
-    }
-}
-
-int xen_is_pirq_msi(uint32_t msi_data)
-{
-    /* If vector is 0, the msi is remapped into a pirq, passed as
-     * dest_id.
-     */
-    return ((msi_data & MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT) =
=3D=3D 0;
-}
-
-void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
-{
-    xc_hvm_inject_msi(xen_xc, xen_domid, addr, data);
-}
-
-static void xen_suspend_notifier(Notifier *notifier, void *data)
-{
-    xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 3);
-}
-
-/* Xen Interrupt Controller */
-
-static void xen_set_irq(void *opaque, int irq, int level)
-{
-    xc_hvm_set_isa_irq_level(xen_xc, xen_domid, irq, level);
-}
-
-qemu_irq *xen_interrupt_controller_init(void)
-{
-    return qemu_allocate_irqs(xen_set_irq, NULL, 16);
-}
-
-/* Memory Ops */
-
-static void xen_ram_init(PCMachineState *pcms,
-                         ram_addr_t ram_size, MemoryRegion **ram_memory_p)
-{
-    MemoryRegion *sysmem =3D get_system_memory();
-    ram_addr_t block_len;
-    uint64_t user_lowmem =3D object_property_get_int(qdev_get_machine(),
-                                                   PC_MACHINE_MAX_RAM_BELO=
W_4G,
-                                                   &error_abort);
-
-    /* Handle the machine opt max-ram-below-4g.  It is basically doing
-     * min(xen limit, user limit).
-     */
-    if (!user_lowmem) {
-        user_lowmem =3D HVM_BELOW_4G_RAM_END; /* default */
-    }
-    if (HVM_BELOW_4G_RAM_END <=3D user_lowmem) {
-        user_lowmem =3D HVM_BELOW_4G_RAM_END;
-    }
-
-    if (ram_size >=3D user_lowmem) {
-        pcms->above_4g_mem_size =3D ram_size - user_lowmem;
-        pcms->below_4g_mem_size =3D user_lowmem;
-    } else {
-        pcms->above_4g_mem_size =3D 0;
-        pcms->below_4g_mem_size =3D ram_size;
-    }
-    if (!pcms->above_4g_mem_size) {
-        block_len =3D ram_size;
-    } else {
-        /*
-         * Xen does not allocate the memory continuously, it keeps a
-         * hole of the size computed above or passed in.
-         */
-        block_len =3D (1ULL << 32) + pcms->above_4g_mem_size;
-    }
-    memory_region_init_ram(&ram_memory, NULL, "xen.ram", block_len,
-                           &error_fatal);
-    *ram_memory_p =3D &ram_memory;
-    vmstate_register_ram_global(&ram_memory);
-
-    memory_region_init_alias(&ram_640k, NULL, "xen.ram.640k",
-                             &ram_memory, 0, 0xa0000);
-    memory_region_add_subregion(sysmem, 0, &ram_640k);
-    /* Skip of the VGA IO memory space, it will be registered later by the=
 VGA
-     * emulated device.
-     *
-     * The area between 0xc0000 and 0x100000 will be used by SeaBIOS to lo=
ad
-     * the Options ROM, so it is registered here as RAM.
-     */
-    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo",
-                             &ram_memory, 0xc0000,
-                             pcms->below_4g_mem_size - 0xc0000);
-    memory_region_add_subregion(sysmem, 0xc0000, &ram_lo);
-    if (pcms->above_4g_mem_size > 0) {
-        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi",
-                                 &ram_memory, 0x100000000ULL,
-                                 pcms->above_4g_mem_size);
-        memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
-    }
-}
-
-void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
-                   Error **errp)
-{
-    unsigned long nr_pfn;
-    xen_pfn_t *pfn_list;
-    int i;
-
-    if (runstate_check(RUN_STATE_INMIGRATE)) {
-        /* RAM already populated in Xen */
-        fprintf(stderr, "%s: do not alloc "RAM_ADDR_FMT
-                " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGRAT=
E\n",
-                __func__, size, ram_addr);=20
-        return;
-    }
-
-    if (mr =3D=3D &ram_memory) {
-        return;
-    }
-
-    trace_xen_ram_alloc(ram_addr, size);
-
-    nr_pfn =3D size >> TARGET_PAGE_BITS;
-    pfn_list =3D g_malloc(sizeof (*pfn_list) * nr_pfn);
-
-    for (i =3D 0; i < nr_pfn; i++) {
-        pfn_list[i] =3D (ram_addr >> TARGET_PAGE_BITS) + i;
-    }
-
-    if (xc_domain_populate_physmap_exact(xen_xc, xen_domid, nr_pfn, 0, 0, =
pfn_list)) {
-        error_setg(errp, "xen: failed to populate ram at " RAM_ADDR_FMT,
-                   ram_addr);
-    }
-
-    g_free(pfn_list);
-}
-
-static XenPhysmap *get_physmapping(XenIOState *state,
-                                   hwaddr start_addr, ram_addr_t size)
-{
-    XenPhysmap *physmap =3D NULL;
-
-    start_addr &=3D TARGET_PAGE_MASK;
-
-    QLIST_FOREACH(physmap, &state->physmap, list) {
-        if (range_covers_byte(physmap->start_addr, physmap->size, start_ad=
dr)) {
-            return physmap;
-        }
-    }
-    return NULL;
-}
-
-static hwaddr xen_phys_offset_to_gaddr(hwaddr start_addr,
-                                                   ram_addr_t size, void *=
opaque)
-{
-    hwaddr addr =3D start_addr & TARGET_PAGE_MASK;
-    XenIOState *xen_io_state =3D opaque;
-    XenPhysmap *physmap =3D NULL;
-
-    QLIST_FOREACH(physmap, &xen_io_state->physmap, list) {
-        if (range_covers_byte(physmap->phys_offset, physmap->size, addr)) =
{
-            return physmap->start_addr;
-        }
-    }
-
-    return start_addr;
-}
-
-static int xen_add_to_physmap(XenIOState *state,
-                              hwaddr start_addr,
-                              ram_addr_t size,
-                              MemoryRegion *mr,
-                              hwaddr offset_within_region)
-{
-    unsigned long i =3D 0;
-    int rc =3D 0;
-    XenPhysmap *physmap =3D NULL;
-    hwaddr pfn, start_gpfn;
-    hwaddr phys_offset =3D memory_region_get_ram_addr(mr);
-    char path[80], value[17];
-    const char *mr_name;
-
-    if (get_physmapping(state, start_addr, size)) {
-        return 0;
-    }
-    if (size <=3D 0) {
-        return -1;
-    }
-
-    /* Xen can only handle a single dirty log region for now and we want
-     * the linear framebuffer to be that region.
-     * Avoid tracking any regions that is not videoram and avoid tracking
-     * the legacy vga region. */
-    if (mr =3D=3D framebuffer && start_addr > 0xbffff) {
-        goto go_physmap;
-    }
-    return -1;
-
-go_physmap:
-    DPRINTF("mapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx"\n",
-            start_addr, start_addr + size);
-
-    pfn =3D phys_offset >> TARGET_PAGE_BITS;
-    start_gpfn =3D start_addr >> TARGET_PAGE_BITS;
-    for (i =3D 0; i < size >> TARGET_PAGE_BITS; i++) {
-        unsigned long idx =3D pfn + i;
-        xen_pfn_t gpfn =3D start_gpfn + i;
-
-        rc =3D xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE=
_gmfn, idx, gpfn);
-        if (rc) {
-            DPRINTF("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
-                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc,=
 errno);
-            return -rc;
-        }
-    }
-
-    mr_name =3D memory_region_name(mr);
-
-    physmap =3D g_malloc(sizeof (XenPhysmap));
-
-    physmap->start_addr =3D start_addr;
-    physmap->size =3D size;
-    physmap->name =3D mr_name;
-    physmap->phys_offset =3D phys_offset;
-
-    QLIST_INSERT_HEAD(&state->physmap, physmap, list);
-
-    xc_domain_pin_memory_cacheattr(xen_xc, xen_domid,
-                                   start_addr >> TARGET_PAGE_BITS,
-                                   (start_addr + size - 1) >> TARGET_PAGE_=
BITS,
-                                   XEN_DOMCTL_MEM_CACHEATTR_WB);
-
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/start_addr"=
,
-            xen_domid, (uint64_t)phys_offset);
-    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)start_addr);
-    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
-        return -1;
-    }
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap/%"PRIx64"/size",
-            xen_domid, (uint64_t)phys_offset);
-    snprintf(value, sizeof(value), "%"PRIx64, (uint64_t)size);
-    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
-        return -1;
-    }
-    if (mr_name) {
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%"PRIx64"/name",
-                xen_domid, (uint64_t)phys_offset);
-        if (!xs_write(state->xenstore, 0, path, mr_name, strlen(mr_name)))=
 {
-            return -1;
-        }
-    }
-
-    return 0;
-}
-
-static int xen_remove_from_physmap(XenIOState *state,
-                                   hwaddr start_addr,
-                                   ram_addr_t size)
-{
-    unsigned long i =3D 0;
-    int rc =3D 0;
-    XenPhysmap *physmap =3D NULL;
-    hwaddr phys_offset =3D 0;
-
-    physmap =3D get_physmapping(state, start_addr, size);
-    if (physmap =3D=3D NULL) {
-        return -1;
-    }
-
-    phys_offset =3D physmap->phys_offset;
-    size =3D physmap->size;
-
-    DPRINTF("unmapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx", at "
-            "%"HWADDR_PRIx"\n", start_addr, start_addr + size, phys_offset=
);
-
-    size >>=3D TARGET_PAGE_BITS;
-    start_addr >>=3D TARGET_PAGE_BITS;
-    phys_offset >>=3D TARGET_PAGE_BITS;
-    for (i =3D 0; i < size; i++) {
-        xen_pfn_t idx =3D start_addr + i;
-        xen_pfn_t gpfn =3D phys_offset + i;
-
-        rc =3D xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE=
_gmfn, idx, gpfn);
-        if (rc) {
-            fprintf(stderr, "add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
-                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc,=
 errno);
-            return -rc;
-        }
-    }
-
-    QLIST_REMOVE(physmap, list);
-    if (state->log_for_dirtybit =3D=3D physmap) {
-        state->log_for_dirtybit =3D NULL;
-    }
-    g_free(physmap);
-
-    return 0;
-}
-
-static void xen_set_memory(struct MemoryListener *listener,
-                           MemoryRegionSection *section,
-                           bool add)
-{
-    XenIOState *state =3D container_of(listener, XenIOState, memory_listen=
er);
-    hwaddr start_addr =3D section->offset_within_address_space;
-    ram_addr_t size =3D int128_get64(section->size);
-    bool log_dirty =3D memory_region_is_logging(section->mr, DIRTY_MEMORY_=
VGA);
-    hvmmem_type_t mem_type;
-
-    if (section->mr =3D=3D &ram_memory) {
-        return;
-    } else {
-        if (add) {
-            xen_map_memory_section(xen_xc, xen_domid, state->ioservid,
-                                   section);
-        } else {
-            xen_unmap_memory_section(xen_xc, xen_domid, state->ioservid,
-                                     section);
-        }
-    }
-
-    if (!memory_region_is_ram(section->mr)) {
-        return;
-    }
-
-    if (log_dirty !=3D add) {
-        return;
-    }
-
-    trace_xen_client_set_memory(start_addr, size, log_dirty);
-
-    start_addr &=3D TARGET_PAGE_MASK;
-    size =3D TARGET_PAGE_ALIGN(size);
-
-    if (add) {
-        if (!memory_region_is_rom(section->mr)) {
-            xen_add_to_physmap(state, start_addr, size,
-                               section->mr, section->offset_within_region)=
;
-        } else {
-            mem_type =3D HVMMEM_ram_ro;
-            if (xc_hvm_set_mem_type(xen_xc, xen_domid, mem_type,
-                                    start_addr >> TARGET_PAGE_BITS,
-                                    size >> TARGET_PAGE_BITS)) {
-                DPRINTF("xc_hvm_set_mem_type error, addr: "TARGET_FMT_plx"=
\n",
-                        start_addr);
-            }
-        }
-    } else {
-        if (xen_remove_from_physmap(state, start_addr, size) < 0) {
-            DPRINTF("physmapping does not exist at "TARGET_FMT_plx"\n", st=
art_addr);
-        }
-    }
-}
-
-static void xen_region_add(MemoryListener *listener,
-                           MemoryRegionSection *section)
-{
-    memory_region_ref(section->mr);
-    xen_set_memory(listener, section, true);
-}
-
-static void xen_region_del(MemoryListener *listener,
-                           MemoryRegionSection *section)
-{
-    xen_set_memory(listener, section, false);
-    memory_region_unref(section->mr);
-}
-
-static void xen_io_add(MemoryListener *listener,
-                       MemoryRegionSection *section)
-{
-    XenIOState *state =3D container_of(listener, XenIOState, io_listener);
-    MemoryRegion *mr =3D section->mr;
-
-    if (mr->ops =3D=3D &unassigned_io_ops) {
-        return;
-    }
-
-    memory_region_ref(mr);
-
-    xen_map_io_section(xen_xc, xen_domid, state->ioservid, section);
-}
-
-static void xen_io_del(MemoryListener *listener,
-                       MemoryRegionSection *section)
-{
-    XenIOState *state =3D container_of(listener, XenIOState, io_listener);
-    MemoryRegion *mr =3D section->mr;
-
-    if (mr->ops =3D=3D &unassigned_io_ops) {
-        return;
-    }
-
-    xen_unmap_io_section(xen_xc, xen_domid, state->ioservid, section);
-
-    memory_region_unref(mr);
-}
-
-static void xen_device_realize(DeviceListener *listener,
-			       DeviceState *dev)
-{
-    XenIOState *state =3D container_of(listener, XenIOState, device_listen=
er);
-
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        PCIDevice *pci_dev =3D PCI_DEVICE(dev);
-
-        xen_map_pcidev(xen_xc, xen_domid, state->ioservid, pci_dev);
-    }
-}
-
-static void xen_device_unrealize(DeviceListener *listener,
-				 DeviceState *dev)
-{
-    XenIOState *state =3D container_of(listener, XenIOState, device_listen=
er);
-
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        PCIDevice *pci_dev =3D PCI_DEVICE(dev);
-
-        xen_unmap_pcidev(xen_xc, xen_domid, state->ioservid, pci_dev);
-    }
-}
-
-static void xen_sync_dirty_bitmap(XenIOState *state,
-                                  hwaddr start_addr,
-                                  ram_addr_t size)
-{
-    hwaddr npages =3D size >> TARGET_PAGE_BITS;
-    const int width =3D sizeof(unsigned long) * 8;
-    unsigned long bitmap[DIV_ROUND_UP(npages, width)];
-    int rc, i, j;
-    const XenPhysmap *physmap =3D NULL;
-
-    physmap =3D get_physmapping(state, start_addr, size);
-    if (physmap =3D=3D NULL) {
-        /* not handled */
-        return;
-    }
-
-    if (state->log_for_dirtybit =3D=3D NULL) {
-        state->log_for_dirtybit =3D physmap;
-    } else if (state->log_for_dirtybit !=3D physmap) {
-        /* Only one range for dirty bitmap can be tracked. */
-        return;
-    }
-
-    rc =3D xc_hvm_track_dirty_vram(xen_xc, xen_domid,
-                                 start_addr >> TARGET_PAGE_BITS, npages,
-                                 bitmap);
-    if (rc < 0) {
-#ifndef ENODATA
-#define ENODATA  ENOENT
-#endif
-        if (errno =3D=3D ENODATA) {
-            memory_region_set_dirty(framebuffer, 0, size);
-            DPRINTF("xen: track_dirty_vram failed (0x" TARGET_FMT_plx
-                    ", 0x" TARGET_FMT_plx "): %s\n",
-                    start_addr, start_addr + size, strerror(errno));
-        }
-        return;
-    }
-
-    for (i =3D 0; i < ARRAY_SIZE(bitmap); i++) {
-        unsigned long map =3D bitmap[i];
-        while (map !=3D 0) {
-            j =3D ctzl(map);
-            map &=3D ~(1ul << j);
-            memory_region_set_dirty(framebuffer,
-                                    (i * width + j) * TARGET_PAGE_SIZE,
-                                    TARGET_PAGE_SIZE);
-        };
-    }
-}
-
-static void xen_log_start(MemoryListener *listener,
-                          MemoryRegionSection *section,
-                          int old, int new)
-{
-    XenIOState *state =3D container_of(listener, XenIOState, memory_listen=
er);
-
-    if (new & ~old & (1 << DIRTY_MEMORY_VGA)) {
-        xen_sync_dirty_bitmap(state, section->offset_within_address_space,
-                              int128_get64(section->size));
-    }
-}
-
-static void xen_log_stop(MemoryListener *listener, MemoryRegionSection *se=
ction,
-                         int old, int new)
-{
-    XenIOState *state =3D container_of(listener, XenIOState, memory_listen=
er);
-
-    if (old & ~new & (1 << DIRTY_MEMORY_VGA)) {
-        state->log_for_dirtybit =3D NULL;
-        /* Disable dirty bit tracking */
-        xc_hvm_track_dirty_vram(xen_xc, xen_domid, 0, 0, NULL);
-    }
-}
-
-static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *se=
ction)
-{
-    XenIOState *state =3D container_of(listener, XenIOState, memory_listen=
er);
-
-    xen_sync_dirty_bitmap(state, section->offset_within_address_space,
-                          int128_get64(section->size));
-}
-
-static void xen_log_global_start(MemoryListener *listener)
-{
-    if (xen_enabled()) {
-        xen_in_migration =3D true;
-    }
-}
-
-static void xen_log_global_stop(MemoryListener *listener)
-{
-    xen_in_migration =3D false;
-}
-
-static MemoryListener xen_memory_listener =3D {
-    .region_add =3D xen_region_add,
-    .region_del =3D xen_region_del,
-    .log_start =3D xen_log_start,
-    .log_stop =3D xen_log_stop,
-    .log_sync =3D xen_log_sync,
-    .log_global_start =3D xen_log_global_start,
-    .log_global_stop =3D xen_log_global_stop,
-    .priority =3D 10,
-};
-
-static MemoryListener xen_io_listener =3D {
-    .region_add =3D xen_io_add,
-    .region_del =3D xen_io_del,
-    .priority =3D 10,
-};
-
-static DeviceListener xen_device_listener =3D {
-    .realize =3D xen_device_realize,
-    .unrealize =3D xen_device_unrealize,
-};
-
-/* get the ioreq packets from share mem */
-static ioreq_t *cpu_get_ioreq_from_shared_memory(XenIOState *state, int vc=
pu)
-{
-    ioreq_t *req =3D xen_vcpu_ioreq(state->shared_page, vcpu);
-
-    if (req->state !=3D STATE_IOREQ_READY) {
-        DPRINTF("I/O request not ready: "
-                "%x, ptr: %x, port: %"PRIx64", "
-                "data: %"PRIx64", count: %u, size: %u\n",
-                req->state, req->data_is_ptr, req->addr,
-                req->data, req->count, req->size);
-        return NULL;
-    }
-
-    xen_rmb(); /* see IOREQ_READY /then/ read contents of ioreq */
-
-    req->state =3D STATE_IOREQ_INPROCESS;
-    return req;
-}
-
-/* use poll to get the port notification */
-/* ioreq_vec--out,the */
-/* retval--the number of ioreq packet */
-static ioreq_t *cpu_get_ioreq(XenIOState *state)
-{
-    int i;
-    evtchn_port_t port;
-
-    port =3D xenevtchn_pending(state->xce_handle);
-    if (port =3D=3D state->bufioreq_local_port) {
-        timer_mod(state->buffered_io_timer,
-                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIM=
E));
-        return NULL;
-    }
-
-    if (port !=3D -1) {
-        for (i =3D 0; i < max_cpus; i++) {
-            if (state->ioreq_local_port[i] =3D=3D port) {
-                break;
-            }
-        }
-
-        if (i =3D=3D max_cpus) {
-            hw_error("Fatal error while trying to get io event!\n");
-        }
-
-        /* unmask the wanted port again */
-        xenevtchn_unmask(state->xce_handle, port);
-
-        /* get the io packet from shared memory */
-        state->send_vcpu =3D i;
-        return cpu_get_ioreq_from_shared_memory(state, i);
-    }
-
-    /* read error or read nothing */
-    return NULL;
-}
-
-static uint32_t do_inp(uint32_t addr, unsigned long size)
-{
-    switch (size) {
-        case 1:
-            return cpu_inb(addr);
-        case 2:
-            return cpu_inw(addr);
-        case 4:
-            return cpu_inl(addr);
-        default:
-            hw_error("inp: bad size: %04x %lx", addr, size);
-    }
-}
-
-static void do_outp(uint32_t addr,
-        unsigned long size, uint32_t val)
-{
-    switch (size) {
-        case 1:
-            return cpu_outb(addr, val);
-        case 2:
-            return cpu_outw(addr, val);
-        case 4:
-            return cpu_outl(addr, val);
-        default:
-            hw_error("outp: bad size: %04x %lx", addr, size);
-    }
-}
-
-/*
- * Helper functions which read/write an object from/to physical guest
- * memory, as part of the implementation of an ioreq.
- *
- * Equivalent to
- *   cpu_physical_memory_rw(addr + (req->df ? -1 : +1) * req->size * i,
- *                          val, req->size, 0/1)
- * except without the integer overflow problems.
- */
-static void rw_phys_req_item(hwaddr addr,
-                             ioreq_t *req, uint32_t i, void *val, int rw)
-{
-    /* Do everything unsigned so overflow just results in a truncated resu=
lt
-     * and accesses to undesired parts of guest memory, which is up
-     * to the guest */
-    hwaddr offset =3D (hwaddr)req->size * i;
-    if (req->df) {
-        addr -=3D offset;
-    } else {
-        addr +=3D offset;
-    }
-    cpu_physical_memory_rw(addr, val, req->size, rw);
-}
-
-static inline void read_phys_req_item(hwaddr addr,
-                                      ioreq_t *req, uint32_t i, void *val)
-{
-    rw_phys_req_item(addr, req, i, val, 0);
-}
-static inline void write_phys_req_item(hwaddr addr,
-                                       ioreq_t *req, uint32_t i, void *val=
)
-{
-    rw_phys_req_item(addr, req, i, val, 1);
-}
-
-
-static void cpu_ioreq_pio(ioreq_t *req)
-{
-    uint32_t i;
-
-    trace_cpu_ioreq_pio(req, req->dir, req->df, req->data_is_ptr, req->add=
r,
-                         req->data, req->count, req->size);
-
-    if (req->size > sizeof(uint32_t)) {
-        hw_error("PIO: bad size (%u)", req->size);
-    }
-
-    if (req->dir =3D=3D IOREQ_READ) {
-        if (!req->data_is_ptr) {
-            req->data =3D do_inp(req->addr, req->size);
-            trace_cpu_ioreq_pio_read_reg(req, req->data, req->addr,
-                                         req->size);
-        } else {
-            uint32_t tmp;
-
-            for (i =3D 0; i < req->count; i++) {
-                tmp =3D do_inp(req->addr, req->size);
-                write_phys_req_item(req->data, req, i, &tmp);
-            }
-        }
-    } else if (req->dir =3D=3D IOREQ_WRITE) {
-        if (!req->data_is_ptr) {
-            trace_cpu_ioreq_pio_write_reg(req, req->data, req->addr,
-                                          req->size);
-            do_outp(req->addr, req->size, req->data);
-        } else {
-            for (i =3D 0; i < req->count; i++) {
-                uint32_t tmp =3D 0;
-
-                read_phys_req_item(req->data, req, i, &tmp);
-                do_outp(req->addr, req->size, tmp);
-            }
-        }
-    }
-}
-
-static void cpu_ioreq_move(ioreq_t *req)
-{
-    uint32_t i;
-
-    trace_cpu_ioreq_move(req, req->dir, req->df, req->data_is_ptr, req->ad=
dr,
-                         req->data, req->count, req->size);
-
-    if (req->size > sizeof(req->data)) {
-        hw_error("MMIO: bad size (%u)", req->size);
-    }
-
-    if (!req->data_is_ptr) {
-        if (req->dir =3D=3D IOREQ_READ) {
-            for (i =3D 0; i < req->count; i++) {
-                read_phys_req_item(req->addr, req, i, &req->data);
-            }
-        } else if (req->dir =3D=3D IOREQ_WRITE) {
-            for (i =3D 0; i < req->count; i++) {
-                write_phys_req_item(req->addr, req, i, &req->data);
-            }
-        }
-    } else {
-        uint64_t tmp;
-
-        if (req->dir =3D=3D IOREQ_READ) {
-            for (i =3D 0; i < req->count; i++) {
-                read_phys_req_item(req->addr, req, i, &tmp);
-                write_phys_req_item(req->data, req, i, &tmp);
-            }
-        } else if (req->dir =3D=3D IOREQ_WRITE) {
-            for (i =3D 0; i < req->count; i++) {
-                read_phys_req_item(req->data, req, i, &tmp);
-                write_phys_req_item(req->addr, req, i, &tmp);
-            }
-        }
-    }
-}
-
-static void regs_to_cpu(vmware_regs_t *vmport_regs, ioreq_t *req)
-{
-    X86CPU *cpu;
-    CPUX86State *env;
-
-    cpu =3D X86_CPU(current_cpu);
-    env =3D &cpu->env;
-    env->regs[R_EAX] =3D req->data;
-    env->regs[R_EBX] =3D vmport_regs->ebx;
-    env->regs[R_ECX] =3D vmport_regs->ecx;
-    env->regs[R_EDX] =3D vmport_regs->edx;
-    env->regs[R_ESI] =3D vmport_regs->esi;
-    env->regs[R_EDI] =3D vmport_regs->edi;
-}
-
-static void regs_from_cpu(vmware_regs_t *vmport_regs)
-{
-    X86CPU *cpu =3D X86_CPU(current_cpu);
-    CPUX86State *env =3D &cpu->env;
-
-    vmport_regs->ebx =3D env->regs[R_EBX];
-    vmport_regs->ecx =3D env->regs[R_ECX];
-    vmport_regs->edx =3D env->regs[R_EDX];
-    vmport_regs->esi =3D env->regs[R_ESI];
-    vmport_regs->edi =3D env->regs[R_EDI];
-}
-
-static void handle_vmport_ioreq(XenIOState *state, ioreq_t *req)
-{
-    vmware_regs_t *vmport_regs;
-
-    assert(state->shared_vmport_page);
-    vmport_regs =3D
-        &state->shared_vmport_page->vcpu_vmport_regs[state->send_vcpu];
-    QEMU_BUILD_BUG_ON(sizeof(*req) < sizeof(*vmport_regs));
-
-    current_cpu =3D state->cpu_by_vcpu_id[state->send_vcpu];
-    regs_to_cpu(vmport_regs, req);
-    cpu_ioreq_pio(req);
-    regs_from_cpu(vmport_regs);
-    current_cpu =3D NULL;
-}
-
-static void handle_ioreq(XenIOState *state, ioreq_t *req)
-{
-    trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr=
,
-                       req->addr, req->data, req->count, req->size);
-
-    if (!req->data_is_ptr && (req->dir =3D=3D IOREQ_WRITE) &&
-            (req->size < sizeof (target_ulong))) {
-        req->data &=3D ((target_ulong) 1 << (8 * req->size)) - 1;
-    }
-
-    if (req->dir =3D=3D IOREQ_WRITE)
-        trace_handle_ioreq_write(req, req->type, req->df, req->data_is_ptr=
,
-                                 req->addr, req->data, req->count, req->si=
ze);
-
-    switch (req->type) {
-        case IOREQ_TYPE_PIO:
-            cpu_ioreq_pio(req);
-            break;
-        case IOREQ_TYPE_COPY:
-            cpu_ioreq_move(req);
-            break;
-        case IOREQ_TYPE_VMWARE_PORT:
-            handle_vmport_ioreq(state, req);
-            break;
-        case IOREQ_TYPE_TIMEOFFSET:
-            break;
-        case IOREQ_TYPE_INVALIDATE:
-            xen_invalidate_map_cache();
-            break;
-        case IOREQ_TYPE_PCI_CONFIG: {
-            uint32_t sbdf =3D req->addr >> 32;
-            uint32_t val;
-
-            /* Fake a write to port 0xCF8 so that
-             * the config space access will target the
-             * correct device model.
-             */
-            val =3D (1u << 31) |
-                  ((req->addr & 0x0f00) << 16) |
-                  ((sbdf & 0xffff) << 8) |
-                  (req->addr & 0xfc);
-            do_outp(0xcf8, 4, val);
-
-            /* Now issue the config space access via
-             * port 0xCFC
-             */
-            req->addr =3D 0xcfc | (req->addr & 0x03);
-            cpu_ioreq_pio(req);
-            break;
-        }
-        default:
-            hw_error("Invalid ioreq type 0x%x\n", req->type);
-    }
-    if (req->dir =3D=3D IOREQ_READ) {
-        trace_handle_ioreq_read(req, req->type, req->df, req->data_is_ptr,
-                                req->addr, req->data, req->count, req->siz=
e);
-    }
-}
-
-static int handle_buffered_iopage(XenIOState *state)
-{
-    buffered_iopage_t *buf_page =3D state->buffered_io_page;
-    buf_ioreq_t *buf_req =3D NULL;
-    ioreq_t req;
-    int qw;
-
-    if (!buf_page) {
-        return 0;
-    }
-
-    memset(&req, 0x00, sizeof(req));
-    req.state =3D STATE_IOREQ_READY;
-    req.count =3D 1;
-    req.dir =3D IOREQ_WRITE;
-
-    for (;;) {
-        uint32_t rdptr =3D buf_page->read_pointer, wrptr;
-
-        xen_rmb();
-        wrptr =3D buf_page->write_pointer;
-        xen_rmb();
-        if (rdptr !=3D buf_page->read_pointer) {
-            continue;
-        }
-        if (rdptr =3D=3D wrptr) {
-            break;
-        }
-        buf_req =3D &buf_page->buf_ioreq[rdptr % IOREQ_BUFFER_SLOT_NUM];
-        req.size =3D 1U << buf_req->size;
-        req.addr =3D buf_req->addr;
-        req.data =3D buf_req->data;
-        req.type =3D buf_req->type;
-        xen_rmb();
-        qw =3D (req.size =3D=3D 8);
-        if (qw) {
-            if (rdptr + 1 =3D=3D wrptr) {
-                hw_error("Incomplete quad word buffered ioreq");
-            }
-            buf_req =3D &buf_page->buf_ioreq[(rdptr + 1) %
-                                           IOREQ_BUFFER_SLOT_NUM];
-            req.data |=3D ((uint64_t)buf_req->data) << 32;
-            xen_rmb();
-        }
-
-        handle_ioreq(state, &req);
-
-        /* Only req.data may get updated by handle_ioreq(), albeit even th=
at
-         * should not happen as such data would never make it to the guest=
 (we
-         * can only usefully see writes here after all).
-         */
-        assert(req.state =3D=3D STATE_IOREQ_READY);
-        assert(req.count =3D=3D 1);
-        assert(req.dir =3D=3D IOREQ_WRITE);
-        assert(!req.data_is_ptr);
-
-        atomic_add(&buf_page->read_pointer, qw + 1);
-    }
-
-    return req.count;
-}
-
-static void handle_buffered_io(void *opaque)
-{
-    XenIOState *state =3D opaque;
-
-    if (handle_buffered_iopage(state)) {
-        timer_mod(state->buffered_io_timer,
-                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIM=
E));
-    } else {
-        timer_del(state->buffered_io_timer);
-        xenevtchn_unmask(state->xce_handle, state->bufioreq_local_port);
-    }
-}
-
-static void cpu_handle_ioreq(void *opaque)
-{
-    XenIOState *state =3D opaque;
-    ioreq_t *req =3D cpu_get_ioreq(state);
-
-    handle_buffered_iopage(state);
-    if (req) {
-        ioreq_t copy =3D *req;
-
-        xen_rmb();
-        handle_ioreq(state, &copy);
-        req->data =3D copy.data;
-
-        if (req->state !=3D STATE_IOREQ_INPROCESS) {
-            fprintf(stderr, "Badness in I/O request ... not in service?!: =
"
-                    "%x, ptr: %x, port: %"PRIx64", "
-                    "data: %"PRIx64", count: %u, size: %u, type: %u\n",
-                    req->state, req->data_is_ptr, req->addr,
-                    req->data, req->count, req->size, req->type);
-            destroy_hvm_domain(false);
-            return;
-        }
-
-        xen_wmb(); /* Update ioreq contents /then/ update state. */
-
-        /*
-         * We do this before we send the response so that the tools
-         * have the opportunity to pick up on the reset before the
-         * guest resumes and does a hlt with interrupts disabled which
-         * causes Xen to powerdown the domain.
-         */
-        if (runstate_is_running()) {
-            if (qemu_shutdown_requested_get()) {
-                destroy_hvm_domain(false);
-            }
-            if (qemu_reset_requested_get()) {
-                qemu_system_reset(VMRESET_REPORT);
-                destroy_hvm_domain(true);
-            }
-        }
-
-        req->state =3D STATE_IORESP_READY;
-        xenevtchn_notify(state->xce_handle,
-                         state->ioreq_local_port[state->send_vcpu]);
-    }
-}
-
-static void xen_main_loop_prepare(XenIOState *state)
-{
-    int evtchn_fd =3D -1;
-
-    if (state->xce_handle !=3D NULL) {
-        evtchn_fd =3D xenevtchn_fd(state->xce_handle);
-    }
-
-    state->buffered_io_timer =3D timer_new_ms(QEMU_CLOCK_REALTIME, handle_=
buffered_io,
-                                                 state);
-
-    if (evtchn_fd !=3D -1) {
-        CPUState *cpu_state;
-
-        DPRINTF("%s: Init cpu_by_vcpu_id\n", __func__);
-        CPU_FOREACH(cpu_state) {
-            DPRINTF("%s: cpu_by_vcpu_id[%d]=3D%p\n",
-                    __func__, cpu_state->cpu_index, cpu_state);
-            state->cpu_by_vcpu_id[cpu_state->cpu_index] =3D cpu_state;
-        }
-        qemu_set_fd_handler(evtchn_fd, cpu_handle_ioreq, NULL, state);
-    }
-}
-
-
-static void xen_hvm_change_state_handler(void *opaque, int running,
-                                         RunState rstate)
-{
-    XenIOState *state =3D opaque;
-
-    if (running) {
-        xen_main_loop_prepare(state);
-    }
-
-    xen_set_ioreq_server_state(xen_xc, xen_domid,
-                               state->ioservid,
-                               (rstate =3D=3D RUN_STATE_RUNNING));
-}
-
-static void xen_exit_notifier(Notifier *n, void *data)
-{
-    XenIOState *state =3D container_of(n, XenIOState, exit);
-
-    xenevtchn_close(state->xce_handle);
-    xs_daemon_close(state->xenstore);
-}
-
-static void xen_read_physmap(XenIOState *state)
-{
-    XenPhysmap *physmap =3D NULL;
-    unsigned int len, num, i;
-    char path[80], *value =3D NULL;
-    char **entries =3D NULL;
-
-    snprintf(path, sizeof(path),
-            "/local/domain/0/device-model/%d/physmap", xen_domid);
-    entries =3D xs_directory(state->xenstore, 0, path, &num);
-    if (entries =3D=3D NULL)
-        return;
-
-    for (i =3D 0; i < num; i++) {
-        physmap =3D g_malloc(sizeof (XenPhysmap));
-        physmap->phys_offset =3D strtoull(entries[i], NULL, 16);
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/start_addr",
-                xen_domid, entries[i]);
-        value =3D xs_read(state->xenstore, 0, path, &len);
-        if (value =3D=3D NULL) {
-            g_free(physmap);
-            continue;
-        }
-        physmap->start_addr =3D strtoull(value, NULL, 16);
-        free(value);
-
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/size",
-                xen_domid, entries[i]);
-        value =3D xs_read(state->xenstore, 0, path, &len);
-        if (value =3D=3D NULL) {
-            g_free(physmap);
-            continue;
-        }
-        physmap->size =3D strtoull(value, NULL, 16);
-        free(value);
-
-        snprintf(path, sizeof(path),
-                "/local/domain/0/device-model/%d/physmap/%s/name",
-                xen_domid, entries[i]);
-        physmap->name =3D xs_read(state->xenstore, 0, path, &len);
-
-        QLIST_INSERT_HEAD(&state->physmap, physmap, list);
-    }
-    free(entries);
-}
-
-static void xen_wakeup_notifier(Notifier *notifier, void *data)
-{
-    xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
-}
-
-void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
-{
-    int i, rc;
-    xen_pfn_t ioreq_pfn;
-    xen_pfn_t bufioreq_pfn;
-    evtchn_port_t bufioreq_evtchn;
-    XenIOState *state;
-
-    state =3D g_malloc0(sizeof (XenIOState));
-
-    state->xce_handle =3D xenevtchn_open(NULL, 0);
-    if (state->xce_handle =3D=3D NULL) {
-        perror("xen: event channel open");
-        goto err;
-    }
-
-    state->xenstore =3D xs_daemon_open();
-    if (state->xenstore =3D=3D NULL) {
-        perror("xen: xenstore open");
-        goto err;
-    }
-
-    xen_create_ioreq_server(xen_xc, xen_domid, &state->ioservid);
-
-    state->exit.notify =3D xen_exit_notifier;
-    qemu_add_exit_notifier(&state->exit);
-
-    state->suspend.notify =3D xen_suspend_notifier;
-    qemu_register_suspend_notifier(&state->suspend);
-
-    state->wakeup.notify =3D xen_wakeup_notifier;
-    qemu_register_wakeup_notifier(&state->wakeup);
-
-    rc =3D xen_get_ioreq_server_info(xen_xc, xen_domid, state->ioservid,
-                                   &ioreq_pfn, &bufioreq_pfn,
-                                   &bufioreq_evtchn);
-    if (rc < 0) {
-        error_report("failed to get ioreq server info: error %d handle=3D%=
p",
-                     errno, xen_xc);
-        goto err;
-    }
-
-    DPRINTF("shared page at pfn %lx\n", ioreq_pfn);
-    DPRINTF("buffered io page at pfn %lx\n", bufioreq_pfn);
-    DPRINTF("buffered io evtchn is %x\n", bufioreq_evtchn);
-
-    state->shared_page =3D xenforeignmemory_map(xen_fmem, xen_domid,
-                                              PROT_READ|PROT_WRITE,
-                                              1, &ioreq_pfn, NULL);
-    if (state->shared_page =3D=3D NULL) {
-        error_report("map shared IO page returned error %d handle=3D%p",
-                     errno, xen_xc);
-        goto err;
-    }
-
-    rc =3D xen_get_vmport_regs_pfn(xen_xc, xen_domid, &ioreq_pfn);
-    if (!rc) {
-        DPRINTF("shared vmport page at pfn %lx\n", ioreq_pfn);
-        state->shared_vmport_page =3D
-            xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ|PROT_WRITE=
,
-                                 1, &ioreq_pfn, NULL);
-        if (state->shared_vmport_page =3D=3D NULL) {
-            error_report("map shared vmport IO page returned error %d hand=
le=3D%p",
-                         errno, xen_xc);
-            goto err;
-        }
-    } else if (rc !=3D -ENOSYS) {
-        error_report("get vmport regs pfn returned error %d, rc=3D%d",
-                     errno, rc);
-        goto err;
-    }
-
-    state->buffered_io_page =3D xenforeignmemory_map(xen_fmem, xen_domid,
-                                                   PROT_READ|PROT_WRITE,
-                                                   1, &bufioreq_pfn, NULL)=
;
-    if (state->buffered_io_page =3D=3D NULL) {
-        error_report("map buffered IO page returned error %d", errno);
-        goto err;
-    }
-
-    /* Note: cpus is empty at this point in init */
-    state->cpu_by_vcpu_id =3D g_malloc0(max_cpus * sizeof(CPUState *));
-
-    rc =3D xen_set_ioreq_server_state(xen_xc, xen_domid, state->ioservid, =
true);
-    if (rc < 0) {
-        error_report("failed to enable ioreq server info: error %d handle=
=3D%p",
-                     errno, xen_xc);
-        goto err;
-    }
-
-    state->ioreq_local_port =3D g_malloc0(max_cpus * sizeof (evtchn_port_t=
));
-
-    /* FIXME: how about if we overflow the page here? */
-    for (i =3D 0; i < max_cpus; i++) {
-        rc =3D xenevtchn_bind_interdomain(state->xce_handle, xen_domid,
-                                        xen_vcpu_eport(state->shared_page,=
 i));
-        if (rc =3D=3D -1) {
-            error_report("shared evtchn %d bind error %d", i, errno);
-            goto err;
-        }
-        state->ioreq_local_port[i] =3D rc;
-    }
-
-    rc =3D xenevtchn_bind_interdomain(state->xce_handle, xen_domid,
-                                    bufioreq_evtchn);
-    if (rc =3D=3D -1) {
-        error_report("buffered evtchn bind error %d", errno);
-        goto err;
-    }
-    state->bufioreq_local_port =3D rc;
-
-    /* Init RAM management */
-    xen_map_cache_init(xen_phys_offset_to_gaddr, state);
-    xen_ram_init(pcms, ram_size, ram_memory);
-
-    qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
-
-    state->memory_listener =3D xen_memory_listener;
-    QLIST_INIT(&state->physmap);
-    memory_listener_register(&state->memory_listener, &address_space_memor=
y);
-    state->log_for_dirtybit =3D NULL;
-
-    state->io_listener =3D xen_io_listener;
-    memory_listener_register(&state->io_listener, &address_space_io);
-
-    state->device_listener =3D xen_device_listener;
-    device_listener_register(&state->device_listener);
-
-    /* Initialize backend core & drivers */
-    if (xen_be_init() !=3D 0) {
-        error_report("xen backend core setup failed");
-        goto err;
-    }
-    xen_be_register_common();
-    xen_read_physmap(state);
-
-    /* Disable ACPI build because Xen handles it */
-    pcms->acpi_build_enabled =3D false;
-
-    return;
-
-err:
-    error_report("xen hardware virtual machine initialisation failed");
-    exit(1);
-}
-
-void destroy_hvm_domain(bool reboot)
-{
-    xc_interface *xc_handle;
-    int sts;
-
-    xc_handle =3D xc_interface_open(0, 0, 0);
-    if (xc_handle =3D=3D NULL) {
-        fprintf(stderr, "Cannot acquire xenctrl handle\n");
-    } else {
-        sts =3D xc_domain_shutdown(xc_handle, xen_domid,
-                                 reboot ? SHUTDOWN_reboot : SHUTDOWN_power=
off);
-        if (sts !=3D 0) {
-            fprintf(stderr, "xc_domain_shutdown failed to issue %s, "
-                    "sts %d, %s\n", reboot ? "reboot" : "poweroff",
-                    sts, strerror(errno));
-        } else {
-            fprintf(stderr, "Issued domain %d %s\n", xen_domid,
-                    reboot ? "reboot" : "poweroff");
-        }
-        xc_interface_close(xc_handle);
-    }
-}
-
-void xen_register_framebuffer(MemoryRegion *mr)
-{
-    framebuffer =3D mr;
-}
-
-void xen_shutdown_fatal_error(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-    fprintf(stderr, "Will destroy the domain.\n");
-    /* destroy the domain */
-    qemu_system_shutdown_request();
-}
-
-void xen_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-    if (unlikely(xen_in_migration)) {
-        int rc;
-        ram_addr_t start_pfn, nb_pages;
-
-        if (length =3D=3D 0) {
-            length =3D TARGET_PAGE_SIZE;
-        }
-        start_pfn =3D start >> TARGET_PAGE_BITS;
-        nb_pages =3D ((start + length + TARGET_PAGE_SIZE - 1) >> TARGET_PA=
GE_BITS)
-            - start_pfn;
-        rc =3D xc_hvm_modified_memory(xen_xc, xen_domid, start_pfn, nb_pag=
es);
-        if (rc) {
-            fprintf(stderr,
-                    "%s failed for "RAM_ADDR_FMT" ("RAM_ADDR_FMT"): %i, %s=
\n",
-                    __func__, start, nb_pages, rc, strerror(-rc));
-        }
-    }
-}
-
-void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
-{
-    if (enable) {
-        memory_global_dirty_log_start();
-    } else {
-        memory_global_dirty_log_stop();
-    }
-}
--
