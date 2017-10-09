Received: from eggs.gnu.org ([2001:4830:134:3::10]:54380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1U15-0003Ua-UL
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1U0x-0002lE-SA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:06:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1U0x-0002l6-Je
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:06:19 -0400
Date: Mon, 9 Oct 2017 11:06:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171009110614.769c19e5.cohuck@redhat.com>
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
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Wed,  4 Oct 2017 15:49:38 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

"not supported", surely?

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

Ugh. Is there DPRINTF redefinition going on?

>  
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

One of the no_kvm_msix should probably be something else :)

> +                (!fs || !fs->ais_supported)) {
> +                error_setg(errp, "VFIO PCI is not supported "
> +                           "because kernel has no AIS capability.");

I think failure is per-device (i.e., you would be able to plug a
different vfio device if you turned off irqfd support for it); should
that be reflected in the error message?

> +                return;
> +            }

Would it make sense to fail plugging before we try to create a zpci
device?

>              pbdev->fh |= FH_SHM_VFIO;
>          } else {
>              pbdev->fh |= FH_SHM_EMUL;
