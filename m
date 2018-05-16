Received: from eggs.gnu.org ([2001:4830:134:3::10]:50129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ1JG-0005Xb-Tq
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ1JG-000364-5k
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:37:58 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-18-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb5728b5-cfec-ceff-b471-8af6e8b96979@redhat.com>
Date: Wed, 16 May 2018 13:37:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-18-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On 05/09/2018 11:26 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Rather sparse on the commit message, given the other comments in this 
thread.

> +++ b/include/qemu/job.h
> @@ -58,6 +58,9 @@ typedef struct Job {
>        */
>       bool cancelled;
>   
> +    /** Set to true when the job has deferred work to the main loop. */
> +    bool deferred_to_main_loop;
> +
>       /** Element of the list of jobs */
>       QLIST_ENTRY(Job) job_list;
>   } Job;
> @@ -131,6 +134,23 @@ Job *job_get(const char *id);
>    */
>   int job_apply_verb(Job *job, JobVerb bv, Error **errp);
>   
> +typedef void JobDeferToMainLoopFn(Job *job, void *opaque);
> +
> +/**
> + * @job: The job
> + * @fn: The function to run in the main loop
> + * @opaque: The opaque value that is passed to @fn
> + *
> + * This function must be called by the main job coroutine just before it
> + * returns.  @fn is executed in the main loop with the job AioContext acquired.
> + *
> + * Block jobs must call bdrv_unref(), bdrv_close(), and anything that uses
> + * bdrv_drain_all() in the main loop.

Do we still want this block-job-specific comment in the main job.h header?

> + *
> + * The @job AioContext is held while @fn executes.
> + */
> +void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque);
> +


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
