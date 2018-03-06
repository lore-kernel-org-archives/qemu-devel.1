Received: from eggs.gnu.org ([2001:4830:134:3::10]:59346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etDGY-0004dN-Ov
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etDGX-00076x-DH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:08:30 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etDGX-00076W-6h
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:08:29 -0500
Received: by mail-ot0-x243.google.com with SMTP id f11so18412981otj.12
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 06:08:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-3-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-3-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 14:08:07 +0000
Message-ID: <CAFEAcA-uMZwR8HfVDx0Rau9G2unMypWJEL0o3ACPHxCqZ+g=_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 02/14] hw/arm/smmu-common: IOMMU memory
 region and address space setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> We enumerate all the PCI devices attached to the SMMU and
> initialize an associated IOMMU memory region and address space.
> This happens on SMMU base instance init.
>
> Those info are stored in SMMUDevice objects. The devices are
> grouped according to the PCIBus they belong to. A hash table
> indexed by the PCIBus poinet is used. Also an array indexed by

"pointer".

> the bus number allows to find the list of SMMUDevices.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
> v8 -> v9:
> - fix key value for lookup
>
> v7 -> v8:
> - introduce SMMU_MAX_VA_BITS
> - use PCI bus handle as a key
> - do not clear s->smmu_as_by_bus_num
> - use g_new0 instead of g_malloc0
> - use primary_bus field
> ---
>  hw/arm/smmu-common.c         | 59 ++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmu-common.h |  6 +++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 86a5aab..d0516dc 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -28,12 +28,71 @@
>  #include "qemu/error-report.h"
>  #include "hw/arm/smmu-common.h"
>
> +SMMUPciBus *smmu_find_as_from_bus_num(SMMUState *s, uint8_t bus_num)
> +{
> +    SMMUPciBus *smmu_pci_bus = s->smmu_as_by_bus_num[bus_num];

Variable name suggests this is a table of AddressSpaces indexed by
bus number, but the code says we're getting SMMUPCIBus objects from it?

> +
> +    if (!smmu_pci_bus) {
> +        GHashTableIter iter;
> +
> +        g_hash_table_iter_init(&iter, s->smmu_as_by_busptr);
> +        while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
> +            if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
> +                s->smmu_as_by_bus_num[bus_num] = smmu_pci_bus;
> +                return smmu_pci_bus;
> +            }
> +        }

Why do we populate this hashtable lazily rather than when we
put the SMMUPciBus in the smmu_as_by_busptr table? Do we
expect this function not to ordinarily be called?

> +    }
> +    return smmu_pci_bus;
> +}
> +
> +static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
> +{
> +    SMMUState *s = opaque;
> +    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_as_by_busptr, bus);
> +    SMMUDevice *sdev;
> +
> +    if (!sbus) {
> +        sbus = g_malloc0(sizeof(SMMUPciBus) +
> +                         sizeof(SMMUDevice *) * SMMU_PCI_DEVFN_MAX);
> +        sbus->bus = bus;
> +        g_hash_table_insert(s->smmu_as_by_busptr, bus, sbus);
> +    }
> +
> +    sdev = sbus->pbdev[devfn];
> +    if (!sdev) {
> +        char *name = g_strdup_printf("%s-%d-%d",
> +                                     s->mrtypename,
> +                                     pci_bus_num(bus), devfn);
> +        sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
> +
> +        sdev->smmu = s;
> +        sdev->bus = bus;
> +        sdev->devfn = devfn;
> +
> +        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
> +                                 s->mrtypename,
> +                                 OBJECT(s), name, 1ULL << SMMU_MAX_VA_BITS);
> +        address_space_init(&sdev->as,
> +                           MEMORY_REGION(&sdev->iommu), name);

This leaks the memory pointed to by name, doesn't it?
(address_space_init() takes a copy of the name string, so you want
to g_free(name) here.)

> +    }
> +
> +    return &sdev->as;
> +}
> +
>  static void smmu_base_realize(DeviceState *dev, Error **errp)
>  {
>      SMMUState *s = ARM_SMMU(dev);
>
>      s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>      s->iotlb = g_hash_table_new_full(NULL, NULL, NULL, g_free);
> +    s->smmu_as_by_busptr = g_hash_table_new(NULL, NULL);
> +
> +    if (s->primary_bus) {
> +        pci_setup_iommu(s->primary_bus, smmu_find_add_as, s);
> +    } else {
> +        error_setg(errp, "SMMU is not attached to any PCI bus!");
> +    }
>  }
>
>  static void smmu_base_reset(DeviceState *dev)
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 8a9d931..aee96c2 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -121,4 +121,10 @@ typedef struct {
>  #define ARM_SMMU_GET_CLASS(obj)                              \
>      OBJECT_GET_CLASS(SMMUBaseClass, (obj), TYPE_ARM_SMMU)
>
> +SMMUPciBus *smmu_find_as_from_bus_num(SMMUState *s, uint8_t bus_num);
> +
> +static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
> +{
> +    return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
> +}

Can we have at least brief documentation comments for any
new functions or prototypes added to header files, please?

>  #endif  /* HW_ARM_SMMU_COMMON */
> --

thanks
-- PMM
