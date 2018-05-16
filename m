Received: from eggs.gnu.org ([2001:4830:134:3::10]:44742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ0tk-0001K4-No
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ0tj-0003jo-So
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:11:36 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-14-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff88f17e-098a-2a73-c73d-bbc38597eb44@redhat.com>
Date: Wed, 16 May 2018 13:11:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/42] job: Move state transitions to Job
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
> This moves BlockJob.status and the closely related functions
> (block_)job_state_transition() and (block_)job_apply_verb to Job. The
> two QAPI enums are renamed to JobStatus and JobVerb.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json     |  14 +++----
>   include/block/blockjob.h |   3 --
>   include/qemu/job.h       |  13 ++++++
>   blockjob.c               | 102 +++++++++++------------------------------------
>   job.c                    |  56 ++++++++++++++++++++++++++
>   tests/test-blockjob.c    |  39 +++++++++---------
>   block/trace-events       |   2 -
>   trace-events             |   4 ++
>   8 files changed, 122 insertions(+), 111 deletions(-)
> 

> @@ -90,4 +93,14 @@ Job *job_next(Job *job);
>    */
>   Job *job_get(const char *id);
>   
> +/**
> + * Check whether the verb @bv can be applied to @job in its current state.
> + * Returns 0 if the verb can be applied; otherwise errp is set and -EPERM
> + * returned.
> + */
> +int job_apply_verb(Job *job, JobVerb bv, Error **errp);

Why 'JobVerb bv' rather than 'jv' or 'verb'?

> @@ -968,7 +913,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>       job->refcnt        = 1;
>       job->auto_finalize = !(flags & BLOCK_JOB_MANUAL_FINALIZE);
>       job->auto_dismiss  = !(flags & BLOCK_JOB_MANUAL_DISMISS);
> -    block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);

No replacement to the counterpart job_state_transition() here because 
that should be handled in the parent class now, right? [1]

...

> +
> +int job_apply_verb(Job *job, JobVerb bv, Error **errp)

Again, the name bv made sense for BlockJobVerb, but less so now.

> @@ -81,6 +135,8 @@ void *job_create(const char *job_id, const JobDriver *driver, Error **errp)
>       job->driver        = driver;
>       job->id            = g_strdup(job_id);
>   
> +    job_state_transition(job, JOB_STATUS_CREATED);
> +

[1] Yes, just took me a while to get to it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
