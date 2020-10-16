Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA26C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBFA207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7sT6gT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBFA207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKez-0007KK-Q3
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKdU-0006GV-9b
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKdS-0007kN-9w
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602835125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQN6svgc8jNvmXKTNnzUBnyuzNjlz72qsV6bQoaY3Uk=;
 b=A7sT6gT39L/DKmVMFOj/T9zejB4tBAFQk24pf1ntHxwKhPsEEx5gP/1yeFVfycp9ghKtiT
 FMhd3iU2qp6P54pxUwRIjVbcacREPG8KIHGaHiz70SgPcfp+2schi6eSFyUmd0JHvVDspR
 3mQM2vulH5BCAhgnT3wb+RBGFz137dA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-U0CvAIk-P2-yfgb5MpCM4A-1; Fri, 16 Oct 2020 03:58:41 -0400
X-MC-Unique: U0CvAIk-P2-yfgb5MpCM4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97BA457001;
 Fri, 16 Oct 2020 07:58:40 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7C7C5D9CA;
 Fri, 16 Oct 2020 07:58:29 +0000 (UTC)
Subject: Re: [PATCH v10 03/10] virtio-iommu: Add memory notifiers for map/unmap
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-4-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bacbb642-ba18-77b7-3776-617b0e577540@redhat.com>
Date: Fri, 16 Oct 2020 09:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-4-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, bbhushan2@marvell.com, qemu-devel@nongnu.org,
 peterx@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 10/8/20 7:15 PM, Jean-Philippe Brucker wrote:
> From: Bharat Bhushan <bbhushan2@marvell.com>
> 
> Extend VIRTIO_IOMMU_T_MAP/UNMAP request to notify memory listeners. It
> will call VFIO notifier to map/unmap regions in the physical IOMMU.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v10:
> * Use the flags from IOMMUMemoryRegion
> * Pass virt_start/virt_end rather than size, to avoid dealing with
>   overflow and for consistency.
> ---
>  hw/virtio/virtio-iommu.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  hw/virtio/trace-events   |  2 ++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 33115e82186..fcdf3a819f8 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -125,6 +125,49 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>      }
>  }
>  
> +static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr virt_start,
> +                                    hwaddr virt_end, hwaddr paddr)
> +{
> +    IOMMUTLBEntry entry;
> +    IOMMUNotifierFlag flags = mr->iommu_notify_flags;
> +
> +    if (!(flags & IOMMU_NOTIFIER_MAP)) {
> +        return;
> +    }
> +
> +    trace_virtio_iommu_notify_map(mr->parent_obj.name, virt_start, virt_end,
> +                                  paddr);
> +
> +    entry.target_as = &address_space_memory;
> +    entry.addr_mask = virt_end - virt_start;
> +    entry.iova = virt_start;
> +    entry.perm = IOMMU_RW;
logically you should be able to cascade the struct virtio_iommu_req_map
*req flags field instead.
> +    entry.translated_addr = paddr;
> +
> +    memory_region_notify_iommu(mr, 0, entry);
> +}
> +
> +static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr virt_start,
> +                                      hwaddr virt_end)
> +{
> +    IOMMUTLBEntry entry;
> +    IOMMUNotifierFlag flags = mr->iommu_notify_flags;
> +
> +    if (!(flags & IOMMU_NOTIFIER_UNMAP)) {
> +        return;
> +    }
> +
> +    trace_virtio_iommu_notify_unmap(mr->parent_obj.name, virt_start, virt_end);
> +
> +    entry.target_as = &address_space_memory;
> +    entry.addr_mask = virt_end - virt_start;
> +    entry.iova = virt_start;
> +    entry.perm = IOMMU_NONE;
> +    entry.translated_addr = 0;
> +
> +    memory_region_notify_iommu(mr, 0, entry);
> +}
> +
>  static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>  {
>      if (!ep->domain) {
> @@ -315,6 +358,7 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>      VirtIOIOMMUDomain *domain;
>      VirtIOIOMMUInterval *interval;
>      VirtIOIOMMUMapping *mapping;
> +    VirtIOIOMMUEndpoint *ep;
>  
>      if (flags & ~VIRTIO_IOMMU_MAP_F_MASK) {
>          return VIRTIO_IOMMU_S_INVAL;
> @@ -344,6 +388,10 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>  
>      g_tree_insert(domain->mappings, interval, mapping);
>  
> +    QLIST_FOREACH(ep, &domain->endpoint_list, next) {
> +        virtio_iommu_notify_map(ep->iommu_mr, virt_start, virt_end, phys_start);
> +    }
> +
>      return VIRTIO_IOMMU_S_OK;
>  }
>  
> @@ -356,6 +404,7 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>      VirtIOIOMMUMapping *iter_val;
>      VirtIOIOMMUInterval interval, *iter_key;
>      VirtIOIOMMUDomain *domain;
> +    VirtIOIOMMUEndpoint *ep;
>      int ret = VIRTIO_IOMMU_S_OK;
>  
>      trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
> @@ -373,6 +422,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>          uint64_t current_high = iter_key->high;
>  
>          if (interval.low <= current_low && interval.high >= current_high) {
> +            QLIST_FOREACH(ep, &domain->endpoint_list, next) {
> +                virtio_iommu_notify_unmap(ep->iommu_mr, current_low,
> +                                          current_high);
> +            }
>              g_tree_remove(domain->mappings, iter_key);
>              trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
>          } else {
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index cf1e59de302..65a48555c78 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -106,6 +106,8 @@ virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>  virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>  virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
>  virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
> +virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
> +virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
>  
>  # virtio-mem.c
>  virtio_mem_send_response(uint16_t type) "type=%" PRIu16
> 
Besides it looks good to me.

Thanks

Eric


