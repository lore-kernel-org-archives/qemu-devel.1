Received: from eggs.gnu.org ([2001:4830:134:3::10]:55796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7qAo-00039q-LZ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7qAl-0005JY-Hx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:26:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1d7qAl-0005JS-8F
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:26:27 -0400
References: <20170508141536.20690-1-stefanha@redhat.com>
	<20170508141536.20690-5-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8b49e6e9-043d-e628-3c49-1433ba0b5d5e@redhat.com>
Date: Mon, 8 May 2017 23:26:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170508141536.20690-5-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qwxRQaV7OWQA9vq7BRIQDkPPI2M5EhTjc"
Subject: Re: [Qemu-devel] [PATCH v6 4/9] qcow2: make refcount size
 calculation conservative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qwxRQaV7OWQA9vq7BRIQDkPPI2M5EhTjc
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <8b49e6e9-043d-e628-3c49-1433ba0b5d5e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/9] qcow2: make refcount size calculation
 conservative
References: <20170508141536.20690-1-stefanha@redhat.com>
 <20170508141536.20690-5-stefanha@redhat.com>
In-Reply-To: <20170508141536.20690-5-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2017 16:15, Stefan Hajnoczi wrote:
> The refcount metadata size calculation is inaccurate and can produce
> numbers that are too small.  This is bad because we should calculate a
> conservative number - one that is guaranteed to be large enough.
>=20
> This patch switches the approach to a fixed point calculation because
> the existing equation is hard to solve when inaccuracies are taken care=

> of.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 82 ++++++++++++++++++++++++++++++---------------------=
--------
>  1 file changed, 42 insertions(+), 40 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 5569b63..ff0d825 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2095,6 +2095,43 @@ static int preallocate(BlockDriverState *bs)
>      return 0;
>  }
> =20
> +/* qcow2_refcount_metadata_size:
> + * @clusters: number of clusters to refcount (including data and L1/L2=
 tables)
> + * @cluster_size: size of a cluster, in bytes
> + * @refcount_order: refcount bits power-of-2 exponent
> + *
> + * Returns: Number of bytes required for refcount blocks and table met=
adata.
> + */
> +static int64_t qcow2_refcount_metadata_size(int64_t clusters,
> +                                            size_t cluster_size,
> +                                            int refcount_order)
> +{
> +    /*
> +     * Every host cluster is reference-counted, including metadata (ev=
en
> +     * refcount metadata is recursively included).
> +     *
> +     * An accurate formula for the size of refcount metadata size is d=
ifficult
> +     * to derive.

Oh, by the way:

https://lists.nongnu.org/archive/html/qemu-devel/2014-04/msg04820.html

*cough* *cough*

(No, this is not the formula that was used for this preallocation.
Otherwise, it would have been correct. O:-))

Max

>                     An easier method of calculation is finding the fixe=
d point
> +     * where no further refcount blocks or table clusters are required=
 to
> +     * reference count every cluster.
> +     */
> +    int64_t blocks_per_table_cluster =3D cluster_size / sizeof(uint64_=
t);
> +    int64_t refcounts_per_block =3D cluster_size * 8 / (1 << refcount_=
order);
> +    int64_t table =3D 0;  /* number of refcount table clusters */
> +    int64_t blocks =3D 0; /* number of refcount block clusters */
> +    int64_t last;
> +    int64_t n =3D 0;
> +
> +    do {
> +        last =3D n;
> +        blocks =3D DIV_ROUND_UP(clusters + table + blocks, refcounts_p=
er_block);
> +        table =3D DIV_ROUND_UP(blocks, blocks_per_table_cluster);
> +        n =3D clusters + blocks + table;
> +    } while (n !=3D last);
> +
> +    return (blocks + table) * cluster_size;
> +}
> +
>  /**
>   * qcow2_calc_prealloc_size:
>   * @total_size: virtual disk size in bytes


--qwxRQaV7OWQA9vq7BRIQDkPPI2M5EhTjc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQ4noSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxaEIAImfaJI3rvZbbUSCzgABsqSDjlplcM3J
6yDazLAWxz67XwdxxBXenxxChjsjJpeotlCGmiPD4Z5xMsJqRLrgrwIQiynyEQ3/
wK+eSvBGaLAL7dtO6YJCWdcmiduoIBTzw47ofbDMeNspSlKVkmHw7c+k0eJnJwDt
15+94l8Qh8kHgwHVJvLza7it0G1TcX337ZDSEE2jiGyvohiWrkEhnvBb4Gi5DA/U
xiGU/+/lvVeWrGBSpoi/+7usvRcL0qjE+jmjjwaEIeh5huc+qGjfnhHJjiFqEGtr
XCDDw/7R6M13qTdfJD41/SrhgYpElp9HL6EWtNNJVXbkct3Rm8f+1II=
=Yr/q
-----END PGP SIGNATURE-----

--qwxRQaV7OWQA9vq7BRIQDkPPI2M5EhTjc--
