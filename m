Received: from eggs.gnu.org ([2001:4830:134:3::10]:53424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ch2hz-0002LG-6Y
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ch2hw-0005b8-0a
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:21:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ch2hv-0005ai-OW
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:21:55 -0500
Date: Fri, 24 Feb 2017 01:21:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170224012000-mutt-send-email-mst@kernel.org>
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487742565-2513-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: make sure its init before PCI
 dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, yi.l.liu@intel.com, Jintack Lim <jintack@cs.columbia.edu>

On Wed, Feb 22, 2017 at 01:49:25PM +0800, Peter Xu wrote:
> Intel vIOMMU devices are created with "-device" parameter, while here
> actually we need to make sure this device will be created before some
> other PCI devices (like vfio-pci devices) so that we know iommu_fn will
> be setup correctly before realizations of those PCI devices.
> Here we do explicit check to make sure intel-iommu device will be inited
> before all the rest of the PCI devices. This is done by checking against
> the devices dangled under current root PCIe bus and we should see
> nothing there besides integrated ICH9 ones.
> 
> If the user violated this rule, we abort the program.
> 
> Maybe one day we will be able to manage the ordering of device
> initialization, and then we can grant VT-d devices a higher init
> priority. But before that, let's have this explicit check to make sure
> of it.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 22d8226..db74124 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -31,6 +31,7 @@
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/boards.h"
>  #include "hw/i386/x86-iommu.h"
> +#include "hw/i386/ich9.h"
>  #include "hw/pci-host/q35.h"
>  #include "sysemu/kvm.h"
>  #include "hw/i386/apic_internal.h"
> @@ -2560,6 +2561,41 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>      return true;
>  }
>  
> +static bool vtd_has_inited_pci_devices(PCIBus *bus, Error **errp)
> +{
> +    int i;
> +    uint8_t func;
> +
> +    /* We check against root bus */
> +    assert(bus && pci_bus_is_root(bus));
> +
> +    /*
> +     * We need to make sure vIOMMU device is created before other PCI
> +     * devices other than the integrated ICH9 ones,


Why wouldn't this apply to integrated ICH9 ones?


> so that they can
> +     * get correct iommu_fn setup even during its realize(). Some
> +     * devices (e.g., vfio-pci) will need a correct iommu_fn to work.

If there's something special about vfio devices, then just check
the device type.

> +     */
> +    for (i = 1; i < PCI_FUNC_MAX * PCI_SLOT_MAX; i++) {
> +        /* Skip the checking against ICH9 integrated devices */
> +        if (PCI_SLOT(i) == ICH9_LPC_DEV) {
> +            func = PCI_FUNC(i);
> +            if (func == ICH9_LPC_FUNC ||
> +                func == ICH9_SATA1_FUNC ||
> +                func == ICH9_SMB_FUNC) {
> +                continue;
> +            }
> +        }
> +
> +        if (bus->devices[i]) {
> +            error_setg(errp, "Please init intel-iommu before "
> +                       "other PCI devices");
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>  static void vtd_realize(DeviceState *dev, Error **errp)
>  {
>      PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> @@ -2567,6 +2603,10 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>  
> +    if (vtd_has_inited_pci_devices(bus, errp)) {
> +        return;
> +    }
> +
>      VTD_DPRINTF(GENERAL, "");
>      x86_iommu->type = TYPE_INTEL;
>  
> -- 
> 2.7.4
