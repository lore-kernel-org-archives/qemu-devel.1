Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3939C010A2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01AF21A4A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDPxi5jO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01AF21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRxFp-00018s-SV
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 06:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRxFC-0000VD-39
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRxF9-0000l8-Cg
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:43:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRxF9-0000kB-7K
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572954206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PgRJQiqV3FNADDHldejTg9zJ7QE7pMaqAEQLU5kUZB4=;
 b=fDPxi5jOcBdI7U4qcTScLQx0c4gijkfo+d8xyZU2/5PUAQ2Sfa3oCRMADrdSglyWKFEJRD
 qXbV9gQUzidvEG3leNHrQU9/a5lCE/B/HvqpOomx4WH+Ap9FiV+upghCT1+6BoExZNeECY
 TrZDEhiA1gweY0i8ugxSwsQAb8i43y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-W9H2TWfkPBWGe5Bcts7Lrg-1; Tue, 05 Nov 2019 06:43:22 -0500
X-MC-Unique: W9H2TWfkPBWGe5Bcts7Lrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65DE91800D78;
 Tue,  5 Nov 2019 11:43:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-89.ams2.redhat.com
 [10.36.117.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 471AE19C4F;
 Tue,  5 Nov 2019 11:43:18 +0000 (UTC)
Subject: Re: [RFC PATCH v2 20/26] qcow2: Update L2 bitmap in
 qcow2_alloc_cluster_link_l2()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <289ea5edc3f1530787c8fe905b1a524cc48945a9.1572125022.git.berto@igalia.com>
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
Message-ID: <389b5cbb-2278-86c1-034a-05621a7b4c71@redhat.com>
Date: Tue, 5 Nov 2019 12:43:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <289ea5edc3f1530787c8fe905b1a524cc48945a9.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hk6FhbEyFUgJ4rijzWp4GBGU5Yw2g9Y1Y"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hk6FhbEyFUgJ4rijzWp4GBGU5Yw2g9Y1Y
Content-Type: multipart/mixed; boundary="bBNTny1zOnvN4WsByXzS5GhGH7SnWPuxt"

--bBNTny1zOnvN4WsByXzS5GhGH7SnWPuxt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> The L2 bitmap needs to be updated after each write to indicate what
> new subclusters are now allocated.
>=20
> This needs to happen even if the cluster was already allocated and the
> L2 entry was otherwise valid.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index fb6cf8df17..acb7226e03 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -980,6 +980,22 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs=
, QCowL2Meta *m)
> =20
>          set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_COPIED |
>                       (cluster_offset + (i << s->cluster_bits)));
> +
> +        /* Update bitmap with the subclusters that were just written */
> +        if (has_subclusters(s)) {
> +            uint64_t written_from =3D m->cow_start.offset;
> +            uint64_t written_to =3D m->cow_end.offset + m->cow_end.nb_by=
tes;

It=E2=80=99s a bit strange to make these uint64_t when all the fields queri=
ed
are of type unsigned, but more on that below.

> +            uint64_t l2_bitmap =3D get_l2_bitmap(s, l2_slice, l2_index +=
 i);
> +            int sc;
> +            for (sc =3D 0; sc < s->subclusters_per_cluster; sc++) {
> +                uint64_t sc_off =3D i * s->cluster_size + sc * s->subclu=
ster_size;

It=E2=80=99s weird to give this a uint64_t type when all the variables in t=
he
term are of type int.

I=E2=80=99m not sure whether it can overflow.  handle_alloc() limits everyt=
hing
to INT_MAX, but I=E2=80=99m not sure about handle_copied().

Speaking of handle_copied(); both elements of Qcow2COWRegion are of type
unsigned.  handle_copied() doesn=E2=80=99t look like it takes any precautio=
ns to
limit the range to even UINT_MAX (and it should probably limit it to
INT_MAX).

Max

> +                if (sc_off >=3D written_from && sc_off < written_to) {
> +                    l2_bitmap |=3D QCOW_OFLAG_SUB_ALLOC(sc);
> +                    l2_bitmap &=3D ~QCOW_OFLAG_SUB_ZERO(sc);
> +                }
> +            }
> +            set_l2_bitmap(s, l2_slice, l2_index + i, l2_bitmap);
> +        }
>       }
> =20
> =20
>=20



--bBNTny1zOnvN4WsByXzS5GhGH7SnWPuxt--

--Hk6FhbEyFUgJ4rijzWp4GBGU5Yw2g9Y1Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3BYFQACgkQ9AfbAGHV
z0A6BQgArt5BGXfPJ/A2ZunPyIrwv1RA+y07M1nqllUFcMoAqQV+r4YSk9G4eO29
PSjvzEfmD3xWAmnw8ILT4cutjwZ6zOKOkgh0IjGyf4V9RzmRtlDdGGhkKYIk5Gxa
yWU8YBDG12H2CZi/215S5MwpoKonOAGep8JALf19AmhJlR7CaydZ5dnozflZOnhs
pgDxtWSUNWOXHYUyDS3Rj2hWEWauJBSiH9LmzfkD+wgGknUV7HOfTbdXGW9z47WP
6qz/Y3AA6FbMm+mDRT3LpB3GdOtf1IwEUDga6OJY0J5Wij1x36ALwB6szridA0Jy
jEtL4MxQgew9WalFdRZhr9TGkbhu3g==
=YmOt
-----END PGP SIGNATURE-----

--Hk6FhbEyFUgJ4rijzWp4GBGU5Yw2g9Y1Y--


