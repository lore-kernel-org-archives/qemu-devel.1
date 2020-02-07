Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F0C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1EA2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKu9EEme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1EA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07SF-000319-37
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j07Rb-0002Vt-3m
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j07RY-00039q-K3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:29:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j07RY-000390-GT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581096568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=85R5aouRtN6lOx9mwRV9rAsGC92T8wVM1kWT8w8aDVU=;
 b=SKu9EEmeMKjzp3DUWhIT0oEOQfWHiyOGAur67hrTI3eX4Ui+WLZKy0YWvLsJp9WqdPG7hw
 TEhvRrKFCApIGXshhDpYnjpCnR54/oVN6uS3P7U/YBlM+kRSKEs+54/0ax9nvhe5KMbjnU
 K7uS9rzjsDQ3VVKuZ2NVIBt2jJbLRZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-zgJ1noZdOdCcr1Rsh5hRRg-1; Fri, 07 Feb 2020 12:29:08 -0500
X-MC-Unique: zgJ1noZdOdCcr1Rsh5hRRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E2708010E7;
 Fri,  7 Feb 2020 17:29:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-14.ams2.redhat.com
 [10.36.117.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 083BF87B1C;
 Fri,  7 Feb 2020 17:29:00 +0000 (UTC)
Subject: Re: [PATCH v2 1/7] block/block-copy: specialcase first copy_range
 request
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-2-vsementsov@virtuozzo.com>
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
Message-ID: <2f3e4122-6ffc-fa3e-7433-c3ef84bdfd31@redhat.com>
Date: Fri, 7 Feb 2020 18:28:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191127180840.11937-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DojI43Hgodgsy7CTaWhma53T7Hsjr4yK3"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DojI43Hgodgsy7CTaWhma53T7Hsjr4yK3
Content-Type: multipart/mixed; boundary="gCCblnptq8QDjC4YFVxAvPFmombUzoCD3"

--gCCblnptq8QDjC4YFVxAvPFmombUzoCD3
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
> In block_copy_do_copy we fallback to read+write if copy_range failed.
> In this case copy_size is larger than defined for buffered IO, and
> there is corresponding commit. Still, backup copies data cluster by
> cluster, and most of requests are limited to one cluster anyway, so the
> only source of this one bad-limited request is copy-before-write
> operation.
>=20
> Further patch will move backup to use block_copy directly, than for
> cases where copy_range is not supported, first request will be
> oversized in each backup. It's not good, let's change it now.
>=20
> Fix is simple: just limit first copy_range request like buffer-based
> request. If it succeed, set larger copy_range limit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 79798a1567..8602e2cae7 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c

[...]

> @@ -168,7 +170,21 @@ static int coroutine_fn block_copy_do_copy(BlockCopy=
State *s,
>              s->use_copy_range =3D false;
>              s->copy_size =3D MAX(s->cluster_size, BLOCK_COPY_MAX_BUFFER)=
;
>              /* Fallback to read+write with allocated buffer */
> -        } else {
> +        } else if (s->use_copy_range) {
> +            /*
> +             * Successful copy-range. Now increase copy_size.
> +             * copy_range does not respect max_transfer (it's a TODO), s=
o we
> +             * factor that in here.
> +             *
> +             * Note: we double-check s->use_copy_range for the case when
> +             * parallel block-copy request unset it during previous
> +             * bdrv_co_copy_range call.

But we should still goto out anyway, shouldn=92t we?

> +             */
> +            s->copy_size =3D
> +                    MIN(MAX(s->cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
> +                        QEMU_ALIGN_DOWN(block_copy_max_transfer(s->sourc=
e,
> +                                                                s->targe=
t),
> +                                        s->cluster_size));
>              goto out;
>          }
>      }
> @@ -176,7 +192,10 @@ static int coroutine_fn block_copy_do_copy(BlockCopy=
State *s,
>      /*
>       * In case of failed copy_range request above, we may proceed with b=
uffered
>       * request larger than BLOCK_COPY_MAX_BUFFER. Still, further request=
s will
> -     * be properly limited, so don't care too much.
> +     * be properly limited, so don't care too much. Moreover the most po=
ssible

s/possible/likely/

Max

> +     * case (copy_range is unsupported for the configuration, so the ver=
y first
> +     * copy_range request fails) is handled by setting large copy_size o=
nly
> +     * after first successful copy_range.
>       */
> =20
>      bounce_buffer =3D qemu_blockalign(s->source->bs, nbytes);
>=20



--gCCblnptq8QDjC4YFVxAvPFmombUzoCD3--

--DojI43Hgodgsy7CTaWhma53T7Hsjr4yK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl49nlsACgkQ9AfbAGHV
z0A+zAf+I+G0lCIK59oE6NSD45yGe/D+tBg2xeb9s9xYap26w1InGcKq8oMa1LRh
9iHEYZQkfWsX9iDrfJrA9Q5+JIhry+pdZWvmnTacHg4EI46qXymGsX1xB5NCJpXF
K55ZPSgtQ9J2SSKym3uiGxcdaAMPb8AjX/r7HW+c5sPhgLRbwULXlTKq5EhsWgAH
lOMJ4Y+6tvTPBtVK25kPqQbkJ/eYrJlk056CBkEz/xPsJZGfjreWv1Hp105HSWy1
2zqhnqLhtHSrwcuLq37IMHrumKv811j0GD+KmhsDbcPH8Z5UoWXrSArbnagVvx3L
GyUvjnbcH3m8XTcebvHnuyZtyNQEvg==
=EzxN
-----END PGP SIGNATURE-----

--DojI43Hgodgsy7CTaWhma53T7Hsjr4yK3--


