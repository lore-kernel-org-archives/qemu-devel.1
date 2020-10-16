Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E116FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5469720872
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExWXf8CN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5469720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTL0p-0005Lm-7L
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKwV-00013r-IL
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKwT-0006cg-7g
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602836303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nI31lpRC3RuBjMljucSJMkGUp870VqbFkQNzL/X9tec=;
 b=ExWXf8CNxgjYfKY5fXf48UholP5g3Y3DnEst46aL106Bp8yksMIoFv/jHiVDaQP8I9n3ON
 ad56k7F1daGqaL8ReZwZ6KQp9zD++RDYWpCvrUDca4pAGuBCWTYfGPc4hHTX6VfAIig4Aj
 6APBr5AQhvzSMqot7yULkzJINnmxVaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-xsE7_gB0MF-sLXo4h-Iehg-1; Fri, 16 Oct 2020 04:18:20 -0400
X-MC-Unique: xsE7_gB0MF-sLXo4h-Iehg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D10B56414D;
 Fri, 16 Oct 2020 08:18:18 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E36F6EF70;
 Fri, 16 Oct 2020 08:18:08 +0000 (UTC)
Subject: Re: [PATCH v10 06/10] virtio-iommu: Add notify_flag_changed() memory
 region callback
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-7-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <250ef373-bbba-d9a6-c365-89c437c19c72@redhat.com>
Date: Fri, 16 Oct 2020 10:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-7-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
> Add notify_flag_changed() to notice when memory listeners are added and
> removed.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v10:
> * Use notifier flags instead of notifiers_list
> * Homogenize tracepoints
> ---
>  hw/virtio/virtio-iommu.c | 14 ++++++++++++++
>  hw/virtio/trace-events   |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index d2b96846134..8823bfc804a 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -901,6 +901,19 @@ unlock:
>      qemu_mutex_unlock(&s->mutex);
>  }
>  
> +static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
> +                                            IOMMUNotifierFlag old,
> +                                            IOMMUNotifierFlag new,
> +                                            Error **errp)
> +{
> +    if (old == IOMMU_NOTIFIER_NONE) {
> +        trace_virtio_iommu_notify_flag_add(iommu_mr->parent_obj.name);
> +    } else if (new == IOMMU_NOTIFIER_NONE) {
> +        trace_virtio_iommu_notify_flag_del(iommu_mr->parent_obj.name);
> +    }
> +    return 0;
> +}
> +
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -1132,6 +1145,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>  
>      imrc->translate = virtio_iommu_translate;
>      imrc->replay = virtio_iommu_replay;
> +    imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
>  }
>  
>  static const TypeInfo virtio_iommu_info = {
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 16f4729db4b..9108992bcc3 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -109,6 +109,8 @@ virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start,
>  virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
>  virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
>  virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
> +virtio_iommu_notify_flag_add(const char *name) "add notifier mr=%s"
Maybe "add notifier %d to mr=%s"
> +virtio_iommu_notify_flag_del(const char *name) "del notifier mr=%s"
from?
>  
>  # virtio-mem.c
>  virtio_mem_send_response(uint16_t type) "type=%" PRIu16
> 

Besides
Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


