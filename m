Received: from eggs.gnu.org ([2001:4830:134:3::10]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ3tX-0006el-JH
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ3tW-0004N6-MP
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:23:35 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-38-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a94c9b72-ea9b-11e1-30db-197cd5a4eb63@redhat.com>
Date: Wed, 16 May 2018 16:23:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-38-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 37/42] job: Move progress fields to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On 05/09/2018 11:26 AM, Kevin Wolf wrote:
> BlockJob has fields .offset and .len, which are actually misnomers today
> because they are no longer tied to block device sizes, but just progress
> counters. As such they make a lot of sense in generic Jobs.
> 
> This patch moves the fields to Job and renames them to .progress_current
> and .progress_total to describe their function better.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/include/qemu/job.h
> @@ -114,6 +114,16 @@ typedef struct Job {
>       /** True if this job should automatically dismiss itself */
>       bool auto_dismiss;
>   
> +    /**
> +     * Current progress. The unit is arbitrary as long as the ratio between
> +     * progress_current and progress_total represents the estimated percentage
> +     * of work already done.
> +     */
> +    int64_t progress_current;
> +
> +    /** Estimated progress_current value at the completion of the job */
> +    int64_t progress_total;
> +
>       /** ret code passed to block_job_completed. */
>       int ret;
>   
> @@ -304,6 +314,23 @@ void job_ref(Job *job);
>    */
>   void job_unref(Job *job);
>   
> +/**
> + * @job: The job that has made progress
> + * @done: How much progress the job made
> + *
> + * Updates the progress counter of the job.

Which progress counter? It might be worth calling out that this 
specifically updates the progress_current counter.  Also, it might be 
worth mentioning that the value is added to the current value of 
progress_counter, rather than directly assigned.

> + */
> +void job_progress_update(Job *job, uint64_t done);
> +
> +/**
> + * @job: The job whose expected progress end value is set
> + * @remaining: Expected end value of the progress counter of the job
> + *
> + * Sets the expected end value of the progress counter of a job so that a
> + * completion percentage can be calculated when the progress is updated.
> + */
> +void job_progress_set_remaining(Job *job, uint64_t remaining);

The name 'remaining' sounds like this is a delta (that progress_total is 
computed by summing the current progress_current + remaining) rather 
than directly the new value of progress_total.  Is that intended?

> +++ b/job.c
> @@ -364,6 +364,16 @@ void job_unref(Job *job)
>       }
>   }
>   
> +void job_progress_update(Job *job, uint64_t done)
> +{
> +    job->progress_current += done;
> +}
> +
> +void job_progress_set_remaining(Job *job, uint64_t remaining)
> +{
> +    job->progress_total = job->progress_current + remaining;

Okay, so implementation-wise, both functions ARE taking a delta, rather 
than directly assigning the internal field.  The delta can only be 
positive, but job->progress_total can still shrink over time as needed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
