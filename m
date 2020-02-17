Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545B8C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3542072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5UD/VCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3542072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3f4G-0007PL-Br
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 07:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j3etW-00033D-VJ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j3etV-00054Q-Mu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:48:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44950
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j3etV-00053m-ID
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581940136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aIT8KxW5kd+27ldRSp5UW5iRp8xhiqNBNX+WoMUbRs8=;
 b=E5UD/VCw3VfG8Qceoa56Z0+VPaPIIPidr/pn2NKSDoqmm3E8oCfCLYhYmY4KEoNC3C2d4H
 r4CKO8vu6CJEYYhrXTv4kDrrIPhA6tZTeX2XfEW6CDNW9fCntAFb5VfiAVYibcLEcZ6+Qf
 aRlAfAngzv3n41wak3wdxVbejEO77Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-gPepL7EsN_2YIgT6Cd7chA-1; Mon, 17 Feb 2020 06:48:52 -0500
X-MC-Unique: gPepL7EsN_2YIgT6Cd7chA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44282477;
 Mon, 17 Feb 2020 11:48:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-191.ams2.redhat.com
 [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 258815DA75;
 Mon, 17 Feb 2020 11:48:48 +0000 (UTC)
Subject: Re: [PATCH v2 2/7] block/block-copy: use block_status
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-3-vsementsov@virtuozzo.com>
 <81ce033a-2ac9-21b6-4649-48df61d41797@redhat.com>
 <e6a5a095-78f3-faf1-6eaa-68843b41c490@virtuozzo.com>
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
Message-ID: <168c4ec7-47fa-72a1-dfa7-10754f79519d@redhat.com>
Date: Mon, 17 Feb 2020 12:48:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e6a5a095-78f3-faf1-6eaa-68843b41c490@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lF4rSxLLIMvci71L599jCzB9cSCytM345"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lF4rSxLLIMvci71L599jCzB9cSCytM345
Content-Type: multipart/mixed; boundary="VAtS4ITJpRgwOvUtUUsjVQpMtCYE7fBRs"

--VAtS4ITJpRgwOvUtUUsjVQpMtCYE7fBRs
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.02.20 13:25, Vladimir Sementsov-Ogievskiy wrote:
> 07.02.2020 20:46, Max Reitz wrote:
>> On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
>>> Use bdrv_block_status_above to chose effective chunk size and to handle
>>> zeroes effectively.
>>>
>>> This substitutes checking for just being allocated or not, and drops
>>> old code path for it. Assistance by backup job is dropped too, as
>>> caching block-status information is more difficult than just caching
>>> is-allocated information in our dirty bitmap, and backup job is not
>>> good place for this caching anyway.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =A0 block/block-copy.c | 67 +++++++++++++++++++++++++++++++++++++------=
---
>>> =A0 block/trace-events |=A0 1 +
>>> =A0 2 files changed, 55 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>> index 8602e2cae7..74295d93d5 100644
>>> --- a/block/block-copy.c
>>> +++ b/block/block-copy.c
>>
>> [...]
>>
>>> @@ -336,23 +375,25 @@ int coroutine_fn block_copy(BlockCopyState *s,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chunk_end =3D next_zero;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0 -=A0=A0=A0=A0=A0=A0=A0 if (s->skip_unallocated) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D block_copy_reset_unallocated=
(s, start,
>>> &status_bytes);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret =3D=3D 0) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_block_copy_skip_ra=
nge(s, start, status_bytes);
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 start +=3D status_bytes;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Clamp to known allocated region *=
/
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chunk_end =3D MIN(chunk_end, start +=
 status_bytes);
>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D block_copy_block_status(s, start, chunk_=
end - start,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &status_bytes);
>>> +=A0=A0=A0=A0=A0=A0=A0 if (s->skip_unallocated && !(ret & BDRV_BLOCK_AL=
LOCATED)) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bdrv_reset_dirty_bitmap(s->copy_bitm=
ap, start,
>>> status_bytes);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->progress_reset_callback(s->progre=
ss_opaque);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 trace_block_copy_skip_range(s, start=
, status_bytes);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 start +=3D status_bytes;
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>> =A0 +=A0=A0=A0=A0=A0=A0=A0 chunk_end =3D MIN(chunk_end, start + status_=
bytes);
>>
>> I=92m not sure how much the old =93Clamp to known allocated region=94 ac=
tually
>> helps, but I wouldn=92t drop it anyway.
>=20
> But it may be not allocated now. We just clamp to status_bytes.
> It's "known allocated" only if s->skip_unallocated is true.

Ah, yes, I suppose I was just thinking about that case when trying to
understand how the code changes.  So:

Reviewed-by: Max Reitz <mreitz@redhat.com>

Max


--VAtS4ITJpRgwOvUtUUsjVQpMtCYE7fBRs--

--lF4rSxLLIMvci71L599jCzB9cSCytM345
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5KfZ4ACgkQ9AfbAGHV
z0AtHQf/YsLlDLVDo4cYeoZkGt84iwQO/fwEL3DDh/fOKU4t/B/7+FQ8uNN3No1Y
HiCsDTmx/cvz1+c9PCQANDw6gS4hagoLIlhcUp9cF79AbPKB6fWoPKtKVaKkmU6T
8H5e96hXwx82GlVo7SMjiLLGO0251DrKfnDWTKtlBVD1lc4rX0WCmBWYxh0fagvl
noNq3WpSJKuoR0FjX3bFcptrAt8SmgrggMeSfyxU2bxipp58NWt7Hzi9dyJnZ/a+
3hJWmNeQEyX8PsgGEoXbBqqDuM/5Z9rcHRjng0ni9Ne7tNgcZ0nhbHxM0X84s0H6
ZT1t/ZcpQ8DAmYOAzrj668IJHapvgQ==
=EQqp
-----END PGP SIGNATURE-----

--lF4rSxLLIMvci71L599jCzB9cSCytM345--


