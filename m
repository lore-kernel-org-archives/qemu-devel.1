Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C5CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 12:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5524E20663
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 12:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIf9XcMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5524E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPmj7-0000EP-Gt
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 08:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPmi0-0007rO-Jv
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 08:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPmhw-0000iD-04
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 08:04:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPmhv-0000hC-RE
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 08:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572437051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GmU2smz0stxozhfUlOlFnroE/8XyetW2RWDOuA0QmX4=;
 b=WIf9XcMWdDl8CDjx6wS4rY1HeAGdFjQ9Aywlt0gGbYvS/oN1hDYxsxLkpf9yklWb0qaGZF
 ZBN+0ulmo+SEK6LP6NH+lmySAkacS9V7nEWSKZPtGr0DYfQLKcOfQiAxG8lzM5hUTldh3s
 nGbOEAr8D6MjQZUD0p4zkBCgjPYgnmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-t0huNYUGNKOigW9NV4kg4Q-1; Wed, 30 Oct 2019 08:04:08 -0400
X-MC-Unique: t0huNYUGNKOigW9NV4kg4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D760801E7E;
 Wed, 30 Oct 2019 12:04:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-147.ams2.redhat.com
 [10.36.117.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7F1F60876;
 Wed, 30 Oct 2019 12:04:03 +0000 (UTC)
Subject: Re: [RFC PATCH v2 01/26] qcow2: Add calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <22820af5867124e4fdf3d0cb74b99f31edc1b37f.1572125022.git.berto@igalia.com>
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
Message-ID: <49444fb1-d0b2-4325-20ed-91159182ed37@redhat.com>
Date: Wed, 30 Oct 2019 13:04:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <22820af5867124e4fdf3d0cb74b99f31edc1b37f.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ntep0cE7TBUSHQ7ry37e5LWN8ftuGTcyT"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
--ntep0cE7TBUSHQ7ry37e5LWN8ftuGTcyT
Content-Type: multipart/mixed; boundary="l9a7BIHlk32BEL0I4sjzP6sGuVEhy6Y8G"

--l9a7BIHlk32BEL0I4sjzP6sGuVEhy6Y8G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> handle_alloc() creates a QCowL2Meta structure in order to update the
> image metadata and perform the necessary copy-on-write operations.
>=20
> This patch moves that code to a separate function so it can be used
> from other places.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 76 +++++++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 24 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 8982b7b762..6c1dcdc781 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1019,6 +1019,55 @@ void qcow2_alloc_cluster_abort(BlockDriverState *b=
s, QCowL2Meta *m)
>                          QCOW2_DISCARD_NEVER);
>  }
> =20
> +/*
> + * For a given write request, create a new QCowL2Meta structure and
> + * add it to @m.
> + *
> + * @host_offset points to the beginning of the first cluster.

(I intended not to comment on such things on an RFC, but here I am...)

I=E2=80=99d call it host_cluster_offset to make clear that it points to a
cluster and isn=E2=80=99t the host offset for @guest_offset.

And now that I=E2=80=99ve gone this far already, I might as well say that I=
=E2=80=99d
like if it the comment noted that this function not only creates the
L2Meta structure but also adds it to the cluster_allocs list.

> + * @guest_offset and @bytes indicate the offset and length of the
> + * request.
> + *
> + * If @keep_old is true it means that the clusters were already
> + * allocated and will be overwritten. If false then the clusters are
> + * new and we have to decrease the reference count of the old ones.
> + */
> +static void calculate_l2_meta(BlockDriverState *bs, uint64_t host_offset=
,
> +                              uint64_t guest_offset, uint64_t bytes,

And now I=E2=80=99m so deep into non-RFC-level review territory, I might as=
 well
say I=E2=80=99d prefer @bytes to be an unsigned (or maybe even a plain int)=
,
because anything more wouldn=E2=80=99t work.  (Not least because cow_end_to=
 is
an unsigned).

Sorry...

Max

> +                              QCowL2Meta **m, bool keep_old)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    unsigned cow_start_from =3D 0;
> +    unsigned cow_start_to =3D offset_into_cluster(s, guest_offset);
> +    unsigned cow_end_from =3D cow_start_to + bytes;
> +    unsigned cow_end_to =3D ROUND_UP(cow_end_from, s->cluster_size);
> +    unsigned nb_clusters =3D size_to_clusters(s, cow_end_from);
> +    QCowL2Meta *old_m =3D *m;
> +
> +    *m =3D g_malloc0(sizeof(**m));
> +    **m =3D (QCowL2Meta) {
> +        .next           =3D old_m,
> +
> +        .alloc_offset   =3D host_offset,
> +        .offset         =3D start_of_cluster(s, guest_offset),
> +        .nb_clusters    =3D nb_clusters,
> +
> +        .keep_old_clusters =3D keep_old,
> +
> +        .cow_start =3D {
> +            .offset     =3D cow_start_from,
> +            .nb_bytes   =3D cow_start_to - cow_start_from,
> +        },
> +        .cow_end =3D {
> +            .offset     =3D cow_end_from,
> +            .nb_bytes   =3D cow_end_to - cow_end_from,
> +        },
> +    };
> +
> +    qemu_co_queue_init(&(*m)->dependent_requests);
> +    QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
> +}
> +
>  /*
>   * Returns the number of contiguous clusters that can be used for an all=
ocating
>   * write, but require COW to be performed (this includes yet unallocated=
 space,
> @@ -1417,35 +1466,14 @@ static int handle_alloc(BlockDriverState *bs, uin=
t64_t guest_offset,
>      uint64_t requested_bytes =3D *bytes + offset_into_cluster(s, guest_o=
ffset);
>      int avail_bytes =3D nb_clusters << s->cluster_bits;
>      int nb_bytes =3D MIN(requested_bytes, avail_bytes);
> -    QCowL2Meta *old_m =3D *m;
> -
> -    *m =3D g_malloc0(sizeof(**m));
> -
> -    **m =3D (QCowL2Meta) {
> -        .next           =3D old_m,
> -
> -        .alloc_offset   =3D alloc_cluster_offset,
> -        .offset         =3D start_of_cluster(s, guest_offset),
> -        .nb_clusters    =3D nb_clusters,
> -
> -        .keep_old_clusters  =3D keep_old_clusters,
> -
> -        .cow_start =3D {
> -            .offset     =3D 0,
> -            .nb_bytes   =3D offset_into_cluster(s, guest_offset),
> -        },
> -        .cow_end =3D {
> -            .offset     =3D nb_bytes,
> -            .nb_bytes   =3D avail_bytes - nb_bytes,
> -        },
> -    };
> -    qemu_co_queue_init(&(*m)->dependent_requests);
> -    QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
> =20
>      *host_offset =3D alloc_cluster_offset + offset_into_cluster(s, guest=
_offset);
>      *bytes =3D MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offse=
t));
>      assert(*bytes !=3D 0);
> =20
> +    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
> +                      m, keep_old_clusters);
> +
>      return 1;
> =20
>  fail:
>=20



--l9a7BIHlk32BEL0I4sjzP6sGuVEhy6Y8G--

--ntep0cE7TBUSHQ7ry37e5LWN8ftuGTcyT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl25fDIACgkQ9AfbAGHV
z0DLwwf/fg7y8+YnJRX13HMzCh6Ie/HP/3Ti9gxPFilWYL8QcEhhNmCu/j4jO2ls
fchTiJrGW9YGSrKiz1QF78AAeFxuyXYbpdZJx2sijezMcEqBU58N7NdyAa2yMgTV
8sSPlMUTkTj5HWzlHg8RpXUmUi1EeV96/4LT2jhPJqZz9P7HHKCAYXL5V5AoXot1
Fczlmy56ITqtgPC9/Th7roQ2fv+OWE54CmjlhGhNtny1poOVypKD03dDReyemw4y
TZE4nex+O7UI0JcRuo2mYSk8zR5Q8QKDJYPkPEhpmjwste0oH0EaO5FpadXNNkvj
6OApmaMMrO0CNkL9AGd0JeaFMewCPA==
=eO1k
-----END PGP SIGNATURE-----

--ntep0cE7TBUSHQ7ry37e5LWN8ftuGTcyT--


