Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7552083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5QtCMyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7552083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTPTq-0002YM-T5
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTPT5-00026i-Lh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTPT3-0005Fa-68
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602853698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEcgZvNyGi00z6l/NYVkHO5KlLYfjwhUZbKBa/t1Hyk=;
 b=R5QtCMyKWpcX2qiiyqyz8l5bZV4maTN2uE5RZbV94aZAIqrId+/uxviI7ybjtGnpOHT2OE
 o9nAz+XWbGn5PTCtxNTjSgnwGpSb4ATrHGXQA9U4gizgyvbhY0CJpadobEF40ZqnlRxO6V
 HJM866h2Wv0lyUuG0J1c69LnMJyop4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-OrcRLewpMkeEQ1i9lbpWTg-1; Fri, 16 Oct 2020 09:08:14 -0400
X-MC-Unique: OrcRLewpMkeEQ1i9lbpWTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 387DF640A4;
 Fri, 16 Oct 2020 13:08:13 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D925E27BC3;
 Fri, 16 Oct 2020 13:08:04 +0000 (UTC)
Subject: Re: [PATCH v10 09/10] virtio-iommu: Set supported page size mask
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-10-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <53892fd2-a69f-bd83-4167-b1d2569fb4c3@redhat.com>
Date: Fri, 16 Oct 2020 15:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-10-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
> The virtio-iommu device can deal with arbitrary page sizes for virtual
> endpoints, but for endpoints assigned with VFIO it must follow the page
> granule used by the host IOMMU driver.
> 
> Implement the interface to set the vIOMMU page size mask, called by VFIO
> for each endpoint. We assume that all host IOMMU drivers use the same
> page granule (the host page granule). Override the page_size_mask field
> in the virtio config space.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
> v10: Use global page mask, allowing VFIO to override it until boot.
> ---
>  hw/virtio/virtio-iommu.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 8823bfc804a..dd0b3093d1b 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -914,6 +914,56 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
>      return 0;
>  }
>  
> +static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> +                                           uint64_t page_size_mask,
> +                                           Error **errp)
> +{
> +    int new_granule, old_granule;
> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
> +    VirtIOIOMMU *s = sdev->viommu;
> +
> +    if (!page_size_mask) {
set errp
> +        return -1;
> +    }
> +
> +    new_granule = ctz64(page_size_mask);
> +    old_granule = ctz64(s->config.page_size_mask);

I think this would be interesting to add a trace point
> +
> +    /*
> +     * Modifying the page size after machine initialization isn't supported.
> +     * Having a different mask is possible but the guest will use sub-optimal
> +     * block sizes, so warn about it.
> +     */
> +    if (qdev_hotplug) {
> +        if (new_granule != old_granule) {
> +            error_setg(errp,
> +                       "virtio-iommu page mask 0x%"PRIx64
> +                       " is incompatible with mask 0x%"PRIx64,
> +                       s->config.page_size_mask, page_size_mask);
> +            return -1;
> +        } else if (page_size_mask != s->config.page_size_mask) {
> +            warn_report("virtio-iommu page mask 0x%"PRIx64
> +                        " does not match 0x%"PRIx64,
> +                        s->config.page_size_mask, page_size_mask);
> +        }
> +        return 0;
> +    }
> +
> +    /*
> +     * Disallow shrinking the page size. For example if an endpoint only
> +     * supports 64kB pages, we can't globally enable 4kB pages. But that
> +     * shouldn't happen, the host is unlikely to setup differing page granules.
> +     * The other bits are only hints describing optimal block sizes.
> +     */
> +    if (new_granule < old_granule) {
> +        error_setg(errp, "memory region shrinks the virtio-iommu page granule");
> +        return -1;
> +    }
> +
> +    s->config.page_size_mask = page_size_mask;
> +    return 0;
> +}
> +
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -1146,6 +1196,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>      imrc->translate = virtio_iommu_translate;
>      imrc->replay = virtio_iommu_replay;
>      imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
> +    imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
>  }
>  
>  static const TypeInfo virtio_iommu_info = {
> 
Thanks

Eric


