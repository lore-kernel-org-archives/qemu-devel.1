Received: from eggs.gnu.org ([2001:4830:134:3::10]:39676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJiKC-0008Nb-Vy
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJiK7-0005Nf-5j
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:01:33 -0500
Date: Tue, 28 Nov 2017 11:00:59 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171128160059.GC25110@localhost.localdomain>
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128154350.21504-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/4] Revert "blockjob: do not
 allow coroutine double entry or entry-after-completion"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Tue, Nov 28, 2017 at 04:43:48PM +0100, Kevin Wolf wrote:
> This reverts commit 4afeffc8572f40d8844b946a30c00b10da4442b1.
> 
> This fixed the symptom of a bug rather than the root cause. Waking up a
> sleeping coroutine is generally fine, we just need to make it work
> correctly across AioContexts, which we'll do in a minute.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  include/block/blockjob_int.h | 3 +--
>  blockjob.c                   | 7 ++-----
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index 43f3be2965..f13ad05c0d 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -143,8 +143,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>   * @ns: How many nanoseconds to stop for.
>   *
>   * Put the job to sleep (assuming that it wasn't canceled) for @ns
> - * nanoseconds.  Canceling the job will not interrupt the wait, so the
> - * cancel will not process until the coroutine wakes up.
> + * nanoseconds.  Canceling the job will interrupt the wait immediately.
>   */
>  void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
>  
> diff --git a/blockjob.c b/blockjob.c
> index ff9a614531..3a0c49137e 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -797,14 +797,11 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
>          return;
>      }
>  
> -    /* We need to leave job->busy set here, because when we have
> -     * put a coroutine to 'sleep', we have scheduled it to run in
> -     * the future.  We cannot enter that same coroutine again before
> -     * it wakes and runs, otherwise we risk double-entry or entry after
> -     * completion. */
> +    job->busy = false;
>      if (!block_job_should_pause(job)) {
>          co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
>      }
> +    job->busy = true;
>  
>      block_job_pause_point(job);
>  }
> -- 
> 2.13.6
> 
