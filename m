Received: from eggs.gnu.org ([2001:4830:134:3::10]:52930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fq3Ak-0005IH-IN
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fq3Ae-00029m-Es
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:17:42 -0400
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-17-jsnow@redhat.com>
	<20180809151242.GD4320@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <60ef1ca4-2b17-3600-972a-ecf004fd989c@redhat.com>
Date: Wed, 15 Aug 2018 17:17:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180809151242.GD4320@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/21] block/commit: refactor commit to use
 job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>



On 08/09/2018 11:12 AM, Kevin Wolf wrote:
> Am 07.08.2018 um 06:33 hat John Snow geschrieben:
>> Use the component callbacks; prepare, commit, abort, and clean.
>>
>> NB: prepare is only called when the job has not yet failed;
>> and abort can be called after prepare.
>>
>> complete -> prepare -> abort -> clean
>> complete -> abort -> clean
>=20
> I always found this confusing. After converting all jobs to use the
> infrastructure, do you think that this design is helpful? You seem to b=
e
> calling *_common function from commit and abort, with an almost empty
> prepare, which looks like a hint that maybe we should reorganise things=
.
>=20

After rewriting things a bit, I think it would be nicer to call prepare
regardless of circumstances. The callbacks will be nicer for it.

When I wrote it the first time, the thought process was something like:

"Well, we won't need to prepare anything if we've already failed, we
just need to speed along to abort."

I wasn't considering so carefully the common cleanup case that needs to
occur post-finalization which appears to actually happen in a good
number of jobs.

>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/commit.c | 94 +++++++++++++++++++++++++++++++++++++------------=
---------
>>  1 file changed, 61 insertions(+), 33 deletions(-)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index 1a4a56795f..6673a0544e 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -35,7 +35,9 @@ typedef struct CommitBlockJob {
>>      BlockJob common;
>>      BlockDriverState *commit_top_bs;
>>      BlockBackend *top;
>> +    BlockDriverState *top_bs;
>>      BlockBackend *base;
>> +    BlockDriverState *base_bs;
>>      BlockdevOnError on_error;
>>      int base_flags;
>>      char *backing_file_str;
>=20
> More state. :-(
>=20
> Can we at least move the new fields to the end of the struct with a
> comment that they are only valid after .exit()?
>=20

Sure ... admittedly this is just a crutch because I was not precisely
sure exactly when these might change out from underneath me. If there
are some clever ways to avoid needing the state, feel free to suggest the=
m.

>> @@ -71,37 +73,37 @@ static int coroutine_fn commit_populate(BlockBacke=
nd *bs, BlockBackend *base,
>>  static void commit_exit(Job *job)
>>  {
>>      CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.jo=
b);
>> -    BlockJob *bjob =3D &s->common;
>> -    BlockDriverState *top =3D blk_bs(s->top);
>> -    BlockDriverState *base =3D blk_bs(s->base);
>> -    BlockDriverState *commit_top_bs =3D s->commit_top_bs;
>> -    int ret =3D job->ret;
>> -    bool remove_commit_top_bs =3D false;
>> +
>> +    s->top_bs =3D blk_bs(s->top);
>> +    s->base_bs =3D blk_bs(s->base);
>> =20
>>      /* Make sure commit_top_bs and top stay around until bdrv_replace=
_node() */
>> -    bdrv_ref(top);
>> -    bdrv_ref(commit_top_bs);
>> +    bdrv_ref(s->top_bs);
>> +    bdrv_ref(s->commit_top_bs);
>> +}
>> =20
>> -    /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE =
before
>> -     * the normal backing chain can be restored. */
>> -    blk_unref(s->base);
>> +static int commit_prepare(Job *job)
>> +{
>> +    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.jo=
b);
>> =20
>> -    if (!job_is_cancelled(job) && ret =3D=3D 0) {
>> -        /* success */
>> -        ret =3D bdrv_drop_intermediate(s->commit_top_bs, base,
>> -                                     s->backing_file_str);
>> -    } else {
>> -        /* XXX Can (or should) we somehow keep 'consistent read' bloc=
ked even
>> -         * after the failed/cancelled commit job is gone? If we alrea=
dy wrote
>> -         * something to base, the intermediate images aren't valid an=
y more. */
>> -        remove_commit_top_bs =3D true;
>> -    }
>> +     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE=
 before
>> +      * the normal backing chain can be restored. */
>> +     blk_unref(s->base);
>> +     s->base =3D NULL;
>> +
>> +     return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
>> +                                   s->backing_file_str);
>=20
> The indentation is off here (which is weird because the additional spac=
e
> seems to be the only change to most of the lines).
>=20
>> +}
>> +
>> +static void commit_exit_common(Job *job)
>> +{
>> +    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.jo=
b);
>> =20
>>      /* restore base open flags here if appropriate (e.g., change the =
base back
>>       * to r/o). These reopens do not need to be atomic, since we won'=
t abort
>>       * even on failure here */
>> -    if (s->base_flags !=3D bdrv_get_flags(base)) {
>> -        bdrv_reopen(base, s->base_flags, NULL);
>> +    if (s->base_flags !=3D bdrv_get_flags(s->base_bs)) {
>> +        bdrv_reopen(s->base_bs, s->base_flags, NULL);
>>      }
>>      g_free(s->backing_file_str);
>>      blk_unref(s->top);
>=20
> Feels like general cleanup, so intuitively, I'd expect this in .clean.
> The only thing that could make this impossible is the ordering.
>=20
> bdrv_reopen() of s->base_bs should be safe to be deferred, the node
> is still referenced after the job is concluded and we don't rely on it
> being read-only again in any of the following completion code.
>=20
> g_free() is safe to be moved anyway.
>=20
> blk_unref(s->top) doesn't change the graph because we did a
> bdrv_ref(s->top_bs). The permissions of the BlockBackend could still be
> a problem. However, it doesn't take any permissions:
>=20
>     s->top =3D blk_new(0, BLK_PERM_ALL);
>=20
> So I think moving this first part of commit_exit_common() to .clean
> should be safe.
>=20

OK, I'll try to do this a little more intelligently. This is definitely
a bit of a hack-and-slash job; I'll look at your comments in the second
reply here too and try to eliminate .exit which I agree is likely not
strictly needed especially if we make prepare something that's always
called.

>> @@ -110,21 +112,43 @@ static void commit_exit(Job *job)
>>       * job_finish_sync()), job_completed() won't free it and therefor=
e the
>>       * blockers on the intermediate nodes remain. This would cause
>>       * bdrv_set_backing_hd() to fail. */
>> -    block_job_remove_all_bdrv(bjob);
>> +    block_job_remove_all_bdrv(&s->common);
>=20
> There hasn't been any bdrv_set_backing_hd() close to this comment for a
> while. Might be time to update it.
>=20
> I suppose the update would refer to bdrv_replace_node(), which only
> happens in .abort, so should block_job_remove_all_bdrv() move, too?
>=20
> With these changes, commit_exit_common() would be gone.
>=20
>> +}
>> +
>> +static void commit_commit(Job *job)
>> +{
>> +    commit_exit_common(job);
>> +}
>=20
> (I think I've answered this question now, by effectively proposing to d=
o
> away with .commit, but I'll leave it there anyway.)
>=20
> Is there any reason for the split between .prepare and .commit as it is
> or is this mostly arbitrary? Probably the latter because commit isn't
> even transactionable?
>=20

Just historical, yeah -- we only had commit and abort for a while, and
prepare didn't join the party until we wanted finalize and it became
apparent we needed a way to check the return code and still be able to
fail the transaction in time to be able to do a final commit or still
abort very, very late in the process.

Probably there's no real meaningful reason that prepare and commit need
to be separate callbacks.

It is possible that:

prepare --> [abort] --> clean

would be entirely sufficient for all current cases.

>> +static void commit_abort(Job *job)
>> +{
>> +    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.jo=
b);
>> +
>> +    if (s->base) {
>> +        blk_unref(s->base);
>> +    }
>> +
>> +    commit_exit_common(job);
>> +
>> +    /* XXX Can (or should) we somehow keep 'consistent read' blocked =
even
>> +     * after the failed/cancelled commit job is gone? If we already w=
rote
>> +     * something to base, the intermediate images aren't valid any mo=
re. */
>> =20
>>      /* If bdrv_drop_intermediate() didn't already do that, remove the=
 commit
>>       * filter driver from the backing chain. Do this as the final ste=
p so that
>>       * the 'consistent read' permission can be granted.  */
>> -    if (remove_commit_top_bs) {
>> -        bdrv_child_try_set_perm(commit_top_bs->backing, 0, BLK_PERM_A=
LL,
>> -                                &error_abort);
>> -        bdrv_replace_node(commit_top_bs, backing_bs(commit_top_bs),
>> -                          &error_abort);
>> -    }
>> +    bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_AL=
L,
>> +                            &error_abort);
>> +    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
>> +                      &error_abort);
>> +}
>> =20
>> -    bdrv_unref(commit_top_bs);
>> -    bdrv_unref(top);
>> -    job->ret =3D ret;
>> +static void commit_clean(Job *job)
>> +{
>> +    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.jo=
b);
>> +
>> +    bdrv_unref(s->commit_top_bs);
>> +    bdrv_unref(s->top_bs);
>>  }
>> =20
>>  static int coroutine_fn commit_run(Job *job)
>> @@ -214,6 +238,10 @@ static const BlockJobDriver commit_job_driver =3D=
 {
>>          .drain         =3D block_job_drain,
>>          .start         =3D commit_run,
>>          .exit          =3D commit_exit,
>> +        .prepare       =3D commit_prepare,
>> +        .commit        =3D commit_commit,
>> +        .abort         =3D commit_abort,
>> +        .clean         =3D commit_clean
>>      },
>>  };
>=20
> Kevin
>=20

--=20
=E2=80=94js
