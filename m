Received: from eggs.gnu.org ([2001:4830:134:3::10]:59410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUyMo-0003A2-HX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUyMn-0007V6-Em
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:50:30 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-10-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84791a9a-e8d4-5b85-1926-445688c23b2e@redhat.com>
Date: Tue, 11 Jul 2017 11:50:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-10-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EV3snN32Ub3355bE6TRQf5fqA7xnbJlFM"
Subject: Re: [Qemu-devel] [PATCH v4 09/17] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EV3snN32Ub3355bE6TRQf5fqA7xnbJlFM
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com
Message-ID: <84791a9a-e8d4-5b85-1926-445688c23b2e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/17] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
References: <20170703151051.31327-1-eblake@redhat.com>
 <20170703151051.31327-10-eblake@redhat.com>
In-Reply-To: <20170703151051.31327-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 10:10 AM, Eric Blake wrote:
> Thanks to recent cleanups, most callers were scaling a return value
> of sectors into bytes (the exception, in qcow2-bitmap, will be
> converted to byte-based iteration later).  Update the interface to
> do the scaling internally instead.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

> @@ -506,7 +506,7 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter=
)
>=20
>  int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
>  {
> -    return hbitmap_iter_next(&iter->hbi);
> +    return hbitmap_iter_next(&iter->hbi) * BDRV_SECTOR_SIZE;
>  }
>=20

> +++ b/block/qcow2-bitmap.c
> @@ -1105,7 +1105,7 @@ static uint64_t *store_bitmap_data(BlockDriverSta=
te *bs,
>      sbc =3D limit >> BDRV_SECTOR_BITS;
>      assert(DIV_ROUND_UP(bm_size, limit) =3D=3D tb_size);
>=20
> -    while ((sector =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
> +    while ((sector =3D bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS) =
!=3D -1) {

Does clang's sanitizer complain about right shift of a negative number,
or is that one of the things that we can rely on even though C says it
is not strictly portable?  If it is a problem, I can always split the
check for bdrv_dirty_iter_next()<0 to occur separately from the while()
conditional; but I'd rather not go through with the churn unless it
actually chokes a build-bot as written.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EV3snN32Ub3355bE6TRQf5fqA7xnbJlFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZQHAAAoJEKeha0olJ0NqwuAH+gLwq+nDfDzUJ0mtwI/sXSrw
e95a3siZCg7s3spELgivfNMB+1H7UZEGgGxlLZTNqZoiZ2PS02RyFsbbYz7I9kvy
c2rzZllRJYbq/fdEUEvMKRkhaS0SPq7BhuVgnmb9gbKVhC2iubyVeRBdUQiwj8o8
F0l0OEEx2LTQdNhIR+YAmhr/YPaEKxdfSQNxfu74dNo4xvcuRksWMC7+dTLdqwcy
1psw0/IsIuqwXZrwBkGYhW9SylE2COphRjXRg+TT8XEw8b8PhYKcL7mfBRfLRNTj
Yf54fHreoibU8nVNBLo+4xFUo4yFSH5ZdFRy6+TUBcPXD01nj2iRGSeXMOU6M/A=
=2dfu
-----END PGP SIGNATURE-----

--EV3snN32Ub3355bE6TRQf5fqA7xnbJlFM--
