Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9841DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DFD20855
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkMH7nEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DFD20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37575 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiD7-0003eq-KF
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iXiC2-0002K1-8W
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iXiBz-0007I7-HF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:52:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45891
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iXiBz-0007Hu-5u
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574326318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=izK3Gk1u9VBV0mWkmCBSEHGDNv7gt5vEGRXuWCieFGA=;
 b=IkMH7nEmzvErUuttmdbQaY+on2eNwBQbkMnz3JHZRGwppAKsl9rW+GIOdczvmGVDt9U2JM
 ayz7XjEoYRUaq+j3+6Lft6KVwbfQ3fqgsG8p0pc07IyievmgwcNJL521I0snClcFbBKzzk
 HL0Vr1rkRxQykDQo7ezksweriL7FM2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-7I43-rFRMD2UJHebS3_yfA-1; Thu, 21 Nov 2019 03:51:56 -0500
X-MC-Unique: 7I43-rFRMD2UJHebS3_yfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7338C801E5D;
 Thu, 21 Nov 2019 08:51:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-196.ams2.redhat.com
 [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B40BC66839;
 Thu, 21 Nov 2019 08:51:53 +0000 (UTC)
Subject: Re: qcow2 preallocation and backing files
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191120120625.GA25497@igalia.com>
 <a1575e90-3fe4-e843-518c-714db4b621bc@virtuozzo.com>
 <w517e3u8tks.fsf@maestria.local.igalia.com>
 <5b57fb5b-4480-2b39-9c60-bbd63f13f1cb@virtuozzo.com>
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
Message-ID: <78235737-2182-f126-af84-151b1e01b803@redhat.com>
Date: Thu, 21 Nov 2019 09:51:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5b57fb5b-4480-2b39-9c60-bbd63f13f1cb@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g510DDqpNQ65IvlolNyvakwKV1pQbRzON"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g510DDqpNQ65IvlolNyvakwKV1pQbRzON
Content-Type: multipart/mixed; boundary="upATMp6S9iD6mPkgRfGK514WqNu8GAgmb"

--upATMp6S9iD6mPkgRfGK514WqNu8GAgmb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.11.19 16:58, Vladimir Sementsov-Ogievskiy wrote:
> 20.11.2019 18:18, Alberto Garcia wrote:
>> On Wed 20 Nov 2019 01:27:53 PM CET, Vladimir Semeeausntsov-Ogievskiy wro=
te:
>>
>>> 3. Also, the latter way is inconsistent with discard. Discarded
>>> regions returns zeroes, not clusters from backing. I think discard and
>>> truncate should behave in the same safe zero way.
>>
>> But then PREALLOC_MODE_OFF implies that the L2 metadata should be
>> preallocated (all clusters should be QCOW2_CLUSTER_ZERO_PLAIN), at least
>> when there is a backing file.
>>
>> Or maybe we just forbid PREALLOC_MODE_OFF during resize if there is a
>> backing file ?
>>
>=20
> Kevin proposed a fix that alters PREALLOC_MODE_OFF behavior if there is
> a backing file, to allocate L2 metadata with ZERO clusters..
>=20
> I don't think that it's the best thing to do, but it's already done, it w=
orks
> and seems appropriate for rc3..
>=20
> I see now, that change PREALLOC_MODE_OFF behavior may break things, first=
 of
> all qemu-img create, which creating UNALLOCATED qcow2 by default for year=
s.
>=20
> Still, I think that it would be safer to always ZERO expanded part of qco=
w2,
> regardless of backing file..
>=20
> We may add PREALLOC_MODE_ZERO, and use it in mirror, commit, and some oth=
er calls
> to bdrv_truncate, except for qcow2 image creation of course.

Well, the good news is that block_resize currently has no such parameter
and thus we could make a non-OFF value the default.

The bad news is that the reason it has no such parameter is that it
would need to be a job in order to support any form of preallocation.

So actually I don=E2=80=99t think we can make block_resize write zeroes to =
the
new region by default, because then it needs to be a job, and it just
isn=E2=80=99t.  (Of course, we can get to it through a deprecation cycle, b=
ut we
can=E2=80=99t =E2=80=9Cfix=E2=80=9D block_resize directly.)

Max


--upATMp6S9iD6mPkgRfGK514WqNu8GAgmb--

--g510DDqpNQ65IvlolNyvakwKV1pQbRzON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3WUCcACgkQ9AfbAGHV
z0CFgwf8Ci1dsKKJbL5LxaQca14LmK4vqBgGf40RDFCv++0OuK4H2RpplIGxi3uN
LI/bdtaGIqohQ/zwNMEviskeITcoArw9TKYhoxla/pyemz84XS4+KC1jVxK29aQM
yqoDTcb3qoGmen9lFifcPOORSvIXFjqu8jfeD1KHA0YG0XWSI3HzSY49CHcbFWKd
5EO1hPu08nssfar1B0dRRmBrWwhiZb37budfZDJlqOVmhGY0eHvJ8hzJ43yXzHJb
fLiw5s1+PVPI+fEgIUyUewdzn8npn7hu+oPHxvKwnrhCVtWoEKwo7XJtGmZoijlI
AKF4wxavJFlNtr7VvWU6MWvitX9h0A==
=W34d
-----END PGP SIGNATURE-----

--g510DDqpNQ65IvlolNyvakwKV1pQbRzON--


