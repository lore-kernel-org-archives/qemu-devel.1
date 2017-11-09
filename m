Received: from eggs.gnu.org ([2001:4830:134:3::10]:50483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCnbQ-0003K3-DK
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCnbL-0007Gt-Kb
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:14:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eCnbL-0007Ga-E0
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:14:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <d7a58698-bba9-b873-b2ae-a63bdd06895f@citrix.com>
	<20171030171814.GB5438@work-vm>
Date: Thu, 09 Nov 2017 15:14:36 +0100
In-Reply-To: <20171030171814.GB5438@work-vm> (David Alan Gilbert's message of
	"Mon, 30 Oct 2017 17:18:15 +0000")
Message-ID: <87d14rfsj7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] QMP event missed during startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Ross Lagerwall (ross.lagerwall@citrix.com) wrote:
>> Hi,
>> 
>> I have found an issue where QEMU emits the RESUME event during startup when
>> it starts VM execution, but it is not possible to receive this event.
>> 
>> To repro this, run:
>> qemu-system-i386 -m 256 -trace
>> enable=monitor_protocol_event_emit,file=/tmp/out -qmp
>> unix:/tmp/qmp,server,wait
>> 
>> QEMU will not start execution of the VM until something connects to the QMP
>> socket (e.g. qmp-shell). Once connected, no event is received on the QMP
>> connection but the tracepoint is hit indicating that an event has been
>> emitted. I suspect that the event is emitted while the QMP client is doing
>> the initial negotiation.
>> 
>> The reason I want to receive this event is that QEMU currently uses xenstore
>> to communicate this information to the Xen toolstack (see
>> xen-common.c:xen_change_state_handler) but we want to move to using QMP
>> rather than xenstore for this kind of thing.
>> 
>> Is this a known issue or just a bug that should be fixed?
>
> I'll leave it to Markus to say if it's a bug or not, but can't
> you work around this by starting qemu with -S which leaves the guest
> paused, and then continuing the guest when you have your QMP ?

You can:

<-- {"QMP": {"version": {"qemu": {"micro": 50, "minor": 10, "major": 2}, "package": " (v2.10.0-613-g10656079e1-dirty)"}, "capabilities": []}}
--> { "execute": "qmp_capabilities" }
<-- {"return": {}}
--> { "execute": "cont" }
<-- {"timestamp": {"seconds": 1510235984, "microseconds": 108550}, "event": "RESUME"}
<-- {"return": {}}

RESUME is sent in vm_prepare_start(), called from main() via vm_start(),
but only if @autostart, i.e. no -S.

The "wait" in the argument of -qmp makes QEMU wait for a QMP client to
connect to the QMP socket, long before vm_start() gets called.  However,
having connected is not sufficient for receiving events, you also have
to exit capabilities negotiation mode.  Not possible until QEMU is
running the main loop, which runs after the vm_start() quoted above.

If QMP monitors became usable before entering main_loop(), we'd have a
race condition instead.  The only reliable way to get the RESUME event
is -S.

This adds one minor item to the long list of reasons why management
software should pass -S.

All clear now?
