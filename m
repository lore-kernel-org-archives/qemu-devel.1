Received: from eggs.gnu.org ([2001:4830:134:3::10]:45872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT7u2-0000H9-31
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT7ty-0006VC-0Z
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT7tx-0006Ue-NS
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:37:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
	<8760f7fnot.fsf@dusky.pond.sub.org>
	<54df7dce-5108-40d4-e765-03137af3ad73@ilande.co.uk>
	<87fueanaxt.fsf@dusky.pond.sub.org>
	<70968a58-f3be-4fa1-aa4e-bbfd39520e09@ilande.co.uk>
	<87lgo2hi7u.fsf@dusky.pond.sub.org>
	<7c78b873-1d97-f7ef-395b-21d6f7e8634a@redhat.com>
	<87podd4xjc.fsf@dusky.pond.sub.org>
	<b54c8d3c-bfb5-1a85-ef35-8a33e4893464@redhat.com>
Date: Thu, 06 Jul 2017 16:36:58 +0200
In-Reply-To: <b54c8d3c-bfb5-1a85-ef35-8a33e4893464@redhat.com> (Marcel
	Apfelbaum's message of "Thu, 6 Jul 2017 15:28:48 +0300")
Message-ID: <87d19diqd1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Managing architectural restrictions with -device
 and libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>

Marcel Apfelbaum <marcel@redhat.com> writes:

> On 06/07/2017 14:25, Markus Armbruster wrote:
>> Marcel Apfelbaum <marcel@redhat.com> writes:
>>
>>> On 05/07/2017 21:05, Markus Armbruster wrote:
>>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>> [...]
>>>>> It seems like limiting the size of the bus would solve the majority of
>>>>> the problem. I've had a quick look around pci.c and while I can see that
>>>>> the PCIBus creation functions take a devfn_min parameter, I can't see
>>>>> anything that limits the number of slots available on the bus?
>>>>
>>>> Marcel?
>>>>
>>>
>>> Hi Markus,
>>> Sorry for my late reply.
>>>
>>> Indeed, we don't have currently a restriction on the number of usable
>>> slots on a bus, however deriving from PCIBus class and implementing
>>> the new policy should not be much trouble.
>>>
>>>
>>>>> And presumably if the user did try and coldplug something into a full
>>>>> bus then they would get the standard "PCI: no slot/function
>>>>> available..." error?
>>>>
>>>> That's what I'd expect.
>>>>
>>>>>>> My understanding from reading various bits of documentation is that the
>>>>>>> the empty simba bridge (bus B) can hold a maximum of 4 devices, whilst
>>>>>>> the non-empty simba bridge (bus A) can hold a maximum of 2 devices
>>>>>>> (presumably due to the on-board hardware). And in order to make sure
>>>>>>> OpenBIOS maps the PCI IO ranges correctly, the ebus must be the first
>>>>>>> on-board device found during a PCI bus scan which means slot 0 on bus A
>>>>>>> must be blacklisted.
>>>>>>
>>>>>> Assuming init() plugs in the device providing ebus: plug it into slot 0,
>>>>>> mark it not hotpluggable, done.
>>>>>
>>>>> That is good solution in theory except that I'd like to keep the ebus in
>>>>> slot 1 so that it matches the real DT as much as possible. In the future
>>>>> it could be possible for people to boot using PROMs from a real Sun and
>>>>> I'm not yet convinced that there aren't hardcoded references to some of
>>>>> the onboard legacy devices in a real PROM.
>>>>
>>>> Misunderstanding on my part!  You don't have to blacklist slot 0 to have
>>>> the PCI core put ebus in slot 1.  Simply ask for slot 1 by passing
>>>> PCI_DEVFN(1, 0) to pci_create() or similar.
>>>>
>>>
>
> Hi Markus,
>
>>> Right, hard-coding the device creation in machine init will solve that,
>>> however it will be against our long-term goal to create the machine as
>>> a puzzle, and for that, the devices should be created in some
>>> order. I suspect the task would not be easy to integrate as
>>> part of this project though.
>>
>> Even in a world where we start with an empty board, then plug in stuff
>> directed by configuration file, an onboard device's PCI address should
>> be explicit.  Having to count PCI devices to figure out their address
>> sucks.
>>
>
> You are right, but this is not what I meant.
> We have devices created from command line and devices "built-in".
>
> Instead of manually/ad-hoc adding the devices wherever fits,
> have two lists of devices, one from command line and one
> per machine type (code or config file).
> The init function should order them and take into account
> addresses, of course.

The board needs to be created first, so that when the user's additional
devices clash with the board's, we get decent error messages.  In that
sense, order matters.

We got sidetracked a bit, this stuff is unlikely to be of interest to
Mark :)

>>>>>>> I guess what I'm looking for is some kind of hook that runs after both
>>>>>>> machine init and all the devices have been specified on the command
>>>>>>> line, which I can use to validate the configuration and provide a
>>>>>>> suitable error message/hint if the configuration is invalid?
>>>>>>
>>>>>> You should be able to construct the machine you want, and protect the
>>>>>> parts the user shouldn't mess with from messing users.  No need to
>>>>>> validate the mess afterwards then.
>>>>>
>>>>> Unfortunately there would be issues if the user was allowed to construct
>>>>> a machine with more PCI devices than slots in real hardware, since the
>>>>> PCI interrupt number is limited to 4 bits - 2 bits for the PCI interrupt
>>>>> number (A to D), and 2 bits for the slot. So if a user tries to plug in
>>>>> more than 4 devices into each simba bus then the interrupts won't be
>>>>> mapped correctly.
>>>>>
>>>>> My feeling is that it makes more sense to error out if the user tries to
>>>>> add too many devices to the bus and/or in the wrong slots rather than
>>>>> let them carry on and wonder why the virtual devices don't work
>>>>> correctly, but I'm open to other options.
>>>>
>>>> My advice is to model the physical hardware faithfully.  If it has four
>>>> PCI slots on a certain PCI bus, provide exactly four.  If it has onboard
>>>> devices hardwired into a certain slot, put them exactly there, and
>>>> disable unplug.  Make it impossible to plug too many devices into a bus,
>>>> or into the wrong slots.
>>>>
>>>
>>> I agree, but still the user will see an error. However the error would
>>> be "slot x does not exist" which is clean.
>>>
>>>
>>> I see two ways to continue:
>>>   1. A new kind of pci-bridge should be created with a "special"
>>>      secondary bus that has less slots. (harder to implement)
>>>   2. Add the limitation of the number of slots to the PCIBus class,
>>>      (simpler to implement, but since is not a widely used case maybe
>>>      is not the best way to go.
>>
>> I suspect (2) would be trivial.  I like trivial.
>
> I also like trivial, what might not be trivial is to convince Michael
> a base PCIBus class needs a property that limits the number of slots.
> But since the device registration code is generic, we may need that
> property anyway.
>
> Taking the idea a little farther, instead of limiting the slots number,
> we can have a slot-available flag for each slot. In this way we can
> cover more future requirements like "slot #5 is not never used".

That's strictly more general, and should still be trivial.
