Received: from eggs.gnu.org ([209.51.188.92]:36463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1go9Tq-0004cW-Cl
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1go9To-0005tA-1H
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:09:50 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-12-vsementsov@virtuozzo.com>
	<1ea09d99-04ff-711e-9137-cdae33ca8681@redhat.com>
	<643f318f-392d-1370-f952-b2a01e7d9bb7@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ea0a19fd-2db5-bfa5-180b-68c3ef80e046@redhat.com>
Date: Mon, 28 Jan 2019 16:59:40 +0100
MIME-Version: 1.0
In-Reply-To: <643f318f-392d-1370-f952-b2a01e7d9bb7@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pwjMBhGT4RWtOa9XufqcUibiB219tZ5l0"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pwjMBhGT4RWtOa9XufqcUibiB219tZ5l0
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Message-ID: <ea0a19fd-2db5-bfa5-180b-68c3ef80e046@redhat.com>
Subject: Re: [PATCH v5 11/11] block/backup: use backup-top instead of write
 notifiers
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-12-vsementsov@virtuozzo.com>
 <1ea09d99-04ff-711e-9137-cdae33ca8681@redhat.com>
 <643f318f-392d-1370-f952-b2a01e7d9bb7@virtuozzo.com>
In-Reply-To: <643f318f-392d-1370-f952-b2a01e7d9bb7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.01.19 12:29, Vladimir Sementsov-Ogievskiy wrote:
> 18.01.2019 17:56, Max Reitz wrote:
>> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>> Drop write notifiers and use filter node instead. Changes:
>>>
>>> 1. copy-before-writes now handled by filter node, so, drop all
>>>     is_write_notifier arguments.
>>>
>>> 2. we don't have intersecting requests, so their handling is dropped.=

>>> Instead, synchronization works as follows:
>>> when backup or backup-top starts copying of some area it firstly
>>> clears copy-bitmap bits, and nobody touches areas, not marked with
>>> dirty bits in copy-bitmap, so there is no intersection. Also, backup
>>> job copy operations are surrounded by bdrv region lock, which is
>>> actually serializing request, to not interfer with guest writes and
>>> not read changed data from source (before reading we clear
>>> corresponding bit in copy-bitmap, so, this area is not more handled b=
y
>>> backup-top).
>>>
>>> 3. To sync with in-flight requests we now just drain hook node, we
>>> don't need rw-lock.
>>>
>>> 4. After the whole backup loop (top, full, incremental modes), we nee=
d
>>> to check for not copied clusters, which were under backup-top operati=
on
>>> and we skipped them, but backup-top operation failed, error returned =
to
>>> the guest and dirty bits set back.
>>>
>>> 5. Don't create additional blk, use backup-top children for copy
>>> operations.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/backup.c | 285 ++++++++++++++++++++++++++--------------------=
---
>>>   1 file changed, 149 insertions(+), 136 deletions(-)
>>>
>>> diff --git a/block/backup.c b/block/backup.c
>>> index 88c0242b4e..e332909fb7 100644
>>> --- a/block/backup.c
>>> +++ b/block/backup.c
>>
>> [...]
>>
>>> @@ -300,21 +231,23 @@ static void backup_abort(Job *job)
>>>   static void backup_clean(Job *job)
>>>   {
>>>       BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.=
job);
>>> -    assert(s->target);
>>> -    blk_unref(s->target);
>>> +
>>> +    /* We must clean it to not crash in backup_drain. */
>>>       s->target =3D NULL;
>>
>> Why not set s->source to NULL along with it?  It makes sense if you're=

>> going to drop the backup-top node because both of these are its childr=
en.
>=20
> agree.
>=20
>>
>>>  =20
>>>       if (s->copy_bitmap) {
>>>           hbitmap_free(s->copy_bitmap);
>>>           s->copy_bitmap =3D NULL;
>>>       }
>>> +
>>> +    bdrv_backup_top_drop(s->backup_top);
>>>   }
>>
>> [...]
>>
>>> @@ -386,21 +319,45 @@ static int coroutine_fn backup_run_incremental(=
BackupBlockJob *job)
>>>       bool error_is_read;
>>>       int64_t offset;
>>>       HBitmapIter hbi;
>>> +    void *lock =3D NULL;
>>>  =20
>>>       hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
>>> -    while ((offset =3D hbitmap_iter_next(&hbi)) !=3D -1) {
>>> +    while (hbitmap_count(job->copy_bitmap)) {
>>> +        offset =3D hbitmap_iter_next(&hbi);
>>> +        if (offset =3D=3D -1) {
>>> +            /*
>>> +             * we may have skipped some clusters, which were handled=
 by
>>> +             * backup-top, but failed and finished by returning erro=
r to
>>> +             * the guest and set dirty bit back.
>>> +             */
>>> +            hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
>>> +            offset =3D hbitmap_iter_next(&hbi);
>>> +            assert(offset);
>>
>> I think you want to assert "offset >=3D 0".
>>
>>> +        }
>>> +
>>> +        lock =3D bdrv_co_try_lock(job->source, offset, job->cluster_=
size);
>>> +        /*
>>> +         * Dirty bit is set, which means that there are no in-flight=

>>> +         * write requests on this area. We must succeed.
>>> +         */
>>> +        assert(lock);
>>
>> I'm not sure that is true right now, but more on that below in backup_=
run().
>>
>>> +
>>>           do {
>>>               if (yield_and_check(job)) {
>>> +                bdrv_co_unlock(lock);
>>>                   return 0;
>>>               }
>>> -            ret =3D backup_do_cow(job, offset,
>>> -                                job->cluster_size, &error_is_read, f=
alse);
>>> +            ret =3D backup_do_cow(job, offset, job->cluster_size, &e=
rror_is_read);
>>>               if (ret < 0 && backup_error_action(job, error_is_read, =
-ret) =3D=3D
>>>                              BLOCK_ERROR_ACTION_REPORT)
>>>               {
>>> +                bdrv_co_unlock(lock);
>>>                   return ret;
>>>               }
>>>           } while (ret < 0);
>>> +
>>> +        bdrv_co_unlock(lock);
>>> +        lock =3D NULL;
>>
>> This statement seems unnecessary here.
>>
>>>       }
>>>  =20
>>>       return 0;
>>
>> [...]
>>
>>> @@ -447,26 +402,39 @@ static int coroutine_fn backup_run(Job *job, Er=
ror **errp)
>>>           hbitmap_set(s->copy_bitmap, 0, s->len);
>>>       }
>>>  =20
>>> -    s->before_write.notify =3D backup_before_write_notify;
>>> -    bdrv_add_before_write_notifier(bs, &s->before_write);
>>> -
>>>       if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) {
>>>           /* All bits are set in copy_bitmap to allow any cluster to =
be copied.
>>>            * This does not actually require them to be copied. */
>>>           while (!job_is_cancelled(job)) {
>>> -            /* Yield until the job is cancelled.  We just let our be=
fore_write
>>> -             * notify callback service CoW requests. */
>>> +            /*
>>> +             * Yield until the job is cancelled.  We just let our ba=
ckup-top
>>> +             * fileter driver service CbW requests.
>>
>> *filter
>>
>>> +             */
>>>               job_yield(job);
>>>           }
>>>       } else if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
>>>           ret =3D backup_run_incremental(s);
>>>       } else {
>>
>> [...]
>>
>>> @@ -505,8 +474,20 @@ static int coroutine_fn backup_run(Job *job, Err=
or **errp)
>>>               if (alloced < 0) {
>>>                   ret =3D alloced;
>>>               } else {
>>> +                if (!hbitmap_get(s->copy_bitmap, offset)) {
>>> +                    trace_backup_do_cow_skip(job, offset);
>>> +                    continue; /* already copied */
>>> +                }
>>> +                if (!lock) {
>>> +                    lock =3D bdrv_co_try_lock(s->source, offset, s->=
cluster_size);
>>> +                    /*
>>> +                     * Dirty bit is set, which means that there are =
no in-flight
>>> +                     * write requests on this area. We must succeed.=

>>> +                     */
>>> +                    assert(lock);
>>
>> What if I have a different parent node for the source that issues
>> concurrent writes?  This used to work fine because the before_write
>> notifier would still work.  After this patch, that would be broken
>> because those writes would not cause a CbW.
>=20
> But haw could you have this different parent node? After appending filt=
er,
> there should not be such nodes.

Unless you append them afterwards:

> And I think, during backup it should be
> forbidden to append new parents to source, ignoring filter, as it defin=
itely
> breaks what filter does.

Agreed, but then this needs to be implemented.

> And it applies to other block-job with their filters.
> If we appended a filter, we don't want someone other to write omit our =
filter.
>=20
>>
>> That's not so bad because we just have to make sure that all writes go=

>> through the backup-top node.  That would make this assertion valid
>> again, too.  But that means we cannot share PERM_WRITE; see [1].
>=20
> But we don't share PERM_WRITE on source in backup_top, only on target.

Are you sure?  The job itself shares it, and the filter shares it, too,
as far as I can see.  It uses bdrv_filter_default_perms(), and that does
seem to share PERM_WRITE.

>>
>>> +                }
>>>                   ret =3D backup_do_cow(s, offset, s->cluster_size,
>>> -                                    &error_is_read, false);
>>> +                                    &error_is_read);
>>>               }
>>>               if (ret < 0) {
>>>                   /* Depending on error action, fail now or retry clu=
ster */
>>> @@ -516,17 +497,34 @@ static int coroutine_fn backup_run(Job *job, Er=
ror **errp)
>>>                       break;
>>>                   } else {
>>>                       offset -=3D s->cluster_size;
>>> +                    retry =3D true;
>>>                       continue;
>>>                   }
>>>               }
>>>           }
>>> +        if (lock) {
>>> +            bdrv_co_unlock(lock);
>>> +            lock =3D NULL;
>>> +        }
>>> +        if (ret =3D=3D 0 && !job_is_cancelled(job) &&
>>> +            hbitmap_count(s->copy_bitmap))
>>> +        {
>>> +            /*
>>> +             * we may have skipped some clusters, which were handled=
 by
>>> +             * backup-top, but failed and finished by returning erro=
r to
>>> +             * the guest and set dirty bit back.
>>
>> So it's a matter of a race?
>>
>>> +             */
>>> +            goto iteration;
>>> +        }
>>
>> Why not wrap everything in a do {} while (ret =3D=3D 0 && !job_is...)
>> instead?  Because it would mean reindenting everything?
>=20
> Don't remember, but assume that yes. And this code is anyway "To be ref=
actored",
> I want all FULL/TOP/INCREMENTAL go through the same (mostly) code path.=


Hm, well, if you want to refactor it later anyway...  But I don't like
gotos that go backwards very much, unless there is a good reason to have
them (and there isn't here).

>>>       }
>>>  =20
>>> -    notifier_with_return_remove(&s->before_write);
>>> +    /* wait pending CBW operations in backup-top */
>>> +    bdrv_drain(s->backup_top);
>>>  =20
>>> -    /* wait until pending backup_do_cow() calls have completed */
>>> -    qemu_co_rwlock_wrlock(&s->flush_rwlock);
>>> -    qemu_co_rwlock_unlock(&s->flush_rwlock);
>>> +    backup_top_progress =3D bdrv_backup_top_progress(s->backup_top);=

>>> +    job_progress_update(job, ret + backup_top_progress -
>>
>> Why the "ret"?
>=20
> oops, it looks like a copy-paste bug ("ret" is reasonable in backup_do_=
cow())
>=20
>>
>>> +                        s->backup_top_progress);
>>> +    s->backup_top_progress =3D backup_top_progress;
>>
>> So the backup-top progress is ignored during basically all of the bloc=
k
>> job until it suddenly jumps to 100 % completion?  That doesn't sound i=
deal.
>>
>> Or did you mean to put this into the for () loop of MODE_TOP/MODE_FULL=
?
>>   (And the while() loop of MODE_NONE)
>=20
>=20
> It is done in backup_do_cow(), so FULL and TOP are covered.
>=20
> But you are right that MODE_NONE seems to have a problem about it.. And=
 just updating it
> in a while loop would not work, as I doubt that job_yield will return u=
ntil job finish
> or user interaction like pause/continue/cancel..
>=20
> So now, it looks better to call job_progress_update() from backup_top d=
irectly, and drop
> this hack.

Hmmm...  I don't think job_*() calls belong in backup_top.  How about
adding a callback to bdrv_backup_top_append()?

>>>  =20
>>>       return ret;
>>>   }
>>> @@ -563,6 +561,9 @@ BlockJob *backup_job_create(const char *job_id, B=
lockDriverState *bs,
>>>       int ret;
>>>       int64_t cluster_size;
>>>       HBitmap *copy_bitmap =3D NULL;
>>> +    BlockDriverState *backup_top =3D NULL;
>>> +    uint64_t all_except_resize =3D BLK_PERM_CONSISTENT_READ | BLK_PE=
RM_WRITE |
>>> +                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM=
_GRAPH_MOD;
>>
>> BLK_PERM_ALL & ~BLK_PERM_RESIZE?
>>
>> [1] But we probably do not want to share either PERM_WRITE or
>> PERM_WRITE_UNCHANGED because during the duration of the backup,
>> everything should go through the backup-top filter (not sure about
>> PERM_WRITE_UNCHANGED right now).  Or is that something that the filter=

>> node should enforce in backup_top_child_perm()?
>=20
> It's not shared perm of backup_top, it's a shared perm of block-job com=
mon.blk, which is
> used only to "job->len is fixed, so we can't allow resize", so this par=
t is not changed.
>=20
> So yes, the problem you mean by [1] is about backup_top_child_perm() wh=
ere we share PERM_WRITE.
> And it is described by comment, we must share this write perm, otherwis=
e we break guest writes.

For the target, yes, but the problem is sharing it on the source.

> We share PERM_WRITE in backup_top to force its target child share PERM_=
WRITE on its backing,
> as backing of target is source.
>=20
> But again, we share PERM_WRITE only on target, and it is shared in curr=
ent code too.

I'm not so sure whether PERM_WRITE is shared only on the target.

>>
>>>  =20
>>>       assert(bs);
>>>       assert(target);
>>> @@ -655,25 +656,31 @@ BlockJob *backup_job_create(const char *job_id,=
 BlockDriverState *bs,
>>>  =20
>>>       copy_bitmap =3D hbitmap_alloc(len, ctz32(cluster_size));
>>>  =20
>>> -    /* job->len is fixed, so we can't allow resize */
>>> -    job =3D block_job_create(job_id, &backup_job_driver, txn, bs,
>>> -                           BLK_PERM_CONSISTENT_READ,
>>> -                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE=
 |
>>> -                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH=
_MOD,
>>> -                           speed, creation_flags, cb, opaque, errp);=

>>> -    if (!job) {
>>> +    /*
>>> +     * bdrv_get_device_name will not help to find device name starti=
ng from
>>> +     * @bs after backup-top append,
>>
>> Why not?  Since backup-top is appended, shouldn't all parents of @bs b=
e
>> parents of @backup_top then?  (Making bdrv_get_parent_name() return th=
e
>> same result)
>=20
> bdrv_get_device_name goes finally through role->get_name, and only root=
 role has
> this handler. After append we'll have backing role instead of root.

Ah, I see, I asked the wrong question.

Why is block_job_create() called on bs and not on backup_top?  mirror
calls it on mirror_top_bs.

>>>                                       so let's calculate job_id befor=
e. Do
>>> +     * it in the same way like block_job_create
>>> +     */
>>> +    if (job_id =3D=3D NULL && !(creation_flags & JOB_INTERNAL)) {
>>> +        job_id =3D bdrv_get_device_name(bs);
>>> +    }
>>> +
>>> +    backup_top =3D bdrv_backup_top_append(bs, target, copy_bitmap, e=
rrp);
>>> +    if (!backup_top) {
>>>           goto error;
>>>       }
>>>  =20
>>> -    /* The target must match the source in size, so no resize here e=
ither */
>>> -    job->target =3D blk_new(BLK_PERM_WRITE,
>>> -                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE =
|
>>> -                          BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_=
MOD);
>>> -    ret =3D blk_insert_bs(job->target, target, errp);
>>> -    if (ret < 0) {
>>> +    /* job->len is fixed, so we can't allow resize */
>>> +    job =3D block_job_create(job_id, &backup_job_driver, txn, bs, 0,=

>>
>> Is there a reason you dropped PERM_CONSISTENT_READ here?
>=20
> Because, we don't use this blk for read now, we read through backup_top=
 child.

Makes sense.

>>> +                           all_except_resize, speed, creation_flags,=

>>> +                           cb, opaque, errp);
>>> +    if (!job) {
>>>           goto error;
>>>       }
>>>  =20
>>> +    job->source =3D backup_top->backing;
>>> +    job->target =3D ((BDRVBackupTopState *)backup_top->opaque)->targ=
et;
>>
>> This looks really ugly.  I think as long as the block job performs
>> writes itself, it should use its own BlockBackend.
>=20
> They are not BlockBackends, they are BdrvChildren.

Exactly, which is what I don't like.  They are children of a node that
is implemented in a different file, it looks weird to use them here.

> It was Kevin's idea to reuse filter's
> children in backup job:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01017.html

It's still ugly if backup_top is in a different file.  Well, maybe just
to me.

> Hmm, and this is also why I need PERM_WRITE in backup_top, to write to =
target.
>=20
>>
>> Alternatively, I think it would make sense for the backup-top filter t=
o
>> offer functions that this job can use to issue writes to the target.
>> Then the backup job would no longer need direct access to the target a=
s
>> a BdrvChild.

So what would be the problem with this?

Max


--pwjMBhGT4RWtOa9XufqcUibiB219tZ5l0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxPJuwACgkQ9AfbAGHV
z0B73gf+PuWCFfuDPygaxJI6FzlFzen8+M2fVunLG6zx3BhqQ1G6BomW7i8utPGz
rH704p5TbKcX3LHKfBjPVnkLT8am0LIY4LWds1PXfXIRhixMwu41vbS4ntfQCvP7
grwA2oXjWy2H+gviyZjjNBp/0PQoCNsGXBHSRQdF5gLkOS5F6Nk0ynWmERx1jUbe
JN/IBVbXa2YATH5r+u4zyVHGJIk6AMx05NHSb3JoxxNSSjWMY3F5kGX2PH5yPAvF
0EDgAiV+i0ruLVScwia6q/Q7BwQZqUh2RoToYd8ZQ1xKUNK7UHpdEySM4LHabbGn
ftoZ6I1vF2SAcHjU3SnQ246FAzO4zA==
=rq9F
-----END PGP SIGNATURE-----

--pwjMBhGT4RWtOa9XufqcUibiB219tZ5l0--
