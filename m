Received: from eggs.gnu.org ([2001:4830:134:3::10]:60050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eOY7e-000138-4t
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 19:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eOY7d-0006io-69
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 19:08:34 -0500
Date: Mon, 11 Dec 2017 19:08:24 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171212000824.GE20604@localhost.localdomain>
References: <20171211234609.30497-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211234609.30497-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockjob: kick jobs on set-speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Mon, Dec 11, 2017 at 06:46:09PM -0500, John Snow wrote:
> If users set an unreasonably low speed (like one byte per second), the
> calculated delay may exceed many hours. While we like to punish users
> for asking for stupid things, we do also like to allow users to correct
> their wicked ways.
> 
> When a user provides a new speed, kick the job to allow it to recalculate
> its delay.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockjob.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 715c2c2680..43f01ad190 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -483,6 +483,7 @@ static void block_job_completed_txn_success(BlockJob *job)
>  void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>  {
>      Error *local_err = NULL;
> +    int64_t old_speed = job->speed;
>  
>      if (!job->driver->set_speed) {
>          error_setg(errp, QERR_UNSUPPORTED);
> @@ -495,6 +496,10 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>      }
>  
>      job->speed = speed;
> +    /* Kick the job to recompute its delay */
> +    if ((speed > old_speed) && timer_pending(&job->sleep_timer)) {

job->sleep_timer is protected by block_job_mutex (via
block_job_lock/unlock); is it safe for us to check it here outside the
mutex?

But in any case, I think we could get rid of the timer_pending check, and
just always kick the job if we have a speed increase.  block_job_enter()
should do the right thing (mutex protected check on job->busy and
job->sleep_timer).

> +        block_job_enter(job);
> +    }
>  }
>  
>  void block_job_complete(BlockJob *job, Error **errp)
> -- 
> 2.14.3
> 
