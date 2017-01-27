Received: from eggs.gnu.org ([2001:4830:134:3::10]:53659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cX4LA-0003Qn-F0
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cX4L4-0002wl-CN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:05:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cX4L4-0002vn-4F
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:05:06 -0500
References: <1485423445-12302-1-git-send-email-paul.durrant@citrix.com>
	<1485423445-12302-4-git-send-email-paul.durrant@citrix.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <93357790-3fe3-dbe6-d07c-3cbb5a7b3338@redhat.com>
Date: Fri, 27 Jan 2017 06:05:01 -0500
MIME-Version: 1.0
In-Reply-To: <1485423445-12302-4-git-send-email-paul.durrant@citrix.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] xen-platform: add missing disk
 unplug option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>



On 01/26/2017 04:37 AM, Paul Durrant wrote:
> The Xen HVM unplug protocol [1] specifies a mechanism to allow guests to
> request unplug of 'aux' disks (which is stated to mean all IDE disks,
> except the primary master). This patch adds support for that unplug request.
> 
> NOTE: The semantics of what happens if unplug of all disks and 'aux' disks
>       is simultaneously requests is not clear. The patch makes that
>       assumption that an 'all' request overrides an 'aux' request.
> 
> [1] http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=docs/misc/hvm-emulated-unplug.markdown
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ----
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> ---
>  hw/i386/xen/xen_platform.c | 27 +++++++++++++++------------
>  hw/ide/piix.c              |  4 ++--
>  include/hw/ide.h           |  2 +-
>  3 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index 7d41ebb..6010f35 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -107,8 +107,12 @@ static void pci_unplug_nics(PCIBus *bus)
>      pci_for_each_device(bus, 0, unplug_nic, NULL);
>  }
>  
> -static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
> +static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
>  {
> +    uint32_t flags = *(uint32_t *)opaque;
> +    bool aux = (flags & UNPLUG_AUX_IDE_DISKS) &&
> +        !(flags & UNPLUG_ALL_DISKS);
> +
>      /* We have to ignore passthrough devices */
>      if (!strcmp(d->name, "xen-pci-passthrough")) {
>          return;
> @@ -116,12 +120,14 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
>  
>      switch (pci_get_word(d->config + PCI_CLASS_DEVICE)) {
>      case PCI_CLASS_STORAGE_IDE:
> -        pci_piix3_xen_ide_unplug(DEVICE(d));
> +        pci_piix3_xen_ide_unplug(DEVICE(d), aux);
>          break;
>  
>      case PCI_CLASS_STORAGE_SCSI:
>      case PCI_CLASS_STORAGE_EXPRESS:
> -        object_unparent(OBJECT(d));
> +        if (!aux) {
> +            object_unparent(OBJECT(d));
> +        }
>          break;
>  
>      default:
> @@ -129,9 +135,9 @@ static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
>      }
>  }
>  
> -static void pci_unplug_disks(PCIBus *bus)
> +static void pci_unplug_disks(PCIBus *bus, uint32_t flags)
>  {
> -    pci_for_each_device(bus, 0, unplug_disks, NULL);
> +    pci_for_each_device(bus, 0, unplug_disks, &flags);
>  }
>  
>  static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, uint32_t val)
> @@ -144,17 +150,14 @@ static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, uint32_t v
>          /* Unplug devices.  Value is a bitmask of which devices to
>             unplug, with bit 0 the disk devices, bit 1 the network
>             devices, and bit 2 the non-primary-master IDE devices. */
> -        if (val & UNPLUG_ALL_DISKS) {
> +        if (val & (UNPLUG_ALL_DISKS | UNPLUG_AUX_IDE_DISKS)) {
>              DPRINTF("unplug disks\n");
> -            pci_unplug_disks(pci_dev->bus);
> +            pci_unplug_disks(pci_dev->bus, val);
>          }
>          if (val & UNPLUG_ALL_NICS) {
>              DPRINTF("unplug nics\n");
>              pci_unplug_nics(pci_dev->bus);
>          }
> -        if (val & UNPLUG_AUX_IDE_DISKS) {
> -            DPRINTF("unplug auxiliary disks not supported\n");
> -        }
>          break;
>      }
>      case 2:
> @@ -335,14 +338,14 @@ static void xen_platform_ioport_writeb(void *opaque, hwaddr addr,
>               * If VMDP was to control both disk and LAN it would use 4.
>               * If it controlled just disk or just LAN, it would use 8 below.
>               */
> -            pci_unplug_disks(pci_dev->bus);
> +            pci_unplug_disks(pci_dev->bus, UNPLUG_ALL_DISKS);
>              pci_unplug_nics(pci_dev->bus);
>          }
>          break;
>      case 8:
>          switch (val) {
>          case 1:
> -            pci_unplug_disks(pci_dev->bus);
> +            pci_unplug_disks(pci_dev->bus, UNPLUG_ALL_DISKS);
>              break;
>          case 2:
>              pci_unplug_nics(pci_dev->bus);
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index d5777fd..7e2d767 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -165,7 +165,7 @@ static void pci_piix_ide_realize(PCIDevice *dev, Error **errp)
>      pci_piix_init_ports(d);
>  }
>  
> -int pci_piix3_xen_ide_unplug(DeviceState *dev)
> +int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux)
>  {
>      PCIIDEState *pci_ide;
>      DriveInfo *di;
> @@ -174,7 +174,7 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev)
>  
>      pci_ide = PCI_IDE(dev);
>  
> -    for (i = 0; i < 4; i++) {
> +    for (i = aux ? 1 : 0; i < 4; i++) {
>          di = drive_get_by_index(IF_IDE, i);
>          if (di != NULL && !di->media_cd) {
>              BlockBackend *blk = blk_by_legacy_dinfo(di);
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index bc8bd32..3ae087c 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -17,7 +17,7 @@ void pci_cmd646_ide_init(PCIBus *bus, DriveInfo **hd_table,
>  PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>  PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>  PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
> -int pci_piix3_xen_ide_unplug(DeviceState *dev);
> +int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
>  void vt82c686b_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>  
>  /* ide-mmio.c */
> 

benefit-of-doubt: I assume that if Stefano Stabellini thinks this is
okay that it is alright. Has no impact on non-XEN stuff.

Acked-by: John Snow <jsnow@redhat.com>
