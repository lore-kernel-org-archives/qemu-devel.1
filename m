Received: from eggs.gnu.org ([2001:4830:134:3::10]:39448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXjQ-0004gO-QI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXjN-0003xo-LJ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:43:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csXjN-0003wn-CK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 684E36AADE
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:42:56 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-8-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c0b92f66-8e3b-e419-359b-a6b0f986a03d@redhat.com>
Date: Mon, 27 Mar 2017 18:42:53 +0200
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lbtqg0T9ststaLXSpCM7R3t9t9hOiUg9h"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 07/11] rbd: Clean up
 qemu_rbd_create()'s detour through QemuOpts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lbtqg0T9ststaLXSpCM7R3t9t9hOiUg9h
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <c0b92f66-8e3b-e419-359b-a6b0f986a03d@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 07/11] rbd: Clean up qemu_rbd_create()'s
 detour through QemuOpts
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 15:26, Markus Armbruster wrote:
> The conversion from QDict to QemuOpts is pointless.  Simply get the
> stuff straight from the QDict.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/rbd.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index b2afe07..cf0bab0 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -376,7 +376,6 @@ static int qemu_rbd_create(const char *filename, Qe=
muOpts *opts, Error **errp)
>      rados_t cluster;
>      rados_ioctx_t io_ctx;
>      QDict *options =3D NULL;
> -    QemuOpts *rbd_opts =3D NULL;
>      int ret =3D 0;
> =20
>      secretid =3D qemu_opt_get(opts, "password-secret");
> @@ -407,19 +406,11 @@ static int qemu_rbd_create(const char *filename, =
QemuOpts *opts, Error **errp)
>          goto exit;
>      }
> =20
> -    rbd_opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort=
);
> -    qemu_opts_absorb_qdict(rbd_opts, options, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        ret =3D -EINVAL;
> -        goto exit;
> -    }
> -
> -    pool       =3D qemu_opt_get(rbd_opts, "pool");
> -    conf       =3D qemu_opt_get(rbd_opts, "conf");
> -    clientname =3D qemu_opt_get(rbd_opts, "user");
> -    name       =3D qemu_opt_get(rbd_opts, "image");
> -    keypairs   =3D qemu_opt_get(rbd_opts, "=3Dkeyvalue-pairs");
> +    pool       =3D qdict_get_str(options, "pool");
> +    conf       =3D qdict_get_str(options, "conf");
> +    clientname =3D qdict_get_str(options, "user");
> +    name       =3D qdict_get_str(options, "image");
> +    keypairs   =3D qdict_get_str(options, "=3Dkeyvalue-pairs");

This assumes that all of these options are given which they are not
necessarily:

$ ./qemu-img create -f rbd rbd:blub/ 1M
Formatting 'rbd:blub/', fmt=3Drbd size=3D1048576
[1]    27387 segmentation fault (core dumped)  ./qemu-img create -f rbd
rbd:blub/ 1M

qdict_get_try_str() would probably be better.

Max

> =20
>      ret =3D rados_create(&cluster, clientname);
>      if (ret < 0) {
> @@ -470,7 +461,6 @@ shutdown:
> =20
>  exit:
>      QDECREF(options);
> -    qemu_opts_del(rbd_opts);
>      return ret;
>  }
> =20
>=20



--lbtqg0T9ststaLXSpCM7R3t9t9hOiUg9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZQQ0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvIUH/3ace/+s7ULwovX55P9P6j6rnt+Ky4vK
YhwR/TWaj9jHiKzqoNjfBa66p3C/5zhLC2DySQY3GdK8BSRPzDEEY9qFd2PzahnM
vyQtTFx7FUPoLJJP1ldV1U//U2zVPztz9G1nMBf+FY3b1VJ0LM/6WpGf66Kza7nn
A1XC9wpP5DdeGEV7xM0vpU1syVT8ll08YwraJ76a17DxP/A7kEUw1z8snHfHbsfo
CrWR8gJlwvIQJMA09+P4nZoiECdGTCuU4WqNqXsXfHi15hWkYLdinaK0b1ACpCcZ
olb2WaYyrjDMDgAVI/vdW3GKIilWHPwp7oDE2DJ4pavO1/ElRbXSv+Y=
=cyYn
-----END PGP SIGNATURE-----

--lbtqg0T9ststaLXSpCM7R3t9t9hOiUg9h--
