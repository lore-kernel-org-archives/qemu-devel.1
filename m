Received: from eggs.gnu.org ([209.51.188.92]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmhMM-000434-8R
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmhML-0004fe-41
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:56:06 -0500
References: <20190124141731.21509-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f314a45b-72d4-bc00-07a4-1437c58d286a@redhat.com>
Date: Thu, 24 Jan 2019 09:56:00 -0600
MIME-Version: 1.0
In-Reply-To: <20190124141731.21509-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OxkFGKnnvAkzqoyhQ2KnIeTSt8jbYBkVc"
Subject: Re: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OxkFGKnnvAkzqoyhQ2KnIeTSt8jbYBkVc
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <f314a45b-72d4-bc00-07a4-1437c58d286a@redhat.com>
Subject: Re: [PATCH] file-posix: Cache lseek result for data regions
References: <20190124141731.21509-1-kwolf@redhat.com>
In-Reply-To: <20190124141731.21509-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/24/19 8:17 AM, Kevin Wolf wrote:
> Depending on the exact image layout and the storage backend (tmpfs is
> konwn to have very slow SEEK_HOLE/SEEK_DATA), caching lseek results can=

> save us a lot of time e.g. during a mirror block job or qemu-img conver=
t
> with a fragmented source image (.bdrv_co_block_status on the protocol
> layer can be called for every single cluster in the extreme case).
>=20
> We may only cache data regions because of possible concurrent writers.
> This means that we can later treat a recently punched hole as data, but=

> this is safe. We can't cache holes because then we might treat recently=

> written data as holes, which can cause corruption.

gluster copies heavily from file-posix's implementation; should it also
copy this cache of known-data?  Should NBD also cache known-data when
NBD_CMD_BLOCK_STATUS is available?

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 51 ++++++++++++++++++++++++++++++++++++++++++++--=

>  1 file changed, 49 insertions(+), 2 deletions(-)
>=20

> =20
> +    /* Invalidate seek_data_cache if it overlaps */
> +    sdc =3D &s->seek_data_cache;
> +    if (sdc->valid && !(sdc->end < aiocb->aio_offset ||
> +                        sdc->start > aiocb->aio_offset + aiocb->aio_nb=
ytes))
> +    {
> +        sdc->valid =3D false;
> +    }

Worth a helper function for this repeated action?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--OxkFGKnnvAkzqoyhQ2KnIeTSt8jbYBkVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxJ4BAACgkQp6FrSiUn
Q2rZWgf/eRpRtrvKUkr9ujPZY7qzlZKbXx13OyWS1hq5e/LmBZbmyeLlEkKb6A18
7DjMsd/vaEAJGUwSokIWQYt2pWpIZ64tf92WjampVERmTTgyvxxBD0kX336/ZkED
M5wH9iB5O9MxrmUQLonJBVLLEcDjMwi5wWAeLXWbB4HfJswMPJVqW0OOmqTSktCp
An6ZYcweOiFxOsNnf2+sWEyYQRdc1Ow61YsxJwTzu3F16e25LASm49apASVc0IAv
SawhGMad3dbzDsiJgHiEa2dNy9JW9R2wUrVpCJ2d7g0ARMfeRAfg6k9j4X5wIK4R
ZDrkoO/zW84HkK6IOw9gZmlNfTcrkQ==
=FTCd
-----END PGP SIGNATURE-----

--OxkFGKnnvAkzqoyhQ2KnIeTSt8jbYBkVc--
