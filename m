Received: from eggs.gnu.org ([2001:4830:134:3::10]:43432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSmVs-0002j8-JZ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSmVp-0002gw-EU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dSmVp-0002gI-5C
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:46:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
	<8760f7fnot.fsf@dusky.pond.sub.org>
	<54df7dce-5108-40d4-e765-03137af3ad73@ilande.co.uk>
Date: Wed, 05 Jul 2017 17:46:38 +0200
In-Reply-To: <54df7dce-5108-40d4-e765-03137af3ad73@ilande.co.uk> (Mark
	Cave-Ayland's message of "Wed, 5 Jul 2017 13:58:57 +0100")
Message-ID: <87fueanaxt.fsf@dusky.pond.sub.org>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 05/07/17 06:38, Markus Armbruster wrote:
>
>> Copying Marcel for PCI expertise.
>> 
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>> 
>>> Hi all,
>>>
>>> I've been working on a patchset that brings the sun4u machine on
>>> qemu-system-sparc64 much closer to a real Ultra 5, however due to
>>> various design restrictions I need to be able to restrict how devices
>>> are added to the machine with -device.
>>>
>>> On a real Ultra 5, the root PCI bus (sabre) has 2 PCI bridges (simba A
>>> and simba B) with the onboard devices attached to simba A with 2 free
>>> slots, and an initially empty simba B.
>>>
>>> Firstly, is it possible to restrict the machine so that devices cannot
>>> be directly plugged into the root PCI bus, but only behind one of the
>>> PCI bridges? There is also an additional restriction in that slot 0
>>> behind simba A must be left empty to ensure that the ebus (containing
>>> the onboard devices) is the first device allocated.
>> 
>> I figure sabre, simba A, simba B and the onboard devices attached to
>> simba A are all created by MachineClass init().
>
> Yes that is effectively correct, although the Simba devices are created
> as part of the PCI host bridge (apb) creation in pci_apb_init().

Anything that runs within init() counts as "created by init()".

>> What device provides "the ebus", and how is it created?
>
> It's actually just an ISA bus, so the ebus device is effectively a
> PCI-ISA bridge for legacy devices.

Is this bridge created by init()?

>> Can you provide a list of all onboard PCI devices and how they are
>> connected?  Diagram would be best.
>
> I can try and come up with something more concise later, however I can
> quickly give you the OpenBIOS DT from my WIP patchset if that helps:
>
> 0 > show-devs
> ffe1bf38 /
> ffe1c110 /aliases
> ffe1c238 /openprom (BootROM)
> ffe26b50 /openprom/client-services
> ffe1c4f0 /options
> ffe1c5d0 /chosen
> ffe1c710 /builtin
> ffe1c838 /builtin/console
> ffe26618 /packages
> ffe28640 /packages/cmdline
> ffe28890 /packages/disk-label
> ffe2c8d8 /packages/deblocker
> ffe2cef0 /packages/grubfs-files
> ffe2d300 /packages/sun-parts
> ffe2d718 /packages/elf-loader
> ffe2b210 /memory@0,0 (memory)
> ffe2b370 /virtual-memory
> ffe2d878 /pci@1fe,0 (pci)
> ffe2e1a8 /pci@1fe,0/pci@1,1 (pci)
> ffe2e960 /pci@1fe,0/pci@1,1/ebus@1
> ffe2f1b0 /pci@1fe,0/pci@1,1/ebus@1/eeprom@0
> ffe2f328 /pci@1fe,0/pci@1,1/ebus@1/fdthree@0 (block)
> ffe2f878 /pci@1fe,0/pci@1,1/ebus@1/su@0 (serial)
> ffe2fc08 /pci@1fe,0/pci@1,1/ebus@1/8042@0 (8042)
> ffe2fe00 /pci@1fe,0/pci@1,1/ebus@1/8042@0/kb_ps2@0 (serial)
> ffe301b0 /pci@1fe,0/pci@1,1/NE2000@1,1 (network)
> ffe307c8 /pci@1fe,0/pci@1,1/QEMU,VGA@2 (display)
> ffe31e40 /pci@1fe,0/pci@1,1/ide@3 (ide)
> ffe32398 /pci@1fe,0/pci@1,1/ide@3/ide0@4100 (ide)
> ffe32678 /pci@1fe,0/pci@1,1/ide@3/ide1@4200 (ide)
> ffe32910 /pci@1fe,0/pci@1,1/ide@3/ide1@4200/cdrom@0 (block)
> ffe32f98 /pci@1fe,0/pci@1 (pci)
> ffe336e8 /SUNW,UltraSPARC-IIi (cpu)
>  ok
>
> For comparison you can see the DT from a real Ultra 5 here:
> http://www.pearsonitcertification.com/articles/article.aspx?p=440286&seqNum=7
>
>> The real sabre has two slots, and doesn't support hot (un)plug.  Can we
>> simply model that?  If yes, the root PCI bus is full after init(), and
>> remains full.  Takes care of "cannot directly plugged into the root PCI
>> bus".
>
> Right. So what you're saying is that if we add the 2 simba devices to
> the sabre PCI host bridge during machine init and then mark the sabre
> PCI root bus as not hotplug-able then that will prevent people adding
> extra devices from the command line via -device? I will see if I can
> find time to try this later this evening.

No.  Marking the bus "not hotpluggable" only prevents *hotplug*,
i.e. plug/unplug after machine initialization completed, commonly with
device_add.  -device is *cold* plug; it happens during machine
initialization.

However, if you limit sabre's bus to two slots (modelling real hardware
faithfully), then you can't cold plug anything (there's no free slot).
If you additionally mark the bus or both simba devices not hotpluggable
(again modelling real hardware faithfully), you can't unplug the simbas.
I believe that's what you want.

> My understanding from reading various bits of documentation is that the
> the empty simba bridge (bus B) can hold a maximum of 4 devices, whilst
> the non-empty simba bridge (bus A) can hold a maximum of 2 devices
> (presumably due to the on-board hardware). And in order to make sure
> OpenBIOS maps the PCI IO ranges correctly, the ebus must be the first
> on-board device found during a PCI bus scan which means slot 0 on bus A
> must be blacklisted.

Assuming init() plugs in the device providing ebus: plug it into slot 0,
mark it not hotpluggable, done.

> I guess what I'm looking for is some kind of hook that runs after both
> machine init and all the devices have been specified on the command
> line, which I can use to validate the configuration and provide a
> suitable error message/hint if the configuration is invalid?

You should be able to construct the machine you want, and protect the
parts the user shouldn't mess with from messing users.  No need to
validate the mess afterwards then.
