Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8703C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9F020714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JI3cPewE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9F020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQaG-0001KQ-PI
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHQZQ-0000uG-AS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHQZO-0000kv-6o
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:21:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHQZN-0000kK-Su
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585221665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/0xwYSvws7tBcbiPzj89LCU44fF9iWYFPb6Q1zBuQzA=;
 b=JI3cPewEZ4H9TM3bQlbwy2csXiSDPIcj8ndfSEvkzEpZVX7Rcp4+aAl9lbsNjQCeI/Z9M4
 duYTfnFI2/vXz2l2G8qmcX32fANuH8jF+Yevm4VBOwGIjTbLwve+LcDrP4AQ+NhJWTyGDN
 wn4acssl2Q4NJZmqCCSjTgeoH+2lubY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-0lAlcZksNfyamSkbqAAWlA-1; Thu, 26 Mar 2020 07:21:01 -0400
X-MC-Unique: 0lAlcZksNfyamSkbqAAWlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DCDE10CE789;
 Thu, 26 Mar 2020 11:20:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-132.ams2.redhat.com
 [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BAD110027AA;
 Thu, 26 Mar 2020 11:20:47 +0000 (UTC)
Subject: Re: [PATCH 2/2] block: trickle down the fallback image creation
 function use to the block drivers
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200326011218.29230-1-mlevitsk@redhat.com>
 <20200326011218.29230-3-mlevitsk@redhat.com>
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
Message-ID: <237a76c0-f447-6ba5-267d-b51da3ea2dd4@redhat.com>
Date: Thu, 26 Mar 2020 12:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326011218.29230-3-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LeBRtufMVTDS7GUqSt0ABXwlpWTBusPX7"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jason Dillaman <dillaman@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LeBRtufMVTDS7GUqSt0ABXwlpWTBusPX7
Content-Type: multipart/mixed; boundary="BJc5MMvyA8MrtYx60Rt8zByQFyoLMPOBL"

--BJc5MMvyA8MrtYx60Rt8zByQFyoLMPOBL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.03.20 02:12, Maxim Levitsky wrote:
> Instead of checking the .bdrv_co_create_opts to see if we need the failba=
ck,
> just implement the .bdrv_co_create_opts in the drivers that need it.
>=20
> This way we don't break various places that need to know if the underlyin=
g
> protocol/format really supports image creation, and this way we still
> allow some drivers to not support image creation.
>=20
> Fixes: fd17146cd93d1704cd96d7c2757b325fc7aac6fd
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1816007

Thanks, the series looks good to me, just some thoughts below.

> Note that technically this driver reverts the image creation failback
> for the vxhs driver since I don't have a means to test it,
> and IMHO it is better to leave it not supported as it was prior to
> generic image creation patches.

There=E2=80=99s also file-win32.  I don=E2=80=99t really have the means to =
test that
either, though, so I suppose it=E2=80=99s reasonable to wait until someone
requests it.  OTOH, it shouldn=E2=80=99t be different from file-posix, so m=
aybe
it wouldn=E2=80=99t hurt to support it, too.

We could also take this series for 5.0 as-is, and queue a file-win32
patch for 5.1.

What do you think?

> Also drop iscsi_create_opts which was left accidently
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block.c               | 35 ++++++++++++++++++++---------------
>  block/file-posix.c    |  7 ++++++-
>  block/iscsi.c         | 16 ++++------------
>  block/nbd.c           |  6 ++++++
>  block/nvme.c          |  3 +++
>  include/block/block.h |  7 +++++++
>  6 files changed, 46 insertions(+), 28 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index ff23e20443..72fdf56af7 100644
> --- a/block.c
> +++ b/block.c
> @@ -598,8 +598,15 @@ static int create_file_fallback_zero_first_sector(Bl=
ockBackend *blk,
>      return 0;
>  }
> =20
> -static int bdrv_create_file_fallback(const char *filename, BlockDriver *=
drv,
> -                                     QemuOpts *opts, Error **errp)
> +/**
> + * Simple implementation of bdrv_co_create_opts for protocol drivers
> + * which only support creation via opening a file
> + * (usually existing raw storage device)
> + */
> +int coroutine_fn bdrv_co_create_opts_simple(BlockDriver *drv,
> +                                           const char *filename,
> +                                           QemuOpts *opts,
> +                                           Error **errp)

The alignment=E2=80=99s off (in the header, too), but that can be fixed whe=
n
this series is applied.

>  {
>      BlockBackend *blk;
>      QDict *options;
> @@ -663,11 +670,7 @@ int bdrv_create_file(const char *filename, QemuOpts =
*opts, Error **errp)
>          return -ENOENT;
>      }
> =20
> -    if (drv->bdrv_co_create_opts) {
> -        return bdrv_create(drv, filename, opts, errp);
> -    } else {
> -        return bdrv_create_file_fallback(filename, drv, opts, errp);
> -    }
> +    return bdrv_create(drv, filename, opts, errp);

I thought we=E2=80=99d just let the drivers set BlockDriver.create_opts to
&bdrv_create_opts_simple and keep this bit of code (maybe with an
=E2=80=9Celse if (drv->create_opts !=3D NULL)=E2=80=9D and an
=E2=80=9Cassert(drv->create_opts =3D=3D &bdrv_create_opts_simple)=E2=80=9D)=
.  That would
make the first patch unnecessary.

OTOH, it=E2=80=99s completely reasonable to pass the object as the first
argument to a class method, so why not.  (Well, technically the
BlockDriver kind of is the class, and the BDS is the object, it=E2=80=99s
weird.)  And it definitely follows what we do elsewhere (to provide
default implementations for block drivers to use).

>  }
> =20
>  int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp)

[...]

> diff --git a/block/file-posix.c b/block/file-posix.c
> index 65bc980bc4..7e19bbff5f 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c

[...]

> @@ -3639,10 +3641,11 @@ static BlockDriver bdrv_host_cdrom =3D {
>      .bdrv_reopen_prepare =3D raw_reopen_prepare,
>      .bdrv_reopen_commit  =3D raw_reopen_commit,
>      .bdrv_reopen_abort   =3D raw_reopen_abort,
> +    .bdrv_co_create_opts =3D bdrv_co_create_opts_simple,
> +    .create_opts         =3D &bdrv_create_opts_simple,
>      .mutable_opts        =3D mutable_opts,
>      .bdrv_co_invalidate_cache =3D raw_co_invalidate_cache,
> =20
> -

This line removal seems unrelated, but why not.

Max

>      .bdrv_co_preadv         =3D raw_co_preadv,
>      .bdrv_co_pwritev        =3D raw_co_pwritev,
>      .bdrv_co_flush_to_disk  =3D raw_co_flush_to_disk,


--BJc5MMvyA8MrtYx60Rt8zByQFyoLMPOBL--

--LeBRtufMVTDS7GUqSt0ABXwlpWTBusPX7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl58kA0ACgkQ9AfbAGHV
z0AbgAf+J4xn9DDXLm9WYbpjIb5pen6bc4hHcAAn1mRh1EkzV1OoTKRcN045c0xS
s5VCHggFEffyr8QabHbECXCBGdV6xxbAUt4eaLoN8rA+53wjiJbq5sr7QFslFFgw
rIqjmpb7xw95ui3SqYaP0liHVP9fdua5l9OJE17JD+ewN6s6o4YzjybZzqaAc7rx
fe7s4ZP8yg2WI45n0eZf6AeJbbVEU+72pN+L/d4VkmUA3a1rO6wHv+jNLSqZRdPw
mLba/Dlx5Oclfs/58X4RPVKDgWo9c8r36eKopjYZ4ZBCyB/X9fqg/riakZ/+uvuZ
51Ioc2aOXFiZzFUEx33q2Zeer3y+iA==
=mG7O
-----END PGP SIGNATURE-----

--LeBRtufMVTDS7GUqSt0ABXwlpWTBusPX7--


