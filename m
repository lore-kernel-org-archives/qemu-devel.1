Received: from eggs.gnu.org ([2001:4830:134:3::10]:49286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dapMf-0002SM-Qr
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dapMe-000561-Pr
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:26:33 -0400
References: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
	<1499633493-19865-3-git-send-email-eric.auger@redhat.com>
	<04b06baa-75d8-291b-ef6e-89bbb89b3fd1@semihalf.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9a41e0b1-0519-2c93-70b4-30e0a38a2405@redhat.com>
Date: Thu, 27 Jul 2017 22:26:11 +0200
MIME-Version: 1.0
In-Reply-To: <04b06baa-75d8-291b-ef6e-89bbb89b3fd1@semihalf.com>
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

On 13/07/2017 14:00, Tomasz Nowicki wrote:
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
>> +/*****************************
>> + *  Register Access Primitives
>> + *****************************/
>> +
>> +static inline void smmu_write64_reg(SMMUV3State *s, uint32_t addr,
>> uint64_t val)
>> +{
>> +    addr >>= 2;
>> +    s->regs[addr] = val & 0xFFFFFFFFULL;
>> +    s->regs[addr + 1] = val & ~0xFFFFFFFFULL;
>> +}
>> +
>> +static inline void smmu_write_reg(SMMUV3State *s, uint32_t addr,
>> uint64_t val)
>> +{
>> +    s->regs[addr >> 2] = val;
>> +}
>> +
>> +static inline uint32_t smmu_read_reg(SMMUV3State *s, uint32_t addr)
>> +{
>> +    return s->regs[addr >> 2];
>> +}
>> +
>> +static inline uint64_t smmu_read64_reg(SMMUV3State *s, uint32_t addr)
>> +{
>> +    addr >>= 2;
>> +    return s->regs[addr] | (s->regs[addr + 1] << 32);
> 
> To be consistent with smmu_write64_reg() we should not shift here second
> half of register, instead simply:
> 
> return s->regs[addr] | s->regs[addr + 1];

Thanks for spotting this. I think regs should be uint32_t instead and
extract64() could be used on write64 and shift would stay on read64().

Regards

Eric
> 
> Thanks,
> Tomasz
