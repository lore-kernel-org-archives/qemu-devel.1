Received: from eggs.gnu.org ([2001:4830:134:3::10]:41356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSHYD-0003Mc-EE
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSHY8-0002Dc-EL
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dSHY8-0002Ba-4v
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:04 -0400
From: Markus Armbruster <armbru@redhat.com>
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
Date: Tue, 04 Jul 2017 08:42:59 +0200
In-Reply-To: <a6f580f0-ed90-4860-231e-84612a14202f@linux.vnet.ibm.com> (Halil
	Pasic's message of "Mon, 3 Jul 2017 18:21:29 +0200")
Message-ID: <87van8aej0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cohuck@kernel.org>

Halil Pasic <pasic@linux.vnet.ibm.com> writes:

> On 07/03/2017 03:52 PM, Markus Armbruster wrote:
>> Halil Pasic <pasic@linux.vnet.ibm.com> writes:
>> 
>>> On 06/30/2017 04:54 PM, Eric Blake wrote:
>>>> On 06/30/2017 09:41 AM, Halil Pasic wrote:
>>>>>>> 'This' basically boils down to the question and
>>>>>>> 'Why aren't hints reported in QMP context?'
>>>>>>
>>>>>> QMP is supposed to be machine-parseable.  Hints are supposed to be
>>>>>> human-readable. If you have a machine managing the monitor, the hint
>>>>>> adds nothing but bandwidth consumption, because machine should not be
>>>>>> parsing the human portion of the error message in the first place (as it
>>>>>> is, libvirt already just logs the human-readable portion of a message,
>>>>>> and bases its actions solely on the machine-stable portions of an error
>>>>>> reply: namely, whether an error was sent at all, and occasionally, what
>>>>>> error class was used for that error - there's no guarantee a human will
>>>>>> be reading the log, though).
[...]
>>>>> From prior experiences I'm more used to think about error messages as
>>>>> something meant for human consumption, and expressing things expected to
>>>>> be relevant for some kind of client code in a different way (optimized
>>>>> for machine consumption).
>>>>>
>>>>> If however the error message ain't part of the machine relevant portion,
>>>>> then the same argument applies as to the 'hint', and I don't see the
>>>>> reason for handling hints differently. Do you agree with my
>>>>> argumentation?
>>>>
>>>> Indeed, it may not hurt to start passing the hints over the wire (errors
>>>> would then consume more bandwidth, but errors are not the hot path).
>>>> And I'm not necessarily opposed to that change, so much as trying to
>>>> document why it is not currently the case.  At the same time, I probably
>>>> won't be the one writing a path to populate the hint information into
>>>> the QMP error, as I don't have any reason to use the hint when
>>>> controlling libvirt (except maybe for logging, but there, the hint is
>>>> not going to help the end user, because it's not the end-user's fault
>>>> that libvirt used the API wrong to get a hint in the first place).
>>>
>>> For me both human readable things make sense only for error reporting
>>> (effectively logging). Error.msg should IMHO be different, than Error.hint.
>>> The existence of an error should be indicated by the Error object.
>> 
>> Consider this one from qemu-option.c:
>> 
>>         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
>>                    "a non-negative number below 2^64");
>>         error_append_hint(errp, "Optional suffix k, M, G, T, P or E means"
>>                           " kilo-, mega-, giga-, tera-, peta-\n"
>>                           "and exabytes, respectively.\n");
>> 
>> The hint is helpful for a human command line or HMP user.  It's actively
>> misleading in QMP.
>
> I agree.
>
>> Totally fine, it's how the "hint" feature is meant
>> to be used.
>> 
>
> Was not aware.
>
>> If we have errors that can't be adequately explained in a single error
>> message, we may need a way to add more explanation.  error_append_hint()
>> isn't.
>> 
>
> Was not aware. Using hint in this very situation was suggested by Connie,
> and I assumed she is long enough with the project to know...
>
> In fact looking at  include/qapi/error.h:
> """
> /*
>  * Error reporting system loosely patterned after Glib's GError.
>  *
>  * Create an error:
>  *     error_setg(&err, "situation normal, all fouled up");
>  *
>  * Create an error and add additional explanation:
>  *     error_setg(&err, "invalid quark");
>  *     error_append_hint(&err, "Valid quarks are up, down, strange, "
>  *                       "charm, top, bottom.\n");
>  *
>  * Do *not* contract this to
>  *     error_setg(&err, "invalid quark\n"
>  *                "Valid quarks are up, down, strange, charm, top, bottom.");
> """
>
> my understanding was and is still the exact opposite of what you say:
> error_append_hint is for adding more explanation.
>
> Furthermore 
> """
> /*
>  * Append a printf-style human-readable explanation to an existing error.
>  * @errp may be NULL, but not &error_fatal or &error_abort.
>  * Trivially the case if you call it only after error_setg() or
>  * error_propagate().
>  * May be called multiple times.  The resulting hint should end with a
>  * newline.
>  */
> void error_append_hint(Error **errp, const char *fmt, ...)
> """
>
> Assuming that error_append_hint() isn't for adding more explanation,
> IMHO the doc does not adequately explain what it is for.

You're right, it doesn't.

> I have also failed to find any hint in qapi/error.h which is AFAIU
> documenting the error api about this human-readable explanation
> appended to an existing error by error_append_hint() is to be discarded
> if the error is reported in QMP context.
>
> Am I reading the api doc incorrectly, or did the documentation and
> de-facto api diverge (behavior)?

I added documentation after I inherited this subsystem, in response to
recurring questions on proper use of the interface.  I failed to fully
capture the hint feature's intent.  I'll post a patch.

>>>>>> If something absolutely must be reported, then it is not a hint, and
>>>>>> shouldn't be using the hint mechanism.
>> 
>> Exactly.
>> 
>
> Perfectly fine with me provided the apidoc tells me clearly what the hint is
> for, and what it is not for.
>
>>>>> I find it hard to formulate criteria for 'must be reported'. I'm afraid
>>>>> this is backwards logic: since the hint may not be reported everything
>>>>> that needs to be reported is not a hint. This is a valid approach of
>>>>> course, but then I think some modifications to the comments in error.h
>>>>> would not hurt. And maybe something with verbose would be more
>>>>> expressive name.
>>>>>
>>>>> I hope all this makes some sense and ain't pure waste of time...
>>>>
>>>> No, it never hurts to question whether the design is optimal, and it's
>>>> better to question first to know whether it is even worth patching
>>>> things to behave differently, rather than spending time patching it only
>>>> to have a maintainer clarify that the patch can't be accepted because of
>>>> some design constraint.  So I still hope Markus will chime in.
>>>>
>>>
>>> For this patch I went with Dave's proposal so I have no acute interest
>>> in changing this.
>>>
>>> Conceptually, for me it really boils down to the question: Is it reasonable
>>> to assume that we are interested in what went wrong (error message)?
>>>
>>> If yes, we are good as is. If no, we should not drop hint in QMP context.
>>>
>>> Thanks for your time. I think we provided Markus with enough input to
>>> make his call :).
>> 
>> I had a quick peek at the patch that triggered this discussion.  What
>> problem are you trying to solve?  According to your cover letter, it's
>> "to specify a hint for the case a vmstate equal assertion".  How is
>> nicer assertion failures related to QMP?  Am I confused?
>
>
> The problem is solved by d2164ad ("vmstate: error hint for failed equal
> checks", 2017-06-23).

The way the commit uses error_report() and error_printf() looks good to
me.

> The assertions ain't assertions in sense of the C programming
> language. Maybe calling these 'checks' instead of 'assertions' in the
> cover letter (like in the subject) would have been better. If one of
> these 'assertions' fail qemu is supposed to abort the initiated load
> (migration), state the reason, and terminate normally. In this sense these
> 'assertions' are similar to the assertions in our unit tests (those fail
> a test, and similarly to these do not terminate the program).
>
> The problem I was trying to solve is that the message generated by these
> checks looked something like "5 != 4" which is OK if the check is never
> supposed to fail, but not satisfactory for something we have to live
> with.
>
> Sorry for the confusion.

No problem :)
