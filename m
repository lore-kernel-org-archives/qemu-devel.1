Received: from eggs.gnu.org ([2001:4830:134:3::10]:48397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fb4LB-0001L4-Su
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fb4LA-00015I-Ho
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:30:33 -0400
References: <1530775623-32399-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8YkDgJgr5Mgv4PgpmhQDpr+61hfaxmpnQWGXocEawxdg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <94f26745-00a2-eb8d-f6d9-d9ad4829214e@redhat.com>
Date: Thu, 5 Jul 2018 15:30:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8YkDgJgr5Mgv4PgpmhQDpr+61hfaxmpnQWGXocEawxdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.0] hw/arm/smmu-common: Fix devfn
 computation in smmu_iommu_mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>

Hi Peter,

On 07/05/2018 02:56 PM, Peter Maydell wrote:
> On 5 July 2018 at 08:27, Eric Auger <eric.auger@redhat.com> wrote:
>> smmu_iommu_mr() aims at returning the IOMMUMemoryRegion corresponding
>> to a given sid. The function extracts both the PCIe bus number and
>> the devfn to return this data. Current computation of devfn is wrong
>> as it only returns the PCIe function instead of slot | function.
>>
>> Fixes 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmu-common.c         | 2 +-
>>  include/hw/arm/smmu-common.h | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 3098915..55c75d6 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -351,7 +351,7 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
>>      bus_n = PCI_BUS_NUM(sid);
>>      smmu_bus = smmu_find_smmu_pcibus(s, bus_n);
>>      if (smmu_bus) {
>> -        devfn = sid & 0x7;
>> +        devfn = SMMU_PCI_DEVFN(sid);
>>          smmu = smmu_bus->pbdev[devfn];
>>          if (smmu) {
>>              return &smmu->iommu;
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index 50e2912..b07cadd 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -24,6 +24,7 @@
>>
>>  #define SMMU_PCI_BUS_MAX      256
>>  #define SMMU_PCI_DEVFN_MAX    256
>> +#define SMMU_PCI_DEVFN(sid)   (sid & 0xFF)
>>
>>  #define SMMU_MAX_VA_BITS      48
> 
> Applied to target-arm.next, thanks.
> 
> As I was reviewing this, I checked where we allocate the pbdev array
> to confirm that it's big enough (which it is), and I noticed an oddity:
> in include/hw/arm/smmu-common.h we define the SMMUPciBus struct like this:
> 
> typedef struct SMMUPciBus {
>     PCIBus       *bus;
>     SMMUDevice   *pbdev[0]; /* Parent array is sparse, so dynamically alloc */
> } SMMUPciBus;
> 
> but in fact we don't ever have local variables of this type and the
> only place we dynamically allocate them is in smmu_find_add_as(),
> which does
>         sbus = g_malloc0(sizeof(SMMUPciBus) +
>                          sizeof(SMMUDevice *) * SMMU_PCI_DEVFN_MAX);
> 
> Is there a reason I missed why we don't just define the struct
> to have
>   SMMUDevice *pbdev[SMMU_PCI_DEVFN_MAX];

I don't see any reason either. This code is inherited from
hw/i386.intel_iommu.c vtd_find_add_as() which does the same allocation
and I cannot find any reason out there either. This is not a
justification though ;-)

Can I fix it in 3.1 or do you want me to fix it for 3.0?

Thanks

Eric
> ?
> 
> thanks
> -- PMM
> 
