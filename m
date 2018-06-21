Received: from eggs.gnu.org ([2001:4830:134:3::10]:45054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fVyG7-0005Ss-EA
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1fVyG1-0005fE-28
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:00:15 -0400
References: <1528403460-30526-1-git-send-email-gengdongjiu@huawei.com>
	<1528403460-30526-3-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA_k_-6LuMw_Av9sAvkBeb7OvvZnsppd=1aF6RYydOH=YQ@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <0af82400-4131-d236-4929-8514d899ca9f@huawei.com>
Date: Thu, 21 Jun 2018 19:59:01 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_k_-6LuMw_Av9sAvkBeb7OvvZnsppd=1aF6RYydOH=YQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 RFC 2/2] target: arm: Add support for
 VCPU event states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: James Morse <james.morse@arm.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU
	Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>

Hi peter,
   Thanks for the review.

On 2018/6/21 0:56, Peter Maydell wrote:
> On 7 June 2018 at 21:31, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>> This patch extends the qemu-kvm state sync logic with support for
>> KVM_GET/SET_VCPU_EVENTS, giving access to yet missing SError exception.
>> And also it can support the exception state migration.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  target/arm/cpu.h     |  5 ++++
>>  target/arm/kvm64.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  target/arm/machine.c |  3 +++
>>  3 files changed, 72 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 8488273..b3d6682 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -645,6 +645,11 @@ typedef struct CPUARMState {
>>      const struct arm_boot_info *boot_info;
>>      /* Store GICv3CPUState to access from this struct */
>>      void *gicv3state;
>> +    struct {
>> +        uint32_t pending;
>> +        uint32_t has_esr;
>> +        uint64_t esr;
>> +    } serror;
> 
> What is this state? That is, what guest CPU architectural state
> is it supposed to correspond to?
The guest CPU architectural can be arm64 CPU with RAS extension. so before
kvm_put_vcpu_events() sets the vcpu events, it firstly checks whether  CPU architectural support
RAS extension through kvm_can_set_vcpu_esr().

---------------------------------------------------------------------
static int kvm_put_vcpu_events(ARMCPU *cpu)
{
    ........................................
    if (kvm_can_set_vcpu_esr(cpu)) {
        events.exception.serror_has_esr = env->serror.has_esr;
        events.exception.serror_esr = env->serror.esr;
    }

    ...............................................
}
------------------------------------------------------------------

> 
>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>> index 2e28d08..5a359f4 100644
>> --- a/target/arm/machine.c
>> +++ b/target/arm/machine.c
>> @@ -695,6 +695,9 @@ const VMStateDescription vmstate_arm_cpu = {
>>          VMSTATE_UINT32(env.exception.syndrome, ARMCPU),
>>          VMSTATE_UINT32(env.exception.fsr, ARMCPU),
>>          VMSTATE_UINT64(env.exception.vaddress, ARMCPU),
>> +        VMSTATE_UINT32(env.serror.pending, ARMCPU),
>> +        VMSTATE_UINT32(env.serror.has_esr, ARMCPU),
>> +        VMSTATE_UINT64(env.serror.esr, ARMCPU),
>>          VMSTATE_TIMER_PTR(gt_timer[GTIMER_PHYS], ARMCPU),
>>          VMSTATE_TIMER_PTR(gt_timer[GTIMER_VIRT], ARMCPU),
>>          {
> 
> You can't just add fields like this, as it breaks migration
> compatibility. If these need to be migrated then you need a
> new subsection with a suitable 'needed' function controlling
> whether it is present. But we should determine first
> whether this really is new guest CPU state...

I know your means. I will modify it according to the patch[1], which is used to do SVE migration.
Now I use this API kvm_can_set_vcpu_esr() to check the new guest CPU state. The kvm_can_set_vcpu_esr()
will check whether CPU architectural supports RAS extension.

-------------------------------------------------------------
static bool kvm_can_set_vcpu_esr(ARMCPU *cpu)
{
    CPUState *cs = CPU(cpu);

    int ret = kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_INJECT_SERROR_ESR);
    return (ret) ? true : false;
}
-----------------------------------------------------------------

[1]: https://git.qemu.org/?p=qemu.git;a=commitdiff;h=ef401601d5561f9805102695d5e65d72594f7020

> 
> thanks
> -- PMM
> 
> .
> 
