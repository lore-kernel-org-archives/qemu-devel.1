Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88ECC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14B2206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dwan+BCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14B2206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8KX2-0003sf-0X
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 05:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k8KWV-0003SW-QA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:36:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38823
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k8KWT-0002Am-D6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 05:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597829804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tci/d+Jte5XGSmRrz8dnJf3+Q4jRr5DU96FpGXouw78=;
 b=Dwan+BCsOiwHTC8K/hu7kzpjGHFzoCosyWOlRonZYmuj7RgJEcy0XfPMt58ntBBvn7EfWM
 MMeRlliibcBlMwXTrzTXlfuURRlZ/nVoF19JLzAUdVB7fPh9uBlp67NhNzF0Jr/bciy5gb
 xo31ZfBz+7Jwe8AaFhQMWGU6xMHfsSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-ATMcdHZmNsmCIXnthTtSxQ-1; Wed, 19 Aug 2020 05:36:40 -0400
X-MC-Unique: ATMcdHZmNsmCIXnthTtSxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84DB21005E72;
 Wed, 19 Aug 2020 09:36:39 +0000 (UTC)
Received: from [10.72.13.88] (ovpn-13-88.pek2.redhat.com [10.72.13.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA532100238C;
 Wed, 19 Aug 2020 09:36:23 +0000 (UTC)
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
 <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
 <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
 <CAJaqyWe+KgnVegtprpRmVvXo7kFVFDL_erK_5Nyp4K=gTUcN=Q@mail.gmail.com>
 <eb26c5d7-465a-34ed-3f8f-bad11eda5bee@redhat.com>
 <CAJaqyWfGx5T=DvGPq-ydvvYbNg_pRR35rXAT=Lz5nTaztQAV8g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <82ddcbc9-49e2-b192-6ff6-81d1b03e722b@redhat.com>
Date: Wed, 19 Aug 2020 17:36:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfGx5T=DvGPq-ydvvYbNg_pRR35rXAT=Lz5nTaztQAV8g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Avi Kivity <avi@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/8/19 下午4:22, Eugenio Perez Martin wrote:
> On Wed, Aug 19, 2020 at 9:15 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2020/8/18 下午10:24, Eugenio Perez Martin wrote:
>>> On Wed, Aug 12, 2020 at 10:49 AM Eugenio Perez Martin
>>> <eperezma@redhat.com>  wrote:
>>>> On Wed, Aug 12, 2020 at 4:24 AM Jason Wang<jasowang@redhat.com>  wrote:
>>>>> On 2020/8/12 上午1:55, Eugenio Pérez wrote:
>>>>>> Signed-off-by: Eugenio Pérez<eperezma@redhat.com>
>>>>>> ---
>>>>>>     hw/virtio/vhost.c     |  2 +-
>>>>>>     include/exec/memory.h |  2 ++
>>>>>>     softmmu/memory.c      | 10 ++++++++--
>>>>>>     3 files changed, 11 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>> index 1a1384e7a6..e74ad9e09b 100644
>>>>>> --- a/hw/virtio/vhost.c
>>>>>> +++ b/hw/virtio/vhost.c
>>>>>> @@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
>>>>>>         iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
>>>>>>                                                        MEMTXATTRS_UNSPECIFIED);
>>>>>>         iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
>>>>>> -                        IOMMU_NOTIFIER_UNMAP,
>>>>>> +                        IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_IOTLB,
>>>>> I think we can safely drop IOMMU_NOTIFIER_UNMAP here since device IOTLB
>>>>> is sufficient.
>>>>>
>>>>> Btw, IOMMU_NOTIFIER_IOTLB is kind of confusing, maybe something like
>>>>> IOMMU_NOTIFIER_DEVIOTLB.
>>>>>
>>>> Got it, will change.
>>>>
>>>>>>                             section->offset_within_region,
>>>>>>                             int128_get64(end),
>>>>>>                             iommu_idx);
>>>>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>>>>> index 307e527835..4d94c1e984 100644
>>>>>> --- a/include/exec/memory.h
>>>>>> +++ b/include/exec/memory.h
>>>>>> @@ -87,6 +87,8 @@ typedef enum {
>>>>>>         IOMMU_NOTIFIER_UNMAP = 0x1,
>>>>>>         /* Notify entry changes (newly created entries) */
>>>>>>         IOMMU_NOTIFIER_MAP = 0x2,
>>>>>> +    /* Notify changes on IOTLB entries */
>>>>>> +    IOMMU_NOTIFIER_IOTLB = 0x04,
>>>>>>     } IOMMUNotifierFlag;
>>>>>>
>>>>>>     #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
>>>>>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>>>>>> index af25987518..e2c5f6d0e7 100644
>>>>>> --- a/softmmu/memory.c
>>>>>> +++ b/softmmu/memory.c
>>>>>> @@ -1895,6 +1895,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>>>>> (we probably need a better name of this function, at least something
>>>>> like "memory_region_iommu_notify_one").
>>>>>
>>>> Ok will change.
>>>>
>>>>>>     {
>>>>>>         IOMMUNotifierFlag request_flags;
>>>>>>         hwaddr entry_end = entry->iova + entry->addr_mask;
>>>>>> +    IOMMUTLBEntry tmp = *entry;
>>>>>>
>>>>>>         /*
>>>>>>          * Skip the notification if the notification does not overlap
>>>>>> @@ -1904,7 +1905,12 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>>>>>>             return;
>>>>>>         }
>>>>>>
>>>>>> -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
>>>>>> +    if (notifier->notifier_flags & IOMMU_NOTIFIER_IOTLB) {
>>>>>> +        tmp.iova = MAX(tmp.iova, notifier->start);
>>>>>> +        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
>>>>> Any reason for doing such re-calculation here, a comment would be helpful.
>>>>>
>>>> It was proposed by Peter, but I understand as limiting the
>>>> address+range we pass to the notifier. Although vhost seems to support
>>>> it as long as it contains (notifier->start, notifier->end) in range, a
>>>> future notifier might not.
>>
>> Yes, actually, I feel confused after reading the codes. Is
>> notifier->start IOVA or GPA?
>>
>> In vfio.c, we did:
>>
>>           iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
>>                               IOMMU_NOTIFIER_ALL,
>>                               section->offset_within_region,
>>                               int128_get64(llend),
>>                               iommu_idx);
>>
>> So it looks to me the start and end are GPA, but the assertion above
>> check it against IOVA which seems to be wrong ....
>>
>> Thanks
>>
> I see.
>
> I didn't go so deep, I just assumed that:
> * all the addresses were GPA in the vhost-net+virtio-net case,
> although the name iova in IOMMUTLBEntry.
> * memory region was initialized with IOVA addresses in case of VFIO.


If there's no vIOMMU, IOVA = GPA, so we're fine. But if vIOMMU is 
enabled, IOVA allocation is done inside guest so the start/end here not 
IOVA anymore.


>
> Maybe the comment should warn about the bad "iova" name, if I'm right?
>
> I assumed that nothing changed in the VFIO case since its notifier has
> no IOMMU_NOTIFIER_DEVIOTLB flag and the new conditional in
> memory_region_notify_one_iommu, but I will test with a device
> passthrough and DPDK again. Do you think another test would be needed?


I'm not sure if it's easy, but it might be interesting to teach DPDK to 
use IOVA which is outside the range of [start, end] here.


>
> Maybe Peter can go deeper on this.


Yes, or wait for Peter's comment.

Thanks


>
> Thanks!
>
>>>> It could be done as iommu_entry_crop(IOMMUTLBEntry *entry, const
>>>> IOMMUNotifier *notifier) though.


