Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E177C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C7B2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abLMgZUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C7B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAsDW-0004BF-Vd
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAsCl-0003UQ-7g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:58:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAsCi-0002au-Ga
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598435931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iiySV9C5EM+f4YkDo/KPhGCKP4X/bqH9kn3GhFDOUqI=;
 b=abLMgZUYZnxCUpCfG+TnB2A7F/yooXjgqPOj0VgSyFUuwa0d/AkAHxegg1lMlR5tR3feWR
 gyhgKFsB2/wb1KNdsWqtTy6nji/jgDhyS0DU7RydARl+vdQ95IOTJUmgg0T200IuvAAhds
 1bGZ+4iNqCcVoXn5JyLESUtRA7Vg1rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-13e9G0aNPFWWb0iIP4harA-1; Wed, 26 Aug 2020 05:58:47 -0400
X-MC-Unique: 13e9G0aNPFWWb0iIP4harA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ECBA18B9EC2;
 Wed, 26 Aug 2020 09:58:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-172.ams2.redhat.com
 [10.36.112.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 385241992F;
 Wed, 26 Aug 2020 09:58:41 +0000 (UTC)
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
 <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
 <9195846d-13ab-67d6-dae0-f29056577be1@virtuozzo.com>
 <3d155eaf-7365-70a7-f4fe-1abe88383087@redhat.com>
 <09281829-fbe3-7007-ca03-b57b6581c3bc@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <78c778e7-ee15-027e-aab5-4d7e9935e01d@redhat.com>
Date: Wed, 26 Aug 2020 11:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <09281829-fbe3-7007-ca03-b57b6581c3bc@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A54lFX8VyEFNT3JQ2nVhxfdqBHL8SRzM5"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A54lFX8VyEFNT3JQ2nVhxfdqBHL8SRzM5
Content-Type: multipart/mixed; boundary="OKu1Vx0cvcfZG3aKhoow0BDMdNMeXDTxR"

--OKu1Vx0cvcfZG3aKhoow0BDMdNMeXDTxR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.20 11:15, Vladimir Sementsov-Ogievskiy wrote:
> 26.08.2020 11:52, Max Reitz wrote:
>> On 26.08.20 08:49, Vladimir Sementsov-Ogievskiy wrote:
>>> 25.08.2020 18:11, Max Reitz wrote:
>>>> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>>>>> It's intended to be inserted between format and protocol nodes to
>>>>> preallocate additional space (expanding protocol file) on writes
>>>>> crossing EOF. It improves performance for file-systems with slow
>>>>> allocation.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>>> ---
>>>>> =C2=A0=C2=A0 docs/system/qemu-block-drivers.rst.inc |=C2=A0 26 +++
>>>>> =C2=A0=C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 20 +-
>>>>> =C2=A0=C2=A0 block/preallocate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 291
>>>>> +++++++++++++++++++++++++
>>>>> =C2=A0=C2=A0 block/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>>>>> =C2=A0=C2=A0 4 files changed, 337 insertions(+), 1 deletion(-)
>>>>> =C2=A0=C2=A0 create mode 100644 block/preallocate.c
>>
>> [...]
>>
>>>>> diff --git a/block/preallocate.c b/block/preallocate.c
>>>>> new file mode 100644
>>>>> index 0000000000..bdf54dbd2f
>>>>> --- /dev/null
>>>>> +++ b/block/preallocate.c
>>>>> @@ -0,0 +1,291 @@
>>>>> +/*
>>>>> + * preallocate filter driver
>>>>> + *
>>>>> + * The driver performs preallocate operation: it is injected above
>>>>> + * some node, and before each write over EOF it does additional
>>>>> preallocating
>>>>> + * write-zeroes request.
>>>>> + *
>>>>> + * Copyright (c) 2020 Virtuozzo International GmbH.
>>>>> + *
>>>>> + * Author:
>>>>> + *=C2=A0 Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or
>>>>> modify
>>>>> + * it under the terms of the GNU General Public License as
>>>>> published by
>>>>> + * the Free Software Foundation; either version 2 of the License, or
>>>>> + * (at your option) any later version.
>>>>> + *
>>>>> + * This program is distributed in the hope that it will be useful,
>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e
>>>>> + * GNU General Public License for more details.
>>>>> + *
>>>>> + * You should have received a copy of the GNU General Public License
>>>>> + * along with this program. If not, see
>>>>> <http://www.gnu.org/licenses/>.
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +
>>>>> +#include "qapi/error.h"
>>>>> +#include "qemu/module.h"
>>>>> +#include "qemu/option.h"
>>>>> +#include "qemu/units.h"
>>>>> +#include "block/block_int.h"
>>>>> +
>>>>> +
>>>>> +typedef struct BDRVPreallocateState {
>>>>> +=C2=A0=C2=A0=C2=A0 int64_t prealloc_size;
>>>>> +=C2=A0=C2=A0=C2=A0 int64_t prealloc_align;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Filter is started as not-active, so it do=
esn't do any
>>>>> preallocations nor
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * requires BLK_PERM_RESIZE on its child. Th=
is is needed to
>>>>> create filter
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * above another node-child and then do bdrv=
_replace_node to
>>>>> insert the
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * filter.
>>>>
>>>> A bit weird, but seems fair.=C2=A0 It=E2=80=99s basically just a cache=
 for whether
>>>> this node has a writer on it or not.
>>>>
>>>> Apart from the weirdness, I don=E2=80=99t understand the =E2=80=9Canot=
her node-child=E2=80=9D.
>>>> Say you have =E2=80=9Cformat=E2=80=9D -> =E2=80=9Cproto=E2=80=9D, and =
then you want to insert
>>>> =E2=80=9Cprealloc=E2=80=9D.=C2=A0 Wouldn=E2=80=99t you blockdev-add pr=
ealloc,file=3Dproto and then
>>>> blockdev-replace format.file=3Dprealloc?
>>>
>>> Yes something like this. Actually, I'm about inserting the filter
>>> automatically from block layer code, but your reasoning is about same
>>> thing and is better.
>>>
>>>> So what is that =E2=80=9Cother node-child=E2=80=9D?
>>>
>>> Hmm, just my misleading wording. At least '-' in wrong place. Just
>>> "other node child", or "child of another node"..
>>
>> OK.
>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Filter becomes active the first time it d=
etects that its
>>>>> parents have
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * BLK_PERM_RESIZE on it.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Filter becomes active forever: it doesn't=
 lose active status
>>>>> if parents
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * lose BLK_PERM_RESIZE, otherwise we'll not=
 be able to shrink
>>>>> the file on
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * filter close.
>>>>
>>>> Oh, the file is shrunk?=C2=A0 That wasn=E2=80=99t clear from the docum=
entation.
>>>>
>>>> Hm.=C2=A0 Seems like useful behavior.=C2=A0 I just wonder if keeping t=
he
>>>> permission around indefinitely makes sense.=C2=A0 Why not just truncat=
e it
>>>> when the permission is revoked?
>>>
>>> How? Parent is closed earlier, so on close we will not have the
>>> permission. So, we force-keep the permission up to our close().
>>
>> I thought that preallocate_child_perm() would be invoked when the parent
>> is detached, so we could do the truncate there, before relinquishing
>> preallocate=E2=80=99s RESIZE permission.
>>
>=20
> Hmm, I can check it. I just a bit afraid of doing something serious like
> truncation in .bdrv_child_perm() handler, which doesn't seem to imply
> such usage.

I=E2=80=99m a bit conflicted.  On one hand, I share your concern.  On the o=
ther,
I find it completely reasonable that drivers might want to do I/O when
permissions change.

Usually, this is done as part of reopen, like in qcow2 when a drive
changes from R/W to RO and caches need to be flushed.  But I actually
think it makes more sense as part of the permission system, because of
course a reopen is not the only time when permissions can change.

So that would be another alternative, to implement
.bdrv_reopen_prepare(), and to check reopen_state->perm there.  If
RESIZE is about to go away, then we truncate.  We could keep track of
whether we did any preallocations after the last such truncate, and if
we did, do another truncate on close.

This would cover reopen at least.  Seems better than nothing, but, well...

(One big problem I see with truncating in .bdrv_child_perm() is that
that function is in no way committing.  It=E2=80=99s just a request: =E2=80=
=9CIf your
parents need this of you, what do you need of your children?=E2=80=9D
But I think that could be addressed by doing it in .bdrv_set_perm()
instead.  Of note is that file-posix actually does do I/O in its
raw_set_perm() function, in that it commits to file locks.)

[...]

>>>>> +static int coroutine_fn
>>>>> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo=
ol exact, PreallocMode prealloc,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bd=
rvRequestFlags flags, Error **errp)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 BDRVPreallocateState *s =3D bs->opaque;
>>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D bdrv_co_truncate(bs->file, offset, ex=
act, prealloc,
>>>>> flags, errp);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* s->data_end may become negative here, which me=
ans unknown
>>>>> data end */
>>>>> +=C2=A0=C2=A0=C2=A0 s->data_end =3D bdrv_getlength(bs->file->bs);
>>>>
>>>> What would be the problem with just setting data_end =3D offset?=C2=A0=
 We only
>>>> use data_end to truncate down on close, so basically repeat the
>>>> bdrv_co_truncate() call here, which seems correct.
>>>
>>> We can use offset only if ret >=3D 0 && exact is true..
>>
>> Well, on close, we ignore any errors from truncate() anyway.=C2=A0 So ev=
en if
>> we used exact=3Dfalse here, it shouldn=E2=80=99t matter.
>=20
> Here we handle truncate from user. If I understand "exact" correctly the
> following is possible:
>=20
> 1. parent does truncate 1M -> 2M, exact=3Dfalse
> 2. driver decides to truncate to 5M (exact condition is sutisfied)
> 3. but we remember s->data_end =3D 2M, and on close will shrink to 2M

In theory, yes; in practice, exact=3Dfalse just means to ignore failures
due to unsupported sizes.  So in this example, the driver would have
resized to 5M because 2M is an impossible size, and thus the shrink on
close would just fail.

> Doesn't seem a real problem.. So, we just consider the preallocation
> done by driver as our preallocation to be dropped on close().
>=20
> Could there be problems on user shrink?
>=20
> 1. parent does truncate 2M -> 1M, exact=3Dfalse
> 2. driver decides to do notihng (why not)
> 3. on close() we'll shrink to 1M..
>=20
> Again, seems no real problems.

Same as above, in practice the only difference between exact=3Dfalse and
exact=3Dtrue is how failures are reported.

> But in case when bdrv_co_truncate failed, we should call bdrv_getlength
> anyway, as we don't know the result of failed truncation. Or we can just
> set s->data_end =3D -1, and not care too much about fail-scenarios.
>=20
> So, probably we can do
> s->data_end =3D ret < 0 : ret : offset;
>=20
> But I just feel safer with additional bdrv_getlength().

Yes, let=E2=80=99s just leave it as you wrote it.

(It=E2=80=99s a bit silly of me to argue based on how drivers handle exact=
=3Dfalse
in practice right now.  It can always change.  Also, I shouldn=E2=80=99t pr=
etend
calling bdrv_getlength() would be an issue whatsoever, because it just
isn=E2=80=99t.)

Max


--OKu1Vx0cvcfZG3aKhoow0BDMdNMeXDTxR--

--A54lFX8VyEFNT3JQ2nVhxfdqBHL8SRzM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9GMk8ACgkQ9AfbAGHV
z0BmZgf/Zi/xhyrRkjeRsJj1NzH1WfOW5F1RWz2p0kDZQ7Y5hX2GJ2hquoXU2bGN
TVcD5ctvyTEWaczuWBGmXLdQ797XnRwGJ5+adruQhq04O1aj83Vm3hH7b5mCKWQa
fwWG0G6cTYuNkdVQZrdrkp5CKuZ9ZONUFkhhYw8YFI6riqJvugmL89rnXEhSIKS1
qD2h+3HDUvG/STASA0chSUWlDnTFLwqBdg0d1FVZ2ccrMVIbuOhoAfCmyb99ZEDt
+1HhUw1Qvz+0aqsqO1exd0VaWyeKqZxjZzmgqzIM+ADD93DDAvRq8HMW6s6c+5Ib
Kcmit/3J+FSHSSu9uLBeUltlUf++LQ==
=vn1q
-----END PGP SIGNATURE-----

--A54lFX8VyEFNT3JQ2nVhxfdqBHL8SRzM5--


