Received: from eggs.gnu.org ([2001:4830:134:3::10]:36336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhBJ-0002BO-MO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhBI-0003mf-Rw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:44:09 -0400
Date: Thu, 10 May 2018 09:44:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510084401.GE1296@stefanha-x1.localdomain>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <20180509145815.3330-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/9] block: Introduce API for copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2018 at 10:58:07PM +0800, Fam Zheng wrote:

Please include a commit description:

  Introduce the bdrv_co_copy_range() API for copy offloading.  Block
  drivers implementing this API support efficient copy operations that
  avoid reading each block from the source device and writing it to the
  destination devices.  Examples of copy offload primitives are SCSI
  EXTENDED COPY and Linux copy_file_range(2).

This explains the purpose of the new API.

> +/* Copy range from @bs to @dst. */

There is no @bs argument, I guess it should be @src.

What about the return value?

What about the flags?

You don't need to duplicate this information, just reference
BlockDriver.bdrv_co_copy_range_from() if you want.

> +int bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
> +                            BdrvChild *dst, uint64_t dst_offset,
> +                            uint64_t bytes, BdrvRequestFlags flags)
> +{
> +    return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
> +                                       bytes, flags, true);
> +}
> +
> +/* Copy range from @src to @bs. Should only be called by block drivers when @bs
> + * is the leaf. */

Same here.

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

This is the public API.  It's missing a doc comment.

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9AZRAAoJEJykq7OBq3PICvUIAIsk1scfMfxl9vAIN2bZzb8V
fRQK/q5Tw89bvQo+kJgkOyR80N7YaghRGAUDZucKfKBGz5hh7UYtp8XLQdtwH4fG
PzgRHTvRQNMIt9Lmc2VigS9UZ8rJgWOVknN0C03bzHwaer6QzGpYqsvobGL3BnHn
eXoDqSeE0G47veMhSkNeW7hO/0UEs2Lwk8HnVl+sgDWr+HWI2xyEDk7lwfF89w+t
RnuZb64okFFVzKwPMsS+M8VXolqvSfPjHOEB9K+dKF+FUQm4292bLRAohIpe0gOn
d+Y2rYxXUaolkWJiNwbYGJQPaGzyH65+btNqindM3cxM0HSdilaCjp+fUrV13ws=
=EE/p
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
