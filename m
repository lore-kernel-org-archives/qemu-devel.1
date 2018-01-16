Received: from eggs.gnu.org ([2001:4830:134:3::10]:60197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ebXU3-0007PM-TV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ebXU0-0007If-8q
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:05:23 -0500
Received: from chuckie.co.uk ([82.165.15.123]:51213
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ebXU0-0007IT-1p
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:05:20 -0500
References: <20180115205848.26027-1-mark.cave-ayland@ilande.co.uk>
	<b706db4f-b103-9433-9973-762c7c594005@amsat.org>
	<3012b56d-9242-47ee-eb58-530080ba8c43@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f59cf77f-e796-19a7-148f-d91fbd09b9b8@ilande.co.uk>
Date: Tue, 16 Jan 2018 20:05:11 +0000
MIME-Version: 1.0
In-Reply-To: <3012b56d-9242-47ee-eb58-530080ba8c43@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, atar4qemu@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On 16/01/18 14:23, Marcel Apfelbaum wrote:

> Hi Philippe,
> 
> On 16/01/2018 2:54, Philippe Mathieu-Daudé wrote:
>> CC'ing PCI maintainers.
>>
>> Hi Mark,
>>
>> On 01/15/2018 05:58 PM, Mark Cave-Ayland wrote:
>>> This inbuilt device contains a single 4-byte register, of which bit 
>>> 24 is used
>>> to power down the machine on a real Ultra 5.
>>>
>>> The power device exists at offset 0x724000 on a real machine, but due 
>>> to the
>>> current configuration of the BARs in QEMU it must be located lower in 
>>> PCI IO
>>> space.
>> Is is some issue in pci_bar_address()?
>>
> 
> The QEMU IO layout:
> 
>      /*
>       * QEMU I/O address space usage:
>       *   0000 - 0fff    legacy isa, pci config, pci root bus, ...
>       *   1000 - 9fff    free
>       *   a000 - afff    hotplug (cpu, pci via acpi, i440fx/piix only)
>       *   b000 - bfff    power management (PORT_ACPI_PM_BASE)
>       *                  [ qemu 1.4+ implements pci config registers
>       *                    properly so guests can place the registers
>       *                    where they want, on older versions its fixed ]
>       *   c000 - ffff    free, traditionally used for pci io
>       */
> 
> As you can see we don't have IO address space over ffff.

Well that's not actually quite true - we use a separate ebus address 
space for the onboard devices (and that does have 32-bit PCI IO accesses 
enabled), but the issue here is one of the sun4u PCI host/onboard device 
configuration rather than anything to do with QEMU.


ATB,

Mark.
