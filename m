Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD90CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B12621929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFNm00sW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B12621929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxEv-0007nz-KR
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNwkL-0004k9-2b
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNwkJ-0003GX-43
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:23:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNwkI-0003GI-3A
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571998981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fDOCWPnRCxNWVaLxB7DI3KgRZX8rEnf2giLiVGkd0AE=;
 b=hFNm00sWJQAv9Z20xXi7i9CRq8y6yHVp8Hd7haImEMYGmOYBx/CGrpoPqlgqwBNTUZcRFD
 te1qmRu9R7FbufKo0UK4khTHxa++MzqKBsQr2P/1fWLFMsJkdxPAt9N5MPGU4UR1PG6YLW
 ev7hlnCp3QDsabo51trwPDBZwKS0S7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-XN8yJdyGOVCFysVGYtPJvw-1; Fri, 25 Oct 2019 06:22:55 -0400
X-MC-Unique: XN8yJdyGOVCFysVGYtPJvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD42947B;
 Fri, 25 Oct 2019 10:22:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-205.ams2.redhat.com
 [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11E66600CD;
 Fri, 25 Oct 2019 10:22:48 +0000 (UTC)
Subject: Re: [RFC 2/3] block/file-posix: Detect XFS with CONFIG_FALLOCATE
To: Kevin Wolf <kwolf@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191025095849.25283-3-mreitz@redhat.com>
 <20191025101920.GB7275@localhost.localdomain>
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
Message-ID: <f71d7cab-a1cf-c93c-0697-4b5f77105314@redhat.com>
Date: Fri, 25 Oct 2019 12:22:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025101920.GB7275@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b8t0GyjBB5OXa9b8aSPpJyxxRiljiQWyd"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b8t0GyjBB5OXa9b8aSPpJyxxRiljiQWyd
Content-Type: multipart/mixed; boundary="guYHvNtrn2XbXlfPVjIHFpfxGzKErZiih"

--guYHvNtrn2XbXlfPVjIHFpfxGzKErZiih
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.10.19 12:19, Kevin Wolf wrote:
> Am 25.10.2019 um 11:58 hat Max Reitz geschrieben:
>> We will need this for the next patch.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/file-posix.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 695fcf740d..5cd54c8bff 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -149,7 +149,7 @@ typedef struct BDRVRawState {
>>      int perm_change_flags;
>>      BDRVReopenState *reopen_state;
>> =20
>> -#ifdef CONFIG_XFS
>> +#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
>>      bool is_xfs:1;
>>  #endif
>>      bool has_discard:1;
>> @@ -667,7 +667,7 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
>>      }
>>  #endif
>> =20
>> -#ifdef CONFIG_XFS
>> +#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
>>      if (platform_test_xfs_fd(s->fd)) {
>=20
> platform_test_xfs_fd() is defined in a header file from xfsprogs. I
> don't think you can call that without CONFIG_XFS, it would break the
> build.

Aw.

OK.  Should we then just assume is_xfs to be true (for the next patch)
with !defined(CONFIG_XFS) && defined(CONFIG_FALLOCATE)?

Max


--guYHvNtrn2XbXlfPVjIHFpfxGzKErZiih--

--b8t0GyjBB5OXa9b8aSPpJyxxRiljiQWyd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2yzPYACgkQ9AfbAGHV
z0Cb5gf7B/BAzv5YU2vqZ+sON8fF0M4rlEiiGB5Oh3ympktGPHL0mBLYQxa0bPMP
4/ARRHvnWdrwibEknCCJ5/5RM0Y2uMTYvu+opqj28pLBzRFr4HSUZ1PyZDrX/FP0
RrLkj20dREuK4NnpYhnFlHG7sdmFsGv7Dl5XZpyBfAnS1lJn03chb37dsRQNSBPx
9aTCchx/UyDfvOvf5k6qXNW/fHdURs4JPg0sxORkeX2HL9LsitZiANO3KAmpyOWR
6I0pO1ElKEPrLOg8VJCl6ykDals/SSphHEWVAjhxsECBz0NCw6QkI+18Adcu8yzM
RAxqcOsOK4+XTH6XEqt0O+lyk7Ig+Q==
=ckXj
-----END PGP SIGNATURE-----

--b8t0GyjBB5OXa9b8aSPpJyxxRiljiQWyd--


