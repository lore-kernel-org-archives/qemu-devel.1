Received: from eggs.gnu.org ([2001:4830:134:3::10]:60029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fnQjG-00047P-Rc
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fnQjF-0005Ku-OL
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:50:30 -0400
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-2-jsnow@redhat.com>
	<20180808145707.GB15410@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <3983d933-42c4-1786-5aec-1de76da3d68a@redhat.com>
Date: Wed, 8 Aug 2018 11:50:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180808145707.GB15410@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/21] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>



On 08/08/2018 10:57 AM, Kevin Wolf wrote:
> Am 07.08.2018 um 06:33 hat John Snow geschrieben:
>> Jobs presently use both an Error object in the case of the create job,
>> and char strings in the case of generic errors elsewhere.
>>
>> Unify the two paths as just j->err, and remove the extra argument from
>> job_completed.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> Hm, not sure. Overall, this feels like a step backwards.
> 
>> diff --git a/include/qemu/job.h b/include/qemu/job.h
>> index 18c9223e31..845ad00c03 100644
>> --- a/include/qemu/job.h
>> +++ b/include/qemu/job.h
>> @@ -124,12 +124,12 @@ typedef struct Job {
>>      /** Estimated progress_current value at the completion of the job */
>>      int64_t progress_total;
>>  
>> -    /** Error string for a failed job (NULL if, and only if, job->ret == 0) */
>> -    char *error;
>> -
>>      /** ret code passed to job_completed. */
>>      int ret;
>>  
>> +    /** Error object for a failed job **/
>> +    Error *err;
>> +
>>      /** The completion function that will be called when the job completes.  */
>>      BlockCompletionFunc *cb;
> 
> This is the change that I could agree with, though I don't think it
> makes a big difference: Whether you store the string immediately or an
> Error object from which you get the string later, doesn't really make a
> big difference.
> 
> Maybe we find more uses and having an Error object is common practice in
> QEMU, so no objections to this change.
> 
>> @@ -484,15 +484,13 @@ void job_transition_to_ready(Job *job);
>>  /**
>>   * @job: The job being completed.
>>   * @ret: The status code.
>> - * @error: The error message for a failing job (only with @ret < 0). If @ret is
>> - *         negative, but NULL is given for @error, strerror() is used.
>>   *
>>   * Marks @job as completed. If @ret is non-zero, the job transaction it is part
>>   * of is aborted. If @ret is zero, the job moves into the WAITING state. If it
>>   * is the last job to complete in its transaction, all jobs in the transaction
>>   * move from WAITING to PENDING.
>>   */
>> -void job_completed(Job *job, int ret, Error *error);
>> +void job_completed(Job *job, int ret);
> 
> I don't like this one, though.
> 
> Before this change, job_completed(..., NULL) was a clear sign that the
> error message probably needed an improvement, because an errno string
> doesn't usually describe error situations very well. We may not have a
> much better message in some cases, but in most cases we just don't pass
> one because an error message after job creation is still a quite new
> thing in the QAPI schema.
> 
> What we should get rid of in the long term is the int ret, not the Error
> *error. I suspect callers really just distinguish success/error without
> actually looking at the error code.
> 
> With this change applied, what's your new conversion plan for making
> sure that every failing caller of job_completed() has set job->error
> first?
> 

Getting rid of job_completed and moving to our fairly ubiquitous "ret &
Error *" combo.

>> @@ -666,8 +665,8 @@ static void job_update_rc(Job *job)
>>          job->ret = -ECANCELED;
>>      }
>>      if (job->ret) {
>> -        if (!job->error) {
>> -            job->error = g_strdup(strerror(-job->ret));
>> +        if (!job->err) {
>> +            error_setg_errno(&job->err, -job->ret, "job failed");
>>          }
>>          job_state_transition(job, JOB_STATUS_ABORTING);
>>      }
> 
> This hunk just makes the error message more verbose with a "job failed"
> prefix that doesn't add information. If it's the error string for a job,
> of course the job failed.
> 
> Kevin
> 

Yeah, it's not a good prefix, but if I wanted to use the error object in
a general way across all jobs, I needed _some_ kind of prefix there...
