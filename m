Received: from eggs.gnu.org ([2001:4830:134:3::10]:53661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPvFO-0005UF-8Q
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPv6s-0001Ji-Qi
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 14:58:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPv6s-0001GS-FJ
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 14:57:58 -0500
Date: Thu, 22 Nov 2018 19:57:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181122195748.GF2605@work-vm>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
	<1542746383-18288-4-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542746383-18288-4-git-send-email-kwankhede@nvidia.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] Add migration functions for VFIO
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, qemu-devel@nongnu.org

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> - Migration function are implemented for VFIO_DEVICE_TYPE_PCI device.
> - Added SaveVMHandlers and implemented all basic functions required for live
>   migration.
> - Added VM state change handler to know running or stopped state of VM.
> - Added migration state change notifier to get notification on migration state
>   change. This state is translated to VFIO device state and conveyed to vendor
>   driver.
> - VFIO device supportd migration or not is decided based of migration region
>   query. If migration region query is successful then migration is supported
>   else migration is blocked.
> - Structure vfio_device_migration_info is mapped at 0th offset of migration
>   region and should always trapped by VFIO device's driver. Added both type of
>   access support, trapped or mmapped, for data section of the region.
> - To save device state, read data offset and size using structure
>   vfio_device_migration_info.data, accordingly copy data from the region.
> - To restore device state, write data offset and size in the structure and write
>   data in the region.
> - To get dirty page bitmap, write start address and pfn count then read count of
>   pfns copied and accordingly read those from the rest of the region or mmaped
>   part of the region. This copy is iterated till page bitmap for all requested
>   pfns are copied.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>

This does need something for device/data versioning.
Please consider adding some 'trace' calls to make it easier to
debug in situ.
Splitting the patch a bit more would also help; see some more comments
below.


> ---
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/migration.c           | 729 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |  23 ++
>  3 files changed, 753 insertions(+), 1 deletion(-)
>  create mode 100644 hw/vfio/migration.c
> 
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index a2e7a0a7cf02..2cf2ba1440f2 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,5 +1,5 @@
>  ifeq ($(CONFIG_LINUX), y)
> -obj-$(CONFIG_SOFTMMU) += common.o
> +obj-$(CONFIG_SOFTMMU) += common.o migration.o
>  obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
>  obj-$(CONFIG_VFIO_CCW) += ccw.o
>  obj-$(CONFIG_SOFTMMU) += platform.o
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> new file mode 100644
> index 000000000000..717fb63e4f43
> --- /dev/null
> +++ b/hw/vfio/migration.c
> @@ -0,0 +1,729 @@
> +/*
> + * Migration support for VFIO devices
> + *
> + * Copyright NVIDIA, Inc. 2018
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vfio.h>
> +
> +#include "hw/vfio/vfio-common.h"
> +#include "cpu.h"
> +#include "migration/migration.h"
> +#include "migration/qemu-file.h"
> +#include "migration/register.h"
> +#include "migration/blocker.h"
> +#include "migration/misc.h"
> +#include "qapi/error.h"
> +#include "exec/ramlist.h"
> +#include "exec/ram_addr.h"
> +#include "pci.h"
> +
> +/*
> + * Flags used as delimiter:
> + * 0xffffffff => MSB 32-bit all 1s
> + * 0xef10     => emulated (virtual) function IO
> + * 0x0000     => 16-bits reserved for flags
> + */
> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> +
> +static void vfio_migration_region_exit(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (!migration) {
> +        return;
> +    }
> +
> +    if (migration->region.buffer.size) {
> +        vfio_region_exit(&migration->region.buffer);
> +        vfio_region_finalize(&migration->region.buffer);
> +    }
> +}
> +
> +static int vfio_migration_region_init(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    Object *obj = NULL;
> +    int ret = -EINVAL;
> +
> +    if (!migration) {
> +        return ret;

Here and ...
> +    }
> +
> +    /* Migration support added for PCI device only */
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        obj = vfio_pci_get_object(vbasedev);
> +    }
> +
> +    if (!obj) {
> +        return ret;

Here, you've failed the migration but not printed an error to say why;
please print something so we cna tell what happened.

> +    }
> +
> +    ret = vfio_region_setup(obj, vbasedev, &migration->region.buffer,
> +                            migration->region.index, "migration");
> +    if (ret) {
> +        error_report("Failed to setup VFIO migration region %d: %s",
> +                      migration->region.index, strerror(-ret));
> +        goto err;
> +    }
> +
> +    if (!migration->region.buffer.size) {
> +        ret = -EINVAL;
> +        error_report("Invalid region size of VFIO migration region %d: %s",
> +                     migration->region.index, strerror(-ret));
> +        goto err;
> +    }
> +
> +    if (migration->region.buffer.mmaps) {
> +        ret = vfio_region_mmap(&migration->region.buffer);
> +        if (ret) {
> +            error_report("Failed to mmap VFIO migration region %d: %s",
> +                         migration->region.index, strerror(-ret));
> +            goto err;
> +        }
> +    }
> +
> +    return 0;
> +
> +err:
> +    vfio_migration_region_exit(vbasedev);
> +    return ret;
> +}
> +
> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region.buffer;
> +    int ret = 0;
> +
> +    if (vbasedev->device_state == state) {
> +        return ret;
> +    }
> +
> +    ret = pwrite(vbasedev->fd, &state, sizeof(state),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              device_state));
> +    if (ret < 0) {
> +        error_report("Failed to set migration state %d %s",
> +                     ret, strerror(errno));
> +        return ret;
> +    }
> +
> +    vbasedev->device_state = state;
> +    return ret;
> +}
> +
> +void vfio_get_dirty_page_list(VFIODevice *vbasedev,
> +                              uint64_t start_addr,
> +                              uint64_t pfn_count)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region.buffer;
> +    struct vfio_device_migration_info migration_info;
> +    uint64_t count = 0;
> +    int ret;
> +
> +    migration_info.dirty_pfns.start_addr = start_addr;
> +    migration_info.dirty_pfns.total = pfn_count;
> +
> +    ret = pwrite(vbasedev->fd, &migration_info.dirty_pfns,
> +                 sizeof(migration_info.dirty_pfns),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              dirty_pfns));

Do you also have to check the return value is equal to the size?

> +    if (ret < 0) {
> +        error_report("Failed to set dirty pages start address %d %s",
> +                ret, strerror(errno));
> +        return;
> +    }
> +
> +    do {
> +        /* Read dirty_pfns.copied */
> +        ret = pread(vbasedev->fd, &migration_info.dirty_pfns,
> +                sizeof(migration_info.dirty_pfns),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             dirty_pfns));
> +        if (ret < 0) {
> +            error_report("Failed to get dirty pages bitmap count %d %s",
> +                    ret, strerror(errno));
> +            return;
> +        }
> +
> +        if (migration_info.dirty_pfns.copied) {
> +            uint64_t bitmap_size;
> +            void *buf = NULL;
> +            bool buffer_mmaped = false;
> +
> +            bitmap_size = (BITS_TO_LONGS(migration_info.dirty_pfns.copied) + 1)
> +                           * sizeof(unsigned long);
> +
> +            if (region->mmaps) {
> +                int i;
> +
> +                for (i = 0; i < region->nr_mmaps; i++) {
> +                    if (region->mmaps[i].size >= bitmap_size) {
> +                        buf = region->mmaps[i].mmap;
> +                        buffer_mmaped = true;
> +                        break;
> +                    }
> +                }
> +            }
> +
> +            if (!buffer_mmaped) {
> +                buf = g_malloc0(bitmap_size);
> +
> +                ret = pread(vbasedev->fd, buf, bitmap_size,
> +                            region->fd_offset + sizeof(migration_info) + 1);

Why the +1 ?

> +                if (ret != bitmap_size) {
> +                    error_report("Failed to get migration data %d", ret);
> +                    g_free(buf);
> +                    return;
> +                }
> +            }
> +
> +            cpu_physical_memory_set_dirty_lebitmap((unsigned long *)buf,
> +                                        start_addr + (count * TARGET_PAGE_SIZE),
> +                                        migration_info.dirty_pfns.copied);
> +            count +=  migration_info.dirty_pfns.copied;
> +
> +            if (!buffer_mmaped) {
> +                g_free(buf);
> +            }
> +        }
> +    } while (count < migration_info.dirty_pfns.total);
> +}
> +
> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
> +
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        vfio_pci_save_config(vbasedev, f);
> +    }
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    return qemu_file_get_error(f);
> +}
> +
> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        vfio_pci_load_config(vbasedev, f);
> +    }
> +
> +    if (qemu_get_be64(f) != VFIO_MIG_FLAG_END_OF_STATE) {
> +        error_report("Wrong end of block while loading device config space");
> +        return -EINVAL;
> +    }
> +
> +    return qemu_file_get_error(f);
> +}
> +
> +/* ---------------------------------------------------------------------- */
> +
> +static bool vfio_is_active_iterate(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if (vbasedev->vm_running && vbasedev->migration &&
> +        (vbasedev->migration->pending_precopy_only != 0))
> +        return true;
> +
> +    if (!vbasedev->vm_running && vbasedev->migration &&
> +        (vbasedev->migration->pending_postcopy != 0))
> +        return true;
> +
> +    return false;
> +}
> +
> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    int ret;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> +
> +    qemu_mutex_lock_iothread();
> +    ret = vfio_migration_region_init(vbasedev);
> +    qemu_mutex_unlock_iothread();
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>
You will eventually regret using lots of get's and put's - they're
a pain to debug when it goes wrong.

> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region.buffer;
> +    struct vfio_device_migration_info migration_info;
> +    int ret;
> +
> +    ret = pread(vbasedev->fd, &migration_info.data,
> +                sizeof(migration_info.data),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             data));
> +    if (ret != sizeof(migration_info.data)) {
> +        error_report("Failed to get migration buffer information %d",
> +                     ret);
> +        return -EINVAL;
> +    }
> +
> +    if (migration_info.data.size) {
> +        void *buf = NULL;
> +        bool buffer_mmaped = false;
> +
> +        if (region->mmaps) {
> +            int i;
> +
> +            for (i = 0; i < region->nr_mmaps; i++) {
> +                if (region->mmaps[i].offset == migration_info.data.offset) {
> +                    buf = region->mmaps[i].mmap;
> +                    buffer_mmaped = true;
> +                    break;
> +                }
> +            }
> +        }
> +
> +        if (!buffer_mmaped) {
> +            buf = g_malloc0(migration_info.data.size);

How big are these chunks? If they're larger than about a page please
consider using g_try_malloc0 and checking for allocation failures.

> +            ret = pread(vbasedev->fd, buf, migration_info.data.size,
> +                        region->fd_offset + migration_info.data.offset);
> +            if (ret != migration_info.data.size) {
> +                error_report("Failed to get migration data %d", ret);
> +                return -EINVAL;
> +            }
> +        }
> +
> +        qemu_put_be64(f, migration_info.data.size);
> +        qemu_put_buffer(f, buf, migration_info.data.size);
> +
> +        if (!buffer_mmaped) {
> +            g_free(buf);
> +        }
> +
> +    } else {
> +        qemu_put_be64(f, migration_info.data.size);
> +    }
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return migration_info.data.size;
> +}
> +
> +static int vfio_save_iterate(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    int ret;
> +
> +    ret = vfio_save_buffer(f, vbasedev);
> +    if (ret < 0) {
> +        error_report("vfio_save_buffer failed %s",
> +                     strerror(errno));
> +        return ret;
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return ret;
> +}
> +
> +static void vfio_update_pending(VFIODevice *vbasedev, uint64_t threshold_size)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region.buffer;
> +    struct vfio_device_migration_info migration_info;
> +    int ret;
> +
> +    ret = pwrite(vbasedev->fd, &threshold_size, sizeof(threshold_size),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              pending.threshold_size));
> +    if (ret < 0) {
> +        error_report("Failed to set threshold size %d %s",
> +                     ret, strerror(errno));
> +        return;
> +    }
> +
> +    ret = pread(vbasedev->fd, &migration_info.pending,
> +                sizeof(migration_info.pending),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                             pending));
> +    if (ret != sizeof(migration_info.pending)) {
> +        error_report("Failed to get pending bytes %d", ret);
> +        return;
> +    }
> +
> +    migration->pending_precopy_only = migration_info.pending.precopy_only;
> +    migration->pending_compatible = migration_info.pending.compatible;
> +    migration->pending_postcopy = migration_info.pending.postcopy_only;
> +
> +    return;
> +}
> +
> +static void vfio_save_pending(QEMUFile *f, void *opaque,
> +                              uint64_t threshold_size,
> +                              uint64_t *res_precopy_only,
> +                              uint64_t *res_compatible,
> +                              uint64_t *res_postcopy_only)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    vfio_update_pending(vbasedev, threshold_size);
> +
> +    *res_precopy_only += migration->pending_precopy_only;
> +    *res_compatible += migration->pending_compatible;
> +    *res_postcopy_only += migration->pending_postcopy;
> +}
> +
> +static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    MigrationState *ms = migrate_get_current();
> +    int ret;
> +
> +    if (vbasedev->vm_running) {
> +        vbasedev->vm_running = 0;
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev,
> +                                   VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY);
> +    if (ret) {
> +        error_report("Failed to set state STOPNCOPY_ACTIVE");
> +        return ret;
> +    }
> +
> +    ret = vfio_save_device_config_state(f, opaque);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    do {
> +        vfio_update_pending(vbasedev, ms->threshold_size);
> +
> +        if (vfio_is_active_iterate(opaque)) {
> +            ret = vfio_save_buffer(f, vbasedev);
> +            if (ret < 0) {
> +                error_report("Failed to save buffer");
> +                break;
> +            } else if (ret == 0) {
> +                break;
> +            }
> +        }
> +    } while ((migration->pending_compatible + migration->pending_postcopy) > 0);
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev,
> +                                   VFIO_DEVICE_STATE_MIGRATION_SAVE_COMPLETED);
> +    if (ret) {
> +        error_report("Failed to set state SAVE_COMPLETED");
> +        return ret;
> +    }
> +    return ret;
> +}
> +
> +static void vfio_save_cleanup(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    vfio_migration_region_exit(vbasedev);
> +}
> +
> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    int ret;
> +    uint64_t data;
> +
> +    data = qemu_get_be64(f);
> +    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
> +        if (data == VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
> +            ret = vfio_load_device_config_state(f, opaque);
> +            if (ret) {
> +                return ret;
> +            }
> +        } else if (data == VFIO_MIG_FLAG_DEV_SETUP_STATE) {
> +            data = qemu_get_be64(f);
> +            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
> +                return 0;
> +            } else {
> +                error_report("SETUP STATE: EOS not found 0x%lx", data);
> +                return -EINVAL;
> +            }
> +        } else if (data != 0) {
> +            VFIOMigration *migration = vbasedev->migration;
> +            VFIORegion *region = &migration->region.buffer;
> +            struct vfio_device_migration_info migration_info;
> +            void *buf = NULL;
> +            bool buffer_mmaped = false;
> +
> +            migration_info.data.size = data;
> +
> +            if (region->mmaps) {
> +                int i;
> +
> +                for (i = 0; i < region->nr_mmaps; i++) {
> +                    if (region->mmaps[i].mmap &&
> +                        (region->mmaps[i].size >= data)) {
> +                        buf = region->mmaps[i].mmap;
> +                        migration_info.data.offset = region->mmaps[i].offset;
> +                        buffer_mmaped = true;
> +                        break;
> +                    }
> +                }
> +            }
> +
> +            if (!buffer_mmaped) {
> +                buf = g_malloc0(migration_info.data.size);
> +                migration_info.data.offset = sizeof(migration_info) + 1;
> +            }
> +
> +            qemu_get_buffer(f, buf, data);
> +
> +            ret = pwrite(vbasedev->fd, &migration_info.data,
> +                         sizeof(migration_info.data),
> +                         region->fd_offset +
> +                         offsetof(struct vfio_device_migration_info, data));
> +            if (ret != sizeof(migration_info.data)) {
> +                error_report("Failed to set migration buffer information %d",
> +                        ret);
> +                return -EINVAL;
> +            }
> +
> +            if (!buffer_mmaped) {
> +                ret = pwrite(vbasedev->fd, buf, migration_info.data.size,
> +                             region->fd_offset + migration_info.data.offset);
> +                g_free(buf);
> +
> +                if (ret != migration_info.data.size) {
> +                    error_report("Failed to set migration buffer %d", ret);
> +                    return -EINVAL;
> +                }
> +            }
> +        }
> +
> +        ret = qemu_file_get_error(f);
> +        if (ret) {
> +            return ret;
> +        }
> +        data = qemu_get_be64(f);
> +    }
> +
> +    return 0;
> +}
> +
> +static int vfio_load_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    int ret;
> +
> +    ret = vfio_migration_set_state(vbasedev,
> +                                    VFIO_DEVICE_STATE_MIGRATION_RESUME);
> +    if (ret) {
> +        error_report("Failed to set state RESUME");
> +    }
> +
> +    ret = vfio_migration_region_init(vbasedev);
> +    if (ret) {
> +        error_report("Failed to initialise migration region");
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vfio_load_cleanup(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    int ret = 0;
> +
> +    ret = vfio_migration_set_state(vbasedev,
> +                                 VFIO_DEVICE_STATE_MIGRATION_RESUME_COMPLETED);
> +    if (ret) {
> +        error_report("Failed to set state RESUME_COMPLETED");
> +    }
> +
> +    vfio_migration_region_exit(vbasedev);
> +    return ret;
> +}
> +
> +static SaveVMHandlers savevm_vfio_handlers = {
> +    .save_setup = vfio_save_setup,
> +    .save_live_iterate = vfio_save_iterate,
> +    .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .save_live_pending = vfio_save_pending,
> +    .save_cleanup = vfio_save_cleanup,
> +    .load_state = vfio_load_state,
> +    .load_setup = vfio_load_setup,
> +    .load_cleanup = vfio_load_cleanup,
> +    .is_active_iterate = vfio_is_active_iterate,
> +};
> +
> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if ((vbasedev->vm_running != running) && running) {
> +        int ret;
> +
> +        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        if (ret) {
> +            error_report("Failed to set state RUNNING");
> +        }
> +    }
> +
> +    vbasedev->vm_running = running;
> +}
> +
> +static void vfio_migration_state_notifier(Notifier *notifier, void *data)
> +{
> +    MigrationState *s = data;
> +    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
> +    int ret;
> +
> +    switch (s->state) {
> +    case MIGRATION_STATUS_SETUP:
> +        ret = vfio_migration_set_state(vbasedev,
> +                                       VFIO_DEVICE_STATE_MIGRATION_SETUP);
> +        if (ret) {
> +            error_report("Failed to set state SETUP");
> +        }
> +        return;
> +
> +    case MIGRATION_STATUS_ACTIVE:
> +        if (vbasedev->device_state == VFIO_DEVICE_STATE_MIGRATION_SETUP) {
> +            if (vbasedev->vm_running) {
> +                ret = vfio_migration_set_state(vbasedev,
> +                                          VFIO_DEVICE_STATE_MIGRATION_PRECOPY);
> +                if (ret) {
> +                    error_report("Failed to set state PRECOPY_ACTIVE");
> +                }
> +            } else {
> +                ret = vfio_migration_set_state(vbasedev,
> +                                        VFIO_DEVICE_STATE_MIGRATION_STOPNCOPY);
> +                if (ret) {
> +                    error_report("Failed to set state STOPNCOPY_ACTIVE");
> +                }
> +            }
> +        } else {
> +            ret = vfio_migration_set_state(vbasedev,
> +                                           VFIO_DEVICE_STATE_MIGRATION_RESUME);
> +            if (ret) {
> +                error_report("Failed to set state RESUME");
> +            }
> +        }
> +        return;
> +
> +    case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_CANCELLED:
> +        ret = vfio_migration_set_state(vbasedev,
> +                                       VFIO_DEVICE_STATE_MIGRATION_CANCELLED);
> +        if (ret) {
> +            error_report("Failed to set state CANCELLED");
> +        }
> +        return;
> +
> +    case MIGRATION_STATUS_FAILED:
> +        ret = vfio_migration_set_state(vbasedev,
> +                                       VFIO_DEVICE_STATE_MIGRATION_FAILED);
> +        if (ret) {
> +            error_report("Failed to set state FAILED");
> +        }
> +        return;
> +    }

This lot looks like it would be easier to have a :

    newstate...

   switch (..) {
     case 
      newstate = ...
     case 
      newstate = ...
     case 
      newstate = ...
  }

  ret = vfio_migration_Set_state(newstate);
 
> +}
> +
> +static int vfio_migration_init(VFIODevice *vbasedev,
> +                               struct vfio_region_info *info)
> +{
> +    vbasedev->migration = g_new0(VFIOMigration, 1);
> +    vbasedev->migration->region.index = info->index;
> +
> +    register_savevm_live(NULL, "vfio", -1, 1, &savevm_vfio_handlers, vbasedev);
> +    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> +                                                          vbasedev);
> +
> +    vbasedev->migration_state.notify = vfio_migration_state_notifier;
> +    add_migration_state_change_notifier(&vbasedev->migration_state);
> +
> +    return 0;
> +}
> +
> +
> +/* ---------------------------------------------------------------------- */
> +
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_region_info *info;
> +    int ret;
> +
> +    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
> +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
> +    if (ret) {
> +        Error *local_err = NULL;
> +
> +        error_setg(&vbasedev->migration_blocker,
> +                   "VFIO device doesn't support migration");
> +        ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_free(vbasedev->migration_blocker);
> +            return ret;
> +        }
> +    } else {
> +        return vfio_migration_init(vbasedev, info);
> +    }
> +
> +    return 0;
> +}
> +
> +void vfio_migration_finalize(VFIODevice *vbasedev)
> +{
> +    if (!vbasedev->migration) {
> +        return;
> +    }
> +
> +    if (vbasedev->vm_state) {
> +        qemu_del_vm_change_state_handler(vbasedev->vm_state);
> +        remove_migration_state_change_notifier(&vbasedev->migration_state);
> +    }
> +
> +    if (vbasedev->migration_blocker) {
> +        migrate_del_blocker(vbasedev->migration_blocker);
> +        error_free(vbasedev->migration_blocker);
> +    }
> +
> +    g_free(vbasedev->migration);
> +}
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a9036929b220..ab8217c9e249 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -30,6 +30,8 @@
>  #include <linux/vfio.h>
>  #endif
>  
> +#include "sysemu/sysemu.h"
> +
>  #define ERR_PREFIX "vfio error: %s: "
>  #define WARN_PREFIX "vfio warning: %s: "
>  
> @@ -57,6 +59,16 @@ typedef struct VFIORegion {
>      uint8_t nr; /* cache the region number for debug */
>  } VFIORegion;
>  
> +typedef struct VFIOMigration {
> +    struct {
> +        VFIORegion buffer;
> +        uint32_t index;
> +    } region;
> +    uint64_t pending_precopy_only;
> +    uint64_t pending_compatible;
> +    uint64_t pending_postcopy;
> +} VFIOMigration;
> +
>  typedef struct VFIOAddressSpace {
>      AddressSpace *as;
>      QLIST_HEAD(, VFIOContainer) containers;
> @@ -116,6 +128,12 @@ typedef struct VFIODevice {
>      unsigned int num_irqs;
>      unsigned int num_regions;
>      unsigned int flags;
> +    uint32_t device_state;
> +    VMChangeStateEntry *vm_state;
> +    int vm_running;
> +    Notifier migration_state;
> +    VFIOMigration *migration;
> +    Error *migration_blocker;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> @@ -193,4 +211,9 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
>  
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
> +void vfio_migration_finalize(VFIODevice *vbasedev);
> +void vfio_get_dirty_page_list(VFIODevice *vbasedev, uint64_t start_addr,
> +                               uint64_t pfn_count);
> +
>  #endif /* HW_VFIO_VFIO_COMMON_H */
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
