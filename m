Received: from eggs.gnu.org ([2001:4830:134:3::10]:58834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1egNgT-0001f9-0f
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1egNgO-0004j7-QG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:38:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1egNgO-0004io-I7
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 23:38:08 -0500
Date: Mon, 29 Jan 2018 21:38:03 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180129213803.0553a7c9@w520.home>
In-Reply-To: <e68d0f7f-b942-3452-0771-578bdfb1b276@amsat.org>
References: <20180129202326.9417.71344.stgit@gimli.home>
	<e68d0f7f-b942-3452-0771-578bdfb1b276@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Add option to disable GeForce
 quirks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On Tue, 30 Jan 2018 00:46:38 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Alex,
>=20
> On 01/29/2018 05:23 PM, Alex Williamson wrote:
> > These quirks are necessary for GeForce, but not for Quadro/GRID/Tesla
> > assignment.  Leaving them enabled is fully functional and provides the
> > most compatibility, but due to the unique NVIDIA MSI ACK behavior[1],
> > it also introduces latency in re-triggering the MSI interrupt.  This
> > overhead is typically negligible, but has been shown to adversely
> > affect some (very) high interrupt rate applications.  This adds the
> > vfio-pci device option "x-no-geforce-quirks=3D" which can be set to
> > "on" to disable this additional overhead.
> >=20
> > A follow-on optimization for GeForce might be to make use of an
> > ioeventfd to allow KVM to trigger an irqfd in the kernel vfio-pci
> > driver, avoiding the bounce through userspace to handle this device
> > write.
> >=20
> > [1] Background: the NVIDIA driver has been observed to write 0xff to
> > the read-only MSI capability ID register via the MMIO mirror of PCI
> > config space in order for the MSI interrupt to re-trigger.  This PCI
> > config space mirror is virtualized in QEMU for GeForce.
> >=20
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/vfio/pci-quirks.c |    9 ++++++---
> >  hw/vfio/pci.c        |    2 ++
> >  hw/vfio/pci.h        |    1 +
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index 60ad5fb91a83..e5779a7ad35b 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -542,7 +542,8 @@ static void vfio_vga_probe_nvidia_3d0_quirk(VFIOPCI=
Device *vdev)
> >      VFIOQuirk *quirk;
> >      VFIONvidia3d0Quirk *data;
> > =20
> > -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
> > +    if (vdev->no_geforce_quirks ||
> > +        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) || =20
>=20
> Isn't it enough to check x-pci-device-id =3D=3D 0x03d0 for GeForce rather
> than introduce a x-no-geforce-quirks property?

Hi,

That's not how any of this works.  x-pci-device-id is another vfio-pci
option which is only used for overriding the PCI device IDs of the
assigned device, so I assuming you mean vdev->device_id.  However, we
can lookup here:

http://pci-ids.ucw.cz/read/PC/10de

that vendor ID 0x10de, device ID 0x03d0 only refers to a GeForce 6150SE
embedded into the nForce 430 chipset.  It certainly doesn't identify
all GeForce devices, each product NVIDIA ships has a different device
ID.  Also, the "3d0" of this function refers to a section of the VGA I/O
port region for which we're inserting a quirk, not to a specific
device.  This quirk is only necessary when bootstrapping the VGA BIOS
on an NVIDIA graphics card.  Thanks,

Alex

> >          !vdev->bars[1].region.size) {
> >          return;
> >      }
> > @@ -660,7 +661,8 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDev=
ice *vdev, int nr)
> >      VFIONvidiaBAR5Quirk *bar5;
> >      VFIOConfigWindowQuirk *window;
> > =20
> > -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
> > +    if (vdev->no_geforce_quirks ||
> > +        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
> >          !vdev->vga || nr !=3D 5 || !vdev->bars[5].ioport) {
> >          return;
> >      }
> > @@ -754,7 +756,8 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDev=
ice *vdev, int nr)
> >      VFIOQuirk *quirk;
> >      VFIOConfigMirrorQuirk *mirror;
> > =20
> > -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
> > +    if (vdev->no_geforce_quirks ||
> > +        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
> >          !vfio_is_vga(vdev) || nr !=3D 0) {
> >          return;
> >      }
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 2c7129512563..6d260b92c1e1 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2989,6 +2989,8 @@ static Property vfio_pci_dev_properties[] =3D {
> >      DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, fals=
e),
> >      DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
> >      DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, fals=
e),
> > +    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
> > +                     no_geforce_quirks, false),
> >      DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice, vendor_id, PC=
I_ANY_ID),
> >      DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice, device_id, PC=
I_ANY_ID),
> >      DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > index a8fb3b34222c..7c55087a1c44 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -142,6 +142,7 @@ typedef struct VFIOPCIDevice {
> >      bool no_kvm_intx;
> >      bool no_kvm_msi;
> >      bool no_kvm_msix;
> > +    bool no_geforce_quirks;
> >  } VFIOPCIDevice;
> > =20
> >  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
> >=20
> >  =20
>=20
