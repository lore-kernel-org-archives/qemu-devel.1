Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A036CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB09D217D9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdZ/WHpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB09D217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQU4G-0003q7-7K
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQU2h-0002TV-2Q
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQU2f-0006wX-4Z
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:20:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55072
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQU2d-0006oK-5A
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572603625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tn0qY2v1kZqJdrAZR/etDW1mL8viDRUaSeC6R1tF1nY=;
 b=PdZ/WHpwvY21KDaM/tphhCS3/KaaADlstihkvSVlYgksXftHfOdqHuomCrvTXkNID1FAna
 r69Y07rLqlKXUrHWSuzu8m04syEc42OsEw3LzI8H8PDFi1izZ7NpOUYJF2Dgf0sVs068Lg
 4GAnE3gaTtQOtc8uTRGl5f+rk1lWR1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-iQJgqHWCNnC7dXeRlfpJcw-1; Fri, 01 Nov 2019 06:20:21 -0400
X-MC-Unique: iQJgqHWCNnC7dXeRlfpJcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6159B800D49;
 Fri,  1 Nov 2019 10:20:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-28.ams2.redhat.com
 [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E16375D9E2;
 Fri,  1 Nov 2019 10:20:15 +0000 (UTC)
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
To: qemu-block@nongnu.org
References: <20191101100019.9512-1-mreitz@redhat.com>
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
Message-ID: <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
Date: Fri, 1 Nov 2019 11:20:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101100019.9512-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YToiYZeOuhXjMnR0LRmU3hm1Bh8mzKP1q"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YToiYZeOuhXjMnR0LRmU3hm1Bh8mzKP1q
Content-Type: multipart/mixed; boundary="xgNtGH2FuVQxdibo3mChFxs5cD70byf6W"

--xgNtGH2FuVQxdibo3mChFxs5cD70byf6W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 11:00, Max Reitz wrote:
> Hi,
>=20
> This series builds on the previous RFC.  The workaround is now applied
> unconditionally of AIO mode and filesystem because we don=E2=80=99t know =
those
> things for remote filesystems.  Furthermore, bdrv_co_get_self_request()
> has been moved to block/io.c.
>=20
> Applying the workaround unconditionally is fine from a performance
> standpoint, because it should actually be dead code, thanks to patch 1
> (the elephant in the room).  As far as I know, there is no other block
> driver but qcow2 in handle_alloc_space() that would submit zero writes
> as part of normal I/O so it can occur concurrently to other write
> requests.  It still makes sense to take the workaround for file-posix
> because we can=E2=80=99t really prevent that any other block driver will =
submit
> zero writes as part of normal I/O in the future.
>=20
> Anyway, let=E2=80=99s get to the elephant.
>=20
> From input by XFS developers
> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1765547#c7) it seems clear
> that c8bb23cbdbe causes fundamental performance problems on XFS with
> aio=3Dnative that cannot be fixed.  In other cases, c8bb23cbdbe improves
> performance or we wouldn=E2=80=99t have it.
>=20
> In general, avoiding performance regressions is more important than
> improving performance, unless the regressions are just a minor corner
> case or insignificant when compared to the improvement.  The XFS
> regression is no minor corner case, and it isn=E2=80=99t insignificant.  =
Laurent
> Vivier has found performance to decrease by as much as 88 % (on ppc64le,
> fio in a guest with 4k blocks, iodepth=3D8: 1662 kB/s from 13.9 MB/s).

Ah, crap.

I wanted to send this series as early today as possible to get as much
feedback as possible, so I=E2=80=99ve only started doing benchmarks now.

The obvious

$ qemu-img bench -t none -n -w -S 65536 test.qcow2

on XFS takes like 6 seconds on master, and like 50 to 80 seconds with
c8bb23cbdbe reverted.  So now on to guest tests...

(Well, and the question is still where the performance regression on
ppc64 comes from.)

Max

> Thus, I believe we should revert the commit for now (and most
> importantly for 4.1.1).  We can think about reintroducing it for 5.0,
> but that would require more extensive benchmarks on a variety of
> systems, and we must see how subclusters change the picture.
>=20
>=20
> I would have liked to do benchmarks myself before making this decision,
> but as far as I=E2=80=99m informed, patches for 4.1.1 are to be collected=
 on
> Monday, so we need to be quick.
>=20
>=20
> git-backport-diff against the RFC:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/4:[down] 'Revert "qcow2: skip writing zero buffers to empty COW areas=
"'
> 002/4:[----] [-C] 'block: Make wait/mark serialising requests public'
> 003/4:[down] 'block: Add bdrv_co_get_self_request()'
> 004/4:[0036] [FC] 'block/file-posix: Let post-EOF fallocate serialize'
>=20
>=20
> Max Reitz (4):
>   Revert "qcow2: skip writing zero buffers to empty COW areas"
>   block: Make wait/mark serialising requests public
>   block: Add bdrv_co_get_self_request()
>   block/file-posix: Let post-EOF fallocate serialize
>=20
>  qapi/block-core.json       |  4 +-
>  block/qcow2.h              |  6 ---
>  include/block/block_int.h  |  4 ++
>  block/file-posix.c         | 38 +++++++++++++++++
>  block/io.c                 | 42 +++++++++++++------
>  block/qcow2-cluster.c      |  2 +-
>  block/qcow2.c              | 86 --------------------------------------
>  block/trace-events         |  1 -
>  tests/qemu-iotests/060     |  7 +---
>  tests/qemu-iotests/060.out |  5 +--
>  10 files changed, 76 insertions(+), 119 deletions(-)
>=20



--xgNtGH2FuVQxdibo3mChFxs5cD70byf6W--

--YToiYZeOuhXjMnR0LRmU3hm1Bh8mzKP1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl28Bt0ACgkQ9AfbAGHV
z0BzNggAuEvQ1Ui4DQr5JOxmcq//xrmwgTl0iuLVsSBrXvup3R4r5S7brPgJAnLp
ELovSvWbNRYQA6UwViBS9Rq843FzTS0xW4ALPpHAuanMHQlgPkz4AfEOWZAf5NuC
yJAuAj7/vkwpHZTNlZ7XdB8c9pwrQx7N8TvtRcu3tgC1zENjiTS+k4x3tgT5EFf0
y09n4f1UTcT96Tspkb/lICBA8Jb73ii3YSS1QTcct5wDfO1UwEEO6TZsgL3CS1cX
x4JdRmQnx2cyE6X1dBb8HD17dkjo7lERzGu0geVIRi6qTpaSh4USta2w94Qtfmsl
5tVZHlmhUGwAlojc9Ol1iDk6QldnMA==
=wZOe
-----END PGP SIGNATURE-----

--YToiYZeOuhXjMnR0LRmU3hm1Bh8mzKP1q--


