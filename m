Received: from eggs.gnu.org ([2001:4830:134:3::10]:33469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chJgL-0004yF-Ei
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chJgJ-00060R-RB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:29:25 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-37-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f875d1a5-f91f-7306-e422-692bc8952ced@redhat.com>
Date: Fri, 24 Feb 2017 18:29:14 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-37-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DHgN9uRiB8GndtQJNvGnpuHUikrm7Eqmu"
Subject: Re: [Qemu-devel] [PATCH 36/54] commit: Use real permissions in
 commit block job
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
--DHgN9uRiB8GndtQJNvGnpuHUikrm7Eqmu
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <f875d1a5-f91f-7306-e422-692bc8952ced@redhat.com>
Subject: Re: [PATCH 36/54] commit: Use real permissions in commit block job
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-37-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-37-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> This is probably one of the most interesting conversions to the new
> op blocker system because a commit block job intentionally leaves some
> intermediate block nodes in the backing chain that aren't valid on thei=
r
> own any more; only the whole chain together results in a valid view.
>=20
> In order to provide the 'consistent read' permission to the parents of
> the 'top' node of the commit job, a new filter block driver is inserted=

> above 'top' which doesn't require 'consistent read' on its backing
> chain. Subsequently, the commit job can block 'consistent read' on all
> intermediate nodes without causing a conflict.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++-=
--------
>  1 file changed, 91 insertions(+), 17 deletions(-)
>=20
> diff --git a/block/commit.c b/block/commit.c
> index b69586f..9336237 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -36,6 +36,7 @@ typedef struct CommitBlockJob {
>      BlockJob common;
>      RateLimit limit;
>      BlockDriverState *active;
> +    BlockDriverState *commit_top_bs;
>      BlockBackend *top;
>      BlockBackend *base;
>      BlockdevOnError on_error;
> @@ -83,12 +84,19 @@ static void commit_complete(BlockJob *job, void *op=
aque)
>      BlockDriverState *active =3D s->active;
>      BlockDriverState *top =3D blk_bs(s->top);
>      BlockDriverState *base =3D blk_bs(s->base);
> -    BlockDriverState *overlay_bs =3D bdrv_find_overlay(active, top);
> +    BlockDriverState *overlay_bs =3D bdrv_find_overlay(active, s->comm=
it_top_bs);
>      int ret =3D data->ret;
> +    bool remove_commit_top_bs =3D false;
> =20
>      if (!block_job_is_cancelled(&s->common) && ret =3D=3D 0) {
>          /* success */
> -        ret =3D bdrv_drop_intermediate(active, top, base, s->backing_f=
ile_str);
> +        ret =3D bdrv_drop_intermediate(active, s->commit_top_bs, base,=

> +                                     s->backing_file_str);
> +    } else if (overlay_bs) {
> +        /* XXX Can (or should) we somehow keep 'consistent read' block=
ed even
> +         * after the failed/cancelled commit job is gone? If we alread=
y wrote
> +         * something to base, the intermediate images aren't valid any=
 more. */
> +        remove_commit_top_bs =3D true;
>      }
> =20
>      /* restore base open flags here if appropriate (e.g., change the b=
ase back
> @@ -105,6 +113,13 @@ static void commit_complete(BlockJob *job, void *o=
paque)
>      blk_unref(s->base);
>      block_job_completed(&s->common, ret);
>      g_free(data);
> +
> +    /* If bdrv_drop_intermediate() didn't already do that, remove the =
commit
> +     * filter driver from the backing chain. Do this as the final step=
 so that
> +     * the 'consistent read' permission can be granted.  */
> +    if (remove_commit_top_bs) {
> +        bdrv_set_backing_hd(overlay_bs, top);
> +    }
>  }
> =20
>  static void coroutine_fn commit_run(void *opaque)
> @@ -208,6 +223,34 @@ static const BlockJobDriver commit_job_driver =3D =
{
>      .start         =3D commit_run,
>  };
> =20
> +static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
> +    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
> +{
> +    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static void bdrv_commit_top_close(BlockDriverState *bs)
> +{
> +}
> +
> +static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild=
 *c,
> +                                       const BdrvChildRole *role,
> +                                       uint64_t perm, uint64_t shared,=

> +                                       uint64_t *nperm, uint64_t *nsha=
red)
> +{
> +    *nperm =3D 0;
> +    *nshared =3D BLK_PERM_ALL;
> +}
> +
> +/* Dummy node that provides consistent read to its users without requi=
ring it
> + * from its backing file and that allows writes on the backing file ch=
ain. */
> +static BlockDriver bdrv_commit_top =3D {
> +    .format_name        =3D "commit_top",
> +    .bdrv_co_preadv     =3D bdrv_commit_top_preadv,
> +    .bdrv_close         =3D bdrv_commit_top_close,
> +    .bdrv_child_perm    =3D bdrv_commit_top_child_perm,
> +};
> +
>  void commit_start(const char *job_id, BlockDriverState *bs,
>                    BlockDriverState *base, BlockDriverState *top, int64=
_t speed,
>                    BlockdevOnError on_error, const char *backing_file_s=
tr,
> @@ -219,6 +262,7 @@ void commit_start(const char *job_id, BlockDriverSt=
ate *bs,
>      int orig_base_flags;
>      BlockDriverState *iter;
>      BlockDriverState *overlay_bs;
> +    BlockDriverState *commit_top_bs =3D NULL;
>      Error *local_err =3D NULL;
>      int ret;
> =20
> @@ -235,7 +279,6 @@ void commit_start(const char *job_id, BlockDriverSt=
ate *bs,
>          return;
>      }
> =20
> -    /* FIXME Use real permissions */
>      s =3D block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM=
_ALL,
>                           speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
>      if (!s) {
> @@ -262,34 +305,62 @@ void commit_start(const char *job_id, BlockDriver=
State *bs,
>          }
>      }
> =20
> +    /* Insert commit_top block node above top, so we can block consist=
ent read
> +     * on the backing chain below it */
> +    commit_top_bs =3D bdrv_new_open_driver(&bdrv_commit_top, NULL, BDR=
V_O_RDWR,

Why RDWR when the driver only allows reads anyway?

> +                                         errp);
> +    if (commit_top_bs =3D=3D NULL) {
> +        goto fail;
> +    }
> +
> +    bdrv_set_backing_hd(commit_top_bs, top);
> +    bdrv_set_backing_hd(overlay_bs, commit_top_bs);
> +
> +    s->commit_top_bs =3D commit_top_bs;
> +    bdrv_unref(commit_top_bs);
> =20
>      /* Block all nodes between top and base, because they will
>       * disappear from the chain after this operation. */
>      assert(bdrv_chain_contains(top, base));
> -    for (iter =3D top; iter !=3D backing_bs(base); iter =3D backing_bs=
(iter)) {
> -        /* FIXME Use real permissions */
> -        block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
> -                           BLK_PERM_ALL, &error_abort);
> +    for (iter =3D top; iter !=3D base; iter =3D backing_bs(iter)) {
> +        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ou=
rselves
> +         * at s->base.

As far as I can see, the loop doesn't even touch base, though...?

>                         The other options would be a second filter driv=
er above
> +         * s->base. */
> +        ret =3D block_job_add_bdrv(&s->common, "intermediate node", it=
er, 0,

Don't we need CONSISTENT_READ at least for top?

> +                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_W=
RITE,
> +                                 errp);
> +        if (ret < 0) {
> +            goto fail;
> +        }
>      }
> +
> +    ret =3D block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_A=
LL, errp);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
>      /* overlay_bs must be blocked because it needs to be modified to
> -     * update the backing image string, but if it's the root node then=

> -     * don't block it again */
> -    if (bs !=3D overlay_bs) {
> -        /* FIXME Use real permissions */
> -        block_job_add_bdrv(&s->common, "overlay of top", overlay_bs, 0=
,
> -                           BLK_PERM_ALL, &error_abort);
> +     * update the backing image string. */
> +    ret =3D block_job_add_bdrv(&s->common, "overlay of top", overlay_b=
s,
> +                             BLK_PERM_GRAPH_MOD, BLK_PERM_ALL, errp);
> +    if (ret < 0) {
> +        goto fail;
>      }
> =20
> -    /* FIXME Use real permissions */
> -    s->base =3D blk_new(0, BLK_PERM_ALL);
> +    s->base =3D blk_new(BLK_PERM_CONSISTENT_READ

Do we actually need CONSISTENT_READ for the base?

Max

> +                      | BLK_PERM_WRITE
> +                      | BLK_PERM_RESIZE,
> +                      BLK_PERM_CONSISTENT_READ
> +                      | BLK_PERM_GRAPH_MOD
> +                      | BLK_PERM_WRITE_UNCHANGED);
>      ret =3D blk_insert_bs(s->base, base, errp);
>      if (ret < 0) {
>          goto fail;
>      }
> =20
> -    /* FIXME Use real permissions */
> +    /* Required permissions are already taken with block_job_add_bdrv(=
) */
>      s->top =3D blk_new(0, BLK_PERM_ALL);
> -    ret =3D blk_insert_bs(s->top, top, errp);
> +    blk_insert_bs(s->top, top, errp);
>      if (ret < 0) {
>          goto fail;
>      }
> @@ -314,6 +385,9 @@ fail:
>      if (s->top) {
>          blk_unref(s->top);
>      }
> +    if (commit_top_bs) {
> +        bdrv_set_backing_hd(overlay_bs, top);
> +    }
>      block_job_unref(&s->common);
>  }
> =20
>=20



--DHgN9uRiB8GndtQJNvGnpuHUikrm7Eqmu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwbWoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A694H/30o8f3SMcKoqiB+CYVFlx5yQdheJy39
BCXAy0EQPygEcC7Hb8WHS7NDyD/0N8MR5V0LcfuZEPOAMd47V6he+NBCHZyTTugp
T4/lw37ej5FokNfBpCSU2WtyDXA4/sB+aqSjE1DB5lRvVwqDbFzMlw9BJP+MhT+7
774RI3MQ8Q5Ltf+n/qEDDBcj5pxMEejxaYV0aHRRoQnFX+4dI/Fd4lWncUAcxodd
ygYRvBJYhAQHoF7MdZzPX17ynEvNRmQgsNMguknTkS3yd+q+YUS58sZEcrpDVSSP
IVarjbCEEe1+ogiMVmQL18hEAubMHsfgt1QyT/PC9JZBOlZzlIEDqCc=
=2FVC
-----END PGP SIGNATURE-----

--DHgN9uRiB8GndtQJNvGnpuHUikrm7Eqmu--
