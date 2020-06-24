Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372ABC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093802082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbacS8o/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093802082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joAfU-0006HK-6o
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joAc2-0000Gi-6v
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:59:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joAc0-0004CX-5l
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593025146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILE94C96oLYOR3112z4jfnVh8BqtvVRNz98Gv2HkJwY=;
 b=dbacS8o/+f8umw76BHZfMbOYN7/NE3JUnnZQj66yhEALKbCQsoW9+5AfZoomrh3/foTDet
 9ixCveKaAQpVrv5g8wZ8W46DR7VSN3h/YZMnMrC/IHBVNxz2yZPcnzrSQEu0Z554E7yE7G
 HHqfAWyf5hb5eSwIxE971eh/gv5elLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-nqc3VoH3NFKcYu7wOQKEbg-1; Wed, 24 Jun 2020 14:59:03 -0400
X-MC-Unique: nqc3VoH3NFKcYu7wOQKEbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08EFA108BD0C;
 Wed, 24 Jun 2020 18:59:01 +0000 (UTC)
Received: from x1.home (ovpn-112-156.phx2.redhat.com [10.3.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7769C60F8A;
 Wed, 24 Jun 2020 18:58:59 +0000 (UTC)
Date: Wed, 24 Jun 2020 12:56:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 15/17] vfio: Add ioctl to get dirty pages
 bitmap during dma unmap.
Message-ID: <20200624125614.5e742574@x1.home>
In-Reply-To: <1592684486-18511-16-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-16-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Sun, 21 Jun 2020 01:51:24 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> With vIOMMU, IO virtual address range can get unmapped while in pre-copy
> phase of migration. In that case, unmap ioctl should return pages pinned
> in that range and QEMU should find its correcponding guest physical
> addresses and report those dirty.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0518cf228ed5..a06b8f2f66e2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -311,11 +311,83 @@ static bool vfio_devices_are_stopped_and_saving(void)
>      return true;
>  }
>  
> +static bool vfio_devices_are_running_and_saving(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {

Same as previous, I'm curious if we should instead be looking at
container granularity.  It especially seems to make sense here where
we're unmapping from a container, so iterating every device in every
group seems excessive.

> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> +                (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
> +                continue;
> +            } else {
> +                return false;
> +            }

I'm also not sure about the polarity of this function, should it be if
any device is _SAVING we should report the dirty bitmap?  For example,
what if we have a set of paried failover NICs where we intend to unplug
one just prior to stopping the devices, aren't we going to lose dirtied
pages with this logic that they all must be running and saving?  Thanks,

Alex

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
> +
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
> +    bitmap->data = g_try_malloc0(bitmap->size);
> +    if (!bitmap->data) {
> +        ret = -ENOMEM;
> +        goto unmap_exit;
> +    }
> +
> +    ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
> +    if (!ret) {
> +        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)bitmap->data,
> +                iotlb->translated_addr, pages);
> +    } else {
> +        error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
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
> @@ -324,6 +396,11 @@ static int vfio_dma_unmap(VFIOContainer *container,
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
> @@ -371,7 +448,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>       * the VGA ROM space.
>       */
>      if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> -        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
> +        (errno == EBUSY && vfio_dma_unmap(container, iova, size, NULL) == 0 &&
>           ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
>          return 0;
>      }
> @@ -542,7 +619,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>              }
>          }
>  
> -        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
> +        ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, iotlb);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx") = %d (%m)",
> @@ -853,7 +930,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  
>      if (try_unmap) {
> -        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> +        ret = vfio_dma_unmap(container, iova, int128_get64(llsize), NULL);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx") = %d (%m)",


