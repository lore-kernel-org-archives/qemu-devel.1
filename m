Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8002C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C5A24680
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFP9ffq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C5A24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irN0N-0004wf-Ml
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1irMz9-0003z9-OD
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1irMz8-0002Rw-Ag
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:15:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1irMz8-0002Rq-6z
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579011357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=so5pJ06L3sFXGKVeTXzA74uFyU4PP8yOa6bkF+hV07g=;
 b=NFP9ffq865x1a1cNpA/+9UwJrCo2Bedaz2ZF8dsVBCwI7VMhoF4+jhlB6mny7GdP98KybZ
 BlVcY+qrd1hqjOGfdZne0tz1+lh7rUZFjkJ2xXgWNLFESc6vX2qhzoBgp5xDgjGzKCkWNr
 a4Op0smWaWCFHM2GVeagHUuc0+Ek+c8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-ECV4KQ3iOy-41wF1CWq1bA-1; Tue, 14 Jan 2020 09:15:54 -0500
X-MC-Unique: ECV4KQ3iOy-41wF1CWq1bA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943BF10120D3;
 Tue, 14 Jan 2020 14:15:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC85860C63;
 Tue, 14 Jan 2020 14:15:49 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] qcow2: Use BDRV_SECTOR_SIZE instead of the
 hardcoded value
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1578596897.git.berto@igalia.com>
 <e3982d5118a90db2442c6ac18f339ec8ba006df2.1578596897.git.berto@igalia.com>
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
Message-ID: <02552511-6fcf-d678-362c-707ce6d73659@redhat.com>
Date: Tue, 14 Jan 2020 15:15:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <e3982d5118a90db2442c6ac18f339ec8ba006df2.1578596897.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qpmaCYSTisVJjCQFddGt5v8D2xXZDbLbU"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qpmaCYSTisVJjCQFddGt5v8D2xXZDbLbU
Content-Type: multipart/mixed; boundary="RqePQtdnAdbP7JrZSvFkGqGrJGpnC64UA"

--RqePQtdnAdbP7JrZSvFkGqGrJGpnC64UA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.01.20 20:13, Alberto Garcia wrote:
> This replaces all remaining instances in the qcow2 code.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c |  2 +-
>  block/qcow2.c         | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)

The question of course is why we would even have such instances still.

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 932fc48919..777ca2d409 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -219,7 +219,7 @@ static int l2_load(BlockDriverState *bs, uint64_t off=
set,
>   * Writes one sector of the L1 table to the disk (can't update single en=
tries
>   * and we really don't want bdrv_pread to perform a read-modify-write)
>   */
> -#define L1_ENTRIES_PER_SECTOR (512 / 8)
> +#define L1_ENTRIES_PER_SECTOR (BDRV_SECTOR_SIZE / 8)
>  int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)

Here it=E2=80=99s because the comment is wrong: =E2=80=9CCan=E2=80=99t upda=
te single entries=E2=80=9D =E2=80=93
yes, we can.  We=E2=80=99d just have to do a bdrv_pwrite() to a single entr=
y.

>  {
>      BDRVQcow2State *s =3D bs->opaque;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 783d2b9578..c0f3e715ef 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3280,7 +3280,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
> =20
>      /* Validate options and set default values */
>      if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
> -        error_setg(errp, "Image size must be a multiple of 512 bytes");
> +        error_setg(errp, "Image size must be a multiple of %u bytes",
> +                   (unsigned) BDRV_SECTOR_SIZE);

Either way how patch 1 goes, this is due to a limitation in qemu.

>          ret =3D -EINVAL;
>          goto out;
>      }
> @@ -3836,7 +3837,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
>          case QCOW2_CLUSTER_NORMAL:
>              child =3D s->data_file;
>              copy_offset +=3D offset_into_cluster(s, src_offset);
> -            if ((copy_offset & 511) !=3D 0) {
> +            if (!QEMU_IS_ALIGNED(copy_offset, BDRV_SECTOR_SIZE)) {

Hm.  I don=E2=80=99t get this one.

>                  ret =3D -EIO;
>                  goto out;
>              }
> @@ -3958,8 +3959,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriv=
erState *bs, int64_t offset,
>          return -ENOTSUP;
>      }
> =20
> -    if (offset & 511) {
> -        error_setg(errp, "The new size must be a multiple of 512");
> +    if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
> +        error_setg(errp, "The new size must be a multiple of %u",
> +                   (unsigned) BDRV_SECTOR_SIZE);

This too is due to the limitation in qemu that BDS lengths are only
stored in multiples of BDRV_SECTOR_SIZE, so we disallow any other image
sizes.

>          return -EINVAL;
>      }
So in 3/4 instances this patch looks good to me (it=E2=80=99s really about =
the
block layers concept of a =E2=80=9Csector=E2=80=9D, even though that notion=
 is outdated
in the first hunk), but I don=E2=80=99t quite get the third hunk.  (I=E2=80=
=99m sure it
has to do something with the block layer, so it=E2=80=99s OK to change in t=
his
patch, but I=E2=80=99m still interested in why we have that limitation ther=
e.)

Max


--RqePQtdnAdbP7JrZSvFkGqGrJGpnC64UA--

--qpmaCYSTisVJjCQFddGt5v8D2xXZDbLbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4dzRQACgkQ9AfbAGHV
z0DvJggApu9JXbzhSFmLRauncclxeQEenvTcCdIYYJPpRVXC1dSrSqCnw3lO2Ngr
H61pRo6H7mPIWPVva8eHdb5mbbcrLx+o+L+Y3FZn6kgpoyhNCTp28MqE/tVwE8mY
vEPT71/8yxZyBEiAPaR8JNaC1x5iPck95gFZ7/SEmStwicc1rv0V9MlAUfVZd7vi
s+rkEtZMoa4p2laa7Hg7Q7QUK6X3f/rey3fwqVCI/z9NXxFzTDj1swlo3tPU2Jsa
ugFYIxAZ8nx3MFX+R7vob7ri/kEizk6lPjatLNQ3hKAJm/vS0z0JAN+q4EzbgQa8
8gT8uifaqcQ4UgytrF5qE4V+0j2m/w==
=js5H
-----END PGP SIGNATURE-----

--qpmaCYSTisVJjCQFddGt5v8D2xXZDbLbU--


