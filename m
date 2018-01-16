Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaMN-0003XI-Qc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebaMM-0008Ur-Er
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:09:39 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<1fb1816d471d712f2001ca3ce42c6682273c7daf.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08064c0c-438a-963a-847b-450a21be5e2f@redhat.com>
Date: Tue, 16 Jan 2018 17:09:29 -0600
MIME-Version: 1.0
In-Reply-To: <1fb1816d471d712f2001ca3ce42c6682273c7daf.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Mc5kChytSCi6pBA2LsweMqDLdoSHDswFO"
Subject: Re: [Qemu-devel] [PATCH v2 25/32] qcow2: Update
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mc5kChytSCi6pBA2LsweMqDLdoSHDswFO
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <08064c0c-438a-963a-847b-450a21be5e2f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 25/32] qcow2: Update
 expand_zero_clusters_in_l1() to support L2 slices
References: <cover.1513342045.git.berto@igalia.com>
 <1fb1816d471d712f2001ca3ce42c6682273c7daf.1513342045.git.berto@igalia.com>
In-Reply-To: <1fb1816d471d712f2001ca3ce42c6682273c7daf.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
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
> As a consequence of the new loop the refcount data also needs to be
> loaded before the L2 data, but this is a trivial change with no side
> effects.
>=20
> This function doesn't need any additional changes so apart from that
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 207 +++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 110 insertions(+), 97 deletions(-)
>=20

Even hairier diff than the previous patch. Would it be feasible to split
this into two or three parts - one that just adds an additional {}
scoping (but no variable renames or loop condition changes) (where git
diff -b can easily check the change in isolation); the other that
renames the variable and switches the new scope to be a loop over the
smaller slice limits (possibly as two patches, if the change in refcount
vs. L2 data load ordering deserves separation from the slice conversion)?=


> -        } else {
> -            /* load inactive L2 tables from disk */
> -            ret =3D bdrv_read(bs->file, l2_offset / BDRV_SECTOR_SIZE,
> -                            (void *)l2_table, s->cluster_sectors);

Pre-existing...

> -        }
> -        if (ret < 0) {
> -            goto fail;
> -        }
> -
>          ret =3D qcow2_get_refcount(bs, l2_offset >> s->cluster_bits,
>                                   &l2_refcount);
>          if (ret < 0) {
>              goto fail;
>          }
> =20
> -        for (j =3D 0; j < s->l2_size; j++) {
> -            uint64_t l2_entry =3D be64_to_cpu(l2_table[j]);
> -            int64_t offset =3D l2_entry & L2E_OFFSET_MASK;
> -            QCow2ClusterType cluster_type =3D qcow2_get_cluster_type(l=
2_entry);
> -
> -            if (cluster_type !=3D QCOW2_CLUSTER_ZERO_PLAIN &&
> -                cluster_type !=3D QCOW2_CLUSTER_ZERO_ALLOC) {
> -                continue;
> +        for (slice =3D 0; slice < n_slices; slice++) {
> +            uint64_t slice_offset =3D l2_offset + slice * slice_size;
> +            if (is_active_l1) {
> +                /* get active L2 tables from cache */
> +                ret =3D qcow2_cache_get(bs, s->l2_table_cache, slice_o=
ffset,
> +                                      (void **)&l2_slice);
> +            } else {
> +                /* load inactive L2 tables from disk */
> +                ret =3D bdrv_read(bs->file, slice_offset >> BDRV_SECTO=
R_BITS,
> +                                (void *)l2_slice,
> +                                slice_size >> BDRV_SECTOR_BITS);

=2E..but is it time to convert this to use bdrv_pread[v](), for one less
use of the older sector-based interfaces?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Mc5kChytSCi6pBA2LsweMqDLdoSHDswFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpehikACgkQp6FrSiUn
Q2oGtgf9Gg+Ze5y9mOwbaZWPhxrnHHbilypI8DC5qZYTSt6YHjCx8Kf0YkfLxZOL
e/yhnvLeuBIA4PdNCjUft3c61rv8thsi7AdY/flwjc9fAityFocanDDjb3Vitg/I
qwAqGlmaPrREaDXvE4ILK/L+BTYUF5ZUIwD5V8HHNKFcRPr9J2EkQyy5m3BNxL71
dZ1KG9xgL+91zhp7MVnq6jlF8GOXtc31qTMKkuLngnTsB/2jlnELNVJYPu8GfT9X
LQeArQ/CtnjoY83ecfQ3mByQdGNfCXpY2i5empA+LIYPxEVgpGSWpyb6TlbWsEWO
simAGfiCSKQy7HHlU1DoVSXPiFEQjg==
=E4y6
-----END PGP SIGNATURE-----

--Mc5kChytSCi6pBA2LsweMqDLdoSHDswFO--
