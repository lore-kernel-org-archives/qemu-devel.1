Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE269C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7900220838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdfhBkr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7900220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00ZS-0000dG-MN
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j00Yq-0008R1-BN
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j00Ym-0007Vr-5Y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:08:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j00Ym-0007Ss-1F
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581070107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jbQY/iHNJeohI9qe44PRm00voxOky+pm7e6AdALFbHY=;
 b=FdfhBkr9W1tI/zT+ty63Gs1XffXvNFjekMeywl27IiUzc99VZWEQ7xhOAg7s/6QPaVk75u
 MPtVqKIWKk726kJYgC0tmpAEgVR126x5M3JVuTm8UdKeDxdK8JU1EOlkXTl8iSREt9Uavm
 mzMojb89Tn/eLNeu/9RkA2AhG9vMoW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-dVBmkxwiNiONnM4Hs7R8xg-1; Fri, 07 Feb 2020 05:08:19 -0500
X-MC-Unique: dVBmkxwiNiONnM4Hs7R8xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DA95800E21;
 Fri,  7 Feb 2020 10:08:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-88.ams2.redhat.com
 [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0C2B8E611;
 Fri,  7 Feb 2020 10:08:16 +0000 (UTC)
Subject: Re: [PATCH v2] qapi: Allow getting flat output from
 'query-named-block-nodes'
To: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org
References: <4470f8c779abc404dcf65e375db195cd91a80651.1579509782.git.pkrempa@redhat.com>
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
Message-ID: <79ada57a-f73e-fb7f-0c3d-11541fc5d6d5@redhat.com>
Date: Fri, 7 Feb 2020 11:08:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4470f8c779abc404dcf65e375db195cd91a80651.1579509782.git.pkrempa@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eXoJ4XrDyXzcwmclXhzQZZX0Yc1ZbeMTl"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eXoJ4XrDyXzcwmclXhzQZZX0Yc1ZbeMTl
Content-Type: multipart/mixed; boundary="nCE8aaNRomHbFTGb2ZpR265XPSDFyPCWt"

--nCE8aaNRomHbFTGb2ZpR265XPSDFyPCWt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.01.20 09:50, Peter Krempa wrote:
> When a management application manages node names there's no reason to
> recurse into backing images in the output of query-named-block-nodes.
>=20
> Add a parameter to the command which will return just the top level
> structs.
>=20
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>=20
> Diff to v1:
>  - rewrote setting of 'return_flat' in qmp_query_named_block_nodes
>  - tried to clarify the QMP schema docs for the new field
>=20
> This patch does not aim to fix the rather suboptimal original
> documentation of the command as that is going to end up in a bunch of
> bikeshedding.
>=20
> While I know that there are plans for a new command that should fix
> this, the plans were already there for quite some time without much
> happening. This is a quick fix to a real problem, because if you have
> (maybe unpractically) deep backing chains, the returned JSON is getting
> huge. (140 nesting levels exceeds 10MiB of JSON)

The main reason nothing is happening is because nobody is pressing for
it, I think.  We talk about it from time to time but then our result is
=E2=80=9CAs long as nobody seriously complains and tells us what we need, w=
e=E2=80=99re
going to assume what we have is good enough.=E2=80=9D

For example:
https://lists.nongnu.org/archive/html/qemu-block/2020-01/msg00049.html
(Under =E2=80=9CQuery function situation=E2=80=9D)

>  block.c               |  5 +++--
>  block/qapi.c          | 10 ++++++++--
>  blockdev.c            |  8 ++++++--
>  include/block/block.h |  2 +-
>  include/block/qapi.h  |  4 +++-
>  monitor/hmp-cmds.c    |  2 +-
>  qapi/block-core.json  |  7 ++++++-
>  7 files changed, 28 insertions(+), 10 deletions(-)

[...]

> diff --git a/block/qapi.c b/block/qapi.c
> index 9a5d0c9b27..84048e1a57 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -42,7 +42,9 @@
>  #include "qemu/cutils.h"
>=20
>  BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
> -                                        BlockDriverState *bs, Error **er=
rp)
> +                                        BlockDriverState *bs,
> +                                        bool flat,
> +                                        Error **errp)
>  {
>      ImageInfo **p_image_info;
>      BlockDriverState *bs0;
> @@ -156,6 +158,10 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend=
 *blk,
>              return NULL;
>          }
>=20
> +        /* stop gathering data for flat output */
> +        if (flat)
> +            break;

This should be enclosed in curly brackets (qemu coding style).

Shall I fix that up?

Max

> +
>          if (bs0->drv && bs0->backing) {
>              info->backing_file_depth++;
>              bs0 =3D bs0->backing->bs;


--nCE8aaNRomHbFTGb2ZpR265XPSDFyPCWt--

--eXoJ4XrDyXzcwmclXhzQZZX0Yc1ZbeMTl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl49Nw4ACgkQ9AfbAGHV
z0DATQf9GkwVjnoo9hjvJcjlxnbdN6m2DJkiDzj1nKw6BozHlGmwCcxMM9piq/9m
OkCLUGHDWC1QcHsyDM9ixU39nVaW0/kHn57/RUlgoeoBkjIYscQJYYTRQuKtlDA1
n9Qf9qn/2gKz891+OT/MgDdJnILrGmbiabEpcbZShBOJd4ZqWObH0EY1goaUBBcQ
7p30VEKkZXiZzDiBQs3o9bFNerYu3TlGv5+EzoJEVYdOY4YExyEAUvVzCXmlpfMD
bp/M4wyvxIKYPZHrpRIJjVP9/7XUB1XVKOLf9Ch056JQFuKh52wCzu/GLA+XahHe
r2dS7Nuu4Oh6CuGQ70Qm3nN/Y7p/IQ==
=1kvi
-----END PGP SIGNATURE-----

--eXoJ4XrDyXzcwmclXhzQZZX0Yc1ZbeMTl--


