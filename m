Received: from eggs.gnu.org ([2001:4830:134:3::10]:48448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fpQ8s-0002zZ-NI
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fpQ8r-0004fh-Ph
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 23:37:10 -0400
Date: Mon, 13 Aug 2018 23:36:58 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180814033658.GA3254@localhost.localdomain>
References: <20180813022006.7216-1-mreitz@redhat.com>
	<20180813022006.7216-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813022006.7216-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/17] mirror: Make
 wait_for_any_operation() coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On Mon, Aug 13, 2018 at 04:19:51AM +0200, Max Reitz wrote:
> mirror_wait_for_any_operation() calls qemu_co_queue_wait(), which is a
> coroutine_fn (technically it is a macro which resolves to a
> coroutine_fn).  Therefore, this function needs to be a coroutine_fn as
> well.
> 
> This patch makes it and all of its callers coroutine_fns.
>

It'd be nice if someday coroutine_fn was actually functional during
compile.  We can dream :)

> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  block/mirror.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 85f5742eae..c28b6159d5 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -279,7 +279,8 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
>      return ret;
>  }
>  
> -static inline void mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
> +static inline void coroutine_fn
> +    mirror_co_wait_for_any_operation(MirrorBlockJob *s, bool active)
>  {
>      MirrorOp *op;
>  
> @@ -297,10 +298,11 @@ static inline void mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
>      abort();
>  }
>  
> -static inline void mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
> +static inline void coroutine_fn
> +    mirror_co_wait_for_free_in_flight_slot(MirrorBlockJob *s)
>  {
>      /* Only non-active operations use up in-flight slots */
> -    mirror_wait_for_any_operation(s, false);
> +    mirror_co_wait_for_any_operation(s, false);
>  }
>  
>  /* Perform a mirror copy operation.
> @@ -343,7 +345,7 @@ static void coroutine_fn mirror_co_read(void *opaque)
>  
>      while (s->buf_free_count < nb_chunks) {
>          trace_mirror_yield_in_flight(s, op->offset, s->in_flight);
> -        mirror_wait_for_free_in_flight_slot(s);
> +        mirror_co_wait_for_free_in_flight_slot(s);
>      }
>  
>      /* Now make a QEMUIOVector taking enough granularity-sized chunks
> @@ -549,7 +551,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>  
>          while (s->in_flight >= MAX_IN_FLIGHT) {
>              trace_mirror_yield_in_flight(s, offset, s->in_flight);
> -            mirror_wait_for_free_in_flight_slot(s);
> +            mirror_co_wait_for_free_in_flight_slot(s);
>          }
>  
>          if (s->ret < 0) {
> @@ -600,10 +602,10 @@ static void mirror_free_init(MirrorBlockJob *s)
>   * mirror_resume() because mirror_run() will begin iterating again
>   * when the job is resumed.
>   */
> -static void mirror_wait_for_all_io(MirrorBlockJob *s)
> +static void coroutine_fn mirror_co_wait_for_all_io(MirrorBlockJob *s)
>  {
>      while (s->in_flight > 0) {
> -        mirror_wait_for_free_in_flight_slot(s);
> +        mirror_co_wait_for_free_in_flight_slot(s);
>      }
>  }
>  
> @@ -762,7 +764,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>              if (s->in_flight >= MAX_IN_FLIGHT) {
>                  trace_mirror_yield(s, UINT64_MAX, s->buf_free_count,
>                                     s->in_flight);
> -                mirror_wait_for_free_in_flight_slot(s);
> +                mirror_co_wait_for_free_in_flight_slot(s);
>                  continue;
>              }
>  
> @@ -770,7 +772,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>              offset += bytes;
>          }
>  
> -        mirror_wait_for_all_io(s);
> +        mirror_co_wait_for_all_io(s);
>          s->initial_zeroing_ongoing = false;
>      }
>  
> @@ -916,7 +918,7 @@ static void coroutine_fn mirror_run(void *opaque)
>          /* Do not start passive operations while there are active
>           * writes in progress */
>          while (s->in_active_write_counter) {
> -            mirror_wait_for_any_operation(s, true);
> +            mirror_co_wait_for_any_operation(s, true);
>          }
>  
>          if (s->ret < 0) {
> @@ -942,7 +944,7 @@ static void coroutine_fn mirror_run(void *opaque)
>              if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
>                  (cnt == 0 && s->in_flight > 0)) {
>                  trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight);
> -                mirror_wait_for_free_in_flight_slot(s);
> +                mirror_co_wait_for_free_in_flight_slot(s);
>                  continue;
>              } else if (cnt != 0) {
>                  delay_ns = mirror_iteration(s);
> @@ -1028,7 +1030,7 @@ immediate_exit:
>          assert(ret < 0 || ((s->common.job.force_cancel || !s->synced) &&
>                 job_is_cancelled(&s->common.job)));
>          assert(need_drain);
> -        mirror_wait_for_all_io(s);
> +        mirror_co_wait_for_all_io(s);
>      }
>  
>      assert(s->in_flight == 0);
> @@ -1098,11 +1100,11 @@ static void mirror_complete(Job *job, Error **errp)
>      job_enter(job);
>  }
>  
> -static void mirror_pause(Job *job)
> +static void coroutine_fn mirror_pause(Job *job)
>  {
>      MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
>  
> -    mirror_wait_for_all_io(s);
> +    mirror_co_wait_for_all_io(s);
>  }
>  
>  static bool mirror_drained_poll(BlockJob *job)
> -- 
> 2.17.1
> 
