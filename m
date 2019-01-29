Received: from eggs.gnu.org ([209.51.188.92]:52152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goV4F-0006bB-Dm
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goV3m-00075W-54
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:12:33 -0500
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-3-david@redhat.com>
	<20190123120539.3ca367f9.cohuck@redhat.com>
	<20190128122833.4613659a.cohuck@redhat.com>
	<3b9f7e27-5f3b-5a36-87ab-209942334e59@linux.ibm.com>
	<0c546fd4-28dd-6e62-8f9f-cd7894d36849@redhat.com>
	<a904740f-66e5-0956-44e7-4c29a4552897@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <accf8243-1100-117b-9bae-899537bf433c@redhat.com>
Date: Tue, 29 Jan 2019 16:11:14 +0100
MIME-Version: 1.0
In-Reply-To: <a904740f-66e5-0956-44e7-4c29a4552897@linux.ibm.com>
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
To: pmorel@linux.ibm.com, Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 29.01.19 14:50, Pierre Morel wrote:
> On 29/01/2019 11:24, David Hildenbrand wrote:
>>>>> I'm wondering what the architecture says regarding those events -- =
can
>>>>> someone with access to the documentation comment?
>>>>
>>>> Ping. Any comments from the IBM folks?
>=20
> Hi,
>=20
> Sorry to have wait so long.
> At least Collin was faster.
>=20
>>>>
>>>
>>>
>>> So the idea here is that if we have a PCI device that is the process =
of
>>> being deconfigured and we are also in the middle of a reset, then let=
's
>>> accelerate deconfiguring of the PCI device during the reset. Makes se=
nse.
>=20
> to me too.
> However, how do we ensure that the guest got time to respond to the=20
> first deconfigure request?

30 seconds, then the reboot. On a reboot, I don't see why we should give
a guest more time. "It's dead", rip out the card as the guest refused to
hand it back. (maybe it crashed! but after a reboot the guest state is
reset and baught back to life)

>=20
>>>
>>> Note:
>>>
>>> The callback function will deconfigure the the device and put it into
>>> standby mode. However, a PCI device should only go into standby from =
the
>>> *disabled state* (which it could already be in due to the unplug
>>> sequence), or from a *permanent error state* (something we should
>>> hopefully never see -- this means something went seriously wrong with
>>> the device).
>=20
> Not completely exact, the CHSC event 0x304, on the initiative of the=20
> host, force the "deconfigure state" from "configure state" generally,=20
> whatever sub-state it has (enabled/disabled/error...).
>=20
>>
>> Right, this should already have been checked before setting up the tim=
er.
>=20
> Apropos timer, do we need a timer or wouldn't it be better to use a=20
> delay / a timer + condition?

I don't think we need a timer at all.

>=20
> AFAIU we get out of the unplug without waiting for any answer from the=20
> guest and we surely get the timer triggering after the reset has been d=
one.
> That seems bad.

This is the case right now, correct.

>=20
>=20
>>
>>>
>>> Two things I'm concerned about:
>>>
>>> 1)
>>>
>>> What I would suggest is adding a check for the pbdev->state for
>>> ZPCI_FS_DISABLED || ZPCI_FS_PERMANENT_ERROR. If it is in either of th=
ese
>>> states, then we're safe to deconfigure and put into standby. If the
>>
>> We setup a timer if !ZPCI_FS_STANDBY and !ZPCI_FS_RESERVED.
>>
>> So for
>> - ZPCI_FS_DISABLED
>> - ZPCI_FS_ENABLED
>> - ZPCI_FS_BLOCKED
>> - ZPCI_FS_ERROR
>> - ZPCI_FS_PERMANENT_ERROR
>>
>> We setup a timer and simply go ahead and unplug the device when the
>> timer expires ("forced unplug").
>=20
> I agree only for ZPCI_FS_ENABLED why do we need to be smooth for other=20
> states?
> ZPCI_FS_DISABLED may be a candidate even I do not see the interrest but=
=20
> other states of the device should issue a HP_EVENT_DECONFIGURE_REQUEST=20
> and we do not need a timer (or any delay)

You can always expect that your guest driver is dead.

>=20
>>
>> Changing that behavior might be more invasive. Simply not unplugging i=
n
>> s390_pcihost_timer_cb() on some of these states would mean that somebo=
dy
>> issued a request and that requests is simply lost/ignored. Not sure if
>> that is what we want. I think we need separate patches to change
>> something like that. Especially
>>
>> 1. What happens if the device was in ZPCI_FS_DISABLED, the guest ignor=
es
>> the unplug request and moves the device to ZPCI_FS_ENABLED before the
>> timer expires? These are corner cases to consider.
>=20
> +1, we must ensure to do the work inside the unplug CB.
>=20
>>
>> 2. Do we need a timer at all? Now that Patch #1 introduces
>> unplug_requests, we are free to ignore requests from the user if the
>> guest is not reacting. I would really favor getting rid of the timer
>> completely. Was there a special reason why this was introduced?
>=20
> Yes, to let a chance to the guest to smoothly relinquish the device.
> (for example sync/clean the disk)
> However I do not think it is right implemented.
>=20
>>
>> No other architecture (e.g. ACPI) uses such a timer. They use a simple
>> flag to remember if a request is pending. I would really favor going
>> into that direction.
>=20
> I am not sure that the Intel architecture is a good example. :)

Right, we all learned that zPCI did it better. (sorry ;) )

>=20
> AFAIU they do not wait for the guest to have relinquish the device.
> Or do they?
> How long do they wait?

They wait for ever. And I guess we should do the same thing. If the
guest driver is broken (and this is really a rare scenario!) we would
not get the device back. Which is perfectly fine in my point of view. In
all other scenarios I guess the guest will simply respond in a timely
manner. And ripping out stuff from the guest always feels wrong. (yes
the channel subsystem works like that, but here we actually have a choice=
)

If we reboot, we can unplug the device. Otherwise, let's keep it simply
and don't use a timer.

Thanks!

--=20

Thanks,

David / dhildenb
