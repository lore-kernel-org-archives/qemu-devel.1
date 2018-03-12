Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evM7T-0006JA-4e
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evM7S-0005fn-7Q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:59:59 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evM7S-0005ec-1o
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:59:58 -0400
Received: by mail-ot0-x241.google.com with SMTP id f11so14946293otj.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 04:59:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-12-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-12-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 11:59:36 +0000
Message-ID: <CAFEAcA_9cmK9gebqE9997fzhTzKT6Ky9q4jn=fxwziopDyK9Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 11/14] target/arm/kvm: Translate the MSI
 doorbell in kvm_arch_fixup_msi_route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> In case the MSI is translated by an IOMMU we need to fixup the
> MSI route with the translated address.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v5 -> v6:
> - use IOMMUMemoryRegionClass API
>
> It is still unclear to me if we need to register an IOMMUNotifier
> to handle any change in the MSI doorbell which would occur behind
> the scene and would not lead to any call to kvm_arch_fixup_msi_route().

Paolo, do you know the answer to this question ?

> ---
>  target/arm/kvm.c        | 27 +++++++++++++++++++++++++++
>  target/arm/trace-events |  3 +++
>  2 files changed, 30 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 1219d00..9f5976a 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -20,8 +20,13 @@
>  #include "sysemu/kvm.h"
>  #include "kvm_arm.h"
>  #include "cpu.h"
> +#include "trace.h"
>  #include "internals.h"
>  #include "hw/arm/arm.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/msi.h"
> +#include "hw/arm/smmu-common.h"
> +#include "hw/arm/smmuv3.h"
>  #include "exec/memattrs.h"
>  #include "exec/address-spaces.h"
>  #include "hw/boards.h"
> @@ -666,6 +671,28 @@ int kvm_arm_vgic_probe(void)
>  int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                               uint64_t address, uint32_t data, PCIDevice *dev)
>  {
> +    AddressSpace *as = pci_device_iommu_address_space(dev);
> +    IOMMUMemoryRegionClass *imrc;
> +    IOMMUTLBEntry entry;
> +    SMMUDevice *sdev;
> +
> +    if (as == &address_space_memory) {
> +        return 0;
> +    }
> +
> +    /* MSI doorbell address is translated by an IOMMU */
> +    sdev = container_of(as, SMMUDevice, as);
> +    imrc = IOMMU_MEMORY_REGION_GET_CLASS(&sdev->iommu);
> +
> +    entry = imrc->translate(&sdev->iommu, address, IOMMU_WO);
> +
> +    route->u.msi.address_lo = entry.translated_addr;
> +    route->u.msi.address_hi = entry.translated_addr >> 32;
> +
> +    trace_kvm_arm_fixup_msi_route(address, sdev->devfn,
> +                                  sdev->iommu.parent_obj.name,
> +                                  entry.translated_addr);
> +
>      return 0;
>  }

It seems a bit odd that:
 * the code for arm for "PCI devices behind IOMMU need to have
   the MSI doorbell writes go through the IOMMU" looks rather
   different from the code for x86 for the same thing
 * the code here needs to know specifically that this is an SMMU
   and not some other kind of IOMMU

I would have expected this to be more generic-to-all-IOMMU
APIs and maybe even implemented in the generic KVM support code...

The x86 code seems to be similarly x86-specific though, so
this is more of a "perhaps there is a cleanup opportunity here"
observation I guess.

thanks
-- PMM
