Received: from eggs.gnu.org ([2001:4830:134:3::10]:44112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dT0ey-0001DX-Mq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dT0eu-0008Ph-PL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:53:08 -0400
Received: from chuckie.co.uk ([82.165.15.123]:53106
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dT0eu-0008LL-HW
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:53:04 -0400
References: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
	<8760f7fnot.fsf@dusky.pond.sub.org>
	<54df7dce-5108-40d4-e765-03137af3ad73@ilande.co.uk>
	<87fueanaxt.fsf@dusky.pond.sub.org>
	<70968a58-f3be-4fa1-aa4e-bbfd39520e09@ilande.co.uk>
	<87lgo2hi7u.fsf@dusky.pond.sub.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9a0a991a-cc01-58bb-277a-eac2639acde6@ilande.co.uk>
Date: Thu, 6 Jul 2017 07:52:41 +0100
MIME-Version: 1.0
In-Reply-To: <87lgo2hi7u.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 05/07/17 19:05, Markus Armbruster wrote:

>> It seems like limiting the size of the bus would solve the majority of
>> the problem. I've had a quick look around pci.c and while I can see that
>> the PCIBus creation functions take a devfn_min parameter, I can't see
>> anything that limits the number of slots available on the bus?
> 
> Marcel?
> 
>> And presumably if the user did try and coldplug something into a full
>> bus then they would get the standard "PCI: no slot/function
>> available..." error?
> 
> That's what I'd expect.
> 
>>>> My understanding from reading various bits of documentation is that the
>>>> the empty simba bridge (bus B) can hold a maximum of 4 devices, whilst
>>>> the non-empty simba bridge (bus A) can hold a maximum of 2 devices
>>>> (presumably due to the on-board hardware). And in order to make sure
>>>> OpenBIOS maps the PCI IO ranges correctly, the ebus must be the first
>>>> on-board device found during a PCI bus scan which means slot 0 on bus A
>>>> must be blacklisted.
>>>
>>> Assuming init() plugs in the device providing ebus: plug it into slot 0,
>>> mark it not hotpluggable, done.
>>
>> That is good solution in theory except that I'd like to keep the ebus in
>> slot 1 so that it matches the real DT as much as possible. In the future
>> it could be possible for people to boot using PROMs from a real Sun and
>> I'm not yet convinced that there aren't hardcoded references to some of
>> the onboard legacy devices in a real PROM.
> 
> Misunderstanding on my part!  You don't have to blacklist slot 0 to have
> the PCI core put ebus in slot 1.  Simply ask for slot 1 by passing
> PCI_DEVFN(1, 0) to pci_create() or similar.

Yes, I've managed to do that already. The issue is if a user tries to
add a device to bus A on the command line e.g. -device
virtio-blk-pci,bus=pciA then it appears that the QEMU code iterates over
the slots in order to find the first free slot, finds slot 0 and then
plugs it in before the ebus which breaks OpenBIOS :(

>>>> I guess what I'm looking for is some kind of hook that runs after both
>>>> machine init and all the devices have been specified on the command
>>>> line, which I can use to validate the configuration and provide a
>>>> suitable error message/hint if the configuration is invalid?
>>>
>>> You should be able to construct the machine you want, and protect the
>>> parts the user shouldn't mess with from messing users.  No need to
>>> validate the mess afterwards then.
>>
>> Unfortunately there would be issues if the user was allowed to construct
>> a machine with more PCI devices than slots in real hardware, since the
>> PCI interrupt number is limited to 4 bits - 2 bits for the PCI interrupt
>> number (A to D), and 2 bits for the slot. So if a user tries to plug in
>> more than 4 devices into each simba bus then the interrupts won't be
>> mapped correctly.
>>
>> My feeling is that it makes more sense to error out if the user tries to
>> add too many devices to the bus and/or in the wrong slots rather than
>> let them carry on and wonder why the virtual devices don't work
>> correctly, but I'm open to other options.
> 
> My advice is to model the physical hardware faithfully.  If it has four
> PCI slots on a certain PCI bus, provide exactly four.  If it has onboard
> devices hardwired into a certain slot, put them exactly there, and
> disable unplug.  Make it impossible to plug too many devices into a bus,
> or into the wrong slots.

Agreed. My plan in terms of a migration strategy for existing users was
to say something along the lines of "just add bus=pciB to your -device
command line arguments" which isn't too bad, although there are people
who use a lot of legacy command line options for convenience. But that's
not insurmountable as I can write a guide on the wiki.

For my busA example above though, the only way I can see this working is
if a devfn bitmask can be specified as an optional PCIBus property to
control which slots/functions are available on the bus for hot-plugging
and cold-plugging PCI devices.


ATB,

Mark.
