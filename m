Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4998AC43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DD220878
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2SO+Fu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DD220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTLo3-0008CJ-Bj
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTLnF-0007mY-8M
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTLnB-0002jn-ON
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602839571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQ4aP5p3aTxCICgYx0TdiOrLxv0DsOcpnG74KPiKddQ=;
 b=a2SO+Fu9nKPQkQ/oyzB8t4uzJVVeJei0Mmzv1u70qOYoljOD8Mp4XBCwV9cjh8L5gJ1760
 OJWZZQdLESmzcjby6JKEdWJ9HPpSM1V0OygpPYv5N2ui/Y7ahAtQA7b3mg3kYQGDJ9foLi
 s/hMkwtEwZNM9/5fj+1dGqRbC+gcBpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-OD_5yezVNd2RUev8EcxjpQ-1; Fri, 16 Oct 2020 05:12:48 -0400
X-MC-Unique: OD_5yezVNd2RUev8EcxjpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C474186841A;
 Fri, 16 Oct 2020 09:12:47 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2B5860BFA;
 Fri, 16 Oct 2020 09:12:36 +0000 (UTC)
Subject: Re: [PATCH v10 05/10] virtio-iommu: Add replay() memory region
 callback
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-6-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <056334ec-583d-83c0-74e3-4f87fea365db@redhat.com>
Date: Fri, 16 Oct 2020 11:12:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-6-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
> Implement the replay callback to setup all mappings for a new memory
> region.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v10: Homogenize tracepoint arguments
> ---
>  hw/virtio/virtio-iommu.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  hw/virtio/trace-events   |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 7e6e3cf5200..d2b96846134 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -861,6 +861,46 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>      return (ua > ub) - (ua < ub);
>  }
>  
> +static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer data)
> +{
> +    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
> +    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
> +
> +    trace_virtio_iommu_remap(mr->parent_obj.name, interval->low, interval->high,
> +                             mapping->phys_addr);
> +    virtio_iommu_notify_unmap(mr, interval->low, interval->high);
> +    virtio_iommu_notify_map(mr, interval->low, interval->high,
> +                            mapping->phys_addr);
I don't get the preliminary unmap with the same data. Why isn't the map
sufficient to replay?

The default implementation only notifies for valid entries.
> +    return false;
> +}
> +
> +static void virtio_iommu_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
> +{
> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> +    VirtIOIOMMU *s = sdev->viommu;
> +    uint32_t sid;
> +    VirtIOIOMMUEndpoint *ep;
> +
> +    sid = virtio_iommu_get_bdf(sdev);
> +
> +    qemu_mutex_lock(&s->mutex);
> +
> +    if (!s->endpoints) {
> +        goto unlock;
> +    }
> +
> +    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
> +    if (!ep || !ep->domain) {
> +        goto unlock;
> +    }
> +
> +    g_tree_foreach(ep->domain->mappings, virtio_iommu_remap, mr);
> +
> +unlock:
> +    qemu_mutex_unlock(&s->mutex);
> +}
> +
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -1091,6 +1131,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>  
>      imrc->translate = virtio_iommu_translate;
> +    imrc->replay = virtio_iommu_replay;
>  }
>  
>  static const TypeInfo virtio_iommu_info = {
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 65a48555c78..16f4729db4b 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -108,6 +108,7 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uin
>  virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
>  virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
>  virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
> +virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
>  
>  # virtio-mem.c
>  virtio_mem_send_response(uint16_t type) "type=%" PRIu16
> 
Thanks

Eric


