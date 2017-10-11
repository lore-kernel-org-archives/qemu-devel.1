Received: from eggs.gnu.org ([2001:4830:134:3::10]:46440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2LpT-0003Rg-7K
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2LpS-0001el-AQ
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 14:34:03 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171004020048.26379-15-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c397dd86-5d4e-2c67-55b2-f6d3238a1db9@redhat.com>
Date: Wed, 11 Oct 2017 13:33:49 -0500
MIME-Version: 1.0
In-Reply-To: <20171004020048.26379-15-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qwDQksB5VOgnV4Of0LIn4Rf87fp78UkjO"
Subject: Re: [Qemu-devel] [PATCH v5 14/23] qemu-img: Speed up compare on
 pre-allocated larger file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qwDQksB5VOgnV4Of0LIn4Rf87fp78UkjO
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <c397dd86-5d4e-2c67-55b2-f6d3238a1db9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 14/23] qemu-img: Speed up compare on
 pre-allocated larger file
References: <20171004020048.26379-1-eblake@redhat.com>
 <20171004020048.26379-15-eblake@redhat.com>
In-Reply-To: <20171004020048.26379-15-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/03/2017 09:00 PM, Eric Blake wrote:
> Compare the following images with all-zero contents:
> $ truncate --size 1M A
> $ qemu-img create -f qcow2 -o preallocation=3Doff B 1G
> $ qemu-img create -f qcow2 -o preallocation=3Dmetadata C 1G
>=20

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

> +++ b/qemu-img.c
> @@ -1481,11 +1481,11 @@ static int img_compare(int argc, char **argv)
>          while (sector_num < progress_base) {
>              int64_t count;
>=20
> -            ret =3D bdrv_is_allocated_above(blk_bs(blk_over), NULL,
> +            ret =3D bdrv_block_status_above(blk_bs(blk_over), NULL,

Just now noticing: in this function, ret is 32-bit, but
bdrv_block_status_above() returns 64-bit values...

>                                            sector_num * BDRV_SECTOR_SIZ=
E,
>                                            (progress_base - sector_num)=
 *
>                                            BDRV_SECTOR_SIZE,
> -                                          &count);
> +                                          &count, NULL);
>              if (ret < 0) {

=2E..which could make for a false positive in a static checker (none of
our implementations return a negative value beyond INT_MIN for wrapping
to be a serious concern).  So that's yet another reason why I am liking
Kevin's proposal to split the returned offset to be a by-reference
parameter rather than squashed into the return type, as it will let me
use a 32-bit return type and avoid worrying about this corner case.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qwDQksB5VOgnV4Of0LIn4Rf87fp78UkjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlneZA0ACgkQp6FrSiUn
Q2oHjggAlhO4Y0LjBexoGbDdIbFRsr1n0bo2gLsxx6p+e3h9XfBYXvldFbxo2z4m
3XdDG/2oCu39dx7dffByg8bcGQHjLSuC0y9979fSzyyApCjcN2SnbsRc2e0IFsxg
pQPWrF0Ej04DY2H0ASdkW4TffIQQkrDfy9Z+HzRdFftxNg71GuVRWThEImZvPlw8
TucphkqklN6HxL5PQisF6/SeBe8ZoB+mCsr+/jRsrA2pix1PpW6rmBL0ZqNcbeQx
uFGuG4KDGgJwQTc9YK1d+sbXZfYKQiNPYVFLO2PAbvcPi+eeGem1jNXl+YNiDnmA
Am5SltcocBC9tJU3N40kQ+OaWhyT3Q==
=Ppdq
-----END PGP SIGNATURE-----

--qwDQksB5VOgnV4Of0LIn4Rf87fp78UkjO--
