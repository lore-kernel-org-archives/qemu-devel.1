Received: from eggs.gnu.org ([2001:4830:134:3::10]:51961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbAn4-0000NJ-Li
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fbAn1-0005b2-CF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:23:46 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:36542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fbAn1-0005Zi-1o
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:23:43 -0400
Received: from player730.ha.ovh.net (unknown [10.109.120.75])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 21B13169482
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 22:23:41 +0200 (CEST)
References: <20180705181148.26871-1-clg@kaod.org>
	<20180705220402-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d05d1c86-7a40-3d17-8e28-1150fb73b378@kaod.org>
Date: Thu, 5 Jul 2018 22:23:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180705220402-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pci: remove pci_del_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 07/05/2018 09:11 PM, Michael S. Tsirkin wrote:
> On Thu, Jul 05, 2018 at 08:11:48PM +0200, C=C3=A9dric Le Goater wrote:
>> PCI devices needing a ROM allocate an optional MemoryRegion with
>> pci_add_option_rom(). pci_del_option_rom() does the cleanup when the
>> device is destroyed. The only action taken by this routine is to call
>> vmstate_unregister_ram() which clears the id string of the optional
>> ROM RAMBlock and now, also flags the RAMBlock as non-migratable. This
>> was recently added by commit b895de502717 ("migration: discard
>> non-migratable RAMBlocks"), .
>>
>> VFIO devices do their own allocation of the PCI ROM region. It is
>> initialized in vfio_pci_size_rom() in which the PCI attribute
>> 'has_rom' is set to true but the RAMBlock of the ROM region is not
>> allocated. When the associated PCI device is deleted,
>> pci_del_option_rom() calls vmstate_unregister_ram() which tries to
>> flag a NULL RAMBlock because 'has_rom' is set, leading to a SEGV .
>>
>> The use of vmstate_unregister_ram() in the PCI device was added in
>> commit b0e56e0b63f350691b52d3e75e89bb64143fbeff ("unset RAMBlock idstr
>> when unregister MemoryRegion")
>=20
> I don't see it in that commit. I think it was part of the original
> split by Avi.

ok. That was pointed out to me by Paolo. It is hard to track all
the changes.

>> and from the archive in
>> http://lists.gnu.org/archive/html/qemu-devel/2014-04/msg00282.html, it
>> seems that it was trying to fix a reference count issue.
>>
>> vmstate_unregister_ram() being a work around, let's remove it to fix
>> the current SEGV issue
>> and let's try to find a fix for the initial ref
>> count issue if we can reproduce.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> What kind of testing did you do on this patch? Could you include
> that info in the commit log pls?
>=20
> I think you need to at least add/remove some devices, then migrate.

ok, for next round. I plugged/unplugged a :

	0034:01:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [=
ConnectX-4 Lx]

and then migrated.

Here is the original segv backtrace:

 I caught this bug while deleting a passthrough device from a pseries
 machine. Here is the stack:
  =20
   #0  qemu_ram_unset_migratable (rb=3D0x0) at /home/legoater/work/qemu/q=
emu-xive-3.0.git/exec.c:1994
   #1  0x000000010072def0 in vmstate_unregister_ram (mr=3D0x101796af0, de=
v=3D<optimized out>)
   #2  0x0000000100694e5c in pci_del_option_rom (pdev=3D0x101796330)
   #3  pci_qdev_unrealize (dev=3D<optimized out>, errp=3D<optimized out>)
   #4  0x00000001005ff910 in device_set_realized (obj=3D0x101796330, valu=
e=3D<optimized out>, errp=3D0x0)
   #5  0x00000001007a487c in property_set_bool (obj=3D0x101796330, v=3D<o=
ptimized out>, name=3D<optimized out>,=20
   #6  0x00000001007a7878 in object_property_set (obj=3D0x101796330, v=3D=
0x7fff70033110,=20
   #7  0x00000001007aaf1c in object_property_set_qobject (obj=3D0x1017963=
30, value=3D<optimized out>,=20
   #8  0x00000001007a7b90 in object_property_set_bool (obj=3D0x101796330,=
 value=3D<optimized out>,=20
   #9  0x00000001005fcdd8 in device_unparent (obj=3D0x101796330)
   #10 0x00000001007a6dd0 in object_finalize_child_property (obj=3D<optim=
ized out>, name=3D<optimized out>,=20
   #11 0x00000001007a50c0 in object_property_del_child (obj=3D0x10111f800=
, child=3D0x101796330,=20
   #12 0x0000000100425cc0 in spapr_phb_remove_pci_device_cb (dev=3D0x1017=
96330)
   #13 0x0000000100427974 in spapr_drc_release (drc=3D0x1017e2df0)
   #14 0x0000000100429098 in spapr_drc_detach (drc=3D0x1017e2df0)
   #15 0x00000001004294e0 in drc_isolate_physical (drc=3D0x1017e2df0)
   #16 0x000000010042a50c in rtas_set_isolation_state (state=3D0, idx=3D<=
optimized out>)

C.=20

>=20
>> ---
>>  hw/pci/pci.c | 11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 80bc45930dee..78bf74e19f22 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -191,7 +191,6 @@ static PCIBus *pci_find_bus_nr(PCIBus *bus, int bu=
s_num);
>>  static void pci_update_mappings(PCIDevice *d);
>>  static void pci_irq_handler(void *opaque, int irq_num, int level);
>>  static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom, =
Error **);
>> -static void pci_del_option_rom(PCIDevice *pdev);
>> =20
>>  static uint16_t pci_default_sub_vendor_id =3D PCI_SUBVENDOR_ID_REDHAT=
_QUMRANET;
>>  static uint16_t pci_default_sub_device_id =3D PCI_SUBDEVICE_ID_QEMU;
>> @@ -1096,7 +1095,6 @@ static void pci_qdev_unrealize(DeviceState *dev,=
 Error **errp)
>>      PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(pci_dev);
>> =20
>>      pci_unregister_io_regions(pci_dev);
>> -    pci_del_option_rom(pci_dev);
>> =20
>>      if (pc->exit) {
>>          pc->exit(pci_dev);
>> @@ -2262,15 +2260,6 @@ static void pci_add_option_rom(PCIDevice *pdev,=
 bool is_default_rom,
>>      pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
>>  }
>> =20
>> -static void pci_del_option_rom(PCIDevice *pdev)
>> -{
>> -    if (!pdev->has_rom)
>> -        return;
>> -
>> -    vmstate_unregister_ram(&pdev->rom, &pdev->qdev);
>> -    pdev->has_rom =3D false;
>> -}
>> -
>>  /*
>>   * On success, pci_add_capability() returns a positive value
>>   * that the offset of the pci capability.
>> --=20
>> 2.13.6
