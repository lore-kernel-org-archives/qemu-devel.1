Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADD1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48B72072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tqp3xZ9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48B72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bzx-0001w6-2G
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7bzF-0001S5-Nj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 06:03:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7bzC-0005cV-Ut
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 06:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597658605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O6IM0egQuOTG86+KPpJ9Q8oFuSDg+0JTkUo51RXKdYM=;
 b=Tqp3xZ9YqeN4M1C8OGf9afymkHQOBCaUrXpI8nGBwd3LjF+XhgyeLPMbhg5ljBoZXzAfXQ
 Exr4ccqLm26m7N3f0+Bed2Lv3teEl75oAkh+snVNjqPY1LPURCPfanKYOST1DpQMiJ1XvU
 OVSUf5lkDob9gMsUyslvWDiynH6bxtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-o6I1A2UaNwq5obuCwCvDTw-1; Mon, 17 Aug 2020 06:03:23 -0400
X-MC-Unique: o6I1A2UaNwq5obuCwCvDTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 465151005E65;
 Mon, 17 Aug 2020 10:03:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A3C7D672;
 Mon, 17 Aug 2020 10:03:20 +0000 (UTC)
Subject: Re: [RFC PATCH 04/22] block/export: Add BlockExport infrastructure
 and block-export-add
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-5-kwolf@redhat.com>
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
Message-ID: <7ed669db-7a75-fb25-4ce6-52369ea01b4b@redhat.com>
Date: Mon, 17 Aug 2020 12:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-5-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ix3dnH5mkm3OiKoXsbaBeSwcNSE8rd95j"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ix3dnH5mkm3OiKoXsbaBeSwcNSE8rd95j
Content-Type: multipart/mixed; boundary="Gs8jJ3TxdCh3CIw09NRxXoXto9W9kZLFb"

--Gs8jJ3TxdCh3CIw09NRxXoXto9W9kZLFb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.20 18:29, Kevin Wolf wrote:
> We want to have a common set of commands for all types of block exports.
> Currently, this is only NBD, but we're going to add more types.
>=20
> This patch adds the basic BlockExport and BlockExportDriver structs and
> a QMP command block-export-add that creates a new export based on the
> given BlockExportOptions.
>=20
> qmp_nbd_server_add() becomes a wrapper around qmp_block_export_add().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-export.json     |  9 ++++++
>  include/block/export.h     | 32 +++++++++++++++++++++
>  include/block/nbd.h        |  3 +-
>  block/export/export.c      | 57 ++++++++++++++++++++++++++++++++++++++
>  blockdev-nbd.c             | 19 ++++++++-----
>  nbd/server.c               | 15 +++++++++-
>  Makefile.objs              |  6 ++--
>  block/Makefile.objs        |  2 ++
>  block/export/Makefile.objs |  1 +
>  9 files changed, 132 insertions(+), 12 deletions(-)
>  create mode 100644 include/block/export.h
>  create mode 100644 block/export/export.c
>  create mode 100644 block/export/Makefile.objs

Nothing of too great importance below.  But it=E2=80=99s an RFC, so comment=
s I
will give.

> diff --git a/block/export/export.c b/block/export/export.c
> new file mode 100644
> index 0000000000..3d0dacb3f2
> --- /dev/null
> +++ b/block/export/export.c
> @@ -0,0 +1,57 @@
> +/*
> + * Common block export infrastructure
> + *
> + * Copyright (c) 2012, 2020 Red Hat, Inc.
> + *
> + * Authors:
> + * Paolo Bonzini <pbonzini@redhat.com>
> + * Kevin Wolf <kwolf@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "block/export.h"
> +#include "block/nbd.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-block-export.h"
> +
> +static const BlockExportDriver* blk_exp_drivers[] =3D {
                                 ^^
Sternenplatzierung *hust*

> +    &blk_exp_nbd,
> +};

Not sure whether I like this better than the block driver way of
registering block drivers with a constructor.  It requires writing less
code, at the expense of making the variable global.  So I think there=E2=80=
=99s
no good reason to prefer the block driver approach.

Maybe my hesitance comes from the variable being declared (as extern) in
a header file (block/export.h).  I think I would prefer it if we put
that external reference only here in this file.  Would that work, or do
you have other plans that require blk_exp_nbd to be visible outside of
nbd/server.c and this file here?

> +static const BlockExportDriver *blk_exp_find_driver(BlockExportType type=
)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(blk_exp_drivers); i++) {
> +        if (blk_exp_drivers[i]->type =3D=3D type) {
> +            return blk_exp_drivers[i];
> +        }
> +    }

How bad would it be to define blk_exp_drivers as
blk_exp_drivers[BLOCK_EXPORT_TYPE__MAX] and use the BlockExportType as
the driver index so we don=E2=80=99t have to loop here?

Not that it matters performance-wise.  Just something I wondered.

> +    return NULL;

Why not e.g. g_assert_not_reached()?

(If the BlockExportType were used as the index, I=E2=80=99d assert that
type < ARRAY_SIZE(blk_exp_drivers) && blk_exp_drivers[type] !=3D NULL.  I
don=E2=80=99t think there=E2=80=99s a reason for graceful handling.)

> +}

[...]

> +void qmp_nbd_server_add(BlockExportOptionsNbd *arg, Error **errp)
> +{
> +    BlockExportOptions export =3D {
> +        .type =3D BLOCK_EXPORT_TYPE_NBD,
> +        .u.nbd =3D *arg,
> +    };
> +    qmp_block_export_add(&export, errp);
> +}

Hm.  I think I=E2=80=99d=E2=80=99ve kept this in blockdev-nbd.c, actually, =
but, well.
It=E2=80=99ll stay a one-off.

> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 98ee1b6170..a1dc11bdd7 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c

[...]

> @@ -217,6 +220,8 @@ void qmp_nbd_server_add(BlockExportOptionsNbd *arg, E=
rror **errp)
> =20
>   out:
>      aio_context_release(aio_context);
> +    /* TODO Remove the cast: Move to server.c which can access fields of=
 exp */
> +    return (BlockExport*) exp;

*hust*

(But if it=E2=80=99s moved soon anyway so we can use &exp->common, then wha=
tever.)

Max


--Gs8jJ3TxdCh3CIw09NRxXoXto9W9kZLFb--

--Ix3dnH5mkm3OiKoXsbaBeSwcNSE8rd95j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86VecACgkQ9AfbAGHV
z0BE1wgApycJSZc3Gvh1fKhMfXdszDXdqMAnayluxMgpz8Zv0wjw4FlYQyh9x3yI
FfHC+r3YHck4JFzAQZV/Bxt9OeNMnLsBOGlWrOczf5bTpgBLpEy6Wb67lSt6Qf2G
k0rM7dD6flj41AqoK4Ta1idkI2xVoqrIpPNdHdXStBxe5Ox5Z+P+Gj8UeE/fGIcp
AKJwaw7gCOKPiTgBlDSVSlMgl4hF8QvQcZaljXMf4zCxL0M9jt2p5dnGvsA4bdvl
0TQmn7tO24h22athA9GB2fiKvmIOq6WZoFXcxL4QNSgtqJuCtv9gtY0i2CKLXqbK
sbwbdCefPTAx5x39J6ciZY6TeolIAw==
=E8Ms
-----END PGP SIGNATURE-----

--Ix3dnH5mkm3OiKoXsbaBeSwcNSE8rd95j--


