Received: from eggs.gnu.org ([2001:4830:134:3::10]:51413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eaEKe-0004or-OD
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eaEKd-0002lg-Ro
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:26:16 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-6-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA-RC6hUMR5jPrgOB7nkWjXaPxo6dYEXO=kgC=59k7EVrw@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <f6853acc-ca07-9627-32e6-91240c6669b7@huawei.com>
Date: Sat, 13 Jan 2018 13:24:16 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RC6hUMR5jPrgOB7nkWjXaPxo6dYEXO=kgC=59k7EVrw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 5/9] target-arm: kvm64: inject
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, James
	Morse <james.morse@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, kvm-devel <kvm@vger.kernel.org>, QEMU
	Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Xu Wei <xuwei5@hisilicon.com>

Hi Peter,

>> +static int kvm_arm_cpreg_value(ARMCPU *cpu, ptrdiff_t fieldoffset)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < cpu->cpreg_array_len; i++) {
> 
> This is still absolutely the wrong thing to do. Nothing should
> need to scan this array like this.

For the KVM mode, I use this function to set the ESR_ELx's value. If not set it using this way, do you have better method? Thanks!
>From my test, if kvm_inject_arm_sea() does not call this function kvm_arm_cpreg_value() to set the ESR_ELx's register, the guest
will have wrong ESR value. As shown the log in [1], QEMU sets the ESR to  0x96000414, but the guest's ESR value is 0x56000000 instead of 0x96000414.

[1]:
Taking exception 4 [Data Abort]
...from EL1 to EL1
...with ESR 0x25/0x96000414
...with FAR 0x0
...with ELR 0xffffff8008081a80
...to EL1 PC 0xffffff8008081a00 PSTATE 0x3c5

[   16.974756] Bad mode in Synchronous Abort handler detected on CPU0, code 0x56000000 -- SVC (AArch64)
[   16.989504] Internal error: Oops - bad mode: 0 [#1] SMP
[   16.990753] Modules linked in:
[   16.991462] CPU: 0 PID: 204 Comm: sh Tainted: G        W       4.13.0-rc4ajb-00005-g1353b1e-dirty #40
[   16.993533] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[   16.995083] task: ffffffc03d3c2b00 task.stack: ffffffc03d2b0000
[   16.996448] PC is at vectors+0x280/0x784
[   16.997340] LR is at pl011_tx_empty+0x18/0x40


> 
>> +        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
>> +        const ARMCPRegInfo *ri;
>> +        ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
>> +        if (!ri) {
>> +            continue;
>> +        }

[...]

> 
>> +
>> +    /* For the AArch64, instruction length is 32-bit */
>> +    esr |= ARM_EL_IL;
>> +    env->exception.syndrome = esr;
>> +
>> +    cc->do_interrupt(c);
>> +
>> +    /* set ESR_EL1 */
>> +    ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.esr_el[1]));
> 
> Breakpoint injection doesn't need to do this. Neither should this code.
As my above explanation, in the KVM mode, it needs to set the ESR_ELx in extra method.
the cc->do_interrupt(c) does not set ESR_ELx. so I use kvm_arm_cpreg_value()
to set it. whether you have better method to set the ESR_Elx except for my method?  Thanks.


> 
>> +    if (ret) {
>> +        fprintf(stderr, "<%s> failed to set esr_el1\n", __func__);
>> +        abort();
>> +    }
>> +}
>> +
>>  #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
>>                   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>>
>> --
>> 1.8.3.1
> 
> thanks
> -- PMM
> 
> .
> 
