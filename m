Received: from eggs.gnu.org ([2001:4830:134:3::10]:56592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwdqz-00036G-Pj
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwdqu-0003B8-O1
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:03:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cwdqu-00039V-Fu
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:03:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10F9DC04B937
	for <qemu-devel@nongnu.org>; Sat,  8 Apr 2017 00:03:37 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-6-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <48253fa9-d5eb-f750-6dfc-e478bfd85277@redhat.com>
Date: Fri, 7 Apr 2017 20:03:36 -0400
MIME-Version: 1.0
In-Reply-To: <20170323173928.14439-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/10] blockjob: separate monitor and
 blockjob APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 03/23/2017 01:39 PM, Paolo Bonzini wrote:
> We already have different locking policies for APIs called by the monit=
or
> and the block job.  Monitor APIs need consistency across block_job_get
> and the actual operation (e.g. block_job_set_speed), so currently there
> are explicit aio_context_acquire/release calls in blockdev.c.
>=20
> When a block job needs to do something instead it doesn't care about lo=
cking,
> because the whole coroutine runs under the AioContext lock.  When movin=
g
> away from the AioContext lock, the monitor will have to call new
> block_job_lock/unlock APIs, while blockjob APIs will take care of this
> for the users.
>=20
> In preparation for that, keep all the blockjob APIs together in the
> blockjob.c file.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 206 +++++++++++++++++++++++++++++++----------------------=
--------

Did you guys order... like, fifty million pizzas?

Hooray for
$ diff -u <(sed -n 's/^-//p' patch) <(sed -n 's/^\+//p' patch)

Looks clean, though it may be useful to do a few more things;

- Demarcate what you think is the monitor API in this file
- Organize blockjob.h to match to serve as a useful reference.

>  1 file changed, 105 insertions(+), 101 deletions(-)
>=20
> diff --git a/blockjob.c b/blockjob.c
> index caca718..c5f1d19 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -334,11 +334,6 @@ void block_job_start(BlockJob *job)
>      qemu_coroutine_enter(job->co);
>  }
> =20
> -void block_job_fail(BlockJob *job)
> -{
> -    block_job_unref(job);
> -}
> -
>  static void block_job_completed_single(BlockJob *job)
>  {
>      if (!job->ret) {
> @@ -440,21 +435,6 @@ static void block_job_completed_txn_success(BlockJ=
ob *job)
>      }
>  }
> =20
> -void block_job_completed(BlockJob *job, int ret)
> -{
> -    assert(blk_bs(job->blk)->job =3D=3D job);
> -    assert(!job->completed);
> -    job->completed =3D true;
> -    job->ret =3D ret;
> -    if (!job->txn) {
> -        block_job_completed_single(job);
> -    } else if (ret < 0 || block_job_is_cancelled(job)) {
> -        block_job_completed_txn_abort(job);
> -    } else {
> -        block_job_completed_txn_success(job);
> -    }
> -}
> -
>  void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>  {
>      Error *local_err =3D NULL;
> @@ -492,44 +472,11 @@ void block_job_user_pause(BlockJob *job)
>      block_job_pause(job);
>  }
> =20
> -static bool block_job_should_pause(BlockJob *job)
> -{
> -    return job->pause_count > 0;
> -}
> -
>  bool block_job_user_paused(BlockJob *job)
>  {
>      return job->user_paused;
>  }
> =20
> -void coroutine_fn block_job_pause_point(BlockJob *job)
> -{
> -    assert(job && block_job_started(job));
> -
> -    if (!block_job_should_pause(job)) {
> -        return;
> -    }
> -    if (block_job_is_cancelled(job)) {
> -        return;
> -    }
> -
> -    if (job->driver->pause) {
> -        job->driver->pause(job);
> -    }
> -
> -    if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
> -        job->paused =3D true;
> -        job->busy =3D false;
> -        qemu_coroutine_yield(); /* wait for block_job_resume() */
> -        job->busy =3D true;
> -        job->paused =3D false;
> -    }
> -
> -    if (job->driver->resume) {
> -        job->driver->resume(job);
> -    }
> -}
> -
>  void block_job_user_resume(BlockJob *job)
>  {
>      if (job && job->user_paused && job->pause_count > 0) {
> @@ -538,13 +485,6 @@ void block_job_user_resume(BlockJob *job)
>      }
>  }
> =20
> -void block_job_enter(BlockJob *job)
> -{
> -    if (job->co && !job->busy) {
> -        qemu_coroutine_enter(job->co);
> -    }
> -}
> -
>  void block_job_cancel(BlockJob *job)
>  {
>      if (block_job_started(job)) {
> @@ -556,11 +496,6 @@ void block_job_cancel(BlockJob *job)
>      }
>  }
> =20
> -bool block_job_is_cancelled(BlockJob *job)
> -{
> -    return job->cancelled;
> -}
> -
>  void block_job_iostatus_reset(BlockJob *job)
>  {
>      job->iostatus =3D BLOCK_DEVICE_IO_STATUS_OK;
> @@ -628,42 +563,6 @@ int block_job_complete_sync(BlockJob *job, Error *=
*errp)
>      return block_job_finish_sync(job, &block_job_complete, errp);
>  }
> =20
> -void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
> -{
> -    assert(job->busy);
> -
> -    /* Check cancellation *before* setting busy =3D false, too!  */
> -    if (block_job_is_cancelled(job)) {
> -        return;
> -    }
> -
> -    job->busy =3D false;
> -    if (!block_job_should_pause(job)) {
> -        co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
> -    }
> -    job->busy =3D true;
> -
> -    block_job_pause_point(job);
> -}
> -
> -void block_job_yield(BlockJob *job)
> -{
> -    assert(job->busy);
> -
> -    /* Check cancellation *before* setting busy =3D false, too!  */
> -    if (block_job_is_cancelled(job)) {
> -        return;
> -    }
> -
> -    job->busy =3D false;
> -    if (!block_job_should_pause(job)) {
> -        qemu_coroutine_yield();
> -    }
> -    job->busy =3D true;
> -
> -    block_job_pause_point(job);
> -}
> -
>  BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
>  {
>      BlockJobInfo *info;
> @@ -723,6 +622,10 @@ static void block_job_event_completed(BlockJob *jo=
b, const char *msg)
>                                          &error_abort);
>  }
> =20
> +/*
> + * API for block job drivers and the block layer.
> + */
> +
>  void block_job_pause_all(void)
>  {
>      BlockJob *job =3D NULL;
> @@ -735,6 +638,59 @@ void block_job_pause_all(void)
>      }
>  }
> =20
> +void block_job_fail(BlockJob *job)
> +{
> +    block_job_unref(job);
> +}
> +
> +void block_job_completed(BlockJob *job, int ret)
> +{
> +    assert(blk_bs(job->blk)->job =3D=3D job);
> +    assert(!job->completed);
> +    job->completed =3D true;
> +    job->ret =3D ret;
> +    if (!job->txn) {
> +        block_job_completed_single(job);
> +    } else if (ret < 0 || block_job_is_cancelled(job)) {
> +        block_job_completed_txn_abort(job);
> +    } else {
> +        block_job_completed_txn_success(job);
> +    }
> +}
> +
> +static bool block_job_should_pause(BlockJob *job)
> +{
> +    return job->pause_count > 0;
> +}
> +
> +void coroutine_fn block_job_pause_point(BlockJob *job)
> +{
> +    assert(job && block_job_started(job));
> +
> +    if (!block_job_should_pause(job)) {
> +        return;
> +    }
> +    if (block_job_is_cancelled(job)) {
> +        return;
> +    }
> +
> +    if (job->driver->pause) {
> +        job->driver->pause(job);
> +    }
> +
> +    if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
> +        job->paused =3D true;
> +        job->busy =3D false;
> +        qemu_coroutine_yield(); /* wait for block_job_resume() */
> +        job->busy =3D true;
> +        job->paused =3D false;
> +    }
> +
> +    if (job->driver->resume) {
> +        job->driver->resume(job);
> +    }
> +}
> +
>  void block_job_resume_all(void)
>  {
>      BlockJob *job =3D NULL;
> @@ -747,6 +703,54 @@ void block_job_resume_all(void)
>      }
>  }
> =20
> +void block_job_enter(BlockJob *job)
> +{
> +    if (job->co && !job->busy) {
> +        qemu_coroutine_enter(job->co);
> +    }
> +}
> +
> +bool block_job_is_cancelled(BlockJob *job)
> +{
> +    return job->cancelled;
> +}
> +
> +void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
> +{
> +    assert(job->busy);
> +
> +    /* Check cancellation *before* setting busy =3D false, too!  */
> +    if (block_job_is_cancelled(job)) {
> +        return;
> +    }
> +
> +    job->busy =3D false;
> +    if (!block_job_should_pause(job)) {
> +        co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
> +    }
> +    job->busy =3D true;
> +
> +    block_job_pause_point(job);
> +}
> +
> +void block_job_yield(BlockJob *job)
> +{
> +    assert(job->busy);
> +
> +    /* Check cancellation *before* setting busy =3D false, too!  */
> +    if (block_job_is_cancelled(job)) {
> +        return;
> +    }
> +
> +    job->busy =3D false;
> +    if (!block_job_should_pause(job)) {
> +        qemu_coroutine_yield();
> +    }
> +    job->busy =3D true;
> +
> +    block_job_pause_point(job);
> +}
> +
>  void block_job_event_ready(BlockJob *job)
>  {
>      job->ready =3D true;
>=20

--=20
=97js
