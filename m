Received: from eggs.gnu.org ([2001:4830:134:3::10]:60774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1e1ZIu-0007Fa-8O
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1e1ZIr-0002Ya-K0
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:45:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1e1ZIr-0002Vi-BR
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:45:09 -0400
Date: Mon, 9 Oct 2017 08:45:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171009084506.77da9d5c@t450s.home>
In-Reply-To: <1507124979-8880-5-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-5-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/5] s390x/pci: Refuse to realize
 VFIO-PCI if AIS needed but supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de

On Wed,  4 Oct 2017 15:49:38 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> In S390x the Adapter Interrupt Suppression facility is used to mask
> interrupts of other PCI devices during interruption handling.
> 
> VFIO PCI allows the interrupts to be delivered rapidely through KVM via
> IRQfd or to be delivered through QEMU.
> The choice is made through the x-kvm-intx and x-kvo-misx properties of
> the VFIO PCI device.
> 
> If the VFIO PCI device is using the direct KVM access through IRQfd and
> we know that KVM does not implement AIS support we refuse to realize the
> VFIO PCI device.
> 
> In all other cases, emulation and VFIO PCI sending interrupts through
> QEMU, we intercept the propagated IRQ, and protect it with the QEMU AIS
> implementation before to send it to the guest through KVM.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index d9c294a..4afe49b 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -21,18 +21,21 @@
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/msi.h"
> +#include "hw/vfio/pci.h"
>  #include "qemu/error-report.h"
>  
>  #ifndef DEBUG_S390PCI_BUS
>  #define DEBUG_S390PCI_BUS  0
>  #endif
>  
> +#ifndef DPRINTF
>  #define DPRINTF(fmt, ...)                                         \
>      do {                                                          \
>          if (DEBUG_S390PCI_BUS) {                                  \
>              fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
>          }                                                         \
>      } while (0)
> +#endif

Maybe a sign we shouldn't be including vfio/pci.h

>  S390pciState *s390_get_phb(void)
>  {
> @@ -751,6 +754,15 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
>          }
>  
>          if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
> +            S390FLICState *fs = s390_get_flic();
> +            VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +
> +            if ((!vdev->no_kvm_msix || !vdev->no_kvm_msix) &&
> +                (!fs || !fs->ais_supported)) {
> +                error_setg(errp, "VFIO PCI is not supported "
> +                           "because kernel has no AIS capability.");
> +                return;
> +            }


Hmm, you're basically looking at private data structure fields for
experimental disable flags, which no user, or more importantly no
management tool, could rightfully be expected to provide.  Can we not
take this into account to automatically do the right thing, ie.
automatically set the necessary flag during the device realize?  Thanks,

Alex
