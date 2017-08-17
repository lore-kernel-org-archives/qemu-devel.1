Received: from eggs.gnu.org ([2001:4830:134:3::10]:56248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1diMnf-0004xX-1y
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1diMna-0001UR-W7
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:33:35 -0400
References: <1500017104-3574-1-git-send-email-Bharat.Bhushan@nxp.com>
	<1500017104-3574-2-git-send-email-Bharat.Bhushan@nxp.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c5f6a0f8-0f7c-aff8-1411-ae83b8ff83e6@redhat.com>
Date: Thu, 17 Aug 2017 17:33:10 +0200
MIME-Version: 1.0
In-Reply-To: <1500017104-3574-2-git-send-email-Bharat.Bhushan@nxp.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 PATCH 1/2] target/arm/kvm: Translate the
 MSI doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org

Hi Bharat,
On 14/07/2017 09:25, Bharat Bhushan wrote:
> Translate msi address if device is behind virtio-iommu.
> This logic is similar to vSMMUv3/Intel iommu emulation.
Why Intel?
> 
> This RFC patch does not handle the case where both vsmmuv3 and
> virtio-iommu are available.
I think this should be hidden by the creation of a base vIOMMU object as
initiated by Peter in: "[Qemu-devel] [RFC PATCH 0/8] IOMMU: introduce
common IOMMUObject". I will try to rebase the virtio-iommu and vsmmuv3
series on this idea.

Thanks

Eric
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
> v1-v2:
>   - Added trace events
>   - removed vSMMU3 link in patch description
> 
>  target/arm/kvm.c        | 25 +++++++++++++++++++++++++
>  target/arm/trace-events |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4555468..5a28956 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -21,7 +21,11 @@
>  #include "kvm_arm.h"
>  #include "cpu.h"
>  #include "internals.h"
> +#include "trace.h"
>  #include "hw/arm/arm.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/msi.h"
> +#include "hw/virtio/virtio-iommu.h"
>  #include "exec/memattrs.h"
>  #include "exec/address-spaces.h"
>  #include "hw/boards.h"
> @@ -611,6 +615,27 @@ int kvm_arm_vgic_probe(void)
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
> +    trace_kvm_arm_fixup_msi_route(address, sdev->devfn, sdev->iommu_mr.name,
> +                                  entry.translated_addr);
> +
>      return 0;
>  }
>  
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index e21c84f..eff2822 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -8,3 +8,6 @@ arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value %" P
>  arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value %" PRIx64
>  arm_gt_imask_toggle(int timer, int irqstate) "gt_ctl_write: timer %d IMASK toggle, new irqstate %d"
>  arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value %" PRIx64
> +
> +# target/arm/kvm.c
> +kvm_arm_fixup_msi_route(uint64_t iova, uint32_t devid, const char *name, uint64_t gpa) "MSI addr = 0x%"PRIx64" is translated for devfn=%d through %s into 0x%"PRIx64
> 
