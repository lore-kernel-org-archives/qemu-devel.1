Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF7DC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63E520753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbQ0eW/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63E520753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMb6R-0001Rj-TK
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jMb5b-00010v-1E
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jMb5Z-0001c4-2M
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:35:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jMb5Y-0001bN-SE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586453740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OLblz96jqc+OgmrzEiUnQJCkMsa2rNWlBRAEGoRX+yU=;
 b=CbQ0eW/yKn+S+skocy3OvV3srQujXCpm+13HkhSJ6IDXqOiX+nY1+2VR5Fu9TiT4I4f1XI
 0d6KD2M9OL0h6cDa6VgOcolpBG9MCNGguPymQ1whZo/yZooXMkaVtr1VX4Xi0uDu/IUQwT
 LP3Rtky2daAhumed+zbDcAyKO0XjfLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-WjTE46HuMNervEG4Rz3swg-1; Thu, 09 Apr 2020 13:35:38 -0400
X-MC-Unique: WjTE46HuMNervEG4Rz3swg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D698017FE;
 Thu,  9 Apr 2020 17:35:37 +0000 (UTC)
Received: from [10.36.113.222] (ovpn-113-222.ams2.redhat.com [10.36.113.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54F8952735;
 Thu,  9 Apr 2020 17:35:33 +0000 (UTC)
Subject: Re: [PATCH v18 QEMU 3/3] virtio-balloon: Provide a interface for free
 page reporting
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <20200408225302.18764.209.stgit@localhost.localdomain>
 <20200408225529.18764.44086.stgit@localhost.localdomain>
 <06ac44b9-77ae-7686-8a65-7edff2cbf1b7@redhat.com>
 <CAKgT0UdLRKyc47izJO-rukHmj4cWP1xOzrxBv1ZX4yF92nH8Kg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <987022c8-3aed-dccb-df02-d834500c04d3@redhat.com>
Date: Thu, 9 Apr 2020 19:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdLRKyc47izJO-rukHmj4cWP1xOzrxBv1ZX4yF92nH8Kg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.04.20 19:34, Alexander Duyck wrote:
> On Thu, Apr 9, 2020 at 12:44 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 09.04.20 00:55, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> Add support for what I am referring to as "free page reporting".
>>
>> "Add support for "free page reporting".
>>
>>> Basically the idea is to function very similar to how the balloon works
>>> in that we basically end up madvising the page as not being used. However
>>
>> I'd get rid of one "basically".
>>
>>> we don't really need to bother with any deflate type logic since the page
>>> will be faulted back into the guest when it is read or written to.
>>>
>>> This is meant to be a simplification of the existing balloon interface
>>> to use for providing hints to what memory needs to be freed. I am assuming
>>
>> It's not really a simplification, it's something new. It's a new way of
>> letting the guest automatically report free pages to the hypervisor, so
>> the hypervisor can reuse them. In contrast to inflate/deflate, that's
>> triggered via the hypervisor explicitly.
>>
>>> this is safe to do as the deflate logic does not actually appear to do very
>>> much other than tracking what subpages have been released and which ones
>>> haven't.
>>
>> "I assume this is safe" does not sound very confident. Can we just drop
>> the last sentence?
> 
> Agreed. I will make the requested changes to the patch description.
> 
>>
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>>  hw/virtio/virtio-balloon.c         |   48 +++++++++++++++++++++++++++++++++++-
>>>  include/hw/virtio/virtio-balloon.h |    2 +-
>>>  2 files changed, 47 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index 1c6d36a29a04..297b267198ac 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -321,6 +321,42 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>>>      balloon_stats_change_timer(s, 0);
>>>  }
>>>
>>> +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
>>> +{
>>> +    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
>>> +    VirtQueueElement *elem;
>>> +
>>> +    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
>>> +        unsigned int i;
>>> +
>>> +        for (i = 0; i < elem->in_num; i++) {
>>> +            void *addr = elem->in_sg[i].iov_base;
>>> +            size_t size = elem->in_sg[i].iov_len;
>>> +            ram_addr_t ram_offset;
>>> +            size_t rb_page_size;
>>> +            RAMBlock *rb;
>>> +
>>> +            if (qemu_balloon_is_inhibited() || dev->poison_val) {
>>> +                continue;
>>> +            }
>>
>> These checks are not sufficient. See virtio_balloon_handle_output(),
>> where we e.g., check that somebody doesn't try to discard the bios.
>>
>> Maybe we can factor our/unify the handling in both code paths.
> 
> I am going to have to look at this further. If I understand correctly
> you are asking me to add all of the memory section checks that are in
> virtio_balloon_handle_output correct?
> 
> I'm not sure it makes sense with the scatterlist approach I have taken
> here. All of the mappings were created as a scatterlist of writable
> DMA mappings unlike the regular balloon which is just stuffing PFN
> numbers into an array and then sending the array across. As such I
> would think there are already such protections in place. For instance,
> you wouldn't want to let virtio-net map the BIOS and request data be
> written into that either, correct? So I am assuming there is something
> there to prevent that already isn't there?

Good point, let's find out :)


-- 
Thanks,

David / dhildenb


