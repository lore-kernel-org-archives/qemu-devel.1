Received: from eggs.gnu.org ([2001:4830:134:3::10]:36771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eWU1y-0007xR-4y
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eWU1x-0001Vb-4I
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:23:30 -0500
Date: Tue, 2 Jan 2018 16:23:14 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180102212314.GB26116@localhost.localdomain>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214005953.8898-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] blockjob: create block_job_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

On Wed, Dec 13, 2017 at 07:59:49PM -0500, John Snow wrote:
> This will replace mirror_throttle, for reuse in other jobs.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c               | 15 ++-------------
>  blockjob.c                   | 11 +++++++++++
>  include/block/blockjob_int.h |  9 +++++++++
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index eef5b598f5..60b52cfb19 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -590,17 +590,6 @@ static void mirror_exit(BlockJob *job, void *opaque)
>      bdrv_unref(src);
>  }
>  
> -static void mirror_throttle(MirrorBlockJob *s)
> -{
> -    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> -
> -    if (now - s->common.last_yield_ns > SLICE_TIME) {
> -        block_job_sleep_ns(&s->common, 0);
> -    } else {
> -        block_job_pause_point(&s->common);
> -    }
> -}
> -
>  static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>  {
>      int64_t offset;
> @@ -621,7 +610,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>              int bytes = MIN(s->bdev_length - offset,
>                              QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
>  
> -            mirror_throttle(s);
> +            block_job_throttle(&s->common);
>  
>              if (block_job_is_cancelled(&s->common)) {
>                  s->initial_zeroing_ongoing = false;
> @@ -649,7 +638,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>          int bytes = MIN(s->bdev_length - offset,
>                          QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
>  
> -        mirror_throttle(s);
> +        block_job_throttle(&s->common);
>  
>          if (block_job_is_cancelled(&s->common)) {
>              return 0;
> diff --git a/blockjob.c b/blockjob.c
> index 8cbc142f57..8d0c89a813 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -882,6 +882,17 @@ void block_job_yield(BlockJob *job)
>      block_job_pause_point(job);
>  }
>  
> +void block_job_throttle(BlockJob *job)
> +{
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> +
> +    if (now - job->last_yield_ns > SLICE_TIME) {
> +        block_job_sleep_ns(job, 0);
> +    } else {
> +        block_job_pause_point(job);
> +    }
> +}
> +
>  void block_job_iostatus_reset(BlockJob *job)
>  {
>      if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index 209fa1bb3e..1a771b1e2e 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -157,6 +157,15 @@ void block_job_sleep_ns(BlockJob *job, int64_t ns);
>   */
>  void block_job_yield(BlockJob *job);
>  
> +/**
> + * block_job_throttle:
> + * @job: The job that calls the function.
> + *
> + * Yield if it has been SLICE_TIME nanoseconds since the last yield.
> + * Otherwise, check if we need to pause (and update the yield counter).
> + */
> +void block_job_throttle(BlockJob *job);
> +
>  /**
>   * block_job_pause_all:
>   *
> -- 
> 2.14.3
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
