Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04834C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD94D215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD94D215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNMv-0007i5-9r
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iGNJS-0005WY-Uv
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iGNJQ-0005CZ-O0
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iGNJF-00057S-TA; Fri, 04 Oct 2019 09:07:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5272A10C0954;
 Fri,  4 Oct 2019 13:07:47 +0000 (UTC)
Received: from [10.3.117.6] (ovpn-117-6.phx2.redhat.com [10.3.117.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20F9310013A7;
 Fri,  4 Oct 2019 13:07:44 +0000 (UTC)
Subject: Re: bitmap migration bug with -drive while block mirror runs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, Peter Krempa <pkrempa@redhat.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
 <20191002104600.GC6129@angien.pipo.sk>
 <73dcfdd5-ede2-250e-4680-7c1408c5a3c3@redhat.com>
 <7b0ea320-4c77-2b0f-7f12-615aa0a6d8cd@virtuozzo.com>
 <53da72e0-d265-8d0f-e47c-8338c43081e3@redhat.com>
 <478fbdba-a3d3-6c3c-2ef5-bff714356789@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3d5512bd-2aca-58cf-1f5c-c95e6ecbfc17@redhat.com>
Date: Fri, 4 Oct 2019 08:07:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <478fbdba-a3d3-6c3c-2ef5-bff714356789@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 04 Oct 2019 13:07:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:

>> The way I see it, we know an auto-generated node name will never be
>> correct, but an explicitly specified one represents an explicit user
>> configuration.
>>
>> It's wrong to use generated names for migration details, but it's never
>> wrong to use explicit configuration.
>>
>> So I believe they are /already/ distinct in nature. We even already have
>> code that can tell them apart.
> 
> Is it restricted to create user node-names formatted like automated ones?

Yes. Explicit node names cannot begin with '#', while all generated node 
names do.


>> There are four cases here:
>>
>> - The bitmap is loaded to a root node with an explicit name
>> - The bitmap is loaded to a non-root node with an explicit name
>>
>> The blockdev case with persistence. The name represents explicit user
>> configuration and can be relied upon in the destination.
>>
>> - The bitmap is loaded to a root node with an implicit name, with a named BB
>>
>> The -drive case. The named BB represents the explicit user configuration
>> and can be relied upon.
>>
>> - The bitmap is loaded to a non-root node with an implicit name.
> 
> So, do you suggest to save information of haw bitmap was loaded or created in
> BdrvDirtyBitmap structure, to distinguish, how to identify it, by blk name or
> by node-name? And how this information would be updated on bitmap merge? And
> what about creating bitmaps?
> 
> So if one bitmap created in node N by blk name B, and another bitmap created in
> same node N by node-name N, will we migrated these bitmaps in different ways?

In the -drive case (historical libvirt), the block device is named, and 
node names are generated (it may be possible to use -drive and still 
create explicit node names, but libvirt will never do that).  You can 
create a bitmap using either ('drive-name','bitmap-name'), or 
('generated-node-name','bitmap-name'), but for the purposes of 
migration, only the 'drive-name' variant is migrateable.

In the -blockdev case (upcoming libvirt), the block device is anonymous, 
and all node names are given by libvirt.  Thus, you can only create a 
bitmap using ('node-name','bitmap-name'), but it is also obvious that 
migration will use the 'node-name' variant.


>>>
>>> If it's a problem for libvirt to keep same node-names, why should we insist?
>>>
>>>
>>
>> Is it really a problem? If libvirt requests migration of bitmaps, those
>> bitmaps need to go somewhere. Even if it constructs a different graph
>> for valid reasons, it should still understand which qcow2 nodes
>> correlate to which other qcow2 nodes and name them accordingly.
>>
>> I don't see why this is actually a terrible constraint. Even in our
>> mapping proposal we're still using node-names.
>>
>>

The obvious case I see is that if we have a source:

Backing.qcow2 (contains bitmap1) <- Active.qcow2 (contains bitmap2)

and we want to migrate AND flatten at the same time, but still preserve 
the bitmaps as a record of changes between the points in time, then 
libvirt needs a way to specify migration to:

Flattened.qcow2 (contains bitmap1 and bitmap2)

No matter which node name libvirt assigns to Flattened.qcow2, at least 
one of the two bitmaps on the source will be migrated to a different 
node name on the destination, while still giving the net result of a 
bitmap logically associated with the drive (and not any particular node).


> Ok, I'm not completely against node-name matching, keeping in mind that it is
> current default behavior anyway. And I see Peter not completely against too.
> 
> But I'd prefer to select default name from current moment, not involving information
> of "how bitmap was created or loaded", as it may lead to migrating bitmaps from one
> node in different ways which seems inconsistent.

As long as a bitmap never has both names non-generated, we should be 
fine (it either has an explicit drive name and generated node name, or 
it has no drive name and an explicit node name).

> 
> Current default is blk name. And node-name if blk name is not available. So I think
> the only thing to fix right now is skipping filters. We possibly may additionally
> restrict migrating bitmaps without blk name and with generated node-name.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

