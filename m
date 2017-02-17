Received: from eggs.gnu.org ([2001:4830:134:3::10]:56561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1ceeg3-0006sj-KH
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1ceeg2-0004QZ-Q4
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:18:07 -0500
MIME-Version: 1.0
In-Reply-To: <bebfa013-8627-83d2-85bc-7ae55131ea48@redhat.com>
References: <1485879782-6075-1-git-send-email-vijay.kilari@gmail.com>
	<1485879782-6075-3-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA_K2TcihHTTrrr7kZ3pGZ3BNptDb0mt5Rc0YinkGD1eHQ@mail.gmail.com>
	<CALicx6v7B3145pJXsOcgGass8xG4HHY7=iA6gEHKbMcHxqQD-A@mail.gmail.com>
	<bebfa013-8627-83d2-85bc-7ae55131ea48@redhat.com>
From: Vijay Kilari <vijay.kilari@gmail.com>
Date: Fri, 17 Feb 2017 14:47:59 +0530
Message-ID: <CALicx6uX8zn7FTBYW5kgAzZorDWRSn=S4WM1TqB37KRK_Disgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 RESEND 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On Fri, Feb 17, 2017 at 2:30 PM, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Vijaya,
>
> On 13/02/2017 13:17, Vijay Kilari wrote:
>> On Tue, Feb 7, 2017 at 8:09 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 31 January 2017 at 16:22,  <vijay.kilari@gmail.com> wrote:
>>>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>>>
>>>> To Save and Restore ICC_SRE_EL1 register Add ICC_SRE_EL1 register
>>>> to vmstate and GICv3CPUState struct.
>>>>
>>>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>>> ---
>>>>  hw/intc/arm_gicv3_common.c         | 1 +
>>>>  include/hw/intc/arm_gicv3_common.h | 1 +
>>>>  2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
>>>> index 0f8c4b8..f3245d9 100644
>>>> --- a/hw/intc/arm_gicv3_common.c
>>>> +++ b/hw/intc/arm_gicv3_common.c
>>>> @@ -68,6 +68,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>>>>          VMSTATE_UINT32(gicr_igrpmodr0, GICv3CPUState),
>>>>          VMSTATE_UINT32(gicr_nsacr, GICv3CPUState),
>>>>          VMSTATE_UINT8_ARRAY(gicr_ipriorityr, GICv3CPUState, GIC_INTERNAL),
>>>> +        VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
>>>>          VMSTATE_UINT64_ARRAY(icc_ctlr_el1, GICv3CPUState, 2),
>>>>          VMSTATE_UINT64(icc_pmr_el1, GICv3CPUState),
>>>>          VMSTATE_UINT64_ARRAY(icc_bpr, GICv3CPUState, 3),
>>>> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
>>>> index 341a311..183c7f8 100644
>>>> --- a/include/hw/intc/arm_gicv3_common.h
>>>> +++ b/include/hw/intc/arm_gicv3_common.h
>>>> @@ -166,6 +166,7 @@ struct GICv3CPUState {
>>>>      uint8_t gicr_ipriorityr[GIC_INTERNAL];
>>>>
>>>>      /* CPU interface */
>>>> +    uint64_t icc_sre_el1;
>>>>      uint64_t icc_ctlr_el1[2];
>>>>      uint64_t icc_pmr_el1;
>>>>      uint64_t icc_bpr[3];
>>>
>>> This breaks migration compatibility for TCG using GICv3; you
>>> need to do something here with a VMState subsection so
>>> the new register is only transferred if it's non-zero.
>>
>> So, you mean to put a check in kvm_arm_gicv3_put() and
>> kvm_arm_gicv3_get() to check for non-zero value?
>> icc_sre_el1 is always non-zero reset to 0xf in TCG and 0x7 in KVM mode.
> In hw/intc/arm_gicv3_cpuif.c we have
>     { .name = "ICC_SRE_EL1", .state = ARM_CP_STATE_BOTH,
>         ../..
>       .resetvalue = 0x7,
>     },
> where did you find the TCG reset value equal to 0xF? I am not able to
> find it.

Sorry, I have referred to ICC_SRE_EL2/3. 0x7 is correct
