Received: from eggs.gnu.org ([2001:4830:134:3::10]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dS46Y-0001zh-9o
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dS46V-0000Ia-0L
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:21:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45062
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dS46U-0000II-PA
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:21:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v63GIuLh033954
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 12:21:35 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bfdbcwkcd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:21:35 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 17:21:33 +0100
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
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 3 Jul 2017 18:21:29 +0200
MIME-Version: 1.0
In-Reply-To: <87d19hk4q1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <a6f580f0-ed90-4860-231e-84612a14202f@linux.vnet.ibm.com>
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
Cc: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Juan Quintela <quintela@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@kernel.org>



On 07/03/2017 03:52 PM, Markus Armbruster wrote:
> Halil Pasic <pasic@linux.vnet.ibm.com> writes:
> 
>> On 06/30/2017 04:54 PM, Eric Blake wrote:
>>> On 06/30/2017 09:41 AM, Halil Pasic wrote:
>>>>>> 'This' basically boils down to the question and
>>>>>> 'Why aren't hints reported in QMP context?'
>>>>>
>>>>> QMP is supposed to be machine-parseable.  Hints are supposed to be
>>>>> human-readable. If you have a machine managing the monitor, the hint
>>>>> adds nothing but bandwidth consumption, because machine should not be
>>>>> parsing the human portion of the error message in the first place (as it
>>>>> is, libvirt already just logs the human-readable portion of a message,
>>>>> and bases its actions solely on the machine-stable portions of an error
>>>>> reply: namely, whether an error was sent at all, and occasionally, what
>>>>> error class was used for that error - there's no guarantee a human will
>>>>> be reading the log, though).
>>>>
>>>>
>>>> Seems I've made wrong assumptions about error messages (in QEMU) up until
>>>> now. If I understand you correctly, in QEMU error messages are part of
>>>> the API (but hints are not). Thus if one changes a typo in an error
>>>> message (like here
>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06732.html) the
>>>> one is strictly speaking breaking API backward compatibility.  Is that
>>>> really the way we want to have things?
>>>
>>> Quite the opposite. In QMP, the EXISTENCE of an error message is part of
>>> the API, but the CONTENTS of the message are not (machines are not
>>> supposed to further parse the message) - anything that the machine would
>>> want to differentiate between two different possible error messages
>>> should instead be conveyed via a second field in the same returned
>>> dictionary (the error class), and not by parsing the message.  
>>
>> I think we are in agreement, it's just that you call 'error message' what
>> I would call 'error response' (from docs/qmp-spec.txt).
> 
> According to qmp-spec.txt, the 'error response' is a JSON object of the
> form
> 
>     { "error": { "class": json-string, "desc": json-string },
>       "id": json-value }
> 
>>                                                         For me an error
>> response MAY OR MAY NOT or MUST (I don't know it is not stated in
>> qmp-spec.txt, and qapi-schema.json did not make me much smarter: I would
>> guess may or may not -- there is even some comment in qapi-schema showing
>> it that direction) contain a 'desc' which is per definition "- The
>> "desc" member is a human-readable error message. Clients should not
>> attempt to parse this message.".
> 
> Both in qmp-spec.txt and in the QAPI schema, members are mandatory
> unless marked optional.  Thus, "desc" is mandatory.
> 

My bad! I've missed the 'mandatory unless marked optional part' in
qmp-spec.txt.

>> So I would call that 'error message'. If the logic (modulo reporting) in
>> libvirt (I don't know, my focus isn't libvirt) or any other management
>> software depends on the EXISTENCE of 'desc' (or human-readable portion of
>> some error API object) I find that weird, but it's a definition thing.
> 
> QMP clients such as libvirt may depend on the existence of "desc", just
> not on its contents.
> 
> Depending on existence: show it to a human user, log it ...
> 
> Depending on contents: if "desc" matches /pattern/, do this, else do
> that.
> 

I understand. My guess was that desc is optional because of this (quote):
"""
# If you're planning to adopt QMP, please observe the following:
#
#     1. The deprecation policy will take effect and be documented soon, please
#        check the documentation of each used command as soon as a new release of
#        QEMU is available
#
#     2. DO NOT rely on anything which is not explicit documented
#
#     3. Errors, in special, are not documented. Applications should NOT check
#        for specific errors classes or data (it's strongly recommended to only
#        check for the "error" key)
#
"""
(qapi-schema.json)

I think this is a solomonic solution ;), it's just that I've missed
a crucial bit.

>>> Most
>>> often, there is not a strong case for having differentiation, so most
>>> errors are lumped in the generic class (error_setg() makes this easy to
>>> do by default).  An example where differentiation matters: look at the
>>> "Important Note" in blockdev.c:qmp_block_commit().
>>
>> I think I have seen that. I find the 'strong discouragement' weird, because
>> if there is a reason to have differentiation the error class is the way
>> to go. And if there is no reason to -- it should be obvious.
> 
> The "strong discouragement" is the result of a long and somewhat
> tortuous history.  If you're interested, I can tell it once again.
> 

Thanks, but I value your time more than I'm interested.

>>>> From prior experiences I'm more used to think about error messages as
>>>> something meant for human consumption, and expressing things expected to
>>>> be relevant for some kind of client code in a different way (optimized
>>>> for machine consumption).
>>>>
>>>> If however the error message ain't part of the machine relevant portion,
>>>> then the same argument applies as to the 'hint', and I don't see the
>>>> reason for handling hints differently. Do you agree with my
>>>> argumentation?
>>>
>>> Indeed, it may not hurt to start passing the hints over the wire (errors
>>> would then consume more bandwidth, but errors are not the hot path).
>>> And I'm not necessarily opposed to that change, so much as trying to
>>> document why it is not currently the case.  At the same time, I probably
>>> won't be the one writing a path to populate the hint information into
>>> the QMP error, as I don't have any reason to use the hint when
>>> controlling libvirt (except maybe for logging, but there, the hint is
>>> not going to help the end user, because it's not the end-user's fault
>>> that libvirt used the API wrong to get a hint in the first place).
>>
>> For me both human readable things make sense only for error reporting
>> (effectively logging). Error.msg should IMHO be different, than Error.hint.
>> The existence of an error should be indicated by the Error object.
> 
> Consider this one from qemu-option.c:
> 
>         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
>                    "a non-negative number below 2^64");
>         error_append_hint(errp, "Optional suffix k, M, G, T, P or E means"
>                           " kilo-, mega-, giga-, tera-, peta-\n"
>                           "and exabytes, respectively.\n");
> 
> The hint is helpful for a human command line or HMP user.  It's actively
> misleading in QMP.

I agree.

> Totally fine, it's how the "hint" feature is meant
> to be used.
> 

Was not aware.

> If we have errors that can't be adequately explained in a single error
> message, we may need a way to add more explanation.  error_append_hint()
> isn't.
> 

Was not aware. Using hint in this very situation was suggested by Connie,
and I assumed she is long enough with the project to know...

In fact looking at  include/qapi/error.h:
"""
/*
 * Error reporting system loosely patterned after Glib's GError.
 *
 * Create an error:
 *     error_setg(&err, "situation normal, all fouled up");
 *
 * Create an error and add additional explanation:
 *     error_setg(&err, "invalid quark");
 *     error_append_hint(&err, "Valid quarks are up, down, strange, "
 *                       "charm, top, bottom.\n");
 *
 * Do *not* contract this to
 *     error_setg(&err, "invalid quark\n"
 *                "Valid quarks are up, down, strange, charm, top, bottom.");
"""

my understanding was and is still the exact opposite of what you say:
error_append_hint is for adding more explanation.

Furthermore 
"""
/*
 * Append a printf-style human-readable explanation to an existing error.
 * @errp may be NULL, but not &error_fatal or &error_abort.
 * Trivially the case if you call it only after error_setg() or
 * error_propagate().
 * May be called multiple times.  The resulting hint should end with a
 * newline.
 */
void error_append_hint(Error **errp, const char *fmt, ...)
"""

Assuming that error_append_hint() isn't for adding more explanation,
IMHO the doc does not adequately explain what it is for.

I have also failed to find any hint in qapi/error.h which is AFAIU
documenting the error api about this human-readable explanation
appended to an existing error by error_append_hint() is to be discarded
if the error is reported in QMP context.

Am I reading the api doc incorrectly, or did the documentation and
de-facto api diverge (behavior)?

>>>>> If something absolutely must be reported, then it is not a hint, and
>>>>> shouldn't be using the hint mechanism.
> 
> Exactly.
> 

Perfectly fine with me provided the apidoc tells me clearly what the hint is
for, and what it is not for.

>>>> I find it hard to formulate criteria for 'must be reported'. I'm afraid
>>>> this is backwards logic: since the hint may not be reported everything
>>>> that needs to be reported is not a hint. This is a valid approach of
>>>> course, but then I think some modifications to the comments in error.h
>>>> would not hurt. And maybe something with verbose would be more
>>>> expressive name.
>>>>
>>>> I hope all this makes some sense and ain't pure waste of time...
>>>
>>> No, it never hurts to question whether the design is optimal, and it's
>>> better to question first to know whether it is even worth patching
>>> things to behave differently, rather than spending time patching it only
>>> to have a maintainer clarify that the patch can't be accepted because of
>>> some design constraint.  So I still hope Markus will chime in.
>>>
>>
>> For this patch I went with Dave's proposal so I have no acute interest
>> in changing this.
>>
>> Conceptually, for me it really boils down to the question: Is it reasonable
>> to assume that we are interested in what went wrong (error message)?
>>
>> If yes, we are good as is. If no, we should not drop hint in QMP context.
>>
>> Thanks for your time. I think we provided Markus with enough input to
>> make his call :).
> 
> I had a quick peek at the patch that triggered this discussion.  What
> problem are you trying to solve?  According to your cover letter, it's
> "to specify a hint for the case a vmstate equal assertion".  How is
> nicer assertion failures related to QMP?  Am I confused?


The problem is solved by d2164ad ("vmstate: error hint for failed equal
checks", 2017-06-23).

The assertions ain't assertions in sense of the C programming
language. Maybe calling these 'checks' instead of 'assertions' in the
cover letter (like in the subject) would have been better. If one of
these 'assertions' fail qemu is supposed to abort the initiated load
(migration), state the reason, and terminate normally. In this sense these
'assertions' are similar to the assertions in our unit tests (those fail
a test, and similarly to these do not terminate the program).

The problem I was trying to solve is that the message generated by these
checks looked something like "5 != 4" which is OK if the check is never
supposed to fail, but not satisfactory for something we have to live
with.

Sorry for the confusion.

Regards,
Halil
