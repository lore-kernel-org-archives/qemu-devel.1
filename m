Received: from eggs.gnu.org ([2001:4830:134:3::10]:50047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coJn2-0000Hy-DR
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coJmx-0002jH-HF
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1coJmx-0002j4-7n
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 21:01:11 -0400
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-2-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5251b9a6-9e00-d11e-ac23-304accfda59a@redhat.com>
Date: Thu, 16 Mar 2017 02:01:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170315092940.1367-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SxClGKtt8etFp17G2LWqaJE6L9WdSwP1K"
Subject: Re: [Qemu-devel] [RFC v2 1/8] block: add bdrv_measure() API
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
--SxClGKtt8etFp17G2LWqaJE6L9WdSwP1K
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <5251b9a6-9e00-d11e-ac23-304accfda59a@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/8] block: add bdrv_measure() API
References: <20170315092940.1367-1-stefanha@redhat.com>
 <20170315092940.1367-2-stefanha@redhat.com>
In-Reply-To: <20170315092940.1367-2-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.03.2017 10:29, Stefan Hajnoczi wrote:
> bdrv_measure() provides a conservative maximum for the size of a new
> image.  This information is handy if storage needs to be allocated (e.g=
=2E
> a SAN or an LVM volume) ahead of time.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json      | 19 +++++++++++++++++++
>  include/block/block.h     |  4 ++++
>  include/block/block_int.h |  2 ++
>  block.c                   | 33 +++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 786b39e..673569d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -463,6 +463,25 @@
>             '*dirty-bitmaps': ['BlockDirtyInfo'] } }
> =20
>  ##
> +# @BlockMeasureInfo:
> +#
> +# Image size calculation information.  This structure describes the si=
ze
> +# requirements for creating a new image.
> +#
> +# @required-bytes: Amount of space required for image creation.  This =
value is
> +#                  the host file size including sparse file regions.  =
A new 5
> +#                  GB raw file therefore has a required size of 5 GB, =
not 0
> +#                  bytes.

This should probably note that it's a conservative estimation (and I
agree that it should be). It's nice to have it in the commit message but
few people are going to run git blame on the QAPI documentation to find
out the rest of its story. :-)

> +#
> +# @fully-allocated-bytes: Space required once data has been written to=
 all
> +#                         sectors
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'BlockMeasureInfo',
> +  'data': {'required-bytes': 'int', 'fully-allocated-bytes': 'int'} }
> +
> +##
>  # @query-block:
>  #
>  # Get a list of BlockInfo for all virtual block devices.
> diff --git a/include/block/block.h b/include/block/block.h
> index 5149260..43c789f 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -298,6 +298,10 @@ int bdrv_truncate(BdrvChild *child, int64_t offset=
);
>  int64_t bdrv_nb_sectors(BlockDriverState *bs);
>  int64_t bdrv_getlength(BlockDriverState *bs);
>  int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
> +void bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> +                  BlockDriverState *in_bs,
> +                  BlockMeasureInfo *info,
> +                  Error **errp);
>  void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)=
;
>  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
>  int bdrv_commit(BlockDriverState *bs);
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 6c699ac..45a7fbe 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -201,6 +201,8 @@ struct BlockDriver {
>      int64_t (*bdrv_getlength)(BlockDriverState *bs);
>      bool has_variable_length;
>      int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
> +    void (*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
> +                         BlockMeasureInfo *info, Error **errp);
> =20
>      int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *b=
s,
>          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
> diff --git a/block.c b/block.c
> index cb57370..532a4d1 100644
> --- a/block.c
> +++ b/block.c
> @@ -3260,6 +3260,39 @@ int64_t bdrv_get_allocated_file_size(BlockDriver=
State *bs)
>      return -ENOTSUP;
>  }
> =20
> +/*
> + * bdrv_measure:
> + * @drv: Format driver
> + * @opts: Creation options
> + * @in_bs: Existing image containing data for new image (may be NULL)
> + * @info: Result object
> + * @errp: Error object
> + *
> + * Calculate file size required to create a new image.
> + *
> + * If @in_bs is given then space for allocated clusters and zero clust=
ers
> + * from that image are included in the calculation.  If @opts contains=
 a
> + * backing file that is shared by @in_bs then backing clusters are omi=
tted
> + * from the calculation.

This seems to run a bit contrary to the documentation of
BlockMeasureInfo.required-bytes, and I don't fully understand it either.

What does "space for zero clusters" mean? Do zero clusters take space?
Does it depend on the image format? (i.e. would they take space for raw
but not for qcow2?)

And is space for unallocated clusters included or not? Do unallocated
clusters without a backing image count as zero clusters?

If that space is not included, then it would run contrary to the QAPI
documentation which states that it should be included.

Finally, how are you supposed to check whether the backing file in @opts
is shared by @in_bs?

> + *
> + * If @in_bs is NULL then the calculation includes no allocated cluste=
rs
> + * unless a preallocation option is given in @opts.

But the BlockMeasureInfo.required-bytes documentation states that a new
5 GB raw image should still report 5 GB of required space.

Max

> + *
> + * Note that @in_bs may use a different BlockDriver from @drv.
> + */
> +void bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> +                  BlockDriverState *in_bs, BlockMeasureInfo *info,
> +                  Error **errp)
> +{
> +    if (!drv->bdrv_measure) {
> +        error_setg(errp, "Block driver '%s' does not support size meas=
urement",
> +                   drv->format_name);
> +        return;
> +    }
> +
> +    drv->bdrv_measure(opts, in_bs, info, errp);
> +}
> +
>  /**
>   * Return number of sectors on success, -errno on error.
>   */
>=20



--SxClGKtt8etFp17G2LWqaJE6L9WdSwP1K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljJ488SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aq+QIALRHosYCh5bYZ5X4N5jjjYAS85rd/V7S
FgYHcP02ll86xh2HzId6C892Z0AtKOHIBsNqM0aTeJYTztARQhylEJLnkY0+r4Ih
bE1vbycWQ2tooc+iPDT87O5BVE2iBWoDV+f1jK9RsvQJmaTMID1I95o3eSU6RTVr
vl84BTPOYxDc0GQcgV4ZpiyN87EuqSfs6zW7Tk79qoMxMPV14QncrEC2gnLtarXw
mLWXY6QPFeo1Yk2CzVVmznaiNKrwBRd7yBDNm0o9vOe7kscjPuW/Cfx/nbSWXCeV
bbwO+/JPpM8UY80r5BSX4sd2YqldPNsJfrS1eaaUrbPJ47l6tGAai8Y=
=9JjK
-----END PGP SIGNATURE-----

--SxClGKtt8etFp17G2LWqaJE6L9WdSwP1K--
