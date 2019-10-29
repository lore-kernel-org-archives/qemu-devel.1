Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB5CA9EC3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E75214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C60bJDCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E75214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPPW1-0003ai-2g
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 07:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPPUb-0002dx-8S
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPPST-0000FF-Lr
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:14:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPPST-0000En-HQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572347681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0o4H6DXRxks1QalUBMiRmCjgoSt0wOCtTjKoAXxrruU=;
 b=C60bJDCZYwjln/ano8RG6gdLkfYjFpCxHYEDK4mf/dXidGqZUFPkOcSaBD5wFngG6rK3xu
 D74mloZoE7ROWaOPD0TzA0+T2YIPngm80MTHy4EkSIoXfaRwaqSEqPFDOn7Zlcg0P7tSSe
 H8wKvXtG+UlFLmTfanELm4Yx3+4XWyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-t9zAyEuaOheOr0qIaX8u2A-1; Tue, 29 Oct 2019 07:14:37 -0400
X-MC-Unique: t9zAyEuaOheOr0qIaX8u2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E84491800D67;
 Tue, 29 Oct 2019 11:14:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96909165FE;
 Tue, 29 Oct 2019 11:14:33 +0000 (UTC)
Subject: Re: [PATCH v2] qcow2-bitmap: Fix uint64_t left-shift overflow
To: Tuguoyi <tu.guoyi@h3c.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <494aedb644bf434f8eee0263aa17aa23@h3c.com>
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
Message-ID: <8f65c725-68ae-6a9f-d155-cb0dd15c995e@redhat.com>
Date: Tue, 29 Oct 2019 12:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <494aedb644bf434f8eee0263aa17aa23@h3c.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BgFSnwyll1numj390cubnEz4jLFkzwW2c"
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BgFSnwyll1numj390cubnEz4jLFkzwW2c
Content-Type: multipart/mixed; boundary="AyjCjFlY5ZLBsR5jKpHzIboMpICMWqxWD"

--AyjCjFlY5ZLBsR5jKpHzIboMpICMWqxWD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.10.19 07:33, Tuguoyi wrote:
> In check_constraints_on_bitmap(), the sanity check on the
> granularity will cause uint64_t integer left-shift overflow
> when cluster_size is 2M and the granularity is BIGGER than
> 32K. As a result, for a qcow2 disk with cluster_size set to
> 2M, we could not even create a dirty bitmap with default
> granularity. This patch fix the issue by dividing @len by
> granularity instead.
>=20
> Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>
> ---
>  block/qcow2-bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 98294a7..71ac822 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -172,8 +172,8 @@ static int check_constraints_on_bitmap(BlockDriverSta=
te *bs,
>      }
> =20
>      if ((len > (uint64_t)BME_MAX_PHYS_SIZE << granularity_bits) ||
> -        (len > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size <<
> -               granularity_bits))
> +        (DIV_ROUND_UP(len, granularity) > (uint64_t)BME_MAX_TABLE_SIZE *
> +                s->cluster_size))

This didn=E2=80=99t change because of this patch, but doesn=E2=80=99t this =
comparison
need a conversion of bits to bytes somewhere?

len / granularity gives us the number of bits needed for the bitmap.

BME_MAX_TABLE_SIZE is, as far as I can see, a number of bitmap clusters,
so multiplying it by the cluster size gives the number of bytes in the
bitmap.  But the number of bits is eight times higher.

Another topic: Isn=E2=80=99t BME_MAX_TABLE_SIZE too big?  As it is, bitmap
tables can have a size of 1 GB, and that=E2=80=99s the table alone.  Depend=
ing
on the cluster size, the bitmap would take up at least 64 GB and cover
at least 32 TB (at a granularity of 512 bytes).

Max

>      {
>          error_setg(errp, "Too much space will be occupied by the bitmap.=
 "
>                     "Use larger granularity");
>=20



--AyjCjFlY5ZLBsR5jKpHzIboMpICMWqxWD--

--BgFSnwyll1numj390cubnEz4jLFkzwW2c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl24HxgACgkQ9AfbAGHV
z0DldAf/TZqKnG5P6DFv7XMHjrI/mn5YZinTi5ng4LX8mT8Q+gYZsjcbNtCA5hhN
eSwT02OUFIgZf6/TGG86yINpjfYA9PghwmLPGvAFMKHYUYTRPxLBqQVuggvrf2ez
2p8bX4Fhj31VAtMzJi+DtAdIuA36lnX6nQ2/E/xsdzYDjQE1Z0jrmvJAaRsYmIC+
VAacwIQsYcmH4nWJekJgujqk71kRLDM4HnRomdestO83ePIHuSGrBxe5B0UXrFxL
UwokJFs6o5R2AmS1tacb+a0n7xiOVi2iw9rAUKTaJYiIXPhPIy0WtoeEPc3Km/T1
g5kSvgOKDE1Z9nGoXdwaLhoB+l849A==
=ODsQ
-----END PGP SIGNATURE-----

--BgFSnwyll1numj390cubnEz4jLFkzwW2c--


