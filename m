Received: from eggs.gnu.org ([2001:4830:134:3::10]:46192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dXMqg-0007tc-MG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dXMqb-00081z-Lj
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:23:14 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1dXMqb-00081Z-6v
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:23:09 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 12so15585180wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 00:23:08 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <06941EB3-4E1A-435D-869E-8FC9E5C46EE7@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Tue, 18 Jul 2017 10:23:06 +0300
In-Reply-To: <20170717195300-mutt-send-email-mst@kernel.org>
References: <20170716082917.720-1-dmitry@daynix.com>
	<09ea0b99-783f-263c-fd47-801c933fb398@redhat.com>
	<5FFD3164-EECD-4077-97DC-13924DEDFA61@daynix.com>
	<20170717195300-mutt-send-email-mst@kernel.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pci: honor PCI_COMMAND_MEMORY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Sameeh Jubran <sameeh@daynix.com>

On 17 Jul 2017, at 19:59 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Mon, Jul 17, 2017 at 03:48:03PM +0300, Dmitry Fleytman wrote:
>> Am I understand correctly that there are no special cases for
>> IDE controllers, i.e. bus master bit must be set by SW same
>> way as for other PCI devices?
>=20
> Bus mastering is typically enabled by the driver.
> E.g. under linux:
>=20
> static int virtio_pci_restore(struct device *dev)
> {
>        struct pci_dev *pci_dev =3D to_pci_dev(dev);
>        struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
>        int ret;
>=20
>        ret =3D pci_enable_device(pci_dev);
>        if (ret)
>                return ret;
>=20
>        pci_set_master(pci_dev);
>        return virtio_device_restore(&vp_dev->vdev);
> }
>=20
>=20
> As an exception, in case of BIOS booting using device ROM, it is set =
by
> the ROM. E.g. src/hw/virtio-pci.c:
>=20
>    vp_reset(vp);
>    pci_enable_busmaster(pci);
>    vp_set_status(vp, VIRTIO_CONFIG_S_ACKNOWLEDGE |
>                  VIRTIO_CONFIG_S_DRIVER );


Thanks, Michael.

After some more investigations, there are additional interesting =
details.

First of all, resume from hibernation succeeds without USB host =
controller (-usbtablet).

I did tracing of PCI configuration space writes and here is what I see:

=3D=3D=3D=3D=3D=3D=3D=3D=3D Booting with -usbtablet (piix3-usb-uhci) =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

++ pci_init_bus_master:93: i440FX, enabled: 0
++ pci_init_bus_master:93: PIIX3, enabled: 0
++ pci_init_bus_master:93: piix3-ide, enabled: 0
++ pci_init_bus_master:93: piix3-usb-uhci, enabled: 0
++ pci_init_bus_master:93: PIIX4_PM, enabled: 0
++ pci_init_bus_master:93: VGA, enabled: 0
++ pci_init_bus_master:93: e1000, enabled: 0

All devices start with bus master disabled

++ piix3_reset:121
++ pci_default_write_config:1363: i440FX, addr 4, val_in 259, l 2, =
enabled: 0
++ pci_default_write_config:1363: PIIX3, addr 4, val_in 259, l 2, =
enabled: 0
++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 259, l 2, =
enabled: 0

Guest writes 259 (2 bytes) to PCI_COMMAND, i.e. PCI_COMMAND_IO | =
PCI_COMMAND_MEMORY | PCI_COMMAND_SERR.
This way it effectively disables PCI_COMMAND_MASTER event if it was =
enabled from the beginning.

++ pci_default_write_config:1363: piix3-usb-uhci, addr 4, val_in 259, l =
2, enabled: 0
++ pci_default_write_config:1363: PIIX4_PM, addr 4, val_in 259, l 2, =
enabled: 0
++ pci_default_write_config:1363: VGA, addr 4, val_in 259, l 2, enabled: =
0
++ pci_default_write_config:1363: e1000, addr 4, val_in 259, l 2, =
enabled: 0
++ pci_default_write_config:1363: piix3-usb-uhci, addr 4, val_in 259, l =
2, enabled: 0
++ pci_default_write_config:1363: piix3-usb-uhci, addr 4, val_in 263, l =
2, enabled: 4

At the same time it enables PCI_COMMAND_MASTER for piix3-usb-uhci.
After that it does a bunch of sector reads without DMA and then switches =
to DMA mode and eventually crashes

=3D=3D=3D=3D=3D=3D=3D=3D=3D Booting without -usbtablet (piix3-usb-uhci) =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

++ pci_init_bus_master:93: i440FX, enabled: 0
++ pci_init_bus_master:93: PIIX3, enabled: 0
++ pci_init_bus_master:93: piix3-ide, enabled: 0
++ pci_init_bus_master:93: PIIX4_PM, enabled: 0
++ pci_init_bus_master:93: VGA, enabled: 0
++ pci_init_bus_master:93: e1000, enabled: 0

All devices start with bus master disabled

++ piix3_reset:121
++ pci_default_write_config:1363: i440FX, addr 4, val_in 259, l 2, =
enabled: 0
++ pci_default_write_config:1363: PIIX3, addr 4, val_in 259, l 2, =
enabled: 0
++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 259, l 2, =
enabled: 0
++ pci_default_write_config:1363: PIIX4_PM, addr 4, val_in 259, l 2, =
enabled: 0
++ pci_default_write_config:1363: VGA, addr 4, val_in 259, l 2, enabled: =
0
++ pci_default_write_config:1363: e1000, addr 4, val_in 259, l 2, =
enabled: 0

Again it writes 259 to PCI_COMMAND
After that it does a bunch of sector reads without DMA as before.

++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 1285, l 2, =
enabled: 4

And after that it enables PCI bus master on piix3-ide,
starts DMA transfers and SUCEEDS resume from hibernation

++ pci_default_write_config:1363: VGA, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: VGA, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: VGA, addr 4, val_in 1287, l 2, =
enabled: 4
++ pci_default_write_config:1363: e1000, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: e1000, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: e1000, addr 4, val_in 1287, l 2, =
enabled: 4
++ pci_default_write_config:1363: e1000, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: e1000, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: e1000, addr 4, val_in 1287, l 2, =
enabled: 4
++ pci_default_write_config:1363: e1000, addr 4, val_in 1287, l 2, =
enabled: 4
++ pci_default_write_config:1363: e1000, addr 4, val_in 263, l 2, =
enabled: 4
++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 1280, l 2, =
enabled: 0
++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 1285, l 2, =
enabled: 4
++ pci_default_write_config:1363: piix3-ide, addr 4, val_in 261, l 2, =
enabled: 4

It also enables bus master for all other devices at some point.

Do you have any idea for possible directions?

Regards,
Dmitry

>=20
>=20
> --=20
> MST
