Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA05C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9ABC20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcgeqFhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ABC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0cD-0004cZ-SU
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jT0Z6-0001s0-0Y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jT0Z5-0002x0-9T
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:00:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jT0Z4-0002ny-Qk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587981637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y2K1egNj1eZMS0R8opccvSLZR0exQ4pvyVmp/4rOIv0=;
 b=bcgeqFhUYZPocGVbJ3OlFnF+/aI58aC1hpuKzBkYnvW0judtrCJodom8XmjNB5DcdFnk7e
 V4qpTKOXA55HQ7iUjiC0aqrDJpB1lsbKwoMuoW5WBudnjEn35s3DdYCFtwHbHmPszVedj7
 VNfv6PV8BQSRUlmSUcZABklLHhY1+wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-9O-PSGJgP96XcR--jR28vA-1; Mon, 27 Apr 2020 06:00:34 -0400
X-MC-Unique: 9O-PSGJgP96XcR--jR28vA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B5F11005510;
 Mon, 27 Apr 2020 10:00:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-29.ams2.redhat.com
 [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E17B5C1D6;
 Mon, 27 Apr 2020 10:00:12 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] block: Add blk_new_with_bs() helper
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200424190903.522087-1-eblake@redhat.com>
 <20200424190903.522087-2-eblake@redhat.com>
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
Message-ID: <ba31b83c-538a-0f3f-9bab-7aadb2f99ea9@redhat.com>
Date: Mon, 27 Apr 2020 12:00:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424190903.522087-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xEhqSYEW8v88T08h11wOrhpB6WnrQnVsQ"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xEhqSYEW8v88T08h11wOrhpB6WnrQnVsQ
Content-Type: multipart/mixed; boundary="WxyYo912wrh8eXyU9mtlMnuwoO7xchuxq"

--WxyYo912wrh8eXyU9mtlMnuwoO7xchuxq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 21:09, Eric Blake wrote:
> There are several callers that need to create a new block backend from
> an existing BDS; make the task slightly easier with a common helper
> routine.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/sysemu/block-backend.h |  2 ++
>  block/block-backend.c          | 23 +++++++++++++++++++++++
>  block/crypto.c                 | 10 ++++------
>  block/parallels.c              |  8 ++++----
>  block/qcow.c                   |  8 ++++----
>  block/qcow2.c                  | 18 ++++++++----------
>  block/qed.c                    |  9 ++++-----
>  block/sheepdog.c               | 11 +++++------
>  block/vdi.c                    |  8 ++++----
>  block/vhdx.c                   |  9 ++++-----
>  block/vmdk.c                   |  9 ++++-----
>  block/vpc.c                    |  8 ++++----
>  blockdev.c                     |  8 +++-----
>  blockjob.c                     |  7 ++-----
>  14 files changed, 75 insertions(+), 63 deletions(-)

[...]

> diff --git a/block/crypto.c b/block/crypto.c
> index d577f89659fa..a4d77f07fe8c 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -256,16 +256,14 @@ static int block_crypto_co_create_generic(BlockDriv=
erState *bs,
>                                            PreallocMode prealloc,
>                                            Error **errp)
>  {
> -    int ret;
> +    int ret =3D -EPERM;

I=E2=80=99m not sure I=E2=80=99m a fan of this, because I feel like it make=
s the code
harder to read, due to having to look in three places (here, around the
blk_new_with_bs() call, and under the cleanup label) instead of in two
(not here) to verify that the error handling code is correct.

There=E2=80=99s also the fact that this is not really a default return valu=
e,
but one very specific error code for if one very specific function call
fails.

I suppose it comes down to whether one considers LoC a complexity
problem.  (I don=E2=80=99t, necessarily.)

(Also I realize it seems rather common in the kernel to set error return
variables before the function call, but I think the more common pattern
in qemu is to set it in the error path.)

[...]

> diff --git a/block/qed.c b/block/qed.c
> index 1af9b3cb1db1..7a31495d293b 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -610,7 +610,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCr=
eateOptions *opts,
>      QEDHeader le_header;
>      uint8_t *l1_table =3D NULL;
>      size_t l1_size;
> -    int ret =3D 0;
> +    int ret =3D -EPERM;

(Same here; well, especially here, because there is so much other code
between the initialization and the =E2=80=9Cgoto out=E2=80=9D this is for)

[...]

> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index 59f7ebb1710f..2b53cd950d20 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -1801,14 +1801,13 @@ static int sd_prealloc(BlockDriverState *bs, int6=
4_t old_size, int64_t new_size,
>      uint32_t idx, max_idx;
>      uint32_t object_size;
>      void *buf =3D NULL;
> -    int ret;
> +    int ret =3D -EPERM;

(and here)

[...]

> diff --git a/block/vhdx.c b/block/vhdx.c
> index 33e57cd6567a..bdf5d05cc018 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1891,7 +1891,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCrea=
teOptions *opts,
>      BlockBackend *blk =3D NULL;
>      BlockDriverState *bs =3D NULL;
>=20
> -    int ret =3D 0;
> +    int ret =3D -EPERM;

(and again especially here)

But it does look like you got all cases covered this time.

Max


--WxyYo912wrh8eXyU9mtlMnuwoO7xchuxq--

--xEhqSYEW8v88T08h11wOrhpB6WnrQnVsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6mrSoACgkQ9AfbAGHV
z0DF0QgAlwF8q97t2YwURC5eQfzisHutYFVZpTHJJecqGVvhtW2PZAb7YF3xuTW1
r2IzVIhTJzLtcxHVW3IkM0010eFV86c6sdLsHm5m63q81QsMq09PqV7JBCIr93RN
7N9c1Sxx0+OxtKQNISoOgNLtBWjRQbpDcLW4HoW4JDqmjALGkBskcxp8rowcpgK6
YFfTvD4xbUJ3vbc3yuFlhp+b8ehLNbL4ZZRBSrV09FM7f0q+lZTlSasQ//MdoUUU
jmwWL19V38ePeTBf2ZvgDkv4QtZemWkxgih/ULiGQsNadDgC+B/DSJQQglt49Goc
GLgkHR5KO3eLo+IsXod2ywKHE77RoA==
=rgV6
-----END PGP SIGNATURE-----

--xEhqSYEW8v88T08h11wOrhpB6WnrQnVsQ--


