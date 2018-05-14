Received: from eggs.gnu.org ([2001:4830:134:3::10]:44011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKvv-0004lm-Kz
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKvu-00070j-MH
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:23:03 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-37-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0133dc3a-ee5c-dd27-df06-9b8f35c0737a@redhat.com>
Date: Mon, 14 May 2018 23:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-37-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1ixGo0oS1lSGwXpa6wqVO4cwAjIZadEXR"
Subject: Re: [Qemu-devel] [PATCH 36/42] job: Add job_transition_to_ready()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1ixGo0oS1lSGwXpa6wqVO4cwAjIZadEXR
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <0133dc3a-ee5c-dd27-df06-9b8f35c0737a@redhat.com>
Subject: Re: [PATCH 36/42] job: Add job_transition_to_ready()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-37-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-37-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> The transition to the READY state was still performed in the BlockJob
> layer, in the same function that sent the BLOCK_JOB_READY QMP event.
>=20
> This patch brings the state transition to the Job layer and implements
> the QMP event using a notifier called from the Job layer, like we
> already do for other events related to state transitions.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     |  3 +++
>  include/block/blockjob_int.h |  8 --------
>  include/qemu/job.h           |  9 ++++++---
>  block/mirror.c               |  6 +++---
>  blockjob.c                   | 36 +++++++++++++++++++-----------------=

>  job.c                        | 16 +++++++++++++---
>  tests/test-bdrv-drain.c      |  2 +-
>  tests/test-blockjob.c        |  2 +-
>  8 files changed, 46 insertions(+), 36 deletions(-)

[...]

> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index fb81cc7c09..20b48926d9 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h

[...]

> @@ -522,7 +528,4 @@ void job_defer_to_main_loop(Job *job, JobDeferToMai=
nLoopFn *fn, void *opaque);
>   */
>  int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Err=
or **errp);
> =20
> -/* TODO To be removed from the public interface */
> -void job_state_transition(Job *job, JobStatus s1);
> -

\o/

>  #endif

[...]

> diff --git a/blockjob.c b/blockjob.c
> index 0512b41901..27f3199a20 100644
> --- a/blockjob.c
> +++ b/blockjob.c

[...]

> @@ -387,13 +403,14 @@ void *block_job_create(const char *job_id, const =
BlockJobDriver *driver,
>      job->finalize_cancelled_notifier.notify =3D block_job_event_cancel=
led;
>      job->finalize_completed_notifier.notify =3D block_job_event_comple=
ted;
>      job->pending_notifier.notify =3D block_job_event_pending;
> +    job->ready_notifier.notify =3D block_job_event_ready;
> =20
>      notifier_list_add(&job->job.on_finalize_cancelled,
>                        &job->finalize_cancelled_notifier);
>      notifier_list_add(&job->job.on_finalize_completed,
>                        &job->finalize_completed_notifier);
> -    notifier_list_add(&job->job.on_pending,
> -                      &job->pending_notifier);
> +    notifier_list_add(&job->job.on_pending, &job->pending_notifier);

Do you want to move this to the patch that introduced this line?

If you do:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    notifier_list_add(&job->job.on_ready, &job->ready_notifier);
> =20
>      error_setg(&job->blocker, "block device is in use by block job: %s=
",
>                 job_type_str(&job->job));


--1ixGo0oS1lSGwXpa6wqVO4cwAjIZadEXR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5/iwACgkQ9AfbAGHV
z0AFlQf+L3HecFTqcEWPZ+ILihmU8Oamc8wMAsJqs8Ei/oW2y8IDYxF5aXqJpskf
Lgx/ygS1WfjyT89yaAuat181kJy34jsl2EywGoEuiFzSYmV5JJdU9tLq0EBxLVBr
cuNm4f9ehsA29M/qJv11fymGEMN+3KOF5laNH3+sopA3D3nx5CmkpmLvcLQqcOOd
UmKl0GNdLDgb9iLisyDA/DL+r3BKb5sSBgwrcjLnw/V97MXA+e4Mou52QYWtqeK+
Xr3T3YdiIM+9YIFp/vY7cBS4lyMmnfnxyxBncVWczOdMYZDc7iaG3d+VWEGMnIWY
uJTlJ2RD+B9gqUkhFMTTril2xpM3gQ==
=r3ka
-----END PGP SIGNATURE-----

--1ixGo0oS1lSGwXpa6wqVO4cwAjIZadEXR--
