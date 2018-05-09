Received: from eggs.gnu.org ([2001:4830:134:3::10]:39894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGStf-0006zO-C0
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGSte-0006Js-GI
	for qemu-devel@nongnu.org; Wed, 09 May 2018 13:28:59 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39a5a1c0-c87c-5fae-8471-95f4c6767299@redhat.com>
Date: Wed, 9 May 2018 12:28:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/42] blockjob: Fix assertion in
 block_job_finalize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On 05/09/2018 11:25 AM, Kevin Wolf wrote:
> Every job gets a non-NULL job->txn on creation, but it doesn't
> necessarily keep it until it is decommissioned: Finalising a job removes
> it from its transaction. Therefore, calling 'blockdev-job-finalize' a
> second time on an already concluded job causes an assertion failure.
> 
> Remove job->txn from the assertion in block_job_finalize() to fix this.
> block_job_do_finalize() still has the same assertion, but if a job is
> already removed from its transaction, block_job_apply_verb() will
> already error out before we run into that assertion.

CC: qemu-stable@nongnu.org

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   blockjob.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/blockjob.c b/blockjob.c
> index 4de48166b2..b38ed7e265 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -702,7 +702,7 @@ void block_job_complete(BlockJob *job, Error **errp)
>   
>   void block_job_finalize(BlockJob *job, Error **errp)
>   {
> -    assert(job && job->id && job->txn);
> +    assert(job && job->id);
>       if (block_job_apply_verb(job, BLOCK_JOB_VERB_FINALIZE, errp)) {
>           return;
>       }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
