Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A3DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E74220885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShVeZD6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E74220885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqycd-0001uT-Fm
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqybw-0000vR-Ty
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:46:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqybt-00054G-Sf
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593693996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FQoLx0+3ADCJl/0+Q/DpDCM2F58xO0dNOuxxEPHYLTM=;
 b=ShVeZD6Pz/DiMAtQij00TUJIerN5XF69HQZGwcQaM8QekrzLxNeno2GXdVwiRNupL8g9xe
 djbjsqvPBhWJF4oAQFH5O4OF4ba+b9rCPs1OH0bkOGSPqA3mVD+2ElNG+2r/+wyDpllcGT
 9VBPTckFxIQhQXh2HEsMoRf8168J7ZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-68ZPw3MaPSm2o3ErGuviyg-1; Thu, 02 Jul 2020 08:46:32 -0400
X-MC-Unique: 68ZPw3MaPSm2o3ErGuviyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 443A580400F;
 Thu,  2 Jul 2020 12:46:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 816095C1D3;
 Thu,  2 Jul 2020 12:46:29 +0000 (UTC)
Subject: Re: [PATCH v9 21/34] qcow2: Add subcluster support to
 qcow2_get_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <d82b7e4829f466eda81f3a33b536dde43aa3e26a.1593342067.git.berto@igalia.com>
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
Message-ID: <2dada231-fc81-04af-0f70-d883ca41433a@redhat.com>
Date: Thu, 2 Jul 2020 14:46:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d82b7e4829f466eda81f3a33b536dde43aa3e26a.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aD4ErQFOZI2ELaJPfPVt0XX4W9fLTkwgW"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
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
--aD4ErQFOZI2ELaJPfPVt0XX4W9fLTkwgW
Content-Type: multipart/mixed; boundary="8ufPRCSs8fstvsvEdw9G6Q0jxDlmvEbsS"

--8ufPRCSs8fstvsvEdw9G6Q0jxDlmvEbsS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> The logic of this function remains pretty much the same, except that
> it uses count_contiguous_subclusters(), which combines the logic of
> count_contiguous_clusters() / count_contiguous_clusters_unallocated()
> and checks individual subclusters.
>=20
> qcow2_cluster_to_subcluster_type() is not necessary as a separate
> function anymore so it's inlined into its caller.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.h         |  38 ++++-------
>  block/qcow2-cluster.c | 150 ++++++++++++++++++++++--------------------
>  2 files changed, 92 insertions(+), 96 deletions(-)

[...]

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 59dd9bda29..2f3bd3a882 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -426,66 +426,66 @@ static int qcow2_get_subcluster_range_type(BlockDri=
verState *bs,

[...]

> +static int count_contiguous_subclusters(BlockDriverState *bs, int nb_clu=
sters,
> +                                        unsigned sc_index, uint64_t *l2_=
slice,
> +                                        unsigned *l2_index)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> -    int i;
> -    QCow2ClusterType first_cluster_type;
> -    uint64_t mask =3D stop_flags | L2E_OFFSET_MASK | QCOW_OFLAG_COMPRESS=
ED;
> -    uint64_t first_entry =3D get_l2_entry(s, l2_slice, l2_index);
> -    uint64_t offset =3D first_entry & mask;
> +    int i, count =3D 0;
> +    bool check_offset;
> +    uint64_t expected_offset;
> +    QCow2SubclusterType expected_type, type;
> =20
> -    first_cluster_type =3D qcow2_get_cluster_type(bs, first_entry);
> -    if (first_cluster_type =3D=3D QCOW2_CLUSTER_UNALLOCATED) {
> -        return 0;
> -    }
> -
> -    /* must be allocated */
> -    assert(first_cluster_type =3D=3D QCOW2_CLUSTER_NORMAL ||
> -           first_cluster_type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC);
> +    assert(*l2_index + nb_clusters <=3D s->l2_size);

Not l2_slice_size?

> =20
>      for (i =3D 0; i < nb_clusters; i++) {
> -        uint64_t l2_entry =3D get_l2_entry(s, l2_slice, l2_index + i) & =
mask;
> -        if (offset + (uint64_t) i * cluster_size !=3D l2_entry) {
> +        unsigned first_sc =3D (i =3D=3D 0) ? sc_index : 0;
> +        uint64_t l2_entry =3D get_l2_entry(s, l2_slice, *l2_index + i);
> +        uint64_t l2_bitmap =3D get_l2_bitmap(s, l2_slice, *l2_index + i)=
;
> +        int ret =3D qcow2_get_subcluster_range_type(bs, l2_entry, l2_bit=
map,
> +                                                  first_sc, &type);
> +        if (ret < 0) {
> +            *l2_index +=3D i; /* Point to the invalid entry */
> +            return -EIO;
> +        }
> +        if (i =3D=3D 0) {
> +            if (type =3D=3D QCOW2_SUBCLUSTER_COMPRESSED) {
> +                /* Compressed clusters are always processed one by one *=
/
> +                return ret;
> +            }
> +            expected_type =3D type;
> +            expected_offset =3D l2_entry & L2E_OFFSET_MASK;
> +            check_offset =3D (type =3D=3D QCOW2_SUBCLUSTER_NORMAL ||
> +                            type =3D=3D QCOW2_SUBCLUSTER_ZERO_ALLOC ||
> +                            type =3D=3D QCOW2_SUBCLUSTER_UNALLOCATED_ALL=
OC);
> +        } else if (type !=3D expected_type) {
>              break;
> +        } else if (check_offset) {

My gcc (v10.1.1) appears to be a bit daft, and so doesn=E2=80=99t recognize=
 that
check_offset must always be initialized before this line is hit.

> +            expected_offset +=3D s->cluster_size;

Same for expected_offset.

Would you mind helping it by initializing them in their definition? O:)

Max


--8ufPRCSs8fstvsvEdw9G6Q0jxDlmvEbsS--

--aD4ErQFOZI2ELaJPfPVt0XX4W9fLTkwgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl791yMACgkQ9AfbAGHV
z0AqSQf/eQxg8mbWvzYt0ITvpc5zn3joqh5mkzvc8huV4OnvQwnKIYokm1BCv0tR
0+YSeA/mhwntLHKEMLz5mM3NL3ZHZGsXYHy/SJFs42ens1wu1vtI8J2ElsKxsaWG
AGBXMHcz5/+44IltTI03zmxbinBQqsiKBYutDqFoFJrYsEOmIzAOidJEXDcwAMNs
uFtv7a0Muu1D1xJBEkiJOjYVi0cbq58t/Ia2e3wI+QnP7ugDMbaqhOr1aBMTeabE
YD+JPehITTWbP+2QM5JSB8kpkH52KLjJ5TkJmrXxqi/27McaO2nZT6gXz9bOVMMC
3pUDyYrVb1mviKJd5pFH0XjohUWLBQ==
=0v9B
-----END PGP SIGNATURE-----

--aD4ErQFOZI2ELaJPfPVt0XX4W9fLTkwgW--


