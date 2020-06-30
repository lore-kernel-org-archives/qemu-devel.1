Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE53C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 02:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7595A20760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 02:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eD1SVNyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7595A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq6Do-0001UG-Pk
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 22:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jq6DG-000141-5X
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 22:41:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jq6DD-00019T-8E
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 22:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593484889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwhYGfMvjCAVCl8R8KWtpgRWtfhjIf7UdEB0VYmCfX0=;
 b=eD1SVNyLwSvhTaimGoyVlxSmGmH+wYMFMWrsiKnvNsUK/iLYU2uBK7dfUqBHfaLNqIJQlA
 CG7klIbxKkbG47fOS6ybjN/vlv7Tq3a7JwoLa74Am7/JYWusYZ/kAZVl+jDpi8zpPGwmPp
 ZG2rkSjcoxOsOYhOySgUsVhi9KmUmE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-gVI60DzaPNKRzZTdUO6OFQ-1; Mon, 29 Jun 2020 22:41:25 -0400
X-MC-Unique: gVI60DzaPNKRzZTdUO6OFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A22219200C0;
 Tue, 30 Jun 2020 02:41:24 +0000 (UTC)
Received: from [10.72.13.159] (ovpn-13-159.pek2.redhat.com [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2AB01001B07;
 Tue, 30 Jun 2020 02:41:11 +0000 (UTC)
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200626064122.9252-2-eperezma@redhat.com> <20200626212917.GD175520@xz-x1>
 <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
Date: Tue, 30 Jun 2020 10:41:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629133403.GA266532@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 19:44:14
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
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/29 下午9:34, Peter Xu wrote:
> On Mon, Jun 29, 2020 at 01:51:47PM +0800, Jason Wang wrote:
>> On 2020/6/28 下午10:47, Peter Xu wrote:
>>> On Sun, Jun 28, 2020 at 03:03:41PM +0800, Jason Wang wrote:
>>>> On 2020/6/27 上午5:29, Peter Xu wrote:
>>>>> Hi, Eugenio,
>>>>>
>>>>> (CCing Eric, Yan and Michael too)
>>>>>
>>>>> On Fri, Jun 26, 2020 at 08:41:22AM +0200, Eugenio Pérez wrote:
>>>>>> diff --git a/memory.c b/memory.c
>>>>>> index 2f15a4b250..7f789710d2 100644
>>>>>> --- a/memory.c
>>>>>> +++ b/memory.c
>>>>>> @@ -1915,8 +1915,6 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
>>>>>>             return;
>>>>>>         }
>>>>>> -    assert(entry->iova >= notifier->start && entry_end <= notifier->end);
>>>>> I can understand removing the assertion should solve the issue, however imho
>>>>> the major issue is not about this single assertion but the whole addr_mask
>>>>> issue behind with virtio...
>>>> I don't get here, it looks to the the range was from guest IOMMU drivers.
>>> Yes.  Note that I didn't mean that it's a problem in virtio, it's just the fact
>>> that virtio is the only one I know that would like to support arbitrary address
>>> range for the translated region.  I don't know about tcg, but vfio should still
>>> need some kind of page alignment in both the address and the addr_mask.  We
>>> have that assumption too across the memory core when we do translations.
>>
>> Right but it looks to me the issue is not the alignment.
>>
>>
>>> A further cause of the issue is the MSI region when vIOMMU enabled - currently
>>> we implemented the interrupt region using another memory region so it split the
>>> whole DMA region into two parts.  That's really a clean approach to IR
>>> implementation, however that's also a burden to the invalidation part because
>>> then we'll need to handle things like this when the listened range is not page
>>> alighed at all (neither 0-0xfedffff, nor 0xfef0000-MAX).  If without the IR
>>> region (so the whole iommu address range will be a single FlatRange),
>>
>> Is this a bug? I remember that at least for vtd, it won't do any DMAR on the
>> intrrupt address range
> I don't think it's a bug, at least it's working as how I understand...  that
> interrupt range is using an IR region, that's why I said the IR region splits
> the DMAR region into two pieces, so we have two FlatRange for the same
> IOMMUMemoryRegion.


I don't check the qemu code but if "a single FlatRange" means 
0xFEEx_xxxx is subject to DMA remapping, OS need to setup passthrough 
mapping for that range in order to get MSI to work. This is not what vtd 
spec said:

"""

3.14 Handling Requests to Interrupt Address Range

Requests without PASID to address range 0xFEEx_xxxx are treated as
potential interrupt requests and are not subjected to DMA remapping
(even if translation structures specify a mapping for this
range). Instead, remapping hardware can be enabled to subject such
interrupt requests to interrupt remapping.

"""

My understanding is vtd won't do any DMA translation on 0xFEEx_xxxx even 
if IR is not enabled.


>
>>
>>>    I think
>>> we probably don't need most of the logic in vtd_address_space_unmap() at all,
>>> then we can directly deliver all the IOTLB invalidations without splitting into
>>> small page aligned ranges to all the iommu notifiers.  Sadly, so far I still
>>> don't have ideal solution for it, because we definitely need IR.
>>
>> Another possible (theoretical) issue (for vhost) is that it can't trigger
>> interrupt through the interrupt range.
> Hmm.. Could you explain?  When IR is enabled, all devices including virtio
> who send interrupt to 0xfeeXXXXX should be trapped by IR.


I meant vhost not virtio, if you teach vhost to DMA to 0xFEEx_xxxx, it 
can't generate any interrupts as expected.


>
>>
>>>>> For normal IOTLB invalidations, we were trying our best to always make
>>>>> IOMMUTLBEntry contain a valid addr_mask to be 2**N-1.  E.g., that's what we're
>>>>> doing with the loop in vtd_address_space_unmap().
>>>> I'm sure such such assumption can work for any type of IOMMU.
>>>>
>>>>
>>>>> But this is not the first time that we may want to break this assumption for
>>>>> virtio so that we make the IOTLB a tuple of (start, len), then that len can be
>>>>> not a address mask any more.  That seems to be more efficient for things like
>>>>> vhost because iotlbs there are not page based, so it'll be inefficient if we
>>>>> always guarantee the addr_mask because it'll be quite a lot more roundtrips of
>>>>> the same range of invalidation.  Here we've encountered another issue of
>>>>> triggering the assertion with virtio-net, but only with the old RHEL7 guest.
>>>>>
>>>>> I'm thinking whether we can make the IOTLB invalidation configurable by
>>>>> specifying whether the backend of the notifier can handle arbitary address
>>>>> range in some way.  So we still have the guaranteed addr_masks by default
>>>>> (since I still don't think totally break the addr_mask restriction is wise...),
>>>>> however we can allow the special backends to take adavantage of using arbitary
>>>>> (start, len) ranges for reasons like performance.
>>>>>
>>>>> To do that, a quick idea is to introduce a flag IOMMU_NOTIFIER_ARBITRARY_MASK
>>>>> to IOMMUNotifierFlag, to declare that the iommu notifier (and its backend) can
>>>>> take arbitrary address mask, then it can be any value and finally becomes a
>>>>> length rather than an addr_mask.  Then for every iommu notify() we can directly
>>>>> deliver whatever we've got from the upper layer to this notifier.  With the new
>>>>> flag, vhost can do iommu_notifier_init() with UNMAP|ARBITRARY_MASK so it
>>>>> declares this capability.  Then no matter for device iotlb or normal iotlb, we
>>>>> skip the complicated procedure to split a big range into small ranges that are
>>>>> with strict addr_mask, but directly deliver the message to the iommu notifier.
>>>>> E.g., we can skip the loop in vtd_address_space_unmap() if the notifier is with
>>>>> ARBITRARY flag set.
>>>> I'm not sure coupling IOMMU capability to notifier is the best choice.
>>> IMHO it's not an IOMMU capability.  The flag I wanted to introduce is a
>>> capability of the one who listens to the IOMMU TLB updates.  For our case, it's
>>> virtio/vhost's capability to allow arbitrary length. The IOMMU itself
>>> definitely has some limitation on the address range to be bound to an IOTLB
>>> invalidation, e.g., the device-iotlb we're talking here only accept both the
>>> iova address and addr_mask to be aligned to 2**N-1.
>>
>> I think this go back to one of our previous discussion of whether to
>> introduce a dedicated notifiers for device IOTLB.
>>
>> For IOMMU, it might have limitation like GAW, but for device IOTLB it
>> probably doesn't. That's the reason we hit the assert here.
> I feel like even for hardware it shouldn't be arbitrary either,


Yes, but from the view of IOMMU, it's hard to know about that. Allowing 
[0, ~0ULL] looks sane.


>   because the
> device iotlb sent from at least vt-d driver is very restricted too (borrowing
> the comment you wrote :):
>
>      /* According to ATS spec table 2.4:
>       * S = 0, bits 15:12 = xxxx     range size: 4K
>       * S = 1, bits 15:12 = xxx0     range size: 8K
>       * S = 1, bits 15:12 = xx01     range size: 16K
>       * S = 1, bits 15:12 = x011     range size: 32K
>       * S = 1, bits 15:12 = 0111     range size: 64K
>       * ...
>       */


Right, but the comment is probably misleading here, since it's for the 
PCI-E transaction between IOMMU and device not for the device IOTLB 
invalidation descriptor.

For device IOTLB invalidation descriptor, spec allows a [0, ~0ULL] 
invalidation:

"

6.5.2.5 Device-TLB Invalidate Descriptor

...

Size (S): The size field indicates the number of consecutive pages 
targeted by this invalidation
request. If S field is zero, a single page at page address specified by 
Address [63:12] is requested
to be invalidated. If S field is Set, the least significant bit in the 
Address field with value 0b
indicates the invalidation address range. For example, if S field is Set 
and Address[12] is Clear, it
indicates an 8KB invalidation address range with base address in Address 
[63:13]. If S field and
Address[12] is Set and bit 13 is Clear, it indicates a 16KB invalidation 
address range with base
address in Address [63:14], etc.

"

So if we receive an address whose [63] is 0 and the rest is all 1, it's 
then a [0, ~0ULL] invalidation.


>
>>
>>>> How about just convert to use a range [start, end] for any notifier and move
>>>> the checks (e.g the assert) into the actual notifier implemented (vhost or
>>>> vfio)?
>>> IOMMUTLBEntry itself is the abstraction layer of TLB entry.  Hardware TLB entry
>>> is definitely not arbitrary range either (because AFAICT the hardware should
>>> only cache PFN rather than address, so at least PAGE_SIZE aligned).
>>> Introducing this flag will already make this trickier just to avoid introducing
>>> another similar struct to IOMMUTLBEntry, but I really don't want to make it a
>>> default option...  Not to mention I probably have no reason to urge the rest
>>> iommu notifier users (tcg, vfio) to change their existing good code to suite
>>> any of the backend who can cooperate with arbitrary address ranges...
>>
>> Ok, so it looks like we need a dedicated notifiers to device IOTLB.
> Or we can also make a new flag for device iotlb just like current UNMAP? Then
> we replace the vhost type from UNMAP to DEVICE_IOTLB.  But IMHO using the
> ARBITRARY_LENGTH flag would work in a similar way.  DEVICE_IOTLB flag could
> also allow virtio/vhost to only receive one invalidation (now IIUC it'll
> receive both iotlb and device-iotlb for unmapping a page when ats=on), but then
> ats=on will be a must and it could break some old (misconfiged) qemu because
> afaict previously virtio/vhost could even work with vIOMMU (accidentally) even
> without ats=on.


That's a bug and I don't think we need to workaround mis-configurated 
qemu :)

Thanks


>
> Thanks,
>


