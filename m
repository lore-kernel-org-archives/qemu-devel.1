Received: from eggs.gnu.org ([2001:4830:134:3::10]:37003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3TUu-0002BU-Jp
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d3TUr-0007mP-F4
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1d3TUr-0007kU-4k
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:25:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C036CA08F1
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 20:25:07 +0000 (UTC)
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-8-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e733d2b3-4c20-e9a4-4807-86675661f2cc@redhat.com>
Date: Wed, 26 Apr 2017 16:25:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170419144219.20371-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/11] blockjob: introduce
 block_job_cancel_async, check iostatus invariants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org



On 04/19/2017 10:42 AM, Paolo Bonzini wrote:
> The new functions helps respecting the invariant that the coroutine
> is entered with false user_resume, zero pause count and no error
> recorded in the iostatus.
> 
> Resetting the iostatus is now common to all of block_job_cancel_async,
> block_job_user_resume and block_job_iostatus_reset, albeit with slight
> differences:
> 
> - block_job_cancel_async resets the iostatus, and resumes the job if
> there was an error, but the coroutine is not restarted immediately.
> For example the caller may continue with a call to block_job_finish_sync.
> 
> - block_job_user_resume resets the iostatus.  It wants to resume the job
> unconditionally, even if there was no error.
> 
> - block_job_iostatus_reset doesn't resume the job at all.  Maybe that's
> a bug but it should be fixed separately.
> 
> block_job_iostatus_reset does the least common denominator, so add some
> checking but otherwise leave it as the entry point for resetting the
> iostatus.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: rewritten
> 
>  blockjob.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 5906266..1756153 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -304,6 +304,19 @@ static void block_job_completed_single(BlockJob *job)
>      block_job_unref(job);
>  }
>  
> +static void block_job_cancel_async(BlockJob *job)
> +{
> +    if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
> +        block_job_iostatus_reset(job);
> +    }
> +    if (job->user_paused) {
> +        /* Do not call block_job_enter here, the caller will handle it.  */
> +        job->user_paused = false;
> +        job->pause_count--;
> +    }
> +    job->cancelled = true;
> +}
> +
>  static void block_job_completed_txn_abort(BlockJob *job)
>  {
>      AioContext *ctx;
> @@ -328,7 +341,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
>               * them; this job, however, may or may not be cancelled, depending
>               * on the caller, so leave it. */
>              if (other_job != job) {
> -                other_job->cancelled = true;
> +                block_job_cancel_async(other_job);
>              }
>              continue;
>          }
> @@ -411,8 +424,8 @@ bool block_job_user_paused(BlockJob *job)
>  void block_job_user_resume(BlockJob *job)
>  {
>      if (job && job->user_paused && job->pause_count > 0) {
> -        job->user_paused = false;
>          block_job_iostatus_reset(job);
> +        job->user_paused = false;
>          block_job_resume(job);
>      }
>  }
> @@ -420,8 +433,7 @@ void block_job_user_resume(BlockJob *job)
>  void block_job_cancel(BlockJob *job)
>  {
>      if (block_job_started(job)) {
> -        job->cancelled = true;
> -        block_job_iostatus_reset(job);
> +        block_job_cancel_async(job);
>          block_job_enter(job);>      } else {
>          block_job_completed(job, -ECANCELED);
> @@ -765,6 +777,10 @@ void block_job_yield(BlockJob *job)
>  
>  void block_job_iostatus_reset(BlockJob *job)
>  {
> +    if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
> +        return;
> +    }
> +    assert(job->user_paused && job->pause_count > 0);

Why assert that it's user-paused? Will that be true from:

(A) All users of block_job_cancel_async, including:

- block_job_cancel
- block_job_completed
    block_job_completed_txn_abort

(B) all users of blk_iostatus_reset:
- blk_do_attach_dev
- qmp_cont

It's ... not really clear to me that this is true, can you help me out?

>      job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
>  }
>  
> 
