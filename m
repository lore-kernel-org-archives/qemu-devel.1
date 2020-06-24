Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53EC206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVHKiqIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53EC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joAdO-0002oe-5O
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joAc7-0000Tz-VO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:59:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joAc5-0004ET-T4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593025153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Em8vlYOdz1ZHq1Jul1aPRLXioyrebtzohuC0KJzGnQw=;
 b=HVHKiqIl69thNH3EXMsGax8TAKbKazbBX+IoTJLRe4TQjWQqpoxN2JNGQzKNYSSZEukE8W
 F/5DEk2LU+o7RPERHCjRhbZk06mAz6TW/g6xxD7rOTmE5KgxPTCtmiVVVqLOkks9JP/dFj
 iI1tcwjDCKbKzFtq7AQU027vd6In5bM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-B-_C6IQtNSueCnkCHpVzYw-1; Wed, 24 Jun 2020 14:59:09 -0400
X-MC-Unique: B-_C6IQtNSueCnkCHpVzYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3391F464;
 Wed, 24 Jun 2020 18:59:07 +0000 (UTC)
Received: from x1.home (ovpn-112-156.phx2.redhat.com [10.3.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A642260F8A;
 Wed, 24 Jun 2020 18:59:05 +0000 (UTC)
Date: Wed, 24 Jun 2020 12:55:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 14/17] vfio: Add vfio_listener_log_sync to mark
 dirty pages
Message-ID: <20200624125537.649527b3@x1.home>
In-Reply-To: <1592684486-18511-15-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-15-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jun 2020 01:51:23 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> vfio_listener_log_sync gets list of dirty pages from container using
> VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
> devices are stopped and saving state.
> Return early for the RAM block section of mapped MMIO region.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c     | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |   1 +
>  2 files changed, 131 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6921a78e9ba5..0518cf228ed5 100644
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

Should this be passed the container in order to iterate
container->group_list?

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
> @@ -852,9 +876,115 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  }
>  
> +static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
> +                                 uint64_t size, ram_addr_t ram_addr)
> +{
> +    struct vfio_iommu_type1_dirty_bitmap *dbitmap;
> +    struct vfio_iommu_type1_dirty_bitmap_get *range;
> +    uint64_t pages;
> +    int ret;
> +
> +    dbitmap = g_malloc0(sizeof(*dbitmap) + sizeof(*range));
> +
> +    dbitmap->argsz = sizeof(*dbitmap) + sizeof(*range);
> +    dbitmap->flags = VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> +    range = (struct vfio_iommu_type1_dirty_bitmap_get *)&dbitmap->data;
> +    range->iova = iova;
> +    range->size = size;
> +
> +    /*
> +     * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
> +     * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap's pgsize to
> +     * TARGET_PAGE_SIZE.
> +     */
> +    range->bitmap.pgsize = TARGET_PAGE_SIZE;
> +
> +    pages = TARGET_PAGE_ALIGN(range->size) >> TARGET_PAGE_BITS;
> +    range->bitmap.size = ROUND_UP(pages, sizeof(__u64) * BITS_PER_BYTE) /
> +                                         BITS_PER_BYTE;
> +    range->bitmap.data = g_try_malloc0(range->bitmap.size);
> +    if (!range->bitmap.data) {
> +        ret = -ENOMEM;
> +        goto err_out;
> +    }
> +
> +    ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
> +    if (ret) {
> +        error_report("Failed to get dirty bitmap for iova: 0x%llx "
> +                "size: 0x%llx err: %d",
> +                range->iova, range->size, errno);
> +        goto err_out;
> +    }
> +
> +    cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitmap.data,
> +                                            ram_addr, pages);
> +
> +    trace_vfio_get_dirty_bitmap(container->fd, range->iova, range->size,
> +                                range->bitmap.size, ram_addr);
> +err_out:
> +    g_free(range->bitmap.data);
> +    g_free(dbitmap);
> +
> +    return ret;
> +}
> +
> +static int vfio_sync_dirty_bitmap(MemoryListener *listener,
> +                                 MemoryRegionSection *section)
> +{
> +    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
> +    VFIOGuestIOMMU *giommu = NULL;
> +    ram_addr_t ram_addr;
> +    uint64_t iova, size;
> +    int ret = 0;
> +
> +    if (memory_region_is_iommu(section->mr)) {
> +
> +        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> +            if (MEMORY_REGION(giommu->iommu) == section->mr &&
> +                giommu->n.start == section->offset_within_region) {
> +                VFIOIovaRange *iova_range;
> +
> +                QLIST_FOREACH(iova_range, &giommu->iova_list, next) {
> +                    ret = vfio_get_dirty_bitmap(container, iova_range->iova,
> +                                        iova_range->size, iova_range->ram_addr);
> +                    if (ret) {
> +                        break;
> +                    }
> +                }
> +                break;
> +            }
> +        }
> +
> +    } else {
> +        iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +        size = int128_get64(section->size);
> +
> +        ram_addr = memory_region_get_ram_addr(section->mr) +
> +                   section->offset_within_region + iova -
> +                   TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +
> +        ret = vfio_get_dirty_bitmap(container, iova, size, ram_addr);
> +    }
> +
> +    return ret;
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
> +        vfio_sync_dirty_bitmap(listener, section);
> +    }


How do we decide that this is the best policy for all devices?  For
example if a device does not support page pinning or some future means
of marking dirtied pages, this is clearly the right choice, but when
these are supported, aren't we deferring all dirty logging info until
the final stage?  Thanks,

Alex

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


