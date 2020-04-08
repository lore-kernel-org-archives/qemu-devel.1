Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B71C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CE520692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djWqx64s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CE520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM8oq-0002UL-E2
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 07:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jM8oD-00020i-MR
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jM8oC-0005KP-6m
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:23:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37355
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jM8oB-0005K7-Vf
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586345031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kf+ihLcjnlZcMi2P776CPk0h7UtbY8eNpHrJqQOsouI=;
 b=djWqx64syL+chcFEhxgewRr3Etl1PAS1lmlwK0o8Gd/9vDeey2qMLeWySBnagMxFDA34r7
 GwNGN1Bie142NAxrdaVtE18Z5/V3l0UdIZA8WVkSdAbklGfi/WE/XqY893ZLIgI6KCv6d/
 tz4MV5Ws1uDFLFviUfTO29k4K3IusOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-GlFj59mdMqazQw_1fxAqQg-1; Wed, 08 Apr 2020 07:23:49 -0400
X-MC-Unique: GlFj59mdMqazQw_1fxAqQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9918D8017F6;
 Wed,  8 Apr 2020 11:23:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B230F118F24;
 Wed,  8 Apr 2020 11:23:44 +0000 (UTC)
Subject: Re: [PATCH v4 13/30] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <fe21a93340427771899c47569c47063b849b54e6.1584468723.git.berto@igalia.com>
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
Message-ID: <d2b34b1c-4b4b-f363-3bbc-7c3999cf79a2@redhat.com>
Date: Wed, 8 Apr 2020 13:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fe21a93340427771899c47569c47063b849b54e6.1584468723.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mr55Guuft2m0Vu3qUD7DHep7DcOPyj8G2"
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
--Mr55Guuft2m0Vu3qUD7DHep7DcOPyj8G2
Content-Type: multipart/mixed; boundary="zuD3N2n7QF4D8WVnKJpszKkWefGfK4yer"

--zuD3N2n7QF4D8WVnKJpszKkWefGfK4yer
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 19:16, Alberto Garcia wrote:
> This patch adds QCow2SubclusterType, which is the subcluster-level
> version of QCow2ClusterType. All QCOW2_SUBCLUSTER_* values have the
> the same meaning as their QCOW2_CLUSTER_* equivalents (when they
> exist). See below for details and caveats.
>=20
> In images without extended L2 entries clusters are treated as having
> exactly one subcluster so it is possible to replace one data type with
> the other while keeping the exact same semantics.
>=20
> With extended L2 entries there are new possible values, and every
> subcluster in the same cluster can obviously have a different
> QCow2SubclusterType so functions need to be adapted to work on the
> subcluster level.
>=20
> There are several things that have to be taken into account:
>=20
>   a) QCOW2_SUBCLUSTER_COMPRESSED means that the whole cluster is
>      compressed. We do not support compression at the subcluster
>      level.
>=20
>   b) There are two different values for unallocated subclusters:
>      QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN which means that the whole
>      cluster is unallocated, and QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
>      which means that the cluster is allocated but the subcluster is
>      not. The latter can only happen in images with extended L2
>      entries.
>=20
>   c) QCOW2_SUBCLUSTER_INVALID is used to detect the cases where an L2
>      entry has a value that violates the specification. The caller is
>      responsible for handling these situations.
>=20
>      To prevent compatibility problems with images that have invalid
>      values but are currently being read by QEMU without causing side
>      effects, QCOW2_SUBCLUSTER_INVALID is only returned for images
>      with extended L2 entries.
>=20
> qcow2_cluster_to_subcluster_type() is added as a separate function
> from qcow2_get_subcluster_type(), but this is only temporary and both
> will be merged in a subsequent patch.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.h | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 9611efbc52..52865787ee 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h

[...]

> @@ -447,6 +456,33 @@ typedef struct QCowL2Meta
>      QLIST_ENTRY(QCowL2Meta) next_in_flight;
>  } QCowL2Meta;
> =20
> +/*
> + * In images with standard L2 entries all clusters are treated as if
> + * they had one subcluster so QCow2ClusterType and QCow2SubclusterType
> + * can be mapped to each other and have the exact same meaning
> + * (QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC cannot happen in these images).
> + *
> + * In images with extended L2 entries QCow2ClusterType refers to the
> + * complete cluster and QCow2SubclusterType to each of the individual
> + * subclusters, so there are several possible combinations:
> + *
> + *     |--------------+---------------------------|
> + *     | Cluster type | Possible subcluster types |
> + *     |--------------+---------------------------|
> + *     | UNALLOCATED  |         UNALLOCATED_PLAIN |
> + *     |              |                ZERO_PLAIN |
> + *     |--------------+---------------------------|
> + *     | NORMAL       |         UNALLOCATED_ALLOC |
> + *     |              |                ZERO_ALLOC |
> + *     |              |                    NORMAL |
> + *     |--------------+---------------------------|
> + *     | COMPRESSED   |                COMPRESSED |
> + *     |--------------+---------------------------|
> + *
> + * QCOW2_SUBCLUSTER_INVALID means that the L2 entry is incorrect and
> + * the image should be marked corrupt.
> + */
> +

Oh, a welcome addition! :)

[...]

> @@ -632,6 +678,80 @@ static inline QCow2ClusterType qcow2_get_cluster_typ=
e(BlockDriverState *bs,

[...]

> +/*
> + * In an image without subsclusters @l2_bitmap is ignored and
> + * @sc_index must be 0.
> + */
> +static inline
> +QCow2SubclusterType qcow2_get_subcluster_type(BlockDriverState *bs,
> +                                              uint64_t l2_entry,
> +                                              uint64_t l2_bitmap,
> +                                              unsigned sc_index)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    QCow2ClusterType type =3D qcow2_get_cluster_type(bs, l2_entry);
> +    assert(sc_index < s->subclusters_per_cluster);
> +
> +    if (has_subclusters(s)) {
> +        bool sc_zero  =3D l2_bitmap & QCOW_OFLAG_SUB_ZERO(sc_index);
> +        bool sc_alloc =3D l2_bitmap & QCOW_OFLAG_SUB_ALLOC(sc_index);
> +        switch (type) {
> +        case QCOW2_CLUSTER_COMPRESSED:
> +            return QCOW2_SUBCLUSTER_COMPRESSED;

Why did you drop the check that l2_bitmap =3D=3D 0 here?

Max

> +        case QCOW2_CLUSTER_ZERO_PLAIN:
> +        case QCOW2_CLUSTER_ZERO_ALLOC:
> +            return QCOW2_SUBCLUSTER_INVALID;
> +        case QCOW2_CLUSTER_NORMAL:
> +            if (!sc_zero && !sc_alloc) {
> +                return QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC;
> +            } else if (!sc_zero && sc_alloc) {
> +                return QCOW2_SUBCLUSTER_NORMAL;
> +            } else if (sc_zero && !sc_alloc) {
> +                return QCOW2_SUBCLUSTER_ZERO_ALLOC;
> +            } else { /* sc_zero && sc_alloc */
> +                return QCOW2_SUBCLUSTER_INVALID;
> +            }
> +        case QCOW2_CLUSTER_UNALLOCATED:
> +            if (!sc_zero && !sc_alloc) {
> +                return QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
> +            } else if (!sc_zero && sc_alloc) {
> +                return QCOW2_SUBCLUSTER_INVALID;
> +            } else if (sc_zero && !sc_alloc) {
> +                return QCOW2_SUBCLUSTER_ZERO_PLAIN;
> +            } else { /* sc_zero && sc_alloc */
> +                return QCOW2_SUBCLUSTER_INVALID;
> +            }
> +        default:
> +            g_assert_not_reached();
> +        }
> +    } else {
> +        return qcow2_cluster_to_subcluster_type(type);
> +    }
> +}
> +
>  /* Check whether refcounts are eager or lazy */
>  static inline bool qcow2_need_accurate_refcounts(BDRVQcow2State *s)
>  {
>=20



--zuD3N2n7QF4D8WVnKJpszKkWefGfK4yer--

--Mr55Guuft2m0Vu3qUD7DHep7DcOPyj8G2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6NtD4ACgkQ9AfbAGHV
z0A5wAf8C5sJ6RudqfFMeFGotG63+9ApJ2KYq+metrXdTDdsIgn7d6JErgZk8T06
azYiqAoC35iJ7WBLNOHd36RV1BXuimmdAheshv5R2/l/6GfFFtLcSIQA/bVSDQqE
mURxIsu5cAhI2GIR4LjNkZjf42L7vScOIDYLVPI/Ti63anKWcvrt9u3AQem1gzWc
iFXsK6ojqieVmDg4o4x48Hfj/bdN30mS6p0BIOWINZL7oa/U+z1BtO2t6j05xYYs
fO0D5nrJ28xRESEiiHYksnVPTtcFjygBsbyQMQe9FnlN6XwIsXMvWonvjp8RKuL0
fkgANI0YQ673suQLhCshVyC7AMlWuw==
=OmMh
-----END PGP SIGNATURE-----

--Mr55Guuft2m0Vu3qUD7DHep7DcOPyj8G2--


