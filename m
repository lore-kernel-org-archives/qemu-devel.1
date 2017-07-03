Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS3xn-0007AI-1s
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS3xl-00030Z-Qh
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:12:39 -0400
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-4-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
Date: Mon, 3 Jul 2017 11:12:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170629184320.7151-4-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XXsgUw1WsPbtGb22xOTgx9g3UBJKVghCD"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: add default implementations
 for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XXsgUw1WsPbtGb22xOTgx9g3UBJKVghCD
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: add default implementations
 for bdrv_co_get_block_status()
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
 <20170629184320.7151-4-el13635@mail.ntua.gr>
In-Reply-To: <20170629184320.7151-4-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 01:43 PM, Manos Pitsidianakis wrote:
> bdrv_co_get_block_status_from_file() and
> bdrv_co_get_block_status_from_backing() set *file to bs->file and
> bs->backing respectively, so that bdrv_co_get_block_status() can recurs=
e
> to them. Future block drivers won't have to duplicate code to implement=

> this.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/blkdebug.c          | 12 +-----------
>  block/commit.c            | 12 +-----------
>  block/io.c                | 24 ++++++++++++++++++++++++
>  block/mirror.c            | 12 +-----------
>  include/block/block_int.h | 16 ++++++++++++++++
>  5 files changed, 43 insertions(+), 33 deletions(-)

My [still-needs-rebasing] part 3 series converting
bdrv_co_get_block_status to byte-based will be impacted by this, but I'd
rather yours go in first and I can deal with the rebase fallout.


> +++ b/include/block/block_int.h
> @@ -945,6 +945,22 @@ void bdrv_format_default_perms(BlockDriverState *b=
s, BdrvChild *c,
>                                 uint64_t perm, uint64_t shared,
>                                 uint64_t *nperm, uint64_t *nshared);
> =20
> +/*
> + * Default implementation for drivers to pass bdrv_co_get_block_status=
() to
> + * their file

I would have ended with '.'

> + * */

Looks odd.  Just use ' */', not ' * */'

> +int64_t coroutine_fn bdrv_co_get_block_status_from_file(BlockDriverSta=
te *bs,
> +                                                     int64_t sector_nu=
m,
> +                                                     int nb_sectors, i=
nt *pnum,
> +                                                     BlockDriverState =
**file);

Indentation is unusual (not necessarily bad, since you are up against
80-column limits).

> +/*
> + * Default implementation for drivers to pass bdrv_co_get_block_status=
() to
> + * their backing file
> + * */
> +int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriver=
State *bs,
> +                                                     int64_t sector_nu=
m,
> +                                                     int nb_sectors, i=
nt *pnum,
> +                                                     BlockDriverState =
**file);

Ditto.

Making changes according to what I mentioned is minor, so you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XXsgUw1WsPbtGb22xOTgx9g3UBJKVghCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWmztAAoJEKeha0olJ0NqETEH/0jb/zI5aHQBusFbkD00J5eF
TJPoiDrrExvL1h8XOM/aXk1CgauigxOM1qwrq6iNRdlmU0hQjWUtVRSFy0zOZrAy
pv/DU3C4/n4SD44+ce23dJqrBgP+tr+My9M+ForsA0CRff8OedNptyJE0FRtxw6e
JGr6lZQG3PsXpHpvYIH6MlZQ1rrtnIGip11Lt5eR10LqIqm7WoVHMI7g2rAlvy3O
6sBR4ZxfxseFKxliALgiTXIh5yZNL5w7ymxrql4EvGBzd7wNf9fm26qBcX7xtWtF
yhjSGdgDDX10J7TPNarJXzxQjDUPFCYDSu8RAb/IMlOBgG4JjvkYm9sDSzTQPM0=
=IeLl
-----END PGP SIGNATURE-----

--XXsgUw1WsPbtGb22xOTgx9g3UBJKVghCD--
