Received: from eggs.gnu.org ([2001:4830:134:3::10]:44018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eK2CT-0006bs-Ab
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eK2CS-0000MI-3A
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:14:53 -0500
Date: Wed, 29 Nov 2017 08:14:43 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171129131443.GK25110@localhost.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] blockjob: remove clock argument from
 block_job_sleep_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com


On Wed, Nov 29, 2017 at 11:25:11AM +0100, Paolo Bonzini wrote:
> All callers are using QEMU_CLOCK_REALTIME, and it will not be possible to
> support more than one clock when block_job_sleep_ns switches to a single
> timer stored in the BlockJob struct.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>


> ---
>  block/backup.c               | 4 ++--
>  block/commit.c               | 2 +-
>  block/mirror.c               | 6 +++---
>  block/stream.c               | 2 +-
>  blockjob.c                   | 5 +++--
>  include/block/blockjob_int.h | 7 +++----
>  tests/test-blockjob-txn.c    | 2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 06ddbfd03d..99e6bcc748 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -346,9 +346,9 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
>          uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
>                                                        job->bytes_read);
>          job->bytes_read = 0;
> -        block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, delay_ns);
> +        block_job_sleep_ns(&job->common, delay_ns);
>      } else {
> -        block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, 0);
> +        block_job_sleep_ns(&job->common, 0);
>      }
>  
>      if (block_job_is_cancelled(&job->common)) {
> diff --git a/block/commit.c b/block/commit.c
> index 5036eec434..c5327551ce 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -174,7 +174,7 @@ static void coroutine_fn commit_run(void *opaque)
>          /* Note that even when no rate limit is applied we need to yield
>           * with no pending I/O here so that bdrv_drain_all() returns.
>           */
> -        block_job_sleep_ns(&s->common, QEMU_CLOCK_REALTIME, delay_ns);
> +        block_job_sleep_ns(&s->common, delay_ns);
>          if (block_job_is_cancelled(&s->common)) {
>              break;
>          }
> diff --git a/block/mirror.c b/block/mirror.c
> index 307b6391a8..c9badc1203 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -598,7 +598,7 @@ static void mirror_throttle(MirrorBlockJob *s)
>  
>      if (now - s->last_pause_ns > SLICE_TIME) {
>          s->last_pause_ns = now;
> -        block_job_sleep_ns(&s->common, QEMU_CLOCK_REALTIME, 0);
> +        block_job_sleep_ns(&s->common, 0);
>      } else {
>          block_job_pause_point(&s->common);
>      }
> @@ -870,13 +870,13 @@ static void coroutine_fn mirror_run(void *opaque)
>          ret = 0;
>          trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
>          if (!s->synced) {
> -            block_job_sleep_ns(&s->common, QEMU_CLOCK_REALTIME, delay_ns);
> +            block_job_sleep_ns(&s->common, delay_ns);
>              if (block_job_is_cancelled(&s->common)) {
>                  break;
>              }
>          } else if (!should_complete) {
>              delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
> -            block_job_sleep_ns(&s->common, QEMU_CLOCK_REALTIME, delay_ns);
> +            block_job_sleep_ns(&s->common, delay_ns);
>          }
>          s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      }
> diff --git a/block/stream.c b/block/stream.c
> index e6f72346e5..499cdacdb0 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -141,7 +141,7 @@ static void coroutine_fn stream_run(void *opaque)
>          /* Note that even when no rate limit is applied we need to yield
>           * with no pending I/O here so that bdrv_drain_all() returns.
>           */
> -        block_job_sleep_ns(&s->common, QEMU_CLOCK_REALTIME, delay_ns);
> +        block_job_sleep_ns(&s->common, delay_ns);
>          if (block_job_is_cancelled(&s->common)) {
>              break;
>          }
> diff --git a/blockjob.c b/blockjob.c
> index 2f0cc1528b..db9e4fc89a 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -788,7 +788,7 @@ bool block_job_is_cancelled(BlockJob *job)
>      return job->cancelled;
>  }
>  
> -void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
> +void block_job_sleep_ns(BlockJob *job, int64_t ns)
>  {
>      assert(job->busy);
>  
> @@ -803,7 +803,8 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
>       * it wakes and runs, otherwise we risk double-entry or entry after
>       * completion. */
>      if (!block_job_should_pause(job)) {
> -        co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
> +        co_aio_sleep_ns(blk_get_aio_context(job->blk),
> +                        QEMU_CLOCK_REALTIME, ns);
>      }
>  
>      block_job_pause_point(job);
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index 43f3be2965..f7ab183a39 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -139,14 +139,13 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>  /**
>   * block_job_sleep_ns:
>   * @job: The job that calls the function.
> - * @clock: The clock to sleep on.
>   * @ns: How many nanoseconds to stop for.
>   *
>   * Put the job to sleep (assuming that it wasn't canceled) for @ns
> - * nanoseconds.  Canceling the job will not interrupt the wait, so the
> - * cancel will not process until the coroutine wakes up.
> + * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will not interrupt
> + * the wait, so the cancel will not process until the coroutine wakes up.
>   */
> -void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
> +void block_job_sleep_ns(BlockJob *job, int64_t ns);
>  
>  /**
>   * block_job_yield:
> diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
> index c77343fc04..3591c9617f 100644
> --- a/tests/test-blockjob-txn.c
> +++ b/tests/test-blockjob-txn.c
> @@ -44,7 +44,7 @@ static void coroutine_fn test_block_job_run(void *opaque)
>  
>      while (s->iterations--) {
>          if (s->use_timer) {
> -            block_job_sleep_ns(job, QEMU_CLOCK_REALTIME, 0);
> +            block_job_sleep_ns(job, 0);
>          } else {
>              block_job_yield(job);
>          }
> -- 
> 2.14.3
> 
> 
