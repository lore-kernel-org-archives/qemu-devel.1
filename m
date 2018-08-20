Received: from eggs.gnu.org ([2001:4830:134:3::10]:44534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frox7-0000NT-J5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frovA-0000OV-I4
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:28:59 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <154f228d-9a04-5fef-f703-e41f6b75ba86@redhat.com>
Date: Mon, 20 Aug 2018 13:28:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180817190457.8292-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] jobs: change start callback to run
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>

On 08/17/2018 02:04 PM, John Snow wrote:
> Presently we codify the entry point for a job as the "start" callback,
> but a more apt name would be "run" to clarify the idea that when this
> function returns we consider the job to have "finished," except for
> any cleanup which occurs in separate callbacks later.
> 
> As part of this clarification, change the signature to include an error
> object and a return code. The error ptr is not yet used, and the return
> code while captured, will be overwritten by actions in the job_completed
> function.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> +++ b/block/backup.c
> @@ -480,9 +480,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>       bdrv_dirty_iter_free(dbi);
>   }
>   
> -static void coroutine_fn backup_run(void *opaque)
> +static int coroutine_fn backup_run(Job *opaque_job, Error **errp)
>   {
> -    BackupBlockJob *job = opaque;
> +    BackupBlockJob *job = container_of(opaque_job, BackupBlockJob, common.job);

Hmm. Here, you used the naming pair 'opaque_job' vs. 'job',...

> +++ b/block/commit.c
> @@ -134,9 +134,9 @@ static void commit_complete(Job *job, void *opaque)
>       bdrv_unref(top);
>   }
>   
> -static void coroutine_fn commit_run(void *opaque)
> +static int coroutine_fn commit_run(Job *job, Error **errp)
>   {
> -    CommitBlockJob *s = opaque;
> +    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);

while in the majority of the other clients, it was 'job' vs. 's'. Is it 
worth making these names consistent, or is that too much bikeshed paint?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
