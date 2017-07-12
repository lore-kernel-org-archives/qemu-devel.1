Received: from eggs.gnu.org ([2001:4830:134:3::10]:55211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dV5XC-0001kl-3c
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dV5X8-0001u5-Uu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dV5X8-0001tk-MS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 20:29:38 -0400
Date: Tue, 11 Jul 2017 17:29:27 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170710140320.GA1587@perard.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1707111728070.26679@sstabellini-ThinkPad-X260>
References: <1490362825-24854-1-git-send-email-paul.durrant@citrix.com>
	<20170710140320.GA1587@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v3] xen-platform: separate unplugging of
 NVMe disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Paul Durrant <paul.durrant@citrix.com>

On Mon, 10 Jul 2017, Anthony PERARD wrote:
> Hi Stefano,
> 
> Looks like this patch can be applied.

Thank you for pointing it out to me, because this email has
inexplicably disappeared from my inbox. I have now marked it
appropriately to be committed.

> 
> On Fri, Mar 24, 2017 at 01:40:25PM +0000, Paul Durrant wrote:
> > Commit 090fa1c8 "add support for unplugging NVMe disks..." extended the
> > existing disk unplug flag to cover NVMe disks as well as IDE and SCSI.
> > 
> > The recent thread on the xen-devel mailing list [1] has highlighted that
> > this is not desirable behaviour: PV frontends should be able to distinguish
> > NVMe disks from other types of disk and should have separate control over
> > whether they are unplugged.
> > 
> > This patch defines a new bit in the unplug mask for this purpose (see Xen
> > commit [2]) and also tidies up the definitions of, and improves the
> > comments regarding, the previously exiting bits in the protocol.
> > 
> > [1] https://lists.xen.org/archives/html/xen-devel/2017-03/msg02924.html
> > [2] http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=1096aa02
> > 
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > --
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > 
> > v3:
> > - Updated to reference Xen documentation patch
> > 
> > v2:
> > - Fix the commit comment
> > ---
> >  hw/i386/xen/xen_platform.c | 47 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 35 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> > index 6010f35..983d532 100644
> > --- a/hw/i386/xen/xen_platform.c
> > +++ b/hw/i386/xen/xen_platform.c
> > @@ -87,10 +87,30 @@ static void log_writeb(PCIXenPlatformState *s, char val)
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
> > + * The logic got a little confused at some point in the past but this is
> > + * what they do now.
> > + *
> > + * bit 0: Unplug all IDE and SCSI disks.
> > + * bit 1: Unplug all NICs.
> > + * bit 2: Unplug IDE disks except primary master. This is overridden if
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
> > @@ -111,7 +131,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
> >  {
> >      uint32_t flags = *(uint32_t *)opaque;
> >      bool aux = (flags & UNPLUG_AUX_IDE_DISKS) &&
> > -        !(flags & UNPLUG_ALL_DISKS);
> > +        !(flags & UNPLUG_IDE_SCSI_DISKS);
> >  
> >      /* We have to ignore passthrough devices */
> >      if (!strcmp(d->name, "xen-pci-passthrough")) {
> > @@ -124,12 +144,16 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
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
> > @@ -147,10 +171,9 @@ static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, uint32_t v
> >      switch (addr) {
> >      case 0: {
> >          PCIDevice *pci_dev = PCI_DEVICE(s);
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
> > @@ -338,14 +361,14 @@ static void xen_platform_ioport_writeb(void *opaque, hwaddr addr,
> >               * If VMDP was to control both disk and LAN it would use 4.
> >               * If it controlled just disk or just LAN, it would use 8 below.
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
> 
> -- 
> Anthony PERARD
> 
