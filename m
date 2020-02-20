Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3F2C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7CD207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNFIFP3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7CD207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4neX-0006Vf-8e
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4ncV-0005Ly-9I
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4ncT-0007Ab-P2
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:20:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4ncT-00079v-Kt
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582212004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6xit2VhaB5KgwIXvoiTeq6/Y5us8FKvqzXS2+6K+vSM=;
 b=WNFIFP3aP9Ucush2ZCYWMy86Zre/Z7upr+YwaB1QwtTDAZI9lyZiLRhhpc4tWr0yeSkpt4
 kAmwz0PVDcdUvVPnX2GYUwgdKoEuOxgQDWjiIxiAm8PDZJyjiBdBPTx7ZAZRU5lGgLesat
 V1c9L2RkDv5+Q1ubBhh7jO6MGRHk1tI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-YzhSLJ6VMg-JDKn8GW7T0g-1; Thu, 20 Feb 2020 10:20:00 -0500
X-MC-Unique: YzhSLJ6VMg-JDKn8GW7T0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA3BC19057A6;
 Thu, 20 Feb 2020 15:19:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD1419051B;
 Thu, 20 Feb 2020 15:19:36 +0000 (UTC)
Subject: Re: [RFC PATCH v3 03/27] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC
 clusters in handle_copied()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <e327f4c1ed2f9626ce018c1fd2b9db437721b30c.1577014346.git.berto@igalia.com>
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
Message-ID: <3d87fc6f-7f94-2da6-654a-a2dece6e5b5c@redhat.com>
Date: Thu, 20 Feb 2020 16:19:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e327f4c1ed2f9626ce018c1fd2b9db437721b30c.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hn8gWREllaGZ18ZSddBsmPlsHZ7WKeDhT"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hn8gWREllaGZ18ZSddBsmPlsHZ7WKeDhT
Content-Type: multipart/mixed; boundary="HblUGXCbIhCxhdg8aTE1O2J7zDg2AtRBE"

--HblUGXCbIhCxhdg8aTE1O2J7zDg2AtRBE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I have no idea how I managed to forgot some style comments I wrote
during the review, but, anyway:

On 22.12.19 12:36, Alberto Garcia wrote:
> When writing to a qcow2 file there are two functions that take a
> virtual offset and return a host offset, possibly allocating new
> clusters if necessary:
>=20
>    - handle_copied() looks for normal data clusters that are already
>      allocated and have a reference count of 1. In those clusters we
>      can simply write the data and there is no need to perform any
>      copy-on-write.
>=20
>    - handle_alloc() looks for clusters that do need copy-on-write,
>      either because they haven't been allocated yet, because their
>      reference count is !=3D 1 or because they are ZERO_ALLOC clusters.
>=20
> The ZERO_ALLOC case is a bit special because those are clusters that
> are already allocated and they could perfectly be dealt with in
> handle_copied() (as long as copy-on-write is performed when required).
>=20
> In fact, there is extra code specifically for them in handle_alloc()
> that tries to reuse the existing allocation if possible and frees them
> otherwise.
>=20
> This patch changes the handling of ZERO_ALLOC clusters so the
> semantics of these two functions are now like this:
>=20
>    - handle_copied() looks for clusters that are already allocated and
>      which we can overwrite (NORMAL and ZERO_ALLOC clusters with a
>      reference count of 1).
>=20
>    - handle_alloc() looks for clusters for which we need a new
>      allocation (all other cases).
>=20
> One importante difference after this change is that clusters found in

s/importante/important/

> handle_copied() may now require copy-on-write, but this will be anyway
> necessary once we add support for subclusters.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 226 +++++++++++++++++++++++-------------------
>  1 file changed, 126 insertions(+), 100 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index e078bddcc2..9387f15866 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c

[...]

> @@ -1035,15 +1040,53 @@ void qcow2_alloc_cluster_abort(BlockDriverState *=
bs, QCowL2Meta *m)
>  static void calculate_l2_meta(BlockDriverState *bs,
>                                uint64_t host_cluster_offset,
>                                uint64_t guest_offset, unsigned bytes,
> -                              QCowL2Meta **m, bool keep_old)
> +                              uint64_t *l2_slice, QCowL2Meta **m, bool k=
eep_old)
>  {

[...]

> +    /* Return if there's no COW (all clusters are normal and we keep the=
m) */
> +    if (keep_old) {
> +        int i;
> +        for (i =3D 0; i < nb_clusters; i++) {
> +            l2_entry =3D be64_to_cpu(l2_slice[l2_index + i]);
> +            if (qcow2_get_cluster_type(bs, l2_entry) !=3D QCOW2_CLUSTER_=
NORMAL) {
> +                break;
> +            }
> +        }
> +        if (i =3D=3D nb_clusters) {
> +            return;
> +        }
> +    }
> +
> +    /* Get the L2 entry from the first cluster */

s/from/of/

(Otherwise it sounds a bit like this is the same entry for all clusters)

> +    l2_entry =3D be64_to_cpu(l2_slice[l2_index]);
> +    type =3D qcow2_get_cluster_type(bs, l2_entry);
> +
> +    if (type =3D=3D QCOW2_CLUSTER_NORMAL && keep_old) {
> +        cow_start_from =3D cow_start_to;
> +    } else {
> +        cow_start_from =3D 0;
> +    }
> +
> +    /* Get the L2 entry from the last cluster */

s/from/of/

> +    l2_entry =3D be64_to_cpu(l2_slice[l2_index + nb_clusters - 1]);
> +    type =3D qcow2_get_cluster_type(bs, l2_entry);
> +
> +    if (type =3D=3D QCOW2_CLUSTER_NORMAL && keep_old) {
> +        cow_end_to =3D cow_end_from;
> +    } else {
> +        cow_end_to =3D ROUND_UP(cow_end_from, s->cluster_size);
> +    }
> =20
>      *m =3D g_malloc0(sizeof(**m));
>      **m =3D (QCowL2Meta) {
> @@ -1069,18 +1112,20 @@ static void calculate_l2_meta(BlockDriverState *b=
s,
>      QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
>  }
> =20
> -/* Returns true if writing to a cluster requires COW */
> -static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
> +/* Returns true if writing to the cluster pointed to by @l2_entry
> + * requires a new allocation (that is, if the cluster is unallocated
> + * or has refcount > 1 and therefore cannot be written in-place). */

Not sure why Patchew hasn=E2=80=99t complained, but the current coding styl=
e
requires /* and */ to be on separate lines for multi-line comments.

Max


--HblUGXCbIhCxhdg8aTE1O2J7zDg2AtRBE--

--hn8gWREllaGZ18ZSddBsmPlsHZ7WKeDhT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5Oo4UACgkQ9AfbAGHV
z0DMfgf/VIJ1N3jmdFD2Nu8AETDfv9VoQn8BFNlcYeWDZfadbGVP8rBmEL4XZvGx
/CibNHGbSncAaf/tuTsHSiuLMme+gdZs0gzn/sq7OEleWV7NnpxwK5BXtj8ijI5h
89rWVpuisA7YE0GLRZ+GqQvjE3FAoTKAT3z75lXdis+akpyX1iaBNE5MR3q8pnUg
9zrioiLVVQdxhFOwwr0t+RBSIP1EMsR6lrJXmDDDt0+Ce8I3vt6np3A+hK+1QPXP
QKVHqrQr/CtUrTEYggzeciak91bWU3wuqcsslOOaT3qFqGDkCYzWOv5Qo+CovhYF
hkQcILJ58IQITVEoMrFiCG1H+Hhzmw==
=cbpp
-----END PGP SIGNATURE-----

--hn8gWREllaGZ18ZSddBsmPlsHZ7WKeDhT--


