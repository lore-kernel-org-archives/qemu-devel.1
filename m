Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A18C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86B8207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3pBY3Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86B8207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVA5-0005Ya-RT
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDV9M-0004I8-H5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDV9I-0006m4-Ig
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599062291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnEZPwwFTE7QQHln0FXz2F6oEzing58SDWSEsXsa8sU=;
 b=d3pBY3Ti6qL95sMJrvoqitwQaBMzwC8KJZh2qWNvFsah+o2giz16X75mqNbsuS2CoSZ85w
 4oyeqk9OKr9TfKRt7Dj1Xb6pJd5KPH6hEFM6NdQL0xIKWwk8hU6QkWRDcK2rcys5KOA58a
 hF0qrZZnGUOdg7NrPi1nLw1DWdmj8Kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-aSwxJlKqPUe6JU6T06NJcw-1; Wed, 02 Sep 2020 11:58:03 -0400
X-MC-Unique: aSwxJlKqPUe6JU6T06NJcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEDB2801AB4;
 Wed,  2 Sep 2020 15:58:02 +0000 (UTC)
Received: from [10.3.113.128] (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 539EF5C1C4;
 Wed,  2 Sep 2020 15:58:02 +0000 (UTC)
Subject: Re: [PATCH v3 1/6] block: add bitmap-populate job
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200619195621.58740-1-eblake@redhat.com>
 <20200619195621.58740-2-eblake@redhat.com>
 <074b3859-a6e1-1388-2142-5a7af8ee3fdb@virtuozzo.com>
 <74dc0ce7-2c0e-c987-cbc8-398d2c23f21a@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f1d44c06-5c79-ba04-46ad-5a2ee5a3002c@redhat.com>
Date: Wed, 2 Sep 2020 10:58:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <74dc0ce7-2c0e-c987-cbc8-398d2c23f21a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[reviving an old thread]

On 6/22/20 4:44 PM, Eric Blake wrote:
> On 6/19/20 11:16 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 19.06.2020 22:56, Eric Blake wrote:
>>> From: John Snow <jsnow@redhat.com>
>>>
>>> This job copies the allocation map into a bitmap. It's a job because
>>> there's no guarantee that allocation interrogation will be quick (or
>>> won't hang), so it cannot be retrofitted into block-dirty-bitmap-merge.
>>>
>>> It was designed with different possible population patterns in mind,
>>> but only top layer allocation was implemented for now.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
> 
>>> +{ 'struct': 'BlockDirtyBitmapPopulate',
>>> +  'base': 'BlockDirtyBitmap',
>>> +  'data': { 'job-id': 'str',
>>> +            'pattern': 'BitmapPattern',

As written, "pattern":"allocate-top" is rather limited - it can only 
grab allocation from the top node.  Being able to grab the allocation 
from a specific node may indeed be more useful.  Another bitmap patterns 
that might be useful would be an all-one pattern (create a bitmap that 
treats the entire disk as dirty).  I also remember brainstorming with 
John the question of whether we want bitmap-populate to have different 
mask modes: does the population perform an overwrite (the bitmap now 
matches the source pattern exactly, even if some bits were set and 
others cleared), a union merge (any bits already set in the bitmap 
remain set, additional bits are set according to pattern), or even a 
difference (any bits already cleared in the bitmap remain clear, while 
bits in the pattern can also clear additional bits in the bitmap).

If I understand Peter's goals, the initial libvirt use is a union mode 
(keep bits in the bitmap that are already set, but set additional bits 
according to the population pattern).

>>> +            '*on-error': 'BlockdevOnError',
>>> +            '*auto-finalize': 'bool',
>>> +            '*auto-dismiss': 'bool' } }
>>> +
>>
>> Peter said about a possibility of populating several target bitmaps 
>> simultaneously.
>>
>> What about such a generalized semantics:
>>
>> Merge all sources to each target
>>
>> @targets: list of bitmaps to be populated by the job
>> { 'struct': 'BlockDirtyBitmapPopulate',
>>    'data': { <common job fields>,
>>              'targets': ['BlockDirtyBitmap'],
>>              'sources': ['BitmapPopulateSource'] } }
> 
> We still need the 'pattern' argument (the idea being that if we have: 
> Base <- Active, we want to be able to merge in the allocation map of 
> Active into bitmaps stored in Base as part of a commit operation, 
> whether that is active commit of a live guest or offline commit while 
> the guest is offline).  Having an array for 'targets' to merge into is 
> fine, but for 'sources', it's less a concern about selecting from 
> multiple sources, and more a concern about selecting the allocation 
> pattern to be merged in (libvirt wants to merge the same allocation 
> pattern into each bitmap in Base).  Generalizing things to allow the 
> merge of more than one source at once might not hurt, but I'm not sure 
> we need it yet.

But when it comes to multiple destinations or multiple sources, while it 
seems like it might be a convenience factor, I also worry that it is 
over-engineering.  See more below...

> 
> But there are other patterns that we may want to support: an all-ones 
> pattern, or maybe a pattern that tracks known-zeros instead of allocation.
> 
>>
>>
>> @bitmap: specify dirty bitmap to be merged to target bitamp(s)
>> @node: specify a node name, which allocation-map is to be merged to 
>> target bitmap(s)
>> { 'alternate': 'BitmapPopulateSource',
>>    'data': { 'bitmap': 'BlockDirtyBitmap',
>>              'node': 'str' } }
> 
> This design is clever in that it lets us merge in both existing bitmaps 
> and using a node-name for merging in an allocation map instead of a 
> bitmap; but it limits us to only one pattern.  Better might be something 
> where we supply a union (hmm, we've had proposals in the past for a 
> default value to the discriminator to allow it to be optional, so I'll 
> proceed as if we will finally implement that):
> 
> { 'enum': 'BitmapPattern', 'data': [ 'bitmap', 'allocation-top' ] }
> { 'union': 'BitmapPopulateSource',
>    'base': { '*pattern': 'BitmapPattern' },
>    'discriminator': { 'name': 'pattern', 'default': 'bitmap' },
>    'data': { 'bitmap': 'BitmapPopulateSource',
>              'allocation-top': { 'node': 'str' } } }
> 
> so that you can then do:
> 
> { "execute": "block-dirty-bitmap-populate",
>    "arguments": { "targets": [ { "node": "base", "name": "b1" },
>                                { "node": "base", "name": "b2" } ],
>          "sources": [ { "pattern": "allocation-top", "node": "top" } ]
>    } }
> 
> to merge in the allocation information of top into multiple bitmaps of 
> base at once,

Hmm, I left out the mandatory "job-id" parameter here; one of the key 
points of the new command is that some patterns (like allocation) may 
involve potentially lengthy I/O, so we need a job-id (the existing 
block-dirty-bitmap-merge does not).  But since the existing 
block-dirty-bitmap-merge supports multiple sources to one destination, 
supporting multiple patterns to one destination tracked by a single job 
id does have some appeal.

> or conversely, do:
> 
> { "execute": "block-dirty-bitmap-populate",
>    "arguments": { "targets": [ { "node": "base", "name": "b1" } ],
>          "sources": [ { "pattern": "bitmap",
>                         "node": "top", "name": "b1" } ]
>    } }
> { "execute": "block-dirty-bitmap-populate",
>    "arguments": { "targets": [ { "node": "base", "name": "b2" } ],
>          "sources": [ { "node": "top", "name": "b2" } ]
>    } }
> 
> and of course, wrap this in a "transaction" to ensure that it all 
> succeeds or fails as a unit, rather than messing up one bitmap if 
> another fails, while also allowing future extension for additional 
> patterns.

We already have transactions that let us perform multiple destinations 
as a group.  So what is the difference in the end results between 
merging one source into two separate destinations in one command spelled 
this way:

# proposal with many:many bitmap populate
{ "execute": "block-dirty-bitmap-populate",
   "arguments": { "job-id": "job0",
                  "targets": [ { "node": "base", "name": "b1" },
                               { "node": "base", "name": "b2" } ],
                  "source": { "pattern": "allocation", "node": "top" } } }
wait for job to complete

vs. spelled this way:

# patch as written with 1:1 bitmap-populate, but tweak to source
{ "execute": "block-dirty-bitmap-add",
   "arguments": { "node": "top", "name": "tmp" } }
{ "execute": "block-dirty-bitmap-populate",
   "arguments": { "job-id": "job0",
                  "node": "top", "name": "tmp",
                  "source": { "pattern": "allocation", "node": "top" } } }
wait for job to complete
{ "execute": "transaction",
   "arguments": { "actions": [
     { "type": "block-dirty-bitmap-merge", "node": "base", "name": "b1",
         "bitmaps": [ { "node": "top", "name": "tmp" } ] },
     { "type": "block-dirty-bitmap-merge", "node": "base", "name": "b2",
         "bitmaps": [ { "node": "top", "name": "tmp" } ] }
] } }



> 
>>
>>
>> - so, we can merge several bitmaps together with several allocation 
>> maps into several target bitmaps.
>> (I remember, we also said about a possibility of starting several 
>> populating jobs, populating into
>>   same bitmap, I think it may be substituted by one job with several 
>> sources. Still, it's not hard to
>>   allow to use target bitmaps in a several jobs simultaneously and 
>> this is not about the QAPI interface)
>>
>> Will this simplify things in libvirt?
> 
> Peter, in your preliminary experiments with block-dirty-bitmap-populate, 
> did you ever need to start more than one job to a single bitmap 
> destination, or was it merely starting multiple jobs because you had 
> multiple destinations but always just a single source?

I guess I'm struggling in posting a v4 in part because I don't have a 
good answer to what is easiest for Peter to use.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


