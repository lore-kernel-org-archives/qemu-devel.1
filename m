Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455BC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670E920674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/6z/Q1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670E920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz28Z-00042T-Lb
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz25s-0001Jt-Pn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz25r-0003Fi-IC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:34:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz25r-0003DW-E3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580837674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3GvwBz0QwSigpzVWbwmZxX1l5FnWzqrRV20DZP08UQU=;
 b=C/6z/Q1/eToqut0/GV30uc6xHqWceFgjZjkkBNgsDHcjJWbE+qXB/2KhfbN7vpJb6JTwkM
 6+/lu0IFj7FSjgDmhviUNaS+9BBbn9EZLp+nSKUQ1s5jn72kyZUJ7nAr4a52EkcrXsMIRu
 WnOAdnLXQg1OOsns79mvshHFmkt5elQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-7cePBl11OUiejmkB-vl9lA-1; Tue, 04 Feb 2020 12:34:27 -0500
X-MC-Unique: 7cePBl11OUiejmkB-vl9lA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FD788005A0;
 Tue,  4 Feb 2020 17:34:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-98.ams2.redhat.com
 [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97DAA5D9C5;
 Tue,  4 Feb 2020 17:34:24 +0000 (UTC)
Subject: Re: [PATCH 10/17] block: Add new BDRV_ZERO_OPEN flag
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-11-eblake@redhat.com>
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
Message-ID: <d4df9a48-6fb6-3432-3189-54bb7c7bb20c@redhat.com>
Date: Tue, 4 Feb 2020 18:34:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131174436.2961874-11-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P4UAsnJsbCqHIOI5TNjsUpbTu4hA0bf5M"
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P4UAsnJsbCqHIOI5TNjsUpbTu4hA0bf5M
Content-Type: multipart/mixed; boundary="E0vjnAosJ0SHHyztwbRmjvTS315xJ26FI"

--E0vjnAosJ0SHHyztwbRmjvTS315xJ26FI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.01.20 18:44, Eric Blake wrote:
> Knowing that a file reads as all zeroes when created is useful, but
> limited in scope to drivers that can create images.  However, there
> are also situations where pre-existing images can quickly be
> determined to read as all zeroes, even when the image was not just
> created by the same process.  The optimization used in qemu-img
> convert to avoid a pre-zeroing pass on the destination is just as
> useful in such a scenario.  As such, it is worth the block layer
> adding another bit to bdrv_known_zeroes().
>=20
> Note that while BDRV_ZERO_CREATE cannot chase through backing layers
> (because it only applies at creation time, but the backing layer was
> not created at the same time as the active layer being created), it IS
> okay for BDRV_ZERO_OPEN to chase through layers (as long as all layers
> currently read as zero, the image reads as zero).
>=20
> Upcoming patches will update the qcow2, file-posix, and nbd drivers to
> advertise the new bit when appropriate.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c               | 12 ++++++------
>  include/block/block.h | 10 ++++++++++
>  qemu-img.c            | 10 ++++++----
>  3 files changed, 22 insertions(+), 10 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index fac0813140aa..d68f527dc41f 100644
> --- a/block.c
> +++ b/block.c
> @@ -5078,7 +5078,7 @@ int bdrv_known_zeroes_truncate(BlockDriverState *bs=
)
>=20
>  int bdrv_known_zeroes(BlockDriverState *bs)
>  {
> -    int mask =3D BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE;
> +    int mask =3D BDRV_ZERO_CREATE | BDRV_ZERO_TRUNCATE | BDRV_ZERO_OPEN;
>=20
>      if (!bs->drv) {
>          return 0;
> @@ -5100,17 +5100,17 @@ int bdrv_known_zeroes(BlockDriverState *bs)
>       * ZERO_CREATE is not viable.  If the current layer is smaller
>       * than the backing layer, truncation may expose backing data,
>       * restricting ZERO_TRUNCATE; treat failure to query size in the
> -     * same manner.  Otherwise, we can trust the driver.
> +     * same manner.  For ZERO_OPEN, we insist that both backing and
> +     * current layer report the bit.
>       */
> -
>      if (bs->backing) {
>          int64_t back =3D bdrv_getlength(bs->backing->bs);
>          int64_t curr =3D bdrv_getlength(bs);
>=20
> -        if (back < 0 || curr < back) {
> -            return 0;
> +        mask =3D bdrv_known_zeroes(bs->backing->bs) & BDRV_ZERO_OPEN;
> +        if (back >=3D 0 && curr >=3D back) {
> +            mask |=3D BDRV_ZERO_TRUNCATE;
>          }
> -        mask =3D BDRV_ZERO_TRUNCATE;
>      }
>=20
>      if (bs->drv->bdrv_known_zeroes) {
> diff --git a/include/block/block.h b/include/block/block.h
> index a6a227f50678..dafb8cc2bd80 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -105,6 +105,16 @@ typedef enum {
>       * for drivers that set .bdrv_co_truncate.
>       */
>      BDRV_ZERO_TRUNCATE      =3D 0x2,
> +
> +    /*
> +     * bdrv_known_zeroes() should include this bit if an image is
> +     * known to read as all zeroes when first opened; this bit should
> +     * not be relied on after any writes to the image.

Is there a good reason for this?  Because to me this screams like we are
going to check this flag without ensuring that the image has actually
not been written to yet.  So if it=E2=80=99s generally easy for drivers to =
stop
reporting this flag after a write, then maybe we should do so.

Max

>                                                          This can be
> +     * set even if BDRV_ZERO_INIT is clear, but should only be set if
> +     * making the determination is more efficient than looping over
> +     * block status for the image.
> +     */
> +    BDRV_ZERO_OPEN          =3D 0x4,
>  } BdrvZeroFlags;
>=20
>  typedef struct BlockSizes {
> diff --git a/qemu-img.c b/qemu-img.c
> index e60217e6c382..c8519a74f738 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1985,10 +1985,12 @@ static int convert_do_copy(ImgConvertState *s)
>      int64_t sector_num =3D 0;
>=20
>      /* Check whether we have zero initialisation or can get it efficient=
ly */
> -    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
> -        !s->target_has_backing) {
> -        s->has_zero_init =3D !!(bdrv_known_zeroes(blk_bs(s->target)) &
> -                              BDRV_ZERO_CREATE);
> +    if (!s->has_zero_init && s->min_sparse && !s->target_has_backing) {
> +        ret =3D bdrv_known_zeroes(blk_bs(s->target));
> +        if (ret & BDRV_ZERO_OPEN ||
> +            (s->target_is_new && ret & BDRV_ZERO_CREATE)) {
> +            s->has_zero_init =3D true;
> +        }
>      }
>=20
>      if (!s->has_zero_init && !s->target_has_backing &&
>=20



--E0vjnAosJ0SHHyztwbRmjvTS315xJ26FI--

--P4UAsnJsbCqHIOI5TNjsUpbTu4hA0bf5M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl45qx4ACgkQ9AfbAGHV
z0Cbvgf/d49X2l84KtV98fKr0Ls4zfkYvwwL8J/XfsEPV9eGv3HCRVYyb5huKNZj
uI6oTN+OsEypN/rAWh/95pNuSSo/l3h+Rwj1WhEWYIwPZn/+mD77ZxMN7zXUIuAT
u86aRYn9o47vv2IgOzg9GkMFYBLfWVEvThdUmkxvXSenq2VlwnEQhm8dcXXNeomn
mUCzNJWUlZk1EgknArcxNNuZPYCAYZ0pqo0vs8QUCrzzsTwu8jld7EFIbnKScEyJ
K0dEiGDBk7t29nXafEj3Idm8NMcO0rpxdKGjUsVnRuQ3F/r5urXw409P4MXh/MP7
QgAfdWzayrhzfSO0tF2rNgwyJGNvaA==
=nIjs
-----END PGP SIGNATURE-----

--P4UAsnJsbCqHIOI5TNjsUpbTu4hA0bf5M--


