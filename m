Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d86gD-0006F0-Lf
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d86gC-0007K5-Ka
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:04:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170508211953.28017-1-eblake@redhat.com>
	<20170508211953.28017-6-eblake@redhat.com>
	<87a86mp71i.fsf@dusky.pond.sub.org>
	<e86df300-088c-d1f6-4e5a-c201672820e3@redhat.com>
Date: Tue, 09 May 2017 17:03:52 +0200
In-Reply-To: <e86df300-088c-d1f6-4e5a-c201672820e3@redhat.com> (Eric Blake's
	message of "Tue, 9 May 2017 09:18:41 -0500")
Message-ID: <87mvamf4x3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 5/5] shutdown: Expose bool cause in
 SHUTDOWN and RESET events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel@nongnu.org, alistair.francis@xilinx.com, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 05/09/2017 07:07 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> Libvirt would like to be able to distinguish between a SHUTDOWN
>>> event triggered solely by guest request and one triggered by a
>>> SIGTERM or other action on the host.  While qemu_kill_report() was
>>> already able to give different output to stderr based on whether a
>>> shutdown was triggered by a host signal (but NOT by a host UI event,
>>> such as clicking the X on the window), that information was then
>>> lost to management.  The previous patches improved things to use an
>>> enum throughout all callsites, so now we have something ready to
>>> expose through QMP.
>>>
>>> Here is output from 'virsh qemu-monitor-event --loop' with the
>>> patch installed:
>>>
>>> event SHUTDOWN at 1492639680.731251 for domain fedora_13: {"guest":true}
>>> event STOP at 1492639680.732116 for domain fedora_13: <null>
>>> event SHUTDOWN at 1492639680.732830 for domain fedora_13: {"guest":false}
>>>
>>> Note that libvirt runs qemu with -no-quit: the first SHUTDOWN event
>> 
>> Do you mean -no-shutdown?
>
> Oh, right. (Too many synonyms to choose from).
>
>> 
>>> was triggered by an action I took directly in the guest (shutdown -h),
>>> at which point qemu stops the vcpus and waits for libvirt to do any
>>> final cleanups; the second SHUTDOWN event is the result of libvirt
>>> sending SIGTERM now that it has completed cleanup.
>> 
>> The double shutdown is a bit weird.  To avoid it, we'd have to
>> distinguish between guest shutdown and QEMU termination.  shutdown -h in
>> the guest triggers termination only when QEMU is configured that way.
>> SIGTERM triggers shutdown only when the guest is running.  The result
>> would be neater, but I'm not sure it's worth the extra effort.
>
> And libvirt is already handling the double event emission - it only
> exposes the first event to the end-user (which is the one that will have
> the correct guest-vs-host flag); the second event (which will always be
> host) is elided because libvirt already knows it passed on the first
> event.  So changing it is outside the scope of this series.

Agreed.

>>> +++ b/vl.c
>>> @@ -1705,8 +1705,8 @@ void qemu_system_reset(ShutdownCause reason)
>>>          qemu_devices_reset();
>>>      }
>>>      if (reason) {
>>> -        /* FIXME update event based on reason */
>>> -        qapi_event_send_reset(&error_abort);
>>> +        qapi_event_send_reset(reason >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
>>> +                              &error_abort);
>> 
>> Exploits enum ordering.  A comment in the enum definition warning not to
>> reorder its members would be in order.  Defining a suitable predicate
>> right next to it would do, too.
>
> As in, adding this to sysemu.h?

Yes, right next to the typedef.

> static inline bool shutdown_caused_by_guest(ShutdownCause cause) {
>     return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
> }
>
> I can do that, if you like it.

Works for me.  A suitable comment in the enum would also work.

>> With at least the -no-quit in the commit message fixed (assuming it
>> needs fixing):
>
> Yes, it does need fixing.
>
>> 
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> 
