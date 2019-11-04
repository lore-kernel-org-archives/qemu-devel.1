Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440B4CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BF521D7F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fcq+C0A5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BF521D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRdpo-0003ky-5F
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:00:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRdoz-0002io-Lp
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRdox-0006K4-8M
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:59:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRdow-0006Ji-Ny
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572879545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j1/OERgKziLiuSJ/oBL+nny3iOYtPfQI99s0q5fanP0=;
 b=Fcq+C0A5wVJ33qXwViShsOd0fAYvLDXwlAx7coJCVVAaCwErAWJGb10vKgGOeKzAsbKN4m
 arTp94Qy98MLLYXV4ss431i/gdteAoF+alb0e53AO/Fp8SJDItqVT/5ZuhkCH2taMm4w9g
 n+4p6A9tjUfUD62RHgYDej2BLYHtvEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-U9SVBv_qPv6iPXLoBto-7w-1; Mon, 04 Nov 2019 09:59:02 -0500
X-MC-Unique: U9SVBv_qPv6iPXLoBto-7w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E121005500;
 Mon,  4 Nov 2019 14:59:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5C0719C58;
 Mon,  4 Nov 2019 14:58:58 +0000 (UTC)
Subject: Re: [RFC PATCH v2 14/26] qcow2: Add subcluster support to
 qcow2_get_cluster_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <6932c2ddfe19a564cad7c54246290e166525fc46.1572125022.git.berto@igalia.com>
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
Message-ID: <673d72da-bf8c-3ffb-a324-79e93f88a140@redhat.com>
Date: Mon, 4 Nov 2019 15:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <6932c2ddfe19a564cad7c54246290e166525fc46.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v67qdasf4HqgtQPCgwyf2gjP8Vp1Yvw4c"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v67qdasf4HqgtQPCgwyf2gjP8Vp1Yvw4c
Content-Type: multipart/mixed; boundary="yP4GBClMgCRBPHE5l0o8CHqkHKNrlqzT7"

--yP4GBClMgCRBPHE5l0o8CHqkHKNrlqzT7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> The logic of this function remains pretty much the same, except that
> it uses count_contiguous_subclusters(), which combines the logic of
> count_contiguous_clusters() / count_contiguous_clusters_unallocated()
> and checks individual subclusters.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 111 ++++++++++++++++++++----------------------
>  1 file changed, 52 insertions(+), 59 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 990bc070af..e67559152f 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -372,66 +372,51 @@ fail:
>  }
> =20
>  /*
> - * Checks how many clusters in a given L2 slice are contiguous in the im=
age
> - * file. As soon as one of the flags in the bitmask stop_flags changes c=
ompared
> - * to the first cluster, the search is stopped and the cluster is not co=
unted
> - * as contiguous. (This allows it, for example, to stop at the first com=
pressed
> - * cluster which may require a different handling)
> + * Return the number of contiguous subclusters of the exact same type
> + * in a given L2 slice, starting from cluster @l2_index, subcluster
> + * @sc_index. At most @nb_clusters are checked. Allocated clusters are

I=E2=80=99d add a note that reassures that @nb_clusters really is a number =
of
clusters, not subclusters.  (Because if the variable were named =E2=80=9Cx=
=E2=80=9D
(i.e., it=E2=80=99d be =E2=80=9CAt most @x are checked=E2=80=9D), you=E2=80=
=99d assume it refers to a
number of subclusters.)

OTOH, what I don=E2=80=99t like so far about this series is that the =E2=80=
=9Ccluster
logic=E2=80=9D is still everywhere when I think it should just be about
subclusters now.  (Except in few places where it must be about clusters
as in something that can have a distinct host offset and/or has an own
L2 entry.)  So maybe the parameter should really be @nb_subclusters.

But I=E2=80=99m not sure.  For how this function is written right now, it m=
akes
sense for it to be @nb_clusters, but I think it could be changed so it
would work with @nb_subclusters, too.  (Just a single loop over the
subclusters and then loading l2_entry+l2_bitmap and checking the offset
at every cluster boundary.)

> + * also required to be contiguous in the image file.
>   */
> -static int count_contiguous_clusters(BlockDriverState *bs, int nb_cluste=
rs,
> -        int cluster_size, uint64_t *l2_slice, int l2_index, uint64_t sto=
p_flags)
> +static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clu=
sters,
> +                                        unsigned sc_index, uint64_t *l2_=
slice,
> +                                        int l2_index)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> -    int i;
> -    QCow2ClusterType first_cluster_type;
> -    uint64_t mask =3D stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESS=
ED;
> -    uint64_t first_entry =3D get_l2_entry(s, l2_slice, l2_index);
> -    uint64_t offset =3D first_entry & mask;
> -
> -    first_cluster_type =3D qcow2_get_cluster_type(bs, first_entry);
> -    if (first_cluster_type =3D=3D QCOW2_CLUSTER_UNALLOCATED) {
> -        return 0;
> +    int i, j, count =3D 0;
> +    uint64_t l2_entry =3D get_l2_entry(s, l2_slice, l2_index);
> +    uint64_t l2_bitmap =3D get_l2_bitmap(s, l2_slice, l2_index);
> +    uint64_t expected_offset =3D l2_entry & L2E_OFFSET_MASK;
> +    bool check_offset =3D true;
> +    QCow2ClusterType type =3D
> +        qcow2_get_subcluster_type(bs, l2_entry, l2_bitmap, sc_index);
> +
> +    assert(type !=3D QCOW2_CLUSTER_INVALID); /* The caller should check =
this */
> +
> +    if (type =3D=3D QCOW2_CLUSTER_COMPRESSED) {
> +        return 1; /* Compressed clusters are always counted one by one *=
/

Hm, yes, but cluster by cluster, not subcluster by subcluster, so this
should be s->subclusters_per_cluster, and perhaps sc_index should be
asserted to be 0.  (Or it should be s->subclusters_per_cluster - sc_index.)

[...]

> @@ -514,8 +499,8 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, ui=
nt64_t offset,

I suppose this is get_subcluster_offset now.

[...]

> @@ -587,6 +574,13 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, u=
int64_t offset,
>          goto fail;
>      }
>      switch (type) {
> +    case QCOW2_CLUSTER_INVALID:
> +        qcow2_signal_corruption(bs, true, -1, -1, "Invalid cluster entry=
 found "
> +                                " (L2 offset: %#" PRIx64 ", L2 index: %#=
x)",
> +                                l2_offset, l2_index);
> +        ret =3D -EIO;
> +        goto fail;
> +        break;

No need to break here.

>      case QCOW2_CLUSTER_COMPRESSED:
>          if (has_data_file(bs)) {
>              qcow2_signal_corruption(bs, true, -1, -1, "Compressed cluste=
r "
> @@ -602,16 +596,15 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, =
uint64_t offset,
>          break;

Here (QCOW2_CLUSTER_COMPRESSED), c is 1, even though it should count
subclusters.

Max

>      case QCOW2_CLUSTER_ZERO_PLAIN:
>      case QCOW2_CLUSTER_UNALLOCATED:
> -        /* how many empty clusters ? */
> -        c =3D count_contiguous_clusters_unallocated(bs, nb_clusters,
> -                                                  l2_slice, l2_index, ty=
pe);
> +        c =3D count_contiguous_subclusters(bs, nb_clusters, sc_index,
> +                                         l2_slice, l2_index);
>          *cluster_offset =3D 0;
>          break;


--yP4GBClMgCRBPHE5l0o8CHqkHKNrlqzT7--

--v67qdasf4HqgtQPCgwyf2gjP8Vp1Yvw4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3APLEACgkQ9AfbAGHV
z0CQnQgAgTWcl6HpUNx8k/y4uS3QUGUWaCRZmlr4riqJFGejYPxJR8jAVO7BkbqQ
g/ZWcJnDa4yYrivtZKrx1dzAS8tMD+w+97eJqImP49aFBxtS3NtQcS+mDgtyklAP
qdyA12J0ZnVH3sOh8rt9ZNao3yUk415da2yo5MrUX5V2kgMjaAYzoDytu2ICAcnQ
4W6D/oMwgDzmMbL3u4bHvk80IlD6gllmJsUXpZuiKeigei7mQ2sW4DLU8Ga7FO8L
l4GZZ78pOgyBpASSUEB//QBSKSJMPVlL7FNm5MNR7gXwhcnW+Jr7B/JW5Pl/P4oX
Bi+LhR6kgtI/9Rk/sAHcjfLdojBNrw==
=sacI
-----END PGP SIGNATURE-----

--v67qdasf4HqgtQPCgwyf2gjP8Vp1Yvw4c--


