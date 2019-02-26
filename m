Received: from eggs.gnu.org ([209.51.188.92]:55889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gyjAC-00086L-Tm
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gyjAA-0005u8-WA
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:17:16 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gyjAA-0005pk-Hk
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:17:14 -0500
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
	<1550611400-13703-4-git-send-email-kwankhede@nvidia.com>
	<20190221153822.34a1dcc4@w520.home>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <dada4d97-a567-2238-e15e-aa007a139169@nvidia.com>
Date: Wed, 27 Feb 2019 01:46:54 +0530
MIME-Version: 1.0
In-Reply-To: <20190221153822.34a1dcc4@w520.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] Add migration functions for VFIO
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org



On 2/22/2019 4:08 AM, Alex Williamson wrote:
> On Wed, 20 Feb 2019 02:53:18 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> - Migration function are implemented for VFIO_DEVICE_TYPE_PCI device.
>> - Added SaveVMHandlers and implemented all basic functions required for live
>>   migration.
>> - Added VM state change handler to know running or stopped state of VM.
>> - Added migration state change notifier to get notification on migration state
>>   change. This state is translated to VFIO device state and conveyed to vendor
>>   driver.
>> - VFIO device supports migration or not is decided based of migration region
>>   query. If migration region query is successful then migration is supported
>>   else migration is blocked.
>> - Structure vfio_device_migration_info is mapped at 0th offset of migration
>>   region and should always trapped by VFIO device's driver. Added both type of
>>   access support, trapped or mmapped, for data section of the region.
>> - To save device state, read pending_bytes and data_offset using structure
>>   vfio_device_migration_info, accordingly copy data from the region.
>> - To restore device state, write data_offset and data_size in the structure
>>   and write data in the region.
>> - To get dirty page bitmap, write start address and pfn count then read count of
>>   pfns copied and accordingly read those from the rest of the region or mmaped
>>   part of the region. This copy is iterated till page bitmap for all requested
>>   pfns are copied.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  hw/vfio/Makefile.objs         |   2 +-
>>  hw/vfio/migration.c           | 714 ++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/vfio/vfio-common.h |  20 ++
>>  3 files changed, 735 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/vfio/migration.c
>>
>> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
>> index abad8b818c9b..36033d1437c5 100644
>> --- a/hw/vfio/Makefile.objs
>> +++ b/hw/vfio/Makefile.objs
>> @@ -1,4 +1,4 @@
>> -obj-y += common.o spapr.o
>> +obj-y += common.o spapr.o migration.o
>>  obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
>>  obj-$(CONFIG_VFIO_CCW) += ccw.o
>>  obj-$(CONFIG_VFIO_PLATFORM) += platform.o
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> new file mode 100644
>> index 000000000000..d7b6d972c043
>> --- /dev/null
>> +++ b/hw/vfio/migration.c
>> @@ -0,0 +1,714 @@
>> +/*
>> + * Migration support for VFIO devices
>> + *
>> + * Copyright NVIDIA, Inc. 2018
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2. See
>> + * the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include <linux/vfio.h>
>> +
>> +#include "hw/vfio/vfio-common.h"
>> +#include "cpu.h"
>> +#include "migration/migration.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/register.h"
>> +#include "migration/blocker.h"
>> +#include "migration/misc.h"
>> +#include "qapi/error.h"
>> +#include "exec/ramlist.h"
>> +#include "exec/ram_addr.h"
>> +#include "pci.h"
>> +
>> +/*
>> + * Flags used as delimiter:
>> + * 0xffffffff => MSB 32-bit all 1s
>> + * 0xef10     => emulated (virtual) function IO
> 
> :^)
> 
>> + * 0x0000     => 16-bits reserved for flags
>> + */
>> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
>> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
>> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>> +
>> +static void vfio_migration_region_exit(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    if (!migration) {
>> +        return;
>> +    }
>> +
>> +    if (migration->region.buffer.size) {
>> +        vfio_region_exit(&migration->region.buffer);
>> +        vfio_region_finalize(&migration->region.buffer);
>> +    }
>> +}
>> +
>> +static int vfio_migration_region_init(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    Object *obj = NULL;
>> +    int ret = -EINVAL;
>> +
>> +    if (!migration) {
>> +        return ret;
>> +    }
>> +
>> +    /* Migration support added for PCI device only */
>> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
>> +        obj = vfio_pci_get_object(vbasedev);
>> +    }
>> +
>> +    if (!obj) {
>> +        return ret;
>> +    }
>> +
>> +    ret = vfio_region_setup(obj, vbasedev, &migration->region.buffer,
>> +                            migration->region.index, "migration");
>> +    if (ret) {
>> +        error_report("Failed to setup VFIO migration region %d: %s",
>> +                      migration->region.index, strerror(-ret));
>> +        goto err;
>> +    }
>> +
>> +    if (!migration->region.buffer.size) {
>> +        ret = -EINVAL;
>> +        error_report("Invalid region size of VFIO migration region %d: %s",
>> +                     migration->region.index, strerror(-ret));
>> +        goto err;
>> +    }
>> +
>> +    if (migration->region.buffer.mmaps) {
>> +        ret = vfio_region_mmap(&migration->region.buffer);
>> +        if (ret) {
>> +            error_report("Failed to mmap VFIO migration region %d: %s",
>> +                         migration->region.index, strerror(-ret));
>> +            goto err;
>> +        }
> 
> In patch 5 this eventually gets called from our realize function, so
> we're forcing the kernel to allocate whatever backing store it might
> use for these mmaps for the entire life of the device, in case maybe we
> want to migrate it.  Like my reply to Yan, unless I'm misunderstanding
> how drivers will back this mmap this seems really inefficient.
> 

Backing storage can be allocated on access, that is from fault handler,
but will remain allocated for entire life of device.

This can be moved to .save_setup and unmmap from .save_cleanup,
similarly during resuming .load_setup and .load_cleanup can be used.
I'll update patch in next iteration.

>> +    }
>> +
>> +    return 0;
>> +
>> +err:
>> +    vfio_migration_region_exit(vbasedev);
>> +    return ret;
>> +}
>> +
>> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIORegion *region = &migration->region.buffer;
>> +    int ret = 0;
>> +
>> +    ret = pwrite(vbasedev->fd, &state, sizeof(state),
>> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                              device_state));
>> +    if (ret < 0) {
>> +        error_report("Failed to set migration state %d %s",
>> +                     ret, strerror(errno));
>> +        return ret;
>> +    }
>> +
>> +    vbasedev->device_state = state;
>> +    return 0;
>> +}
>> +
>> +void vfio_get_dirty_page_list(VFIODevice *vbasedev,
>> +                              uint64_t start_pfn,
>> +                              uint64_t pfn_count,
>> +                              uint64_t page_size)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIORegion *region = &migration->region.buffer;
>> +    uint64_t count = 0, copied_pfns = 0;
>> +    int ret;
>> +
>> +    ret = pwrite(vbasedev->fd, &start_pfn, sizeof(start_pfn),
>> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                              start_pfn));
>> +    if (ret < 0) {
>> +        error_report("Failed to set dirty pages start address %d %s",
>> +                ret, strerror(errno));
>> +        return;
>> +    }
>> +
>> +    ret = pwrite(vbasedev->fd, &page_size, sizeof(page_size),
>> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                              page_size));
>> +    if (ret < 0) {
>> +        error_report("Failed to set dirty page size %d %s",
>> +                ret, strerror(errno));
>> +        return;
>> +    }
>> +
>> +    ret = pwrite(vbasedev->fd, &pfn_count, sizeof(pfn_count),
>> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                              total_pfns));
>> +    if (ret < 0) {
>> +        error_report("Failed to set dirty page total pfns %d %s",
>> +                ret, strerror(errno));
>> +        return;
>> +    }
>> +
>> +    do {
>> +        uint64_t bitmap_size;
>> +        void *buf = NULL;
>> +        bool buffer_mmaped = false;
>> +
>> +        /* Read dirty_pfns.copied */
>> +        ret = pread(vbasedev->fd, &copied_pfns, sizeof(copied_pfns),
>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                             copied_pfns));
>> +        if (ret < 0) {
>> +            error_report("Failed to get dirty pages bitmap count %d %s",
>> +                    ret, strerror(errno));
>> +            return;
>> +        }
>> +
>> +        if (copied_pfns == 0) {
>> +            /*
>> +             * copied_pfns could be 0 if driver doesn't have any page to report
>> +             * dirty in given range
>> +             */
>> +            break;
>> +        }
>> +
>> +        bitmap_size = (BITS_TO_LONGS(copied_pfns) + 1) * sizeof(unsigned long);
>> +
>> +        if (region->mmaps) {
>> +            int i;
>> +
>> +            for (i = 0; i < region->nr_mmaps; i++) {
>> +                if (region->mmaps[i].size >= bitmap_size) {
>> +                    buf = region->mmaps[i].mmap;
>> +                    buffer_mmaped = true;
>> +                    break;
>> +                }
> 
> Wait, the first sparse mmap region that's big enough to hold the bitmap
> is necessarily the one where we read it?  Shouldn't we test that the
> mmap range covers the correct offset?  This also makes me realize that
> if a driver wanted the device memory mmap'd but not the dirty memory
> backing, I don't think they can do it with this interface.  Perhaps
> there should be separate data and dirty offset fields in the header to
> that a driver can place them at separate offsets with different mmap
> coverage if they desire.  Thanks,
>

Makes sense. I'll add dirty_offset in header.

Thanks,
Kirti


> Alex
> 
