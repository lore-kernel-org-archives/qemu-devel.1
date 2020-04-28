Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5B3C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10AE206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxsvcCiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10AE206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTNLp-0008Vi-Vj
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTNKY-0007uE-HD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTNIg-00023F-WA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:19:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58621
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTNIg-00022y-IW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588069033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7L2HIdeLA+epkBISaavs3I1yhov+zrGsHnPtyB6q+Dg=;
 b=hxsvcCiTs46kA6DPBZ8ub18FC+PDQIKTgXw6RwJ0M2vuPEjo4FDxh3Vw+Wo8kvkO2re6jr
 BrxMqcDK0F3VnhF8wEHJDOdrm8Af+a1z2AHIR+vkOTsA9ojJg8T/7cwKUOHp70L1VlwtqE
 hALLMH3TQ/2UB6I+LT2Tc57AjvWWkoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-sHFDhgDuMAuUo3ESUuSWxg-1; Tue, 28 Apr 2020 06:17:08 -0400
X-MC-Unique: sHFDhgDuMAuUo3ESUuSWxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71425108C2A0;
 Tue, 28 Apr 2020 10:17:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D060611A9;
 Tue, 28 Apr 2020 10:17:05 +0000 (UTC)
Subject: Re: [PATCH v20 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-4-dplotnikov@virtuozzo.com>
 <f8b52ed6-9532-ff65-5c18-0b5142c3b550@redhat.com>
 <f34a5b59-a323-4d63-e4c6-2fcd505b58b1@virtuozzo.com>
 <6f9049f9-4b2a-796d-d3f7-dbd9dbe720cc@redhat.com>
 <7f239f5d-b909-b23c-5571-bd021e4e1dfb@virtuozzo.com>
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
Message-ID: <11d88832-1cb8-5004-a2f9-5c209987a997@redhat.com>
Date: Tue, 28 Apr 2020 12:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7f239f5d-b909-b23c-5571-bd021e4e1dfb@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hFzj4RsWZw4LUHYGZ0D3qf2Wi55EkGijn"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hFzj4RsWZw4LUHYGZ0D3qf2Wi55EkGijn
Content-Type: multipart/mixed; boundary="Bu1844szGsehFhtJMTGi91jBFyJOt0K5d"

--Bu1844szGsehFhtJMTGi91jBFyJOt0K5d
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 09:23, Denis Plotnikov wrote:
>=20
>=20
> On 28.04.2020 09:16, Max Reitz wrote:
>> On 27.04.20 21:26, Denis Plotnikov wrote:
>>>
>>> On 27.04.2020 15:35, Max Reitz wrote:
>>>> On 21.04.20 10:11, Denis Plotnikov wrote:
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
>>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>>>> QAPI part:
>>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>>> ---
>>>>> =A0=A0 docs/interop/qcow2.txt |=A0=A0 1 +
>>>>> =A0=A0 configure=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>>>>> =A0=A0 qapi/block-core.json=A0=A0 |=A0=A0 3 +-
>>>>> =A0=A0 block/qcow2-threads.c=A0 | 157
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>> =A0=A0 block/qcow2.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 ++
>>>>> =A0=A0 5 files changed, 168 insertions(+), 2 deletions(-)
>>>> [...]
>>>>
>>>>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>>>>> index 7dbaf53489..0525718704 100644
>>>>> --- a/block/qcow2-threads.c
>>>>> +++ b/block/qcow2-threads.c
>>>>> @@ -28,6 +28,11 @@
>>>>> =A0=A0 #define ZLIB_CONST
>>>>> =A0=A0 #include <zlib.h>
>>>>> =A0=A0 +#ifdef CONFIG_ZSTD
>>>>> +#include <zstd.h>
>>>>> +#include <zstd_errors.h>
>>>>> +#endif
>>>>> +
>>>>> =A0=A0 #include "qcow2.h"
>>>>> =A0=A0 #include "block/thread-pool.h"
>>>>> =A0=A0 #include "crypto.h"
>>>>> @@ -166,6 +171,148 @@ static ssize_t qcow2_zlib_decompress(void
>>>>> *dest, size_t dest_size,
>>>>> =A0=A0=A0=A0=A0=A0 return ret;
>>>>> =A0=A0 }
>>>>> =A0=A0 +#ifdef CONFIG_ZSTD
>>>>> +
>>>>> +/*
>>>>> + * qcow2_zstd_compress()
>>>>> + *
>>>>> + * Compress @src_size bytes of data using zstd compression method
>>>>> + *
>>>>> + * @dest - destination buffer, @dest_size bytes
>>>>> + * @src - source buffer, @src_size bytes
>>>>> + *
>>>>> + * Returns: compressed size on success
>>>>> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 -ENOMEM destination buffer is not enou=
gh to store
>>>>> compressed data
>>>>> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0 -EIO=A0=A0=A0 on any other error
>>>>> + */
>>>>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void *src, size_t src_size)
>>>>> +{
>>>>> +=A0=A0=A0 ssize_t ret;
>>>>> +=A0=A0=A0 ZSTD_outBuffer output =3D { dest, dest_size, 0 };
>>>>> +=A0=A0=A0 ZSTD_inBuffer input =3D { src, src_size, 0 };
>>>> Minor style note: I think it=92d be nicer to use designated initialize=
rs
>>>> here.
>>>>
>>>>> +=A0=A0=A0 ZSTD_CCtx *cctx =3D ZSTD_createCCtx();
>>>>> +
>>>>> +=A0=A0=A0 if (!cctx) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 return -EIO;
>>>>> +=A0=A0=A0 }
>>>>> +=A0=A0=A0 /*
>>>>> +=A0=A0=A0=A0 * Use the zstd streamed interface for symmetry with
>>>>> decompression,
>>>>> +=A0=A0=A0=A0 * where streaming is essential since we don't record th=
e exact
>>>>> +=A0=A0=A0=A0 * compressed size.
>>>>> +=A0=A0=A0=A0 *
>>>>> +=A0=A0=A0=A0 * In the loop, we try to compress all the data into one=
 zstd
>>>>> frame.
>>>>> +=A0=A0=A0=A0 * ZSTD_compressStream2 potentially can finish a frame e=
arlier
>>>>> +=A0=A0=A0=A0 * than the full input data is consumed. That's why we a=
re
>>>>> looping
>>>>> +=A0=A0=A0=A0 * until all the input data is consumed.
>>>>> +=A0=A0=A0=A0 */
>>>>> +=A0=A0=A0 while (input.pos < input.size) {
>>>>> +=A0=A0=A0=A0=A0=A0=A0 size_t zstd_ret;
>>>>> +=A0=A0=A0=A0=A0=A0=A0 /*
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * ZSTD spec: "You must continue calling
>>>>> ZSTD_compressStream2()
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * with ZSTD_e_end until it returns 0, at wh=
ich point you are
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * free to start a new frame". We assume tha=
t "start a new
>>>>> frame"
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * means call ZSTD_compressStream2 in the ve=
ry beginning or
>>>>> when
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 * ZSTD_compressStream2 has returned with 0.
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0 */
>>>>> +=A0=A0=A0=A0=A0=A0=A0 do {
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 zstd_ret =3D ZSTD_compressStream2(=
cctx, &output, &input,
>>>>> ZSTD_e_end);
>>>> The spec makes it sound to me like ZSTD_e_end will always complete in =
a
>>>> single call if there=92s enough space in the output buffer.=A0 So the =
only
>>>> team we have to loop would be when there isn=92t enough space anyway:
>>>>
>>>> It says this about ZSTD_e_end:
>>>>> flush operation is the same, and follows same rules as calling
>>>>> ZSTD_compressStream2() with ZSTD_e_flush.
>>>> Those rules being:
>>>>> Note that, if `output->size` is too small, a single invocation with
>>>>> ZSTD_e_flush might not be enough (return code > 0).
>>>> So it seems like it will only return a value > 0 if the output
>>>> buffer is
>>>> definitely too small.
>>>>
>>>> The spec also notes that the return value is greater than 0 if:
>>>>>> 0 if some data still present within internal buffer (the value is
>>>>> minimal estimation of remaining size),
>>>> So it=92s a minimum estimate.=A0 That=92s another point that heavily i=
mplies
>>>> to me that if the return value were less than what=92s left in the
>>>> buffer,
>>>> the function wouldn=92t return but still try to write it out, until it
>>>> realizes that there isn=92t enough space in the output buffer, and the=
n
>>>> return a value that exceeds the remaining output buffer size.
>>>>
>>>> (Because if the function just played it safe, I would expect it to
>>>> return a maximum estimate.)
>>>>
>>>>
>>>> OTOH, if it were actually possible for ZSTD_e_end to finish a frame
>>>> earlier than the end of the input, I think it would make more sense to
>>>> use ZSTD_e_continue until the input is done and then finish with
>>>> ZSTD_e_end, like the spec seems to propose.=A0 That way, we=92d always=
 end
>>>> up with a single frame to make decompression simpler (and I think it
>>>> would also make more sense overall).
>>>>
>>>>
>>>> But anyway.=A0 From how I understand the spec, this code simply always
>>>> ends up creating a single frame or erroring out, without looping ever.
>>>> So it isn=92t exactly wrong, it just seems overly complicated.=A0 (Aga=
in,
>>>> assuming I understand the spec correctly.=A0 Which seems like a tough
>>>> thing to assume, because the spec is not exactly obvious to read...)
>>>>
>>>> (Running some quick tests by converting some images with zstd
>>>> compression seems to confirm that whenever ZSTD_compressStream2()
>>>> returns, either zstd_ret > output.size - output.pos, or zstd_ret =3D=
=3D 0
>>>> and input.pos =3D=3D input.size.=A0 So none of the loops ever loop.)
>>>>
>>>> Max
>>> So, what should we do?
>>>
>>> 1. Rely on the test that there's no need for the loop:
>>> =A0=A0=A0 * make one ZSTD_compressStream2() call
>>> =A0=A0=A0 * make sure it returned with zstd_ret =3D=3D 0 and
>>> =A0=A0=A0=A0=A0 input.pos =3D=3D input.size.
>>> =A0=A0=A0=A0=A0 if so, return with the size
>>> =A0=A0=A0 * if not, check that zstd_ret > output.size - output.pos
>>> =A0=A0=A0=A0=A0 if so, return with -ENOMEM
>>> =A0=A0=A0 * if none above return with -EIO
>>>
>>> =A0=A0=A0 This should cover the majority of the compressing cases
>> According to how I interpret the spec, =93none of the above=94 should ne=
ver
>> happen except for ZSTD_isError(zstd_ret), so this should cover all
>> compressing cases, actually.
>>
>>> 2. Leave the loop as is, because of the documentation:
>>> =A0=A0=A0 "You *must* continue calling ZSTD_compressStream2() with ZSTD=
_e_end
>>> until it returns 0,
>>> =A0=A0=A0=A0 at which point you are free to start a new frame."
>> As far as I can see, the return value is always 0 or greater than the
>> remaining buffer space, so this will always be satisfied even without a
>> loop.=A0 (We will always have one of three cases: (1) Success and all
>> input has been consumed, (2) ZSTD_isError(zstd_ret), so we return -EIO,
>> (3) zstd_ret > output.size - output.pos, so we return -ENOMEM.
>>
>> I interpret the =93You *must* continue until it returns 0=94 as =93If th=
ere is
>> no sufficient space in the output buffer, this function will return a
>> value greater than 0 indicating how much space is at least still
>> required.=A0 The caller is free to supply a greater output buffer for th=
e
>> next call (by supplying a different ZSTD_outBuffer structure), and then
>> we=92ll try again.=94
>> (I.e., retrying with the same ZSTD_outBuffer will make the function
>> return immediately because it knows that it=92s insufficient.)
>>
>> Max
>=20
> ok, removing the loop sounds reasonable.
> My only concern is that *must* in the doc.

Well, if we just return an error whenever we get a return value !=3D 0,
then we shouldn=92t have to care what we must and mustn=92t do, because
we=92ll just abort the compression process then.

> Could ZSTD-lib change the logic in the future relying on the fact
> that they make users use ZSTD_compressStream() in a loop.

It isn=92t like I just wondered whether the loop is necessary and saw that
with the current implementation, it didn=92t seem necessary for any of the
test images I have.

My reasoning is based on the specification, which says for ZSTD_e_flush
that it will only return a value > 0 if output->size is too small; and
that ZSTD_e_end follows the same rules.

So I think if they were to change behavior, they=92d violate the spec.

> Honestly, I can't imagine the case when they would want to do that,
> but still.
> Without the loop we're protected even in this case. The worst thing
> could happen because of that is qcow2_zstd_compress() would return
> with -EIO more frequently.

I think so, too.

> So, if I understand correctly, you are ok with removing the loop.

Yes.

Max


--Bu1844szGsehFhtJMTGi91jBFyJOt0K5d--

--hFzj4RsWZw4LUHYGZ0D3qf2Wi55EkGijn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6oAp8ACgkQ9AfbAGHV
z0DgCAf+L5GF8jsFxCLDFmhY9pAEZtyMMRMOnnAT99AXvZCH7JZI4uQUqA+eQ/4e
4K/M3nYYQWIPQhJmLH1ZI70xDuIGL1HCSW64dtUwVTjO+OYV3SwzdXRaZdoENUuJ
LSUa9RSTwOaN+bmLb6N5+HNh4SfnqF3ylCG8TozyyihnWqY8o0nUdkhdTo2w8tOS
5/t4AcG1KL1Oc5zgsxGZ/alGAplHDtgc6t1t72ltulIeC4cfwTe3iQen3oEfDWM3
BE5F7qeI6C5hYDsFiNEluphVaQ6pd7977nwYcZQxVIdMafsloPKX56IsvlidQyaG
ncFRYx0Esi8nDQhGyWI3pUds/RHxrw==
=EiGQ
-----END PGP SIGNATURE-----

--hFzj4RsWZw4LUHYGZ0D3qf2Wi55EkGijn--


