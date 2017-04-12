Received: from eggs.gnu.org ([2001:4830:134:3::10]:60216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyIhX-0006uQ-CT
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyIhU-0004Ud-A3
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cyIhU-0004U2-0j
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:52:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170406210917.6896-1-eblake@redhat.com>
	<877f2pnb2t.fsf@dusky.pond.sub.org>
	<70ca7ebd-f538-1721-c500-9e106225959c@redhat.com>
Date: Wed, 12 Apr 2017 15:52:44 +0200
In-Reply-To: <70ca7ebd-f538-1721-c500-9e106225959c@redhat.com> (Eric Blake's
	message of "Wed, 12 Apr 2017 08:15:07 -0500")
Message-ID: <87vaq97mxf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

Eric Blake <eblake@redhat.com> writes:

> On 04/12/2017 06:02 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> qemu_kill_report() is already able to tell whether a shutdown
>>> was triggered by guest action (no output) or by a host signal
>>> (a message about termination is printed via error_report); but
>>> this information is then lost.  Libvirt would like to be able
>>> to distinguish between a SHUTDOWN event triggered solely by
>>> guest request and one triggered by a SIGTERM on the host.
>>>
>>> Enhance the SHUTDOWN event to pass the value of shutdown_signal
>>> through to the monitor client, suitably remapped into a
>>> platform-neutral string.  Note that mingw lacks decent signal
>> 
>> I understand the desire to distinguish between guest-initiated and
>> host-initiated shutdown, but I'm not sure why libvirt (or anyone) would
>> care for the exact signal.  Can you explain?
>
> If we don't care about the signal itself, a simple boolean (host vs.
> guest) is just as easy to code up.  Or even code up a boolean now, and
> then add signal information down the road if someone has a use case for
> it (as Dan said, libvirt doesn't care, but someone on top of libvirt
> might - but I haven't identified such a user at this point in time).

Starting with just a boolean should be safe.  Especially attractive if
it lets us sidestep Windows complications; more on that below.

>> 
>>>                           Note that mingw lacks decent signal
>>> support, and will never report a signal because it never calls
>>> qemu_system_killed().
>> 
>> Awkward.
>> 
>
>> In other words, these three signals are polite requests to terminate
>> QEMU.
>> 
>> Stefan, are there equivalent requests under Windows?  I guess there
>> might be one at least for SIGINT, namely whatever happens when you hit
>> ^C on the console.
>
> Mingw has SIGINT (C99 requires it), and that's presumably what happens
> for ^C,...
>
>> 
>> Could we arrange to run qemu_system_killed() then?
>
> ...but I don't know why it is not currently wired up to call
> qemu_system_killed(), nor do I have enough Windows programming expertise
> to try and write such a patch. But I think that is an orthogonal
> improvement.  On the other hand, mingw has a definition for SIGTERM (but
> I'm not sure how it gets triggered) and no definition at all for SIGHUP
> (as evidenced by the #ifdef'fery in the patch to get it to compile under
> docker targetting mingw).

If all we need is distingishing host- and guest-initiated shutdown, then
detecting the latter reliably lets us stay away from OS-specific stuff.
Can we do that?

>> 
>> If not, could we at least distinguish between guest-initiated and
>> host-initiated shutdown?
>> 
>>> See also https://bugzilla.redhat.com/1384007
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  qapi/event.json | 20 +++++++++++++++++++-
>>>  vl.c            | 21 ++++++++++++++++++---
>>>  2 files changed, 37 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/qapi/event.json b/qapi/event.json
>>> index e80f3f4..6aad475 100644
>>> --- a/qapi/event.json
>>> +++ b/qapi/event.json
>>> @@ -5,11 +5,29 @@
>>>  ##
>>>
>>>  ##
>>> +# @ShutdownSignal:
>>> +#
>>> +# The list of host signal types known to cause qemu to shut down a guest.
>>> +#
>>> +# @int: SIGINT
>>> +# @hup: SIGHUP
>>> +# @term: SIGTERM
>>> +#
>>> +# Since: 2.10
>>> +##
>>> +{ 'enum': 'ShutdownSignal', 'data': [ 'int', 'hup', 'term' ] }
>> 
>> I'd call them sigint, sighup, sigterm, but it's a matter of taste.
>
> And it goes away if we are okay with a simpler bool of host vs. guest.
>
>> 
>>> +
>>> +##
>>>  # @SHUTDOWN:
>>>  #
>>>  # Emitted when the virtual machine has shut down, indicating that qemu is
>>>  # about to exit.
>>>  #
>>> +# @signal: If present, the shutdown was (probably) triggered due to
>>> +# the receipt of the given signal in the host, rather than by a guest
>>> +# action (note that there is an inherent race with a guest choosing to
>>> +# shut down near the same time the host sends a signal). (since 2.10)
>>> +#
>> 
>> Is the "(probably)" due to just Windows, or are there other reasons for
>> uncertainty?
>
> There are other reasons too: a guest can request shutdown immediately
> before the host sends SIGINT. Based on when things are processed, you
> could see either the guest or the host as the initiator.  And the race
> is not entirely implausible - when trying to shut down a guest, libvirt
> first tries to inform the guest to initiate things (whether by interrupt
> or guest agent), but after a given amount of time, assumes the guest is
> unresponsive and resorts to a signal to qemu. A heavily loaded guest
> that takes its time in responding could easily overlap with the timeout
> resorting to a host-side action.

This race doesn't worry me.  If both host and guest have initiated a
shutdown, then reporting whichever of the two finishes first seems fair.

Additional ways to terminate QEMU: HMP and QMP command "quit", and the
various GUI controls such "close SDL window".

>
>>> -static void qemu_kill_report(void)
>>> +static ShutdownSignal qemu_kill_report(void)
>>>  {
>>> +    ShutdownSignal ss = SHUTDOWN_SIGNAL__MAX;
>>>      if (!qtest_driver() && shutdown_signal != -1) {
>> 
>> Outside this patch's scope: could just as well use 0 instead of -1, as 0
>> can't be a valid signal number (kill() uses it for "check if we could
>> kill").
>
> Indeed.
>
>>> @@ -1852,8 +1867,8 @@ static bool main_loop_should_exit(void)
>>>          qemu_system_suspend();
>>>      }
>>>      if (qemu_shutdown_requested()) {
>>> -        qemu_kill_report();
>>> -        qapi_event_send_shutdown(&error_abort);
>>> +        ShutdownSignal ss = qemu_kill_report();
>>> +        qapi_event_send_shutdown(ss < SHUTDOWN_SIGNAL__MAX, ss, &error_abort);
>>>          if (no_shutdown) {
>>>              vm_stop(RUN_STATE_SHUTDOWN);
>>>          } else {
>> 
>> Why not send the event within qemu_kill_report()?
>
> Sure, I can do that in v2.
