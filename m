Received: from eggs.gnu.org ([2001:4830:134:3::10]:50886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvlGa-0003VL-OW
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvlGZ-000162-SE
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:23:20 -0400
References: <20180830015734.19765-1-jsnow@redhat.com>
	<20180830015734.19765-3-jsnow@redhat.com>
	<6ed2e7ac-8de1-bd7b-0787-fdd33c6b306e@redhat.com>
	<87mut3ukyi.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <126a3e52-7706-d6dc-fb7a-bda8e11d9791@redhat.com>
Date: Fri, 31 Aug 2018 11:23:03 -0400
MIME-Version: 1.0
In-Reply-To: <87mut3ukyi.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/9] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>



On 08/31/2018 02:08 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 08/29/2018 08:57 PM, John Snow wrote:
>>> Jobs presently use both an Error object in the case of the create job,
>>> and char strings in the case of generic errors elsewhere.
>>>
>>> Unify the two paths as just j->err, and remove the extra argument from
>>> job_completed. The integer error code for job_completed is kept for now,
>>> to be removed shortly in a separate patch.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>
>>> +++ b/job.c
>>
>>> @@ -666,8 +666,8 @@ static void job_update_rc(Job *job)
>>>           job->ret = -ECANCELED;
>>>       }
>>>       if (job->ret) {
>>> -        if (!job->error) {
>>> -            job->error = g_strdup(strerror(-job->ret));
>>> +        if (!job->err) {
>>> +            error_setg(&job->err, "%s", g_strdup(strerror(-job->ret)));
>>
>> Memleak. Drop the g_strdup(), and just directly pass strerror()
>> results to error_setg().  (I guess we can't quite use
>> error_setg_errno() unless we add additional text beyond the strerror()
>> results).
> 
> Adding such text might well be an improvement.  I'm not telling you to
> do so (not having looked at the context myself), just to think about it.
> 

In this case, and I agree with Kevin who suggested it; we ought to be
moving away from the retcode in general and using first-class error
objects for all of our jobs anyway.

In this case, the job has failed with a retcode and we wish to give the
user some hope of understanding why, but at this point in the code all
we know is what the strerror can tell us, so a generic prefix like "The
job failed" is not helpful because it will already be clear by events
and other things that the job failed.

The only text I can think of that would be useful is: "The job failed
and didn't give a more specific error message. Please email
qemu-devel@nongnu.org and harass the authors until they fix it. Anyway,
nice chatting to you, the generic error message is: %s"

--js

>> With that fixed,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
