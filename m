Received: from eggs.gnu.org ([2001:4830:134:3::10]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvRzA-0008HN-D8
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvRmD-0000hU-Ge
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:34:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvRmD-0000h2-Bh
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:34:41 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-3-git-send-email-Liam.Merwick@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83875cdc-3238-fafa-7c96-21d1df89b37a@redhat.com>
Date: Thu, 30 Aug 2018 13:34:39 -0500
MIME-Version: 1.0
In-Reply-To: <1535644031-848-3-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] job: Fix off-by-one accesses to JobSTT
 and JobVerbTable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org

On 08/30/2018 10:47 AM, Liam Merwick wrote:
> In the array dereference of JobVerbTable[verb] in job_apply_verb()
> the check of the index, verb, allows an overrun because an index
> equal to the array size is permitted.
> 
> Similarly, in the array dereference of JobSTT[s0][s1] with index s1
> in job_state_transition(), an off-by-one overrun is possible.

Fortunately, these are just assertions that are too weak; we don't have 
any actual callers passing the __MAX entry to cause an actual overrun.

> 
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> ---
>   job.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/job.c b/job.c
> index e36ebaafd81c..40320566f43b 100644
> --- a/job.c
> +++ b/job.c
> @@ -166,7 +166,7 @@ bool job_is_internal(Job *job)
>   static void job_state_transition(Job *job, JobStatus s1)
>   {
>       JobStatus s0 = job->status;
> -    assert(s1 >= 0 && s1 <= JOB_STATUS__MAX);
> +    assert(s1 >= 0 && s1 < JOB_STATUS__MAX);
>       trace_job_state_transition(job, job->ret,
>                                  JobSTT[s0][s1] ? "allowed" : "disallowed",
>                                  JobStatus_str(s0), JobStatus_str(s1));
> @@ -181,7 +181,7 @@ static void job_state_transition(Job *job, JobStatus s1)
>   int job_apply_verb(Job *job, JobVerb verb, Error **errp)
>   {
>       JobStatus s0 = job->status;
> -    assert(verb >= 0 && verb <= JOB_VERB__MAX);
> +    assert(verb >= 0 && verb < JOB_VERB__MAX);
>       trace_job_apply_verb(job, JobStatus_str(s0), JobVerb_str(verb),
>                            JobVerbTable[verb][s0] ? "allowed" : "prohibited");
>       if (JobVerbTable[verb][s0]) {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
