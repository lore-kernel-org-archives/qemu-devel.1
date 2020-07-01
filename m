Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA15C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B850520772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBfEETPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B850520772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcEz-0002Yr-Sm
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqcE2-0001EH-QD
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:52:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqcE0-000457-RJ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593607947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hXrgLROq3wfiTtbVae71XTOpycSGZ4y9Rd7y/vUea0c=;
 b=TBfEETPcxrLm8KzBAiRFxg0fYs7ljYZLZnahzGYQwgbj50RlF/xsF/OAXBTarsn1tVZdHB
 ZYmV5RFDa1h7k5IDOwR/kllj7BnnUbm6QRpDp3IvSP0nZ4wCqvoZ7mY2zHTGnnfbgvmSPz
 Y8L7EaevYR49hkAPDqQcsXbJCzkGoZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-kj58tENuP4ax7LeDyg4JNQ-1; Wed, 01 Jul 2020 08:52:22 -0400
X-MC-Unique: kj58tENuP4ax7LeDyg4JNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D391EC1A2;
 Wed,  1 Jul 2020 12:52:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-108.ams2.redhat.com
 [10.36.113.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA0932C8A1;
 Wed,  1 Jul 2020 12:52:15 +0000 (UTC)
Subject: Re: [PATCH v9 14/34] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <6ee75696d3eaed56b46e91fe242fdfab51feb066.1593342067.git.berto@igalia.com>
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
Message-ID: <fae77394-92fd-d170-0ae6-051c0a024d04@redhat.com>
Date: Wed, 1 Jul 2020 14:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6ee75696d3eaed56b46e91fe242fdfab51feb066.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p2dUy6WBRzNwKHeJ3WTxknSSrDhfbcC6D"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p2dUy6WBRzNwKHeJ3WTxknSSrDhfbcC6D
Content-Type: multipart/mixed; boundary="SyovLqWL5RKxyNpIO89TZsVKytAFJ7It8"

--SyovLqWL5RKxyNpIO89TZsVKytAFJ7It8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
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
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.h | 126 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 82b86f6cec..3aec6f452a 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h

[...]

> @@ -634,9 +686,11 @@ static inline int64_t qcow2_vm_state_offset(BDRVQcow=
2State *s)
>  static inline QCow2ClusterType qcow2_get_cluster_type(BlockDriverState *=
bs,
>                                                        uint64_t l2_entry)
>  {
> +    BDRVQcow2State *s =3D bs->opaque;
> +
>      if (l2_entry & QCOW_OFLAG_COMPRESSED) {
>          return QCOW2_CLUSTER_COMPRESSED;
> -    } else if (l2_entry & QCOW_OFLAG_ZERO) {
> +    } else if ((l2_entry & QCOW_OFLAG_ZERO) && !has_subclusters(s)) {

OK, so now qcow2_get_cluster_type() reports zero clusters to be normal
or unallocated clusters when there are subclusters.  Seems weird to me,
because zero clusters are invalid clusters then.  I preferred just
reporting them as zero clusters and letting the caller deal with it,
because it does mean an error in the image and so it should be reported.

So...

>          if (l2_entry & L2E_OFFSET_MASK) {
>              return QCOW2_CLUSTER_ZERO_ALLOC;
>          }

[...]

> +/*
> + * In an image without subsclusters @l2_bitmap is ignored and
> + * @sc_index must be 0.
> + * Return QCOW2_SUBCLUSTER_INVALID if an invalid l2 entry is detected
> + * (this checks the whole entry and bitmap, not only the bits related
> + * to subcluster @sc_index).
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
> +        switch (type) {
> +        case QCOW2_CLUSTER_COMPRESSED:
> +            return QCOW2_SUBCLUSTER_COMPRESSED;
> +        case QCOW2_CLUSTER_NORMAL:
> +            if ((l2_bitmap >> 32) & l2_bitmap) {
> +                return QCOW2_SUBCLUSTER_INVALID;
> +            } else if (l2_bitmap & QCOW_OFLAG_SUB_ZERO(sc_index)) {
> +                return QCOW2_SUBCLUSTER_ZERO_ALLOC;
> +            } else if (l2_bitmap & QCOW_OFLAG_SUB_ALLOC(sc_index)) {
> +                return QCOW2_SUBCLUSTER_NORMAL;
> +            } else {
> +                return QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC;
> +            }
> +        case QCOW2_CLUSTER_UNALLOCATED:
> +            if (l2_bitmap & QCOW_L2_BITMAP_ALL_ALLOC) {
> +                return QCOW2_SUBCLUSTER_INVALID;
> +            } else if (l2_bitmap & QCOW_OFLAG_SUB_ZERO(sc_index)) {
> +                return QCOW2_SUBCLUSTER_ZERO_PLAIN;
> +            } else {
> +                return QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN;
> +            }

...consequentially, this function no longer reports clusters which have
the zero flag set as invalid (which it did in v4, when I last looked at it)=
.

I see this was a conscious choice of yours in v5.  I don=E2=80=99t really s=
ee
the justification for it, though.  As far as I can understand, you seem
to argue that no corruption detection is better than incomplete
corruption detection, and that a complete and thorough detection would
warrant its own series, do I understand that correctly?

Max

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



--SyovLqWL5RKxyNpIO89TZsVKytAFJ7It8--

--p2dUy6WBRzNwKHeJ3WTxknSSrDhfbcC6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl78hv4ACgkQ9AfbAGHV
z0B9jQf+KhnDoG14hGwgi35onoTUv9Qf+AnuZbiWPa74WdTxW95nHzukVcv5hHhx
cmdHx3YUg+gsICiVJwD3xcEq0e49YzpJ+94KtUPlFmmUVBRxjZE7hecDi9o97CLj
ZCjZjjAgXn0TyLRgCEFhLaPj6Y4Mu+qjROCC6Z/nXUtx32S5LgzE+52maHyqEyLP
VNx6HCO+dDy7bOWddNkUfxFaINpG9WeYxCMct6CkgbB83kBrOCf4PzdeQneTY9R5
gRZP4gCpkXthKS2RwYd1EbyUc8pDntMwwhtDAs4/dYiuwIMU6AAwk+PY1b5s4dqQ
jCVJFi6WXxC34oM+YYyFXgg652NV0Q==
=xUpo
-----END PGP SIGNATURE-----

--p2dUy6WBRzNwKHeJ3WTxknSSrDhfbcC6D--


