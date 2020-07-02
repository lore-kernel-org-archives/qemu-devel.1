Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0818CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58BC20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 14:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkWDnMd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58BC20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0Du-0007Z8-2b
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 10:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jr0D6-000667-T1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:29:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40359
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jr0D5-0003HG-8X
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 10:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593700146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0HEN/Wb/5c1iESdvCR8oXBr/DtqD9PSD/km8m+DVmpc=;
 b=GkWDnMd/LcyGJ9Xbx8M3nW+LwWLkgetBSmQQmxAbWeUlmKAJSq5eqUjgRIophzEmJdLWco
 +sCAgogPVTKHorfM9UPW4d8wuAqf7IeuWvXgo+zUkjH/DuLmiak5ayjzoV0S2fyjBnj7x7
 QTshkbqJnmBk9qsG+ULl87ymP4yGRyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-dn2YHwtvM9mIChVDZhEGog-1; Thu, 02 Jul 2020 10:29:02 -0400
X-MC-Unique: dn2YHwtvM9mIChVDZhEGog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8221800597;
 Thu,  2 Jul 2020 14:29:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 050DA7789E;
 Thu,  2 Jul 2020 14:28:58 +0000 (UTC)
Subject: Re: [PATCH v9 28/34] qcow2: Add subcluster support to
 qcow2_co_pwrite_zeroes()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <3c6140626c443f1eb443881eddcfb65b6107aff2.1593342067.git.berto@igalia.com>
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
Message-ID: <25384933-0ca3-3f50-c1af-4c92e8c88328@redhat.com>
Date: Thu, 2 Jul 2020 16:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3c6140626c443f1eb443881eddcfb65b6107aff2.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sq5xbjMnO6yPPrnYUR83tP3lHHMC9qABT"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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
--sq5xbjMnO6yPPrnYUR83tP3lHHMC9qABT
Content-Type: multipart/mixed; boundary="AJQogpYMhWN1CtMfn5glg1AdRRgCOf8Ih"

--AJQogpYMhWN1CtMfn5glg1AdRRgCOf8Ih
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> This works now at the subcluster level and pwrite_zeroes_alignment is
> updated accordingly.
>=20
> qcow2_cluster_zeroize() is turned into qcow2_subcluster_zeroize() with
> the following changes:
>=20
>    - The request can now be subcluster-aligned.
>=20
>    - The cluster-aligned body of the request is still zeroized using
>      zero_in_l2_slice() as before.
>=20
>    - The subcluster-aligned head and tail of the request are zeroized
>      with the new zero_l2_subclusters() function.
>=20
> There is just one thing to take into account for a possible future
> improvement: compressed clusters cannot be partially zeroized so
> zero_l2_subclusters() on the head or the tail can return -ENOTSUP.
> This makes the caller repeat the *complete* request and write actual
> zeroes to disk. This is sub-optimal because
>=20
>    1) if the head area was compressed we would still be able to use
>       the fast path for the body and possibly the tail.
>=20
>    2) if the tail area was compressed we are writing zeroes to the
>       head and the body areas, which are already zeroized.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.h         |  4 +--
>  block/qcow2-cluster.c | 80 +++++++++++++++++++++++++++++++++++++++----
>  block/qcow2.c         | 27 ++++++++-------
>  3 files changed, 90 insertions(+), 21 deletions(-)

[...]

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index deff838fe8..1641976028 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2015,12 +2015,58 @@ static int zero_in_l2_slice(BlockDriverState *bs,=
 uint64_t offset,
>      return nb_clusters;
>  }
> =20
> -int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
> -                          uint64_t bytes, int flags)
> +static int zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
> +                               unsigned nb_subclusters)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t *l2_slice;
> +    uint64_t old_l2_bitmap, l2_bitmap;
> +    int l2_index, ret, sc =3D offset_to_sc_index(s, offset);
> +
> +    /* For full clusters use zero_in_l2_slice() instead */
> +    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_clu=
ster);
> +    assert(sc + nb_subclusters <=3D s->subclusters_per_cluster);

Maybe we should also assert that @offset is aligned to the subcluster size.

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 86258fbc22..4edc3c72b9 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -4367,12 +4367,13 @@ static int coroutine_fn qcow2_co_truncate(BlockDr=
iverState *bs, int64_t offset,
>          uint64_t zero_start =3D QEMU_ALIGN_UP(old_length, s->cluster_siz=
e);

Can we instead align this to just subclusters?

> =20
>          /*
> -         * Use zero clusters as much as we can. qcow2_cluster_zeroize()
> +         * Use zero clusters as much as we can. qcow2_subcluster_zeroize=
()
>           * requires a cluster-aligned start. The end may be unaligned if=
 it is

s/cluster/subcluster/?

Max

>           * at the end of the image (which it is here).
>           */
>          if (offset > zero_start) {
> -            ret =3D qcow2_cluster_zeroize(bs, zero_start, offset - zero_=
start, 0);
> +            ret =3D qcow2_subcluster_zeroize(bs, zero_start, offset - ze=
ro_start,
> +                                           0);
>              if (ret < 0) {
>                  error_setg_errno(errp, -ret, "Failed to zero out new clu=
sters");
>                  goto fail;
>=20


--AJQogpYMhWN1CtMfn5glg1AdRRgCOf8Ih--

--sq5xbjMnO6yPPrnYUR83tP3lHHMC9qABT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl797ykACgkQ9AfbAGHV
z0B/KAgAnJs3K3v9bfYpwLzhiFWiUotFJRF0GlNxRxRK/B/CmFGUPyYMeMrLGCs2
ixTluaG0/So3eH/rINaCKYiTmOBijc0RZ+aj+Hu7K75IZ3SjmQVt58OLZeOk3m2L
wLTHZCTOdSP68fQfz6a0PUVKHLjp4uj8jMKYsZGTmADkHK9wi3Hr6msnck4lzCAF
BlMW7acGP+7GTfUNocx2eehjbCtIsAPUYUqrtVhqsHjKz8xaitxUFSOQdix3+SIA
mTqsfOLlW0i95wpHJ3RWnJ/ds9YVfk6Z6syP4+cUtrcU1gVCTp7BP5G8h1VyE+g0
DH1gvI3w+mfIsA7xEVbWSvuDSXNmpQ==
=NLRj
-----END PGP SIGNATURE-----

--sq5xbjMnO6yPPrnYUR83tP3lHHMC9qABT--


