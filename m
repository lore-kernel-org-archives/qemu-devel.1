Received: from eggs.gnu.org ([2001:4830:134:3::10]:55771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9Dhi-0002XX-RS
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9Dhe-0000nr-2u
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9Dhd-0000nP-T3
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:18:22 -0400
Date: Mon, 30 Oct 2017 17:18:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171030171814.GB5438@work-vm>
References: <d7a58698-bba9-b873-b2ae-a63bdd06895f@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a58698-bba9-b873-b2ae-a63bdd06895f@citrix.com>
Subject: Re: [Qemu-devel] QMP event missed during startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

* Ross Lagerwall (ross.lagerwall@citrix.com) wrote:
> Hi,
> 
> I have found an issue where QEMU emits the RESUME event during startup when
> it starts VM execution, but it is not possible to receive this event.
> 
> To repro this, run:
> qemu-system-i386 -m 256 -trace
> enable=monitor_protocol_event_emit,file=/tmp/out -qmp
> unix:/tmp/qmp,server,wait
> 
> QEMU will not start execution of the VM until something connects to the QMP
> socket (e.g. qmp-shell). Once connected, no event is received on the QMP
> connection but the tracepoint is hit indicating that an event has been
> emitted. I suspect that the event is emitted while the QMP client is doing
> the initial negotiation.
> 
> The reason I want to receive this event is that QEMU currently uses xenstore
> to communicate this information to the Xen toolstack (see
> xen-common.c:xen_change_state_handler) but we want to move to using QMP
> rather than xenstore for this kind of thing.
> 
> Is this a known issue or just a bug that should be fixed?

I'll leave it to Markus to say if it's a bug or not, but can't
you work around this by starting qemu with -S which leaves the guest
paused, and then continuing the guest when you have your QMP ?

Dave

> Thanks,
> -- 
> Ross Lagerwall
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
