Received: from eggs.gnu.org ([2001:4830:134:3::10]:52543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTqgY-0000EB-Ju
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTqgS-00012q-45
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:30:46 -0400
Date: Fri, 15 Jun 2018 16:30:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180615153033.GE12972@stefanha-x1.localdomain>
References: <20180608060417.10170-1-famz@redhat.com>
	<20180608060417.10170-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Content-Disposition: inline
In-Reply-To: <20180608060417.10170-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] block: Add backing passthrough
 implementations for copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 08, 2018 at 02:04:16PM +0800, Fam Zheng wrote:
> +int coroutine_fn bdrv_co_copy_range_from_backing(BlockDriverState *bs,
> +                                                 BdrvChild *src, uint64_t src_offset,
> +                                                 BdrvChild *dst, uint64_t dst_offset,
> +                                                 uint64_t bytes, BdrvRequestFlags flags)
> +{
> +    if (!src->bs) {
> +        return -ENOMEDIUM;
> +    }
> +    return bdrv_co_copy_range_from(src->bs->backing, src_offset, dst,
> +                                   dst_offset, bytes, flags);
> +}
> +
> +int coroutine_fn bdrv_co_copy_range_to_backing(BlockDriverState *bs,
> +                                               BdrvChild *src, uint64_t src_offset,
> +                                               BdrvChild *dst, uint64_t dst_offset,
> +                                               uint64_t bytes, BdrvRequestFlags flags)
> +{
> +    if (!dst->bs) {
> +        return -ENOMEDIUM;
> +    }
> +    return bdrv_co_copy_range_to(src, src_offset, dst->bs->backing,
> +                                 dst_offset, bytes, flags);
> +}

If src->bs or dst->bs were NULL, then bdrv_co_copy_range() would have
already crashed in bdrv_inc_in_flight(src/dst_bs).  Should
.bdrv_co_copy_range_to/from() implementations really check for
ENOMEDIUM?

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbI9uZAAoJEJykq7OBq3PIiUYIAIyp2/q4Kl7Z5xYEA+CeOo9A
ABx4KqWFPvi4pY8LnGaZrVA6NoVyjLBEZSmou8OzU7hTuky34QzZm6GOZvxOcrFC
CuqLBUmh6j/M87+hiDVyTZYxpQ0fyvXwU+PNe2owUTLbwpjKOsxLl4wqWtMplnkt
xu4aWJEmjHJoHXjjYkLsQCmmtglnCufcqtNsPxWowz5p33wnBjiJc8fGNpuS3bf0
zny3n4QzsdsjJS1NW7jSZkG80ZT9Ag/85yb1O6jdGHTowNUiUHa+OOhJ7YEFjRLZ
1ktPL8UaJR71YeU67+cwpj3jTdSdXO0WG1YaSRcwO9VL3fN6vtSklxLl8tugfJY=
=B+K8
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
