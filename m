Received: from eggs.gnu.org ([2001:4830:134:3::10]:44073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eazds-0004gS-IC
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eazdm-00040K-Cu
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:30015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eazdl-0003vL-OD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:10 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Mon, 15 Jan 2018 16:01:55 +0800
Message-Id: <1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
In-Reply-To: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [RFC v1] block/NVMe: introduce a new vhost NVMe host
 device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, changpeng.liu@intel.com
Cc: james.r.harris@intel.com, keith.busch@intel.com, famz@redhat.com, stefanha@gmail.com, pbonzini@redhat.com, mst@redhat.com

NVMe 1.3 specification introduces a new NVMe ADMIN command:
doorbell buffer config, which can write shadow doorbell buffer
instead of MMIO registers, so it can improve the Guest performance
a lot for emulated NVMe devices inside VM.

Similar with existing vhost-user-scsi solution, this commit builds a
new vhost_user_nvme host device to VM and the I/O is processed at
the slave I/O target, so users can implement a user space NVMe driver
in the slave I/O target.

Users can start QEMU with: -chardev socket,id=char0,path=/path/vhost.0 \
-device vhost-user-nvme,chardev=char0,num_io_queues=2.

Currently Guest OS must use 4.12 kernel or later.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 hw/block/Makefile.objs     |   3 +
 hw/block/nvme.h            |  28 ++
 hw/block/vhost.c           | 439 ++++++++++++++++++++++
 hw/block/vhost_user.c      | 588 +++++++++++++++++++++++++++++
 hw/block/vhost_user_nvme.c | 902 +++++++++++++++++++++++++++++++++++++++++++++
 hw/block/vhost_user_nvme.h |  38 ++
 6 files changed, 1998 insertions(+)
 create mode 100644 hw/block/vhost.c
 create mode 100644 hw/block/vhost_user.c
 create mode 100644 hw/block/vhost_user_nvme.c
 create mode 100644 hw/block/vhost_user_nvme.h

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index e0ed980..0b27529 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -8,6 +8,9 @@ common-obj-$(CONFIG_XEN) += xen_disk.o
 common-obj-$(CONFIG_ECC) += ecc.o
 common-obj-$(CONFIG_ONENAND) += onenand.o
 common-obj-$(CONFIG_NVME_PCI) += nvme.o
+ifeq ($(CONFIG_VIRTIO),y)
+common-obj-$(CONFIG_LINUX) += vhost_user_nvme.o vhost.o vhost_user.o
+endif
 
 obj-$(CONFIG_SH4) += tc58128.o
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 6aab338..aa468fb 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -1,6 +1,8 @@
 #ifndef HW_NVME_H
 #define HW_NVME_H
 #include "qemu/cutils.h"
+#include "hw/virtio/vhost.h"
+#include "chardev/char-fe.h"
 
 typedef struct NvmeBar {
     uint64_t    cap;
@@ -236,6 +238,7 @@ enum NvmeAdminCommands {
     NVME_ADM_CMD_ASYNC_EV_REQ   = 0x0c,
     NVME_ADM_CMD_ACTIVATE_FW    = 0x10,
     NVME_ADM_CMD_DOWNLOAD_FW    = 0x11,
+    NVME_ADM_CMD_DB_BUFFER_CFG  = 0x7c,
     NVME_ADM_CMD_FORMAT_NVM     = 0x80,
     NVME_ADM_CMD_SECURITY_SEND  = 0x81,
     NVME_ADM_CMD_SECURITY_RECV  = 0x82,
@@ -414,6 +417,18 @@ typedef struct NvmeCqe {
     uint16_t    status;
 } NvmeCqe;
 
+typedef struct NvmeStatus {
+    uint16_t p:1;     /* phase tag */
+    uint16_t sc:8;    /* status code */
+    uint16_t sct:3;   /* status code type */
+    uint16_t rsvd2:2;
+    uint16_t m:1;     /* more */
+    uint16_t dnr:1;   /* do not retry */
+} NvmeStatus;
+
+#define nvme_cpl_is_error(status) \
+        (((status & 0x01fe) != 0) || ((status & 0x0e00) != 0))
+
 enum NvmeStatusCodes {
     NVME_SUCCESS                = 0x0000,
     NVME_INVALID_OPCODE         = 0x0001,
@@ -573,6 +588,7 @@ enum NvmeIdCtrlOacs {
     NVME_OACS_SECURITY  = 1 << 0,
     NVME_OACS_FORMAT    = 1 << 1,
     NVME_OACS_FW        = 1 << 2,
+    NVME_OACS_DB_BUF    = 1 << 8,
 };
 
 enum NvmeIdCtrlOncs {
@@ -739,8 +755,10 @@ typedef struct NvmeCQueue {
     uint32_t    head;
     uint32_t    tail;
     uint32_t    vector;
+    int32_t     virq;
     uint32_t    size;
     uint64_t    dma_addr;
+    EventNotifier guest_notifier;
     QEMUTimer   *timer;
     QTAILQ_HEAD(sq_list, NvmeSQueue) sq_list;
     QTAILQ_HEAD(cq_req_list, NvmeRequest) req_list;
@@ -754,6 +772,10 @@ typedef struct NvmeNamespace {
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
 
+#define TYPE_VHOST_NVME "vhost-user-nvme"
+#define NVME_VHOST(obj) \
+        OBJECT_CHECK(NvmeCtrl, (obj), TYPE_VHOST_NVME)
+
 typedef struct NvmeCtrl {
     PCIDevice    parent_obj;
     MemoryRegion iomem;
@@ -761,6 +783,12 @@ typedef struct NvmeCtrl {
     NvmeBar      bar;
     BlockConf    conf;
 
+    int32_t    bootindex;
+    CharBackend chardev;
+    struct vhost_dev dev;
+    uint32_t    num_io_queues;
+    bool        dataplane_started;
+
     uint32_t    page_size;
     uint16_t    page_bits;
     uint16_t    max_prp_ents;
diff --git a/hw/block/vhost.c b/hw/block/vhost.c
new file mode 100644
index 0000000..e4a4d99
--- /dev/null
+++ b/hw/block/vhost.c
@@ -0,0 +1,439 @@
+/*
+ * vhost support
+ *
+ * Copyright Red Hat, Inc. 2010
+ *
+ * Authors:
+ *  Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/virtio/vhost.h"
+#include "hw/hw.h"
+#include "qemu/atomic.h"
+#include "qemu/range.h"
+#include "qemu/error-report.h"
+#include "qemu/memfd.h"
+#include <linux/vhost.h>
+#include "exec/address-spaces.h"
+#include "hw/virtio/virtio-bus.h"
+#include "migration/blocker.h"
+#include "sysemu/dma.h"
+
+#include "vhost_user_nvme.h"
+
+static unsigned int used_memslots;
+static QLIST_HEAD(, vhost_dev) vhost_devices =
+    QLIST_HEAD_INITIALIZER(vhost_devices);
+
+/* Assign/unassign. Keep an unsorted array of non-overlapping
+ * memory regions in dev->mem. */
+static void vhost_dev_unassign_memory(struct vhost_dev *dev,
+                                      uint64_t start_addr,
+                                      uint64_t size)
+{
+    int from, to, n = dev->mem->nregions;
+    /* Track overlapping/split regions for sanity checking. */
+    int overlap_start = 0, overlap_end = 0, overlap_middle = 0, split = 0;
+
+    for (from = 0, to = 0; from < n; ++from, ++to) {
+        struct vhost_memory_region *reg = dev->mem->regions + to;
+        uint64_t reglast;
+        uint64_t memlast;
+        uint64_t change;
+
+        /* clone old region */
+        if (to != from) {
+            memcpy(reg, dev->mem->regions + from, sizeof *reg);
+        }
+
+        /* No overlap is simple */
+        if (!ranges_overlap(reg->guest_phys_addr, reg->memory_size,
+                            start_addr, size)) {
+            continue;
+        }
+
+        /* Split only happens if supplied region
+         * is in the middle of an existing one. Thus it can not
+         * overlap with any other existing region. */
+        assert(!split);
+
+        reglast = range_get_last(reg->guest_phys_addr, reg->memory_size);
+        memlast = range_get_last(start_addr, size);
+
+        /* Remove whole region */
+        if (start_addr <= reg->guest_phys_addr && memlast >= reglast) {
+            --dev->mem->nregions;
+            --to;
+            ++overlap_middle;
+            continue;
+        }
+
+        /* Shrink region */
+        if (memlast >= reglast) {
+            reg->memory_size = start_addr - reg->guest_phys_addr;
+            assert(reg->memory_size);
+            assert(!overlap_end);
+            ++overlap_end;
+            continue;
+        }
+
+        /* Shift region */
+        if (start_addr <= reg->guest_phys_addr) {
+            change = memlast + 1 - reg->guest_phys_addr;
+            reg->memory_size -= change;
+            reg->guest_phys_addr += change;
+            reg->userspace_addr += change;
+            assert(reg->memory_size);
+            assert(!overlap_start);
+            ++overlap_start;
+            continue;
+        }
+
+        /* This only happens if supplied region
+         * is in the middle of an existing one. Thus it can not
+         * overlap with any other existing region. */
+        assert(!overlap_start);
+        assert(!overlap_end);
+        assert(!overlap_middle);
+        /* Split region: shrink first part, shift second part. */
+        memcpy(dev->mem->regions + n, reg, sizeof *reg);
+        reg->memory_size = start_addr - reg->guest_phys_addr;
+        assert(reg->memory_size);
+        change = memlast + 1 - reg->guest_phys_addr;
+        reg = dev->mem->regions + n;
+        reg->memory_size -= change;
+        assert(reg->memory_size);
+        reg->guest_phys_addr += change;
+        reg->userspace_addr += change;
+        /* Never add more than 1 region */
+        assert(dev->mem->nregions == n);
+        ++dev->mem->nregions;
+        ++split;
+    }
+}
+
+/* Called after unassign, so no regions overlap the given range. */
+static void vhost_dev_assign_memory(struct vhost_dev *dev,
+                                    uint64_t start_addr,
+                                    uint64_t size,
+                                    uint64_t uaddr)
+{
+    int from, to;
+    struct vhost_memory_region *merged = NULL;
+    for (from = 0, to = 0; from < dev->mem->nregions; ++from, ++to) {
+        struct vhost_memory_region *reg = dev->mem->regions + to;
+        uint64_t prlast, urlast;
+        uint64_t pmlast, umlast;
+        uint64_t s, e, u;
+
+        /* clone old region */
+        if (to != from) {
+            memcpy(reg, dev->mem->regions + from, sizeof *reg);
+        }
+        prlast = range_get_last(reg->guest_phys_addr, reg->memory_size);
+        pmlast = range_get_last(start_addr, size);
+        urlast = range_get_last(reg->userspace_addr, reg->memory_size);
+        umlast = range_get_last(uaddr, size);
+
+        /* check for overlapping regions: should never happen. */
+        assert(prlast < start_addr || pmlast < reg->guest_phys_addr);
+        /* Not an adjacent or overlapping region - do not merge. */
+        if ((prlast + 1 != start_addr || urlast + 1 != uaddr) &&
+            (pmlast + 1 != reg->guest_phys_addr ||
+             umlast + 1 != reg->userspace_addr)) {
+            continue;
+        }
+
+        if (dev->vhost_ops->vhost_backend_can_merge &&
+            !dev->vhost_ops->vhost_backend_can_merge(dev, uaddr, size,
+                                                     reg->userspace_addr,
+                                                     reg->memory_size)) {
+            continue;
+        }
+
+        if (merged) {
+            --to;
+            assert(to >= 0);
+        } else {
+            merged = reg;
+        }
+        u = MIN(uaddr, reg->userspace_addr);
+        s = MIN(start_addr, reg->guest_phys_addr);
+        e = MAX(pmlast, prlast);
+        uaddr = merged->userspace_addr = u;
+        start_addr = merged->guest_phys_addr = s;
+        size = merged->memory_size = e - s + 1;
+        assert(merged->memory_size);
+    }
+
+    if (!merged) {
+        struct vhost_memory_region *reg = dev->mem->regions + to;
+        memset(reg, 0, sizeof *reg);
+        reg->memory_size = size;
+        assert(reg->memory_size);
+        reg->guest_phys_addr = start_addr;
+        reg->userspace_addr = uaddr;
+        ++to;
+    }
+    assert(to <= dev->mem->nregions + 1);
+    dev->mem->nregions = to;
+}
+
+static struct vhost_memory_region *vhost_dev_find_reg(struct vhost_dev *dev,
+                                                      uint64_t start_addr,
+                                                      uint64_t size)
+{
+    int i, n = dev->mem->nregions;
+    for (i = 0; i < n; ++i) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
+        if (ranges_overlap(reg->guest_phys_addr, reg->memory_size,
+                           start_addr, size)) {
+            return reg;
+        }
+    }
+    return NULL;
+}
+
+static bool vhost_dev_cmp_memory(struct vhost_dev *dev,
+                                 uint64_t start_addr,
+                                 uint64_t size,
+                                 uint64_t uaddr)
+{
+    struct vhost_memory_region *reg = vhost_dev_find_reg(dev, start_addr, size);
+    uint64_t reglast;
+    uint64_t memlast;
+
+    if (!reg) {
+        return true;
+    }
+
+    reglast = range_get_last(reg->guest_phys_addr, reg->memory_size);
+    memlast = range_get_last(start_addr, size);
+
+    /* Need to extend region? */
+    if (start_addr < reg->guest_phys_addr || memlast > reglast) {
+        return true;
+    }
+    /* userspace_addr changed? */
+    return uaddr != reg->userspace_addr + start_addr - reg->guest_phys_addr;
+}
+
+static void vhost_set_memory(MemoryListener *listener,
+                             MemoryRegionSection *section,
+                             bool add)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    hwaddr start_addr = section->offset_within_address_space;
+    ram_addr_t size = int128_get64(section->size);
+    bool log_dirty =
+        memory_region_get_dirty_log_mask(section->mr) &
+                                         ~(1 << DIRTY_MEMORY_MIGRATION);
+    int s = offsetof(struct vhost_memory, regions) +
+        (dev->mem->nregions + 1) * sizeof dev->mem->regions[0];
+    void *ram;
+
+    dev->mem = g_realloc(dev->mem, s);
+
+    if (log_dirty) {
+        add = false;
+    }
+
+    assert(size);
+
+    /* Optimize no-change case. At least cirrus_vga does
+     * this a lot at this time.
+     */
+    ram = memory_region_get_ram_ptr(section->mr) +
+                                    section->offset_within_region;
+    if (add) {
+        if (!vhost_dev_cmp_memory(dev, start_addr, size, (uintptr_t)ram)) {
+            /* Region exists with same address. Nothing to do. */
+            return;
+        }
+    } else {
+        if (!vhost_dev_find_reg(dev, start_addr, size)) {
+            /* Removing region that we don't access. Nothing to do. */
+            return;
+        }
+    }
+
+    vhost_dev_unassign_memory(dev, start_addr, size);
+    if (add) {
+        /* Add given mapping, merging adjacent regions if any */
+        vhost_dev_assign_memory(dev, start_addr, size, (uintptr_t)ram);
+    } else {
+        /* Remove old mapping for this memory, if any. */
+        vhost_dev_unassign_memory(dev, start_addr, size);
+    }
+    dev->mem_changed_start_addr = MIN(dev->mem_changed_start_addr, start_addr);
+    dev->mem_changed_end_addr = MAX(dev->mem_changed_end_addr,
+                                    start_addr + size - 1);
+    dev->memory_changed = true;
+    used_memslots = dev->mem->nregions;
+}
+
+static bool vhost_section(MemoryRegionSection *section)
+{
+    return memory_region_is_ram(section->mr) &&
+        !memory_region_is_rom(section->mr);
+}
+
+static void vhost_begin(MemoryListener *listener)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    dev->mem_changed_end_addr = 0;
+    dev->mem_changed_start_addr = -1;
+}
+
+static void vhost_commit(MemoryListener *listener)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    int r;
+
+    if (!dev->memory_changed) {
+        return;
+    }
+    if (!dev->started) {
+        return;
+    }
+    if (dev->mem_changed_start_addr > dev->mem_changed_end_addr) {
+        return;
+    }
+
+    r = dev->vhost_ops->vhost_set_mem_table(dev, dev->mem);
+    if (r < 0) {
+        error_report("vhost_set_mem_table failed");
+    }
+    dev->memory_changed = false;
+}
+
+static void vhost_region_add(MemoryListener *listener,
+                             MemoryRegionSection *section)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+
+    if (!vhost_section(section)) {
+        return;
+    }
+
+    ++dev->n_mem_sections;
+    dev->mem_sections = g_renew(MemoryRegionSection, dev->mem_sections,
+                                dev->n_mem_sections);
+    dev->mem_sections[dev->n_mem_sections - 1] = *section;
+    memory_region_ref(section->mr);
+    vhost_set_memory(listener, section, true);
+}
+
+static void vhost_region_del(MemoryListener *listener,
+                             MemoryRegionSection *section)
+{
+    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
+                                         memory_listener);
+    int i;
+
+    if (!vhost_section(section)) {
+        return;
+    }
+
+    vhost_set_memory(listener, section, false);
+    memory_region_unref(section->mr);
+    for (i = 0; i < dev->n_mem_sections; ++i) {
+        if (dev->mem_sections[i].offset_within_address_space
+            == section->offset_within_address_space) {
+            --dev->n_mem_sections;
+            memmove(&dev->mem_sections[i], &dev->mem_sections[i + 1],
+                    (dev->n_mem_sections - i) * sizeof(*dev->mem_sections));
+            break;
+        }
+    }
+}
+
+static void vhost_region_nop(MemoryListener *listener,
+                             MemoryRegionSection *section)
+{
+}
+
+static void vhost_eventfd_add(MemoryListener *listener,
+                              MemoryRegionSection *section,
+                              bool match_data, uint64_t data, EventNotifier *e)
+{
+}
+
+static void vhost_eventfd_del(MemoryListener *listener,
+                              MemoryRegionSection *section,
+                              bool match_data, uint64_t data, EventNotifier *e)
+{
+}
+
+int vhost_dev_nvme_init(struct vhost_dev *hdev, void *opaque,
+                   VhostBackendType backend_type, uint32_t busyloop_timeout)
+{
+   int r;
+
+   r = vhost_dev_nvme_set_backend_type(hdev, backend_type);
+   assert(r >= 0);
+
+   r = hdev->vhost_ops->vhost_backend_init(hdev, opaque);
+   if (r < 0) {
+        return -1;
+   }
+
+   hdev->memory_listener = (MemoryListener) {
+        .begin = vhost_begin,
+        .commit = vhost_commit,
+        .region_add = vhost_region_add,
+        .region_del = vhost_region_del,
+        .region_nop = vhost_region_nop,
+        .eventfd_add = vhost_eventfd_add,
+        .eventfd_del = vhost_eventfd_del,
+        .priority = 10
+    };
+
+    hdev->mem = g_malloc0(offsetof(struct vhost_memory, regions));
+    hdev->n_mem_sections = 0;
+    hdev->mem_sections = NULL;
+    hdev->log = NULL;
+    hdev->log_size = 0;
+    hdev->log_enabled = false;
+    hdev->started = false;
+    hdev->memory_changed = false;
+    memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
+    return 0;
+}
+
+void vhost_dev_nvme_cleanup(struct vhost_dev *hdev)
+{
+    if (hdev->mem) {
+        /* those are only safe after successful init */
+        memory_listener_unregister(&hdev->memory_listener);
+        QLIST_REMOVE(hdev, entry);
+    }
+    g_free(hdev->mem);
+    g_free(hdev->mem_sections);
+
+    memset(hdev, 0, sizeof(struct vhost_dev));
+}
+
+int vhost_dev_nvme_set_guest_notifier(struct vhost_dev *hdev,
+                                      EventNotifier *notifier, uint32_t qid)
+{
+    struct vhost_vring_file file;
+
+    file.fd = event_notifier_get_fd(notifier);
+    file.index = qid;
+    return hdev->vhost_ops->vhost_set_vring_call(hdev, &file);
+}
+
diff --git a/hw/block/vhost_user.c b/hw/block/vhost_user.c
new file mode 100644
index 0000000..1450e64
--- /dev/null
+++ b/hw/block/vhost_user.c
@@ -0,0 +1,588 @@
+/*
+ * vhost-user
+ *
+ * Copyright (c) 2013 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/virtio-net.h"
+#include "chardev/char-fe.h"
+#include "hw/block/block.h"
+#include "sysemu/kvm.h"
+#include "qemu/error-report.h"
+#include "qemu/sockets.h"
+
+#include "nvme.h"
+#include "vhost_user_nvme.h"
+
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <linux/vhost.h>
+
+#define VHOST_MEMORY_MAX_NREGIONS    8
+#define VHOST_USER_F_PROTOCOL_FEATURES 30
+
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_MQ = 0,
+    VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
+    VHOST_USER_PROTOCOL_F_RARP = 2,
+    VHOST_USER_PROTOCOL_F_REPLY_ACK = 3,
+    VHOST_USER_PROTOCOL_F_NET_MTU = 4,
+    VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
+    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+
+    VHOST_USER_PROTOCOL_F_MAX
+};
+
+#define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MAX) - 1)
+
+typedef enum VhostUserRequest {
+    VHOST_USER_NONE = 0,
+    VHOST_USER_GET_FEATURES = 1,
+    VHOST_USER_SET_FEATURES = 2,
+    VHOST_USER_SET_OWNER = 3,
+    VHOST_USER_RESET_OWNER = 4,
+    VHOST_USER_SET_MEM_TABLE = 5,
+    VHOST_USER_SET_LOG_BASE = 6,
+    VHOST_USER_SET_LOG_FD = 7,
+    VHOST_USER_SET_VRING_NUM = 8,
+    VHOST_USER_SET_VRING_ADDR = 9,
+    VHOST_USER_SET_VRING_BASE = 10,
+    VHOST_USER_GET_VRING_BASE = 11,
+    VHOST_USER_SET_VRING_KICK = 12,
+    VHOST_USER_SET_VRING_CALL = 13,
+    VHOST_USER_SET_VRING_ERR = 14,
+    VHOST_USER_GET_PROTOCOL_FEATURES = 15,
+    VHOST_USER_SET_PROTOCOL_FEATURES = 16,
+    VHOST_USER_GET_QUEUE_NUM = 17,
+    VHOST_USER_SET_VRING_ENABLE = 18,
+    VHOST_USER_SEND_RARP = 19,
+    VHOST_USER_NET_SET_MTU = 20,
+    VHOST_USER_SET_SLAVE_REQ_FD = 21,
+    VHOST_USER_IOTLB_MSG = 22,
+    VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_NVME_ADMIN = 27,
+    VHOST_USER_NVME_SET_CQ_CALL = 28,
+    VHOST_USER_NVME_GET_CAP = 29,
+    VHOST_USER_NVME_START_STOP = 30,
+    VHOST_USER_NVME_IO_CMD = 31,
+    VHOST_USER_MAX
+} VhostUserRequest;
+
+typedef enum VhostUserSlaveRequest {
+    VHOST_USER_SLAVE_NONE = 0,
+    VHOST_USER_SLAVE_IOTLB_MSG = 1,
+    VHOST_USER_SLAVE_MAX
+}  VhostUserSlaveRequest;
+
+typedef struct VhostUserMemoryRegion {
+    uint64_t guest_phys_addr;
+    uint64_t memory_size;
+    uint64_t userspace_addr;
+    uint64_t mmap_offset;
+} VhostUserMemoryRegion;
+
+typedef struct VhostUserMemory {
+    uint32_t nregions;
+    uint32_t padding;
+    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+} VhostUserMemory;
+
+typedef struct VhostUserLog {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+} VhostUserLog;
+
+enum VhostUserNvmeQueueTypes {
+    VHOST_USER_NVME_SUBMISSION_QUEUE = 1,
+    VHOST_USER_NVME_COMPLETION_QUEUE = 2,
+};
+
+typedef struct VhostUserNvmeIO {
+    enum VhostUserNvmeQueueTypes queue_type;
+    uint32_t qid;
+    uint32_t tail_head;
+} VhostUserNvmeIO;
+
+typedef struct VhostUserMsg {
+    VhostUserRequest request;
+
+#define VHOST_USER_VERSION_MASK     (0x3)
+#define VHOST_USER_REPLY_MASK       (0x1 << 2)
+#define VHOST_USER_NEED_REPLY_MASK  (0x1 << 3)
+    uint32_t flags;
+    uint32_t size; /* the following payload size */
+    union {
+#define VHOST_USER_VRING_IDX_MASK   (0xff)
+#define VHOST_USER_VRING_NOFD_MASK  (0x1 << 8)
+        uint64_t u64;
+        struct vhost_vring_state state;
+        struct vhost_vring_addr addr;
+        VhostUserMemory memory;
+        VhostUserLog log;
+        struct nvme {
+            union {
+                NvmeCmd req;
+                NvmeCqe cqe;
+            } cmd;
+            uint8_t buf[4096];
+        } nvme;
+        VhostUserNvmeIO nvme_io;
+        struct vhost_iotlb_msg iotlb;
+    } payload;
+} QEMU_PACKED VhostUserMsg;
+
+static VhostUserMsg m __attribute__ ((unused));
+#define VHOST_USER_HDR_SIZE (sizeof(m.request) \
+                            + sizeof(m.flags) \
+                            + sizeof(m.size))
+
+#define VHOST_USER_PAYLOAD_SIZE (sizeof(m) - VHOST_USER_HDR_SIZE)
+
+/* The version of the protocol we support */
+#define VHOST_USER_VERSION    (0x1)
+
+struct vhost_user {
+    CharBackend *chr;
+};
+
+static bool ioeventfd_enabled(void)
+{
+    return kvm_enabled() && kvm_eventfds_enabled();
+}
+
+static int vhost_user_memslots_limit(struct vhost_dev *dev)
+{
+    return VHOST_MEMORY_MAX_NREGIONS;
+}
+
+/* most non-init callers ignore the error */
+static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
+                            int *fds, int fd_num)
+{
+    struct vhost_user *u = dev->opaque;
+    CharBackend *chr = u->chr;
+    int ret, size = VHOST_USER_HDR_SIZE + msg->size;
+
+    if (qemu_chr_fe_set_msgfds(chr, fds, fd_num) < 0) {
+        error_report("Failed to set msg fds.");
+        return -1;
+    }
+
+    ret = qemu_chr_fe_write_all(chr, (const uint8_t *) msg, size);
+    if (ret != size) {
+        error_report("Failed to write msg."
+                     " Wrote %d instead of %d.", ret, size);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
+{
+    struct vhost_user *u = dev->opaque;
+    CharBackend *chr = u->chr;
+    uint8_t *p = (uint8_t *) msg;
+    int r, size = VHOST_USER_HDR_SIZE;
+
+    r = qemu_chr_fe_read_all(chr, p, size);
+    if (r != size) {
+        error_report("Failed to read msg header. Read %d instead of %d."
+                     " Original request %d.", r, size, msg->request);
+        goto fail;
+    }
+
+    /* validate received flags */
+    if (msg->flags != (VHOST_USER_REPLY_MASK | VHOST_USER_VERSION)) {
+        error_report("Failed to read msg header."
+                " Flags 0x%x instead of 0x%x.", msg->flags,
+                VHOST_USER_REPLY_MASK | VHOST_USER_VERSION);
+        goto fail;
+    }
+
+    /* validate message size is sane */
+    if (msg->size > VHOST_USER_PAYLOAD_SIZE) {
+        error_report("Failed to read msg header."
+                " Size %d exceeds the maximum %zu.", msg->size,
+                VHOST_USER_PAYLOAD_SIZE);
+        goto fail;
+    }
+
+    if (msg->size) {
+        p += VHOST_USER_HDR_SIZE;
+        size = msg->size;
+        r = qemu_chr_fe_read_all(chr, p, size);
+        if (r != size) {
+            error_report("Failed to read msg payload."
+                         " Read %d instead of %d.", r, msg->size);
+            goto fail;
+        }
+    }
+
+    return 0;
+
+fail:
+    return -1;
+}
+
+static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
+{
+    VhostUserMsg msg = {
+        .request = request,
+        .flags = VHOST_USER_VERSION,
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    if (vhost_user_read(dev, &msg) < 0) {
+        return -1;
+    }
+
+    if (msg.request != request) {
+        error_report("Received unexpected msg type. Expected %d received %d",
+                     request, msg.request);
+        return -1;
+    }
+
+    if (msg.size != sizeof(msg.payload.u64)) {
+        error_report("Received bad msg size.");
+        return -1;
+    }
+
+    *u64 = msg.payload.u64;
+
+    return 0;
+}
+
+static int vhost_user_set_u64(struct vhost_dev *dev, int request, uint64_t u64)
+{
+    VhostUserMsg msg = {
+        .request = request,
+        .flags = VHOST_USER_VERSION,
+        .payload.u64 = u64,
+        .size = sizeof(msg.payload.u64),
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+int
+vhost_user_nvme_get_cap(struct vhost_dev *dev, uint64_t *cap)
+{
+    return vhost_user_get_u64(dev, VHOST_USER_NVME_GET_CAP, cap);
+}
+
+int vhost_dev_nvme_start(struct vhost_dev *dev, VirtIODevice *vdev)
+{
+    int r = 0;
+
+    if (vdev != NULL) {
+        return -1;
+    }
+    r = dev->vhost_ops->vhost_set_mem_table(dev, dev->mem);
+    if (r < 0) {
+        error_report("SET MEMTABLE Failed");
+        return -1;
+    }
+
+    vhost_user_set_u64(dev, VHOST_USER_NVME_START_STOP, 1);
+
+    return 0;
+}
+
+int vhost_dev_nvme_stop(struct vhost_dev *dev)
+{
+    return vhost_user_set_u64(dev, VHOST_USER_NVME_START_STOP, 0);
+}
+
+int
+vhost_user_nvme_io_cmd_pass(struct vhost_dev *dev, uint16_t qid,
+                            uint16_t tail_head, bool submission_queue)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_NVME_IO_CMD,
+        .flags = VHOST_USER_VERSION,
+        .size = sizeof(VhostUserNvmeIO),
+    };
+
+    if (submission_queue) {
+        msg.payload.nvme_io.queue_type = VHOST_USER_NVME_SUBMISSION_QUEUE;
+    } else {
+        msg.payload.nvme_io.queue_type = VHOST_USER_NVME_COMPLETION_QUEUE;
+    }
+    msg.payload.nvme_io.qid = qid;
+    msg.payload.nvme_io.tail_head = tail_head;
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+/* reply required for all the messages */
+int
+vhost_user_nvme_admin_cmd_raw(struct vhost_dev *dev, NvmeCmd *cmd,
+                              void *buf, uint32_t len)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_NVME_ADMIN,
+        .flags = VHOST_USER_VERSION,
+    };
+    uint16_t status;
+
+    msg.size = sizeof(*cmd);
+    memcpy(&msg.payload.nvme.cmd.req, cmd, sizeof(*cmd));
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        return -1;
+    }
+
+    if (vhost_user_read(dev, &msg) < 0) {
+        return -1;
+    }
+
+    if (msg.request != VHOST_USER_NVME_ADMIN) {
+        error_report("Received unexpected msg type. Expected %d received %d",
+                     VHOST_USER_NVME_ADMIN, msg.request);
+        return -1;
+    }
+
+    switch (cmd->opcode) {
+    case NVME_ADM_CMD_DELETE_SQ:
+    case NVME_ADM_CMD_CREATE_SQ:
+    case NVME_ADM_CMD_DELETE_CQ:
+    case NVME_ADM_CMD_CREATE_CQ:
+    case NVME_ADM_CMD_DB_BUFFER_CFG:
+        if (msg.size != sizeof(NvmeCqe)) {
+            error_report("Received unexpected rsp message. %u received %u",
+                         cmd->opcode, msg.size);
+        }
+        status = msg.payload.nvme.cmd.cqe.status;
+        if (nvme_cpl_is_error(status)) {
+            error_report("Nvme Admin Command Status Faild");
+            return -1;
+        }
+        memcpy(buf, &msg.payload.nvme.cmd.cqe, len);
+    break;
+    case NVME_ADM_CMD_IDENTIFY:
+    case NVME_ADM_CMD_GET_FEATURES:
+    case NVME_ADM_CMD_SET_FEATURES:
+        if (msg.size != sizeof(NvmeCqe) + 4096) {
+            error_report("Received unexpected rsp message. %u received %u",
+                         cmd->opcode, msg.size);
+        }
+        status = msg.payload.nvme.cmd.cqe.status;
+        if (nvme_cpl_is_error(status)) {
+            error_report("Nvme Admin Command Status Faild");
+            return -1;
+        }
+        memcpy(buf, &msg.payload.nvme.buf, len);
+    break;
+    default:
+        return -1;
+    }
+
+    return 0;
+}
+
+static int process_message_reply(struct vhost_dev *dev,
+                                 const VhostUserMsg *msg)
+{
+    VhostUserMsg msg_reply;
+
+    if ((msg->flags & VHOST_USER_NEED_REPLY_MASK) == 0) {
+        return 0;
+    }
+
+    if (vhost_user_read(dev, &msg_reply) < 0) {
+        return -1;
+    }
+
+    if (msg_reply.request != msg->request) {
+        error_report("Received unexpected msg type."
+                     "Expected %d received %d",
+                     msg->request, msg_reply.request);
+        return -1;
+    }
+
+    return msg_reply.payload.u64 ? -1 : 0;
+}
+
+static int vhost_user_set_mem_table(struct vhost_dev *dev,
+                                    struct vhost_memory *mem)
+{
+    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int i, fd;
+    size_t fd_num = 0;
+    bool reply_supported = true;
+
+    VhostUserMsg msg = {
+        .request = VHOST_USER_SET_MEM_TABLE,
+        .flags = VHOST_USER_VERSION,
+    };
+
+    if (reply_supported) {
+        msg.flags |= VHOST_USER_NEED_REPLY_MASK;
+    }
+
+    for (i = 0; i < dev->mem->nregions; ++i) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
+        ram_addr_t offset;
+        MemoryRegion *mr;
+
+        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
+        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
+                                     &offset);
+        fd = memory_region_get_fd(mr);
+        if (fd > 0) {
+            msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
+            msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
+            msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
+            msg.payload.memory.regions[fd_num].mmap_offset = offset;
+            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
+            fds[fd_num++] = fd;
+        }
+    }
+
+    msg.payload.memory.nregions = fd_num;
+
+    if (!fd_num) {
+        error_report("Failed initializing vhost-user memory map, "
+                     "consider using -object memory-backend-file share=on");
+        return -1;
+    }
+
+    msg.size = sizeof(msg.payload.memory.nregions);
+    msg.size += sizeof(msg.payload.memory.padding);
+    msg.size += fd_num * sizeof(VhostUserMemoryRegion);
+
+    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
+        return -1;
+    }
+
+    if (reply_supported) {
+        return process_message_reply(dev, &msg);
+    }
+
+    return 0;
+}
+
+static int vhost_set_vring_file(struct vhost_dev *dev,
+                                VhostUserRequest request,
+                                struct vhost_vring_file *file)
+{
+    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    size_t fd_num = 0;
+    VhostUserMsg msg = {
+        .request = request,
+        .flags = VHOST_USER_VERSION,
+        .payload.u64 = file->index & VHOST_USER_VRING_IDX_MASK,
+        .size = sizeof(msg.payload.u64),
+    };
+
+    if (ioeventfd_enabled() && file->fd > 0) {
+        fds[fd_num++] = file->fd;
+    } else {
+        msg.payload.u64 |= VHOST_USER_VRING_NOFD_MASK;
+    }
+
+    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int vhost_user_set_vring_call(struct vhost_dev *dev,
+                                     struct vhost_vring_file *file)
+{
+    return vhost_set_vring_file(dev, VHOST_USER_NVME_SET_CQ_CALL, file);
+}
+
+static int vhost_user_init(struct vhost_dev *dev, void *opaque)
+{
+    struct vhost_user *u;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    u = g_new0(struct vhost_user, 1);
+    u->chr = opaque;
+    dev->opaque = u;
+
+    return 0;
+}
+
+static int vhost_user_cleanup(struct vhost_dev *dev)
+{
+    struct vhost_user *u;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+
+    u = dev->opaque;
+    g_free(u);
+    dev->opaque = 0;
+
+    return 0;
+}
+
+static bool vhost_user_can_merge(struct vhost_dev *dev,
+                                 uint64_t start1, uint64_t size1,
+                                 uint64_t start2, uint64_t size2)
+{
+    ram_addr_t offset;
+    int mfd, rfd;
+    MemoryRegion *mr;
+
+    mr = memory_region_from_host((void *)(uintptr_t)start1, &offset);
+    mfd = memory_region_get_fd(mr);
+
+    mr = memory_region_from_host((void *)(uintptr_t)start2, &offset);
+    rfd = memory_region_get_fd(mr);
+
+    return mfd == rfd;
+}
+
+const VhostOps user_nvme_ops = {
+        .backend_type = VHOST_BACKEND_TYPE_USER,
+        .vhost_backend_init = vhost_user_init,
+        .vhost_backend_cleanup = vhost_user_cleanup,
+        .vhost_backend_memslots_limit = vhost_user_memslots_limit,
+        .vhost_set_mem_table = vhost_user_set_mem_table,
+        .vhost_set_vring_call = vhost_user_set_vring_call,
+        .vhost_backend_can_merge = vhost_user_can_merge,
+};
+
+int vhost_dev_nvme_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
+{
+    int r = 0;
+
+    switch (backend_type) {
+    case VHOST_BACKEND_TYPE_USER:
+        dev->vhost_ops = &user_nvme_ops;
+        break;
+    default:
+        error_report("Unknown vhost backend type");
+        r = -1;
+    }
+
+    return r;
+}
diff --git a/hw/block/vhost_user_nvme.c b/hw/block/vhost_user_nvme.c
new file mode 100644
index 0000000..ee21a2d
--- /dev/null
+++ b/hw/block/vhost_user_nvme.c
@@ -0,0 +1,902 @@
+/*
+ * QEMU NVM Express Controller
+ *
+ * Copyright (c) 2017, Intel Corporation
+ *
+ * Author:
+ * Changpeng Liu <changpeng.liu@intel.com>
+ *
+ * This work was largely based on QEMU NVMe driver implementation by:
+ * Keith Busch <keith.busch@intel.com>
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ */
+
+/**
+ * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
+ *
+ *  http://www.nvmexpress.org/resources/
+ */
+
+#include "qemu/osdep.h"
+#include "hw/block/block.h"
+#include "hw/hw.h"
+#include "sysemu/kvm.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci.h"
+#include "sysemu/sysemu.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qapi/visitor.h"
+
+#include "nvme.h"
+#include "vhost_user_nvme.h"
+
+static int vhost_user_nvme_add_kvm_msi_virq(NvmeCtrl *n, NvmeCQueue *cq)
+{
+    int virq;
+    int vector_n;
+
+    if (!msix_enabled(&(n->parent_obj))) {
+        error_report("MSIX is mandatory for the device");
+        return -1;
+    }
+
+    if (event_notifier_init(&cq->guest_notifier, 0)) {
+        error_report("Initiated guest notifier failed");
+        return -1;
+    }
+
+    vector_n = cq->vector;
+
+    virq = kvm_irqchip_add_msi_route(kvm_state, vector_n, &n->parent_obj);
+    if (virq < 0) {
+        error_report("Route MSIX vector to KVM failed");
+        event_notifier_cleanup(&cq->guest_notifier);
+        return -1;
+    }
+
+    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, &cq->guest_notifier,
+                                           NULL, virq) < 0) {
+        kvm_irqchip_release_virq(kvm_state, virq);
+        event_notifier_cleanup(&cq->guest_notifier);
+        error_report("Add MSIX vector to KVM failed");
+        return -1;
+    }
+
+    cq->virq = virq;
+    return 0;
+}
+
+static void vhost_user_nvme_remove_kvm_msi_virq(NvmeCQueue *cq)
+{
+    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &cq->guest_notifier,
+                                          cq->virq);
+    kvm_irqchip_release_virq(kvm_state, cq->virq);
+    event_notifier_cleanup(&cq->guest_notifier);
+    cq->virq = -1;
+}
+
+static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
+{
+    if (sqid < n->num_io_queues + 1) {
+        return 0;
+    }
+
+    return 1;
+}
+
+static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
+{
+    if (cqid < n->num_io_queues + 1) {
+        return 0;
+    }
+
+    return 1;
+}
+
+static void nvme_inc_cq_tail(NvmeCQueue *cq)
+{
+    cq->tail++;
+    if (cq->tail >= cq->size) {
+        cq->tail = 0;
+        cq->phase = !cq->phase;
+    }
+}
+
+static void nvme_inc_sq_head(NvmeSQueue *sq)
+{
+    sq->head = (sq->head + 1) % sq->size;
+}
+
+static uint8_t nvme_sq_empty(NvmeSQueue *sq)
+{
+    return sq->head == sq->tail;
+}
+
+static void nvme_isr_notify(NvmeCtrl *n, NvmeCQueue *cq)
+{
+    if (cq->irq_enabled) {
+        if (msix_enabled(&(n->parent_obj))) {
+            msix_notify(&(n->parent_obj), cq->vector);
+        } else {
+            pci_irq_pulse(&n->parent_obj);
+        }
+    }
+}
+
+static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
+{
+    n->sq[sq->sqid] = NULL;
+    if (sq->sqid) {
+        g_free(sq);
+    }
+}
+
+static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    NvmeDeleteQ *c = (NvmeDeleteQ *)cmd;
+    NvmeSQueue *sq;
+    NvmeCqe cqe;
+    uint16_t qid = le16_to_cpu(c->qid);
+    int ret;
+
+    if (!qid || nvme_check_sqid(n, qid)) {
+        error_report("nvme_del_sq: invalid qid %u", qid);
+        return NVME_INVALID_QID | NVME_DNR;
+    }
+
+    sq = n->sq[qid];
+
+    ret = vhost_user_nvme_admin_cmd_raw(&n->dev, cmd, &cqe, sizeof(cqe));
+    if (ret < 0) {
+        error_report("nvme_del_sq: delete sq failed");
+        return -1;
+    }
+
+    nvme_free_sq(sq, n);
+    return NVME_SUCCESS;
+}
+
+static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
+    uint16_t sqid, uint16_t cqid, uint16_t size)
+{
+    sq->ctrl = n;
+    sq->dma_addr = dma_addr;
+    sq->sqid = sqid;
+    sq->size = size;
+    sq->cqid = cqid;
+    sq->head = sq->tail = 0;
+
+    n->sq[sqid] = sq;
+}
+
+static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    NvmeSQueue *sq;
+    int ret;
+    NvmeCqe cqe;
+    NvmeCreateSq *c = (NvmeCreateSq *)cmd;
+
+    uint16_t cqid = le16_to_cpu(c->cqid);
+    uint16_t sqid = le16_to_cpu(c->sqid);
+    uint16_t qsize = le16_to_cpu(c->qsize);
+    uint16_t qflags = le16_to_cpu(c->sq_flags);
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+
+    if (!cqid) {
+        error_report("nvme_create_sq: invalid cqid %u", cqid);
+        return NVME_INVALID_CQID | NVME_DNR;
+    }
+    if (!sqid || nvme_check_sqid(n, sqid)) {
+        error_report("nvme_create_sq: invalid sqid");
+        return NVME_INVALID_QID | NVME_DNR;
+    }
+    if (!qsize || qsize > NVME_CAP_MQES(n->bar.cap)) {
+        error_report("nvme_create_sq: invalid qsize");
+        return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
+    }
+    if (!prp1 || prp1 & (n->page_size - 1)) {
+        error_report("nvme_create_sq: invalid prp1");
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    if (!(NVME_SQ_FLAGS_PC(qflags))) {
+        error_report("nvme_create_sq: invalid flags");
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* BIOS also create IO queue pair for same queue ID */
+    if (n->sq[sqid] != NULL) {
+        nvme_free_sq(n->sq[sqid], n);
+    }
+
+    sq = g_malloc0(sizeof(*sq));
+    assert(sq != NULL);
+    nvme_init_sq(sq, n, prp1, sqid, cqid, qsize + 1);
+    ret = vhost_user_nvme_admin_cmd_raw(&n->dev, cmd, &cqe, sizeof(cqe));
+    if (ret < 0) {
+        error_report("nvme_create_sq: create sq failed");
+        return -1;
+    }
+    return NVME_SUCCESS;
+}
+
+static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
+{
+    n->cq[cq->cqid] = NULL;
+    msix_vector_unuse(&n->parent_obj, cq->vector);
+    if (cq->cqid) {
+        g_free(cq);
+    }
+}
+
+static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    NvmeDeleteQ *c = (NvmeDeleteQ *)cmd;
+    NvmeCqe cqe;
+    NvmeCQueue *cq;
+    uint16_t qid = le16_to_cpu(c->qid);
+    int ret;
+
+    if (!qid || nvme_check_cqid(n, qid)) {
+        error_report("nvme_del_cq: invalid qid %u", qid);
+        return NVME_INVALID_CQID | NVME_DNR;
+    }
+
+    ret = vhost_user_nvme_admin_cmd_raw(&n->dev, cmd, &cqe, sizeof(cqe));
+    if (ret < 0) {
+        error_report("nvme_del_cq: delete cq failed");
+        return -1;
+    }
+
+    cq = n->cq[qid];
+    if (cq->irq_enabled) {
+        vhost_user_nvme_remove_kvm_msi_virq(cq);
+    }
+    nvme_free_cq(cq, n);
+    return NVME_SUCCESS;
+}
+
+
+static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
+    uint16_t cqid, uint16_t vector, uint16_t size, uint16_t irq_enabled)
+{
+    cq->ctrl = n;
+    cq->cqid = cqid;
+    cq->size = size;
+    cq->dma_addr = dma_addr;
+    cq->phase = 1;
+    cq->irq_enabled = irq_enabled;
+    cq->vector = vector;
+    cq->head = cq->tail = 0;
+    msix_vector_use(&n->parent_obj, cq->vector);
+    n->cq[cqid] = cq;
+}
+
+static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    int ret;
+    NvmeCQueue *cq;
+    NvmeCqe cqe;
+    NvmeCreateCq *c = (NvmeCreateCq *)cmd;
+    uint16_t cqid = le16_to_cpu(c->cqid);
+    uint16_t vector = le16_to_cpu(c->irq_vector);
+    uint16_t qsize = le16_to_cpu(c->qsize);
+    uint16_t qflags = le16_to_cpu(c->cq_flags);
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+
+    if (!cqid || nvme_check_cqid(n, cqid)) {
+        error_report("nvme_create_cq: invalid cqid");
+        return NVME_INVALID_CQID | NVME_DNR;
+    }
+    if (!qsize || qsize > NVME_CAP_MQES(n->bar.cap)) {
+        error_report("nvme_create_cq: invalid qsize, qsize %u", qsize);
+        return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
+    }
+    if (!prp1) {
+        error_report("nvme_create_cq: invalid prp1");
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    if (vector > n->num_io_queues + 1) {
+        error_report("nvme_create_cq: invalid irq vector");
+        return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
+    }
+    if (!(NVME_CQ_FLAGS_PC(qflags))) {
+        error_report("nvme_create_cq: invalid flags");
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* BIOS also create IO queue pair for same queue ID */
+    if (n->cq[cqid] != NULL) {
+        nvme_free_cq(n->cq[cqid], n);
+    }
+
+    cq = g_malloc0(sizeof(*cq));
+    assert(cq != NULL);
+    nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
+                 NVME_CQ_FLAGS_IEN(qflags));
+    ret = vhost_user_nvme_admin_cmd_raw(&n->dev, cmd, &cqe, sizeof(cqe));
+    if (ret < 0) {
+        error_report("nvme_create_cq: create cq failed");
+        return -1;
+    }
+
+    if (cq->irq_enabled) {
+        ret = vhost_user_nvme_add_kvm_msi_virq(n, cq);
+        if (ret < 0) {
+            error_report("nvme_create_cq: add kvm msix virq failed");
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        ret = vhost_dev_nvme_set_guest_notifier(&n->dev, &cq->guest_notifier,
+                                                cqid);
+        if (ret < 0) {
+            error_report("nvme_create_cq: set guest notifier failed");
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+    }
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
+{
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+
+    /* Only PRP1 used */
+    pci_dma_write(&n->parent_obj, prp1, (void *)&n->id_ctrl,
+                 sizeof(n->id_ctrl));
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
+{
+    NvmeNamespace *ns;
+    uint32_t nsid = le32_to_cpu(c->nsid);
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+
+    if (nsid == 0) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    /* Only PRP1 used */
+    ns = &n->namespaces[nsid - 1];
+    pci_dma_write(&n->parent_obj, prp1, (void *)ns, sizeof(*ns));
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    NvmeIdentify *c = (NvmeIdentify *)cmd;
+
+    switch (le32_to_cpu(c->cns)) {
+    case 0x00:
+        return nvme_identify_ns(n, c);
+    case 0x01:
+        return nvme_identify_ctrl(n, c);
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
+static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeCqe *cqe)
+{
+    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
+    uint32_t result;
+    uint32_t dw0;
+    int ret;
+
+    switch (dw10 & 0xff) {
+    case NVME_VOLATILE_WRITE_CACHE:
+        result = 0;
+        break;
+    case NVME_NUMBER_OF_QUEUES:
+        ret = vhost_user_nvme_admin_cmd_raw(&n->dev, cmd, &dw0, sizeof(dw0));
+        if (ret < 0) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        /* 0 based value for number of IO queues */
+        if (n->num_io_queues > (dw0 & 0xffffu) + 1) {
+            fprintf(stdout, "Adjust number of IO queues from %u to %u\n",
+                    n->num_io_queues, (dw0 & 0xffffu) + 1);
+                    n->num_io_queues = (dw0 & 0xffffu) + 1;
+        }
+        result = cpu_to_le32((n->num_io_queues - 1) |
+                            ((n->num_io_queues - 1) << 16));
+        break;
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    cqe->result = result;
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeCqe *cqe)
+{
+    uint32_t dw10 = le32_to_cpu(cmd->cdw10);
+    uint32_t dw0;
+    int ret;
+
+    switch (dw10 & 0xff) {
+    case NVME_NUMBER_OF_QUEUES:
+        ret = vhost_user_nvme_admin_cmd_raw(&n->dev, cmd, &dw0, sizeof(dw0));
+        if (ret < 0) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        /* 0 based value for number of IO queues */
+        if (n->num_io_queues > (dw0 & 0xffffu) + 1) {
+            fprintf(stdout, "Adjust number of IO queues from %u to %u\n",
+                    n->num_io_queues, (dw0 & 0xffffu) + 1);
+                    n->num_io_queues = (dw0 & 0xffffu) + 1;
+        }
+        cqe->result = cpu_to_le32((n->num_io_queues - 1) |
+                                 ((n->num_io_queues - 1) << 16));
+        break;
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_doorbell_buffer_config(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    int ret;
+    NvmeCmd cqe;
+
+    ret = vhost_user_nvme_admin_cmd_raw(&n->dev, cmd, &cqe, sizeof(cqe));
+    if (ret < 0) {
+        error_report("nvme_doorbell_buffer_config: set failed");
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    n->dataplane_started = true;
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_abort_cmd(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    int ret;
+    NvmeCmd cqe;
+
+    ret = vhost_user_nvme_admin_cmd_raw(&n->dev, cmd, &cqe, sizeof(cqe));
+    if (ret < 0) {
+        error_report("nvme_abort_cmd: set failed");
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static const char *nvme_admin_str[256] = {
+    [NVME_ADM_CMD_IDENTIFY] = "NVME_ADM_CMD_IDENTIFY",
+    [NVME_ADM_CMD_CREATE_CQ] = "NVME_ADM_CMD_CREATE_CQ",
+    [NVME_ADM_CMD_GET_LOG_PAGE] = "NVME_ADM_CMD_GET_LOG_PAGE",
+    [NVME_ADM_CMD_CREATE_SQ] = "NVME_ADM_CMD_CREATE_SQ",
+    [NVME_ADM_CMD_DELETE_CQ] = "NVME_ADM_CMD_DELETE_CQ",
+    [NVME_ADM_CMD_DELETE_SQ] = "NVME_ADM_CMD_DELETE_SQ",
+    [NVME_ADM_CMD_SET_FEATURES] = "NVME_ADM_CMD_SET_FEATURES",
+    [NVME_ADM_CMD_GET_FEATURES] = "NVME_ADM_CMD_SET_FEATURES",
+    [NVME_ADM_CMD_ABORT] = "NVME_ADM_CMD_ABORT",
+    [NVME_ADM_CMD_DB_BUFFER_CFG] = "NVME_ADM_CMD_DB_BUFFER_CFG",
+};
+
+static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeCqe *cqe)
+{
+    fprintf(stdout, "QEMU Processing %s\n", nvme_admin_str[cmd->opcode] ?
+            nvme_admin_str[cmd->opcode] : "Unsupported ADMIN Command");
+
+    switch (cmd->opcode) {
+    case NVME_ADM_CMD_DELETE_SQ:
+        return nvme_del_sq(n, cmd);
+    case NVME_ADM_CMD_CREATE_SQ:
+        return nvme_create_sq(n, cmd);
+    case NVME_ADM_CMD_DELETE_CQ:
+        return nvme_del_cq(n, cmd);
+    case NVME_ADM_CMD_CREATE_CQ:
+        return nvme_create_cq(n, cmd);
+    case NVME_ADM_CMD_IDENTIFY:
+        return nvme_identify(n, cmd);
+    case NVME_ADM_CMD_SET_FEATURES:
+        return nvme_set_feature(n, cmd, cqe);
+    case NVME_ADM_CMD_GET_FEATURES:
+        return nvme_get_feature(n, cmd, cqe);
+    case NVME_ADM_CMD_DB_BUFFER_CFG:
+        return nvme_doorbell_buffer_config(n, cmd);
+    case NVME_ADM_CMD_ABORT:
+        return nvme_abort_cmd(n, cmd);
+    default:
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+}
+
+static int nvme_start_ctrl(NvmeCtrl *n)
+{
+    uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
+    uint32_t page_size = 1 << page_bits;
+
+    fprintf(stdout, "QEMU Start NVMe Controller ...\n");
+    if (vhost_dev_nvme_start(&n->dev, NULL) < 0) {
+        error_report("nvme_start_ctrl: vhost device start failed");
+        return -1;
+    }
+
+    if (!n->bar.asq || !n->bar.acq ||
+            n->bar.asq & (page_size - 1) || n->bar.acq & (page_size - 1) ||
+            NVME_CC_MPS(n->bar.cc) < NVME_CAP_MPSMIN(n->bar.cap) ||
+            NVME_CC_MPS(n->bar.cc) > NVME_CAP_MPSMAX(n->bar.cap) ||
+            !NVME_AQA_ASQS(n->bar.aqa) || !NVME_AQA_ACQS(n->bar.aqa)) {
+        error_report("nvme_start_ctrl: invalid bar configurations");
+        return -1;
+    }
+
+    n->page_bits = page_bits;
+    n->page_size = page_size;
+    n->max_prp_ents = n->page_size / sizeof(uint64_t);
+    n->cqe_size = 1 << NVME_CC_IOCQES(n->bar.cc);
+    n->sqe_size = 1 << NVME_CC_IOSQES(n->bar.cc);
+    nvme_init_cq(&n->admin_cq, n, n->bar.acq, 0, 0,
+        NVME_AQA_ACQS(n->bar.aqa) + 1, 1);
+    nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
+        NVME_AQA_ASQS(n->bar.aqa) + 1);
+
+    return 0;
+}
+
+static int nvme_clear_ctrl(NvmeCtrl *n)
+{
+    fprintf(stdout, "QEMU Stop NVMe Controller ...\n");
+    if (vhost_dev_nvme_stop(&n->dev) < 0) {
+        error_report("nvme_clear_ctrl: vhost device stop failed");
+        return -1;
+    }
+    n->bar.cc = 0;
+    n->dataplane_started = false;
+    return 0;
+}
+
+static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
+                           unsigned size)
+{
+    switch (offset) {
+    case 0xc:
+        n->bar.intms |= data & 0xffffffff;
+        n->bar.intmc = n->bar.intms;
+        break;
+    case 0x10:
+        n->bar.intms &= ~(data & 0xffffffff);
+        n->bar.intmc = n->bar.intms;
+        break;
+    case 0x14:
+        /* Windows first sends data, then sends enable bit */
+        if (!NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc) &&
+            !NVME_CC_SHN(data) && !NVME_CC_SHN(n->bar.cc))
+        {
+            n->bar.cc = data;
+        }
+
+        if (NVME_CC_EN(data) && !NVME_CC_EN(n->bar.cc)) {
+            n->bar.cc = data;
+            if (nvme_start_ctrl(n)) {
+                n->bar.csts = NVME_CSTS_FAILED;
+            } else {
+                n->bar.csts = NVME_CSTS_READY;
+            }
+        } else if (!NVME_CC_EN(data) && NVME_CC_EN(n->bar.cc)) {
+            nvme_clear_ctrl(n);
+            n->bar.csts &= ~NVME_CSTS_READY;
+        }
+        if (NVME_CC_SHN(data) && !(NVME_CC_SHN(n->bar.cc))) {
+                nvme_clear_ctrl(n);
+                n->bar.cc = data;
+                n->bar.csts |= NVME_CSTS_SHST_COMPLETE;
+        } else if (!NVME_CC_SHN(data) && NVME_CC_SHN(n->bar.cc)) {
+                n->bar.csts &= ~NVME_CSTS_SHST_COMPLETE;
+                n->bar.cc = data;
+        }
+        break;
+    case 0x24:
+        n->bar.aqa = data & 0xffffffff;
+        break;
+    case 0x28:
+        n->bar.asq = data;
+        break;
+    case 0x2c:
+        n->bar.asq |= data << 32;
+        break;
+    case 0x30:
+        n->bar.acq = data;
+        break;
+    case 0x34:
+        n->bar.acq |= data << 32;
+        break;
+    default:
+        break;
+    }
+}
+
+static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    NvmeCtrl *n = (NvmeCtrl *)opaque;
+    uint8_t *ptr = (uint8_t *)&n->bar;
+    uint64_t val = 0;
+
+    if (addr < sizeof(n->bar)) {
+        memcpy(&val, ptr + addr, size);
+    }
+    return val;
+}
+
+static void nvme_process_admin_cmd(NvmeSQueue *sq)
+{
+    NvmeCtrl *n = sq->ctrl;
+    NvmeCQueue *cq = n->cq[sq->cqid];
+    uint16_t status;
+    hwaddr addr;
+    NvmeCmd cmd;
+    NvmeCqe cqe;
+
+    while (!(nvme_sq_empty(sq))) {
+        addr = sq->dma_addr + sq->head * n->sqe_size;
+        pci_dma_read(&n->parent_obj, addr, (void *)&cmd, sizeof(cmd));
+        nvme_inc_sq_head(sq);
+
+        memset(&cqe, 0, sizeof(cqe));
+        cqe.cid = cmd.cid;
+
+        status = nvme_admin_cmd(n, &cmd, &cqe);
+        cqe.status = cpu_to_le16(status << 1 | cq->phase);
+        cqe.sq_id = cpu_to_le16(sq->sqid);
+        cqe.sq_head = cpu_to_le16(sq->head);
+        addr = cq->dma_addr + cq->tail * n->cqe_size;
+        nvme_inc_cq_tail(cq);
+        pci_dma_write(&n->parent_obj, addr, (void *)&cqe, sizeof(cqe));
+        nvme_isr_notify(n, cq);
+    }
+}
+
+static void nvme_process_admin_db(NvmeCtrl *n, hwaddr addr, int val)
+{
+    uint32_t qid;
+
+    if (((addr - 0x1000) >> 2) & 1) {
+        uint16_t new_head = val & 0xffff;
+        NvmeCQueue *cq;
+
+        qid = (addr - (0x1000 + (1 << 2))) >> 3;
+        if (nvme_check_cqid(n, qid)) {
+            return;
+        }
+
+        cq = n->cq[qid];
+        if (new_head >= cq->size) {
+            return;
+        }
+
+        cq->head = new_head;
+
+        if (cq->tail != cq->head) {
+            nvme_isr_notify(n, cq);
+        }
+    } else {
+        uint16_t new_tail = val & 0xffff;
+        NvmeSQueue *sq;
+
+        qid = (addr - 0x1000) >> 3;
+        if (nvme_check_sqid(n, qid)) {
+            return;
+        }
+
+        sq = n->sq[qid];
+        if (new_tail >= sq->size) {
+            return;
+        }
+
+        sq->tail = new_tail;
+        nvme_process_admin_cmd(sq);
+    }
+}
+
+static void
+nvme_process_io_db(NvmeCtrl *n, hwaddr addr, int val)
+{
+    uint16_t cq_head, sq_tail;
+    uint32_t qid;
+
+    /* Do nothing after the doorbell buffer config command*/
+    if (n->dataplane_started) {
+        return;
+    }
+
+    if (((addr - 0x1000) >> 2) & 1) {
+        qid = (addr - (0x1000 + (1 << 2))) >> 3;
+        cq_head = val & 0xffff;
+        vhost_user_nvme_io_cmd_pass(&n->dev, qid,
+                                    cq_head, false);
+    } else {
+        qid = (addr - 0x1000) >> 3;
+        sq_tail = val & 0xffff;
+        vhost_user_nvme_io_cmd_pass(&n->dev, qid,
+                                    sq_tail, true);
+    }
+
+    return;
+}
+
+static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
+    unsigned size)
+{
+    NvmeCtrl *n = (NvmeCtrl *)opaque;
+    if (addr < sizeof(n->bar)) {
+        nvme_write_bar(n, addr, data, size);
+    } else if (addr >= 0x1000 && addr < 0x1008) {
+        nvme_process_admin_db(n, addr, data);
+    } else {
+        nvme_process_io_db(n, addr, data);
+    }
+}
+
+static const MemoryRegionOps nvme_mmio_ops = {
+    .read = nvme_mmio_read,
+    .write = nvme_mmio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 2,
+        .max_access_size = 8,
+    },
+};
+
+static void nvme_cleanup(NvmeCtrl *n)
+{
+    g_free(n->sq);
+    g_free(n->cq);
+    g_free(n->namespaces);
+}
+
+static int nvme_init(PCIDevice *pci_dev)
+{
+    NvmeCtrl *n = NVME_VHOST(pci_dev);
+    NvmeIdCtrl *id = &n->id_ctrl;
+    NvmeIdentify cmd;
+    int ret, i;
+    uint8_t *pci_conf;
+
+    if (!n->chardev.chr) {
+        error_report("vhost-user-nvme: missing chardev");
+        return -1;
+    }
+
+    if (vhost_dev_nvme_init(&n->dev, (void *)&n->chardev,
+                         VHOST_BACKEND_TYPE_USER, 0) < 0) {
+        error_report("vhost-user-nvme: vhost_dev_init failed");
+        return -1;
+    }
+
+    pci_conf = pci_dev->config;
+    pci_conf[PCI_INTERRUPT_PIN] = 1;
+    pci_config_set_prog_interface(pci_dev->config, 0x2);
+    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
+    pcie_endpoint_cap_init(&n->parent_obj, 0x80);
+
+    n->reg_size = pow2ceil(0x1004 + 2 * (n->num_io_queues + 2) * 4);
+
+    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
+                          "nvme", n->reg_size);
+    pci_register_bar(&n->parent_obj, 0,
+        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
+        &n->iomem);
+    msix_init_exclusive_bar(&n->parent_obj, n->num_io_queues + 1, 4, NULL);
+
+    /* Get PCI capabilities via socket */
+    n->bar.cap = 0;
+    ret = vhost_user_nvme_get_cap(&n->dev, &n->bar.cap);
+    if (ret < 0) {
+        error_report("vhost-user-nvme: get controller capabilities failed");
+        return -1;
+    }
+    fprintf(stdout, "Emulated Controller Capabilities 0x%"PRIx64"\n",
+            n->bar.cap);
+
+    /* Get Identify Controller from backend process */
+    cmd.opcode = NVME_ADM_CMD_IDENTIFY;
+    cmd.cns = 0x1;
+    ret = vhost_user_nvme_admin_cmd_raw(&n->dev, (NvmeCmd *)&cmd,
+                                        id, sizeof(*id));
+    if (ret < 0) {
+        error_report("vhost-user-nvme: get identify controller failed");
+        return -1;
+    }
+
+    /* TODO: Don't support Controller Memory Buffer and AER now */
+    n->bar.vs = 0x00010000;
+    n->bar.intmc = n->bar.intms = 0;
+
+    n->namespaces = g_new0(NvmeNamespace, id->nn);
+    n->sq = g_new0(NvmeSQueue *, n->num_io_queues + 1);
+    n->cq = g_new0(NvmeCQueue *, n->num_io_queues + 1);
+    assert(n->sq != NULL);
+    assert(n->cq != NULL);
+
+    for (i = 1; i <= id->nn; i++) {
+        cmd.opcode = NVME_ADM_CMD_IDENTIFY;
+        cmd.cns = 0x0;
+        cmd.nsid = i;
+        ret = vhost_user_nvme_admin_cmd_raw(&n->dev, (NvmeCmd *)&cmd,
+                                            &n->namespaces[i - 1],
+                                            sizeof(NvmeNamespace));
+        if (ret < 0) {
+            error_report("vhost-user-nvme: get ns %d failed", i);
+            goto err;
+        }
+    }
+
+    return 0;
+
+err:
+    nvme_cleanup(n);
+    return -1;
+}
+
+static void nvme_exit(PCIDevice *pci_dev)
+{
+    NvmeCtrl *n = NVME_VHOST(pci_dev);
+
+    nvme_cleanup(n);
+    msix_uninit_exclusive_bar(pci_dev);
+}
+
+static Property nvme_props[] = {
+    DEFINE_PROP_UINT32("num_io_queues", NvmeCtrl, num_io_queues, 1),
+    DEFINE_PROP_CHR("chardev", NvmeCtrl, chardev),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription nvme_vmstate = {
+    .name = "nvme",
+    .unmigratable = 1,
+};
+
+static void nvme_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->init = nvme_init;
+    pc->exit = nvme_exit;
+    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
+    pc->vendor_id = PCI_VENDOR_ID_INTEL;
+    pc->device_id = 0x5845;
+    pc->revision = 2;
+    pc->is_express = 1;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc = "Non-Volatile Memory Express";
+    dc->props = nvme_props;
+    dc->vmsd = &nvme_vmstate;
+}
+
+static void nvme_instance_init(Object *obj)
+{
+    NvmeCtrl *s = NVME_VHOST(obj);
+
+    device_add_bootindex_property(obj, &s->bootindex,
+                                  "bootindex", "/namespace@1,0",
+                                  DEVICE(obj), &error_abort);
+}
+
+static const TypeInfo nvme_info = {
+    .name          = "vhost-user-nvme",
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(NvmeCtrl),
+    .class_init    = nvme_class_init,
+    .instance_init = nvme_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void nvme_register_types(void)
+{
+    type_register_static(&nvme_info);
+}
+
+type_init(nvme_register_types)
diff --git a/hw/block/vhost_user_nvme.h b/hw/block/vhost_user_nvme.h
new file mode 100644
index 0000000..623338d
--- /dev/null
+++ b/hw/block/vhost_user_nvme.h
@@ -0,0 +1,38 @@
+#ifndef HW_VHOST_USER_NVME_H
+#define HW_VHOST_USER_NVME_H
+/*
+ * vhost-user-nvme
+ *
+ * Copyright (c) 2017 Intel Corporation. All rights reserved.
+ *
+ *  Author:
+ *  Changpeng Liu <changpeng.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "hw/pci/pci.h"
+#include "hw/block/block.h"
+#include "nvme.h"
+
+int vhost_dev_nvme_set_guest_notifier(struct vhost_dev *hdev,
+                                      EventNotifier *notifier, uint32_t qid);
+int vhost_dev_nvme_init(struct vhost_dev *hdev, void *opaque,
+                   VhostBackendType backend_type, uint32_t busyloop_timeout);
+void vhost_dev_nvme_cleanup(struct vhost_dev *hdev);
+
+
+int
+vhost_user_nvme_io_cmd_pass(struct vhost_dev *dev, uint16_t qid,
+                            uint16_t tail_head, bool submission_queue);
+int vhost_user_nvme_admin_cmd_raw(struct vhost_dev *dev, NvmeCmd *cmd,
+                                  void *buf, uint32_t len);
+int vhost_user_nvme_get_cap(struct vhost_dev *dev, uint64_t *cap);
+int vhost_dev_nvme_set_backend_type(struct vhost_dev *dev,
+                                    VhostBackendType backend_type);
+int vhost_dev_nvme_start(struct vhost_dev *hdev, VirtIODevice *vdev);
+int vhost_dev_nvme_stop(struct vhost_dev *hdev);
+
+#endif
-- 
1.9.3
