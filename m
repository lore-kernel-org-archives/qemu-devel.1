Received: from eggs.gnu.org ([2001:4830:134:3::10]:56971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8OOL-0001Xn-Sn
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 07:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8OOH-0003Uw-Ma
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 07:03:17 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:46685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8OOH-0003UY-Gi
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 07:03:13 -0400
Received: by mail-ot0-x242.google.com with SMTP id v64-v6so20881784otb.13
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 04:03:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-12-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-12-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 12:02:52 +0100
Message-ID: <CAFEAcA_hgGFmUmg2S7bb5nYeEh1z0kBNWrSud0_TMbkUcf7uxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 11/17] target/arm/kvm: Translate the
 MSI doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 12 April 2018 at 08:38, Eric Auger <eric.auger@redhat.com> wrote:
> In case the MSI is translated by an IOMMU we need to fixup the
> MSI route with the translated address.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
>
> ---
> v9 -> v10:
> - use address_space_translate
>
> v5 -> v6:
> - use IOMMUMemoryRegionClass API
> ---
>  target/arm/kvm.c        | 27 +++++++++++++++++++++++++++
>  target/arm/trace-events |  3 +++
>  2 files changed, 30 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ecc39ac..c6f6aa8 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -20,8 +20,10 @@
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
>  #include "cpu.h"
> +#include "trace.h"
>  #include "internals.h"
>  #include "hw/arm/arm.h"
> +#include "hw/pci/pci.h"
>  #include "exec/memattrs.h"
>  #include "exec/address-spaces.h"
>  #include "hw/boards.h"
> @@ -649,6 +651,31 @@ int kvm_arm_vgic_probe(void)
>  int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                               uint64_t address, uint32_t data, PCIDevice *dev)
>  {
> +    AddressSpace *as = pci_device_iommu_address_space(dev);
> +    hwaddr xlat, len, doorbell_gpa;
> +    MemoryRegionSection mrs;
> +    MemoryRegion *mr;
> +
> +    if (as == &address_space_memory) {
> +        return 0;
> +    }
> +
> +    /* MSI doorbell address is translated by an IOMMU */
> +
> +    rcu_read_lock();
> +    mr = address_space_translate(as, address, &xlat, &len, true);
> +    if (!mr) {
> +        return 1;

This early-return code path fails to release the rcu_read_lock.

> +    }
> +    mrs = memory_region_find(mr, xlat, 0);

Is it really valid to pass a size of 0 to memory_region_find() ?
We should probably use however big the doorbell write is.

Do we need to do something here to handle the case where
memory_region_find() doesn't find a a region, or does that
just work automatically?

> +    doorbell_gpa = mrs.offset_within_address_space;
> +    rcu_read_unlock();
> +
> +    route->u.msi.address_lo = doorbell_gpa;
> +    route->u.msi.address_hi = doorbell_gpa >> 32;
> +
> +    trace_kvm_arm_fixup_msi_route(address, doorbell_gpa);
> +
>      return 0;
>  }
>
> diff --git a/target/arm/trace-events b/target/arm/trace-events
> index 9e37131..6b759f9 100644
> --- a/target/arm/trace-events
> +++ b/target/arm/trace-events
> @@ -8,3 +8,6 @@ arm_gt_tval_write(int timer, uint64_t value) "gt_tval_write: timer %d value 0x%"
>  arm_gt_ctl_write(int timer, uint64_t value) "gt_ctl_write: timer %d value 0x%" PRIx64
>  arm_gt_imask_toggle(int timer, int irqstate) "gt_ctl_write: timer %d IMASK toggle, new irqstate %d"
>  arm_gt_cntvoff_write(uint64_t value) "gt_cntvoff_write: value 0x%" PRIx64
> +
> +# target/arm/kvm.c
> +kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
> --
> 2.5.5

thanks
-- PMM
