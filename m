Received: from eggs.gnu.org ([2001:4830:134:3::10]:52635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB59F-0008Ap-NU
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB59D-0008CJ-KP
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:06:49 -0400
References: <20180424152515.25664-1-kwolf@redhat.com>
	<20180424152515.25664-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c178709a-ebdd-171a-1db7-5b4a2416de53@redhat.com>
Date: Tue, 24 Apr 2018 16:06:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180424152515.25664-2-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xog4xi3ttmTDvHYPfmmUExcMZKkfmKmoe"
Subject: Re: [Qemu-devel] [RFC PATCH 01/33] blockjob: Wrappers for progress
 counter access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xog4xi3ttmTDvHYPfmmUExcMZKkfmKmoe
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <c178709a-ebdd-171a-1db7-5b4a2416de53@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 01/33] blockjob: Wrappers for progress
 counter access
References: <20180424152515.25664-1-kwolf@redhat.com>
 <20180424152515.25664-2-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:24 AM, Kevin Wolf wrote:
> Block job drivers are not expected to mess with the internal of the

s/internal/internals/

> BlockJob object, so provide wrapper functions for one of the cases wher=
e
> they still do it: Updating the progress counter.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/include/block/blockjob.h
> @@ -278,6 +278,25 @@ void block_job_finalize(BlockJob *job, Error **err=
p);
>  void block_job_dismiss(BlockJob **job, Error **errp);
> =20
>  /**
> + * block_job_progress_update:
> + * @job: The job that has made progress
> + * @done: How much progress the job made
> + *
> + * Updates the progress counter of the job.
> + */
> +void block_job_progress_update(BlockJob *job, uint64_t done);

We already document (and libvirt does as well) that a job progress meter
does not necessarily represent anything obviously correlating to the
real job, other than that the ratio between them serves as an estimate
of completion; and that we are free to move not only the progress
indicator, but also the end goal, over the course of a job, and that a
job can even appear to move backwards when comparing the ratios (for
example, getting the pairs 0/1, 1/1000, 50/1000, 800/1200, 800/1300,
1200/1300, 1/1 over the life of a job is a valid possibility for a
sequence, including the apparent backwards motion at the 800/1300 step).
 But this new API only modifies one of the two (arbitrary) stats - is
that sufficient?

/me reads on...

> +
> +/**
> + * block_job_progress_set_remaining:
> + * @job: The job whose expected progress end value is set
> + * @remaining: Expected end value of the progress counter of the job
> + *
> + * Sets the expected end value of the progress counter of a job so tha=
t a
> + * completion percentage can be calculated when the progress is update=
d.
> + */
> +void block_job_progress_set_remaining(BlockJob *job, uint64_t remainin=
g);

=2E..Oh. You have two separate functions to modify the two arbitrary
values at will.  Why not just a single function?  Maybe seeing how the
callers use it will demonstrate that two separate functions is slightly
easier...

> +
> +/**
>   * block_job_query:
>   * @job: The job to get information about.
>   *
> diff --git a/block/backup.c b/block/backup.c
> index 453cd62c24..5d95805472 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -39,6 +39,7 @@ typedef struct BackupBlockJob {
>      BlockdevOnError on_source_error;
>      BlockdevOnError on_target_error;
>      CoRwlock flush_rwlock;
> +    uint64_t len;
>      uint64_t bytes_read;
>      int64_t cluster_size;
>      bool compress;
> @@ -118,7 +119,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJo=
b *job,
> =20
>          trace_backup_do_cow_process(job, start);
> =20
> -        n =3D MIN(job->cluster_size, job->common.len - start);
> +        n =3D MIN(job->cluster_size, job->len - start);
> =20
>          if (!bounce_buffer) {
>              bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
> @@ -159,7 +160,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJo=
b *job,
>           * offset field is an opaque progress value, it is not a disk =
offset.
>           */
>          job->bytes_read +=3D n;
> -        job->common.offset +=3D n;
> +        block_job_progress_update(&job->common, n);

=2E..Okay, when the end goal isn't changing, updating just the progress i=
s
indeed a bit easier.

>      }
> =20
>  out:
> @@ -261,7 +262,7 @@ void backup_do_checkpoint(BlockJob *job, Error **er=
rp)
>          return;
>      }
> =20
> -    len =3D DIV_ROUND_UP(backup_job->common.len, backup_job->cluster_s=
ize);
> +    len =3D DIV_ROUND_UP(backup_job->len, backup_job->cluster_size);
>      hbitmap_set(backup_job->copy_bitmap, 0, len);
>  }
> =20
> @@ -420,8 +421,9 @@ static void backup_incremental_init_copy_bitmap(Bac=
kupBlockJob *job)
>          bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
>      }
> =20
> -    job->common.offset =3D job->common.len -
> -                         hbitmap_count(job->copy_bitmap) * job->cluste=
r_size;
> +    /* TODO block_job_progress_set_remaining() would make more sense *=
/
> +    block_job_progress_update(&job->common,
> +        job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size=
);

Hmm. The old code couldn't touch job->common.len; the new code now has
two separate lengths (job->len that can't be touched, and
job->common.len that is now internal to stat reporting and therefore no
longer something that we can't touch).  The old code makes the job skip
forward according to the size of the bitmap that is not set (since we
don't have to do any work on that portion), which could indeed be a
rapid skip followed by the rest of the job moving at a slower pace;
where the new code could perhaps instead modify the goal to match just
the size that the bitmap occupies, so that the progress is more linearly
related.  So you're right that
block_job_progress_set_remaining(-hbitmap_count(job->copy_bitmap) *
job->cluster_size) (the negative adjustment is intentional) might make
more sense (or, using some example numbers, the difference is between
going from 0/1000 to 200/1000, where the rest of the job crawls up to
1000/1000, pre-patch and as written; vs. going from 0/1000 to 0/800
here, then the rest of the job crawling up to 800/800, if you used
progress_set_remaining).

But as I read it, you took the conservative approach of this patch
preserving the existing progression through the counters, where we can
save a different (smoother?) progression for a separate patch.  That's
reasonable.

> =20
>      bdrv_dirty_iter_free(dbi);
>  }
> @@ -437,7 +439,9 @@ static void coroutine_fn backup_run(void *opaque)
>      QLIST_INIT(&job->inflight_reqs);
>      qemu_co_rwlock_init(&job->flush_rwlock);
> =20
> -    nb_clusters =3D DIV_ROUND_UP(job->common.len, job->cluster_size);
> +    nb_clusters =3D DIV_ROUND_UP(job->len, job->cluster_size);
> +    block_job_progress_set_remaining(&job->common, job->len);

Whereas the old code overloaded job->common.len for two purposes, the
new code now has to initialize both a local variable and the progress
meter, separating the two purposes into two variables.

> +
>      job->copy_bitmap =3D hbitmap_alloc(nb_clusters, 0);
>      if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
>          backup_incremental_init_copy_bitmap(job);
> @@ -461,7 +465,7 @@ static void coroutine_fn backup_run(void *opaque)
>          ret =3D backup_run_incremental(job);
>      } else {
>          /* Both FULL and TOP SYNC_MODE's require copying.. */
> -        for (offset =3D 0; offset < job->common.len;
> +        for (offset =3D 0; offset < job->len;
>               offset +=3D job->cluster_size) {
>              bool error_is_read;
>              int alloced =3D 0;
> @@ -620,7 +624,7 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>          goto error;
>      }
> =20
> -    /* job->common.len is fixed, so we can't allow resize */
> +    /* job->len is fixed, so we can't allow resize */
>      job =3D block_job_create(job_id, &backup_job_driver, txn, bs,
>                             BLK_PERM_CONSISTENT_READ,
>                             BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |=

> @@ -676,7 +680,7 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>      /* Required permissions are already taken with target's blk_new() =
*/
>      block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL=
,
>                         &error_abort);
> -    job->common.len =3D len;
> +    job->len =3D len;
> =20
>      return &job->common;

Took me a few minutes to review, but the conversion in this file looks sa=
ne.

> =20
> diff --git a/block/commit.c b/block/commit.c
> index 1432baeef4..50b191c980 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -146,21 +146,21 @@ static void coroutine_fn commit_run(void *opaque)=

>      int64_t n =3D 0; /* bytes */
>      void *buf =3D NULL;
>      int bytes_written =3D 0;
> -    int64_t base_len;
> +    int64_t len, base_len;
> =20
> -    ret =3D s->common.len =3D blk_getlength(s->top);
> -
> -    if (s->common.len < 0) {
> +    ret =3D len =3D blk_getlength(s->top);
> +    if (len < 0) {
>          goto out;
>      }
> +    block_job_progress_set_remaining(&s->common, len);

Again, a separation of two purposes, so now you have to initialize two
locations.

> =20
>      ret =3D base_len =3D blk_getlength(s->base);
>      if (base_len < 0) {
>          goto out;
>      }
> =20
> -    if (base_len < s->common.len) {
> -        ret =3D blk_truncate(s->base, s->common.len, PREALLOC_MODE_OFF=
, NULL);
> +    if (base_len < len) {
> +        ret =3D blk_truncate(s->base, len, PREALLOC_MODE_OFF, NULL);
>          if (ret) {
>              goto out;
>          }
> @@ -168,7 +168,7 @@ static void coroutine_fn commit_run(void *opaque)
> =20
>      buf =3D blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
> =20
> -    for (offset =3D 0; offset < s->common.len; offset +=3D n) {
> +    for (offset =3D 0; offset < len; offset +=3D n) {
>          bool copy;
> =20
>          /* Note that even when no rate limit is applied we need to yie=
ld
> @@ -198,7 +198,7 @@ static void coroutine_fn commit_run(void *opaque)
>              }
>          }
>          /* Publish progress */
> -        s->common.offset +=3D n;
> +        block_job_progress_update(&s->common, n);

This one's an easier conversion.

> =20
>          if (copy && s->common.speed) {
>              delay_ns =3D ratelimit_calculate_delay(&s->limit, n);
> diff --git a/block/mirror.c b/block/mirror.c
> index 820f512c7b..0e09e6fffb 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -121,7 +121,7 @@ static void mirror_iteration_done(MirrorOp *op, int=
 ret)
>              bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
>          }
>          if (!s->initial_zeroing_ongoing) {
> -            s->common.offset +=3D op->bytes;
> +            block_job_progress_update(&s->common, op->bytes);
>          }
>      }
>      qemu_iovec_destroy(&op->qiov);
> @@ -792,11 +792,10 @@ static void coroutine_fn mirror_run(void *opaque)=

>          block_job_pause_point(&s->common);
> =20
>          cnt =3D bdrv_get_dirty_count(s->dirty_bitmap);
> -        /* s->common.offset contains the number of bytes already proce=
ssed so
> -         * far, cnt is the number of dirty bytes remaining and
> -         * s->bytes_in_flight is the number of bytes currently being
> -         * processed; together those are the current total operation l=
ength */
> -        s->common.len =3D s->common.offset + s->bytes_in_flight + cnt;=

> +        /* cnt is the number of dirty bytes remaining and s->bytes_in_=
flight is
> +         * the number of bytes currently being processed; together tho=
se are
> +         * the current total operation length */
> +        block_job_progress_set_remaining(&s->common, s->bytes_in_fligh=
t + cnt);

Also makes sense (once I look ahead and see that
progress_set_remaining() adds in the current offset).

> =20
>          /* Note that even when no rate limit is applied we need to yie=
ld
>           * periodically with no pending I/O so that bdrv_drain_all() r=
eturns.
> diff --git a/block/stream.c b/block/stream.c
> index 1a85708fcf..8369852bda 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -107,6 +107,7 @@ static void coroutine_fn stream_run(void *opaque)
>      BlockBackend *blk =3D s->common.blk;
>      BlockDriverState *bs =3D blk_bs(blk);
>      BlockDriverState *base =3D s->base;
> +    int64_t len;
>      int64_t offset =3D 0;
>      uint64_t delay_ns =3D 0;
>      int error =3D 0;
> @@ -118,11 +119,12 @@ static void coroutine_fn stream_run(void *opaque)=

>          goto out;
>      }
> =20
> -    s->common.len =3D bdrv_getlength(bs);
> -    if (s->common.len < 0) {
> -        ret =3D s->common.len;
> +    len =3D bdrv_getlength(bs);
> +    if (len < 0) {
> +        ret =3D len;
>          goto out;
>      }
> +    block_job_progress_set_remaining(&s->common, len);

And another separation.

> =20
>      buf =3D qemu_blockalign(bs, STREAM_BUFFER_SIZE);
> =20
> @@ -135,7 +137,7 @@ static void coroutine_fn stream_run(void *opaque)
>          bdrv_enable_copy_on_read(bs);
>      }
> =20
> -    for ( ; offset < s->common.len; offset +=3D n) {
> +    for ( ; offset < len; offset +=3D n) {
>          bool copy;
> =20
>          /* Note that even when no rate limit is applied we need to yie=
ld
> @@ -159,7 +161,7 @@ static void coroutine_fn stream_run(void *opaque)
> =20
>              /* Finish early if end of backing file has been reached */=

>              if (ret =3D=3D 0 && n =3D=3D 0) {
> -                n =3D s->common.len - offset;
> +                n =3D len - offset;
>              }
> =20
>              copy =3D (ret =3D=3D 1);
> @@ -185,7 +187,7 @@ static void coroutine_fn stream_run(void *opaque)
>          ret =3D 0;
> =20
>          /* Publish progress */
> -        s->common.offset +=3D n;
> +        block_job_progress_update(&s->common, n);

Okay.

>          if (copy && s->common.speed) {
>              delay_ns =3D ratelimit_calculate_delay(&s->limit, n);
>          } else {
> diff --git a/blockjob.c b/blockjob.c
> index 27f957e571..46c8923986 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -810,6 +810,16 @@ int block_job_complete_sync(BlockJob *job, Error *=
*errp)
>      return block_job_finish_sync(job, &block_job_complete, errp);
>  }
> =20
> +void block_job_progress_update(BlockJob *job, uint64_t done)
> +{
> +    job->offset +=3D done;
> +}
> +
> +void block_job_progress_set_remaining(BlockJob *job, uint64_t remainin=
g)

You'd want this to be int64_t if you intend for callers to pass in a
negative value (to adjust the initial estimate down by the amount of
work quickly ascertained to not be needed, per my discussion on the
backup job).

> +{
> +    job->len =3D job->offset + remaining;
> +}
> +
>  BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
>  {
>      BlockJobInfo *info;
>=20

But overall, this looks like a reasonable conversion, even if it was not
a straightforward review.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xog4xi3ttmTDvHYPfmmUExcMZKkfmKmoe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfnFcACgkQp6FrSiUn
Q2rEVwf7BaGnLaCKxoTpOZ0goOoiOGnis17h7qzhyIEyxSSdvL8yGSTySSW6yoXk
3jiNeWsg56IbOeyUEkiGfRHydYF2EPFpoqj7xyRT2UuVwDO2opO6liDlAg1nVi8Q
cCYwbNdPyA+DWr3FTM1/V0W5jZGGo+/PAcWZZH72RBXmJPw6US3+UNTjS1Y3dwo5
Fr3fg2ZhIHnxMjgos9o3awU5UXAl+ivYHXe4ZppTE5EsK52pN0YVOz53V1MXCTuP
4eCPCpq4Tast17chvJ6XImx6MQGMHjBJbtMysRUK3fCoJajdkZ67IvUtUg7+Y4pL
/xZa4SJBSdpTSGcKZMY1PZUq/avzSQ==
=GvPw
-----END PGP SIGNATURE-----

--Xog4xi3ttmTDvHYPfmmUExcMZKkfmKmoe--
