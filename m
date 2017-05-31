Received: from eggs.gnu.org ([2001:4830:134:3::10]:60012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dFxjl-0007Z1-Jh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dFxjk-0005OY-Ck
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:08:09 -0400
References: <1494697399-352-1-git-send-email-eric.auger@redhat.com>
	<1494697399-352-3-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9P=k88CFwUHeAg=oxsDpY72OTUc=+iyffM9dP5=tzRKg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <fb9d6e76-2681-76cc-1f99-c70d5cfbcebf@redhat.com>
Date: Wed, 31 May 2017 09:07:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9P=k88CFwUHeAg=oxsDpY72OTUc=+iyffM9dP5=tzRKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 2/5] hw/arm/smmuv3: smmuv3 emulation model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, prem.mallappa@gmail.com, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>

Hi Peter,
On 30/05/2017 18:01, Peter Maydell wrote:
> On 13 May 2017 at 18:43, Eric Auger <eric.auger@redhat.com> wrote:
>> From: Prem Mallappa <prem.mallappa@broadcom.com>
>>
>> Introduces the SMMUv3 derived model. This is based on
>> System MMUv3 specification (v17).
>>
>> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v3 -> v4
>> - smmu_irq_update
>> - fix hash key allocation
>> - set smmu_iommu_ops
>> - set SMMU_REG_CR0,
>> - smmuv3_translate: ret.perm not set in bypass mode
>> - use trace events
>> - renamed STM2U64 into L1STD_L2PTR and STMSPAN into L1STD_SPAN
>> - rework smmu_find_ste
>> - fix tg2granule in TT0/0b10 corresponds to 16kB
>>
>> v2 -> v3:
>> - move creation of include/hw/arm/smmuv3.h to this patch to fix compil issue
>> - compilation allowed
>> - fix sbus allocation in smmu_init_pci_iommu
>> - restructure code into headers
>> - misc cleanups
>> ---
>>  hw/arm/Makefile.objs     |    2 +-
>>  hw/arm/smmuv3-internal.h |  603 ++++++++++++++++++++++++
>>  hw/arm/smmuv3.c          | 1134 ++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/arm/trace-events      |   32 ++
>>  include/hw/arm/smmuv3.h  |   87 ++++
>>  5 files changed, 1857 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/arm/smmuv3-internal.h
>>  create mode 100644 hw/arm/smmuv3.c
>>  create mode 100644 include/hw/arm/smmuv3.h
> 
> This is a bit of a big patch for review for my taste -- are
> there some easy splits into multiple patches possible?

Yes I fully understand. I will try to split it to ease the review. Maybe
I first need to reach a decent level of functionality first and then
split it.
> 
>> +typedef struct SMMUQueue {
>> +     hwaddr base;
>> +     uint32_t prod;
>> +     uint32_t cons;
>> +     union {
>> +          struct {
>> +               uint8_t prod:1;
>> +               uint8_t cons:1;
>> +          };
>> +          uint8_t unused;
>> +     } wrap;
> 
> Use of bitfields here seems a bit odd but I haven't
> looked at the code really.

OK. I will further look at this part.

Thanks

Eric
> 
> thanks
> -- PMM
> 
