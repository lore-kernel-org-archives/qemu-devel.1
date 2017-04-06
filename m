Received: from eggs.gnu.org ([2001:4830:134:3::10]:52834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cw5wM-0007iz-Sl
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1cw5wI-0002fR-1G
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:51:02 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1cw5wH-0002fD-RT
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:50:57 -0400
Received: by mail-pg0-x242.google.com with SMTP id 81so7975426pgh.3
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 04:50:57 -0700 (PDT)
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-2-haozhong.zhang@intel.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <5f625ae6-3908-51fa-9316-0557cfe55c47@gmail.com>
Date: Thu, 6 Apr 2017 19:50:51 +0800
MIME-Version: 1.0
In-Reply-To: <20170331084147.32716-2-haozhong.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] pc-dimm: add 'reserved-size' to
 reserve address range after the ending address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: dan.j.williams@intel.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 03/31/2017 04:41 PM, Haozhong Zhang wrote:
> If option 'reserved-size=RSVD' is present, QEMU will reserve an
> address range of size 'RSVD' after the ending address of pc-dimm
> device.
>
> For the following example,
>     -object memory-backend-file,id=mem0,size=4G,...
>     -device nvdimm,id=dimm0,memdev=mem0,reserved-size=4K,...
>     -device pc-dimm,id=dimm1,...
> if dimm0 is allocated to address N ~ N+4G, the address range of
> dimm1 will start from N+4G+4K or higher.
>
> Its current usage is to reserve spaces for flush hint addresses
> of nvdimm devices.
>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  hw/mem/pc-dimm.c         | 48 +++++++++++++++++++++++++++++++++++++++++++++---
>  include/hw/mem/pc-dimm.h |  2 ++
>  2 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 9e8dab0..13dcd71 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/kvm.h"
>  #include "trace.h"
>  #include "hw/virtio/vhost.h"
> +#include "exec/address-spaces.h"
>
>  typedef struct pc_dimms_capacity {
>       uint64_t size;
> @@ -44,7 +45,12 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>      MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm);
>      Error *local_err = NULL;
>      uint64_t existing_dimms_capacity = 0;
> -    uint64_t addr;
> +    uint64_t addr, size = memory_region_size(mr);
> +
> +    size += object_property_get_int(OBJECT(dimm), PC_DIMM_RSVD_PROP, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
>
>      addr = object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &local_err);
>      if (local_err) {
> @@ -54,7 +60,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>      addr = pc_dimm_get_free_addr(hpms->base,
>                                   memory_region_size(&hpms->mr),
>                                   !addr ? NULL : &addr, align,
> -                                 memory_region_size(mr), &local_err);
> +                                 size, &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -64,7 +70,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>          goto out;
>      }
>
> -    if (existing_dimms_capacity + memory_region_size(mr) >
> +    if (existing_dimms_capacity + size >
>          machine->maxram_size - machine->ram_size) {
>          error_setg(&local_err, "not enough space, currently 0x%" PRIx64
>                     " in use of total hot pluggable 0x" RAM_ADDR_FMT,
> @@ -315,6 +321,9 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
>          PCDIMMDevice *dimm = item->data;
>          uint64_t dimm_size = object_property_get_int(OBJECT(dimm),
>                                                       PC_DIMM_SIZE_PROP,
> +                                                     errp) +
> +                             object_property_get_int(OBJECT(dimm),
> +                                                     PC_DIMM_RSVD_PROP,
>                                                       errp);
>          if (errp && *errp) {
>              goto out;
> @@ -382,6 +391,37 @@ static void pc_dimm_check_memdev_is_busy(Object *obj, const char *name,
>      error_propagate(errp, local_err);
>  }
>

Should count the reserved size in pc_existing_dimms_capacity_internal()
too.
