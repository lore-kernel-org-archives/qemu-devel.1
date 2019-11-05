Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EFDC17460
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F178221882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AktLQ4Oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F178221882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRyGV-0003En-6S
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 07:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRyFm-0002iT-7H
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRyFk-00011i-Mo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:48:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRyFk-00010E-Il
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572958088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6KxeP3S+SPzQo8AHahV+ietL3li07+NiIX+55/tMxlo=;
 b=AktLQ4OqIF35At3XEL1OmCpiPczI/+fpBvKZIZKzMI4i5TeT51DeW2icp3oOJ+K2RXJNSE
 NaT/6TlN48PmRgORUM1pahG+YaKQn0T+gNCGw0ubGJavmMlAg5rvM6Dyq5qgew7afhNSxw
 OnAqiciUWqeKmsy4yTiY7IvUb4U1sfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-oyHaULYpMzqiCEzUptNMTg-1; Tue, 05 Nov 2019 07:48:04 -0500
X-MC-Unique: oyHaULYpMzqiCEzUptNMTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDBB01800D4A;
 Tue,  5 Nov 2019 12:48:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-89.ams2.redhat.com
 [10.36.117.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C26360BF4;
 Tue,  5 Nov 2019 12:47:59 +0000 (UTC)
Subject: Re: [RFC PATCH v2 24/26] qcow2: Add the 'extended_l2' option and the
 QCOW2_INCOMPAT_EXTL2 bit
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <e8694aa3a45aefa943c9ccbccc8ec5f1460553d0.1572125022.git.berto@igalia.com>
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
Message-ID: <482bff8c-e1fe-6a91-8cd4-a5f571dc4095@redhat.com>
Date: Tue, 5 Nov 2019 13:47:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e8694aa3a45aefa943c9ccbccc8ec5f1460553d0.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Cqmdgr9Ind3Lh1xPxtNuD7SLsaKSFjwB7"
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
--Cqmdgr9Ind3Lh1xPxtNuD7SLsaKSFjwB7
Content-Type: multipart/mixed; boundary="SqwdZZ9R1ON6kH0NUltPROCjO95JuSMFt"

--SqwdZZ9R1ON6kH0NUltPROCjO95JuSMFt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> Now that the implementation of subclusters is complete we can finally
> add the necessary options to create and read images with this feature,
> which we call "extended L2 entries".
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c                    |  46 ++++++++++++++
>  block/qcow2.h                    |   8 ++-
>  include/block/block_int.h        |   1 +
>  qapi/block-core.json             |   6 ++
>  tests/qemu-iotests/031.out       |   8 +--
>  tests/qemu-iotests/036.out       |   4 +-
>  tests/qemu-iotests/049.out       | 102 +++++++++++++++----------------
>  tests/qemu-iotests/060.out       |   1 +
>  tests/qemu-iotests/061.out       |  20 +++---
>  tests/qemu-iotests/065           |  18 ++++--
>  tests/qemu-iotests/082.out       |  48 ++++++++++++---
>  tests/qemu-iotests/085.out       |  38 ++++++------
>  tests/qemu-iotests/144.out       |   4 +-
>  tests/qemu-iotests/182.out       |   2 +-
>  tests/qemu-iotests/185.out       |   8 +--
>  tests/qemu-iotests/198.out       |   2 +
>  tests/qemu-iotests/206.out       |   4 ++
>  tests/qemu-iotests/242.out       |   5 ++
>  tests/qemu-iotests/255.out       |   8 +--
>  tests/qemu-iotests/common.filter |   1 +
>  20 files changed, 224 insertions(+), 110 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 537569ce88..b1fa7ab5da 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1347,6 +1347,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverS=
tate *bs, QDict *options,
>      s->subcluster_size =3D s->cluster_size / s->subclusters_per_cluster;
>      s->subcluster_bits =3D ctz32(s->subcluster_size);
> =20
> +    if (s->subcluster_size < (1 << MIN_CLUSTER_BITS)) {
> +        error_setg(errp, "Unsupported subcluster size: %d", s->subcluste=
r_size);
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> +
>      /* Check support for various header values */
>      if (header.refcount_order > 6) {
>          error_setg(errp, "Reference count entry width too large; may not=
 "

It feels like this hunk should be part of the patch that added the
s->subcluster_size assignment.

> @@ -2806,6 +2812,11 @@ int qcow2_update_header(BlockDriverState *bs)
>                  .bit  =3D QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
>                  .name =3D "lazy refcounts",
>              },
> +            {
> +                .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,
> +                .bit  =3D QCOW2_INCOMPAT_EXTL2_BITNR,
> +                .name =3D "extended L2 entries",
> +            },
>          };
> =20
>          ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
> @@ -3271,6 +3282,27 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>          goto out;
>      }
> =20
> +    if (!qcow2_opts->has_extended_l2) {
> +        qcow2_opts->extended_l2 =3D false;
> +    }
> +    if (qcow2_opts->extended_l2) {
> +        unsigned min_cluster_size =3D
> +            (1 << MIN_CLUSTER_BITS) * QCOW_MAX_SUBCLUSTERS_PER_CLUSTER;
> +        if (version < 3) {
> +            error_setg(errp, "Extended L2 entries are only supported wit=
h "
> +                       "compatibility level 1.1 and above (use version=
=3Dv3 or "

Pre-existing, but old-style creation doesn=E2=80=99t allow version=3Dv3.  I
suppose someone(tm) should fix that...

> +                       "greater)");
> +            ret =3D -EINVAL;
> +            goto out;
> +        }
> +        if (cluster_size < min_cluster_size) {
> +            error_setg(errp, "Extended L2 entries are only supported wit=
h "
> +                       "cluster sizes of at least %u bytes", min_cluster=
_size);
> +            ret =3D -EINVAL;
> +            goto out;
> +        }
> +    }
> +
>      if (!qcow2_opts->has_preallocation) {
>          qcow2_opts->preallocation =3D PREALLOC_MODE_OFF;
>      }

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index aa97ee2641..6e4c81ae1c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -66,6 +66,8 @@
>  #                 standalone (read-only) raw image without looking at qc=
ow2
>  #                 metadata (since: 4.0)
>  #
> +# @extended-l2: true if the image has extended L2 entries (since 4.2)
> +#

I think there should be the same note here as for lazy-refcounts.  So
this field is not present for compat=3D0.10, and present otherwise.
(Without that note, it looks as if this field maybe is only present if
it=E2=80=99s true.)

(Personally, I=E2=80=99d also prefer it to be an =E2=80=9Ciff=E2=80=9D, but=
 who cares.)

>  # @lazy-refcounts: on or off; only valid for compat >=3D 1.1
>  #
>  # @corrupt: true if the image has been marked corrupt; only valid for
> @@ -85,6 +87,7 @@
>        'compat': 'str',
>        '*data-file': 'str',
>        '*data-file-raw': 'bool',
> +      '*extended-l2': 'bool',
>        '*lazy-refcounts': 'bool',
>        '*corrupt': 'bool',
>        'refcount-bits': 'int',
> @@ -4372,6 +4375,8 @@
>  # @data-file-raw    True if the external data file must stay valid as a
>  #                   standalone (read-only) raw image without looking at =
qcow2
>  #                   metadata (default: false; since: 4.0)
> +# @extended-l2      True if the image has extended L2 entries

s/if the image has/to make the image have/ (or something like it)

> +#                   (default: false; since 4.2)
>  # @size             Size of the virtual disk in bytes
>  # @version          Compatibility level (default: v3)
>  # @backing-file     File name of the backing file if a backing file

[...]

> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
> index 9f418b4881..45c0fe746b 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -137,6 +137,7 @@ _filter_img_create()
>          -e "s# adapter_type=3D[^ ]*##g" \
>          -e "s# hwversion=3D[^ ]*##g" \
>          -e "s# lazy_refcounts=3D\\(on\\|off\\)##g" \
> +        -e "s# extended_l2=3D\\(on\\|off\\)##g" \
>          -e "s# block_size=3D[0-9]\\+##g" \
>          -e "s# block_state_zero=3D\\(on\\|off\\)##g" \
>          -e "s# log_size=3D[0-9]\\+##g" \

Filtering it seems like a good idea so one could run the iotests with -o
extended_l2=3Don.  There are still a ton of tests that don=E2=80=99t really=
 seem
filtered, though.  Maybe my =E2=80=9CAllow ./check -o data_file=E2=80=9D se=
ries improves
that? :?

Max


--SqwdZZ9R1ON6kH0NUltPROCjO95JuSMFt--

--Cqmdgr9Ind3Lh1xPxtNuD7SLsaKSFjwB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3Bb34ACgkQ9AfbAGHV
z0ClXAf/UqkWqQPAjr6+h29ZjE9gVH4OD/j2i1igq1EXdEqeHerIng3xprD+UnW1
5UcGjYC9E4+5VUkjD8wdxpRUqH0mI7zzS+G9lOOrzlT3wiJmXLTGaipUBczDvE57
o1/luOxzE7o+OMhML7/6KkuCFXx+L9JlYFeDxEtp0MfhZQhAOnABJHwP3wP4RyKf
Ez5LTreq2h7J2N+UnfIY6/u/xGwg1AlLcycybu4lCWwtIjpES/5AWW4lk3/xHA9n
PlLMa3sOVMcIySg+nhIEZ2b4C471EVxBT2HzMwpyqNQdxpGIDriQ33XPkJc+fTxT
JxuVk00tLCIIDeTAdx7cdq/TeHN61g==
=XhwR
-----END PGP SIGNATURE-----

--Cqmdgr9Ind3Lh1xPxtNuD7SLsaKSFjwB7--


