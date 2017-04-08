Received: from eggs.gnu.org ([2001:4830:134:3::10]:44731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwn4h-0006nn-O9
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwn4e-0002Yp-Md
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cwn4e-0002Xn-GF
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:54:28 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3672883F3E
	for <qemu-devel@nongnu.org>; Sat,  8 Apr 2017 09:54:27 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-9-pbonzini@redhat.com>
	<2f6e20ff-41e8-a931-7a86-abcfcc70d20f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26379979-4b58-4e86-cbc3-67dea734e2d9@redhat.com>
Date: Sat, 8 Apr 2017 17:54:22 +0800
MIME-Version: 1.0
In-Reply-To: <2f6e20ff-41e8-a931-7a86-abcfcc70d20f@redhat.com>
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
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>



On 08/04/2017 09:13, John Snow wrote:
> 
> 
> On 03/23/2017 01:39 PM, Paolo Bonzini wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> What was the bad design that required you to fix the previous test? :)

It was actually patch 9 that had the bug, I'll reorder to match the
commit message.

Paolo

>> ---
>>  blockjob.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/blockjob.c b/blockjob.c
>> index c9cb5b1..093962b 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -373,6 +373,12 @@ static void block_job_completed_single(BlockJob *job)
>>      block_job_unref(job);
>>  }
>>  
>> +static void block_job_cancel_async(BlockJob *job)
>> +{
>> +    job->cancelled = true;
>> +    block_job_iostatus_reset(job);
>> +}
>> +
>>  static void block_job_completed_txn_abort(BlockJob *job)
>>  {
>>      AioContext *ctx;
>> @@ -397,7 +403,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
>>               * them; this job, however, may or may not be cancelled, depending
>>               * on the caller, so leave it. */
>>              if (other_job != job) {
>> -                other_job->cancelled = true;
>> +                block_job_cancel_async(other_job);
> 
> Adds an ioreset here, which I think is probably fine...
> 
>>              }
>>              continue;
>>          }
>> @@ -489,8 +495,7 @@ void block_job_user_resume(BlockJob *job)
>>  void block_job_cancel(BlockJob *job)
>>  {
>>      if (block_job_started(job)) {
>> -        job->cancelled = true;
>> -        block_job_iostatus_reset(job);
>> +        block_job_cancel_async(job);
>>          block_job_enter(job);
>>      } else {
>>          block_job_completed(job, -ECANCELED);
>>
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
