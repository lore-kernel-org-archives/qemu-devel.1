Received: from eggs.gnu.org ([209.51.188.92]:52892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goQZS-0001zQ-SG
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goQZR-0005uh-JW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:24:46 -0500
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-3-david@redhat.com>
	<20190123120539.3ca367f9.cohuck@redhat.com>
	<20190128122833.4613659a.cohuck@redhat.com>
	<3b9f7e27-5f3b-5a36-87ab-209942334e59@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0c546fd4-28dd-6e62-8f9f-cd7894d36849@redhat.com>
Date: Tue, 29 Jan 2019 11:24:41 +0100
MIME-Version: 1.0
In-Reply-To: <3b9f7e27-5f3b-5a36-87ab-209942334e59@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 2/2] s390x/pci: Unplug
 remaining devices on pcihost reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

>>> I'm wondering what the architecture says regarding those events -- ca=
n
>>> someone with access to the documentation comment?
>>
>> Ping. Any comments from the IBM folks?
>>
>=20
>=20
> So the idea here is that if we have a PCI device that is the process of=
=20
> being deconfigured and we are also in the middle of a reset, then let's=
=20
> accelerate deconfiguring of the PCI device during the reset. Makes sens=
e.
>=20
> Note:
>=20
> The callback function will deconfigure the the device and put it into=20
> standby mode. However, a PCI device should only go into standby from th=
e=20
> *disabled state* (which it could already be in due to the unplug=20
> sequence), or from a *permanent error state* (something we should=20
> hopefully never see -- this means something went seriously wrong with=20
> the device).

Right, this should already have been checked before setting up the timer.

>=20
> Two things I'm concerned about:
>=20
> 1)
>=20
> What I would suggest is adding a check for the pbdev->state for=20
> ZPCI_FS_DISABLED || ZPCI_FS_PERMANENT_ERROR. If it is in either of thes=
e=20
> states, then we're safe to deconfigure and put into standby. If the=20

We setup a timer if !ZPCI_FS_STANDBY and !ZPCI_FS_RESERVED.

So for
- ZPCI_FS_DISABLED
- ZPCI_FS_ENABLED
- ZPCI_FS_BLOCKED
- ZPCI_FS_ERROR
- ZPCI_FS_PERMANENT_ERROR

We setup a timer and simply go ahead and unplug the device when the
timer expires ("forced unplug").

Changing that behavior might be more invasive. Simply not unplugging in
s390_pcihost_timer_cb() on some of these states would mean that somebody
issued a request and that requests is simply lost/ignored. Not sure if
that is what we want. I think we need separate patches to change
something like that. Especially

1. What happens if the device was in ZPCI_FS_DISABLED, the guest ignores
the unplug request and moves the device to ZPCI_FS_ENABLED before the
timer expires? These are corner cases to consider.

2. Do we need a timer at all? Now that Patch #1 introduces
unplug_requests, we are free to ignore requests from the user if the
guest is not reacting. I would really favor getting rid of the timer
completely. Was there a special reason why this was introduced?

No other architecture (e.g. ACPI) uses such a timer. They use a simple
flag to remember if a request is pending. I would really favor going
into that direction.

@Christian do you think we need this "force remove after 30 seconds"
timer thingy?

> device is still in another state (such as enabled or blocked, etc) then=
=20
> we should allow the timer to resume and give the device some more time=20
> before forcing an unplug. It's also probably not a good idea to try and=
=20
> deconfigure a device that might already be deconfigured (e.g. if it's=20
> already in standby or reserved state). That might not happen though, bu=
t=20
> it's good to cover our bases.
>=20
> A side thought: In addition to checking the states, what would happen i=
f=20
> you forced the timer to 0? Would the callback get called? Would that=20
> just accelerate the already-in-progress unplug sequence?

I guess so, but then action will be called asynchronously from the main
loop when timers are run. Calling it synchronously during the reset
makes in my point of view more sense.

>=20
> and 2)
>=20
> I worry that the sclp might try to deconfigure a PCI device at the same=
=20
> time we force the callback in this patch. I noticed that the=20
> sclp_deconfigure function also checks on the release timer before=20
> unplugging. I think we should make sure the timer is properly stopped o=
r=20
> canceled before the sclp tries to deconfigure and before this patch=20
> forces the callback, that way we hopefully won't try to do both at the=20
> same time.

Not necessary. Timers are ran from the main thread, just as we (system
reset) are. We don't have any race conditions here. This would only be
possible when being triggered by a VCPU without holding the iothread
mutex. But this is never the case. All VCPUs and even timers (due to the
virtual clock being stopped) are stopped during system reset.


--=20

Thanks,

David / dhildenb
