Received: from eggs.gnu.org ([2001:4830:134:3::10]:59641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cOXiA-0008MX-7K
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 17:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cOXi7-0001Xm-2E
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 17:37:42 -0500
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<1483049536-21548-3-git-send-email-hpoussin@reactos.org>
	<20170102230212.GF12761@umbus.fritz.box>
Message-ID: <38325f34-9511-bb4e-2224-097bd9a88d7e@reactos.org>
Date: Tue, 3 Jan 2017 23:37:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170102230212.GF12761@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] vga: increase priority of 0xa0000
 memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>

Le 03/01/2017 =E0 00:02, David Gibson a =E9crit :
> On Thu, Dec 29, 2016 at 11:12:12PM +0100, Herv=E9 Poussineau wrote:
>> VGA device registers vram as BAR 0. If this BAR is activated as a very=
 low address which
>> crosses 0xa0000-0xbffff, low memory region is not accessible anymore.
>>
>> This fixes display on PReP machine if we enable PCI mapping at
>> address 0.
>
> This commit message needs more information.  What exactly is the VGA
> BAR colliding with?  Why does the other thing have higher priority?
> Why is it safe for the VGA BAR to override the other thing?  Why is
> this safe on all platforms?

VGA has (basically) two memory regions:
- the legacy one, from 0xa0000 to 0xbffff
- a memory region describing the whole VRAM, configurable with PCI BAR 0.

In QEMU, mapping PCI at address 0 is not permitted (MachineClass->pci_all=
ow_0_address is false by default),
except on arm/virt and ppc/spapr. So, this is usually not a problem as al=
l PCI BARs (including video PCI BAR 0) are not mapped at
address 0, and so both memory regions can't collide.

When trying Linux on ppc/40p (introduced later in this patchset), I saw t=
hat Linux assigns
PCI BAR addresses in the order of PCI devices detection, and VGA PCI BAR =
0 ends up at address 0.
However, Linux assumes that 0xa0000-0xbffff is still available to drive t=
he VGA card in text mode.
Without changing the region priority, VGA output is garbled (as writes di=
rectly go to VGA memory).
When increasing the region priority, VGA output is restored (as writes go=
 to legacy address space).

arm/virt by default doesn't have a PCI VGA card.
ppc/spapr may probably have the same problem as ppc/40p. However, as VGA =
PCI BAR 0 and VGA legacy space
both have a priority of 1, it may probably have a problem. I only need to=
 convince Linux to use address 0 for VGA PCI BAR.

Herv=E9

>
>> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
>> ---
>>  hw/display/vga.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/vga.c b/hw/display/vga.c
>> index 2a88b3c..c573f35 100644
>> --- a/hw/display/vga.c
>> +++ b/hw/display/vga.c
>> @@ -2265,7 +2265,7 @@ void vga_init(VGACommonState *s, Object *obj, Me=
moryRegion *address_space,
>>      memory_region_add_subregion_overlap(address_space,
>>                                          0x000a0000,
>>                                          vga_io_memory,
>> -                                        1);
>> +                                        2);
>>      memory_region_set_coalescing(vga_io_memory);
>>      if (init_vga_ports) {
>>          portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga")=
;
>
