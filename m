Received: from eggs.gnu.org ([2001:4830:134:3::10]:59549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDXp7-0007ix-PA
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDXp6-0000dk-ON
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:03:41 -0400
References: <20170519023233.24461-1-eblake@redhat.com>
	<20170519023233.24461-3-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e40ef46c-4b13-bcc6-9385-99db3e384f41@redhat.com>
Date: Wed, 24 May 2017 10:03:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170519023233.24461-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XORIGJkN7GdOIvDTQvufKWJoPkmJe4U5G"
Subject: Re: [Qemu-devel] [PATCH 2/4] block: Guarantee that *file is set on
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XORIGJkN7GdOIvDTQvufKWJoPkmJe4U5G
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
Message-ID: <e40ef46c-4b13-bcc6-9385-99db3e384f41@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] block: Guarantee that *file is set on
 bdrv_get_block_status()
References: <20170519023233.24461-1-eblake@redhat.com>
 <20170519023233.24461-3-eblake@redhat.com>
In-Reply-To: <20170519023233.24461-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2017 09:32 PM, Eric Blake wrote:
> We document that *file is valid if the return is not an error and
> includes BDRV_BLOCK_OFFSET_VALID, but forgot to obey this contract
> when a driver (such as blkdebug) lacks a callback.  Broken in
> commit 67a0fd2 (v2.6), when we added the file parameter.
>=20

> +++ b/block/io.c
> @@ -1749,6 +1749,7 @@ static int64_t coroutine_fn bdrv_co_get_block_sta=
tus(BlockDriverState *bs,
>      int64_t n;
>      int64_t ret, ret2;
>=20
> +    *file =3D NULL;
>      total_sectors =3D bdrv_nb_sectors(bs);
>      if (total_sectors < 0) {
>          return total_sectors;
> @@ -1769,6 +1770,7 @@ static int64_t coroutine_fn bdrv_co_get_block_sta=
tus(BlockDriverState *bs,
>          ret =3D BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
>          if (bs->drv->protocol_name) {
>              ret |=3D BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECT=
OR_SIZE);
> +            *file =3D bs;
>          }
>          return ret;
>      }

Continuing context:

    *file =3D NULL;
    ret =3D bs->drv->bdrv_co_get_block_status(bs, sector_num, nb_sectors,=

pnum,
                                            file);


Guess I need a v2, to remove the now-redundant second initialization of
*file.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XORIGJkN7GdOIvDTQvufKWJoPkmJe4U5G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJaC1AAoJEKeha0olJ0Nqx0kH/1UcoHUd4SidqEHbd/MSbEsJ
AbR+PmD5vvtPfMpAcVxghwblUaghoKCJkZp3qgE44xEQeDtj8YXQyEzkF48n641T
BoFNgr9WnSz1qWX5tGk5OZ2Oo/AP+I7WwX3GTNCkvMGZ/u0c5wd0p3hlrvUFvC2y
fO9S4BOKa0lg03kcMAJ4rg3n4wz2INrLOaS56WQXhkWfUmAkROK365A2CTA4O1Qe
lhCfW/zuf0rUnHbCJOnr6TpEKaKRKmqvOKfLiJjYeGsQv2nBra+htN5OHloVulLl
uRSgINmXpwlvFb0btfrk6MD+X6EV631WHeUIsVYvNCHhGN8ZUw6Lni/QVgRseao=
=/Xf9
-----END PGP SIGNATURE-----

--XORIGJkN7GdOIvDTQvufKWJoPkmJe4U5G--
