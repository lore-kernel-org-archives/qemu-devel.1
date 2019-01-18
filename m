Received: from eggs.gnu.org ([209.51.188.92]:42524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gkVZz-0001uL-Gn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gkVZx-0005q6-WD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:57:07 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-12-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1ea09d99-04ff-711e-9137-cdae33ca8681@redhat.com>
Date: Fri, 18 Jan 2019 15:56:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xfe2USpCVcdiQTDILprq6YpAY2jyVk4KB"
Subject: Re: [Qemu-devel] [PATCH v5 11/11] block/backup: use backup-top
 instead of write notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xfe2USpCVcdiQTDILprq6YpAY2jyVk4KB
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <1ea09d99-04ff-711e-9137-cdae33ca8681@redhat.com>
Subject: Re: [PATCH v5 11/11] block/backup: use backup-top instead of write
 notifiers
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-12-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> Drop write notifiers and use filter node instead. Changes:
>=20
> 1. copy-before-writes now handled by filter node, so, drop all
>    is_write_notifier arguments.
>=20
> 2. we don't have intersecting requests, so their handling is dropped.
> Instead, synchronization works as follows:
> when backup or backup-top starts copying of some area it firstly
> clears copy-bitmap bits, and nobody touches areas, not marked with
> dirty bits in copy-bitmap, so there is no intersection. Also, backup
> job copy operations are surrounded by bdrv region lock, which is
> actually serializing request, to not interfer with guest writes and
> not read changed data from source (before reading we clear
> corresponding bit in copy-bitmap, so, this area is not more handled by
> backup-top).
>=20
> 3. To sync with in-flight requests we now just drain hook node, we
> don't need rw-lock.
>=20
> 4. After the whole backup loop (top, full, incremental modes), we need
> to check for not copied clusters, which were under backup-top operation=

> and we skipped them, but backup-top operation failed, error returned to=

> the guest and dirty bits set back.
>=20
> 5. Don't create additional blk, use backup-top children for copy
> operations.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 285 ++++++++++++++++++++++++++-----------------------=

>  1 file changed, 149 insertions(+), 136 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 88c0242b4e..e332909fb7 100644
> --- a/block/backup.c
> +++ b/block/backup.c

[...]

> @@ -300,21 +231,23 @@ static void backup_abort(Job *job)
>  static void backup_clean(Job *job)
>  {
>      BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job=
);
> -    assert(s->target);
> -    blk_unref(s->target);
> +
> +    /* We must clean it to not crash in backup_drain. */
>      s->target =3D NULL;

Why not set s->source to NULL along with it?  It makes sense if you're
going to drop the backup-top node because both of these are its children.=


> =20
>      if (s->copy_bitmap) {
>          hbitmap_free(s->copy_bitmap);
>          s->copy_bitmap =3D NULL;
>      }
> +
> +    bdrv_backup_top_drop(s->backup_top);
>  }

[...]

> @@ -386,21 +319,45 @@ static int coroutine_fn backup_run_incremental(Ba=
ckupBlockJob *job)
>      bool error_is_read;
>      int64_t offset;
>      HBitmapIter hbi;
> +    void *lock =3D NULL;
> =20
>      hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
> -    while ((offset =3D hbitmap_iter_next(&hbi)) !=3D -1) {
> +    while (hbitmap_count(job->copy_bitmap)) {
> +        offset =3D hbitmap_iter_next(&hbi);
> +        if (offset =3D=3D -1) {
> +            /*
> +             * we may have skipped some clusters, which were handled b=
y
> +             * backup-top, but failed and finished by returning error =
to
> +             * the guest and set dirty bit back.
> +             */
> +            hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
> +            offset =3D hbitmap_iter_next(&hbi);
> +            assert(offset);

I think you want to assert "offset >=3D 0".

> +        }
> +
> +        lock =3D bdrv_co_try_lock(job->source, offset, job->cluster_si=
ze);
> +        /*
> +         * Dirty bit is set, which means that there are no in-flight
> +         * write requests on this area. We must succeed.
> +         */
> +        assert(lock);

I'm not sure that is true right now, but more on that below in backup_run=
().

> +
>          do {
>              if (yield_and_check(job)) {
> +                bdrv_co_unlock(lock);
>                  return 0;
>              }
> -            ret =3D backup_do_cow(job, offset,
> -                                job->cluster_size, &error_is_read, fal=
se);
> +            ret =3D backup_do_cow(job, offset, job->cluster_size, &err=
or_is_read);
>              if (ret < 0 && backup_error_action(job, error_is_read, -re=
t) =3D=3D
>                             BLOCK_ERROR_ACTION_REPORT)
>              {
> +                bdrv_co_unlock(lock);
>                  return ret;
>              }
>          } while (ret < 0);
> +
> +        bdrv_co_unlock(lock);
> +        lock =3D NULL;

This statement seems unnecessary here.

>      }
> =20
>      return 0;

[...]

> @@ -447,26 +402,39 @@ static int coroutine_fn backup_run(Job *job, Erro=
r **errp)
>          hbitmap_set(s->copy_bitmap, 0, s->len);
>      }
> =20
> -    s->before_write.notify =3D backup_before_write_notify;
> -    bdrv_add_before_write_notifier(bs, &s->before_write);
> -
>      if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) {
>          /* All bits are set in copy_bitmap to allow any cluster to be =
copied.
>           * This does not actually require them to be copied. */
>          while (!job_is_cancelled(job)) {
> -            /* Yield until the job is cancelled.  We just let our befo=
re_write
> -             * notify callback service CoW requests. */
> +            /*
> +             * Yield until the job is cancelled.  We just let our back=
up-top
> +             * fileter driver service CbW requests.

*filter

> +             */
>              job_yield(job);
>          }
>      } else if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
>          ret =3D backup_run_incremental(s);
>      } else {

[...]

> @@ -505,8 +474,20 @@ static int coroutine_fn backup_run(Job *job, Error=
 **errp)
>              if (alloced < 0) {
>                  ret =3D alloced;
>              } else {
> +                if (!hbitmap_get(s->copy_bitmap, offset)) {
> +                    trace_backup_do_cow_skip(job, offset);
> +                    continue; /* already copied */
> +                }
> +                if (!lock) {
> +                    lock =3D bdrv_co_try_lock(s->source, offset, s->cl=
uster_size);
> +                    /*
> +                     * Dirty bit is set, which means that there are no=
 in-flight
> +                     * write requests on this area. We must succeed.
> +                     */
> +                    assert(lock);

What if I have a different parent node for the source that issues
concurrent writes?  This used to work fine because the before_write
notifier would still work.  After this patch, that would be broken
because those writes would not cause a CbW.

That's not so bad because we just have to make sure that all writes go
through the backup-top node.  That would make this assertion valid
again, too.  But that means we cannot share PERM_WRITE; see [1].

> +                }
>                  ret =3D backup_do_cow(s, offset, s->cluster_size,
> -                                    &error_is_read, false);
> +                                    &error_is_read);
>              }
>              if (ret < 0) {
>                  /* Depending on error action, fail now or retry cluste=
r */
> @@ -516,17 +497,34 @@ static int coroutine_fn backup_run(Job *job, Erro=
r **errp)
>                      break;
>                  } else {
>                      offset -=3D s->cluster_size;
> +                    retry =3D true;
>                      continue;
>                  }
>              }
>          }
> +        if (lock) {
> +            bdrv_co_unlock(lock);
> +            lock =3D NULL;
> +        }
> +        if (ret =3D=3D 0 && !job_is_cancelled(job) &&
> +            hbitmap_count(s->copy_bitmap))
> +        {
> +            /*
> +             * we may have skipped some clusters, which were handled b=
y
> +             * backup-top, but failed and finished by returning error =
to
> +             * the guest and set dirty bit back.

So it's a matter of a race?

> +             */
> +            goto iteration;
> +        }

Why not wrap everything in a do {} while (ret =3D=3D 0 && !job_is...)
instead?  Because it would mean reindenting everything?

>      }
> =20
> -    notifier_with_return_remove(&s->before_write);
> +    /* wait pending CBW operations in backup-top */
> +    bdrv_drain(s->backup_top);
> =20
> -    /* wait until pending backup_do_cow() calls have completed */
> -    qemu_co_rwlock_wrlock(&s->flush_rwlock);
> -    qemu_co_rwlock_unlock(&s->flush_rwlock);
> +    backup_top_progress =3D bdrv_backup_top_progress(s->backup_top);
> +    job_progress_update(job, ret + backup_top_progress -

Why the "ret"?

> +                        s->backup_top_progress);
> +    s->backup_top_progress =3D backup_top_progress;

So the backup-top progress is ignored during basically all of the block
job until it suddenly jumps to 100 % completion?  That doesn't sound idea=
l.

Or did you mean to put this into the for () loop of MODE_TOP/MODE_FULL?
 (And the while() loop of MODE_NONE)

> =20
>      return ret;
>  }
> @@ -563,6 +561,9 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>      int ret;
>      int64_t cluster_size;
>      HBitmap *copy_bitmap =3D NULL;
> +    BlockDriverState *backup_top =3D NULL;
> +    uint64_t all_except_resize =3D BLK_PERM_CONSISTENT_READ | BLK_PERM=
_WRITE |
> +                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_G=
RAPH_MOD;

BLK_PERM_ALL & ~BLK_PERM_RESIZE?

[1] But we probably do not want to share either PERM_WRITE or
PERM_WRITE_UNCHANGED because during the duration of the backup,
everything should go through the backup-top filter (not sure about
PERM_WRITE_UNCHANGED right now).  Or is that something that the filter
node should enforce in backup_top_child_perm()?

> =20
>      assert(bs);
>      assert(target);
> @@ -655,25 +656,31 @@ BlockJob *backup_job_create(const char *job_id, B=
lockDriverState *bs,
> =20
>      copy_bitmap =3D hbitmap_alloc(len, ctz32(cluster_size));
> =20
> -    /* job->len is fixed, so we can't allow resize */
> -    job =3D block_job_create(job_id, &backup_job_driver, txn, bs,
> -                           BLK_PERM_CONSISTENT_READ,
> -                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |=

> -                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_M=
OD,
> -                           speed, creation_flags, cb, opaque, errp);
> -    if (!job) {
> +    /*
> +     * bdrv_get_device_name will not help to find device name starting=
 from
> +     * @bs after backup-top append,

Why not?  Since backup-top is appended, shouldn't all parents of @bs be
parents of @backup_top then?  (Making bdrv_get_parent_name() return the
same result)

>                                      so let's calculate job_id before. =
Do
> +     * it in the same way like block_job_create
> +     */
> +    if (job_id =3D=3D NULL && !(creation_flags & JOB_INTERNAL)) {
> +        job_id =3D bdrv_get_device_name(bs);
> +    }
> +
> +    backup_top =3D bdrv_backup_top_append(bs, target, copy_bitmap, err=
p);
> +    if (!backup_top) {
>          goto error;
>      }
> =20
> -    /* The target must match the source in size, so no resize here eit=
her */
> -    job->target =3D blk_new(BLK_PERM_WRITE,
> -                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
> -                          BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MO=
D);
> -    ret =3D blk_insert_bs(job->target, target, errp);
> -    if (ret < 0) {
> +    /* job->len is fixed, so we can't allow resize */
> +    job =3D block_job_create(job_id, &backup_job_driver, txn, bs, 0,

Is there a reason you dropped PERM_CONSISTENT_READ here?

> +                           all_except_resize, speed, creation_flags,
> +                           cb, opaque, errp);
> +    if (!job) {
>          goto error;
>      }
> =20
> +    job->source =3D backup_top->backing;
> +    job->target =3D ((BDRVBackupTopState *)backup_top->opaque)->target=
;

This looks really ugly.  I think as long as the block job performs
writes itself, it should use its own BlockBackend.

Alternatively, I think it would make sense for the backup-top filter to
offer functions that this job can use to issue writes to the target.
Then the backup job would no longer need direct access to the target as
a BdrvChild.

> +
>      job->on_source_error =3D on_source_error;
>      job->on_target_error =3D on_target_error;
>      job->sync_mode =3D sync_mode;

[...]

> @@ -712,6 +722,9 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>          backup_clean(&job->common.job);
>          job_early_fail(&job->common.job);
>      }
> +    if (backup_top) {
> +        bdrv_backup_top_drop(backup_top);
> +    }

While it shouldn't be a problem in practice, backup_top has a reference
to copy_bitmap, so that bitmap should be freed after backup_top is droppe=
d.

Max

> =20
>      return NULL;
>  }
>=20



--Xfe2USpCVcdiQTDILprq6YpAY2jyVk4KB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxB6S0ACgkQ9AfbAGHV
z0Beqwf9EeX7d+pQUvjQFHRxgqmxMnrdqog0VcmtvKI01+dtBOhU9A3RoaH3ycQg
Dl+quZTcZRorszbXNQQyoBfsQ1te3NblbqQ2mUfKm9PE3Hvz86AN8VkQTIGxnllR
QqTYrNJ99nIvvs/ck8rr1fDdZLKf7zacVeNUnN5vjnKiHslNx17EeLDn2lFXxijf
fxfGFdITDqyEhGFIdu8fPyZj/3LquHWCRnAqHuCprufIlP2zZHun1sAUqhv/stBS
jWLNXi1gx2TQnVzHtzo1s9ZZIBipXskUGm5UlQGxvKBXsp8m6R7yziFwMXcf6DRU
HM82ArcCOuY3flE5ZE0vfc3kA+pohg==
=hiGV
-----END PGP SIGNATURE-----

--Xfe2USpCVcdiQTDILprq6YpAY2jyVk4KB--
