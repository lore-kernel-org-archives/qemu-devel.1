Received: from eggs.gnu.org ([2001:4830:134:3::10]:45153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIFmK-0004bu-3e
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIFmI-0004rE-Ol
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:52:48 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-18-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <65bf7408-bdd9-6a7d-6c77-318715a4cc59@redhat.com>
Date: Mon, 14 May 2018 17:52:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-18-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QWdBPjzkYDz8hKtVuh2rAR6RGKiz2TheX"
Subject: Re: [Qemu-devel] [PATCH 17/42] job: Move defer_to_main_loop to Job
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
--QWdBPjzkYDz8hKtVuh2rAR6RGKiz2TheX
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <65bf7408-bdd9-6a7d-6c77-318715a4cc59@redhat.com>
Subject: Re: [PATCH 17/42] job: Move defer_to_main_loop to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-18-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-18-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     |  5 ----
>  include/block/blockjob_int.h | 19 ---------------
>  include/qemu/job.h           | 20 ++++++++++++++++
>  block/backup.c               |  7 +++---
>  block/commit.c               | 11 +++++----
>  block/mirror.c               | 15 ++++++------
>  block/stream.c               | 14 +++++------
>  blockjob.c                   | 57 ++++--------------------------------=
--------
>  job.c                        | 33 +++++++++++++++++++++++++
>  tests/test-bdrv-drain.c      |  7 +++---
>  tests/test-blockjob-txn.c    | 13 +++++-----
>  tests/test-blockjob.c        |  7 +++---
>  12 files changed, 98 insertions(+), 110 deletions(-)

[...]

> diff --git a/block/commit.c b/block/commit.c
> index 85baea8f92..d326766e4d 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -72,9 +72,10 @@ typedef struct {
>      int ret;
>  } CommitCompleteData;
> =20
> -static void commit_complete(BlockJob *job, void *opaque)
> +static void commit_complete(Job *job, void *opaque)
>  {
> -    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common);
> +    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.job=
);

Now this is just abuse.

=2E..but it's not the first time someone packs two container_of() into
one, it appears.  So, whatever, I guess.

> +    BlockJob *bjob =3D &s->common;
>      CommitCompleteData *data =3D opaque;
>      BlockDriverState *top =3D blk_bs(s->top);
>      BlockDriverState *base =3D blk_bs(s->base);

[...]

> diff --git a/blockjob.c b/blockjob.c
> index d44f5c2e50..6021d885be 100644
> --- a/blockjob.c
> +++ b/blockjob.c

[...]

> @@ -1159,50 +1159,3 @@ BlockErrorAction block_job_error_action(BlockJob=
 *job, BlockdevOnError on_err,
>      }
>      return action;
>  }
> -
> -typedef struct {
> -    BlockJob *job;
> -    AioContext *aio_context;
> -    BlockJobDeferToMainLoopFn *fn;
> -    void *opaque;
> -} BlockJobDeferToMainLoopData;
> -
> -static void block_job_defer_to_main_loop_bh(void *opaque)
> -{
> -    BlockJobDeferToMainLoopData *data =3D opaque;
> -    AioContext *aio_context;
> -
> -    /* Prevent race with block_job_defer_to_main_loop() */
> -    aio_context_acquire(data->aio_context);
> -
> -    /* Fetch BDS AioContext again, in case it has changed */
> -    aio_context =3D blk_get_aio_context(data->job->blk);
> -    if (aio_context !=3D data->aio_context) {
> -        aio_context_acquire(aio_context);
> -    }
> -
> -    data->fn(data->job, data->opaque);
> -
> -    if (aio_context !=3D data->aio_context) {
> -        aio_context_release(aio_context);
> -    }
> -
> -    aio_context_release(data->aio_context);
> -
> -    g_free(data);
> -}
> -
> -void block_job_defer_to_main_loop(BlockJob *job,
> -                                  BlockJobDeferToMainLoopFn *fn,
> -                                  void *opaque)
> -{
> -    BlockJobDeferToMainLoopData *data =3D g_malloc(sizeof(*data));
> -    data->job =3D job;
> -    data->aio_context =3D blk_get_aio_context(job->blk);
> -    data->fn =3D fn;
> -    data->opaque =3D opaque;
> -    job->deferred_to_main_loop =3D true;
> -
> -    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> -                            block_job_defer_to_main_loop_bh, data);
> -}
> diff --git a/job.c b/job.c
> index 6f97a4317e..b074b3ffd7 100644
> --- a/job.c
> +++ b/job.c
> @@ -28,6 +28,7 @@
>  #include "qapi/error.h"
>  #include "qemu/job.h"
>  #include "qemu/id.h"
> +#include "qemu/main-loop.h"
>  #include "trace-root.h"
> =20
>  static QLIST_HEAD(, Job) jobs =3D QLIST_HEAD_INITIALIZER(jobs);
> @@ -170,3 +171,35 @@ void job_unref(Job *job)
>          g_free(job);
>      }
>  }
> +
> +typedef struct {
> +    Job *job;
> +    JobDeferToMainLoopFn *fn;
> +    void *opaque;
> +} JobDeferToMainLoopData;
> +
> +static void job_defer_to_main_loop_bh(void *opaque)
> +{
> +    JobDeferToMainLoopData *data =3D opaque;
> +    Job *job =3D data->job;
> +    AioContext *aio_context =3D job->aio_context;
> +
> +    /* Prevent race with job_defer_to_main_loop() */
> +    aio_context_acquire(aio_context);

I don't have a good feeling about this.  The original code had this
comment above an aio_context_acquire() for a context that might
decidedly not have anything to do with the BB's context;
block_job_defer_to_main_loop()'s description was that it would acquire
the latter, so why did it acquire the former at all?

We wouldn't need this comment here at all, because acquiring this
AioContext is part of the interface.  That's why I don't have a good
feeling.

The best explanation I can come up with is that the original code
acquired the AioContext both of the block device at the time of the BH
(because that needs to be done), and at the time of
block_job_defer_to_main_loop() -- because the latter is probably the
context the block_job_defer_to_main_loop() call came from, so it should
be (b)locked.

But if that's the case, then the same should be done here.  The context
of the job may change between scheduling the BH and the BH being
executed, so we might lock a different context here than the one
job_defer_to_main_loop() ran in (i.e., job->aio_context at the time of
job_defer_to_main_loop() running).  And maybe we should lock that old
context, too -- just like block_job_defer_to_main_loop_bh() did.

Max

> +    data->fn(data->job, data->opaque);
> +    aio_context_release(aio_context);
> +
> +    g_free(data);
> +}
> +
> +void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *=
opaque)
> +{
> +    JobDeferToMainLoopData *data =3D g_malloc(sizeof(*data));
> +    data->job =3D job;
> +    data->fn =3D fn;
> +    data->opaque =3D opaque;
> +    job->deferred_to_main_loop =3D true;
> +
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                            job_defer_to_main_loop_bh, data);
> +}


--QWdBPjzkYDz8hKtVuh2rAR6RGKiz2TheX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5sMMACgkQ9AfbAGHV
z0CZHQf/TG7x3ie+u4UFS6vGYXvs73uZjaST4ZgaPUGsZlwEIGNuSQasHPOVo7ya
1A6VxFfgkj00dyF1w6N2QBbYxpqER7ibCEhqKJS7C0l+idMADqBYAt3NmvF8M6Z8
1xVtZeUkc5j1iLEFs7A3RHewwTm2DbM8UDakJwioVAnAXauW6R4K0LYkMrMAxrf/
a28WljQPTBs5CMdLncS8wf592QM29Z2jGG9Tpeo2pAGzh/SpoW2Ni17TCb/HSa8C
6jxbU4oCWi8Zf1w78YT/+PwVYwai3ClOPx3ugO/vhtj0L2esXDr54cVxm1qIRQeW
nrEu73XM1KKyAK3/aLoxN4j0Dig+0A==
=hqLE
-----END PGP SIGNATURE-----

--QWdBPjzkYDz8hKtVuh2rAR6RGKiz2TheX--
