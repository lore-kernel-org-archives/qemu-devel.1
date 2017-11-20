Received: from eggs.gnu.org ([2001:4830:134:3::10]:39800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGk4S-0003N7-Gj
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 06:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGk4P-0001Ps-Cv
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 06:17:00 -0500
Date: Mon, 20 Nov 2017 11:16:53 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120111653.GB4516@stefanha-x1.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<2cd4d33dc68bb3c738e1c9aa39a0ddd4108c401e.1511145863.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <2cd4d33dc68bb3c738e1c9aa39a0ddd4108c401e.1511145863.git.jcody@redhat.com>
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:46:42PM -0500, Jeff Cody wrote:
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -291,10 +291,10 @@ void block_job_start(BlockJob *job)
>  {
>      assert(job && !block_job_started(job) && job->paused &&
>             job->driver && job->driver->start);
> -    job->co =3D qemu_coroutine_create(block_job_co_entry, job);
>      job->pause_count--;
>      job->busy =3D true;
>      job->paused =3D false;
> +    job->co =3D qemu_coroutine_create(block_job_co_entry, job);
>      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
>  }
> =20

This hunk makes no difference.  The coroutine is only entered by
bdrv_coroutine_enter() so the order of job field initialization doesn't
matter.

> @@ -797,11 +797,14 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockTyp=
e type, int64_t ns)
>          return;
>      }
> =20
> -    job->busy =3D false;
> +    /* We need to leave job->busy set here, because when we have
> +     * put a coroutine to 'sleep', we have scheduled it to run in
> +     * the future.  We cannot enter that same coroutine again before
> +     * it wakes and runs, otherwise we risk double-entry or entry after
> +     * completion. */
>      if (!block_job_should_pause(job)) {
>          co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
>      }
> -    job->busy =3D true;
> =20
>      block_job_pause_point(job);

This leaves a stale doc comment in include/block/blockjob_int.h:

  /**
   * block_job_sleep_ns:
   * @job: The job that calls the function.
   * @clock: The clock to sleep on.
   * @ns: How many nanoseconds to stop for.
   *
   * Put the job to sleep (assuming that it wasn't canceled) for @ns
   * nanoseconds.  Canceling the job will interrupt the wait immediately.
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   */
  void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);

This raises questions about the ability to cancel sleep:

1. Does something depend on cancelling sleep?

2. Did cancellation work properly in commit
   4513eafe928ff47486f4167c28d364c72b5ff7e3 ("block: add
   block_job_sleep_ns") and was it broken afterwards?

It is possible to fix the recursive coroutine entry without losing sleep
cancellation.  Whether it's worth the trouble depends on the answers to
the above questions.

Stefan

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaErmlAAoJEJykq7OBq3PIvYAIAKiZWRXNx0EJawJ46AHbsLGl
qb3rbyAS3v3svNxIfGPvyQh4Wd5C2Nlcar2qrbK+XcwXc7uIX2SHTwLCbA7Cx/2k
bE8EV/M8IsOheWSWOwX0fqgDVf/BpRxlz4hP3/wV34vRaNpW6MUM8jr7/KJwIYva
awD63thVnJopLX7IvMFucdJInXOp2Wp/pFncazt+xaP3ug9tKS5f9f6CmAcvwQKT
eYCzK69CWFxFF6gd+ZqGtCKEoabIi5Ih9594DI/jAfOwRBN2HjQjT1w3YpQOF5tj
VplmTdxNcFXBLWPNYGy4zEAsIXebMVg7O41O9LHFt7HfJCu8cwJa4U7ZKfy9hwk=
=qgJM
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
