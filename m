Received: from eggs.gnu.org ([2001:4830:134:3::10]:52301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xOK-0002y4-UD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xOG-00058T-Q5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:10:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1g9xOG-00056e-Hj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:09:56 -0400
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-3-git-send-email-Liam.Merwick@oracle.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d41127d0-e296-eaf8-9818-b1f28e8c95d1@redhat.com>
Date: Tue, 9 Oct 2018 15:09:53 -0400
MIME-Version: 1.0
In-Reply-To: <1535739372-24454-3-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/8] job: Fix off-by-one assert checks
 for JobSTT and JobVerbTable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org



On 08/31/2018 02:16 PM, Liam Merwick wrote:
> In the assert checking the array dereference of JobVerbTable[verb]
> in job_apply_verb() the check of the index, verb, allows an overrun
> because an index equal to the array size is permitted.
> 
> Similarly, in the assert check of JobSTT[s0][s1] with index s1
> in job_state_transition(), an off-by-one overrun is not flagged
> either.
> 

Oops.

> This is not a run-time issue as there are no callers actually
> passing in the max value.
> 

Good.

> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  job.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/job.c b/job.c
> index e36ebaafd81c..40320566f43b 100644
> --- a/job.c
> +++ b/job.c
> @@ -166,7 +166,7 @@ bool job_is_internal(Job *job)
>  static void job_state_transition(Job *job, JobStatus s1)
>  {
>      JobStatus s0 = job->status;
> -    assert(s1 >= 0 && s1 <= JOB_STATUS__MAX);
> +    assert(s1 >= 0 && s1 < JOB_STATUS__MAX);
>      trace_job_state_transition(job, job->ret,
>                                 JobSTT[s0][s1] ? "allowed" : "disallowed",
>                                 JobStatus_str(s0), JobStatus_str(s1));
> @@ -181,7 +181,7 @@ static void job_state_transition(Job *job, JobStatus s1)
>  int job_apply_verb(Job *job, JobVerb verb, Error **errp)
>  {
>      JobStatus s0 = job->status;
> -    assert(verb >= 0 && verb <= JOB_VERB__MAX);
> +    assert(verb >= 0 && verb < JOB_VERB__MAX);
>      trace_job_apply_verb(job, JobStatus_str(s0), JobVerb_str(verb),
>                           JobVerbTable[verb][s0] ? "allowed" : "prohibited");
>      if (JobVerbTable[verb][s0]) {
> 
