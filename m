Received: from eggs.gnu.org ([2001:4830:134:3::10]:39053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkUY-0005Fs-6s
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSkUS-0004Mi-Ql
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:37:18 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  5 Jul 2017 21:36:31 +0800
Message-Id: <20170705133635.11850-3-famz@redhat.com>
In-Reply-To: <20170705133635.11850-1-famz@redhat.com>
References: <20170705133635.11850-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/6] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

This is a new protocol driver that exclusively opens a host NVMe
controller through VFIO. It achieves better latency than linux-aio by
completely bypassing host kernel vfs/block layer.

    $rw-$bs-$iodepth  linux-aio     nvme://
    ----------------------------------------
    randread-4k-1     8269          8851
    randread-512k-1   584           610
    randwrite-4k-1    28601         34649
    randwrite-512k-1  1809          1975

The driver also integrates with the polling mechanism of iothread.

This patch is co-authored by Paolo and me.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 MAINTAINERS         |    6 +
 block/Makefile.objs |    1 +
 block/nvme-vfio.c   |  703 +++++++++++++++++++++++++++++++++
 block/nvme-vfio.h   |   30 ++
 block/nvme.c        | 1091 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/trace-events  |   32 ++
 6 files changed, 1863 insertions(+)
 create mode 100644 block/nvme-vfio.c
 create mode 100644 block/nvme-vfio.h
 create mode 100644 block/nvme.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 839f7ca..4cce80c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1746,6 +1746,12 @@ L: qemu-block@nongnu.org
 S: Supported
 F: block/null.c
 
+NVMe Block Driver
+M: Fam Zheng <famz@redhat.com>
+L: qemu-block@nongnu.org
+S: Supported
+F: block/nvme*
+
 Bootdevice
 M: Gonglei <arei.gonglei@huawei.com>
 S: Maintained
diff --git a/block/Makefile.objs b/block/Makefile.objs
index f9368b5..8866487 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -11,6 +11,7 @@ block-obj-$(CONFIG_POSIX) += file-posix.o
 block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 block-obj-y += null.o mirror.o commit.o io.o
 block-obj-y += throttle-groups.o
+block-obj-$(CONFIG_LINUX) += nvme.o nvme-vfio.o
 
 block-obj-y += nbd.o nbd-client.o sheepdog.o
 block-obj-$(CONFIG_LIBISCSI) += iscsi.o
diff --git a/block/nvme-vfio.c b/block/nvme-vfio.c
new file mode 100644
index 0000000..f030a82
--- /dev/null
+++ b/block/nvme-vfio.c
@@ -0,0 +1,703 @@
+/*
+ * NVMe VFIO interface
+ *
+ * Copyright 2016, 2017 Red Hat, Inc.
+ *
+ * Authors:
+ *   Fam Zheng <famz@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qapi/error.h"
+#include "exec/ramlist.h"
+#include "exec/cpu-common.h"
+#include "trace.h"
+#include "qemu/queue.h"
+#include "qemu/error-report.h"
+#include "standard-headers/linux/pci_regs.h"
+#include "qemu/event_notifier.h"
+#include "block/nvme-vfio.h"
+#include "trace.h"
+
+#define NVME_DEBUG 0
+
+#define NVME_VFIO_IOVA_MIN 0x10000ULL
+/* XXX: Once VFIO exposes the iova bit width in the IOMMU capability interface,
+ * we can use a runtime limit; alternatively it's also possible to do platform
+ * specific detection by reading sysfs entries. Until then, 39 is a safe bet.
+ **/
+#define NVME_VFIO_IOVA_MAX (1ULL << 39)
+
+typedef struct {
+    /* Page aligned addr. */
+    void *host;
+    size_t size;
+    uint64_t iova;
+} IOVAMapping;
+
+struct NVMeVFIOState {
+    int container;
+    int group;
+    int device;
+    RAMBlockNotifier ram_notifier;
+    struct vfio_region_info config_region_info, bar_region_info[6];
+
+    /* VFIO's IO virtual address space is managed by splitting into a few
+     * sections:
+     *
+     * ---------------       <= 0
+     * |xxxxxxxxxxxxx|
+     * |-------------|       <= NVME_VFIO_IOVA_MIN
+     * |             |
+     * |    Fixed    |
+     * |             |
+     * |-------------|       <= low_water_mark
+     * |             |
+     * |    Free     |
+     * |             |
+     * |-------------|       <= high_water_mark
+     * |             |
+     * |    Temp     |
+     * |             |
+     * |-------------|       <= NVME_VFIO_IOVA_MAX
+     * |xxxxxxxxxxxxx|
+     * |xxxxxxxxxxxxx|
+     * ---------------
+     *
+     * - Addresses lower than NVME_VFIO_IOVA_MIN are reserved as invalid;
+     *
+     * - Fixed mappings of HVAs are assigned "low" IOVAs in the range of
+     *   [NVME_VFIO_IOVA_MIN, low_water_mark).  Once allocated they will not be
+     *   reclaimed - low_water_mark never shrinks;
+     *
+     * - IOVAs in range [low_water_mark, high_water_mark) are free;
+     *
+     * - IOVAs in range [high_water_mark, NVME_VFIO_IOVA_MAX) are volatile
+     *   mappings. At each nvme_vfio_dma_reset_temporary() call, the whole area
+     *   is recycled. The caller should make sure I/O's depending on these
+     *   mappings are completed before calling.
+     **/
+    uint64_t low_water_mark;
+    uint64_t high_water_mark;
+    IOVAMapping *mappings;
+    int nr_mappings;
+    QemuMutex lock;
+};
+
+/** Find group file and return the full path in @path by PCI device address
+ * @device. If succeeded, caller needs to g_free the returned path. */
+static int sysfs_find_group_file(const char *device, char **path, Error **errp)
+{
+    int ret;
+    char *sysfs_link = NULL;
+    char *sysfs_group = NULL;
+    char *p;
+
+    sysfs_link = g_strdup_printf("/sys/bus/pci/devices/%s/iommu_group",
+                                 device);
+    sysfs_group = g_malloc(PATH_MAX);
+    ret = readlink(sysfs_link, sysfs_group, PATH_MAX - 1);
+    if (ret == -1) {
+        error_setg_errno(errp, errno, "Failed to find iommu group sysfs path");
+        ret = -errno;
+        goto out;
+    }
+    ret = 0;
+    p = strrchr(sysfs_group, '/');
+    if (!p) {
+        error_setg(errp, "Failed to find iommu group number");
+        ret = -errno;
+        goto out;
+    }
+
+    *path = g_strdup_printf("/dev/vfio/%s", p + 1);
+out:
+    g_free(sysfs_link);
+    g_free(sysfs_group);
+    return ret;
+}
+
+static int nvme_vfio_pci_init_bar(NVMeVFIOState *s, unsigned int index,
+                                  Error **errp)
+{
+    assert(index < ARRAY_SIZE(s->bar_region_info));
+    s->bar_region_info[index] = (struct vfio_region_info) {
+        .index = VFIO_PCI_BAR0_REGION_INDEX + index,
+        .argsz = sizeof(struct vfio_region_info),
+    };
+    if (ioctl(s->device, VFIO_DEVICE_GET_REGION_INFO, &s->bar_region_info[index])) {
+        error_setg_errno(errp, errno, "Failed to get BAR region info");
+        return -errno;
+    }
+
+    return 0;
+}
+
+/**
+ * Map a PCI bar area.
+ */
+void *nvme_vfio_pci_map_bar(NVMeVFIOState *s, int index, Error **errp)
+{
+    void *p;
+    assert(index >= 0 && index < 6);
+    p = mmap(NULL, MIN(8192, s->bar_region_info[index].size),
+             PROT_READ | PROT_WRITE, MAP_SHARED,
+             s->device, s->bar_region_info[index].offset);
+    if (p == MAP_FAILED) {
+        error_setg_errno(errp, errno, "Failed to map BAR region");
+        p = NULL;
+    }
+    return p;
+}
+
+/**
+ * Unmap a PCI bar area.
+ */
+void nvme_vfio_pci_unmap_bar(NVMeVFIOState *s, int index, void *bar)
+{
+    if (bar) {
+        munmap(bar, MIN(8192, s->bar_region_info[index].size));
+    }
+}
+
+/**
+ * Initialize device IRQ with @irq_type and and register an event notifier.
+ */
+int nvme_vfio_pci_init_irq(NVMeVFIOState *s, EventNotifier *e,
+                           int irq_type, Error **errp)
+{
+    int r;
+    struct vfio_irq_set *irq_set;
+    size_t irq_set_size;
+    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+
+    irq_info.index = irq_type;
+    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
+        error_setg_errno(errp, errno, "Failed to get device interrupt info");
+        return -errno;
+    }
+    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
+        error_setg(errp, "Device interrupt doesn't support eventfd");
+        return -EINVAL;
+    }
+
+    irq_set_size = sizeof(*irq_set) + sizeof(int);
+    irq_set = g_malloc0(irq_set_size);
+
+    /* Get to a known IRQ state */
+    *irq_set = (struct vfio_irq_set) {
+        .argsz = irq_set_size,
+        .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
+        .index = irq_info.index,
+        .start = 0,
+        .count = 1,
+    };
+
+    *(int *)&irq_set->data = event_notifier_get_fd(e);
+    r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
+    g_free(irq_set);
+    if (r) {
+        error_setg_errno(errp, errno, "Failed to setup device interrupt");
+        return -errno;
+    }
+    return 0;
+}
+
+static int nvme_vfio_pci_read_config(NVMeVFIOState *s, void *buf,
+                                     int size, int ofs)
+{
+    if (pread(s->device, buf, size,
+              s->config_region_info.offset + ofs) == size) {
+        return 0;
+    }
+    return -1;
+}
+
+static int nvme_vfio_pci_write_config(NVMeVFIOState *s, void *buf, int size, int ofs)
+{
+    if (pwrite(s->device, buf, size,
+               s->config_region_info.offset + ofs) == size) {
+        return 0;
+    }
+
+    return -1;
+}
+
+static int nvme_vfio_init_pci(NVMeVFIOState *s, const char *device,
+                              Error **errp)
+{
+    int ret;
+    int i;
+    uint16_t pci_cmd;
+    struct vfio_group_status group_status = { .argsz = sizeof(group_status) };
+    struct vfio_iommu_type1_info iommu_info = { .argsz = sizeof(iommu_info) };
+    struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
+    char *group_file = NULL;
+
+    /* Create a new container */
+    s->container = open("/dev/vfio/vfio", O_RDWR);
+
+    if (ioctl(s->container, VFIO_GET_API_VERSION) != VFIO_API_VERSION) {
+        error_setg(errp, "Invalid VFIO version");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    if (!ioctl(s->container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
+        error_setg_errno(errp, errno, "VFIO IOMMU check failed");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    /* Open the group */
+    ret = sysfs_find_group_file(device, &group_file, errp);
+    if (ret) {
+        goto out;
+    }
+
+    s->group = open(group_file, O_RDWR);
+    g_free(group_file);
+    if (s->group <= 0) {
+        error_setg_errno(errp, errno, "Failed to open VFIO group file");
+        ret = -errno;
+        goto out;
+    }
+
+    /* Test the group is viable and available */
+    if (ioctl(s->group, VFIO_GROUP_GET_STATUS, &group_status)) {
+        error_setg_errno(errp, errno, "Failed to get VFIO group status");
+        ret = -errno;
+        goto out;
+    }
+
+    if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
+        error_setg(errp, "VFIO group is not viable");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    /* Add the group to the container */
+    if (ioctl(s->group, VFIO_GROUP_SET_CONTAINER, &s->container)) {
+        error_setg_errno(errp, errno, "Failed to add group to VFIO container");
+        ret = -errno;
+        goto out;
+    }
+
+    /* Enable the IOMMU model we want */
+    if (ioctl(s->container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU)) {
+        error_setg_errno(errp, errno, "Failed to set VFIO IOMMU type");
+        ret = -errno;
+        goto out;
+    }
+
+    /* Get additional IOMMU info */
+    if (ioctl(s->container, VFIO_IOMMU_GET_INFO, &iommu_info)) {
+        error_setg_errno(errp, errno, "Failed to get IOMMU info");
+        ret = -errno;
+        goto out;
+    }
+
+    s->device = ioctl(s->group, VFIO_GROUP_GET_DEVICE_FD, device);
+
+    if (s->device < 0) {
+        error_setg_errno(errp, errno, "Failed to get device fd");
+        ret = -errno;
+        goto out;
+    }
+
+    /* Test and setup the device */
+    if (ioctl(s->device, VFIO_DEVICE_GET_INFO, &device_info)) {
+        error_setg_errno(errp, errno, "Failed to get device info");
+        ret = -errno;
+        goto out;
+    }
+
+    if (device_info.num_regions < VFIO_PCI_CONFIG_REGION_INDEX) {
+        error_setg(errp, "Invalid device regions");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    s->config_region_info = (struct vfio_region_info) {
+        .index = VFIO_PCI_CONFIG_REGION_INDEX,
+        .argsz = sizeof(struct vfio_region_info),
+    };
+    if (ioctl(s->device, VFIO_DEVICE_GET_REGION_INFO, &s->config_region_info)) {
+        error_setg_errno(errp, errno, "Failed to get config region info");
+        ret = -errno;
+        goto out;
+    }
+
+    for (i = 0; i < 6; i++) {
+        ret = nvme_vfio_pci_init_bar(s, i, errp);
+        if (ret) {
+            goto out;
+        }
+    }
+
+    /* Enable bus master */
+    if (nvme_vfio_pci_read_config(s, &pci_cmd, sizeof(pci_cmd),
+                                  PCI_COMMAND) < 0) {
+        goto out;
+    }
+    pci_cmd |= PCI_COMMAND_MASTER;
+    if (nvme_vfio_pci_write_config(s, &pci_cmd, sizeof(pci_cmd),
+                                   PCI_COMMAND) < 0) {
+        goto out;
+    }
+out:
+    return ret;
+}
+
+static void nvme_vfio_ram_block_added(RAMBlockNotifier *n,
+                                      void *host, size_t size)
+{
+    NVMeVFIOState *s = container_of(n, NVMeVFIOState, ram_notifier);
+    trace_nvme_vfio_ram_block_added(host, size);
+    nvme_vfio_dma_map(s, host, size, false, NULL);
+}
+
+static void nvme_vfio_ram_block_removed(RAMBlockNotifier *n,
+                                        void *host, size_t size)
+{
+    NVMeVFIOState *s = container_of(n, NVMeVFIOState, ram_notifier);
+    if (host) {
+        trace_nvme_vfio_ram_block_removed(host, size);
+        nvme_vfio_dma_unmap(s, host);
+    }
+}
+
+static int nvme_vfio_init_ramblock(const char *block_name, void *host_addr,
+                                   ram_addr_t offset, ram_addr_t length,
+                                   void *opaque)
+{
+    int ret;
+    NVMeVFIOState *s = opaque;
+
+    if (!host_addr) {
+        return 0;
+    }
+    ret = nvme_vfio_dma_map(s, host_addr, length, false, NULL);
+    if (ret) {
+        fprintf(stderr, "nvme_vfio_init_ramblock: failed %p %ld\n",
+                host_addr, length);
+    }
+    return 0;
+}
+
+static void nvme_vfio_open_common(NVMeVFIOState *s)
+{
+    s->ram_notifier.ram_block_added = nvme_vfio_ram_block_added;
+    s->ram_notifier.ram_block_removed = nvme_vfio_ram_block_removed;
+    ram_block_notifier_add(&s->ram_notifier);
+    s->low_water_mark = NVME_VFIO_IOVA_MIN;
+    s->high_water_mark = NVME_VFIO_IOVA_MAX;
+    qemu_ram_foreach_block(nvme_vfio_init_ramblock, s);
+    qemu_mutex_init(&s->lock);
+}
+
+/**
+ * Open a PCI device, e.g. "0000:00:01.0".
+ */
+NVMeVFIOState *nvme_vfio_open_pci(const char *device, Error **errp)
+{
+    int r;
+    NVMeVFIOState *s = g_new0(NVMeVFIOState, 1);
+
+    r = nvme_vfio_init_pci(s, device, errp);
+    if (r) {
+        g_free(s);
+        return NULL;
+    }
+    nvme_vfio_open_common(s);
+    return s;
+}
+
+static void nvme_vfio_dump_mapping(IOVAMapping *m)
+{
+    if (NVME_DEBUG) {
+        printf("  vfio mapping %p %lx to %lx\n", m->host, m->size, m->iova);
+    }
+}
+
+static void nvme_vfio_dump_mappings(NVMeVFIOState *s)
+{
+    int i;
+
+    if (NVME_DEBUG) {
+        printf("vfio mappings\n");
+        for (i = 0; i < s->nr_mappings; ++i) {
+            nvme_vfio_dump_mapping(&s->mappings[i]);
+        }
+    }
+}
+
+/**
+ * Find the mapping entry that contains [host, host + size) and set @index to
+ * the position. If no entry contains it, @index is the position _after_ which
+ * to insert the new mapping. IOW, it is the index of the largest element that
+ * is smaller than @host, or -1 if no entry is.
+ */
+static IOVAMapping *nvme_vfio_find_mapping(NVMeVFIOState *s, void *host,
+                                           int *index)
+{
+    IOVAMapping *p = s->mappings;
+    IOVAMapping *q = p ? p + s->nr_mappings - 1 : NULL;
+    IOVAMapping *mid = p ? p + (q - p) / 2 : NULL;
+    trace_nvme_vfio_find_mapping(s, host);
+    if (!p) {
+        *index = -1;
+        return NULL;
+    }
+    while (true) {
+        mid = p + (q - p) / 2;
+        if (mid == p) {
+            break;
+        }
+        if (mid->host > host) {
+            q = mid;
+        } else if (mid->host < host) {
+            p = mid;
+        } else {
+            break;
+        }
+    }
+    if (mid->host > host) {
+        mid--;
+    } else if (mid < &s->mappings[s->nr_mappings - 1]
+               && (mid + 1)->host <= host) {
+        mid++;
+    }
+    *index = mid - &s->mappings[0];
+    if (mid >= &s->mappings[0] &&
+        mid->host <= host && mid->host + mid->size > host) {
+        assert(mid < &s->mappings[s->nr_mappings]);
+        return mid;
+    }
+    return NULL;
+}
+
+/**
+ * Allocate IOVA and and create a new mapping record and insert it in @s.
+ */
+static IOVAMapping *nvme_vfio_add_mapping(NVMeVFIOState *s,
+                                          void *host, size_t size,
+                                          int index, uint64_t iova)
+{
+    int shift;
+    IOVAMapping m = {.host = host, .size = size, iova = iova};
+    IOVAMapping *insert;
+
+    assert(QEMU_IS_ALIGNED(size, getpagesize()));
+    assert(QEMU_IS_ALIGNED(s->low_water_mark, getpagesize()));
+    assert(QEMU_IS_ALIGNED(s->high_water_mark, getpagesize()));
+    trace_nvme_vfio_new_mapping(s, host, size, index, iova);
+
+    assert(index >= 0);
+    s->nr_mappings++;
+    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
+                              s->nr_mappings);
+    insert = &s->mappings[index];
+    shift = s->nr_mappings - index - 1;
+    if (shift) {
+        memmove(insert + 1, insert, shift * sizeof(s->mappings[0]));
+    }
+    *insert = m;
+    return insert;
+}
+
+/* Do the DMA mapping with VFIO. */
+static int nvme_vfio_do_mapping(NVMeVFIOState *s, void *host, size_t size,
+                                uint64_t iova)
+{
+    struct vfio_iommu_type1_dma_map dma_map = {
+        .argsz = sizeof(dma_map),
+        .flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+        .iova = iova,
+        .vaddr = (uintptr_t)host,
+        .size = size,
+    };
+    trace_nvme_vfio_do_mapping(s, host, size, iova);
+
+    if (ioctl(s->container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
+        error_report("VFIO_MAP_DMA: %d", -errno);
+        return -errno;
+    }
+    return 0;
+}
+
+/**
+ * Undo the DMA mapping from @s with VFIO, and remove from mapping list.
+ */
+static void nvme_vfio_undo_mapping(NVMeVFIOState *s, IOVAMapping *mapping,
+                                   Error **errp)
+{
+    int index;
+    struct vfio_iommu_type1_dma_unmap unmap = {
+        .argsz = sizeof(unmap),
+        .flags = 0,
+        .iova = mapping->iova,
+        .size = mapping->size,
+    };
+
+    index = mapping - s->mappings;
+    assert(mapping->size > 0);
+    assert(QEMU_IS_ALIGNED(mapping->size, getpagesize()));
+    assert(index >= 0 && index < s->nr_mappings);
+    if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        error_setg(errp, "VFIO_UNMAP_DMA failed: %d", -errno);
+    }
+    memmove(mapping, &s->mappings[index + 1],
+            sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
+    s->nr_mappings--;
+    s->mappings = g_realloc_n(s->mappings, sizeof(s->mappings[0]),
+                              s->nr_mappings);
+}
+
+/* Check if the mapping list is (ascending) ordered. */
+static bool nvme_vfio_verify_mappings(NVMeVFIOState *s)
+{
+    int i;
+    if (NVME_DEBUG) {
+        for (i = 0; i < s->nr_mappings - 1; ++i) {
+            if (!(s->mappings[i].host < s->mappings[i + 1].host)) {
+                fprintf(stderr, "item %d not sorted!\n", i);
+                nvme_vfio_dump_mappings(s);
+                return false;
+            }
+            if (!(s->mappings[i].host + s->mappings[i].size <=
+                  s->mappings[i + 1].host)) {
+                fprintf(stderr, "item %d overlap with next!\n", i);
+                nvme_vfio_dump_mappings(s);
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
+/* Map [host, host + size) area into a contiguous IOVA address space, and store
+ * the result in @iova if not NULL. The area must be aligned to page size, and
+ * mustn't overlap with existing mapping areas.
+ */
+int nvme_vfio_dma_map(NVMeVFIOState *s, void *host, size_t size,
+                      bool temporary, uint64_t *iova)
+{
+    int ret = 0;
+    int index;
+    IOVAMapping *mapping;
+    uint64_t iova0;
+
+    assert(QEMU_PTR_IS_ALIGNED(host, getpagesize()));
+    assert(QEMU_IS_ALIGNED(size, getpagesize()));
+    trace_nvme_vfio_dma_map(s, host, size, temporary, iova);
+    qemu_mutex_lock(&s->lock);
+    mapping = nvme_vfio_find_mapping(s, host, &index);
+    if (mapping) {
+        iova0 = mapping->iova + ((uint8_t *)host - (uint8_t *)mapping->host);
+    } else {
+        if (s->high_water_mark - s->low_water_mark + 1 < size) {
+            ret = -ENOMEM;
+            goto out;
+        }
+        if (!temporary) {
+            iova0 = s->low_water_mark;
+            mapping = nvme_vfio_add_mapping(s, host, size, index + 1, iova0);
+            if (!mapping) {
+                ret = -ENOMEM;
+                goto out;
+            }
+            assert(nvme_vfio_verify_mappings(s));
+            ret = nvme_vfio_do_mapping(s, host, size, iova0);
+            if (ret) {
+                nvme_vfio_undo_mapping(s, mapping, NULL);
+                goto out;
+            }
+            s->low_water_mark += size;
+            nvme_vfio_dump_mappings(s);
+        } else {
+            iova0 = s->high_water_mark - size;
+            ret = nvme_vfio_do_mapping(s, host, size, iova0);
+            if (ret) {
+                goto out;
+            }
+            s->high_water_mark -= size;
+        }
+    }
+    if (iova) {
+        *iova = iova0;
+    }
+    qemu_mutex_unlock(&s->lock);
+out:
+    return ret;
+}
+
+/* Reset the high watermark and free all "temporary" mappings. */
+int nvme_vfio_dma_reset_temporary(NVMeVFIOState *s)
+{
+    struct vfio_iommu_type1_dma_unmap unmap = {
+        .argsz = sizeof(unmap),
+        .flags = 0,
+        .iova = s->high_water_mark,
+        .size = NVME_VFIO_IOVA_MAX - s->high_water_mark,
+    };
+    trace_nvme_vfio_dma_reset_temporary(s);
+    qemu_mutex_lock(&s->lock);
+    if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        error_report("VFIO_UNMAP_DMA: %d", -errno);
+        return -errno;
+    }
+    s->high_water_mark = NVME_VFIO_IOVA_MAX;
+    qemu_mutex_lock(&s->lock);
+    return 0;
+}
+
+/* Unmapping the whole area that was previously mapped with
+ * nvme_vfio_dma_map(). */
+void nvme_vfio_dma_unmap(NVMeVFIOState *s, void *host)
+{
+    int index = 0;
+    IOVAMapping *m;
+
+    if (!host) {
+        return;
+    }
+
+    trace_nvme_vfio_dma_unmap(s, host);
+    qemu_mutex_lock(&s->lock);
+    m = nvme_vfio_find_mapping(s, host, &index);
+    if (!m) {
+        goto out;
+    }
+    nvme_vfio_undo_mapping(s, m, NULL);
+out:
+    qemu_mutex_unlock(&s->lock);
+}
+
+static void nvme_vfio_reset(NVMeVFIOState *s)
+{
+    ioctl(s->device, VFIO_DEVICE_RESET);
+}
+
+/* Close and free the VFIO resources. */
+void nvme_vfio_close(NVMeVFIOState *s)
+{
+    int i;
+
+    if (!s) {
+        return;
+    }
+    for (i = 0; i < s->nr_mappings; ++i) {
+        nvme_vfio_undo_mapping(s, &s->mappings[i], NULL);
+    }
+    ram_block_notifier_remove(&s->ram_notifier);
+    nvme_vfio_reset(s);
+    close(s->device);
+    close(s->group);
+    close(s->container);
+}
diff --git a/block/nvme-vfio.h b/block/nvme-vfio.h
new file mode 100644
index 0000000..2d5840b
--- /dev/null
+++ b/block/nvme-vfio.h
@@ -0,0 +1,30 @@
+/*
+ * NVMe VFIO interface
+ *
+ * Copyright 2016, 2017 Red Hat, Inc.
+ *
+ * Authors:
+ *   Fam Zheng <famz@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_VFIO_H
+#define QEMU_VFIO_H
+#include "qemu/queue.h"
+
+typedef struct NVMeVFIOState NVMeVFIOState;
+
+NVMeVFIOState *nvme_vfio_open_pci(const char *device, Error **errp);
+void nvme_vfio_close(NVMeVFIOState *s);
+int nvme_vfio_dma_map(NVMeVFIOState *s, void *host, size_t size,
+                      bool temporary, uint64_t *iova_list);
+int nvme_vfio_dma_reset_temporary(NVMeVFIOState *s);
+void nvme_vfio_dma_unmap(NVMeVFIOState *s, void *host);
+void *nvme_vfio_pci_map_bar(NVMeVFIOState *s, int index, Error **errp);
+void nvme_vfio_pci_unmap_bar(NVMeVFIOState *s, int index, void *bar);
+int nvme_vfio_pci_init_irq(NVMeVFIOState *s, EventNotifier *e,
+                           int irq_type, Error **errp);
+
+#endif
diff --git a/block/nvme.c b/block/nvme.c
new file mode 100644
index 0000000..eb999a1
--- /dev/null
+++ b/block/nvme.c
@@ -0,0 +1,1091 @@
+/*
+ * NVMe block driver based on vfio
+ *
+ * Copyright 2016, 2017 Red Hat, Inc.
+ *
+ * Authors:
+ *   Fam Zheng <famz@redhat.com>
+ *   Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+#include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qemu/error-report.h"
+#include "qemu/cutils.h"
+#include "block/block_int.h"
+#include "block/nvme-vfio.h"
+#include "trace.h"
+
+/* TODO: Move nvme spec definitions from hw/block/nvme.h into a separate file
+ * that doesn't depend on dma/pci headers. */
+#include "sysemu/dma.h"
+#include "hw/pci/pci.h"
+#include "hw/block/block.h"
+#include "hw/block/nvme.h"
+
+#define NVME_SQ_ENTRY_BYTES 64
+#define NVME_CQ_ENTRY_BYTES 16
+#define NVME_QUEUE_SIZE 128
+
+typedef struct {
+    int32_t  head, tail;
+    uint8_t  *queue;
+    uint64_t iova;
+    volatile uint32_t *doorbell;
+} NVMeQueue;
+
+typedef struct {
+    BlockCompletionFunc *cb;
+    void *opaque;
+    int cid;
+    void *prp_list_page;
+    uint64_t prp_list_iova;
+    bool busy;
+} NVMeRequest;
+
+typedef struct {
+    int         index;
+    NVMeQueue   sq, cq;
+    int         cq_phase;
+    uint8_t     *prp_list_pages;
+    uint64_t    prp_list_base_iova;
+    NVMeRequest reqs[NVME_QUEUE_SIZE];
+    CoQueue     free_req_queue;
+    bool        busy;
+    int         need_kick;
+    int         inflight;
+    QemuMutex   lock;
+} NVMeQueuePair;
+
+typedef volatile struct {
+    uint64_t cap;
+    uint32_t vs;
+    uint32_t intms;
+    uint32_t intmc;
+    uint32_t cc;
+    uint32_t reserved0;
+    uint32_t csts;
+    uint32_t nssr;
+    uint32_t aqa;
+    uint64_t asq;
+    uint64_t acq;
+    uint32_t cmbloc;
+    uint32_t cmbsz;
+    uint8_t  reserved1[0xec0];
+    uint8_t  cmd_set_specfic[0x100];
+    uint32_t doorbells[];
+} QEMU_PACKED NVMeRegs;
+
+QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
+
+typedef struct {
+    AioContext *aio_context;
+    NVMeVFIOState *vfio;
+    NVMeRegs *regs;
+    /* The submission/completion queue pairs.
+     * [0]: admin queue.
+     * [1..]: io queues.
+     */
+    NVMeQueuePair **queues;
+    int nr_queues;
+    size_t page_size;
+    /* How many uint32_t elements does each doorbell entry take. */
+    size_t doorbell_scale;
+    bool write_cache;
+    EventNotifier irq_notifier;
+    uint64_t nsze; /* Namespace size reported by identify command */
+    int nsid;      /* The namespace id to read/write data. */
+    uint64_t max_transfer;
+    int plugged;
+
+    CoMutex dma_map_lock;
+    CoQueue dma_flush_queue;
+
+    /* Total inflight */
+    int         inflight;
+} BDRVNVMeState;
+
+#define NVME_BLOCK_OPT_DEVICE "device"
+#define NVME_BLOCK_OPT_NAMESPACE "namespace"
+
+static QemuOptsList runtime_opts = {
+    .name = "nvme",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        {
+            .name = NVME_BLOCK_OPT_DEVICE,
+            .type = QEMU_OPT_STRING,
+            .help = "NVMe PCI device address",
+        },
+        {
+            .name = NVME_BLOCK_OPT_NAMESPACE,
+            .type = QEMU_OPT_NUMBER,
+            .help = "NVMe namespace",
+        },
+        { /* end of list */ }
+    },
+};
+
+static void nvme_init_queue(BlockDriverState *bs, NVMeQueue *q,
+                            int nentries, int entry_bytes, Error **errp)
+{
+    BDRVNVMeState *s = bs->opaque;
+    size_t bytes;
+    int r;
+
+    bytes = ROUND_UP(nentries * entry_bytes, s->page_size);
+    q->head = q->tail = 0;
+    q->queue = qemu_try_blockalign0(bs, bytes);
+
+    if (!q->queue) {
+        error_setg(errp, "Cannot allocate queue");
+        return;
+    }
+    r = nvme_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
+    if (r) {
+        error_setg(errp, "Cannot map queue");
+    }
+}
+
+static void nvme_free_queue_pair(BlockDriverState *bs, NVMeQueuePair *q)
+{
+    qemu_vfree(q->prp_list_pages);
+    qemu_vfree(q->sq.queue);
+    qemu_vfree(q->cq.queue);
+    g_free(q);
+}
+
+static void nvme_free_req_queue_cb(void *opaque)
+{
+    NVMeQueuePair *q = opaque;
+
+    qemu_co_enter_next(&q->free_req_queue);
+}
+
+static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
+                                             int idx, int size,
+                                             Error **errp)
+{
+    int i, r;
+    BDRVNVMeState *s = bs->opaque;
+    Error *local_err = NULL;
+    NVMeQueuePair *q = g_new0(NVMeQueuePair, 1);
+    uint64_t prp_list_iova;
+
+    qemu_mutex_init(&q->lock);
+    q->index = idx;
+    qemu_co_queue_init(&q->free_req_queue);
+    q->prp_list_pages = qemu_blockalign0(bs, s->page_size * NVME_QUEUE_SIZE);
+    r = nvme_vfio_dma_map(s->vfio, q->prp_list_pages,
+                          s->page_size * NVME_QUEUE_SIZE,
+                          false, &prp_list_iova);
+    if (r) {
+        goto fail;
+    }
+    for (i = 0; i < NVME_QUEUE_SIZE; i++) {
+        NVMeRequest *req = &q->reqs[i];
+        req->cid = i + 1;
+        req->prp_list_page = q->prp_list_pages + i * s->page_size;
+        req->prp_list_iova = prp_list_iova + i * s->page_size;
+    }
+    nvme_init_queue(bs, &q->sq, size, NVME_SQ_ENTRY_BYTES, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+    q->sq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale];
+
+    nvme_init_queue(bs, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
+    }
+    q->cq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale + 1];
+
+    return q;
+fail:
+    nvme_free_queue_pair(bs, q);
+    return NULL;
+}
+
+/* With q->lock */
+static void nvme_kick(BDRVNVMeState *s, NVMeQueuePair *q)
+{
+    if (s->plugged || !q->need_kick) {
+        return;
+    }
+    trace_nvme_kick(s, q->index);
+    assert(!(q->sq.tail & 0xFF00));
+    /* Fence the write to submission queue entry before notifying the device. */
+    smp_wmb();
+    *q->sq.doorbell = cpu_to_le32(q->sq.tail);
+    q->inflight += q->need_kick;
+    s->inflight += q->need_kick;
+    q->need_kick = 0;
+}
+
+static NVMeRequest *nvme_get_free_req(NVMeQueuePair *q)
+{
+    int i;
+    NVMeRequest *req = NULL;
+
+    qemu_mutex_lock(&q->lock);
+    while (q->inflight + q->need_kick > NVME_QUEUE_SIZE - 2) {
+        /* We have to leave one slot empty as that is the full queue case (head
+         * == tail + 1). */
+        trace_nvme_free_req_queue_wait(q);
+        qemu_mutex_unlock(&q->lock);
+        qemu_co_queue_wait(&q->free_req_queue, NULL);
+        qemu_mutex_lock(&q->lock);
+    }
+    for (i = 0; i < NVME_QUEUE_SIZE; i++) {
+        if (!q->reqs[i].busy) {
+            q->reqs[i].busy = true;
+            req = &q->reqs[i];
+            break;
+        }
+    }
+    assert(req);
+    qemu_mutex_unlock(&q->lock);
+    return req;
+}
+
+static inline int nvme_translate_error(const NvmeCqe *c)
+{
+    uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
+    if (status) {
+        trace_nvme_error(c->result, c->sq_head, c->sq_id, c->cid, status);
+    }
+    switch (status) {
+    case 0:
+        return 0;
+    case 1:
+        return -ENOSYS;
+    case 2:
+        return -EINVAL;
+    default:
+        return -EIO;
+    }
+}
+
+/* With q->lock */
+static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
+{
+    bool progress = false;
+    NVMeRequest *req;
+    NvmeCqe *c;
+
+    trace_nvme_process_completion(s, q->index, q->inflight);
+    if (q->busy || s->plugged) {
+        trace_nvme_process_completion_queue_busy(s, q->index);
+        return false;
+    }
+    q->busy = true;
+    assert(q->inflight >= 0);
+    while (q->inflight) {
+        c = (NvmeCqe *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_BYTES];
+        if (!c->cid || (le16_to_cpu(c->status) & 0x1) == q->cq_phase) {
+            break;
+        }
+        q->cq.head = (q->cq.head + 1) % NVME_QUEUE_SIZE;
+        if (!q->cq.head) {
+            q->cq_phase = !q->cq_phase;
+        }
+        if (c->cid == 0 || c->cid > NVME_QUEUE_SIZE) {
+            fprintf(stderr, "Unexpected CID in completion queue: %" PRIu32 "\n",
+                    c->cid);
+            continue;
+        }
+        assert(c->cid <= NVME_QUEUE_SIZE);
+        trace_nvme_complete_command(s, q->index, c->cid);
+        req = &q->reqs[c->cid - 1];
+        assert(req->cid == c->cid);
+        assert(req->cb);
+        req->cb(req->opaque, nvme_translate_error(c));
+        req->cb = req->opaque = NULL;
+        req->busy = false;
+        if (!qemu_co_queue_empty(&q->free_req_queue)) {
+            aio_bh_schedule_oneshot(s->aio_context, nvme_free_req_queue_cb, q);
+        }
+        c->cid = 0;
+        q->inflight--;
+        s->inflight--;
+        /* Flip Phase Tag bit. */
+        c->status = cpu_to_le16(le16_to_cpu(c->status) ^ 0x1);
+        progress = true;
+    }
+    if (progress) {
+        /* Notify the device so it can post more completions. */
+        smp_mb_release();
+        *q->cq.doorbell = cpu_to_le32(q->cq.head);
+    }
+    q->busy = false;
+    return progress;
+}
+
+static void nvme_trace_command(const NvmeCmd *cmd)
+{
+    int i;
+
+    for (i = 0; i < 8; ++i) {
+        uint8_t *cmdp = (uint8_t *)cmd + i * 8;
+        trace_nvme_submit_command_raw(cmdp[0], cmdp[1], cmdp[2], cmdp[3],
+                                      cmdp[4], cmdp[5], cmdp[6], cmdp[7]);
+    }
+}
+
+static void nvme_submit_command(BDRVNVMeState *s, NVMeQueuePair *q,
+                                NVMeRequest *req,
+                                NvmeCmd *cmd, BlockCompletionFunc cb,
+                                void *opaque)
+{
+    assert(!req->cb);
+    req->cb = cb;
+    req->opaque = opaque;
+    cmd->cid = cpu_to_le32(req->cid);
+
+    trace_nvme_submit_command(s, q->index, req->cid);
+    nvme_trace_command(cmd);
+    qemu_mutex_lock(&q->lock);
+    memcpy((uint8_t *)q->sq.queue +
+           q->sq.tail * NVME_SQ_ENTRY_BYTES, cmd, sizeof(*cmd));
+    q->sq.tail = (q->sq.tail + 1) % NVME_QUEUE_SIZE;
+    q->need_kick++;
+    nvme_kick(s, q);
+    nvme_process_completion(s, q);
+    qemu_mutex_unlock(&q->lock);
+}
+
+static void nvme_cmd_sync_cb(void *opaque, int ret)
+{
+    int *pret = opaque;
+    *pret = ret;
+}
+
+static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
+                         NvmeCmd *cmd)
+{
+    NVMeRequest *req;
+    BDRVNVMeState *s = bs->opaque;
+    int ret = -EINPROGRESS;
+    req = nvme_get_free_req(q);
+    if (!req) {
+        return -EBUSY;
+    }
+    nvme_submit_command(s, q, req, cmd, nvme_cmd_sync_cb, &ret);
+
+    BDRV_POLL_WHILE(bs, ret == -EINPROGRESS);
+    return ret;
+}
+
+static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
+{
+    BDRVNVMeState *s = bs->opaque;
+    uint8_t *resp;
+    int r;
+    uint64_t iova;
+    NvmeCmd cmd = {
+        .opcode = NVME_ADM_CMD_IDENTIFY,
+        .cdw10 = cpu_to_le32(0x1),
+    };
+
+    resp = qemu_try_blockalign0(bs, 4096);
+    if (!resp) {
+        error_setg(errp, "Cannot allocate buffer for identify response");
+        return false;
+    }
+    r = nvme_vfio_dma_map(s->vfio, resp, 4096, true, &iova);
+    if (r) {
+        error_setg(errp, "Cannot map buffer for DMA");
+        goto fail;
+    }
+    cmd.prp1 = cpu_to_le64(iova);
+
+    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+        error_setg(errp, "Failed to identify controller");
+        goto fail;
+    }
+
+    if (le32_to_cpu(*(uint32_t *)&resp[516]) < namespace) {
+        error_setg(errp, "Invalid namespace");
+        goto fail;
+    }
+    s->write_cache = le32_to_cpu(resp[525]) & 0x1;
+    s->max_transfer = (resp[77] ? 1 << resp[77] : 0) * s->page_size;
+    /* For now the page list buffer per command is one page, to hold at most
+     * s->page_size / sizeof(uint64_t) entries. */
+    s->max_transfer = MIN_NON_ZERO(s->max_transfer,
+                          s->page_size / sizeof(uint64_t) * s->page_size);
+
+    memset((char *)resp, 0, 4096);
+
+    cmd.cdw10 = 0;
+    cmd.nsid = namespace;
+    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+        error_setg(errp, "Failed to identify namespace");
+        goto fail;
+    }
+
+    s->nsze = le64_to_cpu(*(uint64_t *)&resp[0]);
+
+    nvme_vfio_dma_unmap(s->vfio, resp);
+    qemu_vfree(resp);
+    return true;
+fail:
+    qemu_vfree(resp);
+    return false;
+}
+
+static bool nvme_poll_queues(BDRVNVMeState *s)
+{
+    bool progress = false;
+    int i;
+
+    for (i = 0; i < s->nr_queues; i++) {
+        NVMeQueuePair *q = s->queues[i];
+        qemu_mutex_lock(&q->lock);
+        while (nvme_process_completion(s, q)) {
+            /* Keep polling */
+            progress = true;
+        }
+        qemu_mutex_unlock(&q->lock);
+    }
+    return progress;
+}
+
+static void nvme_handle_event(EventNotifier *n)
+{
+    BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
+
+    trace_nvme_handle_event(s);
+    aio_context_acquire(s->aio_context);
+    event_notifier_test_and_clear(n);
+    nvme_poll_queues(s);
+    aio_context_release(s->aio_context);
+}
+
+static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
+{
+    BDRVNVMeState *s = bs->opaque;
+    int n = s->nr_queues;
+    NVMeQueuePair *q;
+    NvmeCmd cmd;
+    int queue_size = NVME_QUEUE_SIZE;
+
+    q = nvme_create_queue_pair(bs, n, queue_size, errp);
+    if (!q) {
+        return false;
+    }
+    cmd = (NvmeCmd) {
+        .opcode = NVME_ADM_CMD_CREATE_CQ,
+        .prp1 = cpu_to_le64(q->cq.iova),
+        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
+        .cdw11 = cpu_to_le32(0x3),
+    };
+    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+        error_setg(errp, "Failed to create io queue [%d]", n);
+        nvme_free_queue_pair(bs, q);
+        return false;
+    }
+    cmd = (NvmeCmd) {
+        .opcode = NVME_ADM_CMD_CREATE_SQ,
+        .prp1 = cpu_to_le64(q->sq.iova),
+        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
+        .cdw11 = cpu_to_le32(0x1 | (n << 16)),
+    };
+    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+        error_setg(errp, "Failed to create io queue [%d]", n);
+        nvme_free_queue_pair(bs, q);
+        return false;
+    }
+    s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
+    s->queues[n] = q;
+    s->nr_queues++;
+    return true;
+}
+
+static bool nvme_poll_cb(void *opaque)
+{
+    EventNotifier *e = opaque;
+    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
+    bool progress = false;
+
+    aio_context_acquire(s->aio_context);
+    trace_nvme_poll_cb(s);
+    progress = nvme_poll_queues(s);
+    aio_context_release(s->aio_context);
+    return progress;
+}
+
+static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
+                     Error **errp)
+{
+    BDRVNVMeState *s = bs->opaque;
+    int ret;
+    uint64_t cap;
+    uint64_t timeout_ms;
+    uint64_t deadline, now;
+
+    qemu_co_mutex_init(&s->dma_map_lock);
+    qemu_co_queue_init(&s->dma_flush_queue);
+    s->nsid = namespace;
+    s->aio_context = qemu_get_current_aio_context();
+    ret = event_notifier_init(&s->irq_notifier, 0);
+    if (ret) {
+        error_setg(errp, "Failed to init event notifier");
+        return ret;
+    }
+
+    s->vfio = nvme_vfio_open_pci(device, errp);
+    if (!s->vfio) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    s->regs = nvme_vfio_pci_map_bar(s->vfio, 0, errp);
+    if (!s->regs) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    /* Perform initialize sequence as described in NVMe spec "7.6.1
+     * Initialization". */
+
+    cap = le64_to_cpu(s->regs->cap);
+    if (!(cap & (1ULL << 37))) {
+        error_setg(errp, "Device doesn't support NVMe command set");
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    s->page_size = MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
+    s->doorbell_scale = (4 << (((cap >> 32) & 0xF))) / sizeof(uint32_t);
+    bs->bl.opt_mem_alignment = s->page_size;
+    timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
+
+    /* Reset device to get a clean state. */
+    s->regs->cc = cpu_to_le32(le32_to_cpu(s->regs->cc) & 0xFE);
+    /* Wait for CSTS.RDY = 0. */
+    deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * 1000000ULL;
+    while (le32_to_cpu(s->regs->csts) & 0x1) {
+        if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
+            error_setg(errp, "Timeout while waiting for device to reset (%ld ms)",
+                       timeout_ms);
+            ret = -ETIMEDOUT;
+            goto fail;
+        }
+    }
+
+    /* Set up admin queue. */
+    s->queues = g_new(NVMeQueuePair *, 1);
+    s->nr_queues = 1;
+    s->queues[0] = nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, errp);
+    if (!s->queues[0]) {
+        ret = -EINVAL;
+        goto fail;
+    }
+    QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
+    s->regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
+    s->regs->asq = cpu_to_le64(s->queues[0]->sq.iova);
+    s->regs->acq = cpu_to_le64(s->queues[0]->cq.iova);
+
+    /* After setting up all control registers we can enable device now. */
+    s->regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
+                              (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
+                              0x1);
+    /* Wait for CSTS.RDY = 1. */
+    now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    deadline = now + timeout_ms * 1000000;
+    while (!(le32_to_cpu(s->regs->csts) & 0x1)) {
+        if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
+            error_setg(errp, "Timeout while waiting for device to start (%ld ms)",
+                       timeout_ms);
+            ret = -ETIMEDOUT;
+            goto fail_queue;
+        }
+    }
+
+    ret = nvme_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
+                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
+    if (ret) {
+        goto fail_queue;
+    }
+    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+                           false, nvme_handle_event, nvme_poll_cb);
+
+    if (!nvme_identify(bs, namespace, errp)) {
+        ret = -EIO;
+        goto fail_handler;
+    }
+
+    /* Set up command queues. */
+    if (!nvme_add_io_queue(bs, errp)) {
+        ret = -EIO;
+        goto fail_handler;
+    }
+    return 0;
+
+fail_handler:
+    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+                           false, NULL, NULL);
+fail_queue:
+    nvme_free_queue_pair(bs, s->queues[0]);
+fail:
+    nvme_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs);
+    nvme_vfio_close(s->vfio);
+    event_notifier_cleanup(&s->irq_notifier);
+    return ret;
+}
+
+/* Parse a filename in the format of nvme://XXXX:XX:XX.X/X. Example:
+ *
+ *     nvme://0000:44:00.0/1
+ *
+ * where the "nvme://" is a fixed form of the protocol prefix, the middle part
+ * is the PCI address, and the last part is the namespace number starting from
+ * 1 according to the NVMe spec. */
+static void nvme_parse_filename(const char *filename, QDict *options,
+                                Error **errp)
+{
+    int pref = strlen("nvme://");
+
+    if (strlen(filename) > pref && !strncmp(filename, "nvme://", pref)) {
+        const char *tmp = filename + pref;
+        char *device;
+        const char *namespace;
+        unsigned long ns;
+        const char *slash = strchr(tmp, '/');
+        if (!slash) {
+            qdict_put(options, NVME_BLOCK_OPT_DEVICE,
+                      qstring_from_str(tmp));
+            return;
+        }
+        device = g_strndup(tmp, slash - tmp);
+        qdict_put(options, NVME_BLOCK_OPT_DEVICE, qstring_from_str(device));
+        g_free(device);
+        namespace = slash + 1;
+        if (*namespace && qemu_strtoul(namespace, NULL, 10, &ns)) {
+            error_setg(errp, "Invalid namespace '%s', positive number expected",
+                       namespace);
+            return;
+        }
+        qdict_put(options, NVME_BLOCK_OPT_NAMESPACE,
+                  qstring_from_str(*namespace ? namespace : "1"));
+    }
+}
+
+static int nvme_file_open(BlockDriverState *bs, QDict *options, int flags,
+                          Error **errp)
+{
+    const char *device;
+    QemuOpts *opts;
+    int namespace;
+
+    opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options, &error_abort);
+    device = qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
+    if (!device) {
+        error_setg(errp, "'" NVME_BLOCK_OPT_DEVICE "' option is required");
+        return -EINVAL;
+    }
+
+    namespace = qemu_opt_get_number(opts, NVME_BLOCK_OPT_NAMESPACE, 1);
+    nvme_init(bs, device, namespace, errp);
+
+    qemu_opts_del(opts);
+    bs->supported_write_flags = BDRV_REQ_FUA;
+    return 0;
+}
+
+static void nvme_close(BlockDriverState *bs)
+{
+    int i;
+    BDRVNVMeState *s = bs->opaque;
+
+    for (i = 0; i < s->nr_queues; ++i) {
+        nvme_free_queue_pair(bs, s->queues[i]);
+    }
+    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+                           false, NULL, NULL);
+    nvme_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs);
+    nvme_vfio_close(s->vfio);
+}
+
+static int64_t nvme_getlength(BlockDriverState *bs)
+{
+    BDRVNVMeState *s = bs->opaque;
+
+    return s->nsze << BDRV_SECTOR_BITS;
+}
+
+static coroutine_fn int nvme_cmd_unmap_qiov(BlockDriverState *bs,
+                                            QEMUIOVector *qiov)
+{
+    int r = 0;
+    BDRVNVMeState *s = bs->opaque;
+
+    if (!s->inflight && !qemu_co_queue_empty(&s->dma_flush_queue)) {
+        r = nvme_vfio_dma_reset_temporary(s->vfio);
+        qemu_co_queue_restart_all(&s->dma_flush_queue);
+    }
+    return r;
+}
+
+static coroutine_fn int nvme_cmd_map_qiov(BlockDriverState *bs, NvmeCmd *cmd,
+                                          NVMeRequest *req, QEMUIOVector *qiov)
+{
+    BDRVNVMeState *s = bs->opaque;
+    uint64_t *pagelist = req->prp_list_page;
+    int i, j, r;
+    int entries = 0;
+
+    assert(qiov->size);
+    assert(QEMU_IS_ALIGNED(qiov->size, s->page_size));
+    assert(qiov->size / s->page_size <= s->page_size / sizeof(uint64_t));
+    for (i = 0; i < qiov->niov; ++i) {
+        bool retry = true;
+        uint64_t iova;
+        qemu_co_mutex_lock(&s->dma_map_lock);
+try_map:
+        r = nvme_vfio_dma_map(s->vfio,
+                              qiov->iov[i].iov_base,
+                              qiov->iov[i].iov_len,
+                              true, &iova);
+        if (r == -ENOMEM && retry) {
+            retry = false;
+            trace_nvme_dma_flush_queue_wait(s);
+            if (s->inflight) {
+                trace_nvme_dma_map_flush(s);
+                qemu_co_queue_wait(&s->dma_flush_queue, &s->dma_map_lock);
+            } else {
+                r = nvme_vfio_dma_reset_temporary(s->vfio);
+                if (r) {
+                    return r;
+                }
+            }
+            goto try_map;
+        }
+        qemu_co_mutex_unlock(&s->dma_map_lock);
+        if (r) {
+            return r;
+        }
+
+        for (j = 0; j < qiov->iov[i].iov_len / s->page_size; j++) {
+            pagelist[entries++] = iova + j * s->page_size;
+        }
+        trace_nvme_cmd_map_qiov_iov(s, i, qiov->iov[i].iov_base,
+                                    qiov->iov[i].iov_len / s->page_size);
+    }
+
+    assert(entries <= s->page_size / sizeof(uint64_t));
+    switch (entries) {
+    case 0:
+        abort();
+    case 1:
+        cmd->prp1 = cpu_to_le64(pagelist[0]);
+        cmd->prp2 = 0;
+        break;
+    case 2:
+        cmd->prp1 = cpu_to_le64(pagelist[0]);
+        cmd->prp2 = cpu_to_le64(pagelist[1]);;
+        break;
+    default:
+        cmd->prp1 = cpu_to_le64(pagelist[0]);
+        cmd->prp2 = cpu_to_le64(req->prp_list_iova);
+        for (i = 0; i < entries - 1; ++i) {
+            pagelist[i] = cpu_to_le64(pagelist[i + 1]);
+        }
+        pagelist[entries - 1] = 0;
+        break;
+    }
+    trace_nvme_cmd_map_qiov(s, cmd, req, qiov, entries);
+    for (i = 0; i < entries; ++i) {
+        trace_nvme_cmd_map_qiov_pages(s, i, pagelist[i]);
+    }
+    return 0;
+}
+
+typedef struct {
+    Coroutine *co;
+    int ret;
+    AioContext *ctx;
+} NVMeCoData;
+
+static void nvme_rw_cb_bh(void *opaque)
+{
+    NVMeCoData *data = opaque;
+    qemu_coroutine_enter(data->co);
+}
+
+static void nvme_rw_cb(void *opaque, int ret)
+{
+    NVMeCoData *data = opaque;
+    data->ret = ret;
+    if (!data->co) {
+        /* The rw coroutine hasn't yielded, don't try to enter. */
+        return;
+    }
+    aio_bh_schedule_oneshot(data->ctx, nvme_rw_cb_bh, data);
+}
+
+static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
+                                            uint64_t offset, uint64_t bytes,
+                                            QEMUIOVector *qiov,
+                                            bool is_write,
+                                            int flags)
+{
+    int r;
+    BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *ioq = s->queues[1];
+    NVMeRequest *req;
+    uint32_t cdw12 = (((bytes >> BDRV_SECTOR_BITS) - 1) & 0xFFFF) |
+                       (flags & BDRV_REQ_FUA ? 1 << 30 : 0);
+    NvmeCmd cmd = {
+        .opcode = is_write ? NVME_CMD_WRITE : NVME_CMD_READ,
+        .nsid = cpu_to_le32(s->nsid),
+        .cdw10 = cpu_to_le32((offset >> BDRV_SECTOR_BITS) & 0xFFFFFFFF),
+        .cdw11 = cpu_to_le32(((offset >> BDRV_SECTOR_BITS) >> 32) & 0xFFFFFFFF),
+        .cdw12 = cpu_to_le32(cdw12),
+    };
+    NVMeCoData data = {
+        .ctx = bdrv_get_aio_context(bs),
+        .ret = -EINPROGRESS,
+    };
+
+    trace_nvme_prw_aligned(s, is_write, offset, bytes, flags, qiov->niov);
+    assert(s->nr_queues > 1);
+    req = nvme_get_free_req(ioq);
+
+    r = nvme_cmd_map_qiov(bs, &cmd, req, qiov);
+    if (r) {
+        req->busy = false;
+        return r;
+    }
+    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+
+    r = nvme_cmd_unmap_qiov(bs, qiov);
+    if (r) {
+        return r;
+    }
+
+    trace_nvme_rw_done(s, is_write, offset, bytes, data.ret);
+    return data.ret;
+}
+
+static inline bool nvme_qiov_aligned(BlockDriverState *bs,
+                                     const QEMUIOVector *qiov)
+{
+    int i;
+    BDRVNVMeState *s = bs->opaque;
+
+    for (i = 0; i < qiov->niov; ++i) {
+        if (!QEMU_PTR_IS_ALIGNED(qiov->iov[i].iov_base, s->page_size) ||
+            !QEMU_IS_ALIGNED(qiov->iov[i].iov_len, s->page_size)) {
+            trace_nvme_qiov_unaligned(qiov, i, qiov->iov[i].iov_base,
+                                      qiov->iov[i].iov_len, s->page_size);
+            return false;
+        }
+    }
+    return true;
+}
+
+static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                       QEMUIOVector *qiov, bool is_write, int flags)
+{
+    BDRVNVMeState *s = bs->opaque;
+    int r;
+    uint8_t *buf = NULL;
+    QEMUIOVector local_qiov;
+
+    assert(QEMU_IS_ALIGNED(offset, s->page_size));
+    assert(QEMU_IS_ALIGNED(bytes, s->page_size));
+    assert(bytes <= s->max_transfer);
+    if (nvme_qiov_aligned(bs, qiov)) {
+        return nvme_co_prw_aligned(bs, offset, bytes, qiov, is_write, flags);
+    }
+    trace_nvme_prw_buffered(s, offset, bytes, qiov->niov, is_write);
+    buf = qemu_try_blockalign(bs, bytes);
+
+    if (!buf) {
+        return -ENOMEM;
+    }
+    qemu_iovec_init(&local_qiov, 1);
+    if (is_write) {
+        qemu_iovec_to_buf(qiov, 0, buf, bytes);
+    }
+    qemu_iovec_add(&local_qiov, buf, bytes);
+    r = nvme_co_prw_aligned(bs, offset, bytes, &local_qiov, is_write, flags);
+    qemu_iovec_destroy(&local_qiov);
+    if (!r && !is_write) {
+        qemu_iovec_from_buf(qiov, 0, buf, bytes);
+    }
+    qemu_vfree(buf);
+    return r;
+}
+
+static coroutine_fn int nvme_co_preadv(BlockDriverState *bs,
+                                       uint64_t offset, uint64_t bytes,
+                                       QEMUIOVector *qiov, int flags)
+{
+    return nvme_co_prw(bs, offset, bytes, qiov, false, flags);
+}
+
+static coroutine_fn int nvme_co_pwritev(BlockDriverState *bs,
+                                        uint64_t offset, uint64_t bytes,
+                                        QEMUIOVector *qiov, int flags)
+{
+    return nvme_co_prw(bs, offset, bytes, qiov, true, flags);
+}
+
+static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
+{
+    BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *ioq = s->queues[1];
+    NVMeRequest *req;
+    NvmeCmd cmd = {
+        .opcode = NVME_CMD_FLUSH,
+        .nsid = cpu_to_le32(s->nsid),
+    };
+    NVMeCoData data = {
+        .ctx = bdrv_get_aio_context(bs),
+        .ret = -EINPROGRESS,
+    };
+
+    assert(s->nr_queues > 1);
+    req = nvme_get_free_req(ioq);
+    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
+
+    data.co = qemu_coroutine_self();
+    if (data.ret == -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+
+    return data.ret;
+}
+
+
+static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
+                               BlockReopenQueue *queue, Error **errp)
+{
+    return 0;
+}
+
+static int64_t coroutine_fn nvme_co_get_block_status(BlockDriverState *bs,
+                                                     int64_t sector_num,
+                                                     int nb_sectors, int *pnum,
+                                                     BlockDriverState **file)
+{
+    *pnum = nb_sectors;
+    *file = bs;
+
+    return BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID |
+           (sector_num << BDRV_SECTOR_BITS);
+}
+
+static void nvme_refresh_filename(BlockDriverState *bs, QDict *opts)
+{
+    QINCREF(opts);
+    qdict_del(opts, "filename");
+
+    if (!qdict_size(opts)) {
+        snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
+                 bs->drv->format_name);
+    }
+
+    qdict_put(opts, "driver", qstring_from_str(bs->drv->format_name));
+    bs->full_open_options = opts;
+}
+
+static void nvme_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    BDRVNVMeState *s = bs->opaque;
+
+    bs->bl.opt_mem_alignment = s->page_size;
+    bs->bl.request_alignment = s->page_size;
+    bs->bl.max_transfer = s->max_transfer;
+}
+
+static void nvme_detach_aio_context(BlockDriverState *bs)
+{
+    BDRVNVMeState *s = bs->opaque;
+
+    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+                           false, NULL, NULL);
+}
+
+static void nvme_attach_aio_context(BlockDriverState *bs,
+                                    AioContext *new_context)
+{
+    BDRVNVMeState *s = bs->opaque;
+
+    s->aio_context = new_context;
+    aio_set_event_notifier(new_context, &s->irq_notifier,
+                           false, nvme_handle_event, nvme_poll_cb);
+}
+
+static void nvme_aio_plug(BlockDriverState *bs)
+{
+    BDRVNVMeState *s = bs->opaque;
+    s->plugged++;
+}
+
+static void nvme_aio_unplug(BlockDriverState *bs)
+{
+    int i;
+    BDRVNVMeState *s = bs->opaque;
+    assert(s->plugged);
+    if (!--s->plugged) {
+        for (i = 1; i < s->nr_queues; i++) {
+            NVMeQueuePair *q = s->queues[i];
+            qemu_mutex_lock(&q->lock);
+            nvme_kick(s, q);
+            nvme_process_completion(s, q);
+            qemu_mutex_unlock(&q->lock);
+        }
+    }
+}
+
+static BlockDriver bdrv_nvme = {
+    .format_name              = "nvme",
+    .protocol_name            = "nvme",
+    .instance_size            = sizeof(BDRVNVMeState),
+
+    .bdrv_parse_filename      = nvme_parse_filename,
+    .bdrv_file_open           = nvme_file_open,
+    .bdrv_close               = nvme_close,
+    .bdrv_getlength           = nvme_getlength,
+
+    .bdrv_co_preadv           = nvme_co_preadv,
+    .bdrv_co_pwritev          = nvme_co_pwritev,
+    .bdrv_co_flush_to_disk    = nvme_co_flush,
+    .bdrv_reopen_prepare      = nvme_reopen_prepare,
+
+    .bdrv_co_get_block_status = nvme_co_get_block_status,
+
+    .bdrv_refresh_filename    = nvme_refresh_filename,
+    .bdrv_refresh_limits      = nvme_refresh_limits,
+
+    .bdrv_detach_aio_context  = nvme_detach_aio_context,
+    .bdrv_attach_aio_context  = nvme_attach_aio_context,
+
+    .bdrv_io_plug             = nvme_aio_plug,
+    .bdrv_io_unplug           = nvme_aio_unplug,
+};
+
+static void bdrv_nvme_init(void)
+{
+    bdrv_register(&bdrv_nvme);
+}
+
+block_init(bdrv_nvme_init);
diff --git a/block/trace-events b/block/trace-events
index 752de6a..3637d00 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -124,3 +124,35 @@ vxhs_open_iio_open(const char *host) "Failed to connect to storage agent on host
 vxhs_parse_uri_hostinfo(char *host, int port) "Host: IP %s, Port %d"
 vxhs_close(char *vdisk_guid) "Closing vdisk %s"
 vxhs_get_creds(const char *cacert, const char *client_key, const char *client_cert) "cacert %s, client_key %s, client_cert %s"
+
+# block/nvme.c
+nvme_kick(void *s, int queue) "s %p queue %d"
+nvme_dma_flush_queue_wait(void *s) "s %p"
+nvme_vfio_ram_block_removed(void *s, size_t size) "host %p size %zu"
+nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status %x"
+nvme_process_completion(void *s, int index, int inflight) "s %p queue %d inflight %d"
+nvme_process_completion_queue_busy(void *s, int index) "s %p queue %d"
+nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
+nvme_submit_command(void *s, int index, int cid) "s %p queue %d cid %d"
+nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6, int c7) "%02x %02x %02x %02x %02x %02x %02x %02x"
+nvme_handle_event(void *s) "s %p"
+nvme_poll_cb(void *s) "s %p"
+nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset %"PRId64" bytes %"PRId64" flags %d niov %d"
+nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
+nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
+nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
+nvme_dma_map_flush(void *s) "s %p"
+nvme_free_req_queue_wait(void *q) "q %p"
+nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
+nvme_cmd_map_qiov_pages(void *s, int i, uint64_t page) "s %p page[%d] %"PRIx64
+nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pages %d"
+
+# block/nvme-vfio.c
+nvme_vfio_dma_reset_temporary(void *s) "s %p"
+nvme_vfio_ram_block_added(void *p, size_t size) "host %p size %zu"
+nvme_vfio_find_mapping(void *s, void *p) "s %p host %p"
+nvme_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova) "s %p host %p size %zu index %d iova %"PRIx64
+nvme_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size %zu iova %"PRIx64
+nvme_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size %zu temporary %d iova %p"
+nvme_vfio_dma_map_invalid(void *s, void *mapping_host, size_t mapping_size, void *host, size_t size) "s %p mapping %p %zu requested %p %zu"
+nvme_vfio_dma_unmap(void *s, void *host) "s %p host %p"
-- 
2.9.4
