Received: from eggs.gnu.org ([209.51.188.92]:46657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6ii-0000QR-QU
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6ih-0000P9-78
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:25:48 -0500
References: <20190213225311.17876-1-mreitz@redhat.com>
	<20190213225311.17876-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <895b530e-a81a-f8de-3be5-12e30c6190b7@redhat.com>
Date: Wed, 13 Feb 2019 20:25:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190213225311.17876-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ThRTPUBnJo8qOga9V6ZJIYzwBMc0t6zrp"
Subject: Re: [Qemu-devel] [PATCH v3 03/12] block: Filtered children access
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ThRTPUBnJo8qOga9V6ZJIYzwBMc0t6zrp
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <895b530e-a81a-f8de-3be5-12e30c6190b7@redhat.com>
Subject: Re: [PATCH v3 03/12] block: Filtered children access functions
References: <20190213225311.17876-1-mreitz@redhat.com>
 <20190213225311.17876-4-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 4:53 PM, Max Reitz wrote:
> What bs->file and bs->backing mean depends on the node.  For filter
> nodes, both signify a node that will eventually receive all R/W
> accesses.  For format nodes, bs->file contains metadata and data, and
> bs->backing will not receive writes -- instead, writes are COWed to
> bs->file.  Usually.
>=20
> In any case, it is not trivial to guess what a child means exactly with=

> our currently limited form of expression.  It is better to introduce
> some functions that actually guarantee a meaning:
>=20
> - bdrv_filtered_cow_child() will return the child that receives request=
s
>   filtered through COW.  That is, reads may or may not be forwarded
>   (depending on the overlay's allocation status), but writes never go t=
o
>   this child.
>=20
> - bdrv_filtered_rw_child() will return the child that receives requests=

>   filtered through some very plain process.  Reads and writes issued to=

>   the parent will go to the child as well (although timing, etc. may be=

>   modified).
>=20
> - All drivers but quorum (but quorum is pretty opaque to the general
>   block layer anyway) always only have one of these children: All read
>   requests must be served from the filtered_rw_child (if it exists), so=

>   if there was a filtered_cow_child in addition, it would not receive
>   any requests at all.
>   (The closest here is mirror, where all requests are passed on to the
>   source, but with write-blocking, write requests are "COWed" to the
>   target.  But that just means that the target is a special child that
>   cannot be introspected by the generic block layer functions, and that=

>   source is a filtered_rw_child.)
>   Therefore, we can also add bdrv_filtered_child() which returns that
>   one child (or NULL, if there is no filtered child).
>=20
> Also, many places in the current block layer should be skipping filters=

> (all filters or just the ones added implicitly, it depends) when going
> through a block node chain.  They do not do that currently, but this
> patch makes them.
>=20
> One example for this is qemu-img map, which should skip filters and onl=
y
> look at the COW elements in the graph.  The change to iotest 204's
> reference output shows how using blkdebug on top of a COW node used to
> make qemu-img map disregard the rest of the backing chain, but with thi=
s
> patch, the allocation in the base image is reported correctly.
>=20
> Furthermore, a note should be made that sometimes we do want to access
> bs->backing directly.  This is whenever the operation in question is no=
t
> about accessing the COW child, but the "backing" child, be it COW or
> not.  This is the case in functions such as bdrv_open_backing_file() or=

> whenever we have to deal with the special behavior of @backing as a
> blockdev option, which is that it does not default to null like all
> other child references do.
>=20
> Finally, the query functions (query-block and query-named-block-nodes)
> are modified to return any filtered child under "backing", not just
> bs->backing or COW children.  This is so that filters do not interrupt
> the reported backing chain.  This changes the output of iotest 184, as
> the throttled node now appears as a backing child.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/qapi/block-core.json
> @@ -2417,6 +2417,10 @@
>  # On successful completion the image file is updated to drop the backi=
ng file
>  # and the BLOCK_JOB_COMPLETED event is emitted.
>  #
> +# In case @device is a filter node, block-stream modifies the first no=
n-filter
> +# overlay node below it to point to base's backing node (or NULL if @b=
ase was
> +# not specified) instead of modifying @device itself.

Maybe s/In case/If/

> +/*
> + * For a backing chain, return the first non-filter backing image.
> + */
> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
> +{
> +    return bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_filt=
ers(bs)));

Quite a mouthful, but looks correct.


> +++ b/block/io.c
> @@ -118,8 +118,17 @@ static void bdrv_merge_limits(BlockLimits *dst, co=
nst BlockLimits *src)
>  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>  {
>      BlockDriver *drv =3D bs->drv;
> +    BlockDriverState *storage_bs;
> +    BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs(bs);

If the backing file is filtered by a blkdebug layer that intentionally
is trying to advertise alternative block sizes...

>      Error *local_err =3D NULL;
> =20
> +    /*
> +     * FIXME: There should be a function for this, and in fact there
> +     * will be as of a follow-up patch.
> +     */
> +    storage_bs =3D
> +        child_bs(bs->file) ?: bdrv_filtered_rw_bs(bs);
> +
>      memset(&bs->bl, 0, sizeof(bs->bl));
> =20
>      if (!drv) {
> @@ -131,13 +140,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Er=
ror **errp)
>                                  drv->bdrv_aio_preadv) ? 1 : 512;
> =20
>      /* Take some limits from the children as a default */
> -    if (bs->file) {
> -        bdrv_refresh_limits(bs->file->bs, &local_err);
> +    if (storage_bs) {
> +        bdrv_refresh_limits(storage_bs, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
>          }
> -        bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
> +        bdrv_merge_limits(&bs->bl, &storage_bs->bl);
>      } else {
>          bs->bl.min_mem_alignment =3D 512;
>          bs->bl.opt_mem_alignment =3D getpagesize();
> @@ -146,13 +155,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Er=
ror **errp)
>          bs->bl.max_iov =3D IOV_MAX;
>      }
> =20
> -    if (bs->backing) {
> -        bdrv_refresh_limits(bs->backing->bs, &local_err);
> +    if (cow_bs) {
> +        bdrv_refresh_limits(cow_bs, &local_err);

=2E..then this change means that the active layer no longer picks up the
blkdebug block sizes, but the original COW layer sizes.  Is that
intentional?  I don't think it is fatal to the patch (as blkdebug is not
used in production, but only in testing), but it may cause some
head-scratching when trying to test behaviors of a COW child with
different block sizes than the active layer by using blkdebug on top of
the COW child.  I guess I'll find out soon enough (on my todo list is
fixing NBD to never split an NBD_CMD_READ or NBD_CMD_BLOCK_STATUS reply
below the granularity advertised at the active layer, even if the
backing file has a smaller granularity - and using blkdebug to force the
backing file granularity was my original plan of attack - but it is not
until this patch is applied that NBD can even locate the bitmap in a
backing file when a filter is interposed)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ThRTPUBnJo8qOga9V6ZJIYzwBMc0t6zrp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxk0ZcACgkQp6FrSiUn
Q2q0VQf8DXVZ8UjjPSgVK6ZFwP26iCudfnHJz4uz1uu0zMr45fJjTUVU8/8BQqA2
O3TLIj95dojYSYjznoNS1jgEDAsx6DBzdVdHTC4T+WVk7EuhvRdCKyAkCwmlLZf/
o2XYy8FXPGF0E1QQNzoLwsF+0R3WtojCsm4kC5bgjKWU32b/EWlPZMjnNoREeHky
o39HYtyoVveTsNnHqQNOFy00OuufmyM0838nDX5u4/lAiCriSJweMpYIiLhWbG1C
hAfxzYWi/SfO0ofE7FMO6K81pX9afnlG9qCkUADt2U723Cth9rsmjdUjT6K1vSF7
vN+j7S6Lbhc941KDj62Efx80C9XKwA==
=1FUL
-----END PGP SIGNATURE-----

--ThRTPUBnJo8qOga9V6ZJIYzwBMc0t6zrp--
