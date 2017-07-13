Received: from eggs.gnu.org ([2001:4830:134:3::10]:34099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVghZ-0002lX-Cf
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVghY-0001A4-9E
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:10:53 -0400
Date: Thu, 13 Jul 2017 19:10:38 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713190931-mutt-send-email-mst@kernel.org>
References: <1499927922-32303-1-git-send-email-Bharat.Bhushan@nxp.com>
	<1499927922-32303-2-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499927922-32303-2-git-send-email-Bharat.Bhushan@nxp.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] target/arm/kvm: Translate the MSI
 doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Cc: eric.auger@redhat.com, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org

On Thu, Jul 13, 2017 at 12:08:41PM +0530, Bharat Bhushan wrote:
> Fix-up MSI address if it translate via virtual iommu.
> This code is based on http://patchwork.ozlabs.org/patch/785951/
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>

Links go dead with time. And following links
is hard on reviewers. Please copy the full description
tweaking as appropriate and attribute in commit log.

> ---
>  target/arm/kvm.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4555468..eff7e8f 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -22,6 +22,9 @@
>  #include "cpu.h"
>  #include "internals.h"
>  #include "hw/arm/arm.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/msi.h"
> +#include "hw/virtio/virtio-iommu.h"
>  #include "exec/memattrs.h"
>  #include "exec/address-spaces.h"
>  #include "hw/boards.h"
> @@ -611,6 +614,24 @@ int kvm_arm_vgic_probe(void)
>  int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                               uint64_t address, uint32_t data, PCIDevice *dev)
>  {
> +    AddressSpace *as = pci_device_iommu_address_space(dev);
> +    IOMMUTLBEntry entry;
> +    IOMMUDevice *sdev;
> +    VirtIOIOMMU *s;
> +
> +    if (as == &address_space_memory) {
> +        return 0;
> +    }
> +
> +    /* MSI doorbell address is translated by an IOMMU */
> +    sdev = container_of(as, IOMMUDevice, as);
> +    s = sdev->viommu;
> +
> +    entry = s->iommu_ops.translate(&sdev->iommu_mr, address, IOMMU_WO);
> +
> +    route->u.msi.address_lo = entry.translated_addr;
> +    route->u.msi.address_hi = entry.translated_addr >> 32;
> +
>      return 0;
>  }
>  
> -- 
> 1.9.3
