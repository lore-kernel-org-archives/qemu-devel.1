Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E4C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C8F20675
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MW3kGMTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C8F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6h2f-0007oF-7K
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 15:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6h1T-0006wl-8B
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6h1Q-0004Kf-Q6
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:41:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6h1Q-0004Hl-JD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582663299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3Sn+NK3Pwd4UqxVWYBEkaYuAORtuYP/VAncNL1a2S7k=;
 b=MW3kGMTOIVknCAkeYmz+UUpHwCVAZvxZH/KJLI5eir5QSgQZP+24hG9Wn04+NwoxtdWsBS
 vBroW/7ECDMOWeWWDZThhide7O9alxiZCmFeOWUsfElCnx0Q+7vj7J+PQzssUtHh+wB5Gw
 C3w6rSSYoEkoZJafV76bKr35G2gYjfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-40WiEOsRNH6Npk3waxtVYA-1; Tue, 25 Feb 2020 15:41:36 -0500
X-MC-Unique: 40WiEOsRNH6Npk3waxtVYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D90EDB20;
 Tue, 25 Feb 2020 20:41:35 +0000 (UTC)
Received: from [10.18.17.182] (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DD478C077;
 Tue, 25 Feb 2020 20:41:33 +0000 (UTC)
Subject: Re: [PATCH 1/6] block: add bitmap-populate job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-2-jsnow@redhat.com>
 <ede1d2b6-0af9-0002-dc33-b82aa870119f@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5c03a2b5-7cba-b347-da80-f9d9acaccb6e@redhat.com>
Date: Tue, 25 Feb 2020 15:41:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ede1d2b6-0af9-0002-dc33-b82aa870119f@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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



On 2/25/20 11:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.02.2020 3:56, John Snow wrote:
>> This job copies the allocation map into a bitmap. It's a job because
>> there's no guarantee that allocation interrogation will be quick (or
>> won't hang), so it cannot be retrofit into block-dirty-bitmap-merge.
>>
>> It was designed with different possible population patterns in mind,
>> but only top layer allocation was implemented for now.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 48 +++=
++++++
>> =C2=A0 qapi/job.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 include/block/block_int.h |=C2=A0 21 ++++
>> =C2=A0 block/bitmap-alloc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 207 ++++++++=
++++++++++++++++++++++++++++++
>> =C2=A0 blockjob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>> =C2=A0 block/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>> =C2=A0 6 files changed, 280 insertions(+), 2 deletions(-)
>> =C2=A0 create mode 100644 block/bitmap-alloc.c
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 85e27bb61f..df1797681a 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2245,6 +2245,54 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 'command': 'block-dirty-bit=
map-merge',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'data': 'BlockDir=
tyBitmapMerge' }
>> =C2=A0 +##
>> +# @BitmapPattern:
>> +#
>> +# An enumeration of possible patterns that can be written into a bitmap=
.
>> +#
>> +# @allocation-top: The allocation status of the top layer
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of the attached storage node.
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'enum': 'BitmapPattern',
>> +=C2=A0 'data': ['allocation-top'] }
>> +
>> +##
>> +# @BlockDirtyBitmapPopulate:
>> +#
>> +# @job-id: identifier for the newly-created block job.
>> +#
>> +# @pattern: What pattern should be written into the bitmap?
>> +#
>> +# @on-error: the action to take if an error is encountered on a bitmap'=
s
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 att=
ached node, default 'report'.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'st=
op' and 'enospc' can only be used if the block device
>> supports
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io-=
status (see BlockInfo).
>> +#
>> +# @auto-finalize: When false, this job will wait in a PENDING state
>> after it has
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 finished its work, waiting for @block-job-final=
ize
>> before
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 making any block graph changes.
>=20
> sounds a bit strange in context of bitmap-population job
>=20

Yeah, you're right. Copy-pasted for "consistency".

>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 When true, this job will automatically
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 perform its abort or commit actions.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defaults to true.
>> +#
>> +# @auto-dismiss: When false, this job will wait in a CONCLUDED state
>> after it
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 has completely ceased all work, and awaits
>> @block-job-dismiss.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 When true, this job will automatically disappear
>> from the query
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 list without user intervention.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Defaults to true.
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'struct': 'BlockDirtyBitmapPopulate',
>> +=C2=A0 'base': 'BlockDirtyBitmap',
>> +=C2=A0 'data': { 'job-id': 'str',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'pat=
tern': 'BitmapPattern',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*on=
-error': 'BlockdevOnError',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*au=
to-finalize': 'bool',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*au=
to-dismiss': 'bool' } }
>> +
>> =C2=A0 ##
>> =C2=A0 # @BlockDirtyBitmapSha256:
>> =C2=A0 #
>> diff --git a/qapi/job.json b/qapi/job.json
>> index 5e658281f5..5f496d4630 100644
>> --- a/qapi/job.json
>> +++ b/qapi/job.json
>> @@ -22,7 +22,7 @@
>> =C2=A0 # Since: 1.7
>> =C2=A0 ##
>> =C2=A0 { 'enum': 'JobType',
>> -=C2=A0 'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
>> +=C2=A0 'data': ['commit', 'stream', 'mirror', 'backup', 'create',
>> 'bitmap-populate'] }
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @JobStatus:
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 6f9fd5e20e..a5884b597e 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1215,6 +1215,27 @@ BlockJob *backup_job_create(const char *job_id,
>> BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb, void *opaque,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 JobTxn *txn, Error **errp);
>> =C2=A0 +/*
>> + * bitpop_job_create: Create a new bitmap population job.
>> + *
>> + * @job_id: The id of the newly-created job.
>> + * @bs: Block device associated with the @target_bitmap.
>> + * @target_bitmap: The bitmap to populate.
>> + * @on_error: What to do if an error on @bs is encountered.
>> + * @creation_flags: Flags that control the behavior of the Job lifetime=
.
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 See @BlockJobCreateFlags
>> + * @cb: Completion function for the job.
>> + * @opaque: Opaque pointer value passed to @cb.
>> + * @txn: Transaction that this job is part of (may be NULL).
>> + */
>> +BlockJob *bitpop_job_create(const char *job_id, BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BitmapPattern pattern,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int creation_flags,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb, void *opaque,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 JobTxn *txn, Error **errp);
>> +
>> =C2=A0 void hmp_drive_add_node(Monitor *mon, const char *optstr);
>> =C2=A0 =C2=A0 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_=
bs,
>> diff --git a/block/bitmap-alloc.c b/block/bitmap-alloc.c
>> new file mode 100644
>> index 0000000000..47d542dc12
>> --- /dev/null
>> +++ b/block/bitmap-alloc.c
>> @@ -0,0 +1,207 @@
>> +/*
>> + * Async Dirty Bitmap Populator
>> + *
>> + * Copyright (C) 2020 Red Hat, Inc.
>> + *
>> + * Authors:
>> + *=C2=A0 John Snow <jsnow@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "trace.h"
>> +#include "block/block.h"
>> +#include "block/block_int.h"
>> +#include "block/blockjob_int.h"
>> +#include "block/block_backup.h"
>> +#include "block/block-copy.h"
>=20
> I hope, not all includes are needed :)

Whoops, no, of course not. I copied the skeleton from backup, as you can
tell ;)

>=20
>> +#include "qapi/error.h"
>> +#include "qapi/qmp/qerror.h"
>> +#include "qemu/ratelimit.h"
>> +#include "qemu/cutils.h"
>> +#include "sysemu/block-backend.h"
>> +#include "qemu/bitmap.h"
>> +#include "qemu/error-report.h"
>> +
>> +typedef struct BitpopBlockJob {
>> +=C2=A0=C2=A0=C2=A0 BlockJob common;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap;
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *new_bitmap;
>> +=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error;
>> +=C2=A0=C2=A0=C2=A0 uint64_t len;
>> +} BitpopBlockJob;
>> +
>> +static const BlockJobDriver bitpop_job_driver;
>> +
>> +static void bitpop_commit(Job *job)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBlockJ=
ob, common.job);
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_merge_internal(s->target_bitmap, s=
->new_bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NU=
LL, true);
>=20
> Hmm, so you populate new_bitmap, and then merge to target. Why can't we
> work
> directly with target bitmap? The most probable case is that libvirt will
> create bitmap specifically to use as target in this operation, or not?
>=20

Most likely case, yes. Odds are very good it will be a brand new bitmap.

However, we already have a creation command -- I didn't want to make a
second job-version of the command and then maintain two interfaces, so I
made it a "merge into existing" style command instead.

> Hmm, just to make it possible to cancel the job and keep the target
> bitmap in
> original state? Is it really needed? I think on failure target bitmap
> will be
> removed anyway..
>=20

You caught me being *lazy*. I copy the bitmap so I can unconditionally
enable it to catch in-flight writes without having to create block graph
modifications.

But, yes, to undo changes if we cancel.

I didn't want to make a job that was not able to be canceled. The
alternative is pursuing the design where we allow new bitmaps only --
because then on cancel we can just delete them.

>> +}
>> +
>> +/* no abort needed; just clean without committing. */
>> +
>> +static void bitpop_clean(Job *job)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBlockJ=
ob, common.job);
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(s->new_bitmap);
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy(s->target_bitmap, false);
>> +}
>> +
>> +static BlockErrorAction bitpop_error_action(BitpopBlockJob *job, int
>> error)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return block_job_error_action(&job->common, job->on_=
error, true,
>> error);
>> +}
>> +
>> +static bool coroutine_fn yield_and_check(Job *job)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (job_is_cancelled(job)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 job_sleep_ns(job, 0);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (job_is_cancelled(job)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return false;
>> +}
>> +
>> +static int coroutine_fn bitpop_run(Job *job, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *s =3D container_of(job, BitpopBlockJ=
ob, common.job);
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int64_t offset;
>> +=C2=A0=C2=A0=C2=A0 int64_t count;
>> +=C2=A0=C2=A0=C2=A0 int64_t bytes;
>> +
>> +=C2=A0=C2=A0=C2=A0 for (offset =3D 0; offset < s->len; ) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (yield_and_check(job)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -ECANCELED;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes =3D s->len - offset;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_is_allocated(s-=
>bs, offset, bytes, &count);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
bitpop_error_action(s, -ret) =3D=3D
>> BLOCK_ERROR_ACTION_REPORT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!count) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D 0;
>=20
> Hmm, I think it's impossible case.. If so, better to make an assertion
> or ignore..
>=20

OK, agreed.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_set_dirty_bitmap(s->new_bitmap, offset, count);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_progress_update(job, cou=
nt);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset +=3D count;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static const BlockJobDriver bitpop_job_driver =3D {
>> +=C2=A0=C2=A0=C2=A0 .job_driver =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D sizeof(BitpopBlockJob),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .job_type=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D JOB_=
TYPE_BITMAP_POPULATE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .free=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D block_job_free,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .user_resume=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D block_job_user_resu=
me,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .run=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =3D bitpop_run,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .commit=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D bitpop_commit,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .clean=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D bitpop_clean,
>> +=C2=A0=C2=A0=C2=A0 }
>> +};
>> +
>> +
>> +BlockJob *bitpop_job_create(
>> +=C2=A0=C2=A0=C2=A0 const char *job_id,
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *target_bitmap,
>> +=C2=A0=C2=A0=C2=A0 BitmapPattern pattern,
>> +=C2=A0=C2=A0=C2=A0 BlockdevOnError on_error,
>> +=C2=A0=C2=A0=C2=A0 int creation_flags,
>> +=C2=A0=C2=A0=C2=A0 BlockCompletionFunc *cb,
>> +=C2=A0=C2=A0=C2=A0 void *opaque,
>> +=C2=A0=C2=A0=C2=A0 JobTxn *txn,
>> +=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int64_t len;
>> +=C2=A0=C2=A0=C2=A0 BitpopBlockJob *job =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 int64_t cluster_size;
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *new_bitmap =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 assert(bs);
>> +=C2=A0=C2=A0=C2=A0 assert(target_bitmap);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!bdrv_is_inserted(bs)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Device is =
not inserted: %s",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_get_device_name(bs));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> Why this?
>=20

I assumed there was nothing to read the allocation map *of* if there
wasn't a media present.

Am I mistaken?

>> +
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOUR=
CE, errp)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> and this?
>=20

Copy-paste: I don't understand if I want a new op blocker, to re-use an
op-blocker, or to have no op blocker.

Genuinely I have no idea. I should left a review comment here, I forgot
about this part, sorry.

>> +
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(target_bitmap, BDRV_BITM=
AP_DEFAULT,
>> errp)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (pattern !=3D BITMAP_PATTERN_ALLOCATION_TOP) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unrecogniz=
ed bitmap pattern");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 len =3D bdrv_getlength(bs);
>> +=C2=A0=C2=A0=C2=A0 if (len < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -len,=
 "unable to get length for '%s'",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bdrv_get_device_name(bs));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* NB: new bitmap is anonymous and enabled */
>> +=C2=A0=C2=A0=C2=A0 cluster_size =3D bdrv_dirty_bitmap_granularity(targe=
t_bitmap);
>> +=C2=A0=C2=A0=C2=A0 new_bitmap =3D bdrv_create_dirty_bitmap(bs, cluster_=
size, NULL, errp);
>> +=C2=A0=C2=A0=C2=A0 if (!new_bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Take ownership; we reserve the right to write int=
o this
>> on-commit. */
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy(target_bitmap, true);
>=20
> Honestly, I still have bad understanding about how should we use dirty
> bitmap mutex,
> but note that bdrv_dirty_bitmap_set_busy locks the mutex. And it is (may
> be) possible,
> that busy status of the bitmap is changed after bdrv_dirty_bitmap_check
> but before
> bdrv_dirty_bitmap_set_busy.=C2=A0 So, more correct would be do both opera=
tion
> under one
> critical section. Still, I don't know is the situation possible.
>=20

Aren't we under the BQL here? Can we be pre-empted? :(

>> +
>> +=C2=A0=C2=A0=C2=A0 job =3D block_job_create(job_id, &bitpop_job_driver,=
 txn, bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BLK_PERM_CONSISTENT_READ,
>=20
> Do we need it? We are not going to read..
>=20

Copy-paste / leftover from an earlier draft where I was trying to
achieve atomicity. It can be removed if we don't want the stricter
atomicity.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BLK_PERM_ALL & ~BLK_PERM_RESIZE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0, creation_flags,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 cb, opaque, errp);
>> +=C2=A0=C2=A0=C2=A0 if (!job) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_busy(t=
arget_bitmap, false);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(ne=
w_bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 job->bs =3D bs;
>> +=C2=A0=C2=A0=C2=A0 job->on_error =3D on_error;
>> +=C2=A0=C2=A0=C2=A0 job->target_bitmap =3D target_bitmap;
>> +=C2=A0=C2=A0=C2=A0 job->new_bitmap =3D new_bitmap;
>> +=C2=A0=C2=A0=C2=A0 job->len =3D len;
>> +=C2=A0=C2=A0=C2=A0 job_progress_set_remaining(&job->common.job, job->le=
n);
>> +
>> +=C2=A0=C2=A0=C2=A0 return &job->common;
>> +}
>> diff --git a/blockjob.c b/blockjob.c
>> index 5d63b1e89d..7e450372bd 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -56,7 +56,8 @@ static bool is_block_job(Job *job)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return job_type(job) =3D=3D JOB_TYPE_BACK=
UP ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 job_type(job) =3D=3D JOB_TYPE_COMMIT ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 job_type(job) =3D=3D JOB_TYPE_MIRROR ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type(j=
ob) =3D=3D JOB_TYPE_STREAM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type(j=
ob) =3D=3D JOB_TYPE_STREAM ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_type(j=
ob) =3D=3D JOB_TYPE_BITMAP_POPULATE;
>> =C2=A0 }
>> =C2=A0 =C2=A0 BlockJob *block_job_next(BlockJob *bjob)
>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>> index 3bcb35c81d..f3cfc89d90 100644
>> --- a/block/Makefile.objs
>> +++ b/block/Makefile.objs
>> @@ -36,6 +36,7 @@ block-obj-$(CONFIG_LIBSSH) +=3D ssh.o
>> =C2=A0 block-obj-y +=3D accounting.o dirty-bitmap.o
>> =C2=A0 block-obj-y +=3D write-threshold.o
>> =C2=A0 block-obj-y +=3D backup.o
>> +block-obj-y +=3D bitmap-alloc.o
>> =C2=A0 block-obj-$(CONFIG_REPLICATION) +=3D replication.o
>> =C2=A0 block-obj-y +=3D throttle.o copy-on-read.o
>> =C2=A0 block-obj-y +=3D block-copy.o
>>
>=20
>=20

Thanks for the review. I'll start making changes, but won't send V2 just
yet.

--js


