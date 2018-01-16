Received: from eggs.gnu.org ([2001:4830:134:3::10]:59757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ebXSA-0006QD-0g
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ebXS4-0006Gj-DR
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:03:26 -0500
Received: from chuckie.co.uk ([82.165.15.123]:51138
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ebXS4-0006G1-7C
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:03:20 -0500
References: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
	<b706db4f-b103-9433-9973-762c7c594005@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e60bf4f3-37cf-6924-4375-83524ad1e191@ilande.co.uk>
Date: Tue, 16 Jan 2018 20:03:10 +0000
MIME-Version: 1.0
In-Reply-To: <b706db4f-b103-9433-9973-762c7c594005@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sun4u: implement power device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, atar4qemu@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org

On 16/01/18 00:54, Philippe Mathieu-Daudé wrote:

> CC'ing PCI maintainers.
> 
> Hi Mark,
> 
> On 01/15/2018 05:58 PM, Mark Cave-Ayland wrote:
>> This inbuilt device contains a single 4-byte register, of which bit 24 is used
>> to power down the machine on a real Ultra 5.
>>
>> The power device exists at offset 0x724000 on a real machine, but due to the
>> current configuration of the BARs in QEMU it must be located lower in PCI IO
>> space.
> Is is some issue in pci_bar_address()?

Hi Philippe,

It's not an issue with QEMU at all, more the way in which the on-board 
devices are mapped. From memory there are 3 different issues with the 
current setup:

- OpenBIOS uses PCI IO space accesses for all its drivers

In a real Ultra 5 the on-board devices are behind a memory BAR but 
everything in OpenBIOS is hard-coded to use IO accesses. Changing that 
will be fairly hard.

- Some OSs use the ebus BAR to access the onboard devices, others use 
the direct physical accesses

This means that the ebus BAR has to be located at address zero (even 
though its in slot 1) for both accesses to work. The first part of PCI 
IO space containing the ebus is then aliased back onto its physical 
address to make everything consistent.

- Linux sabre fix-up bug

Potentially this could be fixed by increasing the base physical address 
of the simba IO space, however Linux has a fixup routine for this 
particular PCI host bridge and this has a bug which means that it 
presumes the lower word of the address is 0 (like a real Ultra 5) rather 
than reading it from the DT.

Therefore whilst moving the base of PCI IO space within the physical 
address space should work, due to this bug the PCI addresses are 
converted incorrectly from physical addresses causing a panic.

>> For the moment we place the power device at offset 0x7240 as a reminder of its
>> original location and raise the base PCI IO address from 0x4000 to 0x8000.
> 
> If we can't fix it, I rather prefer a #define with a comment in the
> code, IMHO this is safer and easier to remember than looking in git history.

Well TBH just about all of the current devices for sun4u are either 
incorrect or located at the wrong address, and could possibly change 
later if required for Solaris compatibility. So while things are still 
quite fluid, I'm more inclined to leave them as hard-coded offsets 
(similarly in OpenBIOS) until things become more clear.


ATB,

Mark.
