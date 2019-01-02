Received: from eggs.gnu.org ([208.118.235.92]:52520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gefp4-0002Cd-Uv
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gefp4-0006rK-7p
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 07:40:34 -0500
Date: Wed, 2 Jan 2019 12:40:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102124026.GL24009@stefanha-x1.localdomain>
References: <20181223025939.15775-1-npes87184@gmail.com>
	<20181223025939.15775-4-npes87184@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Content-Disposition: inline
In-Reply-To: <20181223025939.15775-4-npes87184@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] dmg: don't skip zero chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2018 at 10:59:39AM +0800, yuchenlin wrote:
> The dmg file has many tables which describe: "start from sector XXX to
> sector XXX, the compression method is XXX and where the compressed data
> resides on".
>=20
> Each sector in the expanded file should be covered by a table. The table
> will describe the offset of compressed data (or raw depends on the type)
> in the dmg.
>=20
> For example:
>=20
> [-----------The expanded file------------]
> [---bzip table ---]/* zeros */[---zlib---]
>     ^
>     | if we want to read this sector.
>=20
> we will find bzip table which contains this sector, and get the
> compressed data offset, read it from dmg, uncompress it, finally write to
> expanded file.
>=20
> If we skip zero chunk (table), some sector cannot find the table which
> will cause search_chunk() return s->n_chunks, dmg_read_chunk() return -1
> and finally causing dmg_co_preadv() return EIO.
>=20
> See:
>=20
> [-----------The expanded file------------]
> [---bzip table ---]/* zeros */[---zlib---]
>                     ^
>                     | if we want to read this sector.
>=20
> Oops, we cannot find the table contains it...
>=20
> In the original implementation, we don't have zero table. When we try to
> read sector inside the zero chunk. We will get EIO, and skip reading.
>=20
> After this patch, we treat zero chunk the same as ignore chunk, it will
> directly write zero and avoid some sector may not find the table.
>=20
> After this patch:
>=20
> [-----------The expanded file------------]
> [---bzip table ---][--zeros--][---zlib---]
>=20
> Signed-off-by: yuchenlin <npes87184@gmail.com>
> ---
>  block/dmg.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLLE6AAoJEJykq7OBq3PICF8IAKYB+9zMj8nxFjqxOhJfxQbL
5EaAiVOx9dp9rSMaEGpUCbHZZUWAGRAYd+xDSb9f3q7H2KCeROx5bU0rw7T49FUn
4NLoprAIBjrSZEmXEtsPB4MOkFWUj5b9ZLolfQ2GxAw6mUf/DctenpwwXl0RgF3q
1iK0RrN7h7A+uKajqnfkKJcYBHgwEDmEAUFCLB1L2cF5/U+rnMVV9YQVYlmaL4Sq
P4+UVd0wB4CFStJOxBQd8OqsrJNxRk0iFYaa3QGHX/2XIahOa2IbJhqm9DLi7kje
w5wrVwnFXKspFJy9v3vFFCwep8+LcYBUahi9wGJkCnBdfRI3FVKPe72u+/rlcsE=
=W5LX
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--
