Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2185BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE0820752
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb6pVC38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE0820752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZPv-0001Pk-12
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVZP1-0000Qd-Do
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:36:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVZOz-000550-2Z
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588592208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kPJ5A4FBQoFCGdz2+T9gyv/c2S1NL38Vsn8fJGylRm8=;
 b=eb6pVC38f4D9Ch1bOLT7LkLp5NF9V2ul90xNm5ZFlaqpUUCQMhnjSemHE0ZxwcCNTjs5Wh
 1TbwnCd4MKLvzf3jA4xww1hb+ZCy9vmy5XWgRVU/VsCqGy77gWOYf2G88T/rkCllmlcgfm
 ZZZz8c2de4JRR4FJXE0iodETf5ImBxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-JUE5zP0OM8G-wgLQ4zUq_g-1; Mon, 04 May 2020 07:36:46 -0400
X-MC-Unique: JUE5zP0OM8G-wgLQ4zUq_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51E24107ACF3;
 Mon,  4 May 2020 11:36:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94F7E10013D9;
 Mon,  4 May 2020 11:36:43 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] qcow2: Expose bitmaps' size during measure
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-5-eblake@redhat.com>
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
Message-ID: <969af6d7-a4e4-b01b-b93b-d0f983782cfc@redhat.com>
Date: Mon, 4 May 2020 13:36:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421212019.170707-5-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fyTqjOKtvqRkM7YfF99os5ju0E01mEOAg"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fyTqjOKtvqRkM7YfF99os5ju0E01mEOAg
Content-Type: multipart/mixed; boundary="KEOfLAB1dVKxXAcjL3KCyRN4GGTro8SWr"

--KEOfLAB1dVKxXAcjL3KCyRN4GGTro8SWr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.04.20 23:20, Eric Blake wrote:
> It's useful to know how much space can be occupied by qcow2 persistent
> bitmaps, even though such metadata is unrelated to the guest-visible
> data.  Report this value as an additional field.  Update iotest 190 to
> cover it and a portion of the just-added qemu-img bitmap command.
>=20
> The addition of a new field demonstrates why we should always
> zero-initialize qapi C structs; while the qcow2 driver still fully
> populates all fields, the raw and crypto drivers had to be tweaked.
>=20
> See also: https://bugzilla.redhat.com/1779904
>=20
> Reported-by: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json       | 15 ++++++++++-----
>  block/crypto.c             |  2 +-
>  block/qcow2.c              | 29 ++++++++++++++++++++++++++++-
>  block/raw-format.c         |  2 +-
>  qemu-img.c                 |  3 +++
>  tests/qemu-iotests/190     | 15 +++++++++++++--
>  tests/qemu-iotests/190.out | 13 ++++++++++++-
>  7 files changed, 68 insertions(+), 11 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 943df1926a91..b47c6d69ba27 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -633,18 +633,23 @@
>  # efficiently so file size may be smaller than virtual disk size.
>  #
>  # The values are upper bounds that are guaranteed to fit the new image f=
ile.
> -# Subsequent modification, such as internal snapshot or bitmap creation,=
 may
> -# require additional space and is not covered here.
> +# Subsequent modification, such as internal snapshot or further bitmap
> +# creation, may require additional space and is not covered here.
>  #
> -# @required: Size required for a new image file, in bytes.
> +# @required: Size required for a new image file, in bytes, when copying =
just
> +#            guest-visible contents.
>  #
>  # @fully-allocated: Image file size, in bytes, once data has been writte=
n
> -#                   to all sectors.
> +#                   to all sectors, when copying just guest-visible cont=
ents.
> +#
> +# @bitmaps: Additional size required for bitmap metadata not directly us=
ed
> +#           for guest contents,

Not sure how I feel about the =E2=80=9Cnot directly used for guest contents=
=E2=80=9D,
because it feels a bit superfluous, and it sounds like there might be
bitmap data that is directly used for guest contents.

>                                  when that metadata can be copied in addi=
tion
> +#           to guest contents. (since 5.1)
>  #
>  # Since: 2.10
>  ##
>  { 'struct': 'BlockMeasureInfo',
> -  'data': {'required': 'int', 'fully-allocated': 'int'} }
> +  'data': {'required': 'int', 'fully-allocated': 'int', '*bitmaps': 'int=
'} }

Why is @bitmaps optional?  I.e., what does absence mean, besides =E2=80=9Cn=
ot
supported yet=E2=80=9D?

Right now, absence means anything in =E2=80=9Cformat doesn=E2=80=99t suppor=
t bitmaps, so
nothing can be copied=E2=80=9D, =E2=80=9Cno input image given, so there=E2=
=80=99s no data on
bitmaps=E2=80=9D, to =E2=80=9C0 bytes to copy=E2=80=9D.

I think in the latter case we should emit it as 0, maybe even in the
former case, because I think the fact that there won=E2=80=99t be any bitma=
p
data to copy might be interesting.  (And it=E2=80=99s also definitely 0, no=
t
just =E2=80=9Cdon=E2=80=99t know=E2=80=9D.)

I suppose absence does make sense in case the user didn=E2=80=99t specify a=
n
input image, because then we just really don=E2=80=99t know.

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index b524b0c53f84..9fd650928016 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -4739,6 +4742,28 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *o=
pts, BlockDriverState *in_bs,
>              goto err;
>          }
>=20
> +        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
> +            if (bdrv_dirty_bitmap_get_persistence(bm)) {
> +                const char *name =3D bdrv_dirty_bitmap_name(bm);
> +                uint32_t granularity =3D bdrv_dirty_bitmap_granularity(b=
m);
> +                uint64_t bmbits =3D DIV_ROUND_UP(bdrv_dirty_bitmap_size(=
bm),
> +                                               granularity);
> +                uint64_t bmclusters =3D DIV_ROUND_UP(DIV_ROUND_UP(bmbits=
,
> +                                                                CHAR_BIT=
),

I suppose if we allowed CHAR_BIT to be anything but 8, it would be wrong
to use it here.  So maybe just a plain 8 would be more correct; although
I suppose CHAR_BIT kind of describes what constant we want here.

> +                                                   cluster_size);
> +
> +                /* Assume the entire bitmap is allocated */
> +                bitmaps_size +=3D bmclusters * cluster_size;
> +                /* Also reserve space for the bitmap table entries */
> +                bitmaps_size +=3D ROUND_UP(bmclusters * sizeof(uint64_t)=
,
> +                                         cluster_size);
> +                /* Guess at contribution to bitmap directory size */
> +                bitmap_overhead +=3D ROUND_UP(strlen(name) + 24,
> +                                            sizeof(uint64_t));

Seems not just a guess to me, but actually correct.  Maybe
bitmap_overhead should be called bitmap_directory_size (or
bitmap_dir_size, or bmap_dir_size, or whatever (but probably not bds!
:)), because that=E2=80=99s what it is.

> +            }
> +        }
> +        bitmaps_size +=3D ROUND_UP(bitmap_overhead, cluster_size);
> +
>          virtual_size =3D ROUND_UP(ssize, cluster_size);
>=20
>          if (has_backing_file) {

[...]

> diff --git a/tests/qemu-iotests/190.out b/tests/qemu-iotests/190.out
> index d001942002db..11962f972429 100644
> --- a/tests/qemu-iotests/190.out
> +++ b/tests/qemu-iotests/190.out
> @@ -1,5 +1,5 @@
>  QA output created by 190
> -=3D=3D Huge file =3D=3D
> +=3D=3D Huge file without bitmaps =3D=3D
>=20
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2199023255552
>  required size: 2199023255552
> @@ -8,4 +8,15 @@ required size: 335806464
>  fully allocated size: 2199359062016
>  required size: 18874368
>  fully allocated size: 2199042129920
> +
> +=3D=3D Huge file with bitmaps =3D=3D
> +
> +required size: 2199023255552
> +fully allocated size: 2199023255552
> +required size: 335806464
> +fully allocated size: 2199359062016
> +bitmaps size: 537198592
> +required size: 18874368
> +fully allocated size: 2199042129920
> +bitmaps size: 545259520

Looks correct.

(It might be nicer to calculate the reference value in the script,
because this way I had to verify it by hand, but, well, now I did verify
it, so...)

Max


--KEOfLAB1dVKxXAcjL3KCyRN4GGTro8SWr--

--fyTqjOKtvqRkM7YfF99os5ju0E01mEOAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6v/kkACgkQ9AfbAGHV
z0BDUAgAkUN0vpj6RsrP+yFavcQI0fw1C4pqx62gD34VG+OEsiR2DpCEGhspKKjz
hG9dMUJkTxUehQWlnwmHeytqoflQsaoDssXwV9+9qEuDzhybGQ0i3PgVnYMThV2x
MLfplR58apJ+ziYFvdOIjlF2G5I8l7D7FXidtrjKnmvmDtx8L76QLivWJ04T01rA
pPhylkqhsGEFokm5WvJTL56veC6rfudsMbVjbeZOKaP8HwUTH5YmyKA1GvAQACDk
EonlqulJBQc2nu1udo2Fzmb8M7Xy9/duQPklTOb6OVdD2gDRaBGqqcnlV6bUlFc0
8nrL7m8/yzGIr5EVMeX1RPxPXjAdgw==
=CmE6
-----END PGP SIGNATURE-----

--fyTqjOKtvqRkM7YfF99os5ju0E01mEOAg--


