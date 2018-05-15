Received: from eggs.gnu.org ([2001:4830:134:3::10]:41172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIYtm-0001Jm-M8
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIYtg-00038v-D0
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:17:46 -0400
Date: Tue, 15 May 2018 14:17:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180515121725.GB4442@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-18-kwolf@redhat.com>
	<65bf7408-bdd9-6a7d-6c77-318715a4cc59@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <65bf7408-bdd9-6a7d-6c77-318715a4cc59@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/42] job: Move defer_to_main_loop to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.05.2018 um 17:52 hat Max Reitz geschrieben:
> On 2018-05-09 18:26, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/blockjob.h     |  5 ----
> >  include/block/blockjob_int.h | 19 ---------------
> >  include/qemu/job.h           | 20 ++++++++++++++++
> >  block/backup.c               |  7 +++---
> >  block/commit.c               | 11 +++++----
> >  block/mirror.c               | 15 ++++++------
> >  block/stream.c               | 14 +++++------
> >  blockjob.c                   | 57 ++++--------------------------------=
--------
> >  job.c                        | 33 +++++++++++++++++++++++++
> >  tests/test-bdrv-drain.c      |  7 +++---
> >  tests/test-blockjob-txn.c    | 13 +++++-----
> >  tests/test-blockjob.c        |  7 +++---
> >  12 files changed, 98 insertions(+), 110 deletions(-)
>=20
> [...]
>=20
> > diff --git a/block/commit.c b/block/commit.c
> > index 85baea8f92..d326766e4d 100644
> > --- a/block/commit.c
> > +++ b/block/commit.c
> > @@ -72,9 +72,10 @@ typedef struct {
> >      int ret;
> >  } CommitCompleteData;
> > =20
> > -static void commit_complete(BlockJob *job, void *opaque)
> > +static void commit_complete(Job *job, void *opaque)
> >  {
> > -    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common);
> > +    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.job=
);
>=20
> Now this is just abuse.
>=20
> ...but it's not the first time someone packs two container_of() into
> one, it appears.  So, whatever, I guess.

I don't think it's abuse. Why wouldn't I directly cast to the type that
I really want instead of casting to each of the uninteresting parent
classes, too?

> > @@ -170,3 +171,35 @@ void job_unref(Job *job)
> >          g_free(job);
> >      }
> >  }
> > +
> > +typedef struct {
> > +    Job *job;
> > +    JobDeferToMainLoopFn *fn;
> > +    void *opaque;
> > +} JobDeferToMainLoopData;
> > +
> > +static void job_defer_to_main_loop_bh(void *opaque)
> > +{
> > +    JobDeferToMainLoopData *data =3D opaque;
> > +    Job *job =3D data->job;
> > +    AioContext *aio_context =3D job->aio_context;
> > +
> > +    /* Prevent race with job_defer_to_main_loop() */
> > +    aio_context_acquire(aio_context);
>=20
> I don't have a good feeling about this.  The original code had this
> comment above an aio_context_acquire() for a context that might
> decidedly not have anything to do with the BB's context;
> block_job_defer_to_main_loop()'s description was that it would acquire
> the latter, so why did it acquire the former at all?
>=20
> We wouldn't need this comment here at all, because acquiring this
> AioContext is part of the interface.  That's why I don't have a good
> feeling.

To be honest, I don't fully understand what the old code was trying to
do or what race it was talking about, because I don't see any potential
race with job_defer_to_main_loop() (neither in the old nor in the new
code).

My suspicion is that Stefan solved the race that you reported [1] (and
which was not with job_defer_to_main_loop(), but with random code that
runs between that and the BH) just by adding some more code that made
the scenario safe, but missed that this also made the existing code
redundant. In other words, I think taking data->aio_context didn't serve
a purpose even in the old code.

The only thing it could possibly protect is the access of data->job->bs,
but that's not something that changes between job_defer_to_main_loop()
and the execution of the BH.

[1] https://lists.gnu.org/archive/html/qemu-devel/2014-10/msg00260.html

> The best explanation I can come up with is that the original code
> acquired the AioContext both of the block device at the time of the BH
> (because that needs to be done), and at the time of
> block_job_defer_to_main_loop() -- because the latter is probably the
> context the block_job_defer_to_main_loop() call came from, so it should
> be (b)locked.
>=20
> But if that's the case, then the same should be done here.  The context
> of the job may change between scheduling the BH and the BH being
> executed, so we might lock a different context here than the one
> job_defer_to_main_loop() ran in (i.e., job->aio_context at the time of
> job_defer_to_main_loop() running).  And maybe we should lock that old
> context, too -- just like block_job_defer_to_main_loop_bh() did.

Why should we lock the old context? We don't access anything protected
by it. Even the data->job->bs access has gone away because we now have
job->aio_context.

Kevin

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa+s/VAAoJEH8JsnLIjy/Wg/8P/3niFzCRv60NjXPSv1HR1k3O
75w3Y9m49sUAeUQoaUM/gG9QNGUgI620dNRKUNj+Z0IBAAiicp3dIwqBUac/POGd
7DBY5fF0W/4vnvO6Heu3uw5T/9MmT5xV8/V0RPpaZVemWXiSceEowV2eTPyLOYaW
zpoZBPYLOp5UijVDpQGR+ScXshP0Ig+BBzm/v00TI4A1OvlDcApkXKGNMM25D+J4
LHMWguiPM9buV6dOsCDnLyWzBaial+S9M8j479srJtNfKyU8A7r5oVqSAiV/x9pP
/0p7YJlStuMt/35KqFucFpC5TQQ3e8xqauiIDI4Q0v+aPCu/YEtGllMUPQ6mcbc9
Tf1plt3IOcdIRrYYIiZI0oI60ukltyaxY+V6bSEEq7EzgNmskIdi5CFBEJRT2xTf
AD2BGaBv14GkfNDvR4G1EWB0EIc72aoMVLY2QQ3sE2eb93MegjjJBW8ucmuZ86c7
GlBXC/Bap712U79LuenYX+tlP2/K+7a95NxToBl58pE5Pw/q0yWw8E/i5XGGiCP+
hjxXtZiOKnBYD7tjiSgnkDOx7lQKQJup30drXS57bW/BCaxC+eWRhpnHLfjEFdax
C3Cqos69mfhEWT0xV2tXkQ6iKmXOrOeB8P9WHEx5ZNi+IgUXCnPq5m9kBuBtJUg5
V/qQ1cHI+aXaNJgYWO1t
=rbgd
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
