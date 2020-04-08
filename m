Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF39C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235A720768
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvN6vBlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235A720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7sb-000797-BS
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jM7rp-00068y-RI
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jM7rm-0002IX-MA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:23:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32040
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jM7rm-0002IK-HC
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586341409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y9bDpe+y57eaDN9iDWVXj0KTmji3PTrzK4YxLSu5gVs=;
 b=FvN6vBlpYFyCVzTqNV1gfJOAdxzwACzFwXjsWtZfv1VJ3fyoGajfStbxuZcFOPhOebqkTH
 EQqRI52VBRaphTgfxkA74yOEeFh1cOkG9BFsbMc0UmZcXulF+q2ZPnnYufBPr1eLTcs4yA
 DRADL5K6gr+awSSS3auYmnIJj6xoq4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-w4W5OgLnNQu5C7N0ZwphZA-1; Wed, 08 Apr 2020 06:23:27 -0400
X-MC-Unique: w4W5OgLnNQu5C7N0ZwphZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 646531005513;
 Wed,  8 Apr 2020 10:23:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D1C114819;
 Wed,  8 Apr 2020 10:23:22 +0000 (UTC)
Subject: Re: [PATCH v4 01/30] qcow2: Make Qcow2AioTask store the full host
 offset
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <d5e20c41da4fa7821704ad1125167fd507eaf7a7.1584468723.git.berto@igalia.com>
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
Message-ID: <02ed4089-9555-c0d5-000f-2363070b3862@redhat.com>
Date: Wed, 8 Apr 2020 12:23:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d5e20c41da4fa7821704ad1125167fd507eaf7a7.1584468723.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K5erISOff499ns8ncclSu4g2wvly2PNOS"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
--K5erISOff499ns8ncclSu4g2wvly2PNOS
Content-Type: multipart/mixed; boundary="l0PIQ3HgzMEXcYYl2Ga8Dc0oNxcoVRKwY"

--l0PIQ3HgzMEXcYYl2Ga8Dc0oNxcoVRKwY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 19:15, Alberto Garcia wrote:
> The file_cluster_offset field of Qcow2AioTask stores a cluster-aligned
> host offset. In practice this is not very useful because all users(*)
> of this structure need the final host offset into the cluster, which
> they calculate using
>=20
>    host_offset =3D file_cluster_offset + offset_into_cluster(s, offset)
>=20
> There is no reason why Qcow2AioTask cannot store host_offset directly
> and that is what this patch does.
>=20
> (*) compressed clusters are the exception: in this case what
>     file_cluster_offset was storing was the full compressed cluster
>     descriptor (offset + size). This does not change with this patch
>     but it is documented now.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 68 +++++++++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index d44b45633d..a00b0c8e45 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -2409,8 +2410,7 @@ static coroutine_fn int qcow2_co_pwritev_task(Block=
DriverState *bs,
>          }
>          qemu_iovec_to_buf(qiov, qiov_offset, crypt_buf, bytes);
> =20
> -        if (qcow2_co_encrypt(bs, file_cluster_offset + offset_in_cluster=
,
> -                             offset, crypt_buf, bytes) < 0)
> +        if (qcow2_co_encrypt(bs, host_offset, offset, crypt_buf, bytes) =
< 0)
>          {

This { should now go on the preceding line; with that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>              ret =3D -EIO;
>              goto out_unlocked;


--l0PIQ3HgzMEXcYYl2Ga8Dc0oNxcoVRKwY--

--K5erISOff499ns8ncclSu4g2wvly2PNOS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6NphgACgkQ9AfbAGHV
z0CeRwgAtmF60VGdf6Alb3ruZCFSwUbYmRUn6VHl/P1fmHuXwvTaOVpXB3SUncok
kbK54yzWBAnzd3fDYzgamlU9i374gn3BpjEZ3YMG+HX701f+ulTVr7pla7tn3+Ui
zt8RgDn8d5m7sHkRmf5BygTVy+BIXQLyfgedOj+nljfbpn1nyTvznpnKmdQBoBbF
1miVFI8wpBP20iaD+JLyYj3jMPWRJ0cC7RR0cEBbt+b2ZZ/r6Iyt81HgqSb/mdXk
SCzmvWPtu5J16birfUCZ1pNB35yYaQNtQe9TXlmhflmOtCFgA4RHBiakXrx6KB1p
G3KETc8WudZfbXrW/JjMbQpOU6k04g==
=ePQG
-----END PGP SIGNATURE-----

--K5erISOff499ns8ncclSu4g2wvly2PNOS--


