Received: from eggs.gnu.org ([2001:4830:134:3::10]:60599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Xa6-0002EZ-9w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Xa1-0001E8-GL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:36:25 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <baaab5d2-76f0-6f5c-c0f1-e1e06a239d40@redhat.com>
Date: Mon, 8 Oct 2018 17:31:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180817122219.16206-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="THj8V21VVhNonVzp0FrPTRzzWW4x0CpgQ"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] block/qcow2-refcount: avoid eating
 RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--THj8V21VVhNonVzp0FrPTRzzWW4x0CpgQ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <baaab5d2-76f0-6f5c-c0f1-e1e06a239d40@redhat.com>
Subject: Re: [PATCH v2 2/7] block/qcow2-refcount: avoid eating RAM
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
> qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat
> an unpredictable amount of memory on corrupted table entries, which are=

> referencing regions far beyond the end of file.
>=20
> Prevent this, by skipping such regions from further processing.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 615847eb09..566c19fbfa 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1499,12 +1499,26 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *=
bs, BdrvCheckResult *res,
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t start, last, cluster_offset, k, refcount;
> +    int64_t file_len;
>      int ret;
> =20
>      if (size <=3D 0) {
>          return 0;
>      }
> =20
> +    file_len =3D bdrv_getlength(bs->file->bs);
> +    if (file_len < 0) {
> +        return file_len;
> +    }

Doesn't this slow things down?  Can we not cache the length somewhere
and update it whenever the image is modified?

> +
> +    if (offset + size - file_len > s->cluster_size) {
> +        fprintf(stderr, "ERROR: counting reference for region exceedin=
g the "
> +                "end of the file by more than one cluster: offset 0x%"=
 PRIx64
> +                " size 0x%" PRIx64 "\n", offset, size);

Why is one cluster OK?  Is there a specific case you're trying to catch
here?

Max

> +        res->corruptions++;
> +        return 0;
> +    }
> +
>      start =3D start_of_cluster(s, offset);
>      last =3D start_of_cluster(s, offset + size - 1);
>      for(cluster_offset =3D start; cluster_offset <=3D last;
>=20



--THj8V21VVhNonVzp0FrPTRzzWW4x0CpgQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7eDgACgkQ9AfbAGHV
z0CB2wf/f/ckHo3S3nma9pDlM6X+msQEz4MVWI42kQfHkrQAqXy82f3A20iiS7MM
0mv/f1+ctKtG9QAYjJvTaiAh1wlg6hH702BSklLxwnOKoSP0Rhdcwli6oUBSCpcv
dh537oyLwhhphGYVZN857uGmieWng+KDtZQflqGhQRqwFdEe/N1LQ5IdRV1e8Elc
L0cck1TZh7Tl8Oe6tE3g2rUEuBjI465gSElzpdADanF+ucskcfwyL9dwEj9ENtZi
mrcH23I0Ziek2MggZf10+vRSL5Pt+zT+F0wNRZj/mf7Mvh6R26NzJKhOI+wlVedW
33CNoF+udyasXNdr7eDDT6h9LjeYZA==
=93H0
-----END PGP SIGNATURE-----

--THj8V21VVhNonVzp0FrPTRzzWW4x0CpgQ--
