Received: from eggs.gnu.org ([2001:4830:134:3::10]:35644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxV1w-0004d8-Jf
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 06:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxV1v-0004lD-JA
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 06:27:24 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-5-jsnow@redhat.com>
	<20180904184620.GI415265@localhost.localdomain>
	<63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <57dc1c6c-29bd-f134-646f-15139df7f4f4@redhat.com>
Date: Wed, 5 Sep 2018 12:27:08 +0200
MIME-Version: 1.0
In-Reply-To: <63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MpgvTthAqkZrDYM1X0daoqN5QkNat6SNW"
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
To: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MpgvTthAqkZrDYM1X0daoqN5QkNat6SNW
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <57dc1c6c-29bd-f134-646f-15139df7f4f4@redhat.com>
Subject: Re: [PATCH v4 04/15] block/commit: refactor commit to use job
 callbacks
References: <20180904170930.28619-1-jsnow@redhat.com>
 <20180904170930.28619-5-jsnow@redhat.com>
 <20180904184620.GI415265@localhost.localdomain>
 <63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
In-Reply-To: <63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-04 22:32, John Snow wrote:
>=20
>=20
> On 09/04/2018 02:46 PM, Jeff Cody wrote:
>> On Tue, Sep 04, 2018 at 01:09:19PM -0400, John Snow wrote:
>>> Use the component callbacks; prepare, abort, and clean.
>>>
>>> NB: prepare is only called when the job has not yet failed;
>>> and abort can be called after prepare.
>>>
>>> complete -> prepare -> abort -> clean
>>> complete -> abort -> clean
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  block/commit.c | 90 ++++++++++++++++++++++++++++++++----------------=
----------
>>>  1 file changed, 49 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/block/commit.c b/block/commit.c
>>> index b6e8969877..eb3941e545 100644
>>> --- a/block/commit.c
>>> +++ b/block/commit.c
>>> @@ -36,6 +36,7 @@ typedef struct CommitBlockJob {
>>>      BlockDriverState *commit_top_bs;
>>>      BlockBackend *top;
>>>      BlockBackend *base;
>>> +    BlockDriverState *base_bs;
>>>      BlockdevOnError on_error;
>>>      int base_flags;
>>>      char *backing_file_str;
>>> @@ -68,61 +69,65 @@ static int coroutine_fn commit_populate(BlockBack=
end *bs, BlockBackend *base,
>>>      return 0;
>>>  }
>>> =20
>>> -static void commit_exit(Job *job)
>>> +static int commit_prepare(Job *job)
>>>  {
>>>      CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.j=
ob);
>>> -    BlockJob *bjob =3D &s->common;
>>> -    BlockDriverState *top =3D blk_bs(s->top);
>>> -    BlockDriverState *base =3D blk_bs(s->base);
>>> -    BlockDriverState *commit_top_bs =3D s->commit_top_bs;
>>> -    bool remove_commit_top_bs =3D false;
>>> -
>>> -    /* Make sure commit_top_bs and top stay around until bdrv_replac=
e_node() */
>>> -    bdrv_ref(top);
>>> -    bdrv_ref(commit_top_bs);
>>> =20
>>>      /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE=
 before
>>>       * the normal backing chain can be restored. */
>>>      blk_unref(s->base);
>>> +    s->base =3D NULL;
>>> =20
>>> -    if (!job_is_cancelled(job) && job->ret =3D=3D 0) {
>>> -        /* success */
>>> -        job->ret =3D bdrv_drop_intermediate(s->commit_top_bs, base,
>>> -                                          s->backing_file_str);
>>> -    } else {
>>> -        /* XXX Can (or should) we somehow keep 'consistent read' blo=
cked even
>>> -         * after the failed/cancelled commit job is gone? If we alre=
ady wrote
>>> -         * something to base, the intermediate images aren't valid a=
ny more. */
>>> -        remove_commit_top_bs =3D true;
>>> +    return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
>>> +                                  s->backing_file_str);
>>> +}
>>
>> If we can go from prepare->abort->clean, then that means to me that ev=
ery
>> failure case of .prepare() can be resolved without permanent changes /=
 data
>> loss.  Is this necessarily the case?
>>
>=20
> That'd be a requisite to make the job a transaction, but commit, mirror=

> and stream are not currently transactionable.

Is that already documented anywhere?

(Otherwise I'd be afraid of us forgetting in like a year, asking "Why
isn't this a transaction already?", just making it one, and then
remembering half a year later.)

> The way commit already works, for example, can leave the base and
> intermediate images as unusable as standalone images. This refactoring
> will not change that alone.
>=20
> So it's not necessarily a problem, but it's something that would need t=
o
> be fixed if we ever wanted transaction support.
>=20
> However, in talking on IRC we did realize that this patch does change
> behavior...
>=20
> Before:
>=20
> If bdrv_drop_intermediate fails, we store the retcode but continue
> cleaning up as if it didn't fail. i.e., we don't remove the commit job'=
s
> installed top_bs node.
>=20
> After:
>=20
> if bdrv_drop_intermediate fails, we return the failure retcode and
> .abort gets called as a result, i.e. we will remove the commit job's
> installed top_bs node in favor of the original top_bs node.
>=20
> I think this behavior is an improvement,

I agree.

> however it raises a question
> about the nature of failures in bdrv_drop_intermediate.
>=20
> If this function fails without making any changes, the new commit
> behavior is good. If it succeeds, we're also good. The problem is with
> intermediate or partial successes.
>=20
> If top has multiple parents (I think under normal circumstances it
> won't, but I'm not absolutely sure) and it fails to update their backin=
g
> file references, it might partially succeed.
>=20
> I think commit's usage here is correct, but I think we might need to
> update bdrv_drop_intermediate to make it roll back changes if it
> experiences a partial failure to give all-or-nothing semantics.

Sure, that would be good.

> Thoughts?

We could start by calling bdrv_check_update_perm() on all parents before
doing any changes.  Then the roll back would consist only of invoking
bdrv_abort_perm_update() and in theory reverting the
c->update_filename() changes.

In practice...  How do we want to revert c->update_filename()?  There
currently is no way of getting the old value.  (And just using the old
child's filename may well be wrong, because the old child might not be
the one referenced by the image header.)

I have three ideas:
1) We could introduce a way of getting the old filename the parent has,
so we can restore it.

2) We could make .update_filename() kind of transactionable (seems like
overkill, but it would be easier in practice, I think).

3) We basically ignore .update_filename() errors.  We'd still return
them, but we don't abort the graph change operation.  So after
bdrv_drop_intermediate() is done, the graph has been changed
succesfully, or it hasn't changed at all -- whether the filename updates
all went through, that's a different story.

#3 would be the simplest solution.  It's a bit stupid, but it would work
for most problems, I think; at least the callers would know that the
graph is in exactly one of two well-defined states.

Max


--MpgvTthAqkZrDYM1X0daoqN5QkNat6SNW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluPr3wACgkQ9AfbAGHV
z0CEhQf/SqYHzJRNLeGAX1+5wS4WH+4WIiSyYzHjUHfwnlWZg5lEQhNJZPlqXhlg
1hNBtOejkPBNRbj/Mkz3YmWOWwfaVdwPzjMTywgvk7XL2YgmXHKYk6OYQ6xomlpm
YQjuc4fVBe75Ap1tLjntK6bFDOgmVFeRfJJONFGhW19cMCWFcB23RZR3JZZbSoDL
f8jBGTekRGESkgrYZrMo8vcw93EeepivsBQqw703+LBybWrj3/pgZCoHcsRUOYR0
6BRBTzWjvOs2nLnqhHsCwjoAg4Bay1LPRE9nvCOILB4XIbiT1I0cgppxB14ufG8j
CvshsMOxerBWbGk+HhH6hrV022jtJg==
=hgAD
-----END PGP SIGNATURE-----

--MpgvTthAqkZrDYM1X0daoqN5QkNat6SNW--
