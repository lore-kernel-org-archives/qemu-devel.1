Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYk0F-0002gm-E5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYk0E-0003U2-5i
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:46:31 -0500
References: <20170130161441.30493-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <574dd15d-ace7-cbaf-574a-944c2c436b95@redhat.com>
Date: Wed, 1 Feb 2017 02:46:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170130161441.30493-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qhHWX2hoj5XqEI0L01nDSjki6B9dwLgAc"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Optimize the refcount-block overlap
 check
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
--qhHWX2hoj5XqEI0L01nDSjki6B9dwLgAc
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <574dd15d-ace7-cbaf-574a-944c2c436b95@redhat.com>
Subject: Re: [PATCH] qcow2: Optimize the refcount-block overlap check
References: <20170130161441.30493-1-berto@igalia.com>
In-Reply-To: <20170130161441.30493-1-berto@igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.01.2017 17:14, Alberto Garcia wrote:
> The metadata overlap checks introduced in a40f1c2add help detect
> corruption in the qcow2 image by verifying that data writes don't
> overlap with existing metadata sections.
>=20
> The 'refcount-block' check in particular iterates over the refcount
> table in order to get the addresses of all refcount blocks and check
> that none of them overlap with the region where we want to write.
>=20
> The problem with the refcount table is that since it always occupies
> complete clusters its size is usually very big.

Actually the main problem is that BDRVQcow2State.refcount_table_size is
updated very generously as opposed to BDRVQcow2State.l1_size. The latter
is usually exactly as large as it needs to be (because the L1 table size
usually doesn't change), whereas the refcount_table_size is just bumped
up every time the image gets bigger until it reaches or exceeds the
value it needs to be.

>                                                 With the default
> values of cluster_size=3D64KB and refcount_bits=3D16 this table holds 8=
192
> entries, each one of them enough to map 2GB worth of host clusters.
>=20
> So unless we're using images with several TB of allocated data this
> table is going to be mostly empty, and iterating over it is a waste of
> CPU. If the storage backend is fast enough this can have an effect on
> I/O performance.
>=20
> This patch keeps the index of the last used (i.e. non-zero) entry in
> the refcount table and updates it every time the table changes. The
> refcount-block overlap check then uses that index instead of reading
> the whole table.
>=20
> In my tests with a 4GB qcow2 file stored in RAM this doubles the
> amount of write IOPS.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c | 21 ++++++++++++++++++++-
>  block/qcow2.c          |  1 +
>  block/qcow2.h          |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index cbfb3fe064..5e4d36587f 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -83,6 +83,16 @@ static Qcow2SetRefcountFunc *const set_refcount_func=
s[] =3D {
>  /*********************************************************/
>  /* refcount handling */
> =20
> +static void update_max_refcount_table_index(BDRVQcow2State *s)
> +{
> +    unsigned i =3D s->refcount_table_size - 1;
> +    while (i > 0 && (s->refcount_table[i] & REFT_OFFSET_MASK) =3D=3D 0=
) {
> +        i--;
> +    }
> +    /* Set s->max_refcount_table_index to the index of the last used e=
ntry */
> +    s->max_refcount_table_index =3D i;
> +}
> +
>  int qcow2_refcount_init(BlockDriverState *bs)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> @@ -111,6 +121,7 @@ int qcow2_refcount_init(BlockDriverState *bs)
>          }
>          for(i =3D 0; i < s->refcount_table_size; i++)
>              be64_to_cpus(&s->refcount_table[i]);
> +        update_max_refcount_table_index(s);
>      }
>      return 0;
>   fail:
> @@ -439,6 +450,7 @@ static int alloc_refcount_block(BlockDriverState *b=
s,
>          }
> =20
>          s->refcount_table[refcount_table_index] =3D new_block;
> +        s->max_refcount_table_index =3D refcount_table_index;

Should be MAX(s->max_refcount_table_index, refcount_table_index) or this
won't support refcount tables with holes in them.

Apart from this, the patch looks good to me. (Just a nagging comment belo=
w.)

> =20
>          /* The new refcount block may be where the caller intended to =
put its
>           * data, so let it restart the search. */
> @@ -580,6 +592,7 @@ static int alloc_refcount_block(BlockDriverState *b=
s,
>      s->refcount_table =3D new_table;
>      s->refcount_table_size =3D table_size;
>      s->refcount_table_offset =3D table_offset;
> +    update_max_refcount_table_index(s);
> =20
>      /* Free old table. */
>      qcow2_free_clusters(bs, old_table_offset, old_table_size * sizeof(=
uint64_t),
> @@ -2171,6 +2184,7 @@ write_refblocks:
>      s->refcount_table =3D on_disk_reftable;
>      s->refcount_table_offset =3D reftable_offset;
>      s->refcount_table_size =3D reftable_size;
> +    update_max_refcount_table_index(s);
> =20
>      return 0;
> =20
> @@ -2383,7 +2397,11 @@ int qcow2_check_metadata_overlap(BlockDriverStat=
e *bs, int ign, int64_t offset,
>      }
> =20
>      if ((chk & QCOW2_OL_REFCOUNT_BLOCK) && s->refcount_table) {
> -        for (i =3D 0; i < s->refcount_table_size; i++) {
> +        unsigned last_entry =3D s->max_refcount_table_index;
> +        assert(last_entry < s->refcount_table_size);
> +        assert(last_entry + 1 =3D=3D s->refcount_table_size ||
> +               (s->refcount_table[last_entry + 1] & REFT_OFFSET_MASK) =
=3D=3D 0);

I'm not sure we need this second assertion, but I don't mind it too much
either.

I'd actually find an assertion that last_entry is less than UNSIGNED_MAX
more important because otherwise the loop below would be an endless one. =
:-)

(Yes, it's pretty obvious that it's less than UNSIGNED_MAX because it's
less than s->refcount_table_size, which is an unsigned int. I'm just
trying to say something while I'm not sure exactly what I'm trying to
say. Sorry.)

Max

> +        for (i =3D 0; i <=3D last_entry; i++) {
>              if ((s->refcount_table[i] & REFT_OFFSET_MASK) &&
>                  overlaps_with(s->refcount_table[i] & REFT_OFFSET_MASK,=

>                  s->cluster_size)) {
> @@ -2871,6 +2889,7 @@ int qcow2_change_refcount_order(BlockDriverState =
*bs, int refcount_order,
>      /* Now update the rest of the in-memory information */
>      old_reftable =3D s->refcount_table;
>      s->refcount_table =3D new_reftable;
> +    update_max_refcount_table_index(s);
> =20
>      s->refcount_bits =3D 1 << refcount_order;
>      s->refcount_max =3D UINT64_C(1) << (s->refcount_bits - 1);


--qhHWX2hoj5XqEI0L01nDSjki6B9dwLgAc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRPewSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgaoIAJH8HHPCJsHm0FIwDjykDw0jCmZj18fE
M7eu2d60jMZYEO+g8eCkjQyZB+ceHeM4fz4cngBYEOEJ8IUbHtNSJZMOhtEBg8B7
lr5Pe1gILG/BrFyNBd9+lqYA+OLl47QGVtlb87fbtKptE9+8QvqmysgfUn7dOzwJ
fpUcTOAh5/aXpXlgOmn+v4wdRo3+PeZW3sXjgcCHAKCa9t/unN17jcaR+IPEo/YG
3AfVbSmUHaRUT4kNJpvanyEjiG4Tm2nuknO5hfLiGKkDsrFCIzoH47TdVDn+swTg
Ewyj7x3ElP1Br8yNT0MoSYpdz2fgONum26k91jX4SYmWUHHbrx4KMzs=
=FNKo
-----END PGP SIGNATURE-----

--qhHWX2hoj5XqEI0L01nDSjki6B9dwLgAc--
