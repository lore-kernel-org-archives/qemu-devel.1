Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A3AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC01720823
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 18:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKRDTF1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC01720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqKM-0008JH-6r
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 14:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqJV-000789-Ul
 for qemu-devel@nongnu.org; Thu, 21 May 2020 14:53:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqJU-00034o-IR
 for qemu-devel@nongnu.org; Thu, 21 May 2020 14:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590087182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBgzU/m2mMtzBMqbYuOE9kmTBvx6dWnvcqa7QdbJ9Z4=;
 b=BKRDTF1ZkFFHjNnA/ny6epg5wGe5+tpTBHSUnIXmEVnUH3BasNa9ssA+oD/wx2QhIoAEHY
 N3ywMi/KRdMoGUbUDqZvLpKwt3KogUSRjKYhaE/LmZhz3ITowaffZ7EsZ/7Rz6xtiM46w3
 E9aEWuPtT326yaK18Pf6UHeyFj2bbtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-ikvyNE_WMfOUoohN3yCO0g-1; Thu, 21 May 2020 14:52:58 -0400
X-MC-Unique: ikvyNE_WMfOUoohN3yCO0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B4461015DAA;
 Thu, 21 May 2020 18:52:44 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26644707C0;
 Thu, 21 May 2020 18:52:06 +0000 (UTC)
Date: Thu, 21 May 2020 19:52:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 15/18] vfio: Add vfio_listener_log_sync to mark
 dirty pages
Message-ID: <20200521185204.GM2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-16-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-16-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> vfio_listener_log_sync gets list of dirty pages from container using
> VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
> devices are stopped and saving state.
> Return early for the RAM block section of mapped MMIO region.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c     | 184 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  hw/vfio/trace-events |   1 +
>  2 files changed, 180 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e0d3d4585a65..3f7049fbd1b0 100644
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
> @@ -813,9 +845,151 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  }
>  
> +static int vfio_get_dirty_bitmap(MemoryListener *listener,
> +                                 MemoryRegionSection *section)
> +{
> +    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOGuestIOMMU *giommu = NULL;
> +    IOMMUTLBEntry iotlb;
> +    hwaddr granularity, iova, iova_end;
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
> +    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +
> +    if (memory_region_is_iommu(section->mr)) {
> +        hwaddr iova_size;
> +
> +        granularity = memory_region_iommu_get_min_page_size(giommu->iommu);
> +        iova_end = memory_region_iommu_get_address_limit(giommu->iommu);
> +
> +        if (iova_end) {
> +            iova_size = MIN(int128_get64(section->size), iova_end - iova + 1);
> +        } else {
> +            iova_size = int128_get64(section->size);
> +        }
> +
> +        iova_end = iova + iova_size - 1;
> +    } else {
> +        granularity = memory_region_size(section->mr);
> +        iova_end = iova + int128_get64(section->size) - 1;
> +    }
> +
> +    RCU_READ_LOCK_GUARD();
> +
> +    while (iova < iova_end) {
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

What's ging on here?  Is this trying to find the start of a valid area -
why would it happen?  It seems pretty expensive if it's going to walk a
page at a time.

> +                continue;
> +            }
> +            iova_xlat = iotlb.iova + giommu->iommu_offset;
> +            size = iotlb.addr_mask + 1;
> +        } else {
> +            iova_xlat = iova;
> +            size = iova_end - iova + 1;
> +        }
> +
> +        dbitmap = g_malloc0(sizeof(*dbitmap) + sizeof(*range));

This is a constant size, it can be allocated outside the loop; or just
on the stack given it's also small.

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
> +        pages = TARGET_PAGE_ALIGN(range->size) >> TARGET_PAGE_BITS;
> +        range->bitmap.size = ROUND_UP(pages, sizeof(__u64) * BITS_PER_BYTE) /
> +                             BITS_PER_BYTE;

A little long winded; if sizeof(__u64) or BITS_PER_BYTE ever change
we're really in trouble!
(A lot of the rest of the dirtymap code unfortunately uses long's - this
is really __u64?)

> +        range->bitmap.data = g_malloc0(range->bitmap.size);

Given that could be large, you should use g_try_malloc0 and check for
failure.

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
> index 4a4bd3ba9a2a..c61ae4f3ead8 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -160,3 +160,4 @@ vfio_save_complete_precopy(const char *name) " (%s)"
>  vfio_load_device_config_state(const char *name) " (%s)"
>  vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>  vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


