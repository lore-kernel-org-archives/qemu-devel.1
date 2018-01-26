Received: from eggs.gnu.org ([2001:4830:134:3::10]:45695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9xE-0000JM-Fv
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9xD-0006t4-3g
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:46:28 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e32b96c-b65a-eba3-9d8e-7d0ec9bad741@redhat.com>
Date: Fri, 26 Jan 2018 13:46:19 -0600
MIME-Version: 1.0
In-Reply-To: <7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NM0AFh1BtFQK39pwreymF6hbGfWzaw8Db"
Subject: Re: [Qemu-devel] [PATCH v3 30/39] qcow2: Update
 expand_zero_clusters_in_l1() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NM0AFh1BtFQK39pwreymF6hbGfWzaw8Db
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <1e32b96c-b65a-eba3-9d8e-7d0ec9bad741@redhat.com>
Subject: Re: [PATCH v3 30/39] qcow2: Update expand_zero_clusters_in_l1() to
 support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
In-Reply-To: <7d8d80bfde60d29e8a0abe04db8241b754714329.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
> expand_zero_clusters_in_l1() expands zero clusters as a necessary step
> to downgrade qcow2 images to a version that doesn't support metadata
> zero clusters. This function takes an L1 table (which may or may not
> be active) and iterates over all its L2 tables looking for zero
> clusters.
>=20
> Since we'll be loading L2 slices instead of full tables we need to add
> an extra loop that iterates over all slices of each L2 table, and we
> should also use the slice size when allocating the buffer used when
> the L1 table is not active.
>=20
> This function doesn't need any additional changes so apart from that
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Finally, and since we have to touch the bdrv_read() / bdrv_write()
> calls anyway, this patch takes the opportunity to replace them with
> the byte-based bdrv_pread() / bdrv_pwrite().

This last paragraph could perhaps be split to a separate patch, but
that's more churn so I'm also fine leaving it here.

>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 52 ++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 29 insertions(+), 23 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> @@ -1905,22 +1908,24 @@ static int expand_zero_clusters_in_l1(BlockDriv=
erState *bs, uint64_t *l1_table,
>              goto fail;
>          }
> =20
> -        {
> +        for (slice =3D 0; slice < n_slices; slice++) {
> +            uint64_t slice_offset =3D l2_offset + slice * slice_size2;=

> +            bool l2_dirty =3D false;
>              if (is_active_l1) {
>                  /* get active L2 tables from cache */
> -                ret =3D qcow2_cache_get(bs, s->l2_table_cache, l2_offs=
et,
> -                                      (void **)&l2_table);
> +                ret =3D qcow2_cache_get(bs, s->l2_table_cache, slice_o=
ffset,
> +                                      (void **)&l2_slice);

The (void **) cast is probably still necessary (anything can go to
void*, but C gets pickier when going to void**), but...

>              } else {
>                  /* load inactive L2 tables from disk */
> -                ret =3D bdrv_read(bs->file, l2_offset / BDRV_SECTOR_SI=
ZE,
> -                                (void *)l2_table, s->cluster_sectors);=

> +                ret =3D bdrv_pread(bs->file, slice_offset,
> +                                 (void *)l2_slice, slice_size2);

=2E..do we still need this cast to void*?


> =20
> -                    ret =3D bdrv_write(bs->file, l2_offset / BDRV_SECT=
OR_SIZE,
> -                                     (void *)l2_table, s->cluster_sect=
ors);
> +                    ret =3D bdrv_pwrite(bs->file, slice_offset,
> +                                      (void *)l2_slice, slice_size2);

and again here

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NM0AFh1BtFQK39pwreymF6hbGfWzaw8Db
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprhYsACgkQp6FrSiUn
Q2qyWwgAoE9nV1A3H73G5Z51e7kCiznUYPSbq81gSDQUCnXzCIpT9dXqrJmtZb1o
R1l04BpFwpqDjAkkAa2UUAEQcwJ2AaTcBTQzgFRfGWt/C9OVtze3hxoC7lxWuO8X
CErmtI70AzV+L1xx4m2A8dL/topz/Rq0079u9hrKvyQRuyhcpQVSQ94U9Js8MB4p
uPb119Cs+YR8Cgm15MSH7vMjFH0I70TTlAlQZCvqqVSGML/GdF0LCnfM73JuQOx6
PQdQDD81c5bdxNawnZokjxA/PFHPvVVqOkKA9uZzyBJTKA6TxU+OOQZ3xWHwfVaL
GKPGL3LFjunVBzvg12AQp1Az9AKd4A==
=y66d
-----END PGP SIGNATURE-----

--NM0AFh1BtFQK39pwreymF6hbGfWzaw8Db--
