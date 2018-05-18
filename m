Received: from eggs.gnu.org ([2001:4830:134:3::10]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJgVO-0002gs-8H
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJgVH-0004VX-RW
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:37:14 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <658b36c1-f533-a1a3-12ab-bff15d864f62@redhat.com>
Date: Fri, 18 May 2018 09:36:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/40] job: Move state transitions to Job
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
> This moves BlockJob.status and the closely related functions
> (block_)job_state_transition() and (block_)job_apply_verb to Job. The
> two QAPI enums are renamed to JobStatus and JobVerb.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---

> @@ -1077,14 +1021,14 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
>       }
>   
>       if (block_job_should_pause(job) && !block_job_is_cancelled(job)) {
> -        BlockJobStatus status = job->status;
> -        block_job_state_transition(job, status == BLOCK_JOB_STATUS_READY ? \
> -                                   BLOCK_JOB_STATUS_STANDBY :           \
> -                                   BLOCK_JOB_STATUS_PAUSED);
> +        JobStatus status = job->job.status;
> +        job_state_transition(&job->job, status == JOB_STATUS_READY
> +                                        ? JOB_STATUS_STANDBY
> +                                        : JOB_STATUS_PAUSED);

Nice that you are getting rid of the pointless \.  Here, you split the 
?: operator by wrapping the ? onto the start of the next line...

> +++ b/job.c

> +int job_apply_verb(Job *job, JobVerb verb, Error **errp)
> +{
> +    assert(verb >= 0 && verb <= JOB_VERB__MAX);
> +    trace_job_apply_verb(job, JobStatus_str(job->status), JobVerb_str(verb),
> +                         JobVerbTable[verb][job->status] ?
> +                         "allowed" : "prohibited");

while here, you put it at the end of the previous line.  We have a 
slight preference for one style over the other (there are also false 
positives in both of these greps):

$ git grep '?$' | wc -c
27251
$ git grep '^ *?' | wc -c
9619

But I don't care which style you use, other than pointing out that a 
consistent style within the patch doesn't hurt. :)

So, whether or not you make a whitespace-only tweak to one of those two 
spots,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
