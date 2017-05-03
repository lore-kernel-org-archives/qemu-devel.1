Received: from eggs.gnu.org ([2001:4830:134:3::10]:51989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zPl-00024z-NY
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zPk-0003B4-QP
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:54:17 -0400
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-4-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <839854ea-bff8-367e-9d87-0ab7dffa4995@redhat.com>
Date: Wed, 3 May 2017 20:54:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170429191419.30051-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w8hp0xggnR5AM123PAapMAQJTDs2oaqWt"
Subject: Re: [Qemu-devel] [PATCH v11 3/9] qemu-io: Switch 'map' output to
 byte-based reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w8hp0xggnR5AM123PAapMAQJTDs2oaqWt
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <839854ea-bff8-367e-9d87-0ab7dffa4995@redhat.com>
Subject: Re: [PATCH v11 3/9] qemu-io: Switch 'map' output to byte-based
 reporting
References: <20170429191419.30051-1-eblake@redhat.com>
 <20170429191419.30051-4-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.2017 21:14, Eric Blake wrote:
> Mixing byte offset and sector allocation counts is a bit
> confusing.  Also, reporting n/m sectors, where m decreases
> according to the remaining size of the file, isn't really
> adding any useful information; and reporting an offset at
> both the front and end of the line, with large amounts of
> whitespace, is pointless.  Update the output to use byte
> counts and shorter lines, then adjust the affected tests
> (./check -qcow2 102, ./check -vpc 146).
>=20
> Note that 'qemu-io map' is MUCH weaker than 'qemu-img map';
> the former only shows which regions of the active layer are
> allocated, without regards to where the allocation comes from
> or whether the allocated portion is known to read as zero
> (because it is using the weaker bdrv_is_allocated()); while the
> latter (especially in --output=3Djson mode) reports more details
> from bdrv_get_block_status().
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v11: rebase to occur before test 179, shrink the output
> v10: rebase to updated test 179
> v9: new patch
> ---
>  qemu-io-cmds.c             | 11 ++++++-----
>  tests/qemu-iotests/102.out |  4 ++--
>  tests/qemu-iotests/146.out | 30 +++++++++++++++---------------
>  3 files changed, 23 insertions(+), 22 deletions(-)

Reviwed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 1e0ebb4..4b2278f 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c

[...]

> @@ -1894,10 +1894,11 @@ static int map_f(BlockBackend *blk, int argc, c=
har **argv)
>          }
>=20
>          retstr =3D ret ? "    allocated" : "not allocated";
> -        cvtstr(offset << 9ULL, s1, sizeof(s1));
> -        printf("[% 24" PRId64 "] % 8" PRId64 "/% 8" PRId64 " sectors %=
s "
> -               "at offset %s (%d)\n",
> -               offset << 9ULL, num, nb_sectors, retstr, s1, ret);
> +        cvtstr(num << BDRV_SECTOR_BITS, s1, sizeof(s1));
> +        cvtstr(offset << BDRV_SECTOR_BITS, s2, sizeof(s2));
> +        printf("%s (0x%" PRIx64 ") bytes %s at offset %s (0x%" PRIx64 =
")\n",

By the way, %# " PRIx64 " would work, too.


Just wanted to get out my kind-of-obscure printf knowledge.

Sorry.

> +               s1, num << BDRV_SECTOR_BITS, retstr,
> +               s2, offset << BDRV_SECTOR_BITS);
>=20
>          offset +=3D num;
>          nb_sectors -=3D num;


--w8hp0xggnR5AM123PAapMAQJTDs2oaqWt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKJ1ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A80YIAJkCoW7/TagKhcH5VD2AQyC/3sbdTbfU
pyMeEMcaw6XCp1i8bEQUAsW24TBYIL7vh+ixLq4KFrVl8PQD8j3B1SI61SOBvz5j
FKApk3wSIkr95OzY2Im55fOr1QdkXcdreeuRErCVXw4IBgug9rJcPhpJXTmc6VVV
YRLXEGQJ2q0eSrSp79ZqxDsbbTGaY3D3k/V61fvJhSIq69Z3dgOLMfiT5tio6YS8
MBAbQf6t02YrduBki7NsoCGVjjOA4JbwUPa0wyOzi3WU9ZVhAQTWdzJ4NbCGOlZi
4Irzw8e74KaeIXl4ZWMe5Ysjx75wSrc70Y89RpjwUYK6u0zf9PtoQt0=
=YMIN
-----END PGP SIGNATURE-----

--w8hp0xggnR5AM123PAapMAQJTDs2oaqWt--
