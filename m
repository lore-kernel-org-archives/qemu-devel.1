Received: from eggs.gnu.org ([2001:4830:134:3::10]:52716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwKW-0003qA-EK
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQwKT-0001wf-C0
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:51:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dQwKT-0001wL-2X
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:51:25 -0400
References: <20170614153557.3319-1-stefanha@redhat.com>
	<20170614153557.3319-2-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b3a700eb-19fa-1e5f-48c0-dafba5bda07b@redhat.com>
Date: Fri, 30 Jun 2017 15:51:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170614153557.3319-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BJ4h6S7435pGpfSxvgiKVd5Rp7CJBwde7"
Subject: Re: [Qemu-devel] [PATCH v8 1/9] block: add bdrv_measure() API
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
--BJ4h6S7435pGpfSxvgiKVd5Rp7CJBwde7
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <b3a700eb-19fa-1e5f-48c0-dafba5bda07b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/9] block: add bdrv_measure() API
References: <20170614153557.3319-1-stefanha@redhat.com>
 <20170614153557.3319-2-stefanha@redhat.com>
In-Reply-To: <20170614153557.3319-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-14 17:35, Stefan Hajnoczi wrote:
> bdrv_measure() provides a conservative maximum for the size of a new
> image.  This information is handy if storage needs to be allocated (e.g=
=2E
> a SAN or an LVM volume) ahead of time.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
> v6:
>  * Change bdrv_measure() return type to BlockMeasureInfo * [Eric]
>  * Clarify that holes in sparse POSIX files are still counted [Eric]
> ---
>  qapi/block-core.json      | 25 +++++++++++++++++++++++++
>  include/block/block.h     |  2 ++
>  include/block/block_int.h |  2 ++
>  block.c                   | 35 +++++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+)

[...]

> diff --git a/block.c b/block.c
> index fa1d06d..056400a 100644
> --- a/block.c
> +++ b/block.c
> @@ -3446,6 +3446,41 @@ int64_t bdrv_get_allocated_file_size(BlockDriver=
State *bs)
>      return -ENOTSUP;
>  }
> =20
> +/*
> + * bdrv_measure:
> + * @drv: Format driver
> + * @opts: Creation options for new image
> + * @in_bs: Existing image containing data for new image (may be NULL)
> + * @errp: Error object
> + * Returns: A #BlockMeasureInfo (free using qapi_free_BlockMeasureInfo=
())
> + *          or NULL on error
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

Well, it's a bit weird that qcow2 just doesn't do this, then. :-)

I'm not really complaining (I think it's the best for qcow2 to ignore
this, at least for now), but maybe an s/are/may be/ would be more
appropriate...

(I wouldn't have complained if I hadn't replied to patch 7 anyway.)

Max

> + *
> + * If @in_bs is NULL then the calculation includes no allocated cluste=
rs
> + * unless a preallocation option is given in @opts.
> + *
> + * Note that @in_bs may use a different BlockDriver from @drv.
> + *
> + * If an error occurs the @errp pointer is set.
> + */
> +BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> +                               BlockDriverState *in_bs, Error **errp)
> +{
> +    if (!drv->bdrv_measure) {
> +        error_setg(errp, "Block driver '%s' does not support size meas=
urement",
> +                   drv->format_name);
> +        return NULL;
> +    }
> +
> +    return drv->bdrv_measure(opts, in_bs, errp);
> +}
> +
>  /**
>   * Return number of sectors on success, -errno on error.
>   */
>=20



--BJ4h6S7435pGpfSxvgiKVd5Rp7CJBwde7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVldOEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPn9
B/4lnEzrbIiuZtDfiPfwb5Uro+xRIPcNULis5ntgOAk0jGAdmb6U0Iov1srtjpCk
oefJKLy4PZNSkDzOO2lU3jPERXM8YqA+5hc4k9JKJfspX7+gGbN0oSI6NQiw04cu
ZsyQ30r5doO22QsDXSP/HbcreUa6mKecaTwjvjlxKhECwp1MeJViTkaBUv84geH4
YMEQ7hnhGw9rBiK/p1Suv/qgRPKjw1G94+qvMlWQeq6vnug6sayIR4eCzj7wvbus
L0yuZqgEZ91s95as/OCj3mWnLuYJCri04tduraj+ouoKFRevUR9Ac5rdHYCtkFPF
dFL/zXyPdKsrZholcL/xiOD8
=faNb
-----END PGP SIGNATURE-----

--BJ4h6S7435pGpfSxvgiKVd5Rp7CJBwde7--
