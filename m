Received: from eggs.gnu.org ([2001:4830:134:3::10]:55129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eu0ir-0003LS-E7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eu0iq-0007pj-GU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:57:01 -0500
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_scj3Nw+W6a7NL6bRR3ZGvUx1NLa4cWSmvfOA1BCEPgQ@mail.gmail.com>
	<f1e870f8-9669-ffde-0556-bc8b16467356@redhat.com>
	<CAFEAcA8+CDvbsQw5EKz5t0JJa1oNpteu+=X5JHxFNdyBUu7OTw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c9174fa5-263a-50ec-e3c9-8272cbb08b4a@redhat.com>
Date: Thu, 8 Mar 2018 19:56:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+CDvbsQw5EKz5t0JJa1oNpteu+=X5JHxFNdyBUu7OTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 03/14] hw/arm/smmu-common: VMSAv8-64
 page table walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

Hi Peter,
On 07/03/18 17:35, Peter Maydell wrote:
> On 7 March 2018 at 16:23, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 06/03/18 20:43, Peter Maydell wrote:
>>> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> 
>>>> +int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>>>> +             IOMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>>>> +{
>>>> +    if (!cfg->aa64) {
>>>> +        error_setg(&error_fatal,
>>>> +                   "SMMUv3 model does not support VMSAv8-32 page walk yet");
>>>
>>> This sort of guest-provokable error should not be fatal -- log
>>> it with LOG_UNIMP and carry on as best you can (in this case
>>> the spec should say what happens for SMMUv3 implementations which
>>> don't support AArch32 tables).
>> This code should never been entered as the check is done when decoding
>> the CD in the smmuv3. However since it is a base class I wanted to
>> enphase the ptw was only supporting AArch32.
> 
> Ah, right. That should be an assert() with a brief comment
> about why the condition will never trigger.
> 
> 
>>>> +#define is_permission_fault(ap, perm) \
>>>> +    (((perm) & IOMMU_WO) && ((ap) & 0x2))
>>>
>>> Don't we also need to check AP bit 1 in some cases?
>>> (when the StreamWorld is S or NS EL1 and either (a) the incoming
>>> transaction has its attrs.user = 1 and STE.PRIVCFG is 0b0x, or
>>> (b) STE.PRIVCFG is 0b10).
>> I think I don't need to as I don't support this feature at the moment:
>> spec says:
>> "When SMMU_IDR1.ATTR_PERMS_OVR=0, this field is RES0 and the incoming
>> PRIV attribute is used."
>> But to be honest I was not aware this existed ;()
> 
> I think you still need to check the incoming transaction
> for user vs priv, even if you don't support STE.PRIVCFG.

On the CPU side, you have MemTxAttrs as input from get_phys_addr_lpae().

On IOMMU side, the current input callback for translation is

static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr
addr, IOMMUAccessFlags flag)

where IOMMUAccessFlags just is R/W access flag.

So I am not sure I have acess to those user/priv attributes.
> 
>>>> +
>>>> +#define PTE_AP_TO_PERM(ap) \
>>>> +    (IOMMU_ACCESS_FLAG(true, !((ap) & 0x2)))
>>>
>>> Similarly here.
>> ?
> 
> Can't just ignore AP bit 1 (or 0, if you're counting it that way).

with AP, the LSB is associated to EL0 rights. Similarly, given the
translation callback in use, is it something relevant as of now?

with APTable, the LSB bit is associated to EL0 as well
APTable[1] = 1, access at EL0 not permitted

In my case, can't I consider all accesses are priviledged?

Thanks

Eric
> 
> 
> thanks
> -- PMM
> 
