Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC93BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9322206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3sqBrfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9322206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbA6p-0001Ez-RT
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbA68-00005B-L7
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:48:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54023
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbA66-00027s-MA
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589924905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wm2PGRPfsXy3oIfQob7uh+dRoMg1Ac1rU9eY0gVbnFo=;
 b=D3sqBrfAxRXxtWNb79a1+0yqFpIhdxctPB1x3nbPbH0xLdzNAsl+PbDpCe9F1C1a5EqbPx
 5LODzBcmbClgFOlM6Q/sA8piyjZgOG5Dtj2ZznYLZAimbP2nPETBfBVLeTkyxc/DFFQmWV
 LcAQdIebLeYf3Zewuxcu/dcKhnPeSog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-E6epcO7FMp-WCa_g64Qu6g-1; Tue, 19 May 2020 17:48:19 -0400
X-MC-Unique: E6epcO7FMp-WCa_g64Qu6g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18319EC1A0;
 Tue, 19 May 2020 21:48:18 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA6625C1C5;
 Tue, 19 May 2020 21:48:14 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] block/io: fix bdrv_co_block_status_above
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
 <20200519195501.29071-2-vsementsov@virtuozzo.com>
 <cd4c3996-703a-13c5-aa9c-664d2de0ca26@redhat.com>
 <3a66bacf-3462-a82c-c758-730107e75898@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <711cc70d-bc12-9fda-b24c-7b3acdd5cb08@redhat.com>
Date: Tue, 19 May 2020 16:48:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3a66bacf-3462-a82c-c758-730107e75898@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 4:13 PM, Vladimir Sementsov-Ogievskiy wrote:
> 19.05.2020 23:41, Eric Blake wrote:
>> On 5/19/20 2:54 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> bdrv_co_block_status_above has several problems with handling short
>>> backing files:
>>>
>>> 1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
>>> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
>>> which produces these after-EOF zeros is inside requested backing
>>> sequence.
>>
>> That's intentional.  That portion of the guest-visible data reads as 
>> zero (BDRV_BLOCK_ZERO set) but was NOT read from the top layer, but 
>> rather synthesized by the block layer because it derived from the 
>> backing file but was beyond EOF of that backing layer 
>> (BDRV_BLOCK_ALLOCATED is clear).
> 
> Not in top yes. But _inside_ the requested base..top backing-chain-part. 
> So it should be considered ALLOCATED, as we should not go to further 
> backing.

Yes, I think I figured that out by patch 5.

> 
> Assume the following chain:
> 
> top    aa--
> middle bb
> base   xxxx
> 
> (so, middle is short)
> 
> block_status(top, 2) should return ZERO without ALLOCATED, as yes it's 
> ZERO and yes, it's from another layer
> 
> block_status_above(top, base, 2) should return ZERO with ALLOCATED, as 
> it's ZERO, and it's produced inside requested backing-chain-region, 
> actually, it's produced because of short middle node. We must report 
> ALLOCATED to show that we are not going to read from base.

Yes, that matches my intuition.  allocated_above says "where in the 
chain did we get the data, since it did not come from top", and the 
correct answer is "we got it from middle, due to synthesizing zero 
beyond EOF".  Okay, with that understanding in place, maybe this patch 
is right.  But I'll have to revisit it tomorrow on a fresh mind (it's 
too late in the day for me to be sure that I'm getting it all straight 
right now).

> 
>>
>>>
>>> 2. With want_zero=false, it may return pnum=0 prior to actual EOF,
>>> because of EOF of short backing file.
>>
>> Do you have a reproducer for this?
> 
> No, I don't have one, but it seems possible at least with 
> want_zero=false. I'll think of it tomorrow, too tired now.
> 
>> In my experience, this is not possible.  Generally, if you request 
>> status that overlaps EOF of the backing, you get a response truncated 
>> to the end of the backing, and you are then likely to follow up with a 
>> subsequent status request starting from the underlying EOF which then 
>> sees the desired unallocated zeroes:
>>
>> back     xxxx
>> top      yy------
>> request    ^^^^^^
>> response   ^^
>> request      ^^^^
>> response     ^^^^

If we can come up with a reproducer where allocated_above returns 
pnum=0, that would indeed prove my initial hesitation wrong (perhaps by:

back    xxxxxxxx
mid1    xxxxxx
mid2    xxxx
mid3    xxxxxx
top     xxxxxxxx

for various different start and base points within the chain?)

>>
>>>
>>> Fix these things, making logic about short backing files clearer.
>>>
>>> Note that 154 output changed, because now bdrv_block_status_above don't
>>
>> doesn't
>>
>>> merge unallocated zeros with zeros after EOF (which are actually
>>> "allocated" in POV of read from backing-chain top) and is_zero() just
>>> don't understand that the whole head or tail is zero. We may update
>>> is_zero to call bdrv_block_status_above several times, or add flag to
>>> bdrv_block_status_above that we are not interested in ALLOCATED flag,
>>> so ranges with different ALLOCATED status may be merged, but actually,
>>> it seems that we'd better don't care about this corner case.
>>
>> This actually sounds like an avoidable regression.  :(
> 
> I don't see real problem in it. But it seems not hard to avoid it, so I 
> will try to.

I guess my real reasoning is: "I spent a lot of time trying to tweak 
that test to not lose the fact that the tail of the image reads as 
zero", because it looks weird if we later resize the image but still 
have a glitch in the middle reporting one non-zero cluster out of a 
larger range all because of the shenanigans that occurred around the 
tail prior to resizing.

>>> +++ b/block/io.c
>>> @@ -2461,25 +2461,45 @@ static int coroutine_fn 
>>> bdrv_co_block_status_above(BlockDriverState *bs,
>>>           ret = bdrv_co_block_status(p, want_zero, offset, bytes, 
>>> pnum, map,
>>>                                      file);
>>>           if (ret < 0) {
>>> -            break;
>>> +            return ret;
>>>           }
>>> -        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
>>> +        if (*pnum == 0) {
>>> +            if (first) {
>>> +                return ret;
>>> +            }
>>> +
>>>               /*
>>> -             * Reading beyond the end of the file continues to read
>>> -             * zeroes, but we can only widen the result to the
>>> -             * unallocated length we learned from an earlier
>>> -             * iteration.
>>> +             * Reads from bs for the selected region will return 
>>> zeroes,
>>> +             * produced because the current level is short. We 
>>> should consider
>>> +             * it as allocated.
>>
>> Why?  If we replaced the backing file to something longer (qemu-img 
>> rebase -u), we would WANT to read from the backing file.  The only 
>> reason we read zero is because the block layer synthesized it _while_ 
>> deferring to the backing layer, not because it was directly allocated 
>> in the top layer.
> 
> No, if we replace backing file of the current layer, nothing will 
> change, as _this_ layer is short, not the backing. Or which backing file 
> do you mean? If you mean current bs, than replacing it doesn't make 
> sense in the context, as block_status_above requested the current bs (as 
> part of base..top range), not the other one.

Maybe it's just the comment wording that needs help.  After reading 
through patch 5, it looks like my problem is now coming up with a 
comment to the effect of "the top layer deferred to this layer, and 
because this layer is short, any zeroes that we synthesize beyond EOF 
behave as if they were allocated at this layer".

> 
>>
>>> +             *
>>> +             * TODO: Should we report p as file here?
>>
>> No. Reporting 'file' only makes sense if you can point to an offset 
>> within that file that would read the guest-visible data in question - 
>> but when the data is synthesized, there is no such offset.
> 
> I don't know. It still adds some information about which level is 
> responsible for these ZEROES. Kevin argued that it make sense.

It took me a while, but I'm coming around to it: my initial read was 
assuming that you were reporting that the tail was being claimed as 
allocated by top; but in reality, you are fixing things to claim it as 
being allocated by mid.  The former is wrong (top did not allocate, it 
deferred to mid); but the latter does indeed make sense (reading from 
mid ended up synthesizing, which means that our hunt for the data ends 
at mid and we never traverse deeper, regardless of whether base may also 
have data).  But now it's a question of whether the code matches that 
textual description, and I'm a bit too fried to answer that question 
properly today :)

>>> +++ b/tests/qemu-iotests/154.out
>>> @@ -310,13 +310,13 @@ wrote 512/512 bytes at offset 134217728
>>>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>   2048/2048 bytes allocated at offset 128 MiB
>>>   [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, 
>>> "data": false},
>>> -{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, 
>>> "data": false}]
>>> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, 
>>> "data": true, "offset": OFFSET}]
>>
>> The fact that we no longer see zeroes in the tail of the file makes me 
>> think this patch is wrong.

So, if we can avoid that minor regression, and still otherwise report 
zeroes as allocated from mid, then I think we'll be on the right track.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


