Received: from eggs.gnu.org ([2001:4830:134:3::10]:47725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cflDk-0007BU-Ng
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cflDj-0007Z2-ED
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:29:28 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-16-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7a82a3ff-5828-c3c6-05c1-a0774160ceba@redhat.com>
Date: Mon, 20 Feb 2017 11:29:15 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-16-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WnISxsu63X0K7APcr8ih1wFXvdXpH5BOt"
Subject: Re: [Qemu-devel] [RFC PATCH 15/41] block: Add permissions to
 blk_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WnISxsu63X0K7APcr8ih1wFXvdXpH5BOt
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <7a82a3ff-5828-c3c6-05c1-a0774160ceba@redhat.com>
Subject: Re: [RFC PATCH 15/41] block: Add permissions to blk_new()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-16-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-16-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> We want every user to be specific about the permissions it needs, so
> we'll pass the initial permissions as parameters to blk_new(). A user
> only needs to call blk_set_perm() if it wants to change the permissions=

> after the fact.
>=20
> The permissions are stored in the BlockBackend and applied whenever a
> BlockDriverState should be attached in blk_insert_bs().
>=20
> This does not include actually choosing the right set of permissions
> yet. Instead, the usual FIXME comment is added to each place and will b=
e
> addressed in individual patches.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/backup.c                   |  3 ++-
>  block/block-backend.c            | 12 ++++++------
>  block/commit.c                   | 12 ++++++++----
>  block/mirror.c                   |  3 ++-
>  blockdev.c                       |  2 +-
>  blockjob.c                       |  3 ++-
>  hmp.c                            |  3 ++-
>  hw/block/fdc.c                   |  3 ++-
>  hw/core/qdev-properties-system.c |  3 ++-
>  hw/ide/qdev.c                    |  3 ++-
>  hw/scsi/scsi-disk.c              |  3 ++-
>  include/sysemu/block-backend.h   |  2 +-
>  migration/block.c                |  3 ++-
>  nbd/server.c                     |  3 ++-
>  tests/test-blockjob.c            |  3 ++-
>  tests/test-throttle.c            |  7 ++++---
>  16 files changed, 42 insertions(+), 26 deletions(-)

[...]

> diff --git a/block/block-backend.c b/block/block-backend.c
> index 8f0348d..a219f0b 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -123,14 +123,14 @@ static const BdrvChildRole child_root =3D {
>   * Store an error through @errp on failure, unless it's null.
>   * Return the new BlockBackend on success, null on failure.
>   */
> -BlockBackend *blk_new(void)
> +BlockBackend *blk_new(uint64_t perm, uint64_t shared_perm)

I think it would be a good idea to document what these parameters do, at
least by pointing to the definition of the permission flags.

Also, this makes me think that the permission flags should not be in
block_int.h but in block.h. This function is available outside of the
core block layer.

>  {
>      BlockBackend *blk;
> =20
>      blk =3D g_new0(BlockBackend, 1);
>      blk->refcnt =3D 1;
> -    blk->perm =3D 0;
> -    blk->shared_perm =3D BLK_PERM_ALL;
> +    blk->perm =3D perm;
> +    blk->shared_perm =3D shared_perm;
>      blk_set_enable_write_cache(blk, true);
> =20
>      qemu_co_queue_init(&blk->public.throttled_reqs[0]);
> @@ -161,7 +161,7 @@ BlockBackend *blk_new_open(const char *filename, co=
nst char *reference,
>      BlockBackend *blk;
>      BlockDriverState *bs;
> =20
> -    blk =3D blk_new();
> +    blk =3D blk_new(0, BLK_PERM_ALL);
>      bs =3D bdrv_open(filename, reference, options, flags, errp);
>      if (!bs) {
>          blk_unref(blk);
> @@ -505,9 +505,9 @@ void blk_remove_bs(BlockBackend *blk)
>  void blk_insert_bs(BlockBackend *blk, BlockDriverState *bs)
>  {
>      bdrv_ref(bs);
> -    /* FIXME Use real permissions */
>      blk->root =3D bdrv_root_attach_child(bs, "root", &child_root,
> -                                       0, BLK_PERM_ALL, blk, &error_ab=
ort);
> +                                       blk->perm, blk->shared_perm, bl=
k,
> +                                       &error_abort);

And the error_abort does not qualify as a FIXME?

> =20
>      notifier_list_notify(&blk->insert_bs_notifiers, blk);
>      if (blk->public.throttle_state) {

[...]

> diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
> index 068c9e4..1dd1cfa 100644
> --- a/tests/test-blockjob.c
> +++ b/tests/test-blockjob.c
> @@ -53,7 +53,8 @@ static BlockJob *do_test_id(BlockBackend *blk, const =
char *id,
>   * BlockDriverState inserted. */
>  static BlockBackend *create_blk(const char *name)
>  {
> -    BlockBackend *blk =3D blk_new();
> +    /* FIXME Use real permissions */
> +    BlockBackend *blk =3D blk_new(0, BLK_PERM_ALL);
>      BlockDriverState *bs;
> =20
>      bs =3D bdrv_open("null-co://", NULL, NULL, 0, &error_abort);

Pretty much independent of this patch, but: blk_new_open() would
probably be the better choice then to call blk_new() + bdrv_open() +
blk_insert_bs().

Max


--WnISxsu63X0K7APcr8ih1wFXvdXpH5BOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliqxPsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjsMH/i2MuzsY5AS8kOa/u4V6NjP25Bgk8lZt
5Oqrhi8z+31wuQqZ+SvZyM+9D4FABmG9FFUUltI8C19FRY+4XBZ484KquYSYmmCp
6PGFYt9P5uQAHwz/qDwv+OGgxIEruKL849oKkw2PwBieip6kUc/rg6qkw4I+REoD
hhFpteXczIrRXJx81Z/LBKDzKgPC+fi3Pvdk6ILRdIM0t3fTQFh02LOyf4dNMH/d
yrmPS3nN1WKFOWMjPGVSAXS+2QD3vfNrLRLteHAgvS0y+zfkDrqtD0okha1EAefD
FfZyp3t/6vioSRD3ZaOGn5oqJGu3jjVU7Hk48AnGmGPh113moc1ELW4=
=ZFgd
-----END PGP SIGNATURE-----

--WnISxsu63X0K7APcr8ih1wFXvdXpH5BOt--
