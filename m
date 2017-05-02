Received: from eggs.gnu.org ([2001:4830:134:3::10]:44127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5WHH-0006nx-QP
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5WHE-0002Co-M4
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5WHE-0002CE-Ce
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:47:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170428021317.24711-1-eblake@redhat.com>
	<20170428021317.24711-3-eblake@redhat.com>
	<87wpa4bnlo.fsf@dusky.pond.sub.org>
	<a45fe48a-5136-35e9-221d-a23939a31202@redhat.com>
Date: Tue, 02 May 2017 13:47:22 +0200
In-Reply-To: <a45fe48a-5136-35e9-221d-a23939a31202@redhat.com> (Eric Blake's
	message of "Fri, 28 Apr 2017 17:34:28 -0500")
Message-ID: <8737cno4z9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/4] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, alistair.francis@xilinx.com, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

Eric Blake <eblake@redhat.com> writes:

> On 04/28/2017 09:42 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> We want to track why a guest was shutdown; in particular, being able
>>> to tell the difference between a guest request (such as ACPI request)
>>> and host request (such as SIGINT) will prove useful to libvirt.
>>> Since all requests eventually end up changing shutdown_requested in
>>> vl.c, the logical change is to make that value track the reason,
>>> rather than its current 0/1 contents.
>>>
>>> Since command-line options control whether a reset request is turned
>>> into a shutdown request instead, the same treatment is given to
>>> reset_requested.
>>>
>>> This patch adds a QAPI enum ShutdownCause that describes reasons
>>> that a shutdown can be requested, and changes qemu_system_reset() to
>>> pass the reason through, although for now it is not reported.  The
>>> next patch will actually wire things up to modify events to report
>>> data based on the reason, and to pass the correct enum value in from
>>> various call-sites that can trigger a reset/shutdown.  Since QAPI
>>> generates enums starting at 0, it's easier if we use a different
>>> number as our sentinel that no request has happened yet.  Most of
>>> the changes are in vl.c, but xen was using things externally.
>>>
>
>>> -static int reset_requested;
>>> -static int shutdown_requested, shutdown_signal;
>>> +static int reset_requested = -1;
>>> +static int shutdown_requested = -1, shutdown_signal;
>> 
>> Peeking ahead, I see that shutdown_requested and reset_requested take
>> ShutdownCause values and -1.  The latter means "no shutdown requested".
>> What about adding 'none' to ShutdownCause, with value 0, und use that
>> instead of literal -1?  Would avoid the unusual "negative means false,
>> non-negative means true".
>
> Works nicely if the enum is internal-use only.  Gets a bit more awkward
> if the enum is exposed to the end-user.
>
> The fact that I let QAPI generate the enum in patch 3 is evidence that
> I'm leaning towards exposing it to the end user (patch 4); if we want to
> keep it internal-only, a better place for the enum might be in sysemu.h

Yes, unless you need the generated ShutdownCause_lookup[].

> (where we also have the weird '#define VMRESET_SILENT false' '#define
> VMRESET_REPORT true' to name a boolean parameter).

Some people believe such defines make code more readable, others hate
them.  Regardless, they're unusual in QEMU.  Unusual is best avoided.

>> PATCH 4 exposes ShutdownCause in event SHUTDOWN, and 'none' must not
>> occur there.  However, if we ever add a query-shutdown to go with this
>> event, we will need 'none' there.
>
> So, query-shutdown would basically be: what is the last-reported
> shutdown event (normally none, when the guest is still running; but if,
> like libvirt, you start qemu -no-shutdown, it can then be the cause of
> why we are in a shutdown/stopped state while waiting for final cleanup)?

Sounds right.

> How important/likely is such an event?  (Hmm, from libvirt's
> perspective, events are usually reliable, but can be lost; if we can
> restart libvirtd and reconnect to a qemu process that is hanging on to
> life only because no one has cleaned it up yet, query-shutdown does seem
> like a useful thing for libvirt to have at the time it reconnects to
> that qemu process).

Rule of thumb: if we need an event, we probably need a query, too.

> We could always include 'none' in the QAPI enum, then document in
> 'SHUTDOWN' and 'RESET' events that the cause will never be 'none'.

Yes.

>                                                                     Doc
> hacks like that feel a little unclean, but not so horrible as to be
> unforgivable.

I wouldn't call it an unclean hack.  For me, it's coping with an
insufficiently expressive type system: we can't define ShutdownCause + {
'none' } as a supertype of ShutdownCause.

Even if we could, I'm not sure it would be worth the bother.

>> I'd be tempted to reshuffle declarations here, because shutdown_signal's
>> int is a different one than reset_requested's and shutdown_requested,
>> and the latter two's "negative means false, non-negative means true" is
>> unusual enough to justify a comment.
> ...
>> 
>> Hmm.  In case we stick to literal -1: consider splitting this patch into
>> a part that changes @shutdown_requested from zero/non-zero to
>> negative/non-negative, and a part that uses ShutdownCause for the
>> non-negative values.
>
>
> You're definitely right that if the enum doesn't have a nice none=0
> state, then reshuffling to the magic -1 as no request is awkward enough
> to be done alone.
>
> But part of the answer is also dependent on whether we want PATCH 4 or
> not (or, as you brought up, the possibility of a query-shutdown command
> with even more persistent storage of the last-reported event).

Yes.

>>> @@ -1650,11 +1650,11 @@ static void qemu_kill_report(void)
>>>  static int qemu_reset_requested(void)
>>>  {
>>>      int r = reset_requested;
>>> -    if (r && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
>>> -        reset_requested = 0;
>>> +    if (r >= 0 && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
>>> +        reset_requested = -1;
>>>          return r;
>>>      }
>>> -    return false;
>>> +    return -1;
>> 
>> "return false" in a function returning int smells, good riddance.
>> 
>
> In one of my earlier drafts of the patch, I even tried to change the
> return type from int to bool, but decided that keeping it as int worked
> best (if I have to use the -1/cause dichotomy).  But you're also right
> that with a 'none' value in the enum, I could directly return ShutdownCause.
>
>>>  }
>>>
>>>  static int qemu_suspend_requested(void)
>>> @@ -1686,7 +1686,12 @@ static int qemu_debug_requested(void)
>>>      return r;
>>>  }
>>>
>>> -void qemu_system_reset(bool report)
>>> +/*
>>> + * Reset the VM. If @report is VMRESET_REPORT, issue an event, using
>>> + * the @reason interpreted as ShutdownType for details.  Otherwise,
>>> + * @report is VMRESET_SILENT and @reason is ignored.
>>> + */
>>> +void qemu_system_reset(bool report, int reason)
>> 
>> Why int reason and not ShutdownCause?  Hmm, peeking ahead, I see you
>> pass -1 with VMRESET_SILENT.  Yet another place where you use int for
>> type ShutdownCause + { -1 }.  Adding 'none' to ShutdownCause looks
>> even more attractive to me now.
>
> Yeah, it's getting to be that way to me to, even if it just means that I
> may have volunteered myself into writing a query-shutdown QMP command.

The reward for doing good work is more work.

>>> @@ -1738,9 +1744,10 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>>>  void qemu_system_reset_request(void)
>>>  {
>>>      if (no_reboot) {
>>> -        shutdown_requested = 1;
>>> +        /* FIXME - add a parameter to allow callers to specify reason */
>> 
>> FIXME addressed in the next patch.  Mention in this one's commit
>> message?
>
> Sure. Something like "Mark a couple of places as FIXME where we have to
> guess a value to use; a later patch will fix things to supply a correct
> value".

Works for me, provided the meaning of "value" is clear from context.

>> 
>>> +        shutdown_requested = SHUTDOWN_CAUSE_GUEST_RESET;
>
> I've also debated about splitting patch 3 into two parts: the event
> member additions (affecting .json and vl.c) and the parameter additions
> (affecting all other call-sites).  If I add the event parameter first,
> then supplying a bogus value to the event means extra churn to qemu
> iotests output files unless I change THIS line of code to guess
> SHUTDOWN_CAUSE_HOST_QMP; the other option is to wire up parameter
> passing first and event reporting last.
>
> I'll wait for more inputs before respinning this series (I already did a
> poor enough job slamming mailboxes by sending 3 iterations of the series
> in one day).  As you mention, I'd still like to hear ideas for the

Your v3 and v4 cost me no time, don't worry.

> replay side of things, and I wouldn't mind if Dan has any ideas from the
> libvirt/upper-layer stack usage side of things on the fate of patch 4.

Okay.
