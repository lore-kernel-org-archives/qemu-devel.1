Received: from eggs.gnu.org ([2001:4830:134:3::10]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIGdp-0002Ng-3l
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIGdn-0000Bl-Oc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:48:05 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-19-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f19b945b-16ea-e938-44e4-230975e8fd71@redhat.com>
Date: Mon, 14 May 2018 18:47:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-19-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1OwmWbpcwMrU9O4UijkfhIr4RJ8xWvVVZ"
Subject: Re: [Qemu-devel] [PATCH 18/42] job: Move coroutine and related code
 to Job
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
--1OwmWbpcwMrU9O4UijkfhIr4RJ8xWvVVZ
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <f19b945b-16ea-e938-44e4-230975e8fd71@redhat.com>
Subject: Re: [PATCH 18/42] job: Move coroutine and related code to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-19-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-19-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This commit moves some core functions for dealing with the job coroutin=
e
> from BlockJob to Job. This includes primarily entering the coroutine
> (both for the first and reentering) and yielding explicitly and at paus=
e
> points.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     |  40 ---------
>  include/block/blockjob_int.h |  26 ------
>  include/qemu/job.h           |  76 ++++++++++++++++
>  block/backup.c               |   2 +-
>  block/commit.c               |   4 +-
>  block/mirror.c               |  22 ++---
>  block/replication.c          |   2 +-
>  block/stream.c               |   4 +-
>  blockdev.c                   |   8 +-
>  blockjob.c                   | 201 +++++++----------------------------=
--------
>  job.c                        | 137 +++++++++++++++++++++++++++++
>  tests/test-bdrv-drain.c      |  38 ++++----
>  tests/test-blockjob-txn.c    |  12 +--
>  tests/test-blockjob.c        |  14 +--
>  14 files changed, 296 insertions(+), 290 deletions(-)

[...]

> diff --git a/job.c b/job.c
> index b074b3ffd7..b4cece1a82 100644
> --- a/job.c
> +++ b/job.c

[...]

> @@ -172,6 +205,110 @@ void job_unref(Job *job)
>      }
>  }
> =20
> +void job_enter_cond(Job *job, bool(*fn)(Job *job))
> +{
> +    if (!job_started(job)) {
> +        return;
> +    }
> +    if (job->deferred_to_main_loop) {
> +        return;
> +    }
> +
> +    job_lock();
> +    if (job->busy) {
> +        job_unlock();
> +        return;
> +    }
> +
> +    if (fn && !fn(job)) {
> +        job_unlock();
> +        return;
> +    }
> +
> +    assert(!job->deferred_to_main_loop);
> +    timer_del(&job->sleep_timer);
> +    job->busy =3D true;
> +    job_unlock();
> +    aio_co_wake(job->co);
> +}
> +
> +/* Yield, and schedule a timer to reenter the coroutine after @ns nano=
seconds.
> + * Reentering the job coroutine with block_job_enter() before the time=
r has

There is no job_enter() yet, but you do reference it below, so this
should probably be adjusted here...

> + * expired is allowed and cancels the timer.
> + *
> + * If @ns is (uint64_t) -1, no timer is scheduled and block_job_enter(=
) must be

=2E..and here.  Or maybe you want to change the job_enter below to a
block_job_enter until there is a job_enter().

With that done (or not, because I don't really care about mid-series
comments);

Reviewed-by: Max Reitz <mreitz@redhat.com>

> + * called explicitly. */
> +void coroutine_fn job_do_yield(Job *job, uint64_t ns)
> +{
> +    job_lock();
> +    if (ns !=3D -1) {
> +        timer_mod(&job->sleep_timer, ns);
> +    }
> +    job->busy =3D false;
> +    job_unlock();
> +    qemu_coroutine_yield();
> +
> +    /* Set by job_enter before re-entering the coroutine.  */
> +    assert(job->busy);
> +}


--1OwmWbpcwMrU9O4UijkfhIr4RJ8xWvVVZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5vbUACgkQ9AfbAGHV
z0D7fAgAtUeqRQfBmyMDT0vNqYCIWjTrb1Bb8gPjnTnHbb1D+SQ6No8dVRo+67x3
dxucy/uPha2KOXShLJ57SrMc9G6b/poRp7IBnD6mat5Y3Qu1h2wK0x0FMByCWwY0
xZbpylb7w1dTFnBFwNBGTsb/jLwsvNIY3dsQfZ2/1CtBkIX3rKVu0J4wp8HMIbUS
gDjz8E0JgQPW2lefOMLhEG6g3mrcpvqb/DZRjpT3Ye8tmc580Lg0snZmwj37vphI
L2EsI3ZP0rdR7ZrfxVAzwrbIXVluSjQO+zyEvYtRgNqcrLuMnaEpeSIWrQbjDuFz
NE5HrKrjx6DCOEBt92sAsXXJxr6MJA==
=eHsH
-----END PGP SIGNATURE-----

--1OwmWbpcwMrU9O4UijkfhIr4RJ8xWvVVZ--
