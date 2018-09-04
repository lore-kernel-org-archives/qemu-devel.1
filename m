Received: from eggs.gnu.org ([2001:4830:134:3::10]:60901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxDtT-00005g-MW
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 12:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxDtS-0001z1-Kw
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 12:09:31 -0400
References: <20180830015734.19765-1-jsnow@redhat.com>
	<20180830015734.19765-3-jsnow@redhat.com>
	<6ed2e7ac-8de1-bd7b-0787-fdd33c6b306e@redhat.com>
	<87mut3ukyi.fsf@dusky.pond.sub.org>
	<126a3e52-7706-d6dc-fb7a-bda8e11d9791@redhat.com>
	<87sh2tirfk.fsf@dusky.pond.sub.org>
	<20180903122232.GA14463@dhcp-200-186.str.redhat.com>
	<87sh2q4qnq.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <00f1f443-8425-56fa-543e-753868e8b697@redhat.com>
Date: Tue, 4 Sep 2018 12:09:20 -0400
MIME-Version: 1.0
In-Reply-To: <87sh2q4qnq.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>



On 09/03/2018 10:11 AM, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
>> Am 01.09.2018 um 09:54 hat Markus Armbruster geschrieben:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> On 08/31/2018 02:08 AM, Markus Armbruster wrote:
>>>>> Eric Blake <eblake@redhat.com> writes:
>>>>>
>>>>>> On 08/29/2018 08:57 PM, John Snow wrote:
>>>>>>> Jobs presently use both an Error object in the case of the create job,
>>>>>>> and char strings in the case of generic errors elsewhere.
>>>>>>>
>>>>>>> Unify the two paths as just j->err, and remove the extra argument from
>>>>>>> job_completed. The integer error code for job_completed is kept for now,
>>>>>>> to be removed shortly in a separate patch.
>>>>>>>
>>>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>>>> ---
>>>>>>
>>>>>>> +++ b/job.c
>>>>>>
>>>>>>> @@ -666,8 +666,8 @@ static void job_update_rc(Job *job)
>>>>>>>           job->ret = -ECANCELED;
>>>>>>>       }
>>>>>>>       if (job->ret) {
>>>>>>> -        if (!job->error) {
>>>>>>> -            job->error = g_strdup(strerror(-job->ret));
>>>>>>> +        if (!job->err) {
>>>>>>> +            error_setg(&job->err, "%s", g_strdup(strerror(-job->ret)));
>>>>>>
>>>>>> Memleak. Drop the g_strdup(), and just directly pass strerror()
>>>>>> results to error_setg().  (I guess we can't quite use
>>>>>> error_setg_errno() unless we add additional text beyond the strerror()
>>>>>> results).
>>>>>
>>>>> Adding such text might well be an improvement.  I'm not telling you to
>>>>> do so (not having looked at the context myself), just to think about it.
>>>>>
>>>>
>>>> In this case, and I agree with Kevin who suggested it; we ought to be
>>>> moving away from the retcode in general and using first-class error
>>>> objects for all of our jobs anyway.
>>>>
>>>> In this case, the job has failed with a retcode and we wish to give the
>>>> user some hope of understanding why, but at this point in the code all
>>>> we know is what the strerror can tell us, so a generic prefix like "The
>>>> job failed" is not helpful because it will already be clear by events
>>>> and other things that the job failed.
>>>>
>>>> The only text I can think of that would be useful is: "The job failed
>>>> and didn't give a more specific error message. Please email
>>>> qemu-devel@nongnu.org and harass the authors until they fix it. Anyway,
>>>> nice chatting to you, the generic error message is: %s"
>>>
>>> That might well be an improvement ;)
>>>
>>> Since I don't have a realistic example ready, I'm making up a contrieved
>>> one:
>>>
>>> --> {"execute": "job-frobnicate"}
>>> <-- {"error": {"class": "GenericError", "desc": "Device or resource busy"}}
>>>
>>> Would a reply
>>>
>>> <-- {"error": {"class": "GenericError", "desc": "Job failed: Device or resource busy"}}
>>>
>>> be better, worse, or a wash?
>>>
>>> If it's a wash, maintainability breaks the tie.  So let's have a look at
>>> the code.  It's either
>>>
>>>             error_setg(&job->err, "%s", strerror(-job->ret));
>>>
>>> or
>>>
>>>             error_setg_errno(&job->err, -job->ret, "Job failed");
>>>
>>> I'd prefer the latter, because it's the common way to put an errno code
>>> into an Error object, and it lets me grep for the message more easily.
>>
>> Basically, if I call "job-frobnicate", I don't want an error message to
>> tell me "job-frobnicate failed: foo". I already know that I called
>> "job-frobnicate", so the actually useful message is only "foo".
>>
>> A prefix like "job-frobnicate failed" should be added when it's one of
>> multiple possible error sources. For example, if a higher level monitor
>> command internally involves job-frobnicate, but also three other
>> operations, this is the place where the prefix should be added to any
>> error message returned by job-frobnicate so that we can distinguish
>> which part of the operation failed.
> 
> John's point is that the error message is bad no matter what.
> 
> My point is that if it's bad no matter what, we can just as well emit it
> the usual way, with error_setg_errno(), rather than playing games with
> strerror().
> 

Not worth it, in my opinion. This way keeps visible behavior consistent
until we fully eradicate the retcode.

--js
