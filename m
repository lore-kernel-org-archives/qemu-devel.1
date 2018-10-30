Received: from eggs.gnu.org ([2001:4830:134:3::10]:36009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHW8O-0007bX-Uk
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHW8J-0001kE-Ge
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:40:48 -0400
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
	<20181016155600.31de8883@redhat.com>
	<9d503a8b-5847-a1ae-2d2c-a2d1f0e7ac95@redhat.com>
	<20181030161552.073b6f6a@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e05f722e-b1ca-8f91-54ba-1b2c3103bc4f@redhat.com>
Date: Tue, 30 Oct 2018 16:40:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181030161552.073b6f6a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] call HotplugHandler->plug()
 as the last step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 30.10.18 16:15, Igor Mammedov wrote:
> On Wed, 24 Oct 2018 15:09:36 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 16.10.18 15:56, Igor Mammedov wrote:
>>> On Tue, 16 Oct 2018 15:33:40 +0200
>>> Igor Mammedov <imammedo@redhat.com> wrote:
>>>  =20
>>>> When [2] was fixed it was agreed that adding and calling post_plug()
>>>> callback after device_reset() was low risk approach to hotfix issue
>>>> right before release. So it was merged instead of moving already
>>>> existing plug() callback after device_reset() is called which would
>>>> be more risky and require all plug() callbacks audit.
>>>>
>>>> Looking at the current plug() callbacks, it doesn't seem that moving
>>>> plug() callback after device_reset() is breaking anything, so here
>>>> goes agreed upon [3] proper fix which essentially reverts [1][2]
>>>> and moves plug() callback after device_reset().
>>>> This way devices always comes to plug() stage, after it's been fully
>>>> initialized (including being reset), which fixes race condition [2]
>>>> without need for an extra post_plug() callback.
>>>>
>>>>  1. (25e897881 "qdev: add HotplugHandler->post_plug() callback")
>>>>  2. (8449bcf94 "virtio-scsi: fix hotplug ->reset() vs event race")
>>>>  3. https://www.mail-archive.com/qemu-devel@nongnu.org/msg549915.htm=
l
>>>>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>> TODO:
>>>>  remove usage of Error** from plug() callback, we need to factor out
>>>>  pre_plug part from plug() callbacks, before proceeding with it.
>>>>  DavidH has recently finished it for pc-dimm/memory_devices, cpus
>>>>  mostly have pre_plug parts factored out, but there still are parts
>>>>  that could fail so it needs some more work to eliminate failure poi=
nts
>>>>  from plug() callbacks. Meanwhile, I'll plan to treat other misc
>>>>  handlers (pci[e]/acpi/usb/...) and introduce pre_plug() where
>>>>  necessary. =20
>>
>> Saw this mail just now. I guess we should do more. Especially what see=
ms
>> to be fragile is errors during unrealize() and unplug().
>>
>> Errors during unplug() should only ever happen if it was not triggered
>> via unplug_request(). Otherwise, unplug_request() should check for all
>> possible errors and unplug() will not result in errors.
> Not sure that I read it right, I see 2 cases:
>  1: unplug_request =3D=3D NULL (i.e. where surprise device removal is s=
upported)
>      should not fail

So for now, we should not report errors.

>  2: unplug_request !=3D NULL && unplug() is called by guest side, it's =
caller
>     policy to decide what to do on failure. One use case is NOP, i.e. c=
aller
>     should not destroy object if unplug() fails and unplug() should fai=
l without
>     side effects, and possibly notify guest about it if such mechanism =
is supported.
>     Could be tricky to handle errors in case of chained handlers.
My assumption would be that unplug_request() performs all necessary
checks and triggers the guest.

The guest action should eventually result in an unplug(), which should
in my opinion also never fail. The code calling into unplug() should
perform checks if the guest is actually doing something sane and/or
something that was actually requested.

Right now I am not sure if unplug() should be allowed to fail at all.
Maybe I am missing once piece.

Chained handlers for memory devices should not be a problem as far as I
can see.

>=20
>=20
>> Also, errors during unrealize() should definitely be avoided. Or even
>> forbidden. E.g. looking at hw/core/qdev.c:device_set_realized,
>>
>> 1. failing to unrealize might already have resulted in the unplug
>> handler getting called.
>> 2. will result in a unparent of the device and therefore removal
>> 3. will have already eventually unrealized child devices or buses.
>>
>> To summarize, failing in unrealize() is a bad idea and might leave the
>> rest of the system in a very unpredictable state.
> failure path isn't really usable here, I'd assume that initial idea
> was that unrealize() could fail cleanly and let caller to decide on
> what to do. But with child bus handling and co it won't really work.

Exactly, we should maybe clean that up. It seems to easy for people that
implement devices to just stop unplug by trying to fail unrealize(). But
it will break things.

>=20
> BTW what devices are the users of DeviceState::child_bus,
> I don't think that we have any composite devices that actually
> exercise realize() part of it and maybe unrealize() part.

For unrealize(): This should be called for all virtio proxy devices to
unrealize the child virtio device. So recursive unrealize is in place.

For realize(): Not really used yet. See the comment in
bus_set_realized() on realize part: "TODO: recursive realization".
That's why e.g. virtio proxy devices explicitly trigger "realize=3Dtrue"
for the child on device realization.

I remember Andreas used to work on this a long time ago but we never
completed it.


--=20

Thanks,

David / dhildenb
