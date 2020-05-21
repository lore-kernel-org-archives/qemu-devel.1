Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D586C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA8520872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtmCsKE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA8520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqWn-0004Lh-E6
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqW5-0003v3-Iy
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:06:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42663
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqW3-000766-5y
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590087961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J6hD4XRtvPPzO87WAGVfqnPjHpxSsLwhkexPZp+M4BI=;
 b=AtmCsKE2u/hzSfipI9+Cuxmwr/5FXf7FIVL0hd5hWeKa9D16hwVhcEOygq+wLoJ23HQtMM
 fmWrM3hhVQkhGnF3Quk6koLl8B4vtR03k+pMblL5nkAVr9qOKvROB1bbjHV5jbwz394srb
 a/5eo2ndjEYpZnTViihoChvRLTg9MqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-4H7vBDAuO8OyRyhBRmG3OA-1; Thu, 21 May 2020 15:05:57 -0400
X-MC-Unique: 4H7vBDAuO8OyRyhBRmG3OA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E91271005512;
 Thu, 21 May 2020 19:05:54 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 092C560C05;
 Thu, 21 May 2020 19:05:43 +0000 (UTC)
Date: Thu, 21 May 2020 20:05:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 16/18] vfio: Add ioctl to get dirty pages bitmap
 during dma unmap.
Message-ID: <20200521190541.GN2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-17-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589999088-31477-17-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
> With vIOMMU, IO virtual address range can get unmapped while in pre-copy
> phase of migration. In that case, unmap ioctl should return pages pinned
> in that range and QEMU should find its correcponding guest physical
> addresses and report those dirty.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 80 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 3f7049fbd1b0..2dd9e8b24788 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -311,11 +311,82 @@ static bool vfio_devices_are_stopped_and_saving(void)
>      return true;
>  }
>  
> +static bool vfio_devices_are_running_and_saving(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> +                (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
> +                continue;
> +            } else {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
> +static int vfio_dma_unmap_bitmap(VFIOContainer *container,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 IOMMUTLBEntry *iotlb)
> +{
> +    struct vfio_iommu_type1_dma_unmap *unmap;
> +    struct vfio_bitmap *bitmap;
> +    uint64_t pages = TARGET_PAGE_ALIGN(size) >> TARGET_PAGE_BITS;
> +    int ret;
> +
> +    unmap = g_malloc0(sizeof(*unmap) + sizeof(*bitmap));
> +    if (!unmap) {
> +        return -ENOMEM;
> +    }

Again that's a fixed size thing so you don't really need to malloc it;
g_malloc0 won't return NULL; it'll just assert (which it shouldn't
do anyway because those structures are small).  Personally I'd just put
it on the stack.

> +    unmap->argsz = sizeof(*unmap) + sizeof(*bitmap);
> +    unmap->iova = iova;
> +    unmap->size = size;
> +    unmap->flags |= VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP;
> +    bitmap = (struct vfio_bitmap *)&unmap->data;
> +
> +    /*
> +     * cpu_physical_memory_set_dirty_lebitmap() expects pages in bitmap of
> +     * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap_pgsize to
> +     * TARGET_PAGE_SIZE.
> +     */
> +
> +    bitmap->pgsize = TARGET_PAGE_SIZE;
> +    bitmap->size = ROUND_UP(pages, sizeof(__u64) * BITS_PER_BYTE) /
> +                   BITS_PER_BYTE;
> +
> +    if (bitmap->size > container->max_dirty_bitmap_size) {
> +        error_report("UNMAP: Size of bitmap too big 0x%llx", bitmap->size);
> +        ret = -E2BIG;
> +        goto unmap_exit;
> +    }
> +
> +    bitmap->data = g_malloc0(bitmap->size);

That one should be a g_try_malloc0 and check it's non-null.

> +
> +    ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
> +    if (!ret) {
> +        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)bitmap->data,
> +                iotlb->translated_addr, pages);
> +    } else {
> +        error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %d", -errno);

You're allowed touse %m in hw/vfio for printing the error nicely.

> +    }
> +
> +    g_free(bitmap->data);
> +unmap_exit:
> +    g_free(unmap);
> +    return ret;
> +}
> +
>  /*
>   * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
>   */
>  static int vfio_dma_unmap(VFIOContainer *container,
> -                          hwaddr iova, ram_addr_t size)
> +                          hwaddr iova, ram_addr_t size,
> +                          IOMMUTLBEntry *iotlb)
>  {
>      struct vfio_iommu_type1_dma_unmap unmap = {
>          .argsz = sizeof(unmap),
> @@ -324,6 +395,11 @@ static int vfio_dma_unmap(VFIOContainer *container,
>          .size = size,
>      };
>  
> +    if (iotlb && container->dirty_pages_supported &&
> +        vfio_devices_are_running_and_saving()) {
> +        return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
> +    }
> +
>      while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          /*
>           * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
> @@ -371,7 +447,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>       * the VGA ROM space.
>       */
>      if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> -        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
> +        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
>           ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
>          return 0;
>      }
> @@ -519,7 +595,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                           iotlb->addr_mask + 1, vaddr, ret);
>          }
>      } else {
> -        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
> +        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx") = %d (%m)",
> @@ -822,7 +898,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  
>      if (try_unmap) {
> -        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> +        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx") = %d (%m)",
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


