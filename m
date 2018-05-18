Received: from eggs.gnu.org ([2001:4830:134:3::10]:44299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJjg8-000859-2F
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJjg7-0001WR-CE
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:00:32 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-21-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd921788-cb74-c646-1edb-123b0359082f@redhat.com>
Date: Fri, 18 May 2018 13:00:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-21-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/40] job: Move single job finalisation
 to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On 05/18/2018 08:20 AM, Kevin Wolf wrote:
> This moves the finalisation of a single job from BlockJob to Job.
> 
> Some part of this code depends on job transactions, and job transactions
> call this code, we introduce some temporary calls from Job functions to
> BlockJob ones. This will be fixed once transactions move to Job, too.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/job.c

> @@ -449,6 +451,100 @@ void job_user_resume(Job *job, Error **errp)
>       job_resume(job);
>   }
>   
> +void job_do_dismiss(Job *job)
> +{
> +    assert(job);
> +    job->busy = false;
> +    job->paused = false;
> +    job->deferred_to_main_loop = true;
> +
> +    /* TODO Don't assume it's a BlockJob */
> +    block_job_txn_del_job((BlockJob*) job);

checkpatch flagged this for style, but it goes away later in the series. 
But more than just style, this hard-codes the assumption that BlockJob 
has a Job member at offset 0.  So would it be better to use 
container_of() instead of a bare cast, even though it is transient?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
