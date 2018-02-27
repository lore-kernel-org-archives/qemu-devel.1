Received: from eggs.gnu.org ([2001:4830:134:3::10]:35552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eql4v-0006hX-HH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eql4u-0007Qh-L5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:38:21 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-10-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9dc66db9-3d67-5eb3-7008-7dc4fd1f2482@redhat.com>
Date: Tue, 27 Feb 2018 13:38:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 09/21] blockjobs: add CONCLUDED state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> add a new state "CONCLUDED" that identifies a job that has ceased all
> operations. The wording was chosen to avoid any phrasing that might
> imply success, error, or cancellation. The task has simply ceased all
> operation and can never again perform any work.
> 
> ("finished", "done", and "completed" might all imply success.)
> 
> Transitions:
> Running  -> Concluded: normal completion
> Ready    -> Concluded: normal completion
> Aborting -> Concluded: error and cancellations
> 
> Verbs:
> None as of this commit. (a future commit adds 'dismiss')
> 


> @@ -620,7 +623,9 @@ void block_job_user_resume(BlockJob *job, Error **errp)
>   
>   void block_job_cancel(BlockJob *job)
>   {
> -    if (block_job_started(job)) {
> +    if (job->status == BLOCK_JOB_STATUS_CONCLUDED) {
> +        return;
> +    } else if (block_job_started(job)) {

It's also possible to do:

if () {
   return ;
}
if (...)

instead of chaining with an 'else if'.  Matter of personal taste, so I 
won't make you change it.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
