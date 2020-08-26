Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1A3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E142071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XncMoxDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E142071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArBg-0000lE-QX
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kArB4-0008Od-10
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kArB1-0002Cf-Kt
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598431982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HtNZ3z9o/ZzsD1uvIUEvnytVOIuIsRCQResnXatWVk8=;
 b=XncMoxDzpUJHLo1YWvtbXk3vGSywAIU6JI9L4O7O8JqsXQdTtw1vCSaN6qcRm9NPIYAzdV
 cNuZUhift7/W/19/zHE6an2924gx1NmhzcfnOZD3/TJLBFnnU5SJHRNLGGy96jdKsDS0rX
 R4z9WSkjSqLNKF7fZ+afRVmLpYdAAUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-hUGTjRVKMEGZugLoIBN7Ng-1; Wed, 26 Aug 2020 04:52:58 -0400
X-MC-Unique: hUGTjRVKMEGZugLoIBN7Ng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A2DC873088;
 Wed, 26 Aug 2020 08:52:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-172.ams2.redhat.com
 [10.36.112.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A245E60C0F;
 Wed, 26 Aug 2020 08:52:52 +0000 (UTC)
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
 <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com>
 <9195846d-13ab-67d6-dae0-f29056577be1@virtuozzo.com>
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
Message-ID: <3d155eaf-7365-70a7-f4fe-1abe88383087@redhat.com>
Date: Wed, 26 Aug 2020 10:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9195846d-13ab-67d6-dae0-f29056577be1@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="84XIIu7nM2QWlWb2Zt7HS0sj2YWrmD4If"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:45:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--84XIIu7nM2QWlWb2Zt7HS0sj2YWrmD4If
Content-Type: multipart/mixed; boundary="buSztraOhW0HcYvQSNgwgBOPpg7IpTElH"

--buSztraOhW0HcYvQSNgwgBOPpg7IpTElH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.20 08:49, Vladimir Sementsov-Ogievskiy wrote:
> 25.08.2020 18:11, Max Reitz wrote:
>> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>>> It's intended to be inserted between format and protocol nodes to
>>> preallocate additional space (expanding protocol file) on writes
>>> crossing EOF. It improves performance for file-systems with slow
>>> allocation.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 docs/system/qemu-block-drivers.rst.inc |=C2=A0 26 +++
>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
20 +-
>>> =C2=A0 block/preallocate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 291=
 +++++++++++++++++++++++++
>>> =C2=A0 block/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
>>> =C2=A0 4 files changed, 337 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644 block/preallocate.c

[...]

>>> diff --git a/block/preallocate.c b/block/preallocate.c
>>> new file mode 100644
>>> index 0000000000..bdf54dbd2f
>>> --- /dev/null
>>> +++ b/block/preallocate.c
>>> @@ -0,0 +1,291 @@
>>> +/*
>>> + * preallocate filter driver
>>> + *
>>> + * The driver performs preallocate operation: it is injected above
>>> + * some node, and before each write over EOF it does additional
>>> preallocating
>>> + * write-zeroes request.
>>> + *
>>> + * Copyright (c) 2020 Virtuozzo International GmbH.
>>> + *
>>> + * Author:
>>> + *=C2=A0 Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modif=
y
>>> + * it under the terms of the GNU General Public License as published b=
y
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program. If not, see <http://www.gnu.org/licenses/>=
.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +
>>> +#include "qapi/error.h"
>>> +#include "qemu/module.h"
>>> +#include "qemu/option.h"
>>> +#include "qemu/units.h"
>>> +#include "block/block_int.h"
>>> +
>>> +
>>> +typedef struct BDRVPreallocateState {
>>> +=C2=A0=C2=A0=C2=A0 int64_t prealloc_size;
>>> +=C2=A0=C2=A0=C2=A0 int64_t prealloc_align;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Filter is started as not-active, so it does=
n't do any
>>> preallocations nor
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * requires BLK_PERM_RESIZE on its child. This=
 is needed to
>>> create filter
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * above another node-child and then do bdrv_r=
eplace_node to
>>> insert the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * filter.
>>
>> A bit weird, but seems fair.=C2=A0 It=E2=80=99s basically just a cache f=
or whether
>> this node has a writer on it or not.
>>
>> Apart from the weirdness, I don=E2=80=99t understand the =E2=80=9Canothe=
r node-child=E2=80=9D.
>> Say you have =E2=80=9Cformat=E2=80=9D -> =E2=80=9Cproto=E2=80=9D, and th=
en you want to insert
>> =E2=80=9Cprealloc=E2=80=9D.=C2=A0 Wouldn=E2=80=99t you blockdev-add prea=
lloc,file=3Dproto and then
>> blockdev-replace format.file=3Dprealloc?
>=20
> Yes something like this. Actually, I'm about inserting the filter
> automatically from block layer code, but your reasoning is about same
> thing and is better.
>=20
>> So what is that =E2=80=9Cother node-child=E2=80=9D?
>=20
> Hmm, just my misleading wording. At least '-' in wrong place. Just
> "other node child", or "child of another node"..

OK.

>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Filter becomes active the first time it det=
ects that its
>>> parents have
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * BLK_PERM_RESIZE on it.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Filter becomes active forever: it doesn't l=
ose active status
>>> if parents
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * lose BLK_PERM_RESIZE, otherwise we'll not b=
e able to shrink
>>> the file on
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * filter close.
>>
>> Oh, the file is shrunk?=C2=A0 That wasn=E2=80=99t clear from the documen=
tation.
>>
>> Hm.=C2=A0 Seems like useful behavior.=C2=A0 I just wonder if keeping the
>> permission around indefinitely makes sense.=C2=A0 Why not just truncate =
it
>> when the permission is revoked?
>=20
> How? Parent is closed earlier, so on close we will not have the
> permission. So, we force-keep the permission up to our close().

I thought that preallocate_child_perm() would be invoked when the parent
is detached, so we could do the truncate there, before relinquishing
preallocate=E2=80=99s RESIZE permission.

[...]

>>> +static void preallocate_close(BlockDriverState *bs)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVPreallocateState *s =3D bs->opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->active && s->data_end >=3D 0 &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_getlength(bs->file->bs=
) > s->data_end)
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_truncate(bs->file, s->=
data_end, true,
>>> PREALLOC_MODE_OFF, 0, NULL);
>>
>> Now that I think more about it...=C2=A0 What if there are other writers =
on
>> bs->file?=C2=A0 This may throw data away.
>=20
> Good point. Actually, if bs->file has other writing parents, the logic
> of the filter
> around "data_end" is broken. So we must unshare WRITE and RESIZE
> permissions.

That=E2=80=99s certainly a heavy hammer, but it=E2=80=99d work.

>> =C2=A0Maybe BDS.wr_highest_offset can
>> help to make a better call?
>=20
> Anyway, we'll have to use wr_highest_offset of the filter not the child
> node
> (in the child wr_highest_offset will track preallocations as well),

That=E2=80=99s true.

> so we want to unshare WRITE/RESIZE permissions.

[...]

>>> +static int coroutine_fn
>>> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool =
exact, PreallocMode prealloc,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvR=
equestFlags flags, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVPreallocateState *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D bdrv_co_truncate(bs->file, offset, exac=
t, prealloc,
>>> flags, errp);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* s->data_end may become negative here, which mean=
s unknown
>>> data end */
>>> +=C2=A0=C2=A0=C2=A0 s->data_end =3D bdrv_getlength(bs->file->bs);
>>
>> What would be the problem with just setting data_end =3D offset?=C2=A0 W=
e only
>> use data_end to truncate down on close, so basically repeat the
>> bdrv_co_truncate() call here, which seems correct.
>=20
> We can use offset only if ret >=3D 0 && exact is true..

Well, on close, we ignore any errors from truncate() anyway.  So even if
we used exact=3Dfalse here, it shouldn=E2=80=99t matter.

> But simpler is
> just call
> bdrv_getlength() anyway.

Certainly simpler than thinking about potential edge cases, true.

Max


--buSztraOhW0HcYvQSNgwgBOPpg7IpTElH--

--84XIIu7nM2QWlWb2Zt7HS0sj2YWrmD4If
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9GIuMACgkQ9AfbAGHV
z0C5nQgAk7xYQDSxMVGa91vCBSs+fQ5zN/JKt2mznHrMCY9OMRtGJDDlReL57lCp
pYPfuoUJtNsCK0hSUHj4g07er0B5ptSYu+0CdkQczPhtZtZ5XS1NLObRL9i1xpTg
2Uec8k8ph2GEUPqCAnDXAEPldPdJ09JnUi/Xyh/m5eLQn/lulCtwDj6OvLgmXWCU
+Q5pGSdtp58mujbK9zlTyJo8AB9GAq+9uF+9NruxZ8nXpt5GSVJl4r9FMl2Wgn+h
zOu6bON/4OLJTYboonkT+lYz71dxvuClN60f3g3wL1h/CAieO4E2GPi9E53+vE4u
u7vMU57T0CAg352f6JXBtVnXlAAsuw==
=wLDZ
-----END PGP SIGNATURE-----

--84XIIu7nM2QWlWb2Zt7HS0sj2YWrmD4If--


