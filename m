Received: from eggs.gnu.org ([2001:4830:134:3::10]:55527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxXK-0002BD-Eu
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxXI-0000aC-W5
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:13:34 -0500
Date: Wed, 1 Feb 2017 16:13:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170201161321.GA12283@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-19-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-19-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 18/21] backup: new async
 architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:29:01PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> @@ -120,11 +257,42 @@ static bool coroutine_fn yield_and_check(BackupBloc=
kJob *job)
>          uint64_t delay_ns =3D ratelimit_calculate_delay(&job->limit,
>                                                        job->sectors_read);
>          job->sectors_read =3D 0;
> +        job->delayed =3D true;
> +        trace_backup_sleep_delay(block_job_is_cancelled(&job->common),
> +                                 block_job_should_pause(&job->common));
>          block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, delay_ns);
> +        job->delayed =3D false;
>      } else {
> -        block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, 0);
> +        trace_backup_sleep_zero(block_job_is_cancelled(&job->common),
> +                                block_job_should_pause(&job->common));
> +        block_job_pause_point(&job->common);
> +    }
> +
> +    trace_backup_sleep_finish();
> +}
> +
> +/* backup_busy_sleep
> + * Just yield, without setting busy=3Dfalse

How does this interact with block_job_detach_aio_context() and
block_job_drain()?  Jobs must reach pause points regularly so that
cancellation and detaching AioContexts works.

> @@ -132,69 +300,246 @@ static bool coroutine_fn yield_and_check(BackupBlo=
ckJob *job)
>      return false;
>  }
> =20
> -static int coroutine_fn backup_do_read(BackupBlockJob *job,
> -                                       int64_t offset, unsigned int byte=
s,
> -                                       QEMUIOVector *qiov)
> +static void backup_job_wait_workers(BackupBlockJob *job)

Missing coroutine_fn.  This function yields and will crash unless called
=66rom coroutine context.  Please use coroutine_fn throughout the code so
it's clear when a function is only allowed to be called from coroutine
context.

> +static void backup_worker_pause(BackupBlockJob *job)
> +{
> +    job->nb_busy_workers--;
> +
> +    trace_backup_worker_pause(qemu_coroutine_self(), job->nb_busy_worker=
s,
> +                              job->waiting_for_workers);
> +
> +    if (job->nb_busy_workers =3D=3D 0 && job->waiting_for_workers) {
> +        qemu_coroutine_add_next(job->common.co);
> +    }
> +
> +    qemu_co_queue_wait(&job->paused_workers);
> +
> +    trace_backup_worker_unpause(qemu_coroutine_self());
> +
> +    job->nb_busy_workers++;

This is similar to rwlock.  The main coroutine would use wrlock and the
workers would use rdlock.

rwlock avoids situations where the main blockjob re-enters a worker and
vice versa.  qemu_coroutine_add_next() is a lower-level primitive and
does not prevent this type of bug.

Please use rwlock.

> +static inline bool check_delay(BackupBlockJob *job)
> +{
> +    uint64_t delay_ns;
> +
> +    if (!job->common.speed) {
> +        return false;
> +    }
> +
> +    delay_ns =3D ratelimit_calculate_delay(&job->limit, job->sectors_rea=
d);
> +    job->sectors_read =3D 0;
> +
> +    if (delay_ns =3D=3D 0) {
> +        if (job->delayed) {
> +            job->delayed =3D false;
> +            qemu_co_queue_restart_all(&job->paused_workers);
>          }
> +        return false;
> +    }
> =20
> -        return ret;
> +    return job->delayed =3D true;

This looks like a "=3D=3D vs =3D" bug.  Please reformat it so readers don't
have to puzzle out what you meant:

job->delayed =3D true;
return true;

> +static void coroutine_fn backup_worker_co(void *opaque)
> +{
> +    BackupBlockJob *job =3D opaque;
> +
> +    job->running_workers++;
> +    job->nb_busy_workers++;
> +
> +    while (true) {
> +        int64_t cluster =3D backup_get_work(job);
> +        trace_backup_worker_got_work(job, qemu_coroutine_self(), cluster=
);
> +
> +        switch (cluster) {
> +        case BACKUP_WORKER_STOP:
> +            job->nb_busy_workers--;
> +            job->running_workers--;
> +            if (job->nb_busy_workers =3D=3D 0 && job->waiting_for_worker=
s) {
> +                qemu_coroutine_add_next(job->common.co);

Is there a reason for using qemu_coroutine_add_next() instead of
qemu_coroutine_enter()?

I think neither function prevents a crash if backup_get_work() returns
BACKUP_WORKER_STOP and this coroutine has never yielded yet.  We would
try to re-enter the main blockjob coroutine.

>  static int coroutine_fn backup_before_write_notify(
>          NotifierWithReturn *notifier,
>          void *opaque)
>  {
> -    BackupBlockJob *job =3D container_of(notifier, BackupBlockJob, befor=
e_write);
> -    BdrvTrackedRequest *req =3D opaque;
> -    int64_t sector_num =3D req->offset >> BDRV_SECTOR_BITS;
> -    int nb_sectors =3D req->bytes >> BDRV_SECTOR_BITS;
> +    BdrvTrackedRequest *tr =3D opaque;
> +    NotifierRequest *nr;
> +    BackupBlockJob *job =3D (BackupBlockJob *)tr->bs->job;
> +    int64_t start =3D tr->offset / job->cluster_size;
> +    int64_t end =3D DIV_ROUND_UP(tr->offset + tr->bytes, job->cluster_si=
ze);
> +    int ret =3D 0;
> +
> +    assert((tr->offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> +    assert((tr->bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);

Are these assertions still necessary?  req->bytes >> BDRV_SECTOR_BITS
rounds down so we needed a multiple of BDRV_SECTOR_SIZE.  Now
DIV_ROUND_UP() is used so it doesn't matter.

> +
> +    nr =3D add_notif_req(job, start, end, qemu_coroutine_self());
> =20
> -    assert(req->bs =3D=3D blk_bs(job->common.blk));
> -    assert((req->offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> -    assert((req->bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
> +    if (nr =3D=3D NULL) {
> +        trace_backup_before_write_notify_skip(job, tr->offset, tr->bytes=
);
> +    } else {
> +        trace_backup_before_write_notify_start(job, tr->offset, tr->byte=
s, nr,
> +                                               nr->start, nr->end, nr->n=
b_wait);
> +
> +        if (!job->has_errors) {
> +            qemu_co_queue_restart_all(&job->paused_workers);
> +        }
> +        co_aio_sleep_ns(blk_get_aio_context(job->common.blk),
> +                        QEMU_CLOCK_REALTIME, WRITE_NOTIFY_TIMEOUT_NS);
> +        if (nr->nb_wait > 0) {
> +            /* timer expired and read request not finished */
> +            ret =3D -EINVAL;

#define	EINVAL		22	/* Invalid argument */

Why did you choose this errno?

EIO is the errno that kernel uses when I/O fails (e.g. hardware timeout).

> @@ -586,50 +923,62 @@ static void coroutine_fn backup_run(void *opaque)
>      BackupCompleteData *data;
>      BlockDriverState *bs =3D blk_bs(job->common.blk);
>      int64_t end;
> -    int ret =3D 0;
> +    int i;
> +    bool is_top =3D job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP;
> +    bool is_full =3D job->sync_mode =3D=3D MIRROR_SYNC_MODE_FULL;
> +
> +    trace_backup_run();

This trace event isn't useful if the guest has multiple drives.  Please
include arguments that correlate the event with specific objects like
the BlockBackend/BlockDriverState/BlockJob instances, I/O request sector
and length, etc.

>  BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError o=
n_err,
>                                          int is_read, int error)
>  {

block_job_get_error_action() was copy-pasted from
block_job_error_action().  Now there are two functions with similar
names that duplicate code.

Why can't you use the existing block_job_error_action() function?

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkgkhAAoJEJykq7OBq3PIrIoH/1VQnEeYLV9oRLHi1VvMXnV6
jBcHl+EUv50dW2Jl2cz8/PZ2JrxDgJVKJhYoXHIMdEczp5KrnMIDKr52TVZKew2C
w0DJNiJC4TzTcd84Q2/02e5/OTPbwXsmJpfVtTFaqZAdj0rIA45h/gqmXtv+O12S
17h5TBI+hjkuPJO0uqnedhriJ4JG7MTIDQFl9IdPqA29/Tg9xOb4dALzSVE9fIUV
ghuNiYUDO3ACM6UboGV+ELT2fU3Vuq3SAODC/q40YV2FDRxADgn3+ZDI1fgfYrAQ
MWokScfGrgs3wk/pXL5C+iU/PbuUv1qBQASRoKhp2ISPcElbujr+fVKArkbWHJY=
=3X07
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
