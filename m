Received: from eggs.gnu.org ([2001:4830:134:3::10]:47017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZYAo-0007nn-1M
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZYAk-0005Wz-0q
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZYAj-0005KC-ME
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:29:45 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181211095057.14623-1-fli@suse.com>
	<20181211095057.14623-7-fli@suse.com>
	<87y38tc2fb.fsf@dusky.pond.sub.org>
	<20181214112447.510e4691@umbus.fritz.box>
Date: Wed, 19 Dec 2018 10:29:41 +0100
In-Reply-To: <20181214112447.510e4691@umbus.fritz.box> (David Gibson's message
	of "Fri, 14 Dec 2018 11:24:47 +1100")
Message-ID: <87k1k5lv96.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v8 6/7] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <dgibson@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

David Gibson <dgibson@redhat.com> writes:

> On Thu, 13 Dec 2018 08:26:48 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> There's a question for David Gibson inline.  Please search for /ppc/.
>> 
>> Fei Li <fli@suse.com> writes:
>> 
>> > Make qemu_thread_create() return a Boolean to indicate if it succeeds
>> > rather than failing with an error. And add an Error parameter to hold
>> > the error message and let the callers handle it.  
>> 
>> The "rather than failing with an error" is misleading.  Before the
>> patch, we report to stderr and abort().  What about:
>> 
>>     qemu-thread: Make qemu_thread_create() handle errors properly
>> 
>>     qemu_thread_create() abort()s on error.  Not nice.  Give it a
>>     return value and an Error ** argument, so it can return success /
>>     failure.
>> 
>> Still missing from the commit message then: how you update the callers.
>> Let's see below.
>
> [snip]
>> > --- a/hw/ppc/spapr_hcall.c
>> > +++ b/hw/ppc/spapr_hcall.c
>> > @@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>> >      sPAPRPendingHPT *pending = spapr->pending_hpt;
>> >      uint64_t current_ram_size;
>> >      int rc;
>> > +    Error *local_err = NULL;
>> >  
>> >      if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
>> >          return H_AUTHORITY;
>> > @@ -538,8 +539,13 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>> >      pending->shift = shift;
>> >      pending->ret = H_HARDWARE;
>> >  
>> > -    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
>> > -                       hpt_prepare_thread, pending, QEMU_THREAD_DETACHED);
>> > +    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
>> > +                            hpt_prepare_thread, pending,
>> > +                            QEMU_THREAD_DETACHED, &local_err)) {
>> > +        error_reportf_err(local_err, "failed to create hpt_prepare_thread: ");
>> > +        g_free(pending);
>> > +        return H_RESOURCE;
>> > +    }
>> >  
>> >      spapr->pending_hpt = pending;
>> >    
>> 
>> This is a caller that returns an error code on failure.  You change it
>> to report the error, then return failure.  The return failure part looks
>> fine.  Whether reporting the error is appropriate I can't say for sure.
>> No other failure mode reports anything.  David, what do you think?
>
> I think it's reasonable here.  In this context error returns and
> reported errors are for different audiences.  The error returns are for
> the guest, the reported errors are for the guest administrator or
> management layers.  This particularly failure is essentially a host
> side fault that is mostly relevant to the VM management.  We have to
> say *something* to the guest to explain that the action couldn't go
> forward and H_RESOURCE makes as much sense as anything.

Double-checking: is it okay to report some failures of this function
(one of two H_RESOURCE failures, to be precise), but not others?
