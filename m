Received: from eggs.gnu.org ([2001:4830:134:3::10]:40633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dSLxw-0002lH-BW
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dSLxs-00011P-88
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:26:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dSLxr-00010j-Ut
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:25:56 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v64BODqf104003
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 07:25:53 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bg78nn53h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 07:25:53 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 4 Jul 2017 12:25:50 +0100
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-2-pasic@linux.vnet.ibm.com>
	<20170607095127.GB2099@work-vm>
	<8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
	<f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
	<00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
	<2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
	<c28ab7f2-4541-4657-0387-b988e8040e3f@redhat.com>
	<7fdfeb7c-050b-1cf4-e22a-fa242da99ad9@linux.vnet.ibm.com>
	<87d19hk4q1.fsf@dusky.pond.sub.org>
	<a6f580f0-ed90-4860-231e-84612a14202f@linux.vnet.ibm.com>
	<87van8aej0.fsf@dusky.pond.sub.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 4 Jul 2017 13:25:47 +0200
MIME-Version: 1.0
In-Reply-To: <87van8aej0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <dae51f0a-121d-1394-64c0-bbf32ae0e1db@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed
 equal checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cohuck@kernel.org>



On 07/04/2017 08:42 AM, Markus Armbruster wrote:
> Halil Pasic <pasic@linux.vnet.ibm.com> writes:
> 
>> On 07/03/2017 03:52 PM, Markus Armbruster wrote:
>>> Halil Pasic <pasic@linux.vnet.ibm.com> writes:
>>>
>>>> On 06/30/2017 04:54 PM, Eric Blake wrote:
>>>>> On 06/30/2017 09:41 AM, Halil Pasic wrote:
[..]
>>> If we have errors that can't be adequately explained in a single error
>>> message, we may need a way to add more explanation.  error_append_hint()
>>> isn't.
>>>
>>
>> Was not aware. Using hint in this very situation was suggested by Connie,
>> and I assumed she is long enough with the project to know...
>>
>> In fact looking at  include/qapi/error.h:
>> """
>> /*
>>  * Error reporting system loosely patterned after Glib's GError.
>>  *
>>  * Create an error:
>>  *     error_setg(&err, "situation normal, all fouled up");
>>  *
>>  * Create an error and add additional explanation:
>>  *     error_setg(&err, "invalid quark");
>>  *     error_append_hint(&err, "Valid quarks are up, down, strange, "
>>  *                       "charm, top, bottom.\n");
>>  *
>>  * Do *not* contract this to
>>  *     error_setg(&err, "invalid quark\n"
>>  *                "Valid quarks are up, down, strange, charm, top, bottom.");
>> """
>>
>> my understanding was and is still the exact opposite of what you say:
>> error_append_hint is for adding more explanation.
>>
>> Furthermore 
>> """
>> /*
>>  * Append a printf-style human-readable explanation to an existing error.
>>  * @errp may be NULL, but not &error_fatal or &error_abort.
>>  * Trivially the case if you call it only after error_setg() or
>>  * error_propagate().
>>  * May be called multiple times.  The resulting hint should end with a
>>  * newline.
>>  */
>> void error_append_hint(Error **errp, const char *fmt, ...)
>> """
>>
>> Assuming that error_append_hint() isn't for adding more explanation,
>> IMHO the doc does not adequately explain what it is for.
> 
> You're right, it doesn't.
> 
>> I have also failed to find any hint in qapi/error.h which is AFAIU
>> documenting the error api about this human-readable explanation
>> appended to an existing error by error_append_hint() is to be discarded
>> if the error is reported in QMP context.
>>
>> Am I reading the api doc incorrectly, or did the documentation and
>> de-facto api diverge (behavior)?
> 
> I added documentation after I inherited this subsystem, in response to
> recurring questions on proper use of the interface.  I failed to fully
> capture the hint feature's intent.  I'll post a patch.
> 

Hey, IMHO error.h is one of the better documented corners of the QEMU
code base. If you like put me on cc for this promised patch.

>>>>>>> If something absolutely must be reported, then it is not a hint, and
>>>>>>> shouldn't be using the hint mechanism.
>>>
>>> Exactly.
>>>
>>
>> Perfectly fine with me provided the apidoc tells me clearly what the hint is
>> for, and what it is not for.
>>
>>>>>> I find it hard to formulate criteria for 'must be reported'. I'm afraid
>>>>>> this is backwards logic: since the hint may not be reported everything
>>>>>> that needs to be reported is not a hint. This is a valid approach of
>>>>>> course, but then I think some modifications to the comments in error.h
>>>>>> would not hurt. And maybe something with verbose would be more
>>>>>> expressive name.
>>>>>>
>>>>>> I hope all this makes some sense and ain't pure waste of time...
>>>>>
>>>>> No, it never hurts to question whether the design is optimal, and it's
>>>>> better to question first to know whether it is even worth patching
>>>>> things to behave differently, rather than spending time patching it only
>>>>> to have a maintainer clarify that the patch can't be accepted because of
>>>>> some design constraint.  So I still hope Markus will chime in.
>>>>>
>>>>
>>>> For this patch I went with Dave's proposal so I have no acute interest
>>>> in changing this.
>>>>
>>>> Conceptually, for me it really boils down to the question: Is it reasonable
>>>> to assume that we are interested in what went wrong (error message)?
>>>>
>>>> If yes, we are good as is. If no, we should not drop hint in QMP context.
>>>>
>>>> Thanks for your time. I think we provided Markus with enough input to
>>>> make his call :).
>>>
>>> I had a quick peek at the patch that triggered this discussion.  What
>>> problem are you trying to solve?  According to your cover letter, it's
>>> "to specify a hint for the case a vmstate equal assertion".  How is
>>> nicer assertion failures related to QMP?  Am I confused?
>>
>>
>> The problem is solved by d2164ad ("vmstate: error hint for failed equal
>> checks", 2017-06-23).
> 
> The way the commit uses error_report() and error_printf() looks good to
> me.
> 

I'm glad to hear that. My confidence ain't very high because my understand
of the infrastructure is shallow (especially the interface between
libvirt/management software and qemu and end user). Because of that
I may have relied on the api-doc more that the more knowledgeable colleagues.

>> The assertions ain't assertions in sense of the C programming
>> language. Maybe calling these 'checks' instead of 'assertions' in the
>> cover letter (like in the subject) would have been better. If one of
>> these 'assertions' fail qemu is supposed to abort the initiated load
>> (migration), state the reason, and terminate normally. In this sense these
>> 'assertions' are similar to the assertions in our unit tests (those fail
>> a test, and similarly to these do not terminate the program).
>>
>> The problem I was trying to solve is that the message generated by these
>> checks looked something like "5 != 4" which is OK if the check is never
>> supposed to fail, but not satisfactory for something we have to live
>> with.
>>
>> Sorry for the confusion.
> 
> No problem :)
> 

I'm glad all resolves positively.

Thanks,
Halil
