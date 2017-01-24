Received: from eggs.gnu.org ([2001:4830:134:3::10]:56735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWApP-0000Ox-3s
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWApM-0001By-1v
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:48:43 -0500
Received: from mail.kernel.org ([198.145.29.136]:44724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cWApL-0001Bn-O2
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 18:48:39 -0500
Date: Tue, 24 Jan 2017 15:48:31 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1485266747-4694-2-git-send-email-paul.durrant@citrix.com>
Message-ID: <alpine.DEB.2.10.1701241519320.10192@sstabellini-ThinkPad-X260>
References: <1485266747-4694-1-git-send-email-paul.durrant@citrix.com>
	<1485266747-4694-2-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xen-platform: re-structure
 unplug_disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, olaf@aepfle.de

On Tue, 24 Jan 2017, Paul Durrant wrote:
> The current code is poorly structured and potentially leads to multiple
> config space reads when one is sufficient. Also the UNPLUG_ALL_IDE_DISKS
> flag is mis-named since it also results in SCSI disks being unplugged.
> 
> This patch renames the flag and re-structures the code to be more
> efficient, and readable.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> 
> v2:
> - Fix style issue
> ---
>  hw/i386/xen/xen_platform.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index 2e1e543..f50915f 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -88,7 +88,7 @@ static void log_writeb(PCIXenPlatformState *s, char val)
>  }
>  
>  /* Xen Platform, Fixed IOPort */
> -#define UNPLUG_ALL_IDE_DISKS 1
> +#define UNPLUG_ALL_DISKS 1
>  #define UNPLUG_ALL_NICS 2
>  #define UNPLUG_AUX_IDE_DISKS 4
>  
> @@ -110,14 +110,21 @@ static void pci_unplug_nics(PCIBus *bus)
>  static void unplug_disks(PCIBus *b, PCIDevice *d, void *o)
>  {
>      /* We have to ignore passthrough devices */
> -    if (pci_get_word(d->config + PCI_CLASS_DEVICE) ==
> -            PCI_CLASS_STORAGE_IDE
> -            && strcmp(d->name, "xen-pci-passthrough") != 0) {
> +    if (!strcmp(d->name, "xen-pci-passthrough")) {
> +        return;
> +    }
> +
> +    switch (pci_get_word(d->config + PCI_CLASS_DEVICE)) {
> +    case PCI_CLASS_STORAGE_IDE:
>          pci_piix3_xen_ide_unplug(DEVICE(d));
> -    } else if (pci_get_word(d->config + PCI_CLASS_DEVICE) ==
> -            PCI_CLASS_STORAGE_SCSI
> -            && strcmp(d->name, "xen-pci-passthrough") != 0) {
> +        break;
> +
> +    case PCI_CLASS_STORAGE_SCSI:
>          object_unparent(OBJECT(d));
> +        break;
> +
> +    default:
> +        break;
>      }
>  }
>  
> @@ -134,9 +141,9 @@ static void platform_fixed_ioport_writew(void *opaque, uint32_t addr, uint32_t v
>      case 0: {
>          PCIDevice *pci_dev = PCI_DEVICE(s);
>          /* Unplug devices.  Value is a bitmask of which devices to
> -           unplug, with bit 0 the IDE devices, bit 1 the network
> +           unplug, with bit 0 the disk devices, bit 1 the network
>             devices, and bit 2 the non-primary-master IDE devices. */
> -        if (val & UNPLUG_ALL_IDE_DISKS) {
> +        if (val & UNPLUG_ALL_DISKS) {
>              DPRINTF("unplug disks\n");
>              pci_unplug_disks(pci_dev->bus);
>          }
> -- 
> 2.1.4
> 
