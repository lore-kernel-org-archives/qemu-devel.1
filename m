Received: from eggs.gnu.org ([2001:4830:134:3::10]:39070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6dMi-00086a-Hp
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6dMa-0007zo-7E
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:33:44 -0400
Date: Fri, 5 May 2017 14:33:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505133336.GG11350@stefanha-x1.localdomain>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
	<1493280397-9622-4-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <1493280397-9622-4-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/7] dmg: Refactor and prepare
 dmg_read_chunk() to cache random access points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, famz@redhat.com, peter@lekensteyn.nl, qemu-devel@nongnu.org, qemu-block@nongnu.org


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 01:36:33PM +0530, Ashijeet Acharya wrote:
> Refactor dmg_read_chunk() to start making use of the new DMGReadState
> structure and do chunk and sector related calculations based on it.
> Add a new argument "DMGReadState *drs" to it.
>=20
> Also, rename DMG_SECTORCOUNTS_MAX to DMG_SECTOR_MAX to avoid indentaion
> problems at some places inside dmg_read_chunk()
>=20
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> ---
>  block/dmg.c | 159 +++++++++++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 94 insertions(+), 65 deletions(-)

This patch makes dmg_read_chunk() reread the chunk even if it has
already been read into s->uncompressed_chunk.  This is inefficient.  If
this is necessary for some reason then the commit description should
include a justification.

> diff --git a/block/dmg.c b/block/dmg.c
> index c6fe8b0..32623e2 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -38,7 +38,7 @@ enum {
>       * or truncating when converting to 32-bit types
>       */
>      DMG_LENGTHS_MAX =3D 64 * 1024 * 1024, /* 64 MB */
> -    DMG_SECTORCOUNTS_MAX =3D DMG_LENGTHS_MAX / 512,
> +    DMG_SECTOR_MAX =3D DMG_LENGTHS_MAX / 512,
>  };
> =20
>  static int dmg_probe(const uint8_t *buf, int buf_size, const char *filen=
ame)
> @@ -260,10 +260,10 @@ static int dmg_read_mish_block(BDRVDMGState *s, Dmg=
HeaderState *ds,
> =20
>          /* all-zeroes sector (type 2) does not need to be "uncompressed"=
 and can
>           * therefore be unbounded. */
> -        if (s->types[i] !=3D 2 && s->sectorcounts[i] > DMG_SECTORCOUNTS_=
MAX) {
> +        if (s->types[i] !=3D 2 && s->sectorcounts[i] > DMG_SECTOR_MAX) {
>              error_report("sector count %" PRIu64 " for chunk %" PRIu32
>                           " is larger than max (%u)",
> -                         s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
> +                         s->sectorcounts[i], i, DMG_SECTOR_MAX);
>              ret =3D -EINVAL;
>              goto fail;
>          }
> @@ -578,78 +578,106 @@ static inline uint32_t search_chunk(BDRVDMGState *=
s, uint64_t sector_num)
>      return s->n_chunks; /* error */
>  }
> =20
> -static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_n=
um)
> +static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_n=
um,
> +                                 DMGReadState *drs)
>  {
>      BDRVDMGState *s =3D bs->opaque;
> =20
> +    int ret;
> +    uint32_t sector_offset;
> +    uint64_t sectors_read;
> +    uint32_t chunk;
> +
>      if (!is_sector_in_chunk(s, s->current_chunk, sector_num)) {
> -        int ret;
> -        uint32_t chunk =3D search_chunk(s, sector_num);
> +        chunk =3D search_chunk(s, sector_num);
> +    } else {
> +        chunk =3D drs->saved_chunk_type;

chunk is an index into s->sectors[] and s->sectorcounts[].  It is not a
chunk type, so drs->saved_chunk_type is an odd name for this new field.

But now this makes me wonder - how is s->current_chunk different from
drs->saved_chunk_type?

> +    }
> =20
> -        if (chunk >=3D s->n_chunks) {
> +    if (chunk >=3D s->n_chunks) {
> +            return -1;
> +    }
> +
> +    /* reset our access point cache if we had a change in current chunk =
*/
> +    if (chunk !=3D drs->saved_chunk_type) {
> +        cache_access_point(drs, NULL, -1, -1, -1, -1);
> +    }
> +

The results of the computation from here...

> +    sector_offset =3D sector_num - s->sectors[chunk];
> +
> +    if ((s->sectorcounts[chunk] - sector_offset) > DMG_SECTOR_MAX) {
> +        sectors_read =3D DMG_SECTOR_MAX;
> +    } else {
> +        sectors_read =3D s->sectorcounts[chunk] - sector_offset;
> +    }
> +
> +    /* truncate sectors read if it exceeds the 2MB buffer of qemu-img
> +     * convert */
> +    if ((sector_num % DMG_SECTOR_MAX) + sectors_read > DMG_SECTOR_MAX) {
> +        sectors_read =3D DMG_SECTOR_MAX - (sector_num % DMG_SECTOR_MAX);
> +    }

=2E..to here are never used.  Please remove the unused code and variables
=66rom this patch.  It may be necessary to add them back in a later patch
(I haven't looked ahead), but each patch must be self-contained and make
sense without foreknowledge of future patches.

> +
> +    s->current_chunk =3D s->n_chunks;
> +
> +    switch (s->types[chunk]) { /* block entry type */
> +    case 0x80000005: { /* zlib compressed */
> +        /* we need to buffer, because only the chunk as whole can be
> +         * inflated. */
> +        ret =3D bdrv_pread(bs->file, s->offsets[chunk],
> +                         s->compressed_chunk, s->lengths[chunk]);
> +        if (ret !=3D s->lengths[chunk]) {
>              return -1;
>          }
> =20
> -        s->current_chunk =3D s->n_chunks;
> -        switch (s->types[chunk]) { /* block entry type */
> -        case 0x80000005: { /* zlib compressed */
> -            /* we need to buffer, because only the chunk as whole can be
> -             * inflated. */
> -            ret =3D bdrv_pread(bs->file, s->offsets[chunk],
> -                             s->compressed_chunk, s->lengths[chunk]);
> -            if (ret !=3D s->lengths[chunk]) {
> -                return -1;
> -            }
> -
> -            s->zstream.next_in =3D s->compressed_chunk;
> -            s->zstream.avail_in =3D s->lengths[chunk];
> -            s->zstream.next_out =3D s->uncompressed_chunk;
> -            s->zstream.avail_out =3D 512 * s->sectorcounts[chunk];
> -            ret =3D inflateReset(&s->zstream);
> -            if (ret !=3D Z_OK) {
> -                return -1;
> -            }
> -            ret =3D inflate(&s->zstream, Z_FINISH);
> -            if (ret !=3D Z_STREAM_END ||
> -                s->zstream.total_out !=3D 512 * s->sectorcounts[chunk]) {
> -                return -1;
> -            }
> -            break; }
> -        case 0x80000006: /* bzip2 compressed */
> -            if (!dmg_uncompress_bz2) {
> -                break;
> -            }
> -            /* we need to buffer, because only the chunk as whole can be
> -             * inflated. */
> -            ret =3D bdrv_pread(bs->file, s->offsets[chunk],
> -                             s->compressed_chunk, s->lengths[chunk]);
> -            if (ret !=3D s->lengths[chunk]) {
> -                return -1;
> -            }
> -
> -            ret =3D dmg_uncompress_bz2((char *)s->compressed_chunk,
> -                                     (unsigned int) s->lengths[chunk],
> -                                     (char *)s->uncompressed_chunk,
> -                                     (unsigned int)
> -                                         (512 * s->sectorcounts[chunk]));
> -            if (ret < 0) {
> -                return ret;
> -            }
> -            break;
> -        case 1: /* copy */
> -            ret =3D bdrv_pread(bs->file, s->offsets[chunk],
> -                             s->uncompressed_chunk, s->lengths[chunk]);
> -            if (ret !=3D s->lengths[chunk]) {
> -                return -1;
> -            }
> -            break;
> -        case 2: /* zero */
> -            /* see dmg_read, it is treated specially. No buffer needs to=
 be
> -             * pre-filled, the zeroes can be set directly. */
> +        s->zstream.next_in =3D s->compressed_chunk;
> +        s->zstream.avail_in =3D s->lengths[chunk];
> +        s->zstream.next_out =3D s->uncompressed_chunk;
> +        s->zstream.avail_out =3D 512 * s->sectorcounts[chunk];
> +        ret =3D inflateReset(&s->zstream);
> +        if (ret !=3D Z_OK) {
> +            return -1;
> +        }
> +        ret =3D inflate(&s->zstream, Z_FINISH);
> +        if (ret !=3D Z_STREAM_END ||
> +            s->zstream.total_out !=3D 512 * s->sectorcounts[chunk]) {
> +            return -1;
> +        }
> +        break; }
> +    case 0x80000006: /* bzip2 compressed */
> +        if (!dmg_uncompress_bz2) {
>              break;
>          }
> -        s->current_chunk =3D chunk;
> +        /* we need to buffer, because only the chunk as whole can be
> +         * inflated. */
> +        ret =3D bdrv_pread(bs->file, s->offsets[chunk],
> +                         s->compressed_chunk, s->lengths[chunk]);
> +        if (ret !=3D s->lengths[chunk]) {
> +            return -1;
> +        }
> +
> +        ret =3D dmg_uncompress_bz2((char *)s->compressed_chunk,
> +                                 (unsigned int) s->lengths[chunk],
> +                                 (char *)s->uncompressed_chunk,
> +                                 (unsigned int)
> +                                    (512 * s->sectorcounts[chunk]));
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        break;
> +    case 1: /* copy */
> +        ret =3D bdrv_pread(bs->file, s->offsets[chunk],
> +                         s->uncompressed_chunk, s->lengths[chunk]);
> +        if (ret !=3D s->lengths[chunk]) {
> +            return -1;
> +        }
> +        break;
> +    case 2: /* zero */
> +        /* see dmg_read, it is treated specially. No buffer needs to be
> +         * pre-filled, the zeroes can be set directly. */
> +        break;
>      }
> +    s->current_chunk =3D chunk;
> +
>      return 0;
>  }
> =20
> @@ -661,6 +689,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, =
uint64_t bytes,
>      uint64_t sector_num =3D offset >> BDRV_SECTOR_BITS;
>      int nb_sectors =3D bytes >> BDRV_SECTOR_BITS;
>      int ret, i;
> +    DMGReadState *drs =3D s->drs;
> =20
>      assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
>      assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> @@ -671,7 +700,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, =
uint64_t bytes,
>          uint32_t sector_offset_in_chunk;
>          void *data;
> =20
> -        if (dmg_read_chunk(bs, sector_num + i) !=3D 0) {
> +        if (dmg_read_chunk(bs, sector_num + i, drs) !=3D 0) {
>              ret =3D -EIO;
>              goto fail;
>          }
> --=20
> 2.6.2
>=20

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDH8wAAoJEJykq7OBq3PIYFkIAL3MtexSYdFe4jfkFQBY/kRZ
nGzpcXDYSz9Kwqko0YLc6mvKO4/qQPTXPxrmc3wHytKreYA1NRB9NXzpyKb2g6cA
IB+C5xfn5sGC9I5KVT2eBjLFkrs8p7S/sSABF6qe8a7CTc+uuIOs6rTeMrZdekGS
ukiWFElh33omfCSsE5v9S0s3ABcpZ8zah1TEefvzK+1aIFVniJCAXimVPtul1OFy
2eWPv9y2IciA74QasJF4hz0DzAVSlm0619UefOt13nJ+3lyct9W+GTIKUIESLrlU
DEN8Ga1FeOg43PBxsDJ0mUUPmWumZDqjKTzG49bnaTmP6wICsGpAIyhYPskqEwM=
=2Gu/
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
