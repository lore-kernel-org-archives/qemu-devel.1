Received: from eggs.gnu.org ([2001:4830:134:3::10]:52721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1di4gE-0004wW-2f
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 16:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1di4gB-0006vS-ES
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 16:12:42 -0400
Date: Wed, 16 Aug 2017 23:11:44 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170816201144.x3uvqrmptacuvubz@postretch>
References: <20170815081854.14568-1-el13635@mail.ntua.gr>
	<20170815081854.14568-2-el13635@mail.ntua.gr>
	<20170816132544.GF3180@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6hai7ohqvlf6bb3b"
Content-Disposition: inline
In-Reply-To: <20170816132544.GF3180@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/2] block: use internal
 filter node in backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--6hai7ohqvlf6bb3b
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 02:25:44PM +0100, Stefan Hajnoczi wrote:
>On Tue, Aug 15, 2017 at 11:18:53AM +0300, Manos Pitsidianakis wrote:
>> block/backup.c currently uses before write notifiers on the targeted
>> node. We can create a filter node instead to intercept write requests
>> for the backup job on the BDS level, instead of the BlockBackend level.
>>
>> This is part of deprecating before write notifiers, which are hard coded
>> into the block layer. Block filter drivers are inserted into the graph
>> only when a feature is needed. This makes the block layer more modular
>> and reuses the block driver abstraction that is already present.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  block.c                    |  89 +++++++++++++++++--
>>  block/backup.c             | 207 ++++++++++++++++++++++++++++++++++++++=
++-----
>>  block/mirror.c             |   7 +-
>>  blockdev.c                 |   2 +-
>>  include/block/block.h      |   8 +-
>>  tests/qemu-iotests/141.out |   2 +-
>>  6 files changed, 276 insertions(+), 39 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 2de1c29eb3..81bd51b670 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2088,6 +2088,38 @@ static void bdrv_parent_cb_resize(BlockDriverStat=
e *bs)
>>  }
>>
>>  /*
>> + * Sets the file link of a BDS. A new reference is created; callers
>> + * which don't need their own reference any more must call bdrv_unref().
>> + */
>> +void bdrv_set_file(BlockDriverState *bs, BlockDriverState *file_bs,
>> +                   Error **errp)
>> +{
>> +    if (file_bs) {
>> +        bdrv_ref(file_bs);
>> +    }
>> +
>> +    if (bs->file) {
>> +        bdrv_unref_child(bs, bs->file);
>> +    }
>> +
>> +    if (!file_bs) {
>> +        bs->file =3D NULL;
>> +        goto out;
>> +    }
>> +
>> +    bs->file =3D bdrv_attach_child(bs, file_bs, "file", &child_file,
>> +                                 errp);
>> +    if (!bs->file) {
>> +        bdrv_unref(file_bs);
>> +    }
>> +
>> +    bdrv_refresh_filename(bs);
>> +
>> +out:
>> +    bdrv_refresh_limits(bs, NULL);
>> +}
>> +
>> +/*
>>   * Sets the backing file link of a BDS. A new reference is created; cal=
lers
>>   * which don't need their own reference any more must call bdrv_unref().
>>   */
>> @@ -2355,12 +2387,12 @@ static BlockDriverState *bdrv_append_temp_snapsh=
ot(BlockDriverState *bs,
>>          goto out;
>>      }
>>
>> -    /* bdrv_append() consumes a strong reference to bs_snapshot
>> +    /* bdrv_append_backing() consumes a strong reference to bs_snapshot
>>       * (i.e. it will call bdrv_unref() on it) even on error, so in
>>       * order to be able to return one, we have to increase
>>       * bs_snapshot's refcount here */
>>      bdrv_ref(bs_snapshot);
>> -    bdrv_append(bs_snapshot, bs, &local_err);
>> +    bdrv_append_backing(bs_snapshot, bs, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          bs_snapshot =3D NULL;
>> @@ -3142,7 +3174,7 @@ static bool should_update_child(BdrvChild *c, Bloc=
kDriverState *to)
>>          return false;
>>      }
>>
>> -    if (c->role =3D=3D &child_backing) {
>> +    if (c->role =3D=3D &child_backing || c->role =3D=3D &child_file) {
>>          /* If @from is a backing file of @to, ignore the child to avoid
>>           * creating a loop. We only want to change the pointer of other
>>           * parents. */
>
>This may have unwanted side-effects.  I think you're using is so that
>bdrv_set_file() + bdrv_replace_node() does not create a loop in the
>graph.  That is okay if there is only one parent with child_file.  If
>there are multiple parents with that role then it's not clear to me that
>they should all be skipped.

I am afraid I don't understand what you're saying. What is the=20
difference with the child_backing scenario here?  In both cases we=20
should update all from->parents children unless they also happen to be a=20
child of `to`. If there are multiple parents with child_file, they are=20
not skipped except for the ones where `to` is the parent.
>
>> @@ -3213,6 +3245,45 @@ out:
>>  }
>>
>>  /*
>> + * Add new bs node at the top of a BDS chain while the chain is
>> + * live, while keeping required fields on the top layer.
>> + *
>> + * This will modify the BlockDriverState fields, and swap contents
>> + * between bs_new and bs_top. Both bs_new and bs_top are modified.
>> + *
>> + * bs_new must not be attached to a BlockBackend.
>> + *
>> + * bdrv_append_file() takes ownership of a bs_new reference and unrefs =
it
>> + * because that's what the callers commonly need. bs_new will be refere=
nced by
>> + * the old parents of bs_top after bdrv_append_file() returns. If the c=
aller
>> + * needs to keep a reference of its own, it must call bdrv_ref().
>> + */
>> +void bdrv_append_file(BlockDriverState *bs_new, BlockDriverState *bs_to=
p,
>> +                      Error **errp)
>> +{
>> +    Error *local_err =3D NULL;
>> +
>> +    bdrv_ref(bs_top);
>> +    bdrv_set_file(bs_new, bs_top, &local_err);
>
>bdrv_set_file() takes its own reference so there's no need to call
>bdrv_ref(bs_top).
>
>But it would be more consistent with existing functions for
>bdrv_set_file() *not* to take a new reference.  If you make that change
>then this bdrv_ref() is correct.
>
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        bdrv_set_file(bs_new, NULL, &error_abort);
>
>If bdrv_set_file(bs_new, bs_top) failed, why is it necessary to set
>bs_new->file to NULL?
>
>bdrv_set_file() should guarantee that bs_new->file is either bs_top (on
>success) or the old value (on failure).  Then the caller does not need
>to fix up bs_new->file on failure.

I think the error paths got mixed here, bs_new->file should be set to=20
NULL on bdrv_replace_node() failure.
>
>> +        goto out;
>> +    }
>> +    bdrv_replace_node(bs_top, bs_new, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        goto out;
>> +    }
>> +
>> +    /* bs_new is now referenced by its new parents, we don't need the
>> +     * additional reference any more. */
>> +out:
>> +    bdrv_unref(bs_top);
>> +    bdrv_unref(bs_new);
>> +}
>> +
>> +/*
>>   * Add new bs contents at the top of an image chain while the chain is
>>   * live, while keeping required fields on the top layer.
>>   *
>
>Plase introduce the bdrv_set_file() and bdrv_append_file() APIs in a
>separate patch from the backup block job changes.
>
>> @@ -3223,13 +3294,13 @@ out:
>>   *
>>   * This function does not create any image files.
>>   *
>> - * bdrv_append() takes ownership of a bs_new reference and unrefs it be=
cause
>> - * that's what the callers commonly need. bs_new will be referenced by =
the old
>> - * parents of bs_top after bdrv_append() returns. If the caller needs t=
o keep a
>> - * reference of its own, it must call bdrv_ref().
>> + * bdrv_append_backing() takes ownership of a bs_new reference and unre=
fs it
>> + * because that's what the callers commonly need. bs_new will be refere=
nced by
>> + * the old parents of bs_top after bdrv_append_backing() returns. If th=
e caller
>> + * needs to keep a reference of its own, it must call bdrv_ref().
>>   */
>> -void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
>> -                 Error **errp)
>> +void bdrv_append_backing(BlockDriverState *bs_new, BlockDriverState *bs=
_top,
>> +                         Error **errp)
>>  {
>>      Error *local_err =3D NULL;
>>
>
>Please change bdrv_append() to bdrv_append_backing() in a separate
>patch.
>
>> diff --git a/block/backup.c b/block/backup.c
>> index 504a089150..0828d522b6 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -43,7 +43,7 @@ typedef struct BackupBlockJob {
>>      unsigned long *done_bitmap;
>>      int64_t cluster_size;
>>      bool compress;
>> -    NotifierWithReturn before_write;
>> +    BlockDriverState *filter;
>>      QLIST_HEAD(, CowRequest) inflight_reqs;
>>  } BackupBlockJob;
>>
>> @@ -174,20 +174,6 @@ out:
>>      return ret;
>>  }
>>
>> -static int coroutine_fn backup_before_write_notify(
>> -        NotifierWithReturn *notifier,
>> -        void *opaque)
>> -{
>> -    BackupBlockJob *job =3D container_of(notifier, BackupBlockJob, befo=
re_write);
>> -    BdrvTrackedRequest *req =3D opaque;
>> -
>> -    assert(req->bs =3D=3D blk_bs(job->common.blk));
>> -    assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
>> -    assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
>> -
>> -    return backup_do_cow(job, req->offset, req->bytes, NULL, true);
>> -}
>> -
>>  static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
>>  {
>>      BackupBlockJob *s =3D container_of(job, BackupBlockJob, common);
>> @@ -202,7 +188,8 @@ static void backup_set_speed(BlockJob *job, int64_t =
speed, Error **errp)
>>  static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
>>  {
>>      BdrvDirtyBitmap *bm;
>> -    BlockDriverState *bs =3D blk_bs(job->common.blk);
>> +    BlockDriverState *bs =3D child_bs(blk_bs(job->common.blk));
>> +    assert(bs);
>>
>>      if (ret < 0 || block_job_is_cancelled(&job->common)) {
>>          /* Merge the successor back into the parent, delete nothing. */
>> @@ -234,9 +221,31 @@ static void backup_abort(BlockJob *job)
>>  static void backup_clean(BlockJob *job)
>>  {
>>      BackupBlockJob *s =3D container_of(job, BackupBlockJob, common);
>> +    BlockDriverState *bs =3D child_bs(s->filter),
>> +                     *filter =3D s->filter;
>
>Please do not put multiple variable declarations with initializers in a
>single statement.  It's easier to read like this:
>
>  BlockDriverState *filter =3D s->filter;
>  BlockDriverState *bs =3D child_bs(filter);
>
>> +
>>      assert(s->target);
>>      blk_unref(s->target);
>>      s->target =3D NULL;
>> +
>> +    /* make sure nothing goes away while removing filter */
>> +    bdrv_ref(filter);
>> +    bdrv_ref(bs);
>> +    bdrv_drained_begin(bs);
>> +
>> +    block_job_remove_all_bdrv(job);
>> +    bdrv_child_try_set_perm(filter->file, 0, BLK_PERM_ALL,
>> +                            &error_abort);
>> +    bdrv_replace_node(filter, bs, &error_abort);
>> +
>> +    blk_remove_bs(job->blk);
>> +    blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
>> +    blk_insert_bs(job->blk, filter, &error_abort);
>> +
>> +    bdrv_drained_end(bs);
>> +    bdrv_unref(filter);
>> +    bdrv_unref(bs);
>> +    s->filter =3D NULL;
>>  }
>>
>>  static void backup_attached_aio_context(BlockJob *job, AioContext *aio_=
context)
>> @@ -421,6 +430,18 @@ out:
>>      return ret;
>>  }
>>
>> +static void backup_top_enable(BackupBlockJob *job)
>> +{
>> +    BlockDriverState *bs =3D job->filter;
>> +    bs->opaque =3D job;
>> +}
>> +
>> +static void backup_top_disable(BackupBlockJob *job)
>> +{
>> +    BlockDriverState *bs =3D job->filter;
>> +    bs->opaque =3D NULL;
>> +}
>
>bs->opaque is a pointer that is managed by block.c.  Drivers are not
>allowed to modify this pointer.  You declared BlockDriver.instance_size
>=3D sizeof(BackupBlockJob *) but didn't use it.

Doh, thanks.=20
>
>I guess this should be:
>
>  static void backup_top_enable(BackupBlockJob *job)
>  {
>      BackupBlockJob **jobp =3D job->bs->opaque;
>      *jobp =3D job;
>  }
>
>  static void backup_top_disable(BackupBlockJob *job)
>  {
>      BackupBlockJob **jobp =3D job->bs->opaque;
>      *jobp =3D NULL;
>  }
>
>  ...
>
>  static int coroutine_fn backup_top_co_pwritev(BlockDriverState *bs,
>                                                uint64_t offset,
>                                                uint64_t bytes,
>                                                QEMUIOVector *qiov, int fl=
ags)
>  {
>      int ret =3D 0;
>      BackupBlockJob *job =3D *(BackupBlockJob **)bs->opaque;
>      if (job) {
>
>Alternatively filter->job can be used but that may be a legacy field
>that will be removed eventually.
>
>> +
>>  static void coroutine_fn backup_run(void *opaque)
>>  {
>>      BackupBlockJob *job =3D opaque;
>> @@ -435,13 +456,12 @@ static void coroutine_fn backup_run(void *opaque)
>>      job->done_bitmap =3D bitmap_new(DIV_ROUND_UP(job->common.len,
>>                                                 job->cluster_size));
>>
>> -    job->before_write.notify =3D backup_before_write_notify;
>> -    bdrv_add_before_write_notifier(bs, &job->before_write);
>> +    backup_top_enable(job);
>>
>>      if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) {
>>          while (!block_job_is_cancelled(&job->common)) {
>> -            /* Yield until the job is cancelled.  We just let our befor=
e_write
>> -             * notify callback service CoW requests. */
>> +            /* Yield until the job is cancelled.  We just let our backu=
p_top
>> +             * filter service CoW requests. */
>>              block_job_yield(&job->common);
>>          }
>>      } else if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
>> @@ -507,8 +527,7 @@ static void coroutine_fn backup_run(void *opaque)
>>              }
>>          }
>>      }
>> -
>> -    notifier_with_return_remove(&job->before_write);
>> +    backup_top_disable(job);
>>
>>      /* wait until pending backup_do_cow() calls have completed */
>>      qemu_co_rwlock_wrlock(&job->flush_rwlock);
>> @@ -532,6 +551,124 @@ static const BlockJobDriver backup_job_driver =3D {
>>      .drain                  =3D backup_drain,
>>  };
>>
>> +static int coroutine_fn backup_top_co_preadv(BlockDriverState *bs,
>> +                                             uint64_t offset,
>> +                                             uint64_t bytes,
>> +                                             QEMUIOVector *qiov, int fl=
ags)
>> +{
>> +    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
>> +}
>> +
>> +static int coroutine_fn backup_top_co_pwritev(BlockDriverState *bs,
>> +                                              uint64_t offset,
>> +                                              uint64_t bytes,
>> +                                              QEMUIOVector *qiov, int f=
lags)
>> +{
>> +    int ret =3D 0;
>> +    BackupBlockJob *job =3D bs->opaque;
>> +    if (job) {
>> +        assert(bs =3D=3D blk_bs(job->common.blk));
>> +        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
>> +        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>> +        ret =3D backup_do_cow(job, offset, bytes, NULL, true);
>> +    }
>> +
>> +    return ret < 0 ? ret : bdrv_co_pwritev(bs->file, offset, bytes,
>> +                                           qiov, flags);
>> +}
>> +
>> +static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *b=
s,
>> +                                                    int64_t offset,
>> +                                                    int bytes,
>> +                                                    BdrvRequestFlags fl=
ags)
>> +{
>> +    int ret =3D 0;
>> +    BackupBlockJob *job =3D bs->opaque;
>> +    if (job) {
>> +        assert(bs =3D=3D blk_bs(job->common.blk));
>> +        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
>> +        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>> +        ret =3D backup_do_cow(job, offset, bytes, NULL, true);
>> +    }
>> +
>> +    return ret < 0 ? ret : bdrv_co_pwrite_zeroes(bs->file, offset, byte=
s,
>> +                                                 flags);
>> +}
>> +
>> +static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
>> +                                               int64_t offset, int byte=
s)
>> +{
>> +    int ret =3D 0;
>> +    BackupBlockJob *job =3D bs->opaque;
>> +    if (job) {
>> +        assert(bs =3D=3D blk_bs(job->common.blk));
>> +        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
>> +        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
>> +        ret =3D backup_do_cow(job, offset, bytes, NULL, true);
>> +    }
>> +
>> +    return ret < 0 ? ret : bdrv_co_pdiscard(bs->file->bs, offset, bytes=
);
>> +}
>> +
>> +static int backup_top_co_flush(BlockDriverState *bs)
>> +{
>> +    return bdrv_co_flush(bs->file->bs);
>> +}
>> +
>> +static int backup_top_open(BlockDriverState *bs, QDict *options,
>> +                           int flags, Error **errp)
>> +{
>> +    return 0;
>> +}
>> +
>> +static void backup_top_close(BlockDriverState *bs)
>> +{
>> +}
>> +
>> +static int64_t backup_top_getlength(BlockDriverState *bs)
>> +{
>> +    return bs->file ? bdrv_getlength(bs->file->bs) : 0;
>> +}
>> +
>> +static bool backup_recurse_is_first_non_filter(BlockDriverState *bs,
>> +                                               BlockDriverState *candid=
ate)
>> +{
>> +    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
>> +}
>> +
>> +static int64_t coroutine_fn backup_co_get_block_status(BlockDriverState=
 *bs,
>> +                                                       int64_t sector_n=
um,
>> +                                                       int nb_sectors,
>> +                                                       int *pnum,
>> +                                                       BlockDriverState=
 **file)
>> +{
>> +    assert(bs->file && bs->file->bs);
>> +    *pnum =3D nb_sectors;
>> +    *file =3D bs->file->bs;
>> +    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
>> +           (sector_num << BDRV_SECTOR_BITS);
>> +}
>> +static BlockDriver backup_top =3D {
>> +    .format_name                        =3D   "backup-top",
>> +    .instance_size                      =3D   sizeof(BackupBlockJob *),
>> +
>> +    .bdrv_open                          =3D   backup_top_open,
>
>.bdrv_open may be NULL.  There's no need to define this function.
>
>> +    .bdrv_close                         =3D   backup_top_close,
>> +
>> +    .bdrv_co_flush                      =3D   backup_top_co_flush,
>> +    .bdrv_co_preadv                     =3D   backup_top_co_preadv,
>> +    .bdrv_co_pwritev                    =3D   backup_top_co_pwritev,
>> +    .bdrv_co_pwrite_zeroes              =3D   backup_top_co_pwrite_zero=
es,
>> +    .bdrv_co_pdiscard                   =3D   backup_top_co_pdiscard,
>> +
>> +    .bdrv_getlength                     =3D   backup_top_getlength,
>> +    .bdrv_child_perm                    =3D   bdrv_filter_default_perms,
>> +    .bdrv_recurse_is_first_non_filter   =3D   backup_recurse_is_first_n=
on_filter,
>
>I think this is dead code since .is_filter =3D true.  It will not be
>called.

bdrv_recurse_is_first_non_filter() is only called if is_filter is true=20
and the driver implements it to allow recursion to its children.
>
>> +    .bdrv_co_get_block_status           =3D   backup_co_get_block_statu=
s,
>> +
>> +    .is_filter                          =3D   true,
>> +};
>> +
>>  BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>>                    BlockDriverState *target, int64_t speed,
>>                    MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitma=
p,
>> @@ -545,6 +682,7 @@ BlockJob *backup_job_create(const char *job_id, Bloc=
kDriverState *bs,
>>      int64_t len;
>>      BlockDriverInfo bdi;
>>      BackupBlockJob *job =3D NULL;
>> +    BlockDriverState *filter =3D NULL;
>>      int ret;
>>
>>      assert(bs);
>> @@ -606,17 +744,33 @@ BlockJob *backup_job_create(const char *job_id, Bl=
ockDriverState *bs,
>>                           bdrv_get_device_name(bs));
>>          goto error;
>>      }
>> +    /* Setup before write filter */
>> +    filter =3D
>> +        bdrv_new_open_driver(&backup_top,
>> +                             NULL, bdrv_get_flags(bs), NULL, &error_abo=
rt);
>> +    filter->implicit =3D true;
>> +    filter->total_sectors =3D bs->total_sectors;
>> +    bdrv_set_aio_context(filter, bdrv_get_aio_context(bs));
>> +
>> +    /* Insert before write notifier in the BDS chain */
>> +    bdrv_ref(filter);
>> +    bdrv_drained_begin(bs);
>> +    bdrv_append_file(filter, bs, &error_abort);
>> +    bdrv_drained_end(bs);
>>
>>      /* job->common.len is fixed, so we can't allow resize */
>> -    job =3D block_job_create(job_id, &backup_job_driver, bs,
>> +    job =3D block_job_create(job_id, &backup_job_driver, filter,
>>                             BLK_PERM_CONSISTENT_READ,
>>                             BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
>>                             BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MO=
D,
>>                             speed, creation_flags, cb, opaque, errp);
>> +    bdrv_unref(filter);
>>      if (!job) {
>>          goto error;
>>      }
>>
>> +    job->filter =3D filter;
>
>Is it okay to use filter here after bdrv_unref()?

Yes, this is only to make sure it won't get freed if bs doesn't have a=20
parent. It is a ref/unref pair around bdrv_append_file and=20
block_job_create, and filter will have refcnt >=3D 1 after the unref. I=20
will add a comment for clarification.=20

Thanks for the comments!

>
>> +
>>      /* The target must match the source in size, so no resize here eith=
er */
>>      job->target =3D blk_new(BLK_PERM_WRITE,
>>                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
>> @@ -675,6 +829,13 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>>      if (job) {
>>          backup_clean(&job->common);
>>          block_job_early_fail(&job->common);
>> +    } else {
>> +        /* don't leak filter if job creation failed */
>> +        if (filter) {
>> +            bdrv_child_try_set_perm(filter->file, 0, BLK_PERM_ALL,
>> +                                    &error_abort);
>> +            bdrv_replace_node(filter, bs, &error_abort);
>> +        }
>>      }
>>
>>      return NULL;
>> diff --git a/block/mirror.c b/block/mirror.c
>> index e1a160e6ea..3044472fd4 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1174,11 +1174,12 @@ static void mirror_start_job(const char *job_id,=
 BlockDriverState *bs,
>>      mirror_top_bs->total_sectors =3D bs->total_sectors;
>>      bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
>>
>> -    /* bdrv_append takes ownership of the mirror_top_bs reference, need=
 to keep
>> -     * it alive until block_job_create() succeeds even if bs has no par=
ent. */
>> +    /* bdrv_append_backing() takes ownership of the mirror_top_bs refer=
ence,
>> +     * need to keep it alive until block_job_create() succeeds even if =
bs has
>> +     * no parent. */
>>      bdrv_ref(mirror_top_bs);
>>      bdrv_drained_begin(bs);
>> -    bdrv_append(mirror_top_bs, bs, &local_err);
>> +    bdrv_append_backing(mirror_top_bs, bs, &local_err);
>>      bdrv_drained_end(bs);
>>
>>      if (local_err) {
>> diff --git a/blockdev.c b/blockdev.c
>> index 5c11c245b0..8e2fc6e64c 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -1788,7 +1788,7 @@ static void external_snapshot_prepare(BlkActionSta=
te *common,
>>       * can fail, so we need to do it in .prepare; undoing it for abort =
is
>>       * always possible. */
>>      bdrv_ref(state->new_bs);
>> -    bdrv_append(state->new_bs, state->old_bs, &local_err);
>> +    bdrv_append_backing(state->new_bs, state->old_bs, &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          return;
>> diff --git a/include/block/block.h b/include/block/block.h
>> index d1f03cb48b..744b50e734 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -244,8 +244,10 @@ int bdrv_create(BlockDriver *drv, const char* filen=
ame,
>>                  QemuOpts *opts, Error **errp);
>>  int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp=
);
>>  BlockDriverState *bdrv_new(void);
>> -void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
>> -                 Error **errp);
>> +void bdrv_append_file(BlockDriverState *bs_new, BlockDriverState *bs_to=
p,
>> +                      Error **errp);
>> +void bdrv_append_backing(BlockDriverState *bs_new, BlockDriverState *bs=
_top,
>> +                         Error **errp);
>>  void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
>>                         Error **errp);
>>
>> @@ -256,6 +258,8 @@ BdrvChild *bdrv_open_child(const char *filename,
>>                             BlockDriverState* parent,
>>                             const BdrvChildRole *child_role,
>>                             bool allow_none, Error **errp);
>> +void bdrv_set_file(BlockDriverState *bs, BlockDriverState *file_bs,
>> +                   Error **errp);
>>  void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backin=
g_hd,
>>                           Error **errp);
>>  int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>> diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
>> index 82e763b68d..cc653c317a 100644
>> --- a/tests/qemu-iotests/141.out
>> +++ b/tests/qemu-iotests/141.out
>> @@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048=
576 backing_file=3DTEST_DIR/m.
>>  {"return": {}}
>>  Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_fil=
e=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
>>  {"return": {}}
>> -{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
>> +{"error": {"class": "GenericError", "desc": "Block device drv0 is in us=
e"}}
>>  {"return": {}}
>>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "eve=
nt": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "off=
set": 0, "speed": 0, "type": "backup"}}
>>  {"return": {}}
>> --
>> 2.11.0
>>
>>



--6hai7ohqvlf6bb3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmUpwAACgkQc2J8L2kN
9xC4GBAAzdSjc+ateqFdI8dt39wf3hyx/uyiEIIKBtvr0wYw2TDQ6PFaP13HYlsY
roQIYuxJffuCrVxrdHpmF+L/fWTovRCBukJ14QvHCOJ/kEK1sJxCk35zDK3klf5+
JFgDYv2/weFgrdTyY82gjXt4M1bCQjep0VEmkc+sZ+vvYVLjVAmfcWdhC3+cd/vH
6X5bYlfmcu7y62Pr6PcRkEHKvJuj/cJrOSqCs6DpcbqshaFhYmofFia8ADKf7aaQ
sZ+WMu3D1C8v/XXlfC4moP7qyaHzJCRECUE4KrQjCIWQXa1OLdckvj/mkXXsiUja
HTuBpqmUcYpq9prvs2O4wJfi5haMDlvvpdMpaNgCSyen/JwYEdROxYdwpaFJQ6PH
iAwMkTK1Y3akH5H5YnFIn8f7oX6J9N3kQr1j3+7WA0EDCwyUTuDKIlz7z3DnLHsc
Ob2E3rhBR5ZJhTMC4k5X6viPozXsqyGoRxz2JPjM7WXd1CeJiXECwCnHmUMdJjIg
QBdIEEOmk9nRRHq2qLnG4qVb1JDik1BrIQw0seP3OYF/5Xg8Sv1SnTr1hkGx7u0W
J1pyLx3AssWoeL6dLL4XrpWVfNDeBmNagQi4YmulI7kLIqIqNNERdTB2Ugp3BDEH
BSmbR1L3gM8/1Ky19U7FwyuS7c6EOLWjsZYkZmyJfiKoERUnF7E=
=qlSu
-----END PGP SIGNATURE-----

--6hai7ohqvlf6bb3b--
