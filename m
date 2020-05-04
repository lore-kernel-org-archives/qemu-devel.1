Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA1C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 07:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6BC206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 07:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QukfhuSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6BC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVVvm-0005L0-2x
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 03:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVVv2-0004Zw-E7
 for qemu-devel@nongnu.org; Mon, 04 May 2020 03:53:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54376
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVVuz-00013c-P3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 03:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588578816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TsV196xQJWzdJkgKBAC8ANU6EHhkv7jO37WcdbDbY0E=;
 b=QukfhuSd15PyM92jVT4NKkDLDPi8KuDfQkB14+mOjxFbr9igsOs6hMtpFNnhBajdtTOClY
 Lb2L03vY1oj/QAx6okPeEIX4gNwOi4aADTne+NDKiA1Sw5rzxO4xOZ20pfID/ItTgSYQQl
 ihI+5VyZVopwJdr4QnyK/H1RSxwuQuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-oZDJSC2ZO06Awf9QmKazhA-1; Mon, 04 May 2020 03:53:32 -0400
X-MC-Unique: oZDJSC2ZO06Awf9QmKazhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63756460;
 Mon,  4 May 2020 07:53:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4946C5C1B2;
 Mon,  4 May 2020 07:53:27 +0000 (UTC)
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
 <22b2918b-3bdd-6627-a378-baddb342dacc@redhat.com>
 <7444cb5f-acda-6354-ea9f-81e998185f0f@virtuozzo.com>
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
Message-ID: <e4f4d868-c3b4-ffd1-35cc-3cac2a4644a1@redhat.com>
Date: Mon, 4 May 2020 09:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7444cb5f-acda-6354-ea9f-81e998185f0f@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4UC3Wur2gQXWVEXlq9MQfqXjcvOcX0HiE"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4UC3Wur2gQXWVEXlq9MQfqXjcvOcX0HiE
Content-Type: multipart/mixed; boundary="Eetbdwq0ZBYwibasqXkACGXMcwnNd0lBN"

--Eetbdwq0ZBYwibasqXkACGXMcwnNd0lBN
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.04.20 15:56, Denis Plotnikov wrote:
>=20
>=20
> On 30.04.2020 14:47, Max Reitz wrote:
>> On 30.04.20 11:48, Denis Plotnikov wrote:
>>>
>>> On 30.04.2020 11:26, Max Reitz wrote:
>>>> On 29.04.20 15:02, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 29.04.2020 15:17, Max Reitz wrote:
>>>>>> On 29.04.20 12:37, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 29.04.2020 13:24, Max Reitz wrote:
>>>>>>>> On 28.04.20 22:00, Denis Plotnikov wrote:
>>>>>>>>> zstd significantly reduces cluster compression time.
>>>>>>>>> It provides better compression performance maintaining
>>>>>>>>> the same level of the compression ratio in comparison with
>>>>>>>>> zlib, which, at the moment, is the only compression
>>>>>>>>> method available.
>>>>>>>>>
>>>>>>>>> The performance test results:
>>>>>>>>> Test compresses and decompresses qemu qcow2 image with just
>>>>>>>>> installed rhel-7.6 guest.
>>>>>>>>> Image cluster size: 64K. Image on disk size: 2.2G
>>>>>>>>>
>>>>>>>>> The test was conducted with brd disk to reduce the influence
>>>>>>>>> of disk subsystem to the test results.
>>>>>>>>> The results is given in seconds.
>>>>>>>>>
>>>>>>>>> compress cmd:
>>>>>>>>> =A0=A0=A0=A0=A0 time ./qemu-img convert -O qcow2 -c -o
>>>>>>>>> compression_type=3D[zlib|zstd]
>>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s=
rc.img [zlib|zstd]_compressed.img
>>>>>>>>> decompress cmd
>>>>>>>>> =A0=A0=A0=A0=A0 time ./qemu-img convert -O qcow2
>>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
zlib|zstd]_compressed.img uncompressed.img
>>>>>>>>>
>>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compression=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 decompression
>>>>>>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 zlib=A0=A0=A0=A0=A0=A0 zstd=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 zlib=A0=A0=A0=A0=A0=A0=A0=A0 zstd
>>>>>>>>> ------------------------------------------------------------
>>>>>>>>> real=A0=A0=A0=A0 65.5=A0=A0=A0=A0=A0=A0 16.3 (-75 %)=A0=A0=A0 1.9=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.6 (-16 %)
>>>>>>>>> user=A0=A0=A0=A0 65.0=A0=A0=A0=A0=A0=A0 15.8=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 5.3=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.5
>>>>>>>>> sys=A0=A0=A0=A0=A0=A0 3.3=A0=A0=A0=A0=A0=A0=A0 0.2=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 2.0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.0
>>>>>>>>>
>>>>>>>>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>>>>>>>>> compressed image size in both cases: 1.4G
>>>>>>>>>
>>>>>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>>>>>> QAPI part:
>>>>>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>>>>>> ---
>>>>>>>>> =A0=A0=A0=A0 docs/interop/qcow2.txt |=A0=A0 1 +
>>>>>>>>> =A0=A0=A0=A0 configure=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 2 +-
>>>>>>>>> =A0=A0=A0=A0 qapi/block-core.json=A0=A0 |=A0=A0 3 +-
>>>>>>>>> =A0=A0=A0=A0 block/qcow2-threads.c=A0 | 169
>>>>>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>> =A0=A0=A0=A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 +=
+
>>>>>>>>> =A0=A0=A0=A0 slirp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 2 +-
>>>>>>>>> =A0=A0=A0=A0 6 files changed, 181 insertions(+), 3 deletions(-)
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>>>>>>> index 7dbaf53489..a0b12e1b15 100644
>>>>>>>>> --- a/block/qcow2-threads.c
>>>>>>>>> +++ b/block/qcow2-threads.c
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t
>>>>>>>>> dest_size,
>>>>>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void *src, size_t
>>>>>>>>> src_size)
>>>>>>>>> +{
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>> +=A0=A0=A0 /*
>>>>>>>>> +=A0=A0=A0=A0 * The compressed stream from the input buffer may c=
onsist of
>>>>>>>>> more
>>>>>>>>> +=A0=A0=A0=A0 * than one zstd frame.
>>>>>>>> Can it?
>>>>>>> If not, we must require it in the specification.
>>>>>> Actually, now that you mention it, it would make sense anyway to add
>>>>>> some note to the specification on what exactly compressed with zstd
>>>>>> means.
>>>>>>
>>>>>>> Hmm. If at some point
>>>>>>> we'll want multi-threaded compression of one big (2M) cluster..
>>>>>>> Could
>>>>>>> this be implemented with zstd lib, if multiple frames are allowed,
>>>>>>> will
>>>>>>> allowing multiple frames help? I don't know actually, but I think
>>>>>>> better
>>>>>>> not to forbid it. On the other hand, I don't see any benefit in
>>>>>>> large
>>>>>>> compressed clusters. At least, in our scenarios (for compressed
>>>>>>> backups)
>>>>>>> we use 64k compressed clusters, for good granularity of incremental
>>>>>>> backups (when for running vm we use 1M clusters).
>>>>>> Is it really that important?=A0 Na=EFvely, it sounds rather
>>>>>> complicated to
>>>>>> introduce multithreading into block drivers.
>>>>> It is already here: compression and encryption already multithreaded.
>>>>> But of course, one cluster is handled in one thread.
>>>> Ah, good.=A0 I forgot.
>>>>
>>>>>> (Also, as for compression, it can only be used in backup scenarios
>>>>>> anyway, where you write many clusters at once.=A0 So parallelism on =
the
>>>>>> cluster level should sufficient to get high usage, and it would
>>>>>> benefit
>>>>>> all compression types and cluster sizes.)
>>>>>>
>>>>> Yes it works in this way already :)
>>>> Well, OK then.
>>>>
>>>>> So, we don't know do we want one frame restriction or not. Do you
>>>>> have a
>>>>> preference?
>>>> *shrug*
>>>>
>>>> Seems like it would be preferential to allow multiple frames still.=A0=
 A
>>>> note in the spec would be nice (i.e., streaming format, multiple frame=
s
>>>> per cluster possible).
>>> We don't mention anything about zlib compressing details in the spec.
>> Yep.=A0 Which is bad enough.
>>
>>> If we mention anything about ZSTD compressing details we'll have to do
>>> it for
>>> zlib as well.
>> I personally don=92t like =93If you can=92t make it perfect, you shouldn=
=92t do
>> it at all=94.=A0 Mentioning it for zstd would still be an improvement.
>=20
> Good approach. I like it. But I'm trying to be cautious.
>>
>> Also, I believe that =93zlib compression=94 is pretty much unambiguous,
>> considering all the code does is call deflate()/inflate().
>>
>> I=92m not saying we need to amend the spec in this series, but I don=92t=
 see
>> a good argument against doing so at some point.
>>
>>> So, I think we have two possibilities for the spec:
>>> 1. mention for both
>>> 2. don't mention at all
>>>
>>> I think the 2nd is better. It gives more degree of freedom for the
>>> future improvements.
>> No, it absolutely doesn=92t.=A0 There is a de-facto format, namely what =
qemu
>> accepts.=A0 Changing that would be an incompatible change.=A0 Just becau=
se
>> we don=92t write what=92s allowed into the spec doesn=92t change that fa=
ct.
>>
>>> and we've already covered both cases (one frame, may frames) in the
>>> code.
>> There are still different zstd formats, namely streaming or not
>> streaming.=A0 That=92s what should be mentioned.
>=20
> It looks like the ZSTD format is always the same.
> The ZSTD interface is different: for some reason the simple
> zstd_decompress()
> wants to know the size of data to decompress
>=20
> From zstd doc:
> *size_t ZSTD_decompress( void* dst, size_t dstCapacity, const void* src,
> size_t compressedSize); *
>=20
> `compressedSize` : must be the _exact_ size of some number of compressed
> and/or skippable frames.

That=92s... interesting.

> I made a test (based on Vladimir's code) to check it:
>=20
> // compile with gcc -lzstd -g test_zstd.c -o test_zstd
>=20
> #include <stdio.h> #include <assert.h> #include <zstd.h> #include
> <zstd_errors.h> int main() { char buf1[] =3D "erbebewbwe"; char buf2[100]=
;
> char buf3[100]; int ret; ZSTD_outBuffer output; ZSTD_inBuffer input; ret
> =3D ZSTD_compress(buf2, sizeof(buf2), buf1, sizeof(buf1), 5); printf("ret=
:
> %d\n", ret); ZSTD_DCtx *dctx =3D ZSTD_createDCtx(); input =3D
> (ZSTD_inBuffer){buf2, ret, 0}; output =3D (ZSTD_outBuffer){buf3,
> sizeof(buf3), 0}; ret =3D ZSTD_decompressStream(dctx, &output, &input);
> printf("ret: %d, input.pos: %ld, output.pos: %ld\n", ret, input.pos,
> output.pos); printf("To compress: %s\n", buf1); buf3[output.pos] =3D 0;
> printf("Uncompressed: %s\n", buf3); return 0; }
>=20
> And it works fine.
>=20
> We use streaming semantics just to be consistent with the interfaces
> (stream_compress/stream_decompress), otherwise
>=20
> we could use simple_compress/stream_decompress

OK, if there=92s just a single format and we accept multiple frames, then
there=92s indeed no need to document it.

Max


--Eetbdwq0ZBYwibasqXkACGXMcwnNd0lBN--

--4UC3Wur2gQXWVEXlq9MQfqXjcvOcX0HiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6vyfUACgkQ9AfbAGHV
z0C3Sgf+P8F87dFsfgZBQQZ2IqHdm1ocU30rwB+iPr7jNFGqL4lFLxXAiGMzym72
Ui0PUI7SLHKsKA9bISXg32iE3P0TNK7obaOnha96xlJRkrPnHA/yEhGxtcVEV3qc
+ZgWAqV4OrLkecOFK1b2Nvnt1IR07MlAJAuDh6ExryE6qGE07J5QuJ0oKxHEgile
4glFYkM4y8aTnhA12Gb3YAz8RAirZR9U3sDneoQo2LGhw6P9ENgE2HSpr+4zWs6E
aUJROrN7gAYzR8jI7ez+AiXRj5uk2MIP2Je3QTHGahfppp7nKY/0N7hJnbTryChM
kLIZMWq69juJq9Dn6vgW+cT2QLqlVw==
=Is2p
-----END PGP SIGNATURE-----

--4UC3Wur2gQXWVEXlq9MQfqXjcvOcX0HiE--


