Received: from eggs.gnu.org ([2001:4830:134:3::10]:45706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGoT-0007ZT-8s
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGoS-0004Fo-9f
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:46:57 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-9-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1981b40b-40c2-4378-35a5-02cc20361370@redhat.com>
Date: Sat, 12 May 2018 00:46:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3dj0MQAtyNQwHXCuq4CIyJZaPgtDiGPQJ"
Subject: Re: [Qemu-devel] [PATCH 08/42] job: Create Job,
 JobDriver and job_create()
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
--3dj0MQAtyNQwHXCuq4CIyJZaPgtDiGPQJ
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <1981b40b-40c2-4378-35a5-02cc20361370@redhat.com>
Subject: Re: [PATCH 08/42] job: Create Job, JobDriver and job_create()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-9-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This is the first step towards creating an infrastructure for generic
> background jobs that aren't tied to a block device. For now, Job only
> stores its ID and JobDriver, the rest stays in BlockJob.
>=20
> The following patches will move over more parts of BlockJob to Job if
> they are meaningful outside the context of a block job.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     |  9 +++----
>  include/block/blockjob_int.h |  4 +--
>  include/qemu/job.h           | 60 ++++++++++++++++++++++++++++++++++++=
++++++++
>  block/backup.c               |  4 ++-
>  block/commit.c               |  4 ++-
>  block/mirror.c               | 10 +++++---
>  block/stream.c               |  4 ++-
>  blockjob.c                   | 46 ++++++++++++++++-----------------
>  job.c                        | 48 +++++++++++++++++++++++++++++++++++
>  tests/test-bdrv-drain.c      |  4 ++-
>  tests/test-blockjob-txn.c    |  4 ++-
>  tests/test-blockjob.c        | 12 ++++++---
>  MAINTAINERS                  |  2 ++
>  Makefile.objs                |  2 +-
>  14 files changed, 169 insertions(+), 44 deletions(-)
>  create mode 100644 include/qemu/job.h
>  create mode 100644 job.c
>=20
> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
> index 0b57d53084..8acc1a236a 100644
> --- a/include/block/blockjob.h
> +++ b/include/block/blockjob.h

[...]

> @@ -40,6 +41,9 @@ typedef struct BlockJobTxn BlockJobTxn;
>   * Long-running operation on a BlockDriverState.
>   */
>  typedef struct BlockJob {
> +    /** Data belonging to the generic Job infrastructure */
> +    Job job;
> +
>      /** The job type, including the job vtable.  */
>      const BlockJobDriver *driver;

Any reason why you keep this field around?  Shouldn't it be just
DO_UPCAST(const BlockJobDriver, job_driver, job.driver)?

> =20
> @@ -47,11 +51,6 @@ typedef struct BlockJob {
>      BlockBackend *blk;
> =20
>      /**
> -     * The ID of the block job. May be NULL for internal jobs.
> -     */
> -    char *id;
> -
> -    /**
>       * The coroutine that executes the job.  If not NULL, it is
>       * reentered when busy is false and the job is cancelled.
>       */

[...]

> diff --git a/blockjob.c b/blockjob.c
> index 9943218a34..35d604d05a 100644
> --- a/blockjob.c
> +++ b/blockjob.c

[...]

> @@ -247,7 +247,7 @@ void block_job_unref(BlockJob *job)
>                                          block_job_detach_aio_context, =
job);
>          blk_unref(job->blk);
>          error_free(job->blocker);
> -        g_free(job->id);
> +        g_free(job->job.id);

Err.  OK.  I put my faith in patch 11.

Reviewed-by: Max Reitz <mreitz@redhat.com>

Although I do wonder about BlockJob.driver.  It seems to stay even after
this series...

>          assert(!timer_pending(&job->sleep_timer));
>          g_free(job);
>      }

[...]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 459e3594e1..a97f60d104 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1369,6 +1369,8 @@ L: qemu-block@nongnu.org

(Cut off here:

M: Jeff Cody <jcody@redhat.com>

Clever!)

>  S: Supported
>  F: blockjob.c
>  F: include/block/blockjob.h
> +F: job.c
> +F: include/block/job.h
>  F: block/backup.c
>  F: block/commit.c
>  F: block/stream.c


--3dj0MQAtyNQwHXCuq4CIyJZaPgtDiGPQJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2HVYACgkQ9AfbAGHV
z0Cz2Qf9HpRLNocmVzQ8DtICHRQMjv93Z1YJ5Y7VTPK+YFh8vBOj/yHpIGrKy2Cc
GsrkEIZtYWzTjNcMQYylRK3qPQ0zFkG2h1kqgHL5qlcMRSqrvO8C+nF6RQQtaBeS
QPLZ1ka+Rc61w6dPN5b9DTkljeMAO76QPlvNqJQg6CEmg1p83wMTqYCzlj+AoNrm
pQq6LKT6WUW/3iDRUnyerIsWkbeISRQwjZlYI/CMMRcIhNbBw9k1DJQuCzL4Xf0J
28YbhlCmet9o9azS7Dc3t4djEDTTfFRkH4Oadq/w5CI7NAbj+ZXEolzJ5vyjIX6C
80o7RqRgEluJlrf+r+LS22cVQFB8Ig==
=GGFK
-----END PGP SIGNATURE-----

--3dj0MQAtyNQwHXCuq4CIyJZaPgtDiGPQJ--
