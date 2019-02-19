Received: from eggs.gnu.org ([209.51.188.92]:33539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwCyb-0006K4-F9
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwCyZ-0005lQ-89
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:53 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gwCyX-0005kx-Nj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:51 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Wed, 20 Feb 2019 02:53:18 +0530
Message-ID: <1550611400-13703-4-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/5] Add migration functions for VFIO devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>

- Migration function are implemented for VFIO_DEVICE_TYPE_PCI device.
- Added SaveVMHandlers and implemented all basic functions required for live
  migration.
- Added VM state change handler to know running or stopped state of VM.
- Added migration state change notifier to get notification on migration state
  change. This state is translated to VFIO device state and conveyed to vendor
  driver.
- VFIO device supports migration or not is decided based of migration region
  query. If migration region query is successful then migration is supported
  else migration is blocked.
- Structure vfio_device_migration_info is mapped at 0th offset of migration
  region and should always trapped by VFIO device's driver. Added both type of
  access support, trapped or mmapped, for data section of the region.
- To save device state, read pending_bytes and data_offset using structure
  vfio_device_migration_info, accordingly copy data from the region.
- To restore device state, write data_offset and data_size in the structure
  and write data in the region.
- To get dirty page bitmap, write start address and pfn count then read count of
  pfns copied and accordingly read those from the rest of the region or mmaped
  part of the region. This copy is iterated till page bitmap for all requested
  pfns are copied.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/Makefile.objs         |   2 +-
 hw/vfio/migration.c           | 714 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  20 ++
 3 files changed, 735 insertions(+), 1 deletion(-)
 create mode 100644 hw/vfio/migration.c

diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index abad8b818c9b..36033d1437c5 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += common.o spapr.o
+obj-y += common.o spapr.o migration.o
 obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
 obj-$(CONFIG_VFIO_CCW) += ccw.o
 obj-$(CONFIG_VFIO_PLATFORM) += platform.o
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
new file mode 100644
index 000000000000..d7b6d972c043
--- /dev/null
+++ b/hw/vfio/migration.c
@@ -0,0 +1,714 @@
+/*
+ * Migration support for VFIO devices
+ *
+ * Copyright NVIDIA, Inc. 2018
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "cpu.h"
+#include "migration/migration.h"
+#include "migration/qemu-file.h"
+#include "migration/register.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
+#include "qapi/error.h"
+#include "exec/ramlist.h"
+#include "exec/ram_addr.h"
+#include "pci.h"
+
+/*
+ * Flags used as delimiter:
+ * 0xffffffff => MSB 32-bit all 1s
+ * 0xef10     => emulated (virtual) function IO
+ * 0x0000     => 16-bits reserved for flags
+ */
+#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
+#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
+#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
+#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
+
+static void vfio_migration_region_exit(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (!migration) {
+        return;
+    }
+
+    if (migration->region.buffer.size) {
+        vfio_region_exit(&migration->region.buffer);
+        vfio_region_finalize(&migration->region.buffer);
+    }
+}
+
+static int vfio_migration_region_init(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    Object *obj = NULL;
+    int ret = -EINVAL;
+
+    if (!migration) {
+        return ret;
+    }
+
+    /* Migration support added for PCI device only */
+    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        obj = vfio_pci_get_object(vbasedev);
+    }
+
+    if (!obj) {
+        return ret;
+    }
+
+    ret = vfio_region_setup(obj, vbasedev, &migration->region.buffer,
+                            migration->region.index, "migration");
+    if (ret) {
+        error_report("Failed to setup VFIO migration region %d: %s",
+                      migration->region.index, strerror(-ret));
+        goto err;
+    }
+
+    if (!migration->region.buffer.size) {
+        ret = -EINVAL;
+        error_report("Invalid region size of VFIO migration region %d: %s",
+                     migration->region.index, strerror(-ret));
+        goto err;
+    }
+
+    if (migration->region.buffer.mmaps) {
+        ret = vfio_region_mmap(&migration->region.buffer);
+        if (ret) {
+            error_report("Failed to mmap VFIO migration region %d: %s",
+                         migration->region.index, strerror(-ret));
+            goto err;
+        }
+    }
+
+    return 0;
+
+err:
+    vfio_migration_region_exit(vbasedev);
+    return ret;
+}
+
+static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    int ret = 0;
+
+    ret = pwrite(vbasedev->fd, &state, sizeof(state),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              device_state));
+    if (ret < 0) {
+        error_report("Failed to set migration state %d %s",
+                     ret, strerror(errno));
+        return ret;
+    }
+
+    vbasedev->device_state = state;
+    return 0;
+}
+
+void vfio_get_dirty_page_list(VFIODevice *vbasedev,
+                              uint64_t start_pfn,
+                              uint64_t pfn_count,
+                              uint64_t page_size)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    uint64_t count = 0, copied_pfns = 0;
+    int ret;
+
+    ret = pwrite(vbasedev->fd, &start_pfn, sizeof(start_pfn),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              start_pfn));
+    if (ret < 0) {
+        error_report("Failed to set dirty pages start address %d %s",
+                ret, strerror(errno));
+        return;
+    }
+
+    ret = pwrite(vbasedev->fd, &page_size, sizeof(page_size),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              page_size));
+    if (ret < 0) {
+        error_report("Failed to set dirty page size %d %s",
+                ret, strerror(errno));
+        return;
+    }
+
+    ret = pwrite(vbasedev->fd, &pfn_count, sizeof(pfn_count),
+                 region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                              total_pfns));
+    if (ret < 0) {
+        error_report("Failed to set dirty page total pfns %d %s",
+                ret, strerror(errno));
+        return;
+    }
+
+    do {
+        uint64_t bitmap_size;
+        void *buf = NULL;
+        bool buffer_mmaped = false;
+
+        /* Read dirty_pfns.copied */
+        ret = pread(vbasedev->fd, &copied_pfns, sizeof(copied_pfns),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             copied_pfns));
+        if (ret < 0) {
+            error_report("Failed to get dirty pages bitmap count %d %s",
+                    ret, strerror(errno));
+            return;
+        }
+
+        if (copied_pfns == 0) {
+            /*
+             * copied_pfns could be 0 if driver doesn't have any page to report
+             * dirty in given range
+             */
+            break;
+        }
+
+        bitmap_size = (BITS_TO_LONGS(copied_pfns) + 1) * sizeof(unsigned long);
+
+        if (region->mmaps) {
+            int i;
+
+            for (i = 0; i < region->nr_mmaps; i++) {
+                if (region->mmaps[i].size >= bitmap_size) {
+                    buf = region->mmaps[i].mmap;
+                    buffer_mmaped = true;
+                    break;
+                }
+            }
+        }
+
+        if (!buffer_mmaped) {
+            buf = g_malloc0(bitmap_size);
+
+            ret = pread(vbasedev->fd, buf, bitmap_size,
+                        region->fd_offset +
+                        sizeof(struct vfio_device_migration_info) + 1);
+            if (ret != bitmap_size) {
+                error_report("Failed to get dirty pages bitmap %d", ret);
+                g_free(buf);
+                return;
+            }
+        }
+
+        cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
+                                               (start_pfn + count) * page_size,
+                                                copied_pfns);
+        count +=  copied_pfns;
+
+        if (!buffer_mmaped) {
+            g_free(buf);
+        }
+    } while (count < pfn_count);
+}
+
+static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
+
+    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        vfio_pci_save_config(vbasedev, f);
+    }
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    return qemu_file_get_error(f);
+}
+
+static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+
+    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        vfio_pci_load_config(vbasedev, f);
+    }
+
+    if (qemu_get_be64(f) != VFIO_MIG_FLAG_END_OF_STATE) {
+        error_report("Wrong end of block while loading device config space");
+        return -EINVAL;
+    }
+
+    return qemu_file_get_error(f);
+}
+
+/* ---------------------------------------------------------------------- */
+
+static int vfio_save_setup(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    int ret;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
+
+    if (vbasedev->vm_running) {
+        ret = vfio_migration_set_state(vbasedev,
+                         VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
+        if (ret) {
+            error_report("Failed to set state RUNNING and SAVING");
+        }
+    } else {
+        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
+        if (ret) {
+            error_report("Failed to set state STOP and SAVING");
+        }
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
+static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    uint64_t data_offset = 0, data_size = 0;
+    int ret;
+
+    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             data_offset));
+    if (ret != sizeof(data_offset)) {
+        error_report("Failed to get migration buffer data offset %d",
+                     ret);
+        return -EINVAL;
+    }
+
+    if (migration->pending_bytes) {
+        void *buf = NULL;
+        bool buffer_mmaped = false;
+
+        if (region->mmaps) {
+            int i;
+
+            for (i = 0; i < region->nr_mmaps; i++) {
+                if ((data_offset >= region->mmaps[i].offset) &&
+                    (data_offset < region->mmaps[i].offset +
+                                   region->mmaps[i].size)) {
+                    uint64_t region_data_size = region->mmaps[i].size -
+                                        (data_offset - region->mmaps[i].offset);
+
+                    buf = region->mmaps[i].mmap;
+                    buffer_mmaped = true;
+
+                    if (migration->pending_bytes > region_data_size) {
+                        data_size = region_data_size;
+                    } else {
+                        data_size = migration->pending_bytes;
+                    }
+                    break;
+                }
+            }
+        }
+
+        if (!buffer_mmaped) {
+            uint64_t region_data_size = region->size - data_offset;
+
+            if (migration->pending_bytes > region_data_size) {
+                data_size = region_data_size;
+            } else {
+                data_size = migration->pending_bytes;
+            }
+
+            buf = g_malloc0(data_size);
+            ret = pread(vbasedev->fd, buf, data_size,
+                        region->fd_offset + data_offset);
+            if (ret != data_size) {
+                error_report("Failed to get migration data %d", ret);
+                return -EINVAL;
+            }
+        }
+
+        qemu_put_be64(f, data_size);
+        qemu_put_buffer(f, buf, data_size);
+
+        if (!buffer_mmaped) {
+            g_free(buf);
+        }
+        migration->pending_bytes -= data_size;
+    } else {
+        qemu_put_be64(f, migration->pending_bytes);
+    }
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    return data_size;
+}
+
+static int vfio_save_iterate(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    int ret;
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
+
+    ret = vfio_save_buffer(f, vbasedev);
+    if (ret < 0) {
+        error_report("vfio_save_buffer failed %s",
+                     strerror(errno));
+        return ret;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    return ret;
+}
+
+static int vfio_update_pending(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIORegion *region = &migration->region.buffer;
+    uint64_t pending_bytes = 0;
+    int ret;
+
+    ret = pread(vbasedev->fd, &pending_bytes, sizeof(pending_bytes),
+                region->fd_offset + offsetof(struct vfio_device_migration_info,
+                                             pending_bytes));
+    if ((ret < 0) || (ret != sizeof(pending_bytes))) {
+        error_report("Failed to get pending bytes %d", ret);
+        migration->pending_bytes = 0;
+        return (ret < 0) ? ret : -EINVAL;
+    }
+
+    migration->pending_bytes = pending_bytes;
+    return 0;
+}
+
+static void vfio_save_pending(QEMUFile *f, void *opaque,
+                              uint64_t threshold_size,
+                              uint64_t *res_precopy_only,
+                              uint64_t *res_compatible,
+                              uint64_t *res_postcopy_only)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    ret = vfio_update_pending(vbasedev);
+    if (ret) {
+        return;
+    }
+
+    if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
+        *res_precopy_only += migration->pending_bytes;
+    } else {
+        *res_postcopy_only += migration->pending_bytes;
+    }
+    *res_compatible += 0;
+}
+
+static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
+    if (ret) {
+        error_report("Failed to set state STOP and SAVING");
+        return ret;
+    }
+
+    ret = vfio_save_device_config_state(f, opaque);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vfio_update_pending(vbasedev);
+    if (ret) {
+        return ret;
+    }
+
+    while (migration->pending_bytes > 0) {
+        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
+        ret = vfio_save_buffer(f, vbasedev);
+        if (ret < 0) {
+            error_report("Failed to save buffer");
+            return ret;
+        } else if (ret == 0) {
+            break;
+        }
+
+        if (migration->pending_bytes == 0) {
+            ret = vfio_update_pending(vbasedev);
+            if (ret) {
+                return ret;
+            }
+        }
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    ret = qemu_file_get_error(f);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vfio_migration_set_state(vbasedev, 0);
+    if (ret) {
+        error_report("Failed to set state STOPPED");
+        return ret;
+    }
+    return ret;
+}
+
+static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
+{
+    VFIODevice *vbasedev = opaque;
+    int ret;
+    uint64_t data, data_size;
+
+    ret = vfio_migration_set_state(vbasedev, 0);
+    if (ret) {
+        error_report("Failed to set state RESUMING");
+        return ret;
+    }
+
+    data = qemu_get_be64(f);
+    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
+        if (data == VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
+            ret = vfio_load_device_config_state(f, opaque);
+            if (ret) {
+                return ret;
+            }
+        } else if (data == VFIO_MIG_FLAG_DEV_SETUP_STATE) {
+            data = qemu_get_be64(f);
+            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
+                return 0;
+            } else {
+                error_report("SETUP STATE: EOS not found 0x%lx", data);
+                return -EINVAL;
+            }
+        } else if (data == VFIO_MIG_FLAG_DEV_DATA_STATE) {
+            VFIOMigration *migration = vbasedev->migration;
+            VFIORegion *region = &migration->region.buffer;
+            void *buf = NULL;
+            bool buffer_mmaped = false;
+            uint64_t data_offset = 0;
+
+            data_size = qemu_get_be64(f);
+            if (data_size != 0) {
+                if (region->mmaps) {
+                    int i;
+
+                    for (i = 0; i < region->nr_mmaps; i++) {
+                        if (region->mmaps[i].mmap &&
+                            (region->mmaps[i].size >= data_size)) {
+                            buf = region->mmaps[i].mmap;
+                            data_offset = region->mmaps[i].offset;
+                            buffer_mmaped = true;
+                            break;
+                        }
+                    }
+                }
+
+                if (!buffer_mmaped) {
+                    buf = g_malloc0(data_size);
+                    data_offset = sizeof(struct vfio_device_migration_info) + 1;
+                }
+
+                qemu_get_buffer(f, buf, data_size);
+
+                ret = pwrite(vbasedev->fd, &data_offset, sizeof(data_offset),
+                             region->fd_offset +
+                      offsetof(struct vfio_device_migration_info, data_offset));
+                if (ret != sizeof(data_offset)) {
+                    error_report("Failed to set migration data offset %d",
+                                  ret);
+                    return -EINVAL;
+                }
+
+                ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
+                             region->fd_offset +
+                        offsetof(struct vfio_device_migration_info, data_size));
+                if (ret != sizeof(data_size)) {
+                    error_report("Failed to set migration buffer data size %d",
+                                 ret);
+                    return -EINVAL;
+                }
+
+                if (!buffer_mmaped) {
+                    ret = pwrite(vbasedev->fd, buf, data_size,
+                                 region->fd_offset + data_offset);
+                    g_free(buf);
+
+                    if (ret != data_size) {
+                        error_report("Failed to set migration buffer %d", ret);
+                        return -EINVAL;
+                    }
+                }
+            }
+        }
+
+        ret = qemu_file_get_error(f);
+        if (ret) {
+            return ret;
+        }
+        data = qemu_get_be64(f);
+    }
+
+    return 0;
+}
+
+static SaveVMHandlers savevm_vfio_handlers = {
+    .save_setup = vfio_save_setup,
+    .save_live_pending = vfio_save_pending,
+    .save_live_iterate = vfio_save_iterate,
+    .save_live_complete_precopy = vfio_save_complete_precopy,
+    .load_state = vfio_load_state,
+};
+
+static void vfio_vmstate_change(void *opaque, int running, RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+
+    if ((vbasedev->vm_running != running) && running) {
+        int ret;
+
+        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
+        if (ret) {
+            error_report("Failed to set state RUNNING");
+        }
+    }
+
+    vbasedev->vm_running = running;
+}
+
+static void vfio_migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s = data;
+    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
+    int ret;
+
+    switch (s->state) {
+    case MIGRATION_STATUS_ACTIVE:
+        if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
+            if (vbasedev->vm_running) {
+                ret = vfio_migration_set_state(vbasedev,
+                          VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
+                if (ret) {
+                    error_report("Failed to set state RUNNING and SAVING");
+                }
+            } else {
+                ret = vfio_migration_set_state(vbasedev,
+                                               VFIO_DEVICE_STATE_SAVING);
+                if (ret) {
+                    error_report("Failed to set state STOP and SAVING");
+                }
+            }
+        } else {
+            ret = vfio_migration_set_state(vbasedev, 0);
+            if (ret) {
+                error_report("Failed to set state RESUMING");
+            }
+        }
+        return;
+
+    case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_FAILED:
+        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
+        if (ret) {
+            error_report("Failed to set state RUNNING");
+        }
+        return;
+    }
+}
+
+static int vfio_migration_init(VFIODevice *vbasedev,
+                               struct vfio_region_info *info)
+{
+    int ret;
+
+    vbasedev->migration = g_new0(VFIOMigration, 1);
+    vbasedev->migration->region.index = info->index;
+
+    ret = vfio_migration_region_init(vbasedev);
+    if (ret) {
+        error_report("Failed to initialise migration region");
+        return ret;
+    }
+
+    register_savevm_live(NULL, "vfio", -1, 1, &savevm_vfio_handlers, vbasedev);
+    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
+                                                          vbasedev);
+
+    vbasedev->migration_state.notify = vfio_migration_state_notifier;
+    add_migration_state_change_notifier(&vbasedev->migration_state);
+
+    return 0;
+}
+
+
+/* ---------------------------------------------------------------------- */
+
+int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_region_info *info;
+    int ret;
+
+    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
+                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
+    if (ret) {
+        Error *local_err = NULL;
+
+        error_setg(&vbasedev->migration_blocker,
+                   "VFIO device doesn't support migration");
+        ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_free(vbasedev->migration_blocker);
+            return ret;
+        }
+    } else {
+        return vfio_migration_init(vbasedev, info);
+    }
+
+    return 0;
+}
+
+void vfio_migration_finalize(VFIODevice *vbasedev)
+{
+    if (!vbasedev->migration) {
+        return;
+    }
+
+    if (vbasedev->vm_state) {
+        qemu_del_vm_change_state_handler(vbasedev->vm_state);
+        remove_migration_state_change_notifier(&vbasedev->migration_state);
+    }
+
+    if (vbasedev->migration_blocker) {
+        migrate_del_blocker(vbasedev->migration_blocker);
+        error_free(vbasedev->migration_blocker);
+    }
+
+    vfio_migration_region_exit(vbasedev);
+    g_free(vbasedev->migration);
+}
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7624c9f511c4..3b8c98b29baf 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -30,6 +30,7 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
+#include "sysemu/sysemu.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -58,6 +59,14 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
+typedef struct VFIOMigration {
+    struct {
+        VFIORegion buffer;
+        uint32_t index;
+    } region;
+    uint64_t pending_bytes;
+} VFIOMigration;
+
 typedef struct VFIOAddressSpace {
     AddressSpace *as;
     QLIST_HEAD(, VFIOContainer) containers;
@@ -119,6 +128,12 @@ typedef struct VFIODevice {
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
+    uint32_t device_state;
+    VMChangeStateEntry *vm_state;
+    int vm_running;
+    Notifier migration_state;
+    VFIOMigration *migration;
+    Error *migration_blocker;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -198,4 +213,9 @@ int vfio_spapr_create_window(VFIOContainer *container,
 int vfio_spapr_remove_window(VFIOContainer *container,
                              hwaddr offset_within_address_space);
 
+int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
+void vfio_migration_finalize(VFIODevice *vbasedev);
+void vfio_get_dirty_page_list(VFIODevice *vbasedev, uint64_t start_pfn,
+                               uint64_t pfn_count, uint64_t page_size);
+
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.7.0
