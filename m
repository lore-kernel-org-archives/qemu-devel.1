Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F0C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390F824640
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqU+tl+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390F824640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhMN-0006M7-5k
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 16:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kVhL2-0005aF-A8
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kVhKy-0002kc-TP
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 16:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603399047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fK2GZy5nx0OA5KrccwcRbz4El81A9H/le3Q+6Yk+1ks=;
 b=MqU+tl+sUSk6F6rLXR6vEeR7gD8VmQCfWA3bXFX4BUmqo+2RVP99MTRGGIkz0COmJRE+n7
 5hdRKkhZUFsrYlexlXalZQaA8hMbNlw4U2sQpjmGfEmZ9y184XtIFCIbpeQNp7/XSOTPT4
 JEhCy5yMCLP5oQOET7AekAX0pi9OPuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-MsSospjLNn2P-tf-fkb-ww-1; Thu, 22 Oct 2020 16:37:23 -0400
X-MC-Unique: MsSospjLNn2P-tf-fkb-ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BC1F10866A8;
 Thu, 22 Oct 2020 20:37:20 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B52245B4A9;
 Thu, 22 Oct 2020 20:37:10 +0000 (UTC)
Date: Thu, 22 Oct 2020 14:37:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v27 14/17] vfio: Dirty page tracking when vIOMMU is enabled
Message-ID: <20201022143710.6a11facc@w520.home>
In-Reply-To: <1603365127-14202-15-git-send-email-kwankhede@nvidia.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
 <1603365127-14202-15-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Oct 2020 16:42:04 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> When vIOMMU is enabled, register MAP notifier from log_sync when all
> devices in container are in stop and copy phase of migration. Call replay
> and get dirty pages from notifier callback.
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
>  hw/vfio/common.c              | 95 ++++++++++++++++++++++++++++++++++++++++---
>  hw/vfio/trace-events          |  1 +
>  include/hw/vfio/vfio-common.h |  1 +
>  3 files changed, 91 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 2634387df948..98c2b1f9b190 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -442,8 +442,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
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
> @@ -474,8 +474,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
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
> @@ -485,7 +494,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>      VFIOContainer *container = giommu->container;
>      hwaddr iova = iotlb->iova + giommu->iommu_offset;
> -    bool read_only;
>      void *vaddr;
>      int ret;
>  
> @@ -501,7 +509,9 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      rcu_read_lock();
>  
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> -        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> +        bool read_only;
> +
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>              goto out;
>          }
>          /*
> @@ -899,11 +909,84 @@ err_out:
>      return ret;
>  }
>  
> +static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> +{
> +    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, dirty_notify);
> +    VFIOContainer *container = giommu->container;
> +    hwaddr iova = iotlb->iova + giommu->iommu_offset;
> +    ram_addr_t translated_addr;
> +
> +    trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
> +
> +    if (iotlb->target_as != &address_space_memory) {
> +        error_report("Wrong target AS \"%s\", only system memory is allowed",
> +                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        return;
> +    }
> +
> +    rcu_read_lock();
> +
> +    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> +        int ret;
> +
> +        ret = vfio_get_dirty_bitmap(container, iova, iotlb->addr_mask + 1,
> +                                    translated_addr);
> +        if (ret) {
> +            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                         "0x%"HWADDR_PRIx") = %d (%m)",
> +                         container, iova,
> +                         iotlb->addr_mask + 1, ret);
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +}
> +
>  static int vfio_sync_dirty_bitmap(VFIOContainer *container,
>                                    MemoryRegionSection *section)
>  {
>      ram_addr_t ram_addr;
>  
> +    if (memory_region_is_iommu(section->mr)) {
> +        VFIOGuestIOMMU *giommu;
> +        int ret = 0;
> +
> +        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> +            if (MEMORY_REGION(giommu->iommu) == section->mr &&
> +                giommu->n.start == section->offset_within_region) {
> +                Int128 llend;
> +                Error *err = NULL;
> +                int idx = memory_region_iommu_attrs_to_index(giommu->iommu,
> +                                                       MEMTXATTRS_UNSPECIFIED);
> +
> +                llend = int128_add(int128_make64(section->offset_within_region),
> +                                   section->size);
> +                llend = int128_sub(llend, int128_one());
> +
> +                iommu_notifier_init(&giommu->dirty_notify,
> +                                    vfio_iommu_map_dirty_notify,
> +                                    IOMMU_NOTIFIER_MAP,
> +                                    section->offset_within_region,
> +                                    int128_get64(llend),
> +                                    idx);
> +                ret = memory_region_register_iommu_notifier(section->mr,
> +                                                  &giommu->dirty_notify, &err);
> +                if (ret) {
> +                    error_report_err(err);
> +                    break;
> +                }
> +
> +                memory_region_iommu_replay(giommu->iommu,
> +                                           &giommu->dirty_notify);
> +
> +                memory_region_unregister_iommu_notifier(section->mr,
> +                                                        &giommu->dirty_notify);


Is it necessary to do the register/unregister?  It seemed to me that
perhaps we could do a replay independent of those.

I'd also be tempted to move dirty_notify to a temporary object rather
than store it on the giommu for such a brief usage, ie. define:

struct giommu_dirty_notfier {
    IOMMUNotifier n;
    VFIOGuestIOMMU *giommu;
}

struct giommu_dirty_notfier n = { .giommu = giommu };

iommu_notifier_init(&n,...);

memory_region_iommu_replay(giommu->iommu, &n);
...

struct giommu_dirty_notfier *ndnotifier = container_of(n, struct giommu_dirty_notfier, n);
VFIOGuestIOMMU *giommu = n->giommu;

It's nice that we remove the extra bloat of the list/tree entirely with
this approach.  Thanks,

Alex

> +                break;
> +            }
> +        }
> +        return ret;
> +    }
> +
>      ram_addr = memory_region_get_ram_addr(section->mr) +
>                 section->offset_within_region;
>  
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index c3b35aa2cce8..d9cb8998a228 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -163,3 +163,4 @@ vfio_load_device_config_state(const char *name) " (%s)"
>  vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>  vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
>  vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
> +vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b1c1b18fd228..92872fae59ee 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -99,6 +99,7 @@ typedef struct VFIOGuestIOMMU {
>      IOMMUMemoryRegion *iommu;
>      hwaddr iommu_offset;
>      IOMMUNotifier n;
> +    IOMMUNotifier dirty_notify;
>      QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
>  } VFIOGuestIOMMU;
>  


