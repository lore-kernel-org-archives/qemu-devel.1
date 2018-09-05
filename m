Received: from eggs.gnu.org ([2001:4830:134:3::10]:57173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fxWNC-0001EY-N8
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fxWNB-00024Q-Eb
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 07:53:26 -0400
Date: Wed, 5 Sep 2018 13:53:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180905115310.GC4489@localhost.localdomain>
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-5-jsnow@redhat.com>
	<20180904184620.GI415265@localhost.localdomain>
	<63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
	<57dc1c6c-29bd-f134-646f-15139df7f4f4@redhat.com>
	<20180905104941.GB4489@localhost.localdomain>
	<78038681-9981-ce9f-e0ba-82c43c31e98d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <78038681-9981-ce9f-e0ba-82c43c31e98d@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.09.2018 um 13:37 hat Max Reitz geschrieben:
> On 2018-09-05 12:49, Kevin Wolf wrote:
> > Am 05.09.2018 um 12:27 hat Max Reitz geschrieben:
> >> On 2018-09-04 22:32, John Snow wrote:
> >>>
> >>>
> >>> On 09/04/2018 02:46 PM, Jeff Cody wrote:
> >>>> On Tue, Sep 04, 2018 at 01:09:19PM -0400, John Snow wrote:
> >>>>> Use the component callbacks; prepare, abort, and clean.
> >>>>>
> >>>>> NB: prepare is only called when the job has not yet failed;
> >>>>> and abort can be called after prepare.
> >>>>>
> >>>>> complete -> prepare -> abort -> clean
> >>>>> complete -> abort -> clean
> >>>>>
> >>>>> Signed-off-by: John Snow <jsnow@redhat.com>
> >>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>>>> ---
> >>>>>  block/commit.c | 90 ++++++++++++++++++++++++++++++++--------------=
------------
> >>>>>  1 file changed, 49 insertions(+), 41 deletions(-)
> >>>>>
> >>>>> diff --git a/block/commit.c b/block/commit.c
> >>>>> index b6e8969877..eb3941e545 100644
> >>>>> --- a/block/commit.c
> >>>>> +++ b/block/commit.c
> >>>>> @@ -36,6 +36,7 @@ typedef struct CommitBlockJob {
> >>>>>      BlockDriverState *commit_top_bs;
> >>>>>      BlockBackend *top;
> >>>>>      BlockBackend *base;
> >>>>> +    BlockDriverState *base_bs;
> >>>>>      BlockdevOnError on_error;
> >>>>>      int base_flags;
> >>>>>      char *backing_file_str;
> >>>>> @@ -68,61 +69,65 @@ static int coroutine_fn commit_populate(BlockBa=
ckend *bs, BlockBackend *base,
> >>>>>      return 0;
> >>>>>  }
> >>>>> =20
> >>>>> -static void commit_exit(Job *job)
> >>>>> +static int commit_prepare(Job *job)
> >>>>>  {
> >>>>>      CommitBlockJob *s =3D container_of(job, CommitBlockJob, common=
=2Ejob);
> >>>>> -    BlockJob *bjob =3D &s->common;
> >>>>> -    BlockDriverState *top =3D blk_bs(s->top);
> >>>>> -    BlockDriverState *base =3D blk_bs(s->base);
> >>>>> -    BlockDriverState *commit_top_bs =3D s->commit_top_bs;
> >>>>> -    bool remove_commit_top_bs =3D false;
> >>>>> -
> >>>>> -    /* Make sure commit_top_bs and top stay around until bdrv_repl=
ace_node() */
> >>>>> -    bdrv_ref(top);
> >>>>> -    bdrv_ref(commit_top_bs);
> >>>>> =20
> >>>>>      /* Remove base node parent that still uses BLK_PERM_WRITE/RESI=
ZE before
> >>>>>       * the normal backing chain can be restored. */
> >>>>>      blk_unref(s->base);
> >>>>> +    s->base =3D NULL;
> >>>>> =20
> >>>>> -    if (!job_is_cancelled(job) && job->ret =3D=3D 0) {
> >>>>> -        /* success */
> >>>>> -        job->ret =3D bdrv_drop_intermediate(s->commit_top_bs, base,
> >>>>> -                                          s->backing_file_str);
> >>>>> -    } else {
> >>>>> -        /* XXX Can (or should) we somehow keep 'consistent read' b=
locked even
> >>>>> -         * after the failed/cancelled commit job is gone? If we al=
ready wrote
> >>>>> -         * something to base, the intermediate images aren't valid=
 any more. */
> >>>>> -        remove_commit_top_bs =3D true;
> >>>>> +    return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
> >>>>> +                                  s->backing_file_str);
> >>>>> +}
> >>>>
> >>>> If we can go from prepare->abort->clean, then that means to me that =
every
> >>>> failure case of .prepare() can be resolved without permanent changes=
 / data
> >>>> loss.  Is this necessarily the case?
> >>>>
> >>>
> >>> That'd be a requisite to make the job a transaction, but commit, mirr=
or
> >>> and stream are not currently transactionable.
> >>
> >> Is that already documented anywhere?
> >>
> >> (Otherwise I'd be afraid of us forgetting in like a year, asking "Why
> >> isn't this a transaction already?", just making it one, and then
> >> remembering half a year later.)
> >>
> >>> The way commit already works, for example, can leave the base and
> >>> intermediate images as unusable as standalone images. This refactoring
> >>> will not change that alone.
> >>>
> >>> So it's not necessarily a problem, but it's something that would need=
 to
> >>> be fixed if we ever wanted transaction support.
> >>>
> >>> However, in talking on IRC we did realize that this patch does change
> >>> behavior...
> >>>
> >>> Before:
> >>>
> >>> If bdrv_drop_intermediate fails, we store the retcode but continue
> >>> cleaning up as if it didn't fail. i.e., we don't remove the commit jo=
b's
> >>> installed top_bs node.
> >>>
> >>> After:
> >>>
> >>> if bdrv_drop_intermediate fails, we return the failure retcode and
> >>> .abort gets called as a result, i.e. we will remove the commit job's
> >>> installed top_bs node in favor of the original top_bs node.
> >>>
> >>> I think this behavior is an improvement,
> >>
> >> I agree.
> >>
> >>> however it raises a question
> >>> about the nature of failures in bdrv_drop_intermediate.
> >>>
> >>> If this function fails without making any changes, the new commit
> >>> behavior is good. If it succeeds, we're also good. The problem is with
> >>> intermediate or partial successes.
> >>>
> >>> If top has multiple parents (I think under normal circumstances it
> >>> won't, but I'm not absolutely sure) and it fails to update their back=
ing
> >>> file references, it might partially succeed.
> >>>
> >>> I think commit's usage here is correct, but I think we might need to
> >>> update bdrv_drop_intermediate to make it roll back changes if it
> >>> experiences a partial failure to give all-or-nothing semantics.
> >>
> >> Sure, that would be good.
> >>
> >>> Thoughts?
> >>
> >> We could start by calling bdrv_check_update_perm() on all parents befo=
re
> >> doing any changes.  Then the roll back would consist only of invoking
> >> bdrv_abort_perm_update() and in theory reverting the
> >> c->update_filename() changes.
> >>
> >> In practice...  How do we want to revert c->update_filename()?  There
> >> currently is no way of getting the old value.  (And just using the old
> >> child's filename may well be wrong, because the old child might not be
> >> the one referenced by the image header.)
> >>
> >> I have three ideas:
> >> 1) We could introduce a way of getting the old filename the parent has,
> >> so we can restore it.
> >>
> >> 2) We could make .update_filename() kind of transactionable (seems like
> >> overkill, but it would be easier in practice, I think).
> >>
> >> 3) We basically ignore .update_filename() errors.  We'd still return
> >> them, but we don't abort the graph change operation.  So after
> >> bdrv_drop_intermediate() is done, the graph has been changed
> >> succesfully, or it hasn't changed at all -- whether the filename updat=
es
> >> all went through, that's a different story.
> >>
> >> #3 would be the simplest solution.  It's a bit stupid, but it would wo=
rk
> >> for most problems, I think; at least the callers would know that the
> >> graph is in exactly one of two well-defined states.
> >=20
> > Option 2 sounds nice in theory, but how do you make things
> > transactionable when they require writing to an image? Either you make
> > the change or you don't. If you make it and later notice that you
> > shouldn't have done so, you can try to write the old value back, but
> > that can fail, too.
>=20
> Yes, that's what I mean by "kind of".  It's just #1 with the code moved
> somewhere else.
>=20
> > So making .update_filename() transactionable is probably not feasible.
> > The choice that is left is whether we update it in .prepare (and
> > continue with .abort if it fails) or in .commit (and ignore errors).
>=20
> My idea was "if we could update it one time, we can probably update it a
> second time", so reverting in .abort() would usually work.  I know that
> a "usually" is not a "definitely", so that's the "kind of" again.
>=20
> So the abort could still throw an error which we would have to handle
> like in #3 anyway, I suppose.

The question is whether it's better to have the new filename on-disk
when the transaction aborted and the graph stays as it was (if reverting
in .abort fails), or to have the old filename there when the transaction
succeeded.

Both are confusing, but confusing error cases are a bit more reasonable
than confusing success cases, so I tend to agree that updating in
=2Eprepare and reverting in .abort is probably the best we can do.

Kevin

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbj8OmAAoJEH8JsnLIjy/WsWMP/3mI6gwIX8GXb6qdLhgZnrV5
ZOpdVIa4o0mBBKDsx2fWgidLu/unjSjcD1KfaPkdlvS5eRcF6feUyomM70vtgtA5
NljLndy/8N60a8+0Lc5jTKSu2aUa/eISIFbfaGqHnUvtF++DKtoLJU9mrSD/u0Kf
8QGUyGtE5EwZW+3K5ufUv05Vs5poYyKp4ot1vJznPoBBXn0aPzjatl8QgBk0sLtE
pNQEtDYQOtbwTTyDQlaBmZDXdEHift1I5f0l3UMJFR6t0FYO8Ov3ddlJYsaMMGL/
JRmWc/VcodlDlVkRpwXXmuhgNgrvnpJFmgDKdQ9TMDLoQkTXk/aZTC0YbLyz4CUV
EXBvC/Ul1R72JarbEYTU1iG6MBZ4WsFIkHwgTlk5ecEO73Y2ECCO5QMbWN/FWLTj
GnQfl+LPgSiD/hENA7+D7hcJ+oMhP4lw1VSv6QVb7Lm0V4efWq6PZqNJeLbyQDV5
W4QdSwOjv11PJI5k/vGkNZmMxpuN5HpbErDzp3S9ayG+P0Lq2J+27l2q0acyy0x4
xlMdET9a4SHMxp6lLzCCJORhTCHVE9DitaNBGjKycYWKqcdBI9sJMLTH0hakCV1j
TkKqdew0TjCfxcg8D1bUDgF6T992SxCUGMueyUX7ObZ84fdqEFbuN9LwFJSq+ZnD
fStBvO3zD/lXOinOKKZW
=SZT9
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
