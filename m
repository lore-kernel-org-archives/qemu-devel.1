Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA742C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A220F2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzgpU/Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A220F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnUGQ-0005F9-SI
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 17:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnUFC-0004Zq-JO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 17:44:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33993
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnUFA-0003Ac-6E
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 17:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592862282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=csFN2T4s0NdUHdPmMmB0W6Bd4KLW4uJGAiELDf0bAPo=;
 b=VzgpU/Rm4cFANgylJTnRwZsQVrcale13KZSHtEYnVPFwXnDzjfG8yiWxhnvlmxb2RRZu6i
 v+HWw4CATcFOl95Dxg7IHYQ7Y3rSDYT7FXvgFrflsV4x6SGb8BZzrj0uCjoAJivIKZ+iYA
 ZwO1pWkly6LQSF661NyFY2/xguQ4vrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Qxec_M6rPJyTwsLBw3y8vw-1; Mon, 22 Jun 2020 17:44:35 -0400
X-MC-Unique: Qxec_M6rPJyTwsLBw3y8vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3DD0464;
 Mon, 22 Jun 2020 21:44:33 +0000 (UTC)
Received: from [10.3.114.4] (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A38910013D2;
 Mon, 22 Jun 2020 21:44:32 +0000 (UTC)
Subject: Re: [PATCH v3 1/6] block: add bitmap-populate job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200619195621.58740-1-eblake@redhat.com>
 <20200619195621.58740-2-eblake@redhat.com>
 <074b3859-a6e1-1388-2142-5a7af8ee3fdb@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <74dc0ce7-2c0e-c987-cbc8-398d2c23f21a@redhat.com>
Date: Mon, 22 Jun 2020 16:44:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <074b3859-a6e1-1388-2142-5a7af8ee3fdb@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 11:16 PM, Vladimir Sementsov-Ogievskiy wrote:
> 19.06.2020 22:56, Eric Blake wrote:
>> From: John Snow <jsnow@redhat.com>
>>
>> This job copies the allocation map into a bitmap. It's a job because
>> there's no guarantee that allocation interrogation will be quick (or
>> won't hang), so it cannot be retrofitted into block-dirty-bitmap-merge.
>>
>> It was designed with different possible population patterns in mind,
>> but only top layer allocation was implemented for now.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> +{ 'struct': 'BlockDirtyBitmapPopulate',
>> +  'base': 'BlockDirtyBitmap',
>> +  'data': { 'job-id': 'str',
>> +            'pattern': 'BitmapPattern',
>> +            '*on-error': 'BlockdevOnError',
>> +            '*auto-finalize': 'bool',
>> +            '*auto-dismiss': 'bool' } }
>> +
> 
> Peter said about a possibility of populating several target bitmaps 
> simultaneously.
> 
> What about such a generalized semantics:
> 
> Merge all sources to each target
> 
> @targets: list of bitmaps to be populated by the job
> { 'struct': 'BlockDirtyBitmapPopulate',
>    'data': { <common job fields>,
>              'targets': ['BlockDirtyBitmap'],
>              'sources': ['BitmapPopulateSource'] } }

We still need the 'pattern' argument (the idea being that if we have: 
Base <- Active, we want to be able to merge in the allocation map of 
Active into bitmaps stored in Base as part of a commit operation, 
whether that is active commit of a live guest or offline commit while 
the guest is offline).  Having an array for 'targets' to merge into is 
fine, but for 'sources', it's less a concern about selecting from 
multiple sources, and more a concern about selecting the allocation 
pattern to be merged in (libvirt wants to merge the same allocation 
pattern into each bitmap in Base).  Generalizing things to allow the 
merge of more than one source at once might not hurt, but I'm not sure 
we need it yet.

But there are other patterns that we may want to support: an all-ones 
pattern, or maybe a pattern that tracks known-zeros instead of allocation.

> 
> 
> @bitmap: specify dirty bitmap to be merged to target bitamp(s)
> @node: specify a node name, which allocation-map is to be merged to 
> target bitmap(s)
> { 'alternate': 'BitmapPopulateSource',
>    'data': { 'bitmap': 'BlockDirtyBitmap',
>              'node': 'str' } }

This design is clever in that it lets us merge in both existing bitmaps 
and using a node-name for merging in an allocation map instead of a 
bitmap; but it limits us to only one pattern.  Better might be something 
where we supply a union (hmm, we've had proposals in the past for a 
default value to the discriminator to allow it to be optional, so I'll 
proceed as if we will finally implement that):

{ 'enum': 'BitmapPattern', 'data': [ 'bitmap', 'allocation-top' ] }
{ 'union': 'BitmapPopulateSource',
   'base': { '*pattern': 'BitmapPattern' },
   'discriminator': { 'name': 'pattern', 'default': 'bitmap' },
   'data': { 'bitmap': 'BitmapPopulateSource',
             'allocation-top': { 'node': 'str' } } }

so that you can then do:

{ "execute": "block-dirty-bitmap-populate",
   "arguments": { "targets": [ { "node": "base", "name": "b1" },
                               { "node": "base", "name": "b2" } ],
         "sources": [ { "pattern": "allocation-top", "node": "top" } ]
   } }

to merge in the allocation information of top into multiple bitmaps of 
base at once, or conversely, do:

{ "execute": "block-dirty-bitmap-populate",
   "arguments": { "targets": [ { "node": "base", "name": "b1" } ],
         "sources": [ { "pattern": "bitmap",
                        "node": "top", "name": "b1" } ]
   } }
{ "execute": "block-dirty-bitmap-populate",
   "arguments": { "targets": [ { "node": "base", "name": "b2" } ],
         "sources": [ { "node": "top", "name": "b2" } ]
   } }

and of course, wrap this in a "transaction" to ensure that it all 
succeeds or fails as a unit, rather than messing up one bitmap if 
another fails, while also allowing future extension for additional patterns.

> 
> 
> - so, we can merge several bitmaps together with several allocation maps 
> into several target bitmaps.
> (I remember, we also said about a possibility of starting several 
> populating jobs, populating into
>   same bitmap, I think it may be substituted by one job with several 
> sources. Still, it's not hard to
>   allow to use target bitmaps in a several jobs simultaneously and this 
> is not about the QAPI interface)
> 
> Will this simplify things in libvirt?

Peter, in your preliminary experiments with block-dirty-bitmap-populate, 
did you ever need to start more than one job to a single bitmap 
destination, or was it merely starting multiple jobs because you had 
multiple destinations but always just a single source?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


