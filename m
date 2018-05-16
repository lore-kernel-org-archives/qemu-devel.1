Received: from eggs.gnu.org ([2001:4830:134:3::10]:38501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ0m5-0006vm-Tx
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ0m5-0007xX-2Q
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:03:41 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-13-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3b46cc1-0c70-8df2-c37a-e8da1a07c5bd@redhat.com>
Date: Wed, 16 May 2018 13:03:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-13-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/42] job: Maintain a list of all jobs
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
> This moves the job list from BlockJob to Job. Now we can check for
> duplicate IDs in job_create().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/blockjob.h |  3 ---
>   include/qemu/job.h       | 19 +++++++++++++++++++
>   blockjob.c               | 47 +++++++++++++++++++++++++----------------------
>   job.c                    | 31 +++++++++++++++++++++++++++++++
>   4 files changed, 75 insertions(+), 25 deletions(-)

> @@ -71,4 +75,19 @@ JobType job_type(Job *job);
>   /** Returns the enum string for the JobType of a given Job. */
>   const char *job_type_str(Job *job);
>   
> +/**
> + * Get the next element from the list of block jobs after @job, or the
> + * first one if @job is %NULL.
> + *
> + * Returns the requested job, or %NULL if there are no more jobs left.
> + */
> +Job *job_next(Job *job);

The new code is supposed to allow you to prime the search by passing in 
NULL.  This looks similar to the semantics originally held by 
block_job_next(), where


> -BlockJob *block_job_next(BlockJob *job)
> +static bool is_block_job(Job *job)
>   {
> -    if (!job) {
> -        return QLIST_FIRST(&block_jobs);
> -    }

the old code did so by special-casing an incoming NULL.

> -    return QLIST_NEXT(job, job_list);
> +    return job_type(job) == JOB_TYPE_BACKUP ||
> +           job_type(job) == JOB_TYPE_COMMIT ||
> +           job_type(job) == JOB_TYPE_MIRROR ||
> +           job_type(job) == JOB_TYPE_STREAM;
> +}
> +
> +BlockJob *block_job_next(BlockJob *bjob)
> +{
> +    Job *job = &bjob->job;

But the new code blindly dereferences what may be a NULL bjob.  Taking 
the address of a member of the NULL pointer may happen to work if that 
member is at offset 0, but is also likely to trigger compiler or 
sanitizer warnings; and does not work if the member is not at offset 0.

I think all you have to do is:

Job *job = bjob ? &bjob->job : NULL;

> +
> +    do {
> +        job = job_next(job);
> +    } while (job && !is_block_job(job));
> +
> +
> +    return job ? container_of(job, BlockJob, job) : NULL;

Why two blank lines?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
