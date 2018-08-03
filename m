Received: from eggs.gnu.org ([2001:4830:134:3::10]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1flbsN-0000pT-E4
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1flbsI-0002h5-Bh
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 11:20:23 -0400
References: <20180618164504.24488-1-kwolf@redhat.com>
	<20180618164504.24488-34-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <733f0e7c-f86f-ad90-6f1c-71af74db20aa@virtuozzo.com>
Date: Fri, 3 Aug 2018 18:20:10 +0300
MIME-Version: 1.0
In-Reply-To: <20180618164504.24488-34-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PULL 33/35] block/mirror: Add active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

18.06.2018 19:45, Kevin Wolf wrote:
> From: Max Reitz <mreitz@redhat.com>
>
> This patch implements active synchronous mirroring.  In active mode, the
> passive mechanism will still be in place and is used to copy all
> initially dirty clusters off the source disk; but every write request
> will write data both to the source and the target disk, so the source
> cannot be dirtied faster than data is mirrored to the target.  Also,
> once the block job has converged (BLOCK_JOB_READY sent), source and
> target are guaranteed to stay in sync (unless an error occurs).
>
> Active mode is completely optional and currently disabled at runtime.  A
> later patch will add a way for users to enable it.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Message-id: 20180613181823.13618-13-mreitz@redhat.com
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json |  18 ++++
>   block/mirror.c       | 252 ++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   2 files changed, 265 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ab629d1647..96f8da1322 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1051,6 +1051,24 @@
>     'data': ['top', 'full', 'none', 'incremental'] }
>  =20
>   ##
> +# @MirrorCopyMode:
> +#
> +# An enumeration whose values tell the mirror block job when to
> +# trigger writes to the target.
> +#
> +# @background: copy data in background only.
> +#
> +# @write-blocking: when data is written to the source, write it
> +#                  (synchronously) to the target as well.  In
> +#                  addition, data is copied in background just like in
> +#                  @background mode.
> +#
> +# Since: 3.0
> +##
> +{ 'enum': 'MirrorCopyMode',
> +  'data': ['background', 'write-blocking'] }
> +
> +##
>   # @BlockJobInfo:
>   #
>   # Information about a long-running block device operation.
> diff --git a/block/mirror.c b/block/mirror.c
> index 7da5e43c0d..99b9b92c30 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -51,8 +51,12 @@ typedef struct MirrorBlockJob {
>       Error *replace_blocker;
>       bool is_none_mode;
>       BlockMirrorBackingMode backing_mode;
> +    MirrorCopyMode copy_mode;
>       BlockdevOnError on_source_error, on_target_error;
>       bool synced;
> +    /* Set when the target is synced (dirty bitmap is clean, nothing
> +     * in flight) and the job is running in active mode */
> +    bool actively_synced;
>       bool should_complete;
>       int64_t granularity;
>       size_t buf_size;
> @@ -74,6 +78,7 @@ typedef struct MirrorBlockJob {
>       int target_cluster_size;
>       int max_iov;
>       bool initial_zeroing_ongoing;
> +    int in_active_write_counter;
>   } MirrorBlockJob;
>  =20
>   typedef struct MirrorBDSOpaque {
> @@ -91,6 +96,7 @@ struct MirrorOp {
>       int64_t *bytes_handled;
>  =20
>       bool is_pseudo_op;
> +    bool is_active_write;
>       CoQueue waiting_requests;
>  =20
>       QTAILQ_ENTRY(MirrorOp) next;
> @@ -106,6 +112,7 @@ static BlockErrorAction mirror_error_action(MirrorBlo=
ckJob *s, bool read,
>                                               int error)
>   {
>       s->synced =3D false;
> +    s->actively_synced =3D false;
>       if (read) {
>           return block_job_error_action(&s->common, s->on_source_error,
>                                         true, error);
> @@ -272,7 +279,7 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_=
t *offset,
>       return ret;
>   }
>  =20
> -static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s=
)
> +static inline void mirror_wait_for_any_operation(MirrorBlockJob *s, bool=
 active)
>   {
>       MirrorOp *op;
>  =20
> @@ -282,7 +289,7 @@ static inline void mirror_wait_for_free_in_flight_slo=
t(MirrorBlockJob *s)
>            * caller of this function.  Since there is only one pseudo op
>            * at any given time, we will always find some real operation
>            * to wait on. */
> -        if (!op->is_pseudo_op) {
> +        if (!op->is_pseudo_op && op->is_active_write =3D=3D active) {
>               qemu_co_queue_wait(&op->waiting_requests, NULL);
>               return;
>           }
> @@ -290,6 +297,12 @@ static inline void mirror_wait_for_free_in_flight_sl=
ot(MirrorBlockJob *s)
>       abort();
>   }
>  =20
> +static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s=
)
> +{
> +    /* Only non-active operations use up in-flight slots */
> +    mirror_wait_for_any_operation(s, false);
> +}
> +
>   /* Perform a mirror copy operation.
>    *
>    * *op->bytes_handled is set to the number of bytes copied after and
> @@ -846,6 +859,7 @@ static void coroutine_fn mirror_run(void *opaque)
>           /* Transition to the READY state and wait for complete. */
>           job_transition_to_ready(&s->common.job);
>           s->synced =3D true;
> +        s->actively_synced =3D true;
>           while (!job_is_cancelled(&s->common.job) && !s->should_complete=
) {
>               job_yield(&s->common.job);
>           }
> @@ -897,6 +911,12 @@ static void coroutine_fn mirror_run(void *opaque)
>           int64_t cnt, delta;
>           bool should_complete;
>  =20
> +        /* Do not start passive operations while there are active
> +         * writes in progress */
> +        while (s->in_active_write_counter) {
> +            mirror_wait_for_any_operation(s, true);
> +        }
> +
>           if (s->ret < 0) {
>               ret =3D s->ret;
>               goto immediate_exit;
> @@ -942,6 +962,9 @@ static void coroutine_fn mirror_run(void *opaque)
>                    */
>                   job_transition_to_ready(&s->common.job);
>                   s->synced =3D true;
> +                if (s->copy_mode !=3D MIRROR_COPY_MODE_BACKGROUND) {
> +                    s->actively_synced =3D true;
> +                }
>               }
>  =20
>               should_complete =3D s->should_complete ||
> @@ -1140,16 +1163,232 @@ static const BlockJobDriver commit_active_job_dr=
iver =3D {
>       .drain                  =3D mirror_drain,
>   };
>  =20
> +static void do_sync_target_write(MirrorBlockJob *job, MirrorMethod metho=
d,
> +                                 uint64_t offset, uint64_t bytes,
> +                                 QEMUIOVector *qiov, int flags)
> +{
> +    BdrvDirtyBitmapIter *iter;
> +    QEMUIOVector target_qiov;
> +    uint64_t dirty_offset;
> +    int dirty_bytes;
> +
> +    if (qiov) {
> +        qemu_iovec_init(&target_qiov, qiov->niov);
> +    }
> +
> +    iter =3D bdrv_dirty_iter_new(job->dirty_bitmap);
> +    bdrv_set_dirty_iter(iter, offset);

if offset is not a multiple of bitmap granularity, first result of=20
hbitmap_iter_next may be less than offset (actually, offset rounded down=20
to granularity bound). Is it ok?

> +
> +    while (true) {
> +        bool valid_area;
> +        int ret;
> +
> +        bdrv_dirty_bitmap_lock(job->dirty_bitmap);
> +        valid_area =3D bdrv_dirty_iter_next_area(iter, offset + bytes,
> +                                               &dirty_offset, &dirty_byt=
es);
> +        if (!valid_area) {

we can skip here a small peace of dirty area, look at may comment to=C2=A0=
=20
"[PULL 30/35] block/dirty-bitmap: Add bdrv_dirty_iter_next_area", is it=20
ok too?

> +            bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
> +            break;
> +        }
> +
> +        bdrv_reset_dirty_bitmap_locked(job->dirty_bitmap,
> +                                       dirty_offset, dirty_bytes);
> +        bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
> +
> +        job_progress_increase_remaining(&job->common.job, dirty_bytes);
> +
> +        assert(dirty_offset - offset <=3D SIZE_MAX);
> +        if (qiov) {
> +            qemu_iovec_reset(&target_qiov);
> +            qemu_iovec_concat(&target_qiov, qiov,
> +                              dirty_offset - offset, dirty_bytes);
> +        }
> +
> +        switch (method) {
> +        case MIRROR_METHOD_COPY:
> +            ret =3D blk_co_pwritev(job->target, dirty_offset, dirty_byte=
s,
> +                                 qiov ? &target_qiov : NULL, flags);
> +            break;
> +
> +        case MIRROR_METHOD_ZERO:
> +            assert(!qiov);
> +            ret =3D blk_co_pwrite_zeroes(job->target, dirty_offset, dirt=
y_bytes,
> +                                       flags);
> +            break;
> +
> +        case MIRROR_METHOD_DISCARD:
> +            assert(!qiov);
> +            ret =3D blk_co_pdiscard(job->target, dirty_offset, dirty_byt=
es);
> +            break;
> +
> +        default:
> +            abort();
> +        }
> +
> +        if (ret >=3D 0) {
> +            job_progress_update(&job->common.job, dirty_bytes);
> +        } else {
> +            BlockErrorAction action;
> +
> +            bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_offset, dirty=
_bytes);
> +            job->actively_synced =3D false;
> +
> +            action =3D mirror_error_action(job, false, -ret);
> +            if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
> +                if (!job->ret) {
> +                    job->ret =3D ret;
> +                }
> +                break;
> +            }
> +        }
> +    }
> +
> +    bdrv_dirty_iter_free(iter);
> +    if (qiov) {
> +        qemu_iovec_destroy(&target_qiov);
> +    }
> +}
> +
> +static MirrorOp *coroutine_fn active_write_prepare(MirrorBlockJob *s,
> +                                                   uint64_t offset,
> +                                                   uint64_t bytes)
> +{
> +    MirrorOp *op;
> +    uint64_t start_chunk =3D offset / s->granularity;
> +    uint64_t end_chunk =3D DIV_ROUND_UP(offset + bytes, s->granularity);
> +
> +    op =3D g_new(MirrorOp, 1);
> +    *op =3D (MirrorOp){
> +        .s                  =3D s,
> +        .offset             =3D offset,
> +        .bytes              =3D bytes,
> +        .is_active_write    =3D true,
> +    };
> +    qemu_co_queue_init(&op->waiting_requests);
> +    QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
> +
> +    s->in_active_write_counter++;
> +
> +    mirror_wait_on_conflicts(op, s, offset, bytes);
> +
> +    bitmap_set(s->in_flight_bitmap, start_chunk, end_chunk - start_chunk=
);
> +
> +    return op;
> +}
> +
> +static void coroutine_fn active_write_settle(MirrorOp *op)
> +{
> +    uint64_t start_chunk =3D op->offset / op->s->granularity;
> +    uint64_t end_chunk =3D DIV_ROUND_UP(op->offset + op->bytes,
> +                                      op->s->granularity);
> +
> +    if (!--op->s->in_active_write_counter && op->s->actively_synced) {
> +        BdrvChild *source =3D op->s->mirror_top_bs->backing;
> +
> +        if (QLIST_FIRST(&source->bs->parents) =3D=3D source &&
> +            QLIST_NEXT(source, next_parent) =3D=3D NULL)
> +        {
> +            /* Assert that we are back in sync once all active write
> +             * operations are settled.
> +             * Note that we can only assert this if the mirror node
> +             * is the source node's only parent. */
> +            assert(!bdrv_get_dirty_count(op->s->dirty_bitmap));
> +        }
> +    }
> +    bitmap_clear(op->s->in_flight_bitmap, start_chunk, end_chunk - start=
_chunk);
> +    QTAILQ_REMOVE(&op->s->ops_in_flight, op, next);
> +    qemu_co_queue_restart_all(&op->waiting_requests);
> +    g_free(op);
> +}
> +
>   static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
>       uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
>   {
>       return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
>   }
>  =20
> +static int coroutine_fn bdrv_mirror_top_do_write(BlockDriverState *bs,
> +    MirrorMethod method, uint64_t offset, uint64_t bytes, QEMUIOVector *=
qiov,
> +    int flags)
> +{
> +    MirrorOp *op =3D NULL;
> +    MirrorBDSOpaque *s =3D bs->opaque;
> +    int ret =3D 0;
> +    bool copy_to_target;
> +
> +    copy_to_target =3D s->job->ret >=3D 0 &&
> +                     s->job->copy_mode =3D=3D MIRROR_COPY_MODE_WRITE_BLO=
CKING;
> +
> +    if (copy_to_target) {
> +        op =3D active_write_prepare(s->job, offset, bytes);
> +    }
> +
> +    switch (method) {
> +    case MIRROR_METHOD_COPY:
> +        ret =3D bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags)=
;
> +        break;
> +
> +    case MIRROR_METHOD_ZERO:
> +        ret =3D bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags)=
;
> +        break;
> +
> +    case MIRROR_METHOD_DISCARD:
> +        ret =3D bdrv_co_pdiscard(bs->backing->bs, offset, bytes);
> +        break;
> +
> +    default:
> +        abort();
> +    }
> +
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    if (copy_to_target) {
> +        do_sync_target_write(s->job, method, offset, bytes, qiov, flags)=
;
> +    }
> +
> +out:
> +    if (copy_to_target) {
> +        active_write_settle(op);
> +    }
> +    return ret;
> +}
> +
>   static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
>       uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
>   {
> -    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
> +    MirrorBDSOpaque *s =3D bs->opaque;
> +    QEMUIOVector bounce_qiov;
> +    void *bounce_buf;
> +    int ret =3D 0;
> +    bool copy_to_target;
> +
> +    copy_to_target =3D s->job->ret >=3D 0 &&
> +                     s->job->copy_mode =3D=3D MIRROR_COPY_MODE_WRITE_BLO=
CKING;
> +
> +    if (copy_to_target) {
> +        /* The guest might concurrently modify the data to write; but
> +         * the data on source and destination must match, so we have
> +         * to use a bounce buffer if we are going to write to the
> +         * target now. */
> +        bounce_buf =3D qemu_blockalign(bs, bytes);
> +        iov_to_buf_full(qiov->iov, qiov->niov, 0, bounce_buf, bytes);
> +
> +        qemu_iovec_init(&bounce_qiov, 1);
> +        qemu_iovec_add(&bounce_qiov, bounce_buf, bytes);
> +        qiov =3D &bounce_qiov;
> +    }
> +
> +    ret =3D bdrv_mirror_top_do_write(bs, MIRROR_METHOD_COPY, offset, byt=
es, qiov,
> +                                   flags);
> +
> +    if (copy_to_target) {
> +        qemu_iovec_destroy(&bounce_qiov);
> +        qemu_vfree(bounce_buf);
> +    }
> +
> +    return ret;
>   }
>  =20
>   static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
> @@ -1164,13 +1403,15 @@ static int coroutine_fn bdrv_mirror_top_flush(Blo=
ckDriverState *bs)
>   static int coroutine_fn bdrv_mirror_top_pwrite_zeroes(BlockDriverState =
*bs,
>       int64_t offset, int bytes, BdrvRequestFlags flags)
>   {
> -    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
> +    return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_ZERO, offset, byte=
s, NULL,
> +                                    flags);
>   }
>  =20
>   static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
>       int64_t offset, int bytes)
>   {
> -    return bdrv_co_pdiscard(bs->backing->bs, offset, bytes);
> +    return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_DISCARD, offset, b=
ytes,
> +                                    NULL, 0);
>   }
>  =20
>   static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDic=
t *opts)
> @@ -1340,6 +1581,7 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
>       s->on_target_error =3D on_target_error;
>       s->is_none_mode =3D is_none_mode;
>       s->backing_mode =3D backing_mode;
> +    s->copy_mode =3D MIRROR_COPY_MODE_BACKGROUND;
>       s->base =3D base;
>       s->granularity =3D granularity;
>       s->buf_size =3D ROUND_UP(buf_size, granularity);


--=20
Best regards,
Vladimir
