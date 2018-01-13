Received: from eggs.gnu.org ([2001:4830:134:3::10]:58110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eaHCe-0004oc-7P
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 03:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eaHCU-0001AM-7h
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 03:30:12 -0500
From: gengdongjiu <gengdongjiu@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-6-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA-RC6hUMR5jPrgOB7nkWjXaPxo6dYEXO=kgC=59k7EVrw@mail.gmail.com>
	<f6853acc-ca07-9627-32e6-91240c6669b7@huawei.com>
Message-ID: <bf79cd19-c1d0-16db-7d6b-36784bc8aa02@huawei.com>
Date: Sat, 13 Jan 2018 16:27:33 +0800
MIME-Version: 1.0
In-Reply-To: <f6853acc-ca07-9627-32e6-91240c6669b7@huawei.com>
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

On 2018/1/13 13:24, gengdongjiu wrote:
>>> +
>>> +    /* For the AArch64, instruction length is 32-bit */
>>> +    esr |= ARM_EL_IL;
>>> +    env->exception.syndrome = esr;
>>> +
>>> +    cc->do_interrupt(c);
>>> +
>>> +    /* set ESR_EL1 */
>>> +    ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.esr_el[1]));
>> Breakpoint injection doesn't need to do this. Neither should this code.
> As my above explanation, in the KVM mode, it needs to set the ESR_ELx in extra method.
> the cc->do_interrupt(c) does not set ESR_ELx. so I use kvm_arm_cpreg_value()
> to set it. whether you have better method to set the ESR_Elx except for my method?  Thanks.

If QEMU changes the KVM's registers, it needs to call write_list_to_kvmstate() to write the cpu->cpreg_values[] list
to KVM through KVM_SET_ONE_REG IOCTL[1]. In Qemu, now it should not have software path to change the cpu->cpreg_values[] list
except write_cpustate_to_list(). Here I can also call write_cpustate_to_list() instead of kvm_arm_cpreg_value() to change
cpu->cpreg_values[] list, but the write_cpustate_to_list() will write all the coprocessor state to the cpu->cpreg_values[] list,
we can not sure all the coprocessor states are right, so here I only change corresponding index value in this list using kvm_arm_cpreg_value().

Breakpoint injection that you mentioned should not change KVM register or not in the KVM mode.

[1]:
 kvm_arch_put_registers()
  -> write_list_to_kvmstate()
    -> write cpu->cpreg_values[] to the kernel KVM through KVM_SET_ONE_REG

> 
> 
>>> +    if (ret) {
>>> +        fprintf(stderr, "<%s> failed to set esr_el1\n", __func__);
>>> +        abort();
>>> +    }
>>> +}
>>> +
>>>  #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
>>>                   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>>>
>>> --
>>> 1.8.3.1
