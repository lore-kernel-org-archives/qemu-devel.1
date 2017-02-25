Received: from eggs.gnu.org ([2001:4830:134:3::10]:41996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chcj3-0006do-Vf
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 08:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chcj1-0006D3-Po
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 08:49:30 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-43-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <23cbb9b0-3048-c90f-1db9-d62ffe37bf50@redhat.com>
Date: Sat, 25 Feb 2017 14:49:11 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-43-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AKr5S9UahSAFvGq7lqPuDMsm9X3BoNwpS"
Subject: Re: [Qemu-devel] [PATCH 42/54] mirror: Use real permissions in
 mirror/active commit block job
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
--AKr5S9UahSAFvGq7lqPuDMsm9X3BoNwpS
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <23cbb9b0-3048-c90f-1db9-d62ffe37bf50@redhat.com>
Subject: Re: [PATCH 42/54] mirror: Use real permissions in mirror/active
 commit block job
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-43-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-43-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> The mirror block job is mainly used for two different scenarios:
> Mirroring to an otherwise unused, independent target node, or for activ=
e
> commit where the target node is part of the backing chain of the source=
=2E
>=20
> Similarly to the commit block job patch, we need to insert a new filter=

> node to keep the permissions correct during active commit.
>=20
> Note that one change this implies is that job->blk points to
> mirror_top_bs as its root now, and mirror_top_bs (rather than the actua=
l
> source node) contains the bs->job pointer. This requires qemu-img commi=
t
> to get the job by name now rather than just taking bs->job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c             | 161 +++++++++++++++++++++++++++++++++++++=
--------
>  qemu-img.c                 |   6 +-
>  tests/qemu-iotests/141     |   2 +-
>  tests/qemu-iotests/141.out |   4 +-
>  4 files changed, 143 insertions(+), 30 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 767b7e7..252107d 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -38,7 +38,10 @@ typedef struct MirrorBlockJob {
>      BlockJob common;
>      RateLimit limit;
>      BlockBackend *target;
> +    BlockDriverState *mirror_top_bs;
> +    BlockDriverState *source;
>      BlockDriverState *base;
> +
>      /* The name of the graph node to replace */
>      char *replaces;
>      /* The BDS to replace */
> @@ -325,7 +328,7 @@ static void mirror_do_zero_or_discard(MirrorBlockJo=
b *s,
> =20
>  static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>  {
> -    BlockDriverState *source =3D blk_bs(s->common.blk);
> +    BlockDriverState *source =3D s->source;
>      int64_t sector_num, first_chunk;
>      uint64_t delay_ns =3D 0;
>      /* At least the first dirty chunk is mirrored in one iteration. */=

> @@ -495,12 +498,14 @@ static void mirror_exit(BlockJob *job, void *opaq=
ue)
>      MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common);
>      MirrorExitData *data =3D opaque;
>      AioContext *replace_aio_context =3D NULL;
> -    BlockDriverState *src =3D blk_bs(s->common.blk);
> +    BlockDriverState *src =3D s->source;
>      BlockDriverState *target_bs =3D blk_bs(s->target);
> +    BlockDriverState *mirror_top_bs =3D s->mirror_top_bs;
> =20
>      /* Make sure that the source BDS doesn't go away before we called
>       * block_job_completed(). */
>      bdrv_ref(src);
> +    bdrv_ref(mirror_top_bs);
> =20
>      if (s->to_replace) {
>          replace_aio_context =3D bdrv_get_aio_context(s->to_replace);
> @@ -522,13 +527,6 @@ static void mirror_exit(BlockJob *job, void *opaqu=
e)
>          bdrv_drained_begin(target_bs);
>          bdrv_replace_in_backing_chain(to_replace, target_bs);
>          bdrv_drained_end(target_bs);
> -
> -        /* We just changed the BDS the job BB refers to, so switch the=
 BB back
> -         * so the cleanup does the right thing. We don't need any perm=
issions
> -         * any more now. */
> -        blk_remove_bs(job->blk);
> -        blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
> -        blk_insert_bs(job->blk, src, &error_abort);
>      }
>      if (s->to_replace) {
>          bdrv_op_unblock_all(s->to_replace, s->replace_blocker);
> @@ -541,9 +539,23 @@ static void mirror_exit(BlockJob *job, void *opaqu=
e)
>      g_free(s->replaces);
>      blk_unref(s->target);
>      s->target =3D NULL;
> +
> +    /* Remove the mirror filter driver from the graph */
> +    bdrv_replace_in_backing_chain(mirror_top_bs, backing_bs(mirror_top=
_bs));
> +
> +    /* We just changed the BDS the job BB refers to (with either or bo=
th of the
> +     * bdrv_replace_in_backing_chain() calls), so switch the BB back s=
o the
> +     * cleanup does the right thing. We don't need any permissions any=
 more
> +     * now. */
> +    blk_remove_bs(job->blk);
> +    blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
> +    blk_insert_bs(job->blk, mirror_top_bs, &error_abort);
> +
>      block_job_completed(&s->common, data->ret);
> +
>      g_free(data);
>      bdrv_drained_end(src);
> +    bdrv_unref(mirror_top_bs);
>      bdrv_unref(src);
>  }
> =20
> @@ -563,7 +575,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlo=
ckJob *s)
>  {
>      int64_t sector_num, end;
>      BlockDriverState *base =3D s->base;
> -    BlockDriverState *bs =3D blk_bs(s->common.blk);
> +    BlockDriverState *bs =3D s->source;
>      BlockDriverState *target_bs =3D blk_bs(s->target);
>      int ret, n;
> =20
> @@ -642,7 +654,7 @@ static void coroutine_fn mirror_run(void *opaque)
>  {
>      MirrorBlockJob *s =3D opaque;
>      MirrorExitData *data;
> -    BlockDriverState *bs =3D blk_bs(s->common.blk);
> +    BlockDriverState *bs =3D s->source;
>      BlockDriverState *target_bs =3D blk_bs(s->target);
>      bool need_drain =3D true;
>      int64_t length;
> @@ -876,7 +888,7 @@ static void mirror_complete(BlockJob *job, Error **=
errp)
>      MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common);
>      BlockDriverState *src, *target;
> =20
> -    src =3D blk_bs(job->blk);
> +    src =3D s->source;
>      target =3D blk_bs(s->target);
> =20
>      if (!s->synced) {
> @@ -908,6 +920,10 @@ static void mirror_complete(BlockJob *job, Error *=
*errp)
>          replace_aio_context =3D bdrv_get_aio_context(s->to_replace);
>          aio_context_acquire(replace_aio_context);
> =20
> +        /* TODO Translate this into permission system. Current definit=
ion of
> +         * GRAPH_MOD would require to request it for the parents; they=
 might
> +         * not even be BlockDriverStates, however, so a BdrvChild can'=
t address
> +         * them. May need redefinition of GRAPH_MOD. */
>          error_setg(&s->replace_blocker,
>                     "block device is in use by block-job-complete");
>          bdrv_op_block_all(s->to_replace, s->replace_blocker);
> @@ -978,6 +994,46 @@ static const BlockJobDriver commit_active_job_driv=
er =3D {
>      .drain                  =3D mirror_drain,
>  };
> =20
> +static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
> +    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
> +{
> +    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
> +    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
> +{
> +    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static void bdrv_mirror_top_close(BlockDriverState *bs)
> +{
> +}
> +
> +static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild=
 *c,
> +                                       const BdrvChildRole *role,
> +                                       uint64_t perm, uint64_t shared,=

> +                                       uint64_t *nperm, uint64_t *nsha=
red)
> +{
> +    /* Must be able to forward guest writes to the real image */
> +    *nperm =3D 0;
> +    if (perm & BLK_PERM_WRITE) {
> +        *nperm |=3D BLK_PERM_WRITE;
> +    }
> +
> +    *nshared =3D BLK_PERM_ALL;
> +}
> +
> +/* Dummy node that provides consistent read to its users without requi=
ring it
> + * from its backing file and that allows writes on the backing file ch=
ain. */
> +static BlockDriver bdrv_mirror_top =3D {
> +    .format_name        =3D "mirror_top",
> +    .bdrv_co_preadv     =3D bdrv_mirror_top_preadv,
> +    .bdrv_co_pwritev    =3D bdrv_mirror_top_pwritev,

Some comments about these stub drivers (which also apply to the one for
commit):

First, what about flush, write_zeroes, discard, and get_block_status?

Second, not implementing bdrv_refresh_filename(), having no "file"
child, and not having the child node's options in the BDS's options
results in an empty filename when queried via query-block. Reasonable in
theory, but are you sure this won't break something?

Third, having a "backing" but not "file" child seems like a bad idea to
me. It makes sense in this context, but I thought that we somehow
arrived at the conclusion that implicit nodes should always have a
"file" node that tools can fall through to if they don't recognize some
node.

In any case, the gist of 2 and 3 is that this changes the query-block
output. I'm not sure how bad it is, but intuitively it doesn't seem to
be a change we should do lightheartedly.

> +    .bdrv_close         =3D bdrv_mirror_top_close,
> +    .bdrv_child_perm    =3D bdrv_mirror_top_child_perm,
> +};
> +
>  static void mirror_start_job(const char *job_id, BlockDriverState *bs,=

>                               int creation_flags, BlockDriverState *tar=
get,
>                               const char *replaces, int64_t speed,
> @@ -993,6 +1049,9 @@ static void mirror_start_job(const char *job_id, B=
lockDriverState *bs,
>                               bool auto_complete)
>  {
>      MirrorBlockJob *s;
> +    BlockDriverState *mirror_top_bs;
> +    bool target_graph_mod;
> +    bool target_is_backing;
>      int ret;
> =20
>      if (granularity =3D=3D 0) {
> @@ -1010,20 +1069,54 @@ static void mirror_start_job(const char *job_id=
, BlockDriverState *bs,
>          buf_size =3D DEFAULT_MIRROR_BUF_SIZE;
>      }
> =20
> -    /* FIXME Use real permissions */
> -    s =3D block_job_create(job_id, driver, bs, 0, BLK_PERM_ALL, speed,=

> +    /* In the case of active commit, add dummy driver to provide consi=
stent
> +     * reads on the top, while disabling it in the intermediate nodes =
*/

Isn't it much more important that this node (just as the one for the
commit job) makes all of the backing chain writable?

It has taken me quite some time (longer than it should have) to figure
that out, actually.

> +    mirror_top_bs =3D bdrv_new_open_driver(&bdrv_mirror_top, NULL, BDR=
V_O_RDWR,
> +                                         errp);
> +    if (mirror_top_bs =3D=3D NULL) {
> +        return;
> +    }
> +    mirror_top_bs->total_sectors =3D bs->total_sectors;
> +
> +    /* bdrv_append takes ownership of the mirror_top_bs reference, nee=
d to keep
> +     * it alive until block_job_create() even if bs has no parent. */
> +    bdrv_ref(mirror_top_bs);
> +    bdrv_drained_begin(bs);
> +    bdrv_append(mirror_top_bs, bs);
> +    bdrv_drained_end(bs);
> +
> +    /* Make sure that the source is not resized while the job is runni=
ng */
> +    s =3D block_job_create(job_id, driver, mirror_top_bs,
> +                         BLK_PERM_CONSISTENT_READ,
> +                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNC=
HANGED |
> +                         BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
>                           creation_flags, cb, opaque, errp);
> +    bdrv_unref(mirror_top_bs);
>      if (!s) {
> -        return;
> +        goto fail;
>      }
> -
> -    /* FIXME Use real permissions */
> -    s->target =3D blk_new(0, BLK_PERM_ALL);
> +    s->source =3D bs;
> +    s->mirror_top_bs =3D mirror_top_bs;
> +
> +    /* No resize for the target either; while the mirror is still runn=
ing, a
> +     * consistent read isn't necessarily possible. We could possibly a=
llow
> +     * writes and graph modifications, though it would likely defeat t=
he
> +     * purpose of a mirror, so leave them blocked for now.
> +     *
> +     * In the case of active commit, things look a bit different, thou=
gh,
> +     * because the target is an already populated backing file in acti=
ve use.
> +     * We can allow anything ecept resize there.*/

*except

Also, I think that a full mirror allows CONSISTENT_READ if active commit
does, too.

> +    target_is_backing =3D bdrv_chain_contains(bs, target);
> +    target_graph_mod =3D (backing_mode !=3D MIRROR_LEAVE_BACKING_CHAIN=
);
> +    s->target =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE |
> +                        (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
> +                        BLK_PERM_WRITE_UNCHANGED |
> +                        (target_is_backing ? BLK_PERM_CONSISTENT_READ =
|
> +                                             BLK_PERM_WRITE |
> +                                             BLK_PERM_GRAPH_MOD : 0));=

>      ret =3D blk_insert_bs(s->target, target, errp);
>      if (ret < 0) {
> -        blk_unref(s->target);
> -        block_job_unref(&s->common);
> -        return;
> +        goto fail;
>      }
> =20
>      s->replaces =3D g_strdup(replaces);
> @@ -1047,23 +1140,39 @@ static void mirror_start_job(const char *job_id=
, BlockDriverState *bs,
>          return;
>      }
> =20
> -    /* FIXME Use real permissions */
> +    /* Required permissions are already taken with blk_new() */
>      block_job_add_bdrv(&s->common, "target", target, 0, BLK_PERM_ALL,
>                         &error_abort);
> =20
>      /* In commit_active_start() all intermediate nodes disappear, so
>       * any jobs in them must be blocked */
> -    if (bdrv_chain_contains(bs, target)) {
> +    if (target_is_backing) {
>          BlockDriverState *iter;
>          for (iter =3D backing_bs(bs); iter !=3D target; iter =3D backi=
ng_bs(iter)) {
> -            /* FIXME Use real permissions */
> -            block_job_add_bdrv(&s->common, "intermediate node", iter, =
0,
> -                               BLK_PERM_ALL, &error_abort);
> +            /* XXX BLK_PERM_WRITE needs to be allowed so we don't bloc=
k ourselves
> +             * at s->base. The other options would be a second filter =
driver above
> +             * s->base. */

I think it's rather about target than s->base here (probably equivalent
in the case of active commit, but well).

> +            ret =3D block_job_add_bdrv(&s->common, "intermediate node"=
, iter, 0,
> +                                     BLK_PERM_WRITE_UNCHANGED | BLK_PE=
RM_WRITE,
> +                                     errp);

OK, now I got why you need to allow writes even though you don't even
touch target itself. Again, it has taken me quite some time to figure
out that

(a) bdrv_format_default_perms() will block writes on backing BDS if the
    overlay does not allow shared writes,

(b) Therefore, the base cannot be written to if something in the chain
    above it blocks shared writes, and

(c) You insert the new node above the backing chain to break that
    recursion and allow writes on the chain from that point on.

A comment about (c) might have made this easier.

Max

> +            if (ret < 0) {
> +                goto fail;
> +            }
>          }
>      }
> =20
>      trace_mirror_start(bs, s, opaque);
>      block_job_start(&s->common);
> +    return;
> +
> +fail:
> +    if (s) {
> +        g_free(s->replaces);
> +        blk_unref(s->target);
> +        block_job_unref(&s->common);
> +    }
> +
> +    bdrv_replace_in_backing_chain(mirror_top_bs, backing_bs(mirror_top=
_bs));
>  }
> =20
>  void mirror_start(const char *job_id, BlockDriverState *bs,
> diff --git a/qemu-img.c b/qemu-img.c
> index 8d9195e..e20830f 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -795,6 +795,8 @@ static void run_block_job(BlockJob *job, Error **er=
rp)
>  {
>      AioContext *aio_context =3D blk_get_aio_context(job->blk);
> =20
> +    /* FIXME In error cases, the job simply goes away and we access a =
dangling
> +     * pointer below. */
>      aio_context_acquire(aio_context);
>      do {
>          aio_poll(aio_context, true);
> @@ -816,6 +818,7 @@ static int img_commit(int argc, char **argv)
>      const char *filename, *fmt, *cache, *base;
>      BlockBackend *blk;
>      BlockDriverState *bs, *base_bs;
> +    BlockJob *job;
>      bool progress =3D false, quiet =3D false, drop =3D false;
>      bool writethrough;
>      Error *local_err =3D NULL;
> @@ -951,7 +954,8 @@ static int img_commit(int argc, char **argv)
>          bdrv_ref(bs);
>      }
> =20
> -    run_block_job(bs->job, &local_err);
> +    job =3D block_job_get("commit");
> +    run_block_job(job, &local_err);
>      if (local_err) {
>          goto unref_backing;
>      }
> diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
> index 3ba79f0..6d8f0a1 100755
> --- a/tests/qemu-iotests/141
> +++ b/tests/qemu-iotests/141
> @@ -67,7 +67,7 @@ test_blockjob()
>      _send_qemu_cmd $QEMU_HANDLE \
>          "{'execute': 'x-blockdev-del',
>            'arguments': {'node-name': 'drv0'}}" \
> -        'error'
> +        'error' | _filter_generated_node_ids
> =20
>      _send_qemu_cmd $QEMU_HANDLE \
>          "{'execute': 'block-job-cancel',
> diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
> index 195ca1a..82e763b 100644
> --- a/tests/qemu-iotests/141.out
> +++ b/tests/qemu-iotests/141.out
> @@ -20,7 +20,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1=
048576 backing_file=3DTEST_DIR/t.
>  Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0=
, "speed": 0, "type": "mirror"}}
>  {"return": {}}
> -{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
> +{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node=
 is used as backing hd of 'NODE_NAME'"}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset=
": 0, "speed": 0, "type": "mirror"}}
>  {"return": {}}
> @@ -30,7 +30,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1=
048576 backing_file=3DTEST_DIR/t.
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0=
, "speed": 0, "type": "commit"}}
>  {"return": {}}
> -{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
> +{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node=
 is used as backing hd of 'NODE_NAME'"}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset=
": 0, "speed": 0, "type": "commit"}}
>  {"return": {}}
>=20



--AKr5S9UahSAFvGq7lqPuDMsm9X3BoNwpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixi1cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQW0IAKzCg1iW3zst/HfzOI7lRRDDH933MM/X
svMxRJaGky7whlDZRP/F0MxmD4Hi98tUPWiYYJKmAvr+02wUHfJi3WYDe7HX/jh2
AKO6tBZy/0q0MTX4AjhcQAWbcaTQZwDUPu121fkLfWllDTXkYhTd6i8pjoTGJ1BN
FeY6ZgKOXrThKxxqwgSne48h2dM9jA2g7wfSUnv53nhtYLwmQLpbyfGkXfYvLyUz
Q0SXshVrMjH58lt0eUpf2qSz5Scx/1wZfMZN6Sl93pIiyfQmXo3SNLwiEJijN3lJ
ZYryw7ERPrQR18+IfJEr4O4ZYHOyILO9e6GajsTTF4ATGN6JfEz2ClI=
=aZNE
-----END PGP SIGNATURE-----

--AKr5S9UahSAFvGq7lqPuDMsm9X3BoNwpS--
