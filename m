Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F39CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9722054F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 16:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="capjgy6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9722054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPrGS-0008P7-0P
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 12:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPrFc-0007hN-Ao
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPrFa-0006a4-CT
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:55:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPrFa-0006Yb-00
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 12:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572454513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WsYofNem7dmShg1q2+zRpto24KSbGS5VqGkxldgW2Ik=;
 b=capjgy6GyZ+HBw1R6bpyphGvKo2E2Y9Ws+gmfyRtZU9O8KunR27mYJ5b0vN8M0i5r4Hbza
 6ltJ84dKmBMh+y8uritZIZNFicI6D7dzL3YQtjDjsl8UA9TJsnWe4ndpfT16yluTkVaCPN
 U7XFDpBAYv94P8An1oZwynYPHhundCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-LQ1vy9eXN6OXn3AOOIliIA-1; Wed, 30 Oct 2019 12:55:09 -0400
X-MC-Unique: LQ1vy9eXN6OXn3AOOIliIA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70B61800D49;
 Wed, 30 Oct 2019 16:55:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-147.ams2.redhat.com
 [10.36.117.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C4721C95C;
 Wed, 30 Oct 2019 16:55:05 +0000 (UTC)
Subject: Re: [RFC PATCH v2 10/26] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <2d4de1dee301cd772fce97c90e08a390edbe2830.1572125022.git.berto@igalia.com>
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
Message-ID: <012198da-55cd-b176-5cb0-0002fc3b92b1@redhat.com>
Date: Wed, 30 Oct 2019 17:55:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2d4de1dee301cd772fce97c90e08a390edbe2830.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eiWbpiH2NDn2GKo93M8F0s8NDozonsJE2"
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
--eiWbpiH2NDn2GKo93M8F0s8NDozonsJE2
Content-Type: multipart/mixed; boundary="Lc98Ma9tJnVEtOX3B50MqxDATqz2Bi67S"

--Lc98Ma9tJnVEtOX3B50MqxDATqz2Bi67S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> Extended L2 entries are 128-bit wide: 64 bits for the entry itself and
> 64 bits for the subcluster allocation bitmap.
>=20
> In order to support them correctly get/set_l2_entry() need to be
> updated so they take the entry width into account in order to
> calculate the correct offset.
>=20
> This patch also adds the get/set_l2_bitmap() functions that are used
> to access the bitmaps. For convenience, these functions are no-ops
> when used in traditional qcow2 images.

Granted, I haven=E2=80=99t seen the following patches yet, but if these
functions are indeed called for images that don=E2=80=99t have subclusters,
shouldn=E2=80=99t they return 0x0*0f*f then? (i.e. everything allocated)

If they aren=E2=80=99t, they should probably just abort().  Well,
set_l2_bitmap() should probably always abort() if there aren=E2=80=99t any
subclusters.

Max

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 29a253bfb9..741c41c80f 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -507,15 +507,37 @@ static inline size_t l2_entry_size(BDRVQcow2State *=
s)
>  static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slic=
e,
>                                      int idx)
>  {
> +    idx *=3D l2_entry_size(s) / sizeof(uint64_t);
>      return be64_to_cpu(l2_slice[idx]);
>  }
> =20
> +static inline uint64_t get_l2_bitmap(BDRVQcow2State *s, uint64_t *l2_sli=
ce,
> +                                     int idx)
> +{
> +    if (has_subclusters(s)) {
> +        idx *=3D l2_entry_size(s) / sizeof(uint64_t);
> +        return be64_to_cpu(l2_slice[idx + 1]);
> +    } else {
> +        return 0;
> +    }
> +}
> +
>  static inline void set_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
>                                  int idx, uint64_t entry)
>  {
> +    idx *=3D l2_entry_size(s) / sizeof(uint64_t);
>      l2_slice[idx] =3D cpu_to_be64(entry);
>  }
> =20
> +static inline void set_l2_bitmap(BDRVQcow2State *s, uint64_t *l2_slice,
> +                                 int idx, uint64_t bitmap)
> +{
> +    if (has_subclusters(s)) {
> +        idx *=3D l2_entry_size(s) / sizeof(uint64_t);
> +        l2_slice[idx + 1] =3D cpu_to_be64(bitmap);
> +    }
> +}
> +
>  static inline bool has_data_file(BlockDriverState *bs)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>=20



--Lc98Ma9tJnVEtOX3B50MqxDATqz2Bi67S--

--eiWbpiH2NDn2GKo93M8F0s8NDozonsJE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl25wGgACgkQ9AfbAGHV
z0BK5ggApXXmJUGzvFgJVPTnmbYvI6McUGtNMFKtexV4bVp0aoOY6Jc5SE+XpUxS
p3LGXxGuVY3Bby3cnPslw1FvCaIkNB31OPxdSiwdN8GazHr2luJHzrQIPXaeOZo+
w8pcQUyb/sepubf+S+QWUec+wnC8SUqvcwGDOoPAppw3yscOYN9Mk+YayYN9atk+
c7UsnWfhDgHhln6UDrPIAAa3049NLnzQDXHttG+bvYISGh6mZeB5dpvxokxKhddZ
ewnOxeFxibjL+6H9ULJ5O0FkYEEMSninUikR/lMbP1oMpsEDeg3lwsGG9b+CLPLu
CafnEkszb1A2m51wwNyEROM7qxV6Gw==
=HrUE
-----END PGP SIGNATURE-----

--eiWbpiH2NDn2GKo93M8F0s8NDozonsJE2--


