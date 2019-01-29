Received: from eggs.gnu.org ([209.51.188.92]:41566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goY0M-00036Y-SC
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1goY0L-0002jy-IO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:21:02 -0500
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-3-david@redhat.com>
	<20190123120539.3ca367f9.cohuck@redhat.com>
	<20190128122833.4613659a.cohuck@redhat.com>
	<3b9f7e27-5f3b-5a36-87ab-209942334e59@linux.ibm.com>
	<0c546fd4-28dd-6e62-8f9f-cd7894d36849@redhat.com>
	<a904740f-66e5-0956-44e7-4c29a4552897@linux.ibm.com>
	<accf8243-1100-117b-9bae-899537bf433c@redhat.com>
	<f9959c97-463e-9681-46ef-19ea728c2025@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <eecbc9c1-cae8-f5d6-32be-8bf71436ac2f@redhat.com>
Date: Tue, 29 Jan 2019 19:20:55 +0100
MIME-Version: 1.0
In-Reply-To: <f9959c97-463e-9681-46ef-19ea728c2025@linux.ibm.com>
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

On 29.01.19 17:50, Pierre Morel wrote:
> On 29/01/2019 16:11, David Hildenbrand wrote:
>> On 29.01.19 14:50, Pierre Morel wrote:
>>> On 29/01/2019 11:24, David Hildenbrand wrote:
>>>>>>> I'm wondering what the architecture says regarding those events -=
- can
>>>>>>> someone with access to the documentation comment?
>>>>>>
>>>>>> Ping. Any comments from the IBM folks?
>>>
>>> Hi,
>>>
>>> Sorry to have wait so long.
>>> At least Collin was faster.
>>>
>>>>>>
>>>>>
>>>>>
>>>>> So the idea here is that if we have a PCI device that is the proces=
s of
>>>>> being deconfigured and we are also in the middle of a reset, then l=
et's
>>>>> accelerate deconfiguring of the PCI device during the reset. Makes =
sense.
>>>
>>> to me too.
>>> However, how do we ensure that the guest got time to respond to the
>>> first deconfigure request?
>>
>> 30 seconds, then the reboot. On a reboot, I don't see why we should gi=
ve
>> a guest more time. "It's dead", rip out the card as the guest refused =
to
>> hand it back. (maybe it crashed! but after a reboot the guest state is
>> reset and baught back to life)
>=20
> I agree that 30 seconds is way enough,
> also agree that in most cases the guest is dead.
>=20
>=20
>>
>>>
>>>>>
>>>>> Note:
>>>>>
>>>>> The callback function will deconfigure the the device and put it in=
to
>>>>> standby mode. However, a PCI device should only go into standby fro=
m the
>>>>> *disabled state* (which it could already be in due to the unplug
>>>>> sequence), or from a *permanent error state* (something we should
>>>>> hopefully never see -- this means something went seriously wrong wi=
th
>>>>> the device).
>>>
>>> Not completely exact, the CHSC event 0x304, on the initiative of the
>>> host, force the "deconfigure state" from "configure state" generally,
>>> whatever sub-state it has (enabled/disabled/error...).
>>>
>>>>
>>>> Right, this should already have been checked before setting up the t=
imer.
>>>
>>> Apropos timer, do we need a timer or wouldn't it be better to use a
>>> delay / a timer + condition?
>>
>> I don't think we need a timer at all.
>=20
> Yes, if it is possible to wait synchronously 30s it seems good to me.

I mean, we don't have to wait 30 seconds at all.

1. We send a request to the guest
2. It responds (after some seconds), letting go of the zPCI device
3. We unplug the device

1. We send a request to the guest
2. Guest does not respond, request keeps pending forever
3. On reboot, unplug the device

This is how x86/ACPI handles it.

>=20
>>
>>>
>>> AFAIU we get out of the unplug without waiting for any answer from th=
e
>>> guest and we surely get the timer triggering after the reset has been=
 done.
>>> That seems bad.
>>
>> This is the case right now, correct.
>>
>>>
>>>
>>>>
>>>>>
>>>>> Two things I'm concerned about:
>>>>>
>>>>> 1)
>>>>>
>>>>> What I would suggest is adding a check for the pbdev->state for
>>>>> ZPCI_FS_DISABLED || ZPCI_FS_PERMANENT_ERROR. If it is in either of =
these
>>>>> states, then we're safe to deconfigure and put into standby. If the
>>>>
>>>> We setup a timer if !ZPCI_FS_STANDBY and !ZPCI_FS_RESERVED.
>>>>
>>>> So for
>>>> - ZPCI_FS_DISABLED
>>>> - ZPCI_FS_ENABLED
>>>> - ZPCI_FS_BLOCKED
>>>> - ZPCI_FS_ERROR
>>>> - ZPCI_FS_PERMANENT_ERROR
>>>>
>>>> We setup a timer and simply go ahead and unplug the device when the
>>>> timer expires ("forced unplug").
>>>
>>> I agree only for ZPCI_FS_ENABLED why do we need to be smooth for othe=
r
>>> states?
>>> ZPCI_FS_DISABLED may be a candidate even I do not see the interrest b=
ut
>>> other states of the device should issue a HP_EVENT_DECONFIGURE_REQUES=
T
>>> and we do not need a timer (or any delay)
>>
>> You can always expect that your guest driver is dead.
>=20
> hum, the device is dead.
> May be the guest got hit too if the driver is not right written.
>=20
>>
>>>
>>>>
>>>> Changing that behavior might be more invasive. Simply not unplugging=
 in
>>>> s390_pcihost_timer_cb() on some of these states would mean that some=
body
>>>> issued a request and that requests is simply lost/ignored. Not sure =
if
>>>> that is what we want. I think we need separate patches to change
>>>> something like that. Especially
>>>>
>>>> 1. What happens if the device was in ZPCI_FS_DISABLED, the guest ign=
ores
>>>> the unplug request and moves the device to ZPCI_FS_ENABLED before th=
e
>>>> timer expires? These are corner cases to consider.
>>>
>>> +1, we must ensure to do the work inside the unplug CB.
>>>
>>>>
>>>> 2. Do we need a timer at all? Now that Patch #1 introduces
>>>> unplug_requests, we are free to ignore requests from the user if the
>>>> guest is not reacting. I would really favor getting rid of the timer
>>>> completely. Was there a special reason why this was introduced?
>>>
>>> Yes, to let a chance to the guest to smoothly relinquish the device.
>>> (for example sync/clean the disk)
>>> However I do not think it is right implemented.
>>>
>>>>
>>>> No other architecture (e.g. ACPI) uses such a timer. They use a simp=
le
>>>> flag to remember if a request is pending. I would really favor going
>>>> into that direction.
>>>
>>> I am not sure that the Intel architecture is a good example. :)
>>
>> Right, we all learned that zPCI did it better. (sorry ;) )
>=20
> Well I really think so.
> It is designed with several guest in parallel and shared devices.
>=20
> In such an architecture, ripping of a device from a guest may have inte=
rest.
> One good thing would be that the software of the guest handle it :)

That is indeed true, but I think such a forced removal also works on
x86. Theoretically. ("physically rip out the card"). See below.

>=20
>>
>>>
>>> AFAIU they do not wait for the guest to have relinquish the device.
>>> Or do they?
>>> How long do they wait?
>>
>> They wait for ever. And I guess we should do the same thing. If the
>> guest driver is broken (and this is really a rare scenario!) we would
>> not get the device back. Which is perfectly fine in my point of view. =
In
>> all other scenarios I guess the guest will simply respond in a timely
>> manner. And ripping out stuff from the guest always feels wrong. (yes
>> the channel subsystem works like that, but here we actually have a cho=
ice)
>>
>> If we reboot, we can unplug the device. Otherwise, let's keep it simpl=
y
>> and don't use a timer.
>>
>> Thanks!
>>
>=20
> AFAIK We have no plan to operate on pools of PCI devices so for me I=20
> have no objection to keep it simple:

Especially one note:

There seems to be demand for a so called "forced PCI removal" also on
other architectures. However, this would than rather most probably be
modeled on top of what we have right now.

E.g. instead of "device_del XXX" which would request the guest to let go
of the device, there could be something like "device_del XXX,forced=3Dtru=
e".

E.g. ask the guest. If it does not respond after some time, force remove
it. This is basically the timer, but managed by a different level, of
software. And you can than actually decide if you want to do eventually
harm to the guest OS.

Are there any other objects of getting rid of the timer?

Conny could pick up patch #1 once you get an ACK. I would send more
patches to drop the timer and rework this patch.

Thanks Pierre!

>=20
> Regards,
> Pierre
>=20
>=20
>=20


--=20

Thanks,

David / dhildenb
