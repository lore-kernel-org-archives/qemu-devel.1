Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4D6C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9075D20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1F8MHcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9075D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7fj-0007nr-EW
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU7ez-000766-5O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU7ey-0004gm-F2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:47:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jU7ex-0004gT-WE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588247237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iqct4rY3zHf8fPceD9++W1yco7W9SUO9QLlVCEAkJZM=;
 b=c1F8MHcUQExe0cM/i6Zcu/F0XfPxdf0UumvlULtq/qa6QuWCGiEWSaVDy05SxYjFxvYhGp
 avZEcHFqCHTUog8jvg18ZksJnXp4qodYu/qFZuV/nI2tBI7H/nS8OeHtxBRdlsBHpSRDeO
 VwUeGRx83NOnCzLYAOyEFe27qhnX60U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-BMtyPWxdOe-hMuZeCdSUww-1; Thu, 30 Apr 2020 07:47:13 -0400
X-MC-Unique: BMtyPWxdOe-hMuZeCdSUww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D35919057A0;
 Thu, 30 Apr 2020 11:47:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-177.ams2.redhat.com
 [10.36.112.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 228076116D;
 Thu, 30 Apr 2020 11:47:08 +0000 (UTC)
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
 <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
 <feeec7a1-6987-18a1-1352-1512dc42824e@virtuozzo.com>
 <be6f57c0-23d9-6a6c-3a39-3a7132f23a42@redhat.com>
 <23f0a79a-6e8d-3702-3d82-9db54a442a5f@virtuozzo.com>
 <73ebc101-7148-2b38-492f-538d4bf8c8a4@redhat.com>
 <477e76fd-ff73-ac34-c636-c8d9ae6be30d@virtuozzo.com>
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
Message-ID: <22b2918b-3bdd-6627-a378-baddb342dacc@redhat.com>
Date: Thu, 30 Apr 2020 13:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <477e76fd-ff73-ac34-c636-c8d9ae6be30d@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yJ9xrMdXPTBrXfWJPiAYLAsmu8YKpdZGf"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yJ9xrMdXPTBrXfWJPiAYLAsmu8YKpdZGf
Content-Type: multipart/mixed; boundary="tI3Z0CANqtQ2ImVb74zjsIkYcoYEpkpSW"

--tI3Z0CANqtQ2ImVb74zjsIkYcoYEpkpSW
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.04.20 11:48, Denis Plotnikov wrote:
>=20
>=20
> On 30.04.2020 11:26, Max Reitz wrote:
>> On 29.04.20 15:02, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.04.2020 15:17, Max Reitz wrote:
>>>> On 29.04.20 12:37, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 29.04.2020 13:24, Max Reitz wrote:
>>>>>> On 28.04.20 22:00, Denis Plotnikov wrote:
>>>>>>> zstd significantly reduces cluster compression time.
>>>>>>> It provides better compression performance maintaining
>>>>>>> the same level of the compression ratio in comparison with
>>>>>>> zlib, which, at the moment, is the only compression
>>>>>>> method available.
>>>>>>>
>>>>>>> The performance test results:
>>>>>>> Test compresses and decompresses qemu qcow2 image with just
>>>>>>> installed rhel-7.6 guest.
>>>>>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>>>>>
>>>>>>> The test was conducted with brd disk to reduce the influence
>>>>>>> of disk subsystem to the test results.
>>>>>>> The results is given in seconds.
>>>>>>>
>>>>>>> compress cmd:
>>>>>>> =A0=A0=A0=A0 time ./qemu-img convert -O qcow2 -c -o
>>>>>>> compression_type=3D[zlib|zstd]
>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src.im=
g [zlib|zstd]_compressed.img
>>>>>>> decompress cmd
>>>>>>> =A0=A0=A0=A0 time ./qemu-img convert -O qcow2
>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [zlib|=
zstd]_compressed.img uncompressed.img
>>>>>>>
>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compression=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 decompression
>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 zlib=A0=A0=A0=A0=A0=A0 zstd=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 zlib=A0=A0=A0=A0=A0=A0=A0=A0 zstd
>>>>>>> ------------------------------------------------------------
>>>>>>> real=A0=A0=A0=A0 65.5=A0=A0=A0=A0=A0=A0 16.3 (-75 %)=A0=A0=A0 1.9=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.6 (-16 %)
>>>>>>> user=A0=A0=A0=A0 65.0=A0=A0=A0=A0=A0=A0 15.8=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 5.3=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.5
>>>>>>> sys=A0=A0=A0=A0=A0=A0 3.3=A0=A0=A0=A0=A0=A0=A0 0.2=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 2.0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.0
>>>>>>>
>>>>>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>>>>>> compressed image size in both cases: 1.4G
>>>>>>>
>>>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>>>> QAPI part:
>>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>>> ---
>>>>>>> =A0=A0=A0 docs/interop/qcow2.txt |=A0=A0 1 +
>>>>>>> =A0=A0=A0 configure=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
2 +-
>>>>>>> =A0=A0=A0 qapi/block-core.json=A0=A0 |=A0=A0 3 +-
>>>>>>> =A0=A0=A0 block/qcow2-threads.c=A0 | 169
>>>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>>> =A0=A0=A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 ++
>>>>>>> =A0=A0=A0 slirp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0=A0 2 +-
>>>>>>> =A0=A0=A0 6 files changed, 181 insertions(+), 3 deletions(-)
>>>>>> [...]
>>>>>>
>>>>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>>>>> index 7dbaf53489..a0b12e1b15 100644
>>>>>>> --- a/block/qcow2-threads.c
>>>>>>> +++ b/block/qcow2-threads.c
>>>>>> [...]
>>>>>>
>>>>>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void *src, size_t
>>>>>>> src_size)
>>>>>>> +{
>>>>>> [...]
>>>>>>
>>>>>>> +=A0=A0=A0 /*
>>>>>>> +=A0=A0=A0=A0 * The compressed stream from the input buffer may con=
sist of
>>>>>>> more
>>>>>>> +=A0=A0=A0=A0 * than one zstd frame.
>>>>>> Can it?
>>>>> If not, we must require it in the specification.
>>>> Actually, now that you mention it, it would make sense anyway to add
>>>> some note to the specification on what exactly compressed with zstd
>>>> means.
>>>>
>>>>> Hmm. If at some point
>>>>> we'll want multi-threaded compression of one big (2M) cluster.. Could
>>>>> this be implemented with zstd lib, if multiple frames are allowed,
>>>>> will
>>>>> allowing multiple frames help? I don't know actually, but I think
>>>>> better
>>>>> not to forbid it. On the other hand, I don't see any benefit in large
>>>>> compressed clusters. At least, in our scenarios (for compressed
>>>>> backups)
>>>>> we use 64k compressed clusters, for good granularity of incremental
>>>>> backups (when for running vm we use 1M clusters).
>>>> Is it really that important?=A0 Na=EFvely, it sounds rather complicate=
d to
>>>> introduce multithreading into block drivers.
>>> It is already here: compression and encryption already multithreaded.
>>> But of course, one cluster is handled in one thread.
>> Ah, good.=A0 I forgot.
>>
>>>> (Also, as for compression, it can only be used in backup scenarios
>>>> anyway, where you write many clusters at once.=A0 So parallelism on th=
e
>>>> cluster level should sufficient to get high usage, and it would benefi=
t
>>>> all compression types and cluster sizes.)
>>>>
>>> Yes it works in this way already :)
>> Well, OK then.
>>
>>> So, we don't know do we want one frame restriction or not. Do you have =
a
>>> preference?
>> *shrug*
>>
>> Seems like it would be preferential to allow multiple frames still.=A0 A
>> note in the spec would be nice (i.e., streaming format, multiple frames
>> per cluster possible).
>=20
> We don't mention anything about zlib compressing details in the spec.

Yep.  Which is bad enough.

> If we mention anything about ZSTD compressing details we'll have to do
> it for
> zlib as well.

I personally don=92t like =93If you can=92t make it perfect, you shouldn=92=
t do
it at all=94.  Mentioning it for zstd would still be an improvement.

Also, I believe that =93zlib compression=94 is pretty much unambiguous,
considering all the code does is call deflate()/inflate().

I=92m not saying we need to amend the spec in this series, but I don=92t se=
e
a good argument against doing so at some point.

> So, I think we have two possibilities for the spec:
> 1. mention for both
> 2. don't mention at all
>=20
> I think the 2nd is better. It gives more degree of freedom for the
> future improvements.

No, it absolutely doesn=92t.  There is a de-facto format, namely what qemu
accepts.  Changing that would be an incompatible change.  Just because
we don=92t write what=92s allowed into the spec doesn=92t change that fact.

> and we've already covered both cases (one frame, may frames) in the code.
There are still different zstd formats, namely streaming or not
streaming.  That=92s what should be mentioned.

Max


--tI3Z0CANqtQ2ImVb74zjsIkYcoYEpkpSW--

--yJ9xrMdXPTBrXfWJPiAYLAsmu8YKpdZGf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6quroACgkQ9AfbAGHV
z0B9xAf/cFGRpm6MM44I/c1AvmlRqsCOc3xdhcUS8EC5fdlzsPhltfuj1rjIomVT
R/PfYypRtw7vqBKbeTYs7ov0BPqDNR0jii82iDQiuaJcwiWRSycdx6sJ5gGy4Suy
rzGwkJybn16JX5PceR4/tWScdPsVkDn+dqL0BRg/6SKmxiiMswkZBnjNbu4BJF7N
eMxAO6+j7k3d1WzF6YO7Mg+IZpxG5RjEQxlwf9ibL/yRwfFsO9eYjGEHaNe2ZvwF
5h4p20SLtZ9ihLmL8ZCMMInWcK5Al76S8vrD/s8ekk21OPMkLMOuBXXDqwKfPUXR
g/WL/VaPPR5aMBbaVK3RzFJJBiAccQ==
=1oY7
-----END PGP SIGNATURE-----

--yJ9xrMdXPTBrXfWJPiAYLAsmu8YKpdZGf--


