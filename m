Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D2C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF7720733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJuFUcDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF7720733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVY1K-0003S1-6q
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 04:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iVXyY-0006DY-G4
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 04:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iVXyT-0000GL-FS
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 04:33:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iVXyQ-0000Fs-F8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 04:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573810380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hkp7AKMzmVvzO4AUhRoD82yXAuQPk3hwZd5HEWueR+Q=;
 b=OJuFUcDrgVuHAPj+dCq7MMbh7mqY4eyuHWDCiumWmUiAMvk/D125jaN7PI3NIm6MxKwvvG
 NvMw2AfRWE3znHDs12ryjjcQYItZX+eprIoHgBnAHFhJgilQI5QMN1TjjRXNyVIuGM08l9
 9e4XufjABc0VO5WM/PcXYFRLGiHE/kY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-S_67Wo24Pua1pmrBOlvRDA-1; Fri, 15 Nov 2019 04:32:57 -0500
X-MC-Unique: S_67Wo24Pua1pmrBOlvRDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF635107ACCC;
 Fri, 15 Nov 2019 09:32:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-227.ams2.redhat.com
 [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1AD41001E91;
 Fri, 15 Nov 2019 09:32:53 +0000 (UTC)
Subject: Re: [PATCH v7 1/3] block: introduce compress filter driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1573670589-229357-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1573670589-229357-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a5dd3514-a804-6c63-2158-0dff9ac37ab3@redhat.com>
 <96bda153-8923-41fb-5374-10711098901d@virtuozzo.com>
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
Message-ID: <dcc46a1b-cd8a-78e3-6353-bf9fb2210d9b@redhat.com>
Date: Fri, 15 Nov 2019 10:32:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <96bda153-8923-41fb-5374-10711098901d@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CY6XQIwwoKWvpm1bvlkDTNnIm1sxBMsOw"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CY6XQIwwoKWvpm1bvlkDTNnIm1sxBMsOw
Content-Type: multipart/mixed; boundary="0dpnpIwNTPi3Jge8t98tifpcoNLoFevci"

--0dpnpIwNTPi3Jge8t98tifpcoNLoFevci
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.19 12:59, Vladimir Sementsov-Ogievskiy wrote:
> 14.11.2019 14:27, Max Reitz wrote:
>> On 13.11.19 19:43, Andrey Shinkevich wrote:
>>> Allow writing all the data compressed through the filter driver.
>>> The written data will be aligned by the cluster size.
>>> Based on the QEMU current implementation, that data can be written to
>>> unallocated clusters only. May be used for a backup job.
>>>
>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/Makefile.objs     |   1 +
>>>   block/filter-compress.c | 201 +++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>   qapi/block-core.json    |  10 ++-
>>>   3 files changed, 208 insertions(+), 4 deletions(-)
>>>   create mode 100644 block/filter-compress.c
>>>
>>> diff --git a/block/Makefile.objs b/block/Makefile.objs
>>> index e394fe0..330529b 100644
>>> --- a/block/Makefile.objs
>>> +++ b/block/Makefile.objs
>>> @@ -43,6 +43,7 @@ block-obj-y +=3D crypto.o
>>>  =20
>>>   block-obj-y +=3D aio_task.o
>>>   block-obj-y +=3D backup-top.o
>>> +block-obj-y +=3D filter-compress.o
>>>  =20
>>>   common-obj-y +=3D stream.o
>>>  =20
>>> diff --git a/block/filter-compress.c b/block/filter-compress.c
>>> new file mode 100644
>>> index 0000000..64b1ee5
>>> --- /dev/null
>>> +++ b/block/filter-compress.c
>>> @@ -0,0 +1,201 @@
>>> +/*
>>> + * Compress filter block driver
>>> + *
>>> + * Copyright (c) 2019 Virtuozzo International GmbH
>>> + *
>>> + * Author:
>>> + *   Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> + *   (based on block/copy-on-read.c by Max Reitz)
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation; either version 2 or
>>> + * (at your option) any later version of the License.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program; if not, see <http://www.gnu.org/licenses/>=
.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "block/block_int.h"
>>> +#include "qemu/module.h"
>>> +
>>> +
>>> +static int compress_open(BlockDriverState *bs, QDict *options, int fla=
gs,
>>> +                         Error **errp)
>>> +{
>>> +    bs->backing =3D bdrv_open_child(NULL, options, "file", bs, &child_=
file, false,
>>> +                                  errp);
>>
>> Please don=92t attach something that the QAPI schema calls =93file=94 as
>> bs->backing.
>=20
>=20
> Agree, it's a mistake. If we want backing and user set backing in options=
, it's opened automatically, I think..
>=20
>>
>> Yes, attaching it as bs->file would break backing chains.  That=92s a bu=
g
>> in the block layer.  I=92ve been working on a fix for a long time.
>>
>> Please don=92t introduce more weirdness just because we have a bug in th=
e
>> block layer.
>>
>> (Note that I=92d strongly oppose calling the child =93backing=94 in the =
QAPI
>> schema, as this would go against what all other user-creatable filters d=
o.)
>>
>=20
> So, are you opposite to correct backing-based user-creatable filter (with=
 backing both
> in QAPI and code)?

I=92m not opposed to fixing it, but I don=92t think the fix is to make all
filters use bs->backing.

> Do you think, that if we make backup-top to be user-creatable, we should =
move it to be
> file-child-based, or support both backing and file child?

I definitely don=92t think it would be wrong.

It depends on how difficult it is.  I=92m currently working on (more
groundwork for the filter series v7) a series to rework BdrvChildRole so
we can see from it what a child is used for (data, metadata, filter,
COW).  I can already see that it won=91t work out perfectly because
whenever we attach "backing", the question is whether that=92s a COW child
now or whether it=92s a filtered child.  I suppose I=92m going to guess COW
when there=92s no way to get the information, and maybe sometimes be wrong.

In my honest opinion, reusing bs->backing for filters was wrong.  I=92m
not saying that bs->file was any better.  But I have a bit of a gripe
with filters using bs->backing, because it=92s acknowledging a bug but not
fixing it at the same time.  Had we fixed the bug when we first noticed
it with the introduction of the mirror filter, maybe we wouldn=92t be in
this position now.  Or maybe we should have just added a bs->filtered link.

But maybes aside, it still means that using bs->backing instead of
bs->file is not really better.  Right now it=92s both wrong, and we need
to fix the block layer so it isn=92t.

So what to do for new filters?  Sure, bs->backing works around a bug
now.  But it=92ll be weird once the bug is fixed.  Then we=92ll have filter=
s
that use @file and others will use @backing.  I don=92t think we want
that, I think we want a uniform interface for all filters.

And yes, that implies we probably should change backup-top to use file
instead of backing once it gets an external interface.

(Compare
https://lists.nongnu.org/archive/html/qemu-block/2017-09/msg00380.html
)

Max


--0dpnpIwNTPi3Jge8t98tifpcoNLoFevci--

--CY6XQIwwoKWvpm1bvlkDTNnIm1sxBMsOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3OcMMACgkQ9AfbAGHV
z0B18Af9HMHTZEvRkxLFjABkiESVC6DNb0NUuxdLJCkbUqdRoZneIIcL31gvYCl5
GA4uOLXHS5ynx9UFfmLGvbPI/NiI0psUlbwyJGrO8+wuv+f+pu7LV5iZxp+jRVB/
EHKOgwOdlSjdLrcB0BoJF+2bIAdv10BkeYuoGVLbclEJI2wzWu5bkTC8PU18HI8j
EdWtynLQTIRYZUlb+oT04P9RM0TblcysSnErmfEjrbpX8jIVXimmsdl/h+jsb/Pr
g90THTpQNNnU5wdchlTaanJ/tgSZ6sSHvbm1YKpdTlborO8wQyCBjrghuG98N2G+
AsQ2pHsh1R1m64ygSE2VB3IL/PrP4Q==
=topr
-----END PGP SIGNATURE-----

--CY6XQIwwoKWvpm1bvlkDTNnIm1sxBMsOw--


