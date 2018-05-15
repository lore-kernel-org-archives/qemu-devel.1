Received: from eggs.gnu.org ([2001:4830:134:3::10]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIadf-0005Ry-JA
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIadZ-0004fB-D3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:09:15 -0400
Date: Tue, 15 May 2018 16:08:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180515140850.GE4442@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-40-kwolf@redhat.com>
	<1212f284-2af7-e586-ec95-18e77a53d13a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <1212f284-2af7-e586-ec95-18e77a53d13a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 39/42] job: Add lifecycle QMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.05.2018 um 00:31 hat Max Reitz geschrieben:
> On 2018-05-09 18:26, Kevin Wolf wrote:
> > This adds QMP commands that control the transition between states of the
> > job lifecycle.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/job.json | 112 ++++++++++++++++++++++++++++++++++++++++++++++
> >  job-qmp.c     | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  MAINTAINERS   |   1 +
> >  Makefile.objs |   2 +-
> >  trace-events  |   9 ++++
> >  5 files changed, 263 insertions(+), 1 deletion(-)
> >  create mode 100644 job-qmp.c
> >=20
> > diff --git a/qapi/job.json b/qapi/job.json
> > index bd88a358d0..7b84158292 100644
> > --- a/qapi/job.json
> > +++ b/qapi/job.json
> > @@ -63,3 +63,115 @@
> >  { 'event': 'JOB_STATUS_CHANGE',
> >    'data': { 'id': 'str',
> >              'status': 'JobStatus' } }
> > +
> > +##
> > +# @job-pause:
> > +#
> > +# Pause an active job.
> > +#
> > +# This command returns immediately after marking the active job for pa=
using.
> > +# Pausing an already paused job has no cumulative effect; a single job=
-resume
> > +# command will resume the job.
>=20
> Pausing an already paused job is, in fact, an error.
>=20
> (Which should be noted here instead of making it appear like it'd be
> idempotent.)

Aye. Interestingly, I managed to fix it below in job-resume, but missed
it here. I should also stick in a patch somewhere early in the series
that fixes the documentation of block-job-pause/resume.

> > +##
> > +# @job-cancel:
> > +#
> > +# Instruct an active background job to cancel at the next opportunity.
> > +# This command returns immediately after marking the active job for
> > +# cancellation.
> > +#
> > +# The job will cancel as soon as possible and then emit a JOB_STATUS_C=
HANGE
> > +# event. Usually, the status will change to ABORTING, but it is possib=
le that
> > +# a job successfully completes (e.g. because it was almost done and th=
ere was
> > +# no opportunity to cancel earlier than completing the job) and transi=
tions to
> > +# PENDING instead.
> > +#
> > +# Note that if you issue 'job-cancel' after a mirror block job has ind=
icated
> > +# (via the event BLOCK_JOB_READY, and by transitioning into the READY =
state)
> > +# that the source and destination are synchronized, then the job always
> > +# completes successfully and transitions to PENDING as well as trigger=
ing the
> > +# event BLOCK_JOB_COMPLETED, to indicate that the mirroring has ended =
and the
> > +# destination now has a point-in-time copy tied to the time of the
> > +# cancellation.
> > +#
> > +# @id: The job identifier.
> > +#
> > +# @force: If true, and the job is already in the READY state, abandon =
the job
> > +#         immediately (even if it is paused) instead of waiting for the
> > +#         destination to complete its final synchronization
>=20
> The note on "final synchronization" is extremely mirror-specific.  I see
> three choices here:
>=20
> (1) If mirror stays the only job with this special cancel semantics,
> then we are free to note that this is a mirror-specific flag here.
>=20
> (2) Even if some other job might come along at some point where use of
> @force may make sense, that doesn't stop us from now noting that only
> mirror supports this, which helps readers understand what "destination"
> and "final synchronization" mean.
>=20
> (Yes, so (1) and (2) are basically the same.)
>=20
> (3) We try to find some general description and drop the last part.
> Like "If a job would normally decide to complete instead of actually
> aborting, this flag can be used to convince it otherwise."  But that's
> so handwavy, I'd rather just mark it as a special mirror flag for now.

Or how about this one?

(4) Mirror is really abusing cancel for a second completion mode and we
    don't want to have this kind of ugliness in job-cancel. Remove
    @force from the schema and internally always use force=3Dtrue. For
    now, block-job-cancel does the job (no pun intended) for mirror, and
    maybe we can later introduce a way to select completion mode with
    job-complete.

This would also get us rid of that whole long paragraph above that
explains how mirror jobs have an exceptional behaviour.

> > diff --git a/Makefile.objs b/Makefile.objs
> > index 3df8d58e49..253e0356f3 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -66,7 +66,7 @@ chardev-obj-y =3D chardev/
> >  # block-obj-y is code used by both qemu system emulation and qemu-img
> > =20
> >  block-obj-y +=3D nbd/
> > -block-obj-y +=3D block.o blockjob.o job.o
> > +block-obj-y +=3D block.o blockjob.o job.o job-qmp.o
>=20
> Shouldn't this be in common-obj-y like blockdev?

Seems to build with that change, so it can't be wrong...

Kevin

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa+unyAAoJEH8JsnLIjy/Wp0kQALcAwVJPj8gmjfM7av9psytd
Xa8Yg9oJsve8+bYWl35xU2sSqWiJK8GVTO1oINVHKENn6EZvzcx8AtkDrhOfQCDp
f9lfhC8Gw0HKhmVtXyoLU8OZFFxNz7Z4/+YPLRGgLwAy437bM3NFiKqW9triq2fQ
bGoiYjIXoJPtH1JWCG2d+wQhRFnvg2pROf4Y8tG14Sm6myzot2+//+9m4dWb6nYb
Ur23v/gUeYQhj53uXu/b/FETGpmR+T0ek1uFbPFYx+Xp3Q81zaCkwfiotOys/2SI
j2H03r91tUgmab7meYie5AeBxp2iQkWoJed+VlVMHwMR/c1Nui8fjvXGQ5CAoYQd
3z/imKvDi9OWTjoOskapUHsaAhWJvxapZkk8p5J6N0HuQYKX3FNaQIL3KVgtaQ5a
x34gVx4Uet28yjpRiS3lHWLut8vKCd1ucDxG7Rdkevso0pkvtFrWE2tYa/CFLpMf
A1BlkLbsLGbIU8Z6zRWWGXSwXHDcCB+Fw1Gm5VTbMuKR2Ltb77gUUXt0YJ23HIAl
wC+N6uUdLoYgDunttHitnlmk79vBHuRMXZNdNhP62QbpTVvUSzfC2RRfEmxIS2BO
I1gZ3FJFe/VmNmhZwo4Ku57QvWTRQPKPio5MmGlkDaqIlL2jV6fhOt/QQ4d6ci1R
GnP67Gs0x12sgoBZTOCN
=keEi
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
