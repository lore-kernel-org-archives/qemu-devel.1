Received: from eggs.gnu.org ([2001:4830:134:3::10]:44880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBiKd-00041V-Vr
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBiKY-0002Xi-2R
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:57:12 -0400
Date: Thu, 26 Apr 2018 15:57:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180426145702.GG30991@stefanha-x1.localdomain>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <20180418030424.28980-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH v2 1/7] block: Introduce
 API for copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 18, 2018 at 11:04:18AM +0800, Fam Zheng wrote:
> diff --git a/block/io.c b/block/io.c
> index bd9a19a9c4..d274e9525f 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2826,3 +2826,94 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
>          bdrv_unregister_buf(child->bs, host);
>      }
>  }
> +
> +static int bdrv_co_copy_range_internal(BdrvChild *src,

Please remember to use coroutine_fn for coroutines!  This applies to the
other functions in this patch too.

> +int bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
> +                       BdrvChild *dst, uint64_t dst_offset,
> +                       uint64_t bytes, BdrvRequestFlags flags)
> +{
> +    BdrvTrackedRequest src_req, dst_req;
> +    BlockDriverState *src_bs = src->bs;
> +    BlockDriverState *dst_bs = dst->bs;
> +    int ret;
> +
> +    bdrv_inc_in_flight(src_bs);
> +    bdrv_inc_in_flight(dst_bs);
> +    tracked_request_begin(&src_req, src_bs, src_offset,
> +                          bytes, BDRV_TRACKED_READ);
> +    tracked_request_begin(&dst_req, dst_bs, dst_offset,
> +                          bytes, BDRV_TRACKED_WRITE);

Tracked requests and in-flight counters are only updated on root nodes.
This is not how read/write works.  Does drain work on an internal or
leaf node with multiple parents?

> diff --git a/include/block/block.h b/include/block/block.h
> index cdec3639a3..72ac011b2b 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -604,4 +604,8 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
>   */
>  void bdrv_register_buf(BlockDriverState *bs, void *host, size_t size);
>  void bdrv_unregister_buf(BlockDriverState *bs, void *host);
> +
> +int bdrv_co_copy_range(BdrvChild *bs, uint64_t offset,
> +                       BdrvChild *src, uint64_t src_offset,
> +                       uint64_t bytes, BdrvRequestFlags flags);

Please document this new block.h API.

These arguments are in the wrong order!  The first BdrvChild is the
source and the second is the destination.

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4ei+AAoJEJykq7OBq3PI9dgIAJf9JUsDYQjvA7k8vBQqoG46
UI1Mm694dpordouHLZQDjXy4hbG1T9E0f9BlG1OLCjaowGHBylvDzpqA9yoTs6us
Zf7wrUFiGgP1M+fKFyWIjZ2V1uKBPMfgLcMW4R9M3wCjOSccFcA0ze0dZ8l9/0wL
gKz060XVAL9MoLIkaZGCABNz+1oIonxtTHjRmRjWC1ZJG5vbJXzbzq3gs/R4NFKM
blaAaR/4XcsNOaFSyIzp/zlvByIulK8S6F2IPkyXFEZTWB9e16RwE+wpxM72wdib
/jz4anJIAYr/36JWf/DI2wZgRnGnUWUes7nBVB+oJNkdKgPwMBcdg1vZgQHg6MM=
=cdRY
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
