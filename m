Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F229C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C4C20656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkFpa7rH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C4C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j726l-0006Cm-7e
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 14:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j725s-0005XH-Cu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j725p-0001BJ-2b
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:11:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43699
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j725o-0001AO-QF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582744296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fjsc3T2RvteXylZ4WTgswsym6YHL7M6Y+sj0IzNLJiY=;
 b=HkFpa7rH0nDEmHWdjyFvAlRbw9lN6LLZXUCNNbFawQbfJ8VtEn/wbWjOEVUkD6VM67CYSg
 u5DO5+ChCPbJZvz+PH3wqsdwxIwzaufN6KXbeCg8Yu+GVJG+XtqL1P8WlWgf8k2tRS/tj0
 HYOoMk4df/wUzB0avJ+EN7BvPLKsNa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-jsgAQG8kPgSbWjSAg9uxMA-1; Wed, 26 Feb 2020 14:11:33 -0500
X-MC-Unique: jsgAQG8kPgSbWjSAg9uxMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2196980268F;
 Wed, 26 Feb 2020 19:11:32 +0000 (UTC)
Received: from [10.10.123.58] (ovpn-123-58.rdu2.redhat.com [10.10.123.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 915E591851;
 Wed, 26 Feb 2020 19:11:30 +0000 (UTC)
Subject: Re: [PATCH 1/6] block: add bitmap-populate job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-2-jsnow@redhat.com>
 <ede1d2b6-0af9-0002-dc33-b82aa870119f@virtuozzo.com>
 <5c03a2b5-7cba-b347-da80-f9d9acaccb6e@redhat.com>
 <d462c95f-a616-1ddb-f0fd-650be113c384@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0343e036-ff72-0fd4-5478-86e40ae54aca@redhat.com>
Date: Wed, 26 Feb 2020 14:11:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d462c95f-a616-1ddb-f0fd-650be113c384@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/26/20 12:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.02.2020 23:41, John Snow wrote:
>>
>>
>> On 2/25/20 11:04 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 25.02.2020 3:56, John Snow wrote:
>>>> This job copies the allocation map into a bitmap. It's a job because
>>>> there's no guarantee that allocation interrogation will be quick (or
>>>> won't hang), so it cannot be retrofit into block-dirty-bitmap-merge.
>>>>
>>>> It was designed with different possible population patterns in mind,
>>>> but only top layer allocation was implemented for now.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 48 +++++++++
>>>> =C2=A0=C2=A0 qapi/job.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>> =C2=A0=C2=A0 include/block/block_int.h |=C2=A0 21 ++++
>>>> =C2=A0=C2=A0 block/bitmap-alloc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 207
>>>> ++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0=C2=A0 blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>>>> =C2=A0=C2=A0 block/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>>>> =C2=A0=C2=A0 6 files changed, 280 insertions(+), 2 deletions(-)
>>>> =C2=A0=C2=A0 create mode 100644 block/bitmap-alloc.c
>>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 85e27bb61f..df1797681a 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -2245,6 +2245,54 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 'command': 'block-d=
irty-bitmap-merge',
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'data': '=
BlockDirtyBitmapMerge' }
>>>> =C2=A0=C2=A0 +##
>>>> +# @BitmapPattern:
>>>> +#
>>>> +# An enumeration of possible patterns that can be written into a
>>>> bitmap.
>>>> +#
>>>> +# @allocation-top: The allocation status of the top layer
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of the attached storage node.
>>>> +#
>>>> +# Since: 5.0
>>>> +##
>>>> +{ 'enum': 'BitmapPattern',
>>>> +=C2=A0 'data': ['allocation-top'] }
>>>> +
>>>> +##
>>>> +# @BlockDirtyBitmapPopulate:
>>>> +#
>>>> +# @job-id: identifier for the newly-created block job.
>>>> +#
>>>> +# @pattern: What pattern should be written into the bitmap?
>>>> +#
>>>> +# @on-error: the action to take if an error is encountered on a
>>>> bitmap's
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
ttached node, default 'report'.
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '=
stop' and 'enospc' can only be used if the block device
>>>> supports
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
o-status (see BlockInfo).
>>>> +#
>>>> +# @auto-finalize: When false, this job will wait in a PENDING state
>>>> after it has
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finished its work, waiting for @block-job-fi=
nalize
>>>> before
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 making any block graph changes.
>>>
>>> sounds a bit strange in context of bitmap-population job
>>>
>>
>> Yeah, you're right. Copy-pasted for "consistency".
>>
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When true, this job will automatically
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perform its abort or commit actions.
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defaults to true.
>>>> +#
>>>> +# @auto-dismiss: When false, this job will wait in a CONCLUDED state
>>>> after it
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 has completely ceased all work, and awaits
>>>> @block-job-dismiss.
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 When true, this job will automatically disappear
>>>> from the query
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 list without user intervention.
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Defaults to true.
>>>> +#
>>>> +# Since: 5.0
>>>> +##
>>>> +{ 'struct': 'BlockDirtyBitmapPopulate',
>>>> +=C2=A0 'base': 'BlockDirtyBitmap',
>>>> +=C2=A0 'data': { 'job-id': 'str',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'p=
attern': 'BitmapPattern',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
on-error': 'BlockdevOnError',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
auto-finalize': 'bool',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*=
auto-dismiss': 'bool' } }
>>>> +
>>>> =C2=A0=C2=A0 ##
>>>> =C2=A0=C2=A0 # @BlockDirtyBitmapSha256:
>>>> =C2=A0=C2=A0 #
>>>> diff --git a/qapi/job.json b/qapi/job.json
>>>> index 5e658281f5..5f496d4630 100644
>>>> --- a/qapi/job.json
>>>> +++ b/qapi/job.json
>>>> @@ -22,7 +22,7 @@
>>>> =C2=A0=C2=A0 # Since: 1.7
>>>> =C2=A0=C2=A0 ##
>>>> =C2=A0=C2=A0 { 'enum': 'JobType',
>>>> -=C2=A0 'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
>>>> +=C2=A0 'data': ['commit', 'stream', 'mirror', 'backup', 'create',
>>>> 'bitmap-populate'] }
>>>> =C2=A0=C2=A0 =C2=A0 ##
>>>> =C2=A0=C2=A0 # @JobStatus:
>>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>>> index 6f9fd5e20e..a5884b597e 100644
>>>> --- a/include/block/block_int.h
>>>> +++ b/include/block/block_int.h
>>>> @@ -1215,6 +1215,27 @@ BlockJob *backup_job_create(const char *job_id,
>>>> BlockDriverState *bs,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb, void *opaque,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 JobTxn *txn, Error **errp);
>>>> =C2=A0=C2=A0 +/*
>>>> + * bitpop_job_create: Create a new bitmap population job.
>>>> + *
>>>> + * @job_id: The id of the newly-created job.
>>>> + * @bs: Block device associated with the @target_bitmap.
>>>> + * @target_bitmap: The bitmap to populate.
>>>> + * @on_error: What to do if an error on @bs is encountered.
>>>> + * @creation_flags: Flags that control the behavior of the Job
>>>> lifetime.
>>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See @BlockJobCreateFlags
>>>> + * @cb: Completion function for the job.
>>>> + * @opaque: Opaque pointer value passed to @cb.
>>>> + * @txn: Transaction that this job is part of (may be NULL).
>>>> + */
>>>> +BlockJob *bitpop_job_create(const char *job_id, BlockDriverState *bs,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BitmapPattern pattern,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int creation_flags,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb, void *opaque,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 JobTxn *txn, Error **errp);
>>>> +
>>>> =C2=A0=C2=A0 void hmp_drive_add_node(Monitor *mon, const char *optstr)=
;
>>>> =C2=A0=C2=A0 =C2=A0 BdrvChild *bdrv_root_attach_child(BlockDriverState=
 *child_bs,
>>>> diff --git a/block/bitmap-alloc.c b/block/bitmap-alloc.c
>>>> new file mode 100644
>>>> index 0000000000..47d542dc12
>>>> --- /dev/null
>>>> +++ b/block/bitmap-alloc.c
>>>> @@ -0,0 +1,207 @@
>>>> +/*
>>>> + * Async Dirty Bitmap Populator
>>>> + *
>>>> + * Copyright (C) 2020 Red Hat, Inc.
>>>> + *
>>>> + * Authors:
>>>> + *=C2=A0 John Snow <jsnow@redhat.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>>>> later.
>>>> + * See the COPYING file in the top-level directory.
>>>> + *
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +
>>>> +#include "trace.h"
>>>> +#include "block/block.h"
>>>> +#include "block/block_int.h"
>>>> +#include "block/blockjob_int.h"
>>>> +#include "block/block_backup.h"
>>>> +#include "block/block-copy.h"
>>>
>>> I hope, not all includes are needed :)
>>
>> Whoops, no, of course not. I copied the skeleton from backup, as you can
>> tell ;)
>>
>>>
>>>> +#include "qapi/error.h"
>>>> +#include "qapi/qmp/qerror.h"
>>>> +#include "qemu/ratelimit.h"
>>>> +#include "qemu/cutils.h"
>>>> +#include "sysemu/block-backend.h"
>>>> +#include "qemu/bitmap.h"
>>>> +#include "qemu/error-report.h"
>>>> +
>>>> +typedef struct BitpopBlockJob {
>>>> +=C2=A0=C2=A0=C2=A0 BlockJob common;
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap;
>>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *new_bitmap;
>>>> +=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t len;
>>>> +} BitpopBlockJob;
>>>> +
>>>> +static const BlockJobDriver bitpop_job_driver;
>>>> +
>>>> +static void bitpop_commit(Job *job)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBloc=
kJob, common.job);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_merge_internal(s->target_bitmap,=
 s->new_bitmap,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NU=
LL, true);
>>>
>>> Hmm, so you populate new_bitmap, and then merge to target. Why can't we
>>> work
>>> directly with target bitmap? The most probable case is that libvirt wil=
l
>>> create bitmap specifically to use as target in this operation, or not?
>>>
>>
>> Most likely case, yes. Odds are very good it will be a brand new bitmap.
>>
>> However, we already have a creation command -- I didn't want to make a
>> second job-version of the command and then maintain two interfaces, so I
>> made it a "merge into existing" style command instead.
>>
>>> Hmm, just to make it possible to cancel the job and keep the target
>>> bitmap in
>>> original state? Is it really needed? I think on failure target bitmap
>>> will be
>>> removed anyway..
>>>
>>
>> You caught me being *lazy*. I copy the bitmap so I can unconditionally
>> enable it to catch in-flight writes without having to create block graph
>> modifications.
>>
>> But, yes, to undo changes if we cancel.
>>
>> I didn't want to make a job that was not able to be canceled. The
>> alternative is pursuing the design where we allow new bitmaps only --
>> because then on cancel we can just delete them.
>=20
> On backup job (and any other) we can't rollback target changes on cancel.
> So, I think it would be OK to take same semantics for the new job,
> keeping in
> mind that it would be most probable usage case and no sense in creating
> additional bitmaps. And if caller needs to use existent non-empty bitmap =
as
> target and wants correct cancel, it always can create additional bitmap b=
y
> itself and then merge it to actual target.
>=20

While backup can't roll back data changes, it does avoid modifying
bitmaps if it didn't succeed. This is a bitmap-centric job and we have
the capability to do a complete rollback.

i.e. I am thinking more about consistency with bitmap behavior than I am
consistency with job behavior.

That this job becomes the only one to be able to be *fully* reversed on
cancel is unique to jobs -- but is shared by all transactionable bitmap
commands.

> And why new? It's up to user, what to use as target. And user knows,
> that on
> failure or cancel target becomes invalid and will workaround this if
> needed.
>=20

I think you're advocating for writing directly into the bitmap and just
accepting that it's trashed afterwards, but I don't like this behavior
because it limits what we can do with this job in the future.

Is this just a matter of taste? Since every other bitmap command offers
some kind of rollback I felt more comfortable doing the same here.

I'm worried that if I decide to treat the result bitmap as disposable,
that I will need to provide greater atomicity for the allocation status
read. At the moment I rely on the temporary bitmap being *enabled* to
make sure that if any new writes happen in regions I have already read
that they are reflected in the bitmap anyway.

If the user passes a disabled bitmap, that guarantee is lost -- we lose
point in time semantics entirely. Writes that occur further in the file
are captured, but ones that occur earlier are missed.

If I make a temporary enabled bitmap, I catch everything.

I could prohibit *disabled* bitmaps from being passed in to this job,
but that again makes it of a more limited use for other patterns in the
future.

So I guess I would prefer to just leave this as-is for now if it's not
that harmful.

>>
>>>> +}
>>>> +
>>>> +/* no abort needed; just clean without committing. */
>>>> +
>>>> +static void bitpop_clean(Job *job)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBloc=
kJob, common.job);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(s->new_bitmap);
>>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy(s->target_bitmap, false=
);
>>>> +}
>>>> +
>>>> +static BlockErrorAction bitpop_error_action(BitpopBlockJob *job, int
>>>> error)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return block_job_error_action(&job->common, job->o=
n_error, true,
>>>> error);
>>>> +}
>>>> +
>>>> +static bool coroutine_fn yield_and_check(Job *job)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 if (job_is_cancelled(job)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 job_sleep_ns(job, 0);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (job_is_cancelled(job)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return false;
>>>> +}
>>>> +
>>>> +static int coroutine_fn bitpop_run(Job *job, Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBloc=
kJob, common.job);
>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t offset;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t count;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t bytes;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 for (offset =3D 0; offset < s->len; ) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (yield_and_check(job)) =
{
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -ECANCELED;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes =3D s->len - offset;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_is_allocated(=
s->bs, offset, bytes, &count);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (bitpop_error_action(s, -ret) =3D=3D
>>>> BLOCK_ERROR_ACTION_REPORT) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!count) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D 0;
>>>
>>> Hmm, I think it's impossible case.. If so, better to make an assertion
>>> or ignore..
>>>
>>
>> OK, agreed.
>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bd=
rv_set_dirty_bitmap(s->new_bitmap, offset, count);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D 0;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_progress_update(job, c=
ount);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset +=3D count;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>> +}
>>>> +
>>>> +static const BlockJobDriver bitpop_job_driver =3D {
>>>> +=C2=A0=C2=A0=C2=A0 .job_driver =3D {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D sizeof(BitpopBlockJob),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .job_type=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D J=
OB_TYPE_BITMAP_POPULATE,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .free=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D block_job_free,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .user_resume=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D block_job_user_r=
esume,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .run=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D bitpop_run,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .commit=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D bitpop_commit,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .clean=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D bitpop_clean,
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +};
>>>> +
>>>> +
>>>> +BlockJob *bitpop_job_create(
>>>> +=C2=A0=C2=A0=C2=A0 const char *job_id,
>>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs,
>>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap,
>>>> +=C2=A0=C2=A0=C2=A0 BitmapPattern pattern,
>>>> +=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error,
>>>> +=C2=A0=C2=A0=C2=A0 int creation_flags,
>>>> +=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb,
>>>> +=C2=A0=C2=A0=C2=A0 void *opaque,
>>>> +=C2=A0=C2=A0=C2=A0 JobTxn *txn,
>>>> +=C2=A0=C2=A0=C2=A0 Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 int64_t len;
>>>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *job =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t cluster_size;
>>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *new_bitmap =3D NULL;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 assert(bs);
>>>> +=C2=A0=C2=A0=C2=A0 assert(target_bitmap);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!bdrv_is_inserted(bs)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Device i=
s not inserted: %s",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_get_device_name(bs));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> Why this?
>>>
>>
>> I assumed there was nothing to read the allocation map *of* if there
>> wasn't a media present.
>>
>> Am I mistaken?
>=20
> is_inserted checks existing of bs->drv, but bitmap operations actually
> doesn't need any drv.. Hmm. I'm not against this check anyway.
>=20

Maybe it would be clearer to say this:

if (pattern =3D BITMAP_PATTERN_ALLOCATION_TOP) {
    if (!bdrv_is_inserted(bs)) {
        ...
    }
} else {
    ...
}

We need to make sure bs->drv exists for the allocation map reading --
not for every theoretical pattern, but for this one we do.

>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SO=
URCE, errp)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> and this?
>>>
>>
>> Copy-paste: I don't understand if I want a new op blocker, to re-use an
>> op-blocker, or to have no op blocker.
>>
>> Genuinely I have no idea. I should left a review comment here, I forgot
>> about this part, sorry.
>=20
> I'm for no op blocker. As I understand, op-blockers are old and should be
> replaced by permissions and frozen children. So, if we don't know, do we
> need any blocking here, better go on without it. Also, op-blockers can't
> block forbidden usage through filters anyway.
>=20

Sounds good to me, honestly.

>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(target_bitmap, BDRV_BI=
TMAP_DEFAULT,
>>>> errp)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (pattern !=3D BITMAP_PATTERN_ALLOCATION_TOP) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unrecogn=
ized bitmap pattern");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 len =3D bdrv_getlength(bs);
>>>> +=C2=A0=C2=A0=C2=A0 if (len < 0) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -le=
n, "unable to get length for '%s'",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bdrv_get_device_name(bs));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* NB: new bitmap is anonymous and enabled */
>>>> +=C2=A0=C2=A0=C2=A0 cluster_size =3D bdrv_dirty_bitmap_granularity(tar=
get_bitmap);
>>>> +=C2=A0=C2=A0=C2=A0 new_bitmap =3D bdrv_create_dirty_bitmap(bs, cluste=
r_size, NULL,
>>>> errp);
>>>> +=C2=A0=C2=A0=C2=A0 if (!new_bitmap) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Take ownership; we reserve the right to write i=
nto this
>>>> on-commit. */
>>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy(target_bitmap, true);
>>>
>>> Honestly, I still have bad understanding about how should we use dirty
>>> bitmap mutex,
>>> but note that bdrv_dirty_bitmap_set_busy locks the mutex. And it is (ma=
y
>>> be) possible,
>>> that busy status of the bitmap is changed after bdrv_dirty_bitmap_check
>>> but before
>>> bdrv_dirty_bitmap_set_busy.=C2=A0 So, more correct would be do both ope=
ration
>>> under one
>>> critical section. Still, I don't know is the situation possible.
>>>
>>
>> Aren't we under the BQL here? Can we be pre-empted? :(
>=20
> Seems we are. But, as it's said above dirty_bitmap_mutex declaration:
>=20
> =C2=A0=C2=A0=C2=A0 /* Writing to the list requires the BQL _and_ the dirt=
y_bitmap_mutex.
> =C2=A0=C2=A0=C2=A0=C2=A0 * Reading from the list can be done with either =
the BQL or the
> =C2=A0=C2=A0=C2=A0=C2=A0 * dirty_bitmap_mutex.=C2=A0 Modifying a bitmap o=
nly requires
> =C2=A0=C2=A0=C2=A0=C2=A0 * dirty_bitmap_mutex.=C2=A0 */
>=20
> It means, that another thread may modify bitmap (for example its 'busy'
> field)
> taking only dirty_bitmap_mutex, which will lead to the case I described.
>=20

Alright, I'll add the locking change. Atomic check-and-lock for the busy
bit sounds like a good model anyway.

>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 job =3D block_job_create(job_id, &bitpop_job_drive=
r, txn, bs,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BLK_PERM_CONSISTENT_READ,
>>>
>>> Do we need it? We are not going to read..
>>>
>>
>> Copy-paste / leftover from an earlier draft where I was trying to
>> achieve atomicity. It can be removed if we don't want the stricter
>> atomicity.
>>

I guess I really don't need READ here. I guess ~RESIZE is the only
important one.

>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BLK_PERM_ALL & ~BLK_PERM_RESIZE,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0, creation_flags,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 cb, opaque, errp);
>>>> +=C2=A0=C2=A0=C2=A0 if (!job) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy=
(target_bitmap, false);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(=
new_bitmap);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 job->bs =3D bs;
>>>> +=C2=A0=C2=A0=C2=A0 job->on_error =3D on_error;
>>>> +=C2=A0=C2=A0=C2=A0 job->target_bitmap =3D target_bitmap;
>>>> +=C2=A0=C2=A0=C2=A0 job->new_bitmap =3D new_bitmap;
>>>> +=C2=A0=C2=A0=C2=A0 job->len =3D len;
>>>> +=C2=A0=C2=A0=C2=A0 job_progress_set_remaining(&job->common.job, job->=
len);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return &job->common;
>>>> +}
>>>> diff --git a/blockjob.c b/blockjob.c
>>>> index 5d63b1e89d..7e450372bd 100644
>>>> --- a/blockjob.c
>>>> +++ b/blockjob.c
>>>> @@ -56,7 +56,8 @@ static bool is_block_job(Job *job)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return job_type(job) =3D=3D JOB_T=
YPE_BACKUP ||
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 job_type(job) =3D=3D JOB_TYPE_COMMIT ||
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 job_type(job) =3D=3D JOB_TYPE_MIRROR ||
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type=
(job) =3D=3D JOB_TYPE_STREAM;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type=
(job) =3D=3D JOB_TYPE_STREAM ||
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type=
(job) =3D=3D JOB_TYPE_BITMAP_POPULATE;
>>>> =C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 =C2=A0 BlockJob *block_job_next(BlockJob *bjob)
>>>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>>>> index 3bcb35c81d..f3cfc89d90 100644
>>>> --- a/block/Makefile.objs
>>>> +++ b/block/Makefile.objs
>>>> @@ -36,6 +36,7 @@ block-obj-$(CONFIG_LIBSSH) +=3D ssh.o
>>>> =C2=A0=C2=A0 block-obj-y +=3D accounting.o dirty-bitmap.o
>>>> =C2=A0=C2=A0 block-obj-y +=3D write-threshold.o
>>>> =C2=A0=C2=A0 block-obj-y +=3D backup.o
>>>> +block-obj-y +=3D bitmap-alloc.o
>>>> =C2=A0=C2=A0 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
>>>> =C2=A0=C2=A0 block-obj-y +=3D throttle.o copy-on-read.o
>>>> =C2=A0=C2=A0 block-obj-y +=3D block-copy.o
>>>>
>>>
>>>
>>

Thanks!


