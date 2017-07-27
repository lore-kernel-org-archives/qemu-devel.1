Received: from eggs.gnu.org ([2001:4830:134:3::10]:49109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dapMO-0002Iz-AV
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dapMN-0004mW-CY
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:26:16 -0400
References: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
	<1499633493-19865-3-git-send-email-eric.auger@redhat.com>
	<448765a4-1ffc-f27b-fcb1-61445fd785d4@semihalf.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <eb6021f4-b0c1-22c2-dddf-e30f331abcbc@redhat.com>
Date: Thu, 27 Jul 2017 22:25:53 +0200
MIME-Version: 1.0
In-Reply-To: <448765a4-1ffc-f27b-fcb1-61445fd785d4@semihalf.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v5 2/8] hw/arm/smmuv3: smmuv3 emulation model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tomasz Nowicki <tn@semihalf.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com

Hi Tomasz,

On 13/07/2017 14:57, Tomasz Nowicki wrote:
> Hi Eric,
> 
> On 09.07.2017 22:51, Eric Auger wrote:
>> From: Prem Mallappa <prem.mallappa@broadcom.com>
>>
>> Introduces the SMMUv3 derived model. This is based on
>> System MMUv3 specification (v17).
>>
>> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v4 -> v5:
>> - change smmuv3_translate proto (IOMMUAccessFlags flag)
>> - has_stagex replaced by is_ste_stagex
>> - smmu_cfg_populate removed
>> - added smmuv3_decode_config and reworked error management
>> - remwork the naming of IOMMU mrs
>> - fix SMMU_CMDQ_CONS offset
>>
> 
> [...]
> 
>> +
>> +static void smmu_update_qreg(SMMUV3State *s, SMMUQueue *q, hwaddr reg,
>> +                             uint32_t off, uint64_t val, unsigned size)
>> +{
>> +   if (size == 8 && off == 0) {
>> +        smmu_write64_reg(s, reg, val);
> 
> Based on my observation we never get here.
> 
> If I read the code correctly,
> memory_region_dispatch_{write|read}()->memory_region_{write|read}_accessor()
> will cut all 8-bytes accesses into 4-bytes slices. However, this makes
> my SMMUv3 register handling happy:
> 
>  static const MemoryRegionOps smmu_mem_ops = {
>      .read = smmu_read_mmio,
>      .write = smmu_write_mmio,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 8,
>      },
> +    .impl = {
> +        .min_access_size = 4,
> +    .max_access_size = 8,
> +    },
Yes indeed: without the .impl setting, only 4byte accesses are performed
by access_with_adjusted_size() which sets access_size_max to 4.

Thanks a lot.

Best regards

Eric
>  };
> 
> Thanks,
> Tomasz
