Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF341C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A4E212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A4E212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfOPH-000793-Om
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 08:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hfOOf-0006i8-UA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hfOOd-0004cI-4U
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hfOOY-0004R7-DO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:48:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E43033082E6E;
 Mon, 24 Jun 2019 12:48:19 +0000 (UTC)
Received: from [10.36.116.89] (ovpn-116-89.ams2.redhat.com [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0E61600D1;
 Mon, 24 Jun 2019 12:48:13 +0000 (UTC)
To: Peter Xu <peterx@redhat.com>
References: <20190624091811.30412-1-peterx@redhat.com>
 <20190624091811.30412-3-peterx@redhat.com>
 <b4e30868-dc87-99ee-0696-a796421b00fc@redhat.com>
 <20190624111013.GL6279@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6805f941-55b9-93d9-fbbf-a922e55b5cfe@redhat.com>
Date: Mon, 24 Jun 2019 14:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190624111013.GL6279@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 24 Jun 2019 12:48:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel_iommu: Fix unexpected unmaps
 during global unmap
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/24/19 1:10 PM, Peter Xu wrote:
> On Mon, Jun 24, 2019 at 12:09:48PM +0200, Auger Eric wrote:
>> Hi Peter,
>>
>> On 6/24/19 11:18 AM, Peter Xu wrote:
>>> This is an replacement work of Yan Zhao's patch:
>>>
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg625340.html
>>>
>>> vtd_address_space_unmap() will do proper page mask alignment to make
>>> sure each IOTLB message will have correct masks for notification
>>> messages (2^N-1), but sometimes it can be expanded to even supercede
>>> the registered range.  That could lead to unexpected UNMAP of already
>>> mapped regions in some other notifiers.
>>>
>>> Instead of doing mindless expension of the start address and address
>>> mask, we split the range into smaller ones and guarantee that each
>>> small range will have correct masks (2^N-1) and at the same time we
>>> should also try our best to generate as less IOTLB messages as
>>> possible.
>>>
>>> Reported-by: Yan Zhao <yan.y.zhao@intel.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  hw/i386/intel_iommu.c | 67 ++++++++++++++++++++++++++-----------------
>>>  1 file changed, 41 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 719ce19ab3..de86f53b4e 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -3363,11 +3363,28 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
>>>      return vtd_dev_as;
>>>  }
>>>  
>>> +static uint64_t get_naturally_aligned_size(uint64_t start,
>>> +                                           uint64_t size, int gaw)
>>> +{
>>> +    uint64_t max_mask = 1ULL << gaw;
>>> +    uint64_t alignment = start ? start & -start : max_mask;
>>> +
>>> +    alignment = MIN(alignment, max_mask);
>>> +    size = MIN(size, max_mask);
>> this does not not prevent from invalidating beyond gaw if start != 0, right?
> 
> Yes.  But at the start of vtd_address_space_unmap(), we have:
> 
>     if (end > VTD_ADDRESS_SIZE(s->aw_bits) - 1) {
>         /*
>          * Don't need to unmap regions that is bigger than the whole
>          * VT-d supported address space size
>          */
>         end = VTD_ADDRESS_SIZE(s->aw_bits) - 1;
>     }
> 
> So we don't need to worry about (start+size) exceeding GAW?
Hum yes. Reviewed the previous patch with blinkers ...
> 
> [1]
> 
>>> +
>>> +    if (alignment <= size) {
>>> +        /* Increase the alignment of start */
>> I don't really get this comment
> 
> This comment comes from Paolo, but I'll try to explain - it tries to
> mean that this "alignment" will be used as an increasement to "start"
> variable, so finally variable "start" will align with larger mask
> size.
> 
> Better comments welcomed... :)
smallest page mask from @start or gaw?
> 
>>> +        return alignment;
>>> +    } else {
>>> +        /* Find the largest page mask from size */
>>> +        return 1ULL << (63 - clz64(size));
>>> +    }> +}
>>> +
>>>  /* Unmap the whole range in the notifier's scope. */
>>>  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>>  {
>>> -    IOMMUTLBEntry entry;
>>> -    hwaddr size;
>>> +    hwaddr size, remain;
>>>      hwaddr start = n->start;
>>>      hwaddr end = n->end;
>>>      IntelIOMMUState *s = as->iommu_state;
>>> @@ -3388,39 +3405,37 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>>      }
>>>  
>>>      assert(start <= end);
>>> -    size = end - start;
>>> +    size = remain = end - start + 1;
>>>  
>>> -    if (ctpop64(size) != 1) {
>>> -        /*
>>> -         * This size cannot format a correct mask. Let's enlarge it to
>>> -         * suite the minimum available mask.
>>> -         */
>>> -        int n = 64 - clz64(size);
>>> -        if (n > s->aw_bits) {
>>> -            /* should not happen, but in case it happens, limit it */
>>> -            n = s->aw_bits;
>>> -        }
>>> -        size = 1ULL << n;
>>> +    while (remain >= VTD_PAGE_SIZE) {
>> Can't we stop as soon as entry.iova exceeds gaw as well?
> 
> As explained at [1], I think we've already checked it.
OK

Thanks

Eric
> 
> Thanks,
> 

