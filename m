Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F1FC83006
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88B32073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU49Txrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88B32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4Y2-0002hf-1x
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU4X0-00012L-6f
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU4WQ-0005kJ-TS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:26:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jU4WQ-0005ey-EN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588235177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/QhOG++09dCXAroQEUcIPty5/OejOTRu5uDqcUPmavc=;
 b=FU49Txrq7L0m4vp8w59vRGAu1rW2U0zyfvMFPNJp2PgFOAQKhDT1v5jTJDCll7U4llhS6G
 HjcIcBsqkXmgr65GSj52VfLFJdpT0kCV1hZ0CHrShvT00Lc+qADw6EwD350dkhTZcqZteb
 K40qLqw0tM6DFsltIxCSNWRJpMcMWtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-Hd2KO_76Mo6BPPBtprl2xA-1; Thu, 30 Apr 2020 04:26:12 -0400
X-MC-Unique: Hd2KO_76Mo6BPPBtprl2xA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A6268014D6;
 Thu, 30 Apr 2020 08:26:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-177.ams2.redhat.com
 [10.36.112.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04B102855B;
 Thu, 30 Apr 2020 08:26:06 +0000 (UTC)
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
 <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
 <feeec7a1-6987-18a1-1352-1512dc42824e@virtuozzo.com>
 <be6f57c0-23d9-6a6c-3a39-3a7132f23a42@redhat.com>
 <23f0a79a-6e8d-3702-3d82-9db54a442a5f@virtuozzo.com>
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
Message-ID: <73ebc101-7148-2b38-492f-538d4bf8c8a4@redhat.com>
Date: Thu, 30 Apr 2020 10:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <23f0a79a-6e8d-3702-3d82-9db54a442a5f@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3mBCjFW98SzB9s1vI1oQyTwIaL9mtpy0L"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3mBCjFW98SzB9s1vI1oQyTwIaL9mtpy0L
Content-Type: multipart/mixed; boundary="UYQb2UJGxeTWCYce0x1MiEOhfzXvWOO1h"

--UYQb2UJGxeTWCYce0x1MiEOhfzXvWOO1h
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.04.20 15:02, Vladimir Sementsov-Ogievskiy wrote:
> 29.04.2020 15:17, Max Reitz wrote:
>> On 29.04.20 12:37, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.04.2020 13:24, Max Reitz wrote:
>>>> On 28.04.20 22:00, Denis Plotnikov wrote:
>>>>> zstd significantly reduces cluster compression time.
>>>>> It provides better compression performance maintaining
>>>>> the same level of the compression ratio in comparison with
>>>>> zlib, which, at the moment, is the only compression
>>>>> method available.
>>>>>
>>>>> The performance test results:
>>>>> Test compresses and decompresses qemu qcow2 image with just
>>>>> installed rhel-7.6 guest.
>>>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>>>
>>>>> The test was conducted with brd disk to reduce the influence
>>>>> of disk subsystem to the test results.
>>>>> The results is given in seconds.
>>>>>
>>>>> compress cmd:
>>>>> =A0=A0=A0 time ./qemu-img convert -O qcow2 -c -o
>>>>> compression_type=3D[zlib|zstd]
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 src.img [zl=
ib|zstd]_compressed.img
>>>>> decompress cmd
>>>>> =A0=A0=A0 time ./qemu-img convert -O qcow2
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [zlib|zstd]=
_compressed.img uncompressed.img
>>>>>
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compression=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 decompression
>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 zlib=A0=A0=A0=A0=A0=A0 zstd=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 zlib=A0=A0=A0=A0=A0=A0=A0=A0 zstd
>>>>> ------------------------------------------------------------
>>>>> real=A0=A0=A0=A0 65.5=A0=A0=A0=A0=A0=A0 16.3 (-75 %)=A0=A0=A0 1.9=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 1.6 (-16 %)
>>>>> user=A0=A0=A0=A0 65.0=A0=A0=A0=A0=A0=A0 15.8=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 5.3=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.5
>>>>> sys=A0=A0=A0=A0=A0=A0 3.3=A0=A0=A0=A0=A0=A0=A0 0.2=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 2.0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.0
>>>>>
>>>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>>>> compressed image size in both cases: 1.4G
>>>>>
>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>> QAPI part:
>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>> ---
>>>>> =A0=A0 docs/interop/qcow2.txt |=A0=A0 1 +
>>>>> =A0=A0 configure=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>>>>> =A0=A0 qapi/block-core.json=A0=A0 |=A0=A0 3 +-
>>>>> =A0=A0 block/qcow2-threads.c=A0 | 169
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>> =A0=A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 ++
>>>>> =A0=A0 slirp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 2 +-
>>>>> =A0=A0 6 files changed, 181 insertions(+), 3 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>>> index 7dbaf53489..a0b12e1b15 100644
>>>>> --- a/block/qcow2-threads.c
>>>>> +++ b/block/qcow2-threads.c
>>>>
>>>> [...]
>>>>
>>>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void *src, size_t
>>>>> src_size)
>>>>> +{
>>>>
>>>> [...]
>>>>
>>>>> +=A0=A0=A0 /*
>>>>> +=A0=A0=A0=A0 * The compressed stream from the input buffer may consi=
st of
>>>>> more
>>>>> +=A0=A0=A0=A0 * than one zstd frame.
>>>>
>>>> Can it?
>>>
>>> If not, we must require it in the specification.
>>
>> Actually, now that you mention it, it would make sense anyway to add
>> some note to the specification on what exactly compressed with zstd
>> means.
>>
>>> Hmm. If at some point
>>> we'll want multi-threaded compression of one big (2M) cluster.. Could
>>> this be implemented with zstd lib, if multiple frames are allowed, will
>>> allowing multiple frames help? I don't know actually, but I think bette=
r
>>> not to forbid it. On the other hand, I don't see any benefit in large
>>> compressed clusters. At least, in our scenarios (for compressed backups=
)
>>> we use 64k compressed clusters, for good granularity of incremental
>>> backups (when for running vm we use 1M clusters).
>>
>> Is it really that important?=A0 Na=EFvely, it sounds rather complicated =
to
>> introduce multithreading into block drivers.
>=20
> It is already here: compression and encryption already multithreaded.
> But of course, one cluster is handled in one thread.

Ah, good.  I forgot.

>> (Also, as for compression, it can only be used in backup scenarios
>> anyway, where you write many clusters at once.=A0 So parallelism on the
>> cluster level should sufficient to get high usage, and it would benefit
>> all compression types and cluster sizes.)
>>
>=20
> Yes it works in this way already :)

Well, OK then.

> So, we don't know do we want one frame restriction or not. Do you have a
> preference?

*shrug*

Seems like it would be preferential to allow multiple frames still.  A
note in the spec would be nice (i.e., streaming format, multiple frames
per cluster possible).

Max


--UYQb2UJGxeTWCYce0x1MiEOhfzXvWOO1h--

--3mBCjFW98SzB9s1vI1oQyTwIaL9mtpy0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6qi50ACgkQ9AfbAGHV
z0DKVwf/QHywNtCkds5M7i7YOwtlhCjglcmdhSoacC70NCD7P3+zj18VzkI7zet6
ruPqBC8+eTFybHztxJe9m4gorquqR24ixYxXPLhm48ISyVX8rc9jZpwxQ6nCXIsi
3Iu47FJfgbvhBjb9UuzHsGtwRU98WNjXs8PIOFs73teEMjEbGAvV9txtTxMEXQHX
/T0bJt+cIwi5kWilmXklxpwpgYUiEaur3Q4RkDJwXI+yZbAdLDOiY84F6cuaIIbw
DeK1WpkElYsWib1osRz8uuau06ecC7W2Pakv2Pl/oFl/ymQrSUXDlENEGbDhL5sK
uq2yBHlKO1aypNM6/YlNhpcbbhq1eA==
=x5lX
-----END PGP SIGNATURE-----

--3mBCjFW98SzB9s1vI1oQyTwIaL9mtpy0L--


