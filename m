Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EBFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1034206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va+VQsOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1034206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joAd7-0002E1-NN
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joAby-00008m-2W
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:59:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joAbw-0004Ai-4D
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593025143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0D7vPdEyzxR/vZxoI5iMUC2l4pcRKAvIP5CXZIWDIU=;
 b=Va+VQsOHPmmgaqdHE06I7vCj3tA2ivSqEWE45WU2UsdBhJ/25EKTrBPdI6qIcjerVqdbFt
 1ibML0mYr5tL+NLwWLHapvhAc3jCgLNSy4r1Bomk1g0cwNlTxI/Chl8Iymxido6Yxmptvp
 d4nlnam3+2C4r7a3/0S77EjM8e+2MVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-tHPpVBmBOj6wx-_-lIwStQ-1; Wed, 24 Jun 2020 14:59:01 -0400
X-MC-Unique: tHPpVBmBOj6wx-_-lIwStQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10DFD8015F0;
 Wed, 24 Jun 2020 18:58:59 +0000 (UTC)
Received: from x1.home (ovpn-112-156.phx2.redhat.com [10.3.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57FD860F8A;
 Wed, 24 Jun 2020 18:58:57 +0000 (UTC)
Date: Wed, 24 Jun 2020 12:55:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 13/17] vfio: create mapped iova list when
 vIOMMU is enabled
Message-ID: <20200624125526.5488954c@x1.home>
In-Reply-To: <1592684486-18511-14-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-14-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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

On Sun, 21 Jun 2020 01:51:22 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Create mapped iova list when vIOMMU is enabled. For each mapped iova
> save translated address. Add node to list on MAP and remove node from
> list on UNMAP.
> This list is used to track dirty pages during migration.

This seems like a lot of overhead to support that the VM might migrate.
Is there no way we can build this when we start migration, for example
replaying the mappings at that time?  Thanks,

Alex

 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  hw/vfio/common.c              | 58 ++++++++++++++++++++++++++++++++++++++-----
>  include/hw/vfio/vfio-common.h |  8 ++++++
>  2 files changed, 60 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e0d3d4585a65..6921a78e9ba5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -408,8 +408,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
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
> @@ -440,8 +440,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
>          return false;
>      }
>  
> -    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> -    *read_only = !writable || mr->readonly;
> +    if (vaddr) {
> +        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +    }
> +
> +    if (ram_addr) {
> +        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
> +    }
> +
> +    if (read_only) {
> +        *read_only = !writable || mr->readonly;
> +    }
>  
>      return true;
>  }
> @@ -451,7 +460,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>      VFIOContainer *container = giommu->container;
>      hwaddr iova = iotlb->iova + giommu->iommu_offset;
> -    bool read_only;
>      void *vaddr;
>      int ret;
>  
> @@ -467,7 +475,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      rcu_read_lock();
>  
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> -        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> +        ram_addr_t ram_addr;
> +        bool read_only;
> +
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, &ram_addr, &read_only)) {
>              goto out;
>          }
>          /*
> @@ -485,8 +496,28 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                           "0x%"HWADDR_PRIx", %p) = %d (%m)",
>                           container, iova,
>                           iotlb->addr_mask + 1, vaddr, ret);
> +        } else {
> +            VFIOIovaRange *iova_range;
> +
> +            iova_range = g_malloc0(sizeof(*iova_range));
> +            iova_range->iova = iova;
> +            iova_range->size = iotlb->addr_mask + 1;
> +            iova_range->ram_addr = ram_addr;
> +
> +            QLIST_INSERT_HEAD(&giommu->iova_list, iova_range, next);
>          }
>      } else {
> +        VFIOIovaRange *iova_range, *tmp;
> +
> +        QLIST_FOREACH_SAFE(iova_range, &giommu->iova_list, next, tmp) {
> +            if (iova_range->iova >= iova &&
> +                iova_range->iova + iova_range->size <= iova +
> +                                                       iotlb->addr_mask + 1) {
> +                QLIST_REMOVE(iova_range, next);
> +                g_free(iova_range);
> +            }
> +        }
> +
>          ret = vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> @@ -643,6 +674,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>              g_free(giommu);
>              goto fail;
>          }
> +        QLIST_INIT(&giommu->iova_list);
>          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
>          memory_region_iommu_replay(giommu->iommu, &giommu->n);
>  
> @@ -741,6 +773,13 @@ static void vfio_listener_region_del(MemoryListener *listener,
>          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
>              if (MEMORY_REGION(giommu->iommu) == section->mr &&
>                  giommu->n.start == section->offset_within_region) {
> +                VFIOIovaRange *iova_range, *tmp;
> +
> +                QLIST_FOREACH_SAFE(iova_range, &giommu->iova_list, next, tmp) {
> +                    QLIST_REMOVE(iova_range, next);
> +                    g_free(iova_range);
> +                }
> +
>                  memory_region_unregister_iommu_notifier(section->mr,
>                                                          &giommu->n);
>                  QLIST_REMOVE(giommu, giommu_next);
> @@ -1538,6 +1577,13 @@ static void vfio_disconnect_container(VFIOGroup *group)
>          QLIST_REMOVE(container, next);
>  
>          QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
> +            VFIOIovaRange *iova_range, *itmp;
> +
> +            QLIST_FOREACH_SAFE(iova_range, &giommu->iova_list, next, itmp) {
> +                QLIST_REMOVE(iova_range, next);
> +                g_free(iova_range);
> +            }
> +
>              memory_region_unregister_iommu_notifier(
>                      MEMORY_REGION(giommu->iommu), &giommu->n);
>              QLIST_REMOVE(giommu, giommu_next);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 5a57a78ec517..56b75e4a8bc4 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -89,11 +89,19 @@ typedef struct VFIOContainer {
>      QLIST_ENTRY(VFIOContainer) next;
>  } VFIOContainer;
>  
> +typedef struct VFIOIovaRange {
> +    hwaddr iova;
> +    size_t size;
> +    ram_addr_t ram_addr;
> +    QLIST_ENTRY(VFIOIovaRange) next;
> +} VFIOIovaRange;
> +
>  typedef struct VFIOGuestIOMMU {
>      VFIOContainer *container;
>      IOMMUMemoryRegion *iommu;
>      hwaddr iommu_offset;
>      IOMMUNotifier n;
> +    QLIST_HEAD(, VFIOIovaRange) iova_list;
>      QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
>  } VFIOGuestIOMMU;
>  


