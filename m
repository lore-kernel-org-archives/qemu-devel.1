Received: from eggs.gnu.org ([2001:4830:134:3::10]:38592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1etDsc-0000bv-Qc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1etDsb-0008Gw-Le
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:47:50 -0500
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-3-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-uMZwR8HfVDx0Rau9G2unMypWJEL0o3ACPHxCqZ+g=_Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e54bcea4-3b04-7409-89c1-b2a79010c969@redhat.com>
Date: Tue, 6 Mar 2018 15:47:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-uMZwR8HfVDx0Rau9G2unMypWJEL0o3ACPHxCqZ+g=_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Tomasz Nowicki <tn@semihalf.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Prem Mallappa <prem.mallappa@gmail.com>, eric.auger.pro@gmail.com

Hi Peter,

On 06/03/18 15:08, Peter Maydell wrote:
> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>> We enumerate all the PCI devices attached to the SMMU and
>> initialize an associated IOMMU memory region and address space.
>> This happens on SMMU base instance init.
>>
>> Those info are stored in SMMUDevice objects. The devices are
>> grouped according to the PCIBus they belong to. A hash table
>> indexed by the PCIBus poinet is used. Also an array indexed by
> 
> "pointer".
OK
> 
>> the bus number allows to find the list of SMMUDevices.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v8 -> v9:
>> - fix key value for lookup
>>
>> v7 -> v8:
>> - introduce SMMU_MAX_VA_BITS
>> - use PCI bus handle as a key
>> - do not clear s->smmu_as_by_bus_num
>> - use g_new0 instead of g_malloc0
>> - use primary_bus field
>> ---
>>  hw/arm/smmu-common.c         | 59 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/arm/smmu-common.h |  6 +++++
>>  2 files changed, 65 insertions(+)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 86a5aab..d0516dc 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -28,12 +28,71 @@
>>  #include "qemu/error-report.h"
>>  #include "hw/arm/smmu-common.h"
>>
>> +SMMUPciBus *smmu_find_as_from_bus_num(SMMUState *s, uint8_t bus_num)
>> +{
>> +    SMMUPciBus *smmu_pci_bus = s->smmu_as_by_bus_num[bus_num];
> 
> Variable name suggests this is a table of AddressSpaces indexed by
> bus number, but the code says we're getting SMMUPCIBus objects from it?
Yes I can rename this variable. It stems from x86 naming (see
hw/intel_iommu.c vtd_find_as_from_bus_num). The code here does the same
functionality with arm smmu datatypes.
SMMUPciBus ~ VTDBus and smmu_as_by_bus_num ~ vtd_as_by_bus_num

purpose is to find the SMUPciBus which matches the bus number passed in
parameter.

> 
>> +
>> +    if (!smmu_pci_bus) {
>> +        GHashTableIter iter;
>> +
>> +        g_hash_table_iter_init(&iter, s->smmu_as_by_busptr);
>> +        while (g_hash_table_iter_next(&iter, NULL, (void **)&smmu_pci_bus)) {
>> +            if (pci_bus_num(smmu_pci_bus->bus) == bus_num) {
>> +                s->smmu_as_by_bus_num[bus_num] = smmu_pci_bus;
>> +                return smmu_pci_bus;
>> +            }
>> +        }
> 
> Why do we populate this hashtable lazily rather than when we
> put the SMMUPciBus in the smmu_as_by_busptr table? Do we
> expect this function not to ordinarily be called?

This function only is used when handling invalidations (vhost/vfio). I
can even remove it from this series at this stage and re-introduce
latter on. From the SID, you retrieve bus_num, retrieve the SMMUPciBus.
Andd from the function number you can then retrieve the IOMMU mr at
smmu_bus->pbdev[devfn]

That's the purpose of ths function. But I will remove it.
> 
>> +    }
>> +    return smmu_pci_bus;
>> +}
>> +
>> +static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>> +{
>> +    SMMUState *s = opaque;
>> +    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_as_by_busptr, bus);
>> +    SMMUDevice *sdev;
>> +
>> +    if (!sbus) {
>> +        sbus = g_malloc0(sizeof(SMMUPciBus) +
>> +                         sizeof(SMMUDevice *) * SMMU_PCI_DEVFN_MAX);
>> +        sbus->bus = bus;
>> +        g_hash_table_insert(s->smmu_as_by_busptr, bus, sbus);
>> +    }
>> +
>> +    sdev = sbus->pbdev[devfn];
>> +    if (!sdev) {
>> +        char *name = g_strdup_printf("%s-%d-%d",
>> +                                     s->mrtypename,
>> +                                     pci_bus_num(bus), devfn);
>> +        sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
>> +
>> +        sdev->smmu = s;
>> +        sdev->bus = bus;
>> +        sdev->devfn = devfn;
>> +
>> +        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
>> +                                 s->mrtypename,
>> +                                 OBJECT(s), name, 1ULL << SMMU_MAX_VA_BITS);
>> +        address_space_init(&sdev->as,
>> +                           MEMORY_REGION(&sdev->iommu), name);
> 
> This leaks the memory pointed to by name, doesn't it?
> (address_space_init() takes a copy of the name string, so you want
> to g_free(name) here.)
Hum yes. Will free it.
> 
>> +    }
>> +
>> +    return &sdev->as;
>> +}
>> +
>>  static void smmu_base_realize(DeviceState *dev, Error **errp)
>>  {
>>      SMMUState *s = ARM_SMMU(dev);
>>
>>      s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>>      s->iotlb = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>> +    s->smmu_as_by_busptr = g_hash_table_new(NULL, NULL);
>> +
>> +    if (s->primary_bus) {
>> +        pci_setup_iommu(s->primary_bus, smmu_find_add_as, s);
>> +    } else {
>> +        error_setg(errp, "SMMU is not attached to any PCI bus!");
>> +    }
>>  }
>>
>>  static void smmu_base_reset(DeviceState *dev)
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index 8a9d931..aee96c2 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -121,4 +121,10 @@ typedef struct {
>>  #define ARM_SMMU_GET_CLASS(obj)                              \
>>      OBJECT_GET_CLASS(SMMUBaseClass, (obj), TYPE_ARM_SMMU)
>>
>> +SMMUPciBus *smmu_find_as_from_bus_num(SMMUState *s, uint8_t bus_num);
>> +
>> +static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>> +{
>> +    return  ((pci_bus_num(sdev->bus) & 0xff) << 8) | sdev->devfn;
>> +}
> 
> Can we have at least brief documentation comments for any
> new functions or prototypes added to header files, please?
Sure.

Thanks

Eric
> 
>>  #endif  /* HW_ARM_SMMU_COMMON */
>> --
> 
> thanks
> -- PMM
> 
