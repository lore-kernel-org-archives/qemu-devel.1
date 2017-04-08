Received: from eggs.gnu.org ([2001:4830:134:3::10]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwewA-0001Vz-Er
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 21:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwew7-0001P0-B3
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 21:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cwew7-0001Os-4j
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 21:13:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D19FB61D15
	for <qemu-devel@nongnu.org>; Sat,  8 Apr 2017 01:13:05 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-9-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2f6e20ff-41e8-a931-7a86-abcfcc70d20f@redhat.com>
Date: Fri, 7 Apr 2017 21:13:04 -0400
MIME-Version: 1.0
In-Reply-To: <20170323173928.14439-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/10] blockjob: introduce
 block_job_cancel_async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>



On 03/23/2017 01:39 PM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

What was the bad design that required you to fix the previous test? :)

> ---
>  blockjob.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index c9cb5b1..093962b 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -373,6 +373,12 @@ static void block_job_completed_single(BlockJob *job)
>      block_job_unref(job);
>  }
>  
> +static void block_job_cancel_async(BlockJob *job)
> +{
> +    job->cancelled = true;
> +    block_job_iostatus_reset(job);
> +}
> +
>  static void block_job_completed_txn_abort(BlockJob *job)
>  {
>      AioContext *ctx;
> @@ -397,7 +403,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
>               * them; this job, however, may or may not be cancelled, depending
>               * on the caller, so leave it. */
>              if (other_job != job) {
> -                other_job->cancelled = true;
> +                block_job_cancel_async(other_job);

Adds an ioreset here, which I think is probably fine...

>              }
>              continue;
>          }
> @@ -489,8 +495,7 @@ void block_job_user_resume(BlockJob *job)
>  void block_job_cancel(BlockJob *job)
>  {
>      if (block_job_started(job)) {
> -        job->cancelled = true;
> -        block_job_iostatus_reset(job);
> +        block_job_cancel_async(job);
>          block_job_enter(job);
>      } else {
>          block_job_completed(job, -ECANCELED);
> 

Reviewed-by: John Snow <jsnow@redhat.com>
