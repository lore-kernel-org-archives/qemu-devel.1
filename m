Received: from eggs.gnu.org ([2001:4830:134:3::10]:60726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gQSFO-00062T-8I
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 02:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gQS9k-0001mu-6p
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 02:15:09 -0500
References: <0184EA26B2509940AA629AE1405DD7F201F7BBE8@DGGEMA503-MBX.china.huawei.com>
	<CAFEAcA_abaoxA=myPszVrO59-hSazHAePRJXUCHKSFnoEdsfiw@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <997764b7-64b6-20f4-a38d-baefb055cff9@huawei.com>
Date: Sat, 24 Nov 2018 15:14:36 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_abaoxA=myPszVrO59-hSazHAePRJXUCHKSFnoEdsfiw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v15 08/10] target-arm: kvm64: inject
 synchronous External Abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Zheng Xiang <zhengxiang9@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Peter,

On 2018/11/24 2:45, Peter Maydell wrote:
> On Wed, 21 Nov 2018 at 14:34, gengdongjiu <gengdongjiu@huawei.com> wrote:
>>
>> Hi Peter,
>>   Thanks for the review and comments.
>>
>>>
>>> On 8 November 2018 at 10:29, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>>> +bool write_part_cpustate_to_list(ARMCPU *cpu, ptrdiff_t fieldoffset)
>>>
>>> What is this about? Nothing else in QEMU needs to mess with the cpustate synchronization. My first assumption is that you should not
>>> need to do so either.
>>
>> We should change the guest CP15 ESR_EL1's value, the only method is to change the cpu->cpreg_values[] in QEMU, then QEMU call write_list_to_kvmstate()
>> to set the cpu->cpreg_values[] to KVM which include the specified ESR_EL1 value, KVM do world switch, and then set the specified ESR_EL1's value to guest kernel.
> 
> Ah, I see. This is a bug in our current handling of the register
> state, where we implicitly assume that nothing in QEMU will ever
> want to change any system register values. This assumption is
> now false -- kvm_arm_handle_debug() broke it -- so we need to
> fix the code that does kvm_arch_put_registers(). There is a comment
> in the kvm32.c version of that function about this. (The kvm64.c
> version has the same assumption but doesn't comment on it.)
> 
> We should (ideally) fix this bug in the code that does register
> syncing, without requiring places in QEMU that update system
> registers to have to manually indicate which registers they have
> changed. I'll have a think about how best to do this.

Ok, it is great that you will think about it, waiting for your wonderful solution

> 
>> About the detailed explanation, as shown in [2].
>>
>> kvm_arm_handle_debug() does not need to do this because QEMU does not need to change CP15 registers, such as ESR_EL1.
> 
> kvm_arm_handle_debug does change ESR_EL1: it is injecting an exception
> and so should set the exception register. This happens when it
> calls the do_interrupt() hook, because arm_cpu_do_interrupt_aarch64()
> writes to env->cp15.esr_el[new_el].

Yes, I see it, but the env->cp15.esr_el[new_el] shouldn't be successfully set to KVM when call kvm_arch_put_registers()

> 
> I'm not entirely sure why this is working today, in fact.
> Alex, did you test whether our debug-exception-injection
> reports the correct ESR_EL1 to the guest ?

Alex?

> 
>>>> +/* Inject synchronous external abort */ static void
>>>> +kvm_inject_arm_sea(CPUState *c) {
>>>> +    ARMCPU *cpu = ARM_CPU(c);
>>>> +    CPUARMState *env = &cpu->env;
>>>> +    CPUClass *cc = CPU_GET_CLASS(c);
>>>> +    uint32_t esr;
>>>> +    int ret;
>>>> +
>>>> +    /* This exception is synchronous data abort */
>>>> +    c->exception_index = EXCP_DATA_ABORT;
>>>> +    /* Inject the exception to guest EL1 */
>>>> +    env->exception.target_el = 1;
>>>
>>> These comments don't tell us anything that the code does not.
>>
>>  Thanks, do you mean I need to remove it or add more detailed comments to it?
> 
> As a rule of thumb, comments should provide information to
> the reader which they wouldn't get if they only had the code.
> Comments often answer the "why do we do this" question, or
> provide an overall summary of what the code is going to do,
> or refer to an external source (a datasheet, an algorithm)
> that is necessary to understand the code. It's better to
> avoid comments that say "what the code is doing" at a line-by-line
> level, because the code itself already answers the "what"
> question at that level of detail.

sure, got it, thanks for the explanation and guidelines.

> 
> thanks
> -- PMM
> 
> .
> 
