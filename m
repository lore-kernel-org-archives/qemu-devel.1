Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2413CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80DD2067D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+IPBaJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80DD2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQWAS-0002pB-S3
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 08:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQW8M-0000oz-0W
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQW8F-0000Gy-C2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:34:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQW8F-0000ED-4M
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572611656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B/oqnIuuUiJydHCRSvSm8WxsFTrAqc1Fop5XsDePvvs=;
 b=E+IPBaJD+wC1Wzd3o5Ow/jT2qZTV4z1fO2qUvMFod/Aa4wbmawSScrKf/Mwlny2CxzeA37
 5FhiJ54G3L96nExuwhKZBi/WGFRjscearTw1sCpNKZe/VOnVhnlHsyeISA+RhJnPhZ7qyn
 joMhIxKKs9lfZF7qFyl30//+3yO4d1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-PQsXpAXfOc-Mq2Gw_IXGig-1; Fri, 01 Nov 2019 08:34:12 -0400
X-MC-Unique: PQsXpAXfOc-Mq2Gw_IXGig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C20CF6BF;
 Fri,  1 Nov 2019 12:34:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-28.ams2.redhat.com
 [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FBA71001DC2;
 Fri,  1 Nov 2019 12:34:07 +0000 (UTC)
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
 <783a805a-3a3a-e8c5-41ac-f6476378975e@virtuozzo.com>
 <908ffc42-8328-969d-641b-4596ec0b6b45@redhat.com>
 <fb5ae941-622f-c82d-9eb8-be3fe66e3fb6@virtuozzo.com>
 <909d8474-0e8f-b9b9-5647-b604f956900a@redhat.com>
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
Message-ID: <c252753e-c67a-be46-1136-d0d7d9e642e7@redhat.com>
Date: Fri, 1 Nov 2019 13:34:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <909d8474-0e8f-b9b9-5647-b604f956900a@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oUaCt2mHLloCUFA0EdPS0DDDUJu4wtJ6y"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oUaCt2mHLloCUFA0EdPS0DDDUJu4wtJ6y
Content-Type: multipart/mixed; boundary="mdtxewBVWOIgUXAA68XdtebdfkcoZYz31"

--mdtxewBVWOIgUXAA68XdtebdfkcoZYz31
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 12:20, Max Reitz wrote:
> On 01.11.19 12:16, Vladimir Sementsov-Ogievskiy wrote:
>> 01.11.2019 14:12, Max Reitz wrote:
>>> On 01.11.19 11:28, Vladimir Sementsov-Ogievskiy wrote:
>>>> 01.11.2019 13:20, Max Reitz wrote:
>>>>> On 01.11.19 11:00, Max Reitz wrote:
>>>>>> Hi,
>>>>>>
>>>>>> This series builds on the previous RFC.  The workaround is now appli=
ed
>>>>>> unconditionally of AIO mode and filesystem because we don=E2=80=99t =
know those
>>>>>> things for remote filesystems.  Furthermore, bdrv_co_get_self_reques=
t()
>>>>>> has been moved to block/io.c.
>>>>>>
>>>>>> Applying the workaround unconditionally is fine from a performance
>>>>>> standpoint, because it should actually be dead code, thanks to patch=
 1
>>>>>> (the elephant in the room).  As far as I know, there is no other blo=
ck
>>>>>> driver but qcow2 in handle_alloc_space() that would submit zero writ=
es
>>>>>> as part of normal I/O so it can occur concurrently to other write
>>>>>> requests.  It still makes sense to take the workaround for file-posi=
x
>>>>>> because we can=E2=80=99t really prevent that any other block driver =
will submit
>>>>>> zero writes as part of normal I/O in the future.
>>>>>>
>>>>>> Anyway, let=E2=80=99s get to the elephant.
>>>>>>
>>>>>>   From input by XFS developers
>>>>>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1765547#c7) it seems =
clear
>>>>>> that c8bb23cbdbe causes fundamental performance problems on XFS with
>>>>>> aio=3Dnative that cannot be fixed.  In other cases, c8bb23cbdbe impr=
oves
>>>>>> performance or we wouldn=E2=80=99t have it.
>>>>>>
>>>>>> In general, avoiding performance regressions is more important than
>>>>>> improving performance, unless the regressions are just a minor corne=
r
>>>>>> case or insignificant when compared to the improvement.  The XFS
>>>>>> regression is no minor corner case, and it isn=E2=80=99t insignifica=
nt.  Laurent
>>>>>> Vivier has found performance to decrease by as much as 88 % (on ppc6=
4le,
>>>>>> fio in a guest with 4k blocks, iodepth=3D8: 1662 kB/s from 13.9 MB/s=
).
>>>>>
>>>>> Ah, crap.
>>>>>
>>>>> I wanted to send this series as early today as possible to get as muc=
h
>>>>> feedback as possible, so I=E2=80=99ve only started doing benchmarks n=
ow.
>>>>>
>>>>> The obvious
>>>>>
>>>>> $ qemu-img bench -t none -n -w -S 65536 test.qcow2
>>>>>
>>>>> on XFS takes like 6 seconds on master, and like 50 to 80 seconds with
>>>>> c8bb23cbdbe reverted.  So now on to guest tests...
>>>>
>>>> Aha, that's very interesting) What about aio-native which should be sl=
owed down?
>>>> Could it be tested like this?
>>>
>>> That is aio=3Dnative (-n).
>>>
>>> But so far I don=E2=80=99t see any significant difference in guest test=
s (i.e.,
>>> fio --rw=3Dwrite --bs=3D4k --iodepth=3D8 --runtime=3D1m --direct=3D1
>>> --ioengine=3Dlibaio --thread --numjobs=3D16 --size=3D2G --time_based), =
neither
>>> with 64 kB nor with 2 MB clusters.  (But only on XFS, I=E2=80=99ll have=
 to see
>>> about ext4 still.)
>>
>> hmm, this possibly mostly tests writes to already allocated clusters. Ha=
s fio
>> an option to behave like qemu-img bench with -S 65536, i.e. write once i=
nto
>> each cluster?
>=20
> Maybe, but is that a realistic depiction of whether this change is worth
> it?  That is why I=E2=80=99m doing the guest test, to see whether it actu=
ally
> has much impact on the guest.

I=E2=80=99ve changed the above fio invocation to use --rw=3Drandwrite and a=
dded
--fallocate=3Dnone.  The performance went down, but it went down both with
and without c8bb23cbdbe.

So on my XFS system (XFS on luks on SSD), I see:
- with c8bb23cbdbe: 26.0 - 27.9 MB/s
- without c8bb23cbdbe: 25.6 - 27 MB/s

On my ext4 system (native on SSD), I see:
- with: 39.4 - 41.5 MB/s
- without: 39.4 - 42.0 MB/s

So basically no difference for XFS, and really no difference for ext4.
(I ran these tests with 2 MB clusters.)

Max


--mdtxewBVWOIgUXAA68XdtebdfkcoZYz31--

--oUaCt2mHLloCUFA0EdPS0DDDUJu4wtJ6y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl28Jj0ACgkQ9AfbAGHV
z0CT8QgAxDL7PA0FMoYEf8EssrhWrrMfeOwZ/i7YdS8TsYjiHN2QcZnCCY8SWPTo
KDpIGqVUgoGPLXxJecyvBxh/xpR62OOGzSL4gzKTUQfvs5r7REZIBlDDhlMOw+FF
W3O3nNijx3wDLWq5n0euZCnjWcY3wwXJKc46beXB9QqlBwcWXgFCnhz6p9zWixil
DGUTWsx66GhM+J5kpT1a+cGQYPlf3hdt4DyPM9DfZ3bI6jPfeWp7+gltJutRzuOz
5JLj2awCHfgWkY/BDLr9tG6VY6/glJxaZ7Oy60JoFHU/7oGlGEvp47DprLCZNgfl
vbqSNKk5nnzDSHyzEYB/jt1e3ZczkA==
=uHxm
-----END PGP SIGNATURE-----

--oUaCt2mHLloCUFA0EdPS0DDDUJu4wtJ6y--


