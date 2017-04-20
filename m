Received: from eggs.gnu.org ([2001:4830:134:3::10]:38025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1En3-0003AC-JQ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1En2-0005LS-Gp
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:18:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170419222258.13415-1-eblake@redhat.com>
	<87k26fffxa.fsf@dusky.pond.sub.org>
	<1adf2797-b86a-00be-bb98-658ee8d0a55d@redhat.com>
Date: Thu, 20 Apr 2017 18:18:26 +0200
In-Reply-To: <1adf2797-b86a-00be-bb98-658ee8d0a55d@redhat.com> (Eric Blake's
	message of "Thu, 20 Apr 2017 08:31:13 -0500")
Message-ID: <87lgqv833h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Paolo Bonzini <pbonzini@redhat.com>, Scott Wood <scottwood@freescale.com>, Richard Henderson <rth@twiddle.net>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Eric Blake <eblake@redhat.com> writes:

> On 04/20/2017 06:59 AM, Markus Armbruster wrote:
>
>> 
>> No objection to Alistair's idea to turn this into an enumeration.
>
> Question - should the enum be more than just 'guest' and 'host'?  For
> example, my patch proves that we have a lot of places that handle
> complimentary machine commands to reset and shutdown, and that whether
> 'reset' triggers a reset (and the guest keeps running as if rebooted) or
> a shutdown is then based on the command-line arguments given to qemu.
> So having the enum differentiate between 'guest-reset' and
> 'guest-shutdown' would be a possibility, if we want the enum to have
> additional states.

I don't know.  What I do know is that we better get the enum right:
while adding members is backwards-compatible, changing the member sent
for a specific trigger is not.  If we want to reserve the option to do
that anyway, we need suitable documentation.

>>> +++ b/vl.c
>>> @@ -1717,7 +1717,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>>>      if (!no_shutdown) {
>>>          qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
>>>                                         !!info, info, &error_abort);
>>> -        qemu_system_shutdown_request();
>>> +        qemu_system_shutdown_request(false);
>> 
>> Panicking is a guest action.  Whether the shutdown on panic should be
>> attributed to guest or host is perhaps debatable.
>
> And it relates to the idea that a guest request for a 'reset' turns into
> a qemu response of 'shutdown'.  After all, whether a guest panic results
> in a shutdown action is determined by command-line arguments to qemu.
> So if we DO want to differentiate between a guest panic and a normal
> guest shutdown, when both events are wired at the command line to cause
> the SHUTDOWN action, then that's another enum to add to my list.
>
>
>>> +++ b/replay/replay.c
>>> @@ -51,7 +51,10 @@ bool replay_next_event_is(int event)
>>>          switch (replay_state.data_kind) {
>>>          case EVENT_SHUTDOWN:
>>>              replay_finish_event();
>>> -            qemu_system_shutdown_request();
>>> +            /* TODO: track source of shutdown request, to replay a
>>> +             * guest-initiated request rather than always claiming to
>>> +             * be from the host? */
>>> +            qemu_system_shutdown_request(false);
>> 
>> This is what your "need a followup patch" refers to.  I'd like to have
>> an opinion from someone familiar with replay on what exactly we need
>> here.
>
> replay-internal.h has an enum ReplayEvents, which is a list of one-byte
> codes used in the replay data stream to record which event to replay. I
> don't know if it is easier to change the replay stream to add a 2-byte
> code (shutdown-with-cause, followed by an encoding of the cause enum),
> or a range of one-byte codes (one new code per number of enum members).
> I also don't know how easy or hard it is to extend the enum (are we free
> to add events in the middle, or are we worried about back-compat to an
> older replay stream that must still play correctly with a newer qemu,
> such that new events must be higher than all existing events).
>
> So yes, I'm hoping for feedback from someone familiar with replay.
>
>> 
>> Amazing number of ways to shut down or reset a machine.
>
> And as I said, it would be easier to submit a patch with less churn by
> having the uncommon case (host-triggered) call a new
> qemu_system_shutdown_request_reason(enum), while the common case
> (guest-triggered) be handled by having qemu_system_shutdown_request()
> with no arguments call
> qemu_system_shutdown_request_reason(SHUTDOWN_GUEST).  I'm just worried
> that doing it that way makes it easy for yet another new host shutdown
> method to use the wrong wrapper.

I don't mind the churn.  It does simplify review.

>> Looks sane on first glance.
>> 
