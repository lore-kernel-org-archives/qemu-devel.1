Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840BAC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 07:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B57D20702
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 07:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FX5cz7E+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B57D20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpRN0-0001Fs-GO
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 03:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jpRMF-0000nT-MU
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 03:04:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jpRMD-0002na-3h
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 03:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593327843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QI5FVSwcPaGuC/TggSFEiMJRkBRRfis06hWFupOlu1o=;
 b=FX5cz7E+xcWFZY8cHgOIgzR59wuaRbyRUZ8XBy7im3jQcUbG9T/u6Iy8Pwn0RWoc42BnFP
 gRSlpvsiU1jPOIKmL5DAKuwIU8dX7fs7eM7S4eH/kxyge5YVYRIVuvJY1aEzzfaA8EeNnj
 fW8SQIswU6VRiw/nAQPZIKAAIhVwK8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-9OFeyATLNDWwfK5J0ZPDgA-1; Sun, 28 Jun 2020 03:04:01 -0400
X-MC-Unique: 9OFeyATLNDWwfK5J0ZPDgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4D9E80183C;
 Sun, 28 Jun 2020 07:04:00 +0000 (UTC)
Received: from [10.72.13.164] (ovpn-13-164.pek2.redhat.com [10.72.13.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBE5C19D71;
 Sun, 28 Jun 2020 07:03:45 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com> <20200626212917.GD175520@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
Date: Sun, 28 Jun 2020 15:03:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626212917.GD175520@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 03:04:03
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/27 上午5:29, Peter Xu wrote:
> Hi, Eugenio,
>
> (CCing Eric, Yan and Michael too)
>
> On Fri, Jun 26, 2020 at 08:41:22AM +0200, Eugenio Pérez wrote:
>> diff --git a/memory.c b/memory.c
>> index 2f15a4b250..7f789710d2 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -1915,8 +1915,6 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>>           return;
>>       }
>>   
>> -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> I can understand removing the assertion should solve the issue, however imho
> the major issue is not about this single assertion but the whole addr_mask
> issue behind with virtio...


I don't get here, it looks to the the range was from guest IOMMU drivers.


>
> For normal IOTLB invalidations, we were trying our best to always make
> IOMMUTLBEntry contain a valid addr_mask to be 2**N-1.  E.g., that's what we're
> doing with the loop in vtd_address_space_unmap().


I'm sure such such assumption can work for any type of IOMMU.


>
> But this is not the first time that we may want to break this assumption for
> virtio so that we make the IOTLB a tuple of (start, len), then that len can be
> not a address mask any more.  That seems to be more efficient for things like
> vhost because iotlbs there are not page based, so it'll be inefficient if we
> always guarantee the addr_mask because it'll be quite a lot more roundtrips of
> the same range of invalidation.  Here we've encountered another issue of
> triggering the assertion with virtio-net, but only with the old RHEL7 guest.
>
> I'm thinking whether we can make the IOTLB invalidation configurable by
> specifying whether the backend of the notifier can handle arbitary address
> range in some way.  So we still have the guaranteed addr_masks by default
> (since I still don't think totally break the addr_mask restriction is wise...),
> however we can allow the special backends to take adavantage of using arbitary
> (start, len) ranges for reasons like performance.
>
> To do that, a quick idea is to introduce a flag IOMMU_NOTIFIER_ARBITRARY_MASK
> to IOMMUNotifierFlag, to declare that the iommu notifier (and its backend) can
> take arbitrary address mask, then it can be any value and finally becomes a
> length rather than an addr_mask.  Then for every iommu notify() we can directly
> deliver whatever we've got from the upper layer to this notifier.  With the new
> flag, vhost can do iommu_notifier_init() with UNMAP|ARBITRARY_MASK so it
> declares this capability.  Then no matter for device iotlb or normal iotlb, we
> skip the complicated procedure to split a big range into small ranges that are
> with strict addr_mask, but directly deliver the message to the iommu notifier.
> E.g., we can skip the loop in vtd_address_space_unmap() if the notifier is with
> ARBITRARY flag set.


I'm not sure coupling IOMMU capability to notifier is the best choice.

How about just convert to use a range [start, end] for any notifier and 
move the checks (e.g the assert) into the actual notifier implemented 
(vhost or vfio)?

Thanks


>
> Then, the assert() is not accurate either, and may become something like:
>
> diff --git a/memory.c b/memory.c
> index 2f15a4b250..99d0492509 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1906,6 +1906,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>   {
>       IOMMUNotifierFlag request_flags;
>       hwaddr entry_end = entry->iova + entry->addr_mask;
> +    IOMMUTLBEntry tmp = *entry;
>
>       /*
>        * Skip the notification if the notification does not overlap
> @@ -1915,7 +1916,13 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>           return;
>       }
>
> -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> +    if (notifier->notifier_flags & IOMMU_NOTIFIER_ARBITRARY_MASK) {
> +        tmp.iova = MAX(tmp.iova, notifier->start);
> +        tmp.addr_mask = MIN(tmp.addr_mask, notifier->end);
> +        assert(tmp.iova <= tmp.addr_mask);
> +    } else {
> +        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> +    }
>
>       if (entry->perm & IOMMU_RW) {
>           request_flags = IOMMU_NOTIFIER_MAP;
> @@ -1924,7 +1931,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>       }
>
>       if (notifier->notifier_flags & request_flags) {
> -        notifier->notify(notifier, entry);
> +        notifier->notify(notifier, &tmp);
>       }
>   }
>
> Then we can keep the assert() for e.g. vfio, however vhost can skip it and even
> get some further performance boosts..  Does that make sense?
>
> Thanks,
>


