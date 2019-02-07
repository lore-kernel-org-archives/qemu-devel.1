Received: from eggs.gnu.org ([209.51.188.92]:42665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grl3l-00083U-RQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grl3k-0006fs-Ps
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:53:49 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb7672c3-9b57-ff63-c0dd-1ddace483fa1@redhat.com>
Date: Thu, 7 Feb 2019 08:53:18 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XaihfD6KAGFxaGKdNJCzhqWMhOwQlKN0C"
Subject: Re: [Qemu-devel] [PATCH v3 02/17] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XaihfD6KAGFxaGKdNJCzhqWMhOwQlKN0C
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <bb7672c3-9b57-ff63-c0dd-1ddace483fa1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/17] block/io: use qemu_iovec_init_buf
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> While being here, use qemu_try_blockalign0 as well.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 89 ++++++++++++------------------------------------------=

>  1 file changed, 20 insertions(+), 69 deletions(-)
>=20

> @@ -1477,7 +1456,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(=
BlockDriverState *bs,
>  {
>      BlockDriver *drv =3D bs->drv;
>      QEMUIOVector qiov;
> -    struct iovec iov =3D {0};
> +    void *buf =3D NULL;
>      int ret =3D 0;
>      bool need_flush =3D false;
>      int head =3D 0;
> @@ -1547,16 +1526,14 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroe=
s(BlockDriverState *bs,
>                  need_flush =3D true;
>              }
>              num =3D MIN(num, max_transfer);
> -            iov.iov_len =3D num;
> -            if (iov.iov_base =3D=3D NULL) {
> -                iov.iov_base =3D qemu_try_blockalign(bs, num);
> -                if (iov.iov_base =3D=3D NULL) {
> +            if (buf =3D=3D NULL) {
> +                buf =3D qemu_try_blockalign0(bs, num);
> +                if (buf =3D=3D NULL) {
>                      ret =3D -ENOMEM;
>                      goto fail;
>                  }
> -                memset(iov.iov_base, 0, num);
>              }
> -            qemu_iovec_init_external(&qiov, &iov, 1);
> +            qemu_iovec_init_buf(&qiov, buf, num);

The use of qemu_try_blockalign0() is new to this revision, but fits in
well enough that I don't think you need to split the patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XaihfD6KAGFxaGKdNJCzhqWMhOwQlKN0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcRl8ACgkQp6FrSiUn
Q2pSSQf+JYS/OlB2kMi6izhaGE69Kyv0R/IZGRz5TH+7b8FEyKtdNdmNz1SFj9Ir
GZ4aE0TSRvYJmm02MvQTaGXY3JJUC1udCmwaIQwiNCOYP4CJTnWag3KqEsnYVVaa
nk3dkUVoumDBUSb8Wi2zD89lJ+JU16Xz2FZDR53Df89PDHENz3YYrhwhuCe9oEzZ
QRXhVJEWE7bii8M4oQ6/PMP9g3l4x3HKWf11wjZTkm5KoUppO94iSou9EIXgwT0K
UAaaQC0sc2iROY5CuritkiumRnrKa0HQrP+xmPTOi9HjVm6ttE+y4LoNAtD15tn0
2GuZjwDMqIZFlBl6JuI04GhEdauruw==
=ZwWt
-----END PGP SIGNATURE-----

--XaihfD6KAGFxaGKdNJCzhqWMhOwQlKN0C--
