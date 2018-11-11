Received: from eggs.gnu.org ([2001:4830:134:3::10]:52325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwrI-0001p3-Bn
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 16:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLwrC-0001kA-W4
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 16:01:28 -0500
References: <cover.1541595424.git.berto@igalia.com>
	<d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <62cb7e48-9120-ace4-cd84-f462b3100251@redhat.com>
Date: Sun, 11 Nov 2018 22:01:05 +0100
MIME-Version: 1.0
In-Reply-To: <d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ADAEtucDnnVgTViimb6h69720JPo35AOm"
Subject: Re: [Qemu-devel] [PATCH v4 14/15] block: Remove assertions from
 update_flags_from_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ADAEtucDnnVgTViimb6h69720JPo35AOm
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <62cb7e48-9120-ace4-cd84-f462b3100251@redhat.com>
Subject: Re: [PATCH v4 14/15] block: Remove assertions from
 update_flags_from_options()
References: <cover.1541595424.git.berto@igalia.com>
 <d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
In-Reply-To: <d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.11.18 13:59, Alberto Garcia wrote:
> This function takes three options (cache.direct, cache.no-flush and
> read-only) from a QemuOpts object and updates the flags accordingly.

and auto-read-only now

>=20
> If any of those options is not set (because it was missing from the
> original QDict or because it had an invalid value) then the function
> aborts with a failed assertion:
>=20
>    $ qemu-io -c 'reopen -o read-only=3Dfoo' hd.qcow2
>    block.c:1126: update_flags_from_options: Assertion `qemu_opt_find(op=
ts, BDRV_OPT_CACHE_DIRECT)' failed.
>    Aborted
>=20
> This assertion is unnecessary, and it forces any caller of
> bdrv_reopen() to pass all the aforementioned three options. This may

*four

> have made sense in order to remove ambiguity when bdrv_reopen() was
> taking both flags and options, but that's not the case anymore.
>=20
> It's also unnecessary if we want to validate the option values,
> because bdrv_reopen_prepare() already takes care of that, as we can
> see if we remove the assertions:
>=20
>    $ qemu-io -c 'reopen -o read-only=3Dfoo' hd.qcow2
>    Parameter 'read-only' expects 'on' or 'off'
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c                    | 4 ----
>  tests/qemu-iotests/133     | 8 ++++++++
>  tests/qemu-iotests/133.out | 6 ++++++
>  3 files changed, 14 insertions(+), 4 deletions(-)

Hm, seems like one way to solve it and I can't really find issue with
it.  So, let's first give a

Reviewed-by: Max Reitz <mreitz@redhat.com>

However, I wonder why you dropped your patch from v1 for this.  It
seemed more reasonable to me.  You're basically trading half-updating
the flags for just not touching them at all (and the latter seems
better, even though it's all an error in the end anyway).

> diff --git a/block.c b/block.c
> index 8bc808d6f3..68f1e3b45e 100644
> --- a/block.c
> +++ b/block.c
> @@ -1139,24 +1139,20 @@ static void update_flags_from_options(int *flag=
s, QemuOpts *opts)
>  {
>      *flags &=3D ~BDRV_O_CACHE_MASK;
> =20
> -    assert(qemu_opt_find(opts, BDRV_OPT_CACHE_NO_FLUSH));
>      if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_NO_FLUSH, false)) {=

>          *flags |=3D BDRV_O_NO_FLUSH;
>      }
> =20
> -    assert(qemu_opt_find(opts, BDRV_OPT_CACHE_DIRECT));
>      if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_DIRECT, false)) {
>          *flags |=3D BDRV_O_NOCACHE;
>      }
> =20
>      *flags &=3D ~BDRV_O_RDWR;

Unrelated to this patch, but isn't BDRV_O_AUTO_RDONLY missing here?

Max

> =20
> -    assert(qemu_opt_find(opts, BDRV_OPT_READ_ONLY));
>      if (!qemu_opt_get_bool_del(opts, BDRV_OPT_READ_ONLY, false)) {
>          *flags |=3D BDRV_O_RDWR;
>      }
> =20
> -    assert(qemu_opt_find(opts, BDRV_OPT_AUTO_READ_ONLY));
>      if (qemu_opt_get_bool_del(opts, BDRV_OPT_AUTO_READ_ONLY, false)) {=

>          *flags |=3D BDRV_O_AUTO_RDONLY;
>      }
> diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
> index 14e6b3b972..59d5e2ea25 100755
> --- a/tests/qemu-iotests/133
> +++ b/tests/qemu-iotests/133
> @@ -101,6 +101,14 @@ $QEMU_IO -c 'reopen -w -o read-only=3Don' $TEST_IM=
G
>  $QEMU_IO -c 'reopen -c none -o cache.direct=3Don' $TEST_IMG
>  $QEMU_IO -c 'reopen -c writeback -o cache.direct=3Don' $TEST_IMG
>  $QEMU_IO -c 'reopen -c directsync -o cache.no-flush=3Don' $TEST_IMG
> +
> +echo
> +echo "=3D=3D=3D Check that invalid options are handled correctly =3D=3D=
=3D"
> +echo
> +
> +$QEMU_IO -c 'reopen -o read-only=3Dfoo' $TEST_IMG
> +$QEMU_IO -c 'reopen -o cache.no-flush=3Dbar' $TEST_IMG
> +$QEMU_IO -c 'reopen -o cache.direct=3Dbaz' $TEST_IMG
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/133.out b/tests/qemu-iotests/133.out
> index 48a9d087f0..551096a9c4 100644
> --- a/tests/qemu-iotests/133.out
> +++ b/tests/qemu-iotests/133.out
> @@ -32,4 +32,10 @@ Cannot set both -r/-w and 'read-only'
>  Cannot set both -c and the cache options
>  Cannot set both -c and the cache options
>  Cannot set both -c and the cache options
> +
> +=3D=3D=3D Check that invalid options are handled correctly =3D=3D=3D
> +
> +Parameter 'read-only' expects 'on' or 'off'
> +Parameter 'cache.no-flush' expects 'on' or 'off'
> +Parameter 'cache.direct' expects 'on' or 'off'
>  *** done
>=20



--ADAEtucDnnVgTViimb6h69720JPo35AOm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvomJEACgkQ9AfbAGHV
z0CCGAf/UDh6kOlq7QdpXIU/HdHfJv/lNgk2OElP178tOs3iVK52Iwwp+GdO+gCt
Cji6WfuG5A5hq9WIJ4uBJKCVeQV7bnbJcZcZa8eMwnVpORDDim8sOTm2ObDsUTsj
5TyrOiGU751pLTjvt3yBmBicfivmnCHciA95iUvY/50c4Z5CFUkVm9BmvdpcuQ9v
T41Vquaxfske4F+mszDmqQOlWSQBPMIha+/3LmWLiVnl7xP9dK1JfG3iVc/ntzKD
sdPcwTlSxdWkBgnJn2vExbAmFBreBLv53EUSRWvEyo2AmR26AO1xLqEqXNrqF/N7
fZSEyKoXlC5Ffd4Brg2gxfncrvMRUw==
=rFNM
-----END PGP SIGNATURE-----

--ADAEtucDnnVgTViimb6h69720JPo35AOm--
