Received: from eggs.gnu.org ([2001:4830:134:3::10]:42002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBLv9-0003SL-Jc
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBLv3-0003Nv-Io
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:01:23 -0400
References: <20180423223337.82366-1-eblake@redhat.com>
	<20180423223337.82366-6-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5cb0271b-6b03-7520-cd3d-46deff0ee682@redhat.com>
Date: Wed, 25 Apr 2018 17:00:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180423223337.82366-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zPlYKkleP1ytjTa8InUNYmjQMWuO1ojjc"
Subject: Re: [Qemu-devel] [PATCH v5 5/5] qcow2: Avoid memory over-allocation
 on compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zPlYKkleP1ytjTa8InUNYmjQMWuO1ojjc
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com
Message-ID: <5cb0271b-6b03-7520-cd3d-46deff0ee682@redhat.com>
Subject: Re: [PATCH v5 5/5] qcow2: Avoid memory over-allocation on compressed
 images
References: <20180423223337.82366-1-eblake@redhat.com>
 <20180423223337.82366-6-eblake@redhat.com>
In-Reply-To: <20180423223337.82366-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-24 00:33, Eric Blake wrote:
> When reading a compressed image, we were allocating s->cluster_data
> to 32*cluster_size + 512 (possibly over 64 megabytes, for an image
> with 2M clusters).  Let's check out the history:
>=20
> Back when qcow2 was first written, we used s->cluster_data for
> everything, including copy_sectors() and encryption, where we want
> to operate on more than one cluster at once.  Obviously, at that
> point, the buffer had to be aligned for other users, even though
> compression itself doesn't require any alignment (the fact that
> the compressed data generally starts mid-sector means that aligning
> our buffer buys us nothing - either the protocol already supports
> byte-based access into whatever offset we want, or we are already
> using a bounce buffer to read a full sector, and copying into
> our destination no longer requires alignment).
>=20
> But commit 1b9f1491 (v1.1!) changed things to allocate parallel
> buffers on demand rather than sharing a single buffer, for encryption
> and COW, leaving compression as the final client of s->cluster_data.
> That use was still preserved, because if a single compressed cluster
> is read more than once, we reuse the cache instead of decompressing
> it a second time (someday, we may come up with better caching to
> avoid wasting repeated decompressions while still being more parallel,
> but that is a task for another patch; the XXX comment in
> qcow2_co_preadv for QCOW2_CLUSTER_COMPRESSED is telling).
>=20
> Much later, in commit de82815d (v2.2), we noticed that a 64M
> allocation is prone to failure, so we switched over to a graceful
> memory allocation error message.  Elsewhere in the code, we do
> g_malloc(2 * cluster_size) without ever checking for failure, but
> even 4M starts to be large enough that trying to be nice is worth
> the effort, so we want to keep that aspect.
>=20
> Then even later, in 3e4c7052 (2.11), we realized that allocating
> a large buffer up front for every qcow2 image is expensive, and
> switched to lazy allocation only for images that actually had
> compressed clusters.  But in the process, we never even bothered
> to check whether what we were allocating still made sense in its
> new context!
>=20
> So, it's time to cut back on the waste.  A compressed cluster
> written by qemu will NEVER occupy more than an uncompressed
> cluster, but based on mid-sector alignment, we may still need
> to read 1 cluster + 1 sector in order to recover enough bytes
> for the decompression.  But third-party producers of qcow2 may
> not be as smart, and gzip DOES document that because the
> compression stream adds metadata, and because of the pigeonhole
> principle, there are worst case scenarios where attempts to
> compress will actually inflate an image, by up to 0.015% (or 62
> sectors larger for an unfortunate 2M compression).

Hm?  2M * 0.00015 < 315 (bytes!), so where does that number come from?

>                                                     In fact,
> the qcow2 spec permits an all-ones sector count, plus a full
> sector containing the initial offset, for a maximum read of
> 2 full clusters; and thanks to the way decompression works,
> even though such a value is probably too large for the actual
> compressed data, it really doesn't matter if we read too much
> (gzip ignores slop, once it has decoded a full cluster).  So
> it's easier to just allocate cluster_data to be as large as we
> can ever possibly see; even if it still wastes up to 2M on any
> image created by qcow2, that's still an improvment of 60M less
> waste than pre-patch.

OK, so from the technical perspective it's irrelevant anyway, but I
suppose the number should still be fixed in the commit message.

Apart from that, the series looks good to me.

Max

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> ---
> v4: fix off-by-one in assertion and commit message [Berto]
> v3: tighten allocation [Berto]
> v2: actually check allocation failure (previous version meant
> to use g_malloc, but ended up posted with g_try_malloc without
> checking); add assertions outside of conditional, improve
> commit message to better match reality now that qcow2 spec bug
> has been fixed
> ---
>  block/qcow2-cluster.c | 27 ++++++++++++++++++---------
>  block/qcow2.c         |  2 +-
>  2 files changed, 19 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 1dc00ff2110..6e3eb88a37a 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1599,20 +1599,29 @@ int qcow2_decompress_cluster(BlockDriverState *=
bs, uint64_t cluster_offset)
>          sector_offset =3D coffset & 511;
>          csize =3D nb_csectors * 512 - sector_offset;
>=20
> -        /* Allocate buffers on first decompress operation, most images=
 are
> -         * uncompressed and the memory overhead can be avoided.  The b=
uffers
> -         * are freed in .bdrv_close().
> +        /* Allocate buffers on the first decompress operation; most
> +         * images are uncompressed and the memory overhead can be
> +         * avoided.  The buffers are freed in .bdrv_close().  qemu
> +         * never writes an inflated cluster, and gzip itself never
> +         * inflates a problematic cluster by more than 0.015%, but the=

> +         * qcow2 format allows up to 1 byte short of 2 full clusters
> +         * when including the sector containing offset.  gzip ignores
> +         * trailing slop, so just allocate that much up front rather
> +         * than reject third-party images with overlarge csize.
>           */
> +        assert(!!s->cluster_data =3D=3D !!s->cluster_cache);
> +        assert(csize <=3D 2 * s->cluster_size);
>          if (!s->cluster_data) {
> -            /* one more sector for decompressed data alignment */
> -            s->cluster_data =3D qemu_try_blockalign(bs->file->bs,
> -                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
> +            s->cluster_data =3D g_try_malloc(2 * s->cluster_size);
>              if (!s->cluster_data) {
>                  return -ENOMEM;
>              }
> -        }
> -        if (!s->cluster_cache) {
> -            s->cluster_cache =3D g_malloc(s->cluster_size);
> +            s->cluster_cache =3D g_try_malloc(s->cluster_size);
> +            if (!s->cluster_cache) {
> +                g_free(s->cluster_data);
> +                s->cluster_data =3D NULL;
> +                return -ENOMEM;
> +            }
>          }
>=20
>          BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
> diff --git a/block/qcow2.c b/block/qcow2.c
> index ef68772acad..a8301371ccc 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2151,7 +2151,7 @@ static void qcow2_close(BlockDriverState *bs)
>      g_free(s->image_backing_format);
>=20
>      g_free(s->cluster_cache);
> -    qemu_vfree(s->cluster_data);
> +    g_free(s->cluster_data);
>      qcow2_refcount_close(bs);
>      qcow2_free_snapshots(bs);
>  }
>=20



--zPlYKkleP1ytjTa8InUNYmjQMWuO1ojjc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrgmCUACgkQ9AfbAGHV
z0DnKggAs0qK2XkuiwfjZHgTeK3uy3/qeEavubFsPYbsCJkv61khyJdwB6izIBjZ
tt7oXFr2y/1xmiUojDXLScnI5oPsvbxb+X4F+/KdfeSbJkzxLJysOMQxeCD4Hu92
kr7mlgRT0S/3o83M+xMNPAaGnb6aIfC8R/Qa2f71g7Y6fujuNPLOEgVMGvccpHJO
zfHMc2l2IlchKlUeHLwaC7WyeRLH/zX9hEJ1h9yvRYQwLT7tVSu+q3mbohkcgdM2
9C68j295osfRVB06rdjo+zJ85xtWFNqdXx6F5s+Qup01gOO63Fp3tJoVSCjfEIRy
T4zItrNiu8av0z44fjJHAkDxx4BiCQ==
=4Kru
-----END PGP SIGNATURE-----

--zPlYKkleP1ytjTa8InUNYmjQMWuO1ojjc--
