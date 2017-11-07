Received: from eggs.gnu.org ([2001:4830:134:3::10]:48227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eC0kG-0004An-0r
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eC0kA-0000lc-Ha
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:04:36 -0500
Date: Tue, 7 Nov 2017 10:04:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171107100417.GA6809@stefanha-x1.localdomain>
References: <cover.1510021573.git.jcody@redhat.com>
	<5d07b67f40f00586834bfc7e6e3adbfcc058e3de.1510021573.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <5d07b67f40f00586834bfc7e6e3adbfcc058e3de.1510021573.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/4] block/parallels: add migration
 blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 09:31:21PM -0500, Jeff Cody wrote:
> @@ -720,6 +722,16 @@ static int parallels_open(BlockDriverState *bs, QDic=
t *options, int flags,
>      s->bat_dirty_bmap =3D
>          bitmap_new(DIV_ROUND_UP(s->header_size, s->bat_dirty_block));
> =20
> +    /* Disable migration until bdrv_invalidate_cache method is added */
> +    error_setg(&s->migration_blocker, "The Parallels format used by node=
 '%s' "
> +               "does not support live migration",
> +               bdrv_get_device_or_node_name(bs));
> +    ret =3D migrate_add_blocker(s->migration_blocker, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_free(s->migration_blocker);
> +        goto fail;
> +    }

Please call migrate_del_blocker() and error_free() in .bdrv_close().

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAYUhAAoJEJykq7OBq3PIIlsH/15PFW0nPFXuUdMZUYp0IbSW
Wo4rRHLs5k0xEJe3inR0C6VG04kSG9HjCxWKzb05503UpIEn2aGerMQSiW4hf7Zj
Ob3h86i4VshhoR0fEshGDM8lV8E6xWnuOiS3MNSHQP4mxYcJ9KLDUs43qGxigbLX
JK0Jl0zM3MSVmeP+vfoodbbRst8eid3rwuYrPl+xP2lydPiiBC7nqe/tzMQdD92S
y1ryGHfSlmF48+jjVD56Q6dEK3fb7DqvKi9jP1wHf+eO0mEuwsRm4n2EaZf4S7QD
xVxemSmCSjb5NugTk6saUXq1i2CT6ofhjs5Vjd+UM15U2W635um1jJIBoAgs5jg=
=3dv2
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
