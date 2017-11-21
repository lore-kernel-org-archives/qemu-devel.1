Received: from eggs.gnu.org ([2001:4830:134:3::10]:59957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7Ie-0001Jz-3V
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7Ic-0008RB-30
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:12 -0500
Date: Tue, 21 Nov 2017 10:47:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171121104711.GD23759@stefanha-x1.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<2cd4d33dc68bb3c738e1c9aa39a0ddd4108c401e.1511145863.git.jcody@redhat.com>
	<20171120111653.GB4516@stefanha-x1.localdomain>
	<20171120133619.GA32161@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <20171120133619.GA32161@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 08:36:19AM -0500, Jeff Cody wrote:
> On Mon, Nov 20, 2017 at 11:16:53AM +0000, Stefan Hajnoczi wrote:
> > On Sun, Nov 19, 2017 at 09:46:42PM -0500, Jeff Cody wrote:
> > > --- a/blockjob.c
> > > +++ b/blockjob.c
> > > @@ -291,10 +291,10 @@ void block_job_start(BlockJob *job)
> > >  {
> > >      assert(job && !block_job_started(job) && job->paused &&
> > >             job->driver && job->driver->start);
> > > -    job->co =3D qemu_coroutine_create(block_job_co_entry, job);
> > >      job->pause_count--;
> > >      job->busy =3D true;
> > >      job->paused =3D false;
> > > +    job->co =3D qemu_coroutine_create(block_job_co_entry, job);
> > >      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
> > >  }
> > > =20
> >=20
> > This hunk makes no difference.  The coroutine is only entered by
> > bdrv_coroutine_enter() so the order of job field initialization doesn't
> > matter.
> >=20
>=20
> It likely makes no difference with the current code (unless there is a
> latent bug). However I made the change to protect against the following
> scenario - which, perhaps to your point, would be a bug in any case:
>=20
> 1. job->co =3D qemu_coroutine_create()
>=20
>     * Now block_job_started() returns true, as it just checks for job->co
>=20
> 2. Another thread calls block_job_enter(), before we call
>    bdrv_coroutine_enter().

The job is protected by AioContext acquire/release.  Other threads
cannot touch it because the block_job_start() caller has already
acquired the AioContext.

>=20
>     * block_job_enter() checks job->busy and block_job_started() to
>       determine if coroutine entry is allowed.  Without this change, these
>       checks could pass and coroutine entry could occur.
>=20
>     * I don't think this can happen in the current code, but the above hu=
nk
>       change is still correct, and would protect against such an
>       occurrence.
>
> I guess the question is, "is it worth doing?", to try and prevent that so=
rt
> of buggy behavior. My thought was "yes" because:
>=20
>     A) there is no penalty in doing it this way
>=20
>     B) while a bug, double entry like this can lead to memory and/or
>     data corruption, and the checks for co->caller et al. might not
>     catch it.  This is particularly true if the coroutine exits
>     (COROUTINE_TERMINATE) before the re-entry.
>=20
> But maybe if we are concerned about that we should figure out a way to
> abort() instead.  Of course, that makes allowing recursive coroutines more
> difficult in the future.

The compiler and CPU can reorder memory accesses so simply reordering
assignment statements is ineffective against threads.

I'm against merging this hunk because:

1. There is a proper thread-safety mechanism in place that callers are
   already using, so this is the wrong way to attempt to provide
   thread-safety.

2. This change doesn't protect against the multi-threaded scenario you
   described because the memory order isn't being controlled.

>=20
>=20
> > > @@ -797,11 +797,14 @@ void block_job_sleep_ns(BlockJob *job, QEMUCloc=
kType type, int64_t ns)
> > >          return;
> > >      }
> > > =20
> > > -    job->busy =3D false;
> > > +    /* We need to leave job->busy set here, because when we have
> > > +     * put a coroutine to 'sleep', we have scheduled it to run in
> > > +     * the future.  We cannot enter that same coroutine again before
> > > +     * it wakes and runs, otherwise we risk double-entry or entry af=
ter
> > > +     * completion. */
> > >      if (!block_job_should_pause(job)) {
> > >          co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
> > >      }
> > > -    job->busy =3D true;
> > > =20
> > >      block_job_pause_point(job);
> >=20
> > This leaves a stale doc comment in include/block/blockjob_int.h:
> >=20
> >   /**
> >    * block_job_sleep_ns:
> >    * @job: The job that calls the function.
> >    * @clock: The clock to sleep on.
> >    * @ns: How many nanoseconds to stop for.
> >    *
> >    * Put the job to sleep (assuming that it wasn't canceled) for @ns
> >    * nanoseconds.  Canceling the job will interrupt the wait immediatel=
y.
> >                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> >    */
>=20
> I didn't catch the doc, that should be changed as well.
>=20
> >   void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns=
);
> >=20
> > This raises questions about the ability to cancel sleep:
> >=20
> > 1. Does something depend on cancelling sleep?
> >=20
>=20
> Not that I can tell.  The advantage is that you don't have to wait for the
> timer, so something like qmp_block_job_cancel() will cancel sooner.
>=20
> But it is obviously broken with the current coroutine implementation to t=
ry
> to do that.
>=20
> > 2. Did cancellation work properly in commit
> >    4513eafe928ff47486f4167c28d364c72b5ff7e3 ("block: add
> >    block_job_sleep_ns") and was it broken afterwards?
> >=20
>=20
> With iothreads, the answer is complicated.  It was broken for a while for
> other reasons.
>=20
> It broke after using aio_co_wake() in the sleep timer cb (commmit
> 2f47da5f7f), which added the ability to schedule a coroutine if the timer
> callback was called from the wrong AioContext.
>=20
> Prior to that it "worked" in that the segfault was not present.
>=20
> But even to bisect back to 2f47da5f7f was not straightforward, because
> attempting them stream/cancel with iothreads would not even work until
> c324fd0 (so I only bisected back as far as c324fd0 would cleanly apply).
>=20
> And it is tricky to say if it "works" or not, because it is racy.  What m=
ay
> have appeared to work may be more attributed to luck and timing.
>=20
> If the coroutine is going to run at a future time, we cannot enter it
> beforehand.  We risk the coroutine not even existing when the timer does =
run
> the sleeping coroutine.  At the very least, early entry with the current
> code would require a way to delete the associated timer.
>=20
> > It is possible to fix the recursive coroutine entry without losing sleep
> > cancellation.  Whether it's worth the trouble depends on the answers to
> > the above questions.
> >=20
>=20
> I contemplated the same thing.
>=20
> At least for 2.11, fixing recursive coroutine entry is probably more than=
 we
> want to do.
>=20
> Long term, my opinion is that we should fix it, because preventing it
> becomes more difficult. It is easy to miss something that might cause a
> recursive entry in code reviews, and since it can be racy, casual testing
> may often miss it as well.

I think both your and Paolos answers show that we don't need to cancel
the timer.  It's okay if the coroutine sleeps for the full duration.
I'm happy with your approach.

Stefan

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFAQvAAoJEJykq7OBq3PIQBIIAJt67n0QTHqv+tatbI6rUhY2
/UEJ/bVGbxeWMWDLMYUOwhE2NJIKDF8fabTy5gYQS5W7zBt0WbQwtEfD6nafaNJB
iFjlREVEtOO2sPo1SqFuSWw/FsEYSRvMtVIjSjhQTalmX6VKWx12nz59ZhSgBHai
KxAQf3UCQwv3W/uXIXSrZfVIm7nxu4HtOxD2eLkOc31aiDVs54c+1M4s1S+Ew0Fh
rLUEU0YWlI8oAgHI/0LvZ61TgyWtLNG9wd9emajji2S/lYRZeBjz8VdGII7+zUg5
yqEx0C5yU60wEonHQ5nsAzHb5y3g1MIzt5bA4PveR06lHF6G2MbKQBfgtDonD1c=
=102J
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
