Received: from eggs.gnu.org ([2001:4830:134:3::10]:38235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crLAB-0000ya-7n
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crLA7-0005xK-TO
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:05:39 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:29193
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crLA7-0005wK-I8
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:05:35 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 24 Mar 2017 09:05:31 +0000
Message-ID: <8c8207cf4d7e4aa1ab5181879aebf873@AMSPEX02CL03.citrite.net>
References: <1490264111-25273-1-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1703231730120.8001@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1703231730120.8001@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] xen-platform: separate unplugging of
 NVMe disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony
	Perard <anthony.perard@citrix.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 24 March 2017 00:51
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano
> Stabellini <sstabellini@kernel.org>; Anthony Perard
> <anthony.perard@citrix.com>
> Subject: Re: [PATCH v2] xen-platform: separate unplugging of NVMe disks
>=20
> On Thu, 23 Mar 2017, Paul Durrant wrote:
> > Commit 090fa1c8 "add support for unplugging NVMe disks..." extended the
> > existing disk unplug flag to cover NVMe disks as well as IDE and SCSI.
> >
> > The recent thread on the xen-devel mailing list [1] has highlighted tha=
t
> > this is not desirable behaviour: PV frontends should be able to disting=
uish
> > NVMe disks from other types of disk and should have separate control
> over
> > whether they are unplugged.
> >
> > This patch defines a new bit in the unplug mask for this purpose and al=
so
> > tidies up the definitions of, and improves the comments regarding, the
> > previously exiting bits in the protocol.
> >
> > [1] https://lists.xen.org/archives/html/xen-devel/2017-03/msg02924.html
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > --
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> >
> > NOTE: A companion patch will be submitted to xen-devel to align the
> >       unplug protocol documentation once this patch is acked.
>=20
> The companion patch needs to be acked before this patch gets applied. In
> fact, I would prefer if the changeset of the Xen commit was added to
> this patch description.
>=20
> If you add that, then you can repost this with
>=20
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>=20

Ok. I'll cc you on the xen docs patch too.

  Paul

>=20
> > v2:
> > - Fix the commit comment
> > ---
> >  hw/i386/xen/xen_platform.c | 47
> ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 35 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> > index 6010f35..983d532 100644
> > --- a/hw/i386/xen/xen_platform.c
> > +++ b/hw/i386/xen/xen_platform.c
> > @@ -87,10 +87,30 @@ static void log_writeb(PCIXenPlatformState *s, char
> val)
> >      }
> >  }
> >
> > -/* Xen Platform, Fixed IOPort */
> > -#define UNPLUG_ALL_DISKS 1
> > -#define UNPLUG_ALL_NICS 2
> > -#define UNPLUG_AUX_IDE_DISKS 4
> > +/*
> > + * Unplug device flags.
> > + *
> > + * The logic got a little confused at some point in the past but this =
is
> > + * what they do now.
> > + *
> > + * bit 0: Unplug all IDE and SCSI disks.
> > + * bit 1: Unplug all NICs.
> > + * bit 2: Unplug IDE disks except primary master. This is overridden i=
f
> > + *        bit 0 is also present in the mask.
> > + * bit 3: Unplug all NVMe disks.
> > + *
> > + */
> > +#define _UNPLUG_IDE_SCSI_DISKS 0
> > +#define UNPLUG_IDE_SCSI_DISKS (1u << _UNPLUG_IDE_SCSI_DISKS)
> > +
> > +#define _UNPLUG_ALL_NICS 1
> > +#define UNPLUG_ALL_NICS (1u << _UNPLUG_ALL_NICS)
> > +
> > +#define _UNPLUG_AUX_IDE_DISKS 2
> > +#define UNPLUG_AUX_IDE_DISKS (1u << _UNPLUG_AUX_IDE_DISKS)
> > +
> > +#define _UNPLUG_NVME_DISKS 3
> > +#define UNPLUG_NVME_DISKS (1u << _UNPLUG_NVME_DISKS)
> >
> >  static void unplug_nic(PCIBus *b, PCIDevice *d, void *o)
> >  {
> > @@ -111,7 +131,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d,
> void *opaque)
> >  {
> >      uint32_t flags =3D *(uint32_t *)opaque;
> >      bool aux =3D (flags & UNPLUG_AUX_IDE_DISKS) &&
> > -        !(flags & UNPLUG_ALL_DISKS);
> > +        !(flags & UNPLUG_IDE_SCSI_DISKS);
> >
> >      /* We have to ignore passthrough devices */
> >      if (!strcmp(d->name, "xen-pci-passthrough")) {
> > @@ -124,12 +144,16 @@ static void unplug_disks(PCIBus *b, PCIDevice *d,
> void *opaque)
> >          break;
> >
> >      case PCI_CLASS_STORAGE_SCSI:
> > -    case PCI_CLASS_STORAGE_EXPRESS:
> >          if (!aux) {
> >              object_unparent(OBJECT(d));
> >          }
> >          break;
> >
> > +    case PCI_CLASS_STORAGE_EXPRESS:
> > +        if (flags & UNPLUG_NVME_DISKS) {
> > +            object_unparent(OBJECT(d));
> > +        }
> > +
> >      default:
> >          break;
> >      }
> > @@ -147,10 +171,9 @@ static void platform_fixed_ioport_writew(void
> *opaque, uint32_t addr, uint32_t v
> >      switch (addr) {
> >      case 0: {
> >          PCIDevice *pci_dev =3D PCI_DEVICE(s);
> > -        /* Unplug devices.  Value is a bitmask of which devices to
> > -           unplug, with bit 0 the disk devices, bit 1 the network
> > -           devices, and bit 2 the non-primary-master IDE devices. */
> > -        if (val & (UNPLUG_ALL_DISKS | UNPLUG_AUX_IDE_DISKS)) {
> > +        /* Unplug devices. See comment above flag definitions */
> > +        if (val & (UNPLUG_IDE_SCSI_DISKS | UNPLUG_AUX_IDE_DISKS |
> > +                   UNPLUG_NVME_DISKS)) {
> >              DPRINTF("unplug disks\n");
> >              pci_unplug_disks(pci_dev->bus, val);
> >          }
> > @@ -338,14 +361,14 @@ static void xen_platform_ioport_writeb(void
> *opaque, hwaddr addr,
> >               * If VMDP was to control both disk and LAN it would use 4=
.
> >               * If it controlled just disk or just LAN, it would use 8 =
below.
> >               */
> > -            pci_unplug_disks(pci_dev->bus, UNPLUG_ALL_DISKS);
> > +            pci_unplug_disks(pci_dev->bus, UNPLUG_IDE_SCSI_DISKS);
> >              pci_unplug_nics(pci_dev->bus);
> >          }
> >          break;
> >      case 8:
> >          switch (val) {
> >          case 1:
> > -            pci_unplug_disks(pci_dev->bus, UNPLUG_ALL_DISKS);
> > +            pci_unplug_disks(pci_dev->bus, UNPLUG_IDE_SCSI_DISKS);
> >              break;
> >          case 2:
> >              pci_unplug_nics(pci_dev->bus);
> > --
> > 2.1.4
> >
