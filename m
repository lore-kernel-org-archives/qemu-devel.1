Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A14C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38D8206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIbZtKWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38D8206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59311 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYh2-0008EI-VB
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jHYT1-0006gl-71
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jHYSy-00078S-SH
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:47:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jHYSy-000789-NQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585252020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuMFZcdJ5495DD/gUf6OFoF6JxTRMjnLIsLlYLITe3I=;
 b=hIbZtKWh+a2iJy2pKc/nmuUrXlEdPVAjRtdhcw4OmJqVcIPGOXUinofPp1p53E1dE19exG
 9m0isha7yQ+vFCmViS/4xLpHni2oKIZf9dDrKXlx+mV/FGR+ogUuZcvhxZJZAbYiavi1DO
 Vl/yGPpijWY2rIqH4z3k23LCaaWFiLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-4hvdCesYOISLLgPc-4wRuw-1; Thu, 26 Mar 2020 15:46:56 -0400
X-MC-Unique: 4hvdCesYOISLLgPc-4wRuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 608C919067E3;
 Thu, 26 Mar 2020 19:46:53 +0000 (UTC)
Received: from x1.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 369D690538;
 Thu, 26 Mar 2020 19:46:51 +0000 (UTC)
Date: Thu, 26 Mar 2020 13:46:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 14/16] vfio: Add vfio_listener_log_sync to mark
 dirty pages
Message-ID: <20200326134650.0c7245e9@x1.home>
In-Reply-To: <1585084154-29461-15-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-15-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 02:39:12 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> vfio_listener_log_sync gets list of dirty pages from container using
> VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
> devices are stopped and saving state.
> Return early for the RAM block section of mapped MMIO region.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c     | 200 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  hw/vfio/trace-events |   1 +
>  2 files changed, 196 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4a2f0d6a2233..6d41e1ac5c2f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -29,6 +29,7 @@
>  #include "hw/vfio/vfio.h"
>  #include "exec/address-spaces.h"
>  #include "exec/memory.h"
> +#include "exec/ram_addr.h"
>  #include "hw/hw.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> @@ -38,6 +39,7 @@
>  #include "sysemu/reset.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "migration/migration.h"
>  
>  VFIOGroupList vfio_group_list =
>      QLIST_HEAD_INITIALIZER(vfio_group_list);
> @@ -288,6 +290,28 @@ const MemoryRegionOps vfio_region_ops = {
>  };
>  
>  /*
> + * Device state interfaces
> + */
> +
> +static bool vfio_devices_are_stopped_and_saving(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> +                !(vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
> +                continue;
> +            } else {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
> +/*
>   * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>   */
>  static int vfio_dma_unmap(VFIOContainer *container,
> @@ -408,8 +432,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>  }
>  
>  /* Called with rcu_read_lock held.  */
> -static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                           bool *read_only)
> +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> +                               ram_addr_t *ram_addr, bool *read_only)
>  {
>      MemoryRegion *mr;
>      hwaddr xlat;
> @@ -440,9 +464,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
>          return false;
>      }
>  
> -    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> -    *read_only = !writable || mr->readonly;
> +    if (vaddr) {
> +        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +    }
>  
> +    if (ram_addr) {
> +        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
> +    }
> +
> +    if (read_only) {
> +        *read_only = !writable || mr->readonly;
> +    }
>      return true;
>  }
>  
> @@ -467,7 +499,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      rcu_read_lock();
>  
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> -        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>              goto out;
>          }
>          /*
> @@ -813,9 +845,167 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  }
>  
> +static int vfio_get_dirty_bitmap(MemoryListener *listener,
> +                                 MemoryRegionSection *section)
> +{
> +    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOGuestIOMMU *giommu;
> +    IOMMUTLBEntry iotlb;
> +    hwaddr granularity, address_limit, iova;
> +    int ret;
> +
> +    if (memory_region_is_iommu(section->mr)) {
> +        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> +            if (MEMORY_REGION(giommu->iommu) == section->mr &&
> +                giommu->n.start == section->offset_within_region) {
> +                break;
> +            }
> +        }
> +
> +        if (!giommu) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    if (memory_region_is_iommu(section->mr)) {
> +        granularity = memory_region_iommu_get_min_page_size(giommu->iommu);
> +
> +        address_limit = MIN(int128_get64(section->size),
> +                            memory_region_iommu_get_address_limit(giommu->iommu,
> +                                                 int128_get64(section->size)));
> +    } else {
> +        granularity = memory_region_size(section->mr);
> +        address_limit = int128_get64(section->size);
> +    }
> +
> +    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    while (iova < address_limit) {
> +        struct vfio_iommu_type1_dirty_bitmap *dbitmap;
> +        struct vfio_iommu_type1_dirty_bitmap_get *range;
> +        ram_addr_t start, pages;
> +        uint64_t iova_xlat, size;
> +
> +        if (memory_region_is_iommu(section->mr)) {
> +            iotlb = address_space_get_iotlb_entry(container->space->as, iova,
> +                                                 true, MEMTXATTRS_UNSPECIFIED);
> +            if ((iotlb.target_as == NULL) || (iotlb.addr_mask == 0)) {
> +                if ((iova + granularity) < iova) {
> +                    break;
> +                }
> +                iova += granularity;
> +                continue;
> +            }
> +            iova_xlat = iotlb.iova + giommu->iommu_offset;
> +            size = iotlb.addr_mask + 1;
> +        } else {
> +            iova_xlat = iova;
> +            size = address_limit;
> +        }
> +
> +        dbitmap = g_malloc0(sizeof(*dbitmap) + sizeof(*range));
> +        if (!dbitmap) {

AIUI, QEMU aborts if this fails, so no need to check.  Because reasons.

> +            return -ENOMEM;
> +        }
> +
> +        dbitmap->argsz = sizeof(*dbitmap) + sizeof(*range);
> +        dbitmap->flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> +        range = (struct vfio_iommu_type1_dirty_bitmap_get *)&dbitmap->data;
> +        range->iova = iova_xlat;
> +        range->size = size;
> +
> +        /*
> +         * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
> +         * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap's pgsize to
> +         * TARGET_PAGE_SIZE.
> +         */
> +        range->bitmap.pgsize = TARGET_PAGE_SIZE;
> +
> +        /*
> +         * Comment from kvm_physical_sync_dirty_bitmap() since same applies here
> +         * XXX bad kernel interface alert
> +         * For dirty bitmap, kernel allocates array of size aligned to
> +         * bits-per-long.  But for case when the kernel is 64bits and
> +         * the userspace is 32bits, userspace can't align to the same
> +         * bits-per-long, since sizeof(long) is different between kernel
> +         * and user space.  This way, userspace will provide buffer which
> +         * may be 4 bytes less than the kernel will use, resulting in
> +         * userspace memory corruption (which is not detectable by valgrind
> +         * too, in most cases).
> +         * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
> +         * a hope that sizeof(long) won't become >8 any time soon.
> +         */

This seems like the problem we've avoided by defining our bitmap as an
array of u64s rather than an array of longs.  Does this comment really
still apply?

> +
> +        pages = TARGET_PAGE_ALIGN(range->size) >> TARGET_PAGE_BITS;
> +        range->bitmap.size = ROUND_UP(pages, 64) / 8;

ROUND_UP(npages/8, sizeof(u64))?

> +        range->bitmap.data = g_malloc0(range->bitmap.size);

We don't require this to be pre-zero'd currently.

> +        if (range->bitmap.data == NULL) {

Same as above.  Seems strange to me too.

> +            error_report("Error allocating bitmap of size 0x%llx",
> +                         range->bitmap.size);
> +            ret = -ENOMEM;
> +            goto err_out;
> +        }
> +
> +        ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
> +        if (ret) {
> +            error_report("Failed to get dirty bitmap for iova: 0x%llx "
> +                         "size: 0x%llx err: %d",
> +                         range->iova, range->size, errno);
> +            goto err_out;
> +        }
> +
> +        if (memory_region_is_iommu(section->mr)) {
> +            if (!vfio_get_xlat_addr(&iotlb, NULL, &start, NULL)) {
> +                ret = -EINVAL;
> +                goto err_out;
> +            }
> +        } else {
> +            start = memory_region_get_ram_addr(section->mr) +
> +                    section->offset_within_region + iova -
> +                    TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +        }
> +
> +        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitmap.data,
> +                                               start, pages);
> +
> +        trace_vfio_get_dirty_bitmap(container->fd, range->iova, range->size,
> +                                    range->bitmap.size, start);
> +err_out:
> +        g_free(range->bitmap.data);
> +        g_free(dbitmap);
> +
> +        if (ret) {
> +            return ret;
> +        }
> +
> +        if ((iova + size) < iova) {
> +            break;
> +        }
> +
> +        iova += size;
> +    }
> +
> +    return 0;
> +}
> +
> +static void vfio_listerner_log_sync(MemoryListener *listener,
> +        MemoryRegionSection *section)
> +{
> +    if (vfio_listener_skipped_section(section)) {
> +        return;
> +    }
> +
> +    if (vfio_devices_are_stopped_and_saving()) {
> +        vfio_get_dirty_bitmap(listener, section);
> +    }
> +}
> +
>  static const MemoryListener vfio_memory_listener = {
>      .region_add = vfio_listener_region_add,
>      .region_del = vfio_listener_region_del,
> +    .log_sync = vfio_listerner_log_sync,
>  };
>  
>  static void vfio_listener_release(VFIOContainer *container)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ac065b559f4e..bc8f35ee9356 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -160,3 +160,4 @@ vfio_save_complete_precopy(char *name) " (%s)"
>  vfio_load_device_config_state(char *name) " (%s)"
>  vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
>  vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64


