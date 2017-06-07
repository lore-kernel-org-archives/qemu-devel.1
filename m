Received: from eggs.gnu.org ([2001:4830:134:3::10]:35053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIZw8-0007zu-I3
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dIZw5-000068-A8
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:19:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54462
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dIZw5-00005y-41
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:19:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v57CIvm2046238
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 08:19:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2axcucdf6h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:19:39 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 13:19:38 +0100
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-3-pasic@linux.vnet.ibm.com>
	<20170607110758.GC2099@work-vm>
	<c6466750-6d71-988c-6c81-9c54f5ca995a@linux.vnet.ibm.com>
	<20170607120138.GD2384@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 7 Jun 2017 14:19:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170607120138.GD2384@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1fb16203-3857-d0aa-498e-4acca6a28a41@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] vmstate: error hint for failed
 equal checks part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org



On 06/07/2017 02:01 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>
>>
>> On 06/07/2017 01:07 PM, Dr. David Alan Gilbert wrote:
>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>>> Verbose error reporting for the _EQUAL family. Modify the standard _EQUAL
>>>> so the hint states the assertion probably failed due to a bug. Introduce
>>>> _EQUAL_HINT for specifying a context specific hint.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>
>>> I'd prefer not to print 'Bug!?' by default - they already get the
>>> message telling them something didn't match and the migration fails.
>>> There are none-bug ways of this happening, e.g. a user starting a VM on
>>> the source and destination with different configs.
>>
>> I admit, my objective with 'Bug!?' was to provoke. My train of thought is
>> to encourage the programmer to think about and document the circumstances
>> under which such an assertion is supposed to fail (and against which it
>> is supposed to guard).
>>
>> I do not know how skillful are our users but a 4 != 5 then maybe a name
>> of a vmstate field is probably quite scary and not very revealing. I doubt
>> a non qemu developer can use it for something else that reporting a bug.
>>
>> Consequently if there are non-bug ways one can use the hint and state them.
>> Your example with the misconfigured target, by the way, is IMHO also be due
>> to a bug of the management software IMHO.
>>
>> To sum it up: IMHO the message provided by a failing _EQUAL is to ugly
>> and Qemuspeak to be presented to an user-user in non-bug cases. Agree?
>> Disagree?
> 
> Disagree.
> 
> I don't mind giving field names etc; they make it easy for us as
> developers to track down what's happening, but also sometimes they help
> endusers work around a prolem or see where the problem is; of course
> that varies depending on the field name, but some of our names are
> reasonable (e.g. there's a VMSTATE_INT32_EQUAL on 'queue_size' in
> vmmouse.c).  They're also pretty good if two end users hit the same
> problem they can see the same error message in a bug report.
> 
> We often have customer-facing support people look at logs before they
> get as far as us developers; if we have bugs that are 
> 'if it's a failing BLAH device complaining about the BAR field'
> then this fixes it, then that helps them find workarounds/fixes quickly
> even if they don't understand what the BAR field is.
> 

You seem to forget, that I'm not proposing omitting this information,
but extending it with something civilized so one can distinguish between
an assert failed should have never happened situation an a as good as
reasonable error handling for an expected error scenario. IMHO the current
EQUAL looks more like the former (assert) and less like the later (error
reporting for an expected error scenario). Agree? Dissagree?

Having a field name is great! That's beyond discussion.

I see, my 'sum it up' above was a bit unfortunate: it sounds like I'm
against the inclusion of technical info and not against a lack of non
technical info. Sorry for that!

>>
>>>
>>> (I also worry we have a lot f macros for each size;
>>> EQUAL, EQUAL_V, EQUAL_V_HINT but I don't know of a better answer for
>>> that)
>>>
>>
>> If we are going to drop the default hint ('Bug?!' or whatever) then
>> I think we could just add an extra NULL hint to each existing  _EQUAL
>> usage, re-purpose EQUAL, and forget about introducing new _HINT macros.
>>
>> What to you think?
> 
> Yes, that would be a lot simpler; and there aren't that many
> VMSTATE*EQUAL* macros in use.
> 

I still have not given up on the discussion above. Will do depending
on the outcome.

Regards,
Halil
