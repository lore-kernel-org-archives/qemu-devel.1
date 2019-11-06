Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39CCC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8584621848
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVwVsMtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8584621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKoA-0005z9-QL
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSKmv-0005HL-3l
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSKmt-00011l-KH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:51:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46542
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSKmt-00011V-GF
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573044711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MRI+I9HfSaYo2vMfd7wmaum7YSEpQj/13yFn8SnTamk=;
 b=LVwVsMtn4h9nRPPGbMPqSUofKb/Jp+LFuySpSyZe2Y+PnEuQplCX0xPJPaIhLN9o0Davyx
 v1ggmtbPLwGjkicfFsBgv32XiLtoxajvdc3qiNo+mU7PjuUZiKQLg4wUKPSlhLQ8R4A5Xo
 CbYtcX0mE/HNOuhspalLa6iUxMFeHPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-DPUt8Ui3MEa1sZodqCN_bg-1; Wed, 06 Nov 2019 07:51:47 -0500
X-MC-Unique: DPUt8Ui3MEa1sZodqCN_bg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8549A477;
 Wed,  6 Nov 2019 12:51:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 168C55D70D;
 Wed,  6 Nov 2019 12:51:44 +0000 (UTC)
Subject: Re: [RFC PATCH 06/18] qemu-storage-daemon: Add --nbd-server option
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-7-kwolf@redhat.com>
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
Message-ID: <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com>
Date: Wed, 6 Nov 2019 13:51:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017130204.16131-7-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fFYNK7YgPWSe9vLWtljVde4ZUQJkVQnBW"
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fFYNK7YgPWSe9vLWtljVde4ZUQJkVQnBW
Content-Type: multipart/mixed; boundary="z8xM9wQOt4ykEDjRPUouIuusw4ZXRucQN"

--z8xM9wQOt4ykEDjRPUouIuusw4ZXRucQN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.10.19 15:01, Kevin Wolf wrote:
> Add a --nbd-server option to qemu-storage-daemon to start the built-in
> NBD server right away. It maps the arguments for nbd-server-start to the
> command line.

Well, it doesn=E2=80=99t quite, because nbd-server-start takes a
SocketAddressLegacy, and this takes a SocketAddress.

On one hand I can understand why you would do it differently (especially
for command-line options), but on the other I find it a bit problematic
to have --nbd-server be slightly different from nbd-server-start when
both are intended to be the same.

My biggest problem though lies in the duplication in the QAPI schema.
If NbdServerOptions.addr were a SocketAddressLegacy, we could let
nbd-server-start=E2=80=99s options just be of type NbdServerOptions and thu=
s get
rid of the duplication.

I suspect in practice it=E2=80=99s all not that big of a problem.  I can=E2=
=80=99t call
it bad if --nbd-server is just nicer to use.  And the biggest problem
with duplication in the QAPI schema is that nbd-server-start and
--nbd-server might get out of sync.  But realistically, I don=E2=80=99t see=
 that
happen, because if nbd-server-start changes, nbd_server_start() will
change, too, so we=E2=80=99ll get compile errors in nbd_server_start_option=
s().

*shrug*

But I do think the commit message should explain why we can=E2=80=99t just =
use
NbdServerOptions for nbd-server-start.

Max

> Example (only with required options):
>=20
>     --nbd-server addr.type=3Dinet,addr.host=3Dlocalhost,addr.port=3D10809
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block.json       | 18 ++++++++++++++++++
>  include/block/nbd.h   |  1 +
>  blockdev-nbd.c        |  5 +++++
>  qemu-storage-daemon.c | 26 +++++++++++++++++++++++++-
>  Makefile.objs         |  2 +-
>  5 files changed, 50 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/block.json b/qapi/block.json
> index 145c268bb6..7fe0cf6538 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -215,6 +215,24 @@
>              '*id': 'str',
>              '*force': 'bool' } }
> =20
> +##
> +# @NbdServerOptions:
> +#
> +# @addr: Address on which to listen.
> +# @tls-creds: ID of the TLS credentials object (since 2.6).
> +# @tls-authz: ID of the QAuthZ authorization object used to validate
> +#             the client's x509 distinguished name. This object is
> +#             is only resolved at time of use, so can be deleted and
> +#             recreated on the fly while the NBD server is active.
> +#             If missing, it will default to denying access (since 4.0).
> +#
> +# Since: 4.2
> +##
> +{ 'struct': 'NbdServerOptions',
> +  'data': { 'addr': 'SocketAddress',
> +            '*tls-creds': 'str',
> +            '*tls-authz': 'str'} }
> +
>  ##
>  # @nbd-server-start:
>  #
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 316fd705a9..2a7441491a 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -353,6 +353,7 @@ void nbd_client_put(NBDClient *client);
> =20
>  void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>                        const char *tls_authz, Error **errp);
> +void nbd_server_start_options(NbdServerOptions *arg, Error **errp);
> =20
>  /* nbd_read
>   * Reads @size bytes from @ioc. Returns 0 on success.
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 6a8b206e1d..d4c1fd4166 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -132,6 +132,11 @@ void nbd_server_start(SocketAddress *addr, const cha=
r *tls_creds,
>      nbd_server =3D NULL;
>  }
> =20
> +void nbd_server_start_options(NbdServerOptions *arg, Error **errp)
> +{
> +    nbd_server_start(arg->addr, arg->tls_creds, arg->tls_authz, errp);
> +}
> +
>  void qmp_nbd_server_start(SocketAddressLegacy *addr,
>                            bool has_tls_creds, const char *tls_creds,
>                            bool has_tls_authz, const char *tls_authz,
> diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> index 904e3c3a46..51882452f3 100644
> --- a/qemu-storage-daemon.c
> +++ b/qemu-storage-daemon.c
> @@ -25,11 +25,14 @@
>  #include "qemu/osdep.h"
> =20
>  #include "block/block.h"
> +#include "block/nbd.h"
>  #include "crypto/init.h"
> =20
>  #include "qapi/error.h"
> -#include "qapi/qapi-visit-block-core.h"
> +#include "qapi/qapi-commands-block.h"
>  #include "qapi/qapi-commands-block-core.h"
> +#include "qapi/qapi-visit-block.h"
> +#include "qapi/qapi-visit-block-core.h"
>  #include "qapi/qobject-input-visitor.h"
> =20
>  #include "qemu-common.h"
> @@ -64,6 +67,12 @@ static void help(void)
>  "             [,driver specific parameters...]\n"
>  "                         configure a block backend\n"
>  "\n"
> +"  --nbd-server addr.type=3Dinet,addr.host=3D<host>,addr.port=3D<port>\n=
"
> +"               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
> +"  --nbd-server addr.type=3Dunix,addr.path=3D<path>\n"
> +"               [,tls-creds=3D<id>][,tls-authz=3D<id>]\n"
> +"                         start an NBD server for exporting block nodes\=
n"
> +"\n"
>  "  --object <properties>  define a QOM object such as 'secret' for\n"
>  "                         passwords and/or encryption keys\n"
>  "\n"
> @@ -74,6 +83,7 @@ QEMU_HELP_BOTTOM "\n",
>  enum {
>      OPTION_OBJECT =3D 256,
>      OPTION_BLOCKDEV,
> +    OPTION_NBD_SERVER,
>  };
> =20
>  static QemuOptsList qemu_object_opts =3D {
> @@ -95,6 +105,7 @@ static int process_options(int argc, char *argv[], Err=
or **errp)
>          {"help", no_argument, 0, 'h'},
>          {"object", required_argument, 0, OPTION_OBJECT},
>          {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
> +        {"nbd-server", required_argument, 0, OPTION_NBD_SERVER},
>          {"version", no_argument, 0, 'V'},
>          {"trace", required_argument, NULL, 'T'},
>          {0, 0, 0, 0}
> @@ -152,6 +163,19 @@ static int process_options(int argc, char *argv[], E=
rror **errp)
>                  qapi_free_BlockdevOptions(options);
>                  break;
>              }
> +        case OPTION_NBD_SERVER:
> +            {
> +                Visitor *v;
> +                NbdServerOptions *options;
> +
> +                v =3D qobject_input_visitor_new_str(optarg, NULL, &error=
_fatal);
> +                visit_type_NbdServerOptions(v, NULL, &options, &error_fa=
tal);
> +                visit_free(v);
> +
> +                nbd_server_start_options(options, &error_fatal);
> +                qapi_free_NbdServerOptions(options);
> +                break;
> +            }
>          }
>      }
>      if (optind !=3D argc) {
> diff --git a/Makefile.objs b/Makefile.objs
> index 00fdf54500..cc262e445f 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -42,7 +42,7 @@ io-obj-y =3D io/
>  # used for system emulation, too, but specified separately there)
> =20
>  storage-daemon-obj-y =3D block/
> -storage-daemon-obj-y +=3D blockdev.o iothread.o
> +storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
> =20
>  ######################################################################
>  # Target independent part of system emulation. The long term path is to
>=20



--z8xM9wQOt4ykEDjRPUouIuusw4ZXRucQN--

--fFYNK7YgPWSe9vLWtljVde4ZUQJkVQnBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3Cwd4ACgkQ9AfbAGHV
z0CCbwf/dqzXorPuz6xmuShw82kJwYqHNxrZtGE/fRWHBM76hHWoOhpTdjQ6kbzu
w1Ql+IESloL2yVg+Bypvc3syv/42ixcg3BKMvvjYJRAwsJUU7DvQtbT9JaUDewIK
uwJsVbt+si/1a/74LoaTKIPhyV2MbTM4GVY1aqPjtLT0c9mmK22/3otm3rHmS95D
3dI9SMKRgDoy9AuWDLFQkBL00dw8wrIjQ+TqTWR1ny1GkzHkjIVFxIFwjczPpD7H
oUA4XdeYRMyw2n0eIWj1A37rggeXMSoUvhN1cnrpt7Zk87NRPkkI/524KwPhXIh6
eeyWr5dpbUjQcYFc2t49jFAKxm+Sxg==
=czPm
-----END PGP SIGNATURE-----

--fFYNK7YgPWSe9vLWtljVde4ZUQJkVQnBW--


