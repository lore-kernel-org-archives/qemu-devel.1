Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3086CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 02:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6582076C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 02:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhihXn1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6582076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5gSu-0004xh-4f
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 22:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k5gRR-00041i-KA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 22:24:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k5gRN-0001P4-0f
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 22:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597199071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1wJ3J4b3IUvrBIsY5enQNlCVEyGwBmB0IP3p/G4CHg=;
 b=DhihXn1G4PzXaKQEfVg6p874AFF+B3Ip3WHK6MmcwEEKlK8nHjNtvUlWSycARjuzIgT/Zw
 S9olAD5C/Uu56WEow/0DpOj+nx7dPMEsPOVpY/OS4IbSElFLet4i00MYT3QaccEHXuY9Lr
 IO0ohDxAZgIX+LmzdA54idiK4aWac4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-IutZHy5TNaCwZA9yFgoy-w-1; Tue, 11 Aug 2020 22:24:27 -0400
X-MC-Unique: IutZHy5TNaCwZA9yFgoy-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D3A1902EA1;
 Wed, 12 Aug 2020 02:24:26 +0000 (UTC)
Received: from [10.72.12.118] (ovpn-12-118.pek2.redhat.com [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E564026570;
 Wed, 12 Aug 2020 02:24:05 +0000 (UTC)
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
Date: Wed, 12 Aug 2020 10:24:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811175533.7359-2-eperezma@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 21:42:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/12 上午1:55, Eugenio Pérez wrote:
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   hw/virtio/vhost.c     |  2 +-
>   include/exec/memory.h |  2 ++
>   softmmu/memory.c      | 10 ++++++++--
>   3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1a1384e7a6..e74ad9e09b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
>       iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
>                                                      MEMTXATTRS_UNSPECIFIED);
>       iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> -                        IOMMU_NOTIFIER_UNMAP,
> +                        IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_IOTLB,


I think we can safely drop IOMMU_NOTIFIER_UNMAP here since device IOTLB 
is sufficient.

Btw, IOMMU_NOTIFIER_IOTLB is kind of confusing, maybe something like 
IOMMU_NOTIFIER_DEVIOTLB.


>                           section->offset_within_region,
>                           int128_get64(end),
>                           iommu_idx);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 307e527835..4d94c1e984 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -87,6 +87,8 @@ typedef enum {
>       IOMMU_NOTIFIER_UNMAP = 0x1,
>       /* Notify entry changes (newly created entries) */
>       IOMMU_NOTIFIER_MAP = 0x2,
> +    /* Notify changes on IOTLB entries */
> +    IOMMU_NOTIFIER_IOTLB = 0x04,
>   } IOMMUNotifierFlag;
>   
>   #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af25987518..e2c5f6d0e7 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1895,6 +1895,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,


(we probably need a better name of this function, at least something 
like "memory_region_iommu_notify_one").


>   {
>       IOMMUNotifierFlag request_flags;
>       hwaddr entry_end = entry->iova + entry->addr_mask;
> +    IOMMUTLBEntry tmp = *entry;
>   
>       /*
>        * Skip the notification if the notification does not overlap
> @@ -1904,7 +1905,12 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>           return;
>       }
>   
> -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> +    if (notifier->notifier_flags & IOMMU_NOTIFIER_IOTLB) {
> +        tmp.iova = MAX(tmp.iova, notifier->start);
> +        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;


Any reason for doing such re-calculation here, a comment would be helpful.


> +    } else {
> +        assert(entry->iova >= notifier->start && entry_end <= notifier->end);


I wonder if it's better to convert the assert so some kind of log or 
warn here.

Thanks


> +    }
>   
>       if (entry->perm & IOMMU_RW) {
>           request_flags = IOMMU_NOTIFIER_MAP;
> @@ -1913,7 +1919,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>       }
>   
>       if (notifier->notifier_flags & request_flags) {
> -        notifier->notify(notifier, entry);
> +        notifier->notify(notifier, &tmp);
>       }
>   }
>   


