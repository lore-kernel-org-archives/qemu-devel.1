Received: from eggs.gnu.org ([2001:4830:134:3::10]:37691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuFNb-0001Zm-1U
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuF8k-00060n-Tl
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:52:59 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-9-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e6fc7a59-748e-858b-0359-89749025105e@redhat.com>
Date: Mon, 27 Aug 2018 12:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180823220856.10094-9-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3k0YskHDDSurl6t4kROI0qTpK34hU8ePD"
Subject: Re: [Qemu-devel] [PATCH v2 8/9] jobs: remove ret argument to
 job_completed; privatize it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3k0YskHDDSurl6t4kROI0qTpK34hU8ePD
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <e6fc7a59-748e-858b-0359-89749025105e@redhat.com>
Subject: Re: [PATCH v2 8/9] jobs: remove ret argument to job_completed;
 privatize it
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-9-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-9-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:08, John Snow wrote:
> Jobs are now expected to return their retcode on the stack, from the
> .run callback, so we can remove that argument.
>=20
> job_cancel does not need to set -ECANCELED because job_completed will
> update the return code itself if the job was canceled.
>=20
> While we're here, make job_completed static to job.c and remove it from=

> job.h; move the documentation of return code to the .run() callback and=

> to the job->ret property, accordingly.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/job.h | 24 +++++++++++-------------
>  job.c              | 11 ++++++-----
>  trace-events       |  2 +-
>  3 files changed, 18 insertions(+), 19 deletions(-)

Er, yeah.  Sorry for not being able to read.  Again.

> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index c67f6a647e..2990f28edc 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -124,7 +124,7 @@ typedef struct Job {
>      /** Estimated progress_current value at the completion of the job =
*/
>      int64_t progress_total;
> =20
> -    /** ret code passed to job_completed. */
> +    /** Return code from @run callback; 0 on success and -errno on fai=
lure. */

Hm.  Not really, it's the general status of the whole job, isn't it?
Besides being the return value from .run(), it's also set by .exit() (so
it's presumably going to be the return value from .prepare() after part
2) and by job_update_rc() when the job has been cancelled.

>      int ret;
> =20
>      /** Error object for a failed job **/
> @@ -168,7 +168,16 @@ struct JobDriver {
>      /** Enum describing the operation */
>      JobType job_type;
> =20
> -    /** Mandatory: Entrypoint for the Coroutine. */
> +    /**
> +     * Mandatory: Entrypoint for the Coroutine.
> +     *
> +     * This callback will be invoked when moving from CREATED to RUNNI=
NG.
> +     *
> +     * If this callback returns nonzero, the job transaction it is par=
t of is
> +     * aborted. If it returns zero, the job moves into the WAITING sta=
te. If it
> +     * is the last job to complete in its transaction, all jobs in the=

> +     * transaction move from WAITING to PENDING.
> +     */

Moving this description from job_completed() seems to imply we do want
to call job_update_rc() right after invoking .run().

>      int coroutine_fn (*run)(Job *job, Error **errp);
> =20
>      /**
> @@ -492,17 +501,6 @@ void job_early_fail(Job *job);
>  /** Moves the @job from RUNNING to READY */
>  void job_transition_to_ready(Job *job);
> =20
> -/**
> - * @job: The job being completed.
> - * @ret: The status code.
> - *
> - * Marks @job as completed. If @ret is non-zero, the job transaction i=
t is part
> - * of is aborted. If @ret is zero, the job moves into the WAITING stat=
e. If it
> - * is the last job to complete in its transaction, all jobs in the tra=
nsaction
> - * move from WAITING to PENDING.
> - */
> -void job_completed(Job *job, int ret);
> -
>  /** Asynchronously complete the specified @job. */
>  void job_complete(Job *job, Error **errp);
> =20
> diff --git a/job.c b/job.c
> index bc8dad4e71..213042b762 100644
> --- a/job.c
> +++ b/job.c
> @@ -535,6 +535,8 @@ void job_drain(Job *job)
>      }
>  }
> =20
> +static void job_completed(Job *job);
> +
>  static void job_exit(void *opaque)
>  {
>      Job *job =3D (Job *)opaque;
> @@ -545,7 +547,7 @@ static void job_exit(void *opaque)
>          job->driver->exit(job);
>          aio_context_release(aio_context);
>      }
> -    job_completed(job, job->ret);
> +    job_completed(job);
>  }
> =20
>  /**
> @@ -883,13 +885,12 @@ static void job_completed_txn_success(Job *job)
>      }
>  }
> =20
> -void job_completed(Job *job, int ret)
> +static void job_completed(Job *job)
>  {
>      assert(job && job->txn && !job_is_completed(job));
> =20
> -    job->ret =3D ret;
>      job_update_rc(job);

I think we want to remove the job_update_rc() from here.  It should be
called after job->ret is updated, i.e. immediately after .run() and
=2Eexit() have been invoked.  (Or presumably .prepare() in part 2.)
Oh, and in job_cancel() before it invokes job_completed()?

But then again, maybe it would be easiest to keep it here...  It just
doesn't feel quite right to me.

Max

> -    trace_job_completed(job, ret, job->ret);
> +    trace_job_completed(job, job->ret);
>      if (job->ret) {
>          job_completed_txn_abort(job);
>      } else {
> @@ -905,7 +906,7 @@ void job_cancel(Job *job, bool force)
>      }
>      job_cancel_async(job, force);
>      if (!job_started(job)) {
> -        job_completed(job, -ECANCELED);
> +        job_completed(job);
>      } else if (job->deferred_to_main_loop) {
>          job_completed_txn_abort(job);
>      } else {
> diff --git a/trace-events b/trace-events
> index c445f54773..4fd2cb4b97 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -107,7 +107,7 @@ gdbstub_err_checksum_incorrect(uint8_t expected, ui=
nt8_t got) "got command packe
>  # job.c
>  job_state_transition(void *job,  int ret, const char *legal, const cha=
r *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%=
s)"
>  job_apply_verb(void *job, const char *state, const char *verb, const c=
har *legal) "job %p in state %s; applying verb %s (%s)"
> -job_completed(void *job, int ret, int jret) "job %p ret %d corrected r=
et %d"
> +job_completed(void *job, int ret) "job %p ret %d"
> =20
>  # job-qmp.c
>  qmp_job_cancel(void *job) "job %p"
>=20



--3k0YskHDDSurl6t4kROI0qTpK34hU8ePD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD1/wACgkQ9AfbAGHV
z0CABAf+OLieT4HfQCj2j/uuVVQSCeFVAhNh5J9lkkp0hrRSvNenBVi4Ll7LPRT6
z9FJWDvIRfE47gAPqAWbFZIknqAWOv7M4L3l3pRbfyXII1RbpvtA4O2AE7JviC3i
dsM4bw5DDsbkkDV5QIj6dqkgpgfZXlFKkhGMcyujKeatJ8URKywj81KBExZnAquo
eqF3pruurOxp/NOM/Y0R9w53I41KuyjHdCsyqvOyk7HaEcNI5v1lYbabV03Ssz5d
nWhVkBdeXGn1FgScbYtE56kxquE2rRkTjMTVuzoW+/gUNWprUkn6vsnanai4gukK
1eeL+YtkKPOvLASA9jW6LZBBhW8ayQ==
=n/NM
-----END PGP SIGNATURE-----

--3k0YskHDDSurl6t4kROI0qTpK34hU8ePD--
