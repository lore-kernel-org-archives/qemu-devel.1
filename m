Received: from eggs.gnu.org ([2001:4830:134:3::10]:47839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxWsZ-0002fs-I0
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxWsY-0002jg-63
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:25:51 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-5-jsnow@redhat.com>
	<20180904184620.GI415265@localhost.localdomain>
	<63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
	<57dc1c6c-29bd-f134-646f-15139df7f4f4@redhat.com>
	<20180905104941.GB4489@localhost.localdomain>
	<78038681-9981-ce9f-e0ba-82c43c31e98d@redhat.com>
	<20180905115310.GC4489@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aba2aea5-737e-b3d7-856a-f6ae692c2d5a@redhat.com>
Date: Wed, 5 Sep 2018 14:25:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180905115310.GC4489@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZHZKaztwJyYAHUEy4MUrQUZSt9pYsv17p"
Subject: Re: [Qemu-devel] [PATCH v4 04/15] block/commit: refactor commit to
 use job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZHZKaztwJyYAHUEy4MUrQUZSt9pYsv17p
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Message-ID: <aba2aea5-737e-b3d7-856a-f6ae692c2d5a@redhat.com>
Subject: Re: [PATCH v4 04/15] block/commit: refactor commit to use job
 callbacks
References: <20180904170930.28619-1-jsnow@redhat.com>
 <20180904170930.28619-5-jsnow@redhat.com>
 <20180904184620.GI415265@localhost.localdomain>
 <63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
 <57dc1c6c-29bd-f134-646f-15139df7f4f4@redhat.com>
 <20180905104941.GB4489@localhost.localdomain>
 <78038681-9981-ce9f-e0ba-82c43c31e98d@redhat.com>
 <20180905115310.GC4489@localhost.localdomain>
In-Reply-To: <20180905115310.GC4489@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-09-05 13:53, Kevin Wolf wrote:
> Am 05.09.2018 um 13:37 hat Max Reitz geschrieben:
>> On 2018-09-05 12:49, Kevin Wolf wrote:
>>> Am 05.09.2018 um 12:27 hat Max Reitz geschrieben:
>>>> On 2018-09-04 22:32, John Snow wrote:
>>>>>
>>>>>
>>>>> On 09/04/2018 02:46 PM, Jeff Cody wrote:
>>>>>> On Tue, Sep 04, 2018 at 01:09:19PM -0400, John Snow wrote:
>>>>>>> Use the component callbacks; prepare, abort, and clean.
>>>>>>>
>>>>>>> NB: prepare is only called when the job has not yet failed;
>>>>>>> and abort can be called after prepare.
>>>>>>>
>>>>>>> complete -> prepare -> abort -> clean
>>>>>>> complete -> abort -> clean
>>>>>>>
>>>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>>>>> ---
>>>>>>>  block/commit.c | 90 ++++++++++++++++++++++++++++++++------------=
--------------
>>>>>>>  1 file changed, 49 insertions(+), 41 deletions(-)
>>>>>>>
>>>>>>> diff --git a/block/commit.c b/block/commit.c
>>>>>>> index b6e8969877..eb3941e545 100644
>>>>>>> --- a/block/commit.c
>>>>>>> +++ b/block/commit.c
>>>>>>> @@ -36,6 +36,7 @@ typedef struct CommitBlockJob {
>>>>>>>      BlockDriverState *commit_top_bs;
>>>>>>>      BlockBackend *top;
>>>>>>>      BlockBackend *base;
>>>>>>> +    BlockDriverState *base_bs;
>>>>>>>      BlockdevOnError on_error;
>>>>>>>      int base_flags;
>>>>>>>      char *backing_file_str;
>>>>>>> @@ -68,61 +69,65 @@ static int coroutine_fn commit_populate(Block=
Backend *bs, BlockBackend *base,
>>>>>>>      return 0;
>>>>>>>  }
>>>>>>> =20
>>>>>>> -static void commit_exit(Job *job)
>>>>>>> +static int commit_prepare(Job *job)
>>>>>>>  {
>>>>>>>      CommitBlockJob *s =3D container_of(job, CommitBlockJob, comm=
on.job);
>>>>>>> -    BlockJob *bjob =3D &s->common;
>>>>>>> -    BlockDriverState *top =3D blk_bs(s->top);
>>>>>>> -    BlockDriverState *base =3D blk_bs(s->base);
>>>>>>> -    BlockDriverState *commit_top_bs =3D s->commit_top_bs;
>>>>>>> -    bool remove_commit_top_bs =3D false;
>>>>>>> -
>>>>>>> -    /* Make sure commit_top_bs and top stay around until bdrv_re=
place_node() */
>>>>>>> -    bdrv_ref(top);
>>>>>>> -    bdrv_ref(commit_top_bs);
>>>>>>> =20
>>>>>>>      /* Remove base node parent that still uses BLK_PERM_WRITE/RE=
SIZE before
>>>>>>>       * the normal backing chain can be restored. */
>>>>>>>      blk_unref(s->base);
>>>>>>> +    s->base =3D NULL;
>>>>>>> =20
>>>>>>> -    if (!job_is_cancelled(job) && job->ret =3D=3D 0) {
>>>>>>> -        /* success */
>>>>>>> -        job->ret =3D bdrv_drop_intermediate(s->commit_top_bs, ba=
se,
>>>>>>> -                                          s->backing_file_str);
>>>>>>> -    } else {
>>>>>>> -        /* XXX Can (or should) we somehow keep 'consistent read'=
 blocked even
>>>>>>> -         * after the failed/cancelled commit job is gone? If we =
already wrote
>>>>>>> -         * something to base, the intermediate images aren't val=
id any more. */
>>>>>>> -        remove_commit_top_bs =3D true;
>>>>>>> +    return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
>>>>>>> +                                  s->backing_file_str);
>>>>>>> +}
>>>>>>
>>>>>> If we can go from prepare->abort->clean, then that means to me tha=
t every
>>>>>> failure case of .prepare() can be resolved without permanent chang=
es / data
>>>>>> loss.  Is this necessarily the case?
>>>>>>
>>>>>
>>>>> That'd be a requisite to make the job a transaction, but commit, mi=
rror
>>>>> and stream are not currently transactionable.
>>>>
>>>> Is that already documented anywhere?
>>>>
>>>> (Otherwise I'd be afraid of us forgetting in like a year, asking "Wh=
y
>>>> isn't this a transaction already?", just making it one, and then
>>>> remembering half a year later.)
>>>>
>>>>> The way commit already works, for example, can leave the base and
>>>>> intermediate images as unusable as standalone images. This refactor=
ing
>>>>> will not change that alone.
>>>>>
>>>>> So it's not necessarily a problem, but it's something that would ne=
ed to
>>>>> be fixed if we ever wanted transaction support.
>>>>>
>>>>> However, in talking on IRC we did realize that this patch does chan=
ge
>>>>> behavior...
>>>>>
>>>>> Before:
>>>>>
>>>>> If bdrv_drop_intermediate fails, we store the retcode but continue
>>>>> cleaning up as if it didn't fail. i.e., we don't remove the commit =
job's
>>>>> installed top_bs node.
>>>>>
>>>>> After:
>>>>>
>>>>> if bdrv_drop_intermediate fails, we return the failure retcode and
>>>>> .abort gets called as a result, i.e. we will remove the commit job'=
s
>>>>> installed top_bs node in favor of the original top_bs node.
>>>>>
>>>>> I think this behavior is an improvement,
>>>>
>>>> I agree.
>>>>
>>>>> however it raises a question
>>>>> about the nature of failures in bdrv_drop_intermediate.
>>>>>
>>>>> If this function fails without making any changes, the new commit
>>>>> behavior is good. If it succeeds, we're also good. The problem is w=
ith
>>>>> intermediate or partial successes.
>>>>>
>>>>> If top has multiple parents (I think under normal circumstances it
>>>>> won't, but I'm not absolutely sure) and it fails to update their ba=
cking
>>>>> file references, it might partially succeed.
>>>>>
>>>>> I think commit's usage here is correct, but I think we might need t=
o
>>>>> update bdrv_drop_intermediate to make it roll back changes if it
>>>>> experiences a partial failure to give all-or-nothing semantics.
>>>>
>>>> Sure, that would be good.
>>>>
>>>>> Thoughts?
>>>>
>>>> We could start by calling bdrv_check_update_perm() on all parents be=
fore
>>>> doing any changes.  Then the roll back would consist only of invokin=
g
>>>> bdrv_abort_perm_update() and in theory reverting the
>>>> c->update_filename() changes.
>>>>
>>>> In practice...  How do we want to revert c->update_filename()?  Ther=
e
>>>> currently is no way of getting the old value.  (And just using the o=
ld
>>>> child's filename may well be wrong, because the old child might not =
be
>>>> the one referenced by the image header.)
>>>>
>>>> I have three ideas:
>>>> 1) We could introduce a way of getting the old filename the parent h=
as,
>>>> so we can restore it.
>>>>
>>>> 2) We could make .update_filename() kind of transactionable (seems l=
ike
>>>> overkill, but it would be easier in practice, I think).
>>>>
>>>> 3) We basically ignore .update_filename() errors.  We'd still return=

>>>> them, but we don't abort the graph change operation.  So after
>>>> bdrv_drop_intermediate() is done, the graph has been changed
>>>> succesfully, or it hasn't changed at all -- whether the filename upd=
ates
>>>> all went through, that's a different story.
>>>>
>>>> #3 would be the simplest solution.  It's a bit stupid, but it would =
work
>>>> for most problems, I think; at least the callers would know that the=

>>>> graph is in exactly one of two well-defined states.
>>>
>>> Option 2 sounds nice in theory, but how do you make things
>>> transactionable when they require writing to an image? Either you mak=
e
>>> the change or you don't. If you make it and later notice that you
>>> shouldn't have done so, you can try to write the old value back, but
>>> that can fail, too.
>>
>> Yes, that's what I mean by "kind of".  It's just #1 with the code move=
d
>> somewhere else.
>>
>>> So making .update_filename() transactionable is probably not feasible=
=2E
>>> The choice that is left is whether we update it in .prepare (and
>>> continue with .abort if it fails) or in .commit (and ignore errors).
>>
>> My idea was "if we could update it one time, we can probably update it=
 a
>> second time", so reverting in .abort() would usually work.  I know tha=
t
>> a "usually" is not a "definitely", so that's the "kind of" again.
>>
>> So the abort could still throw an error which we would have to handle
>> like in #3 anyway, I suppose.
>=20
> The question is whether it's better to have the new filename on-disk
> when the transaction aborted and the graph stays as it was (if revertin=
g
> in .abort fails), or to have the old filename there when the transactio=
n
> succeeded.

Hm.  Thanks for expressing it this way.  Both cases are bad.

In the former case, the user gets pleasant surprise when restarting the
VM and seeing that the commit actually worked, despite having gotten an
error before (and that the graph stayed unchanged).
But the bad thing is that if any more graph manipulations are done on
the basis that the commit failed, things may break when the VM is
restarted.  Like, maybe the user decides to write into the overlay's
backing file (I don't know) and expects to see that data through the
overlay, all of it will be effectively lost when the VM is restarted.

In the latter case, we have basically the same problem.  When the VM is
restarted and all the images we had wanted to discard suddenly reappear,
that may break things in much the same way.
The VM restart surprise here is that the commit seemed to work, but then
you see that it actually kind of didn't?  (Because all the images
reappear.  Maybe you deleted them in the meantime, and then the VM won't
even want to restart.)

So especially the last part seems to swing the pendulum in the direction
of me preferring having the new filename when the transaction failed.

But still, I don't know whether that's really the only question.

I don't quite see how you want to do the update only in .commit(), and
still call it a transaction.  Do you want to do the bdrv_reopen() (for
bdrv_backing_update_filename()) in prepare, and then invoke
bdrv_backing_update_filename() in commit?  A bit better than nothing,
but it's not really a transaction.

As I said, the benefit of doing it in .prepare() and then rolling back
in .abort() would be the idea of "if I can update it once, I can
probably update it twice -- especially if I write a value to it that it
already had before".

Max

> Both are confusing, but confusing error cases are a bit more reasonable=

> than confusing success cases, so I tend to agree that updating in
> .prepare and reverting in .abort is probably the best we can do.
>=20
> Kevin


--ZHZKaztwJyYAHUEy4MUrQUZSt9pYsv17p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluPy0IACgkQ9AfbAGHV
z0DMFwf/Usf07Ig+tDsibtt8dI/TvOvjNOUYuEF70jZMJZmRkjwkbQkomyGrZ7YZ
diY7EPYmFIGpo5rfj3h66sVN3oIRzPB6FaeAd4g7Ytd5JQmrCgAWeq0BBrSl31eR
Cx8V1mdTmXA4mTv96GH2SUdyS6PUafGI+FIJCSwzhQrHMxA26jBv+p4Urfz2ED9j
dT3Mp5HScz7Ccjj0CbLp/KBeTFgSb9VNyUO/QHlXU7wKnmJ4WxNgWKIU2WeDCpU8
5mTk2acpSlFltHa1a2/fS9pFRjlj1OujLKTDhXRhTrLTFVhQ62SS/p1eaqyDbQLf
hNlH7W1/g3oLO5gt5QEXD1Aao/ySUQ==
=4tvU
-----END PGP SIGNATURE-----

--ZHZKaztwJyYAHUEy4MUrQUZSt9pYsv17p--
