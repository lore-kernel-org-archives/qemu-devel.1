Received: from eggs.gnu.org ([2001:4830:134:3::10]:36140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUYYr-0001X4-TM
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 08:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUYYq-0000q4-Pi
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 08:49:29 -0500
Date: Thu, 28 Dec 2017 14:49:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171228144910.49fad2a9@igors-macbook-pro.local>
In-Reply-To: <1514440458-10515-6-git-send-email-gengdongjiu@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-6-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

On Thu, 28 Dec 2017 13:54:14 +0800
Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> Add synchronous external abort injection logic, setup
> exception type and syndrome value. When switch to guest,
> guest will jump to the synchronous external abort vector
> table entry.
> 
> The ESR_ELx.DFSC is set to synchronous external abort(0x10),
> and ESR_ELx.FnV is set to not valid(0x1), which will tell
> guest that FAR is not valid and holds an UNKNOWN value.
> These value will be set to KVM register structures through
> KVM_SET_ONE_REG IOCTL.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> Marc is against that KVM inject the synchronous external abort(SEA) in [1],
> so user space how to inject it. The test result that injection SEA to guest by Qemu
> is shown in [2].
is it possible to inject SEA when running in TCG mode?

it would be useful from testing/verification point of view
(i.e. we could test logic on non ARM host during 'make check')


> [1]: https://lkml.org/lkml/2017/3/2/110
> [2]:
> Taking exception 4 [Data Abort]
> ...from EL0 to EL1
> ...with ESR 0x24/0x92000410
> ...with FAR 0x0
> ...with ELR 0x40cf04
> ...to EL1 PC 0xffffffc000084c00 PSTATE 0x3c5
> after kvm_inject_arm_sea
> Unhandled fault: synchronous external abort (0x92000410) at 0x0000007fa234c12c
> CPU: 0 PID: 536 Comm: devmem Not tainted 4.1.0+ #20
> Hardware name: linux,dummy-virt (DT)
> task: ffffffc019ab2b00 ti: ffffffc008134000 task.ti: ffffffc008134000
> PC is at 0x40cf04
> LR is at 0x40cdec
> pc : [<000000000040cf04>] lr : [<000000000040cdec>] pstate: 60000000
> sp : 0000007ff7b24130
> x29: 0000007ff7b24260 x28: 0000000000000000
> x27: 00000000000000ad x26: 000000000049c000
> x25: 000000000048904b x24: 000000000049c000
> x23: 0000000040600000 x22: 0000007ff7b243a0
> x21: 0000000000000002 x20: 0000000000000000
> x19: 0000000000000020 x18: 0000000000000000
> x17: 000000000049c6d0 x16: 0000007fa22c85c0
> x15: 0000000000005798 x14: 0000007fa2205f1c
> x13: 0000007fa241ccb0 x12: 0000000000000137
> x11: 0000000000000000 x10: 0000000000000000
> x9 : 0000000000000000 x8 : 00000000000000de
> x7 : 0000000000000000 x6 : 0000000000002000
> x5 : 0000000040600000 x4 : 0000000000000003
> x3 : 0000000000000001 x2 : 0000000000000000
> x1 : 0000000000000000 x0 : 0000007fa2418000
> ---
>  target/arm/kvm64.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index a16abc8..c00450d 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -582,6 +582,71 @@ int kvm_arm_cpreg_level(uint64_t regidx)
>      return KVM_PUT_RUNTIME_STATE;
>  }
>  
> +static int kvm_arm_cpreg_value(ARMCPU *cpu, ptrdiff_t fieldoffset)
> +{
> +    int i;
> +
> +    for (i = 0; i < cpu->cpreg_array_len; i++) {
> +        uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
> +        const ARMCPRegInfo *ri;
> +        ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
> +        if (!ri) {
> +            continue;
> +        }
> +
> +        if (ri->type & ARM_CP_NO_RAW) {
> +            continue;
> +        }
> +
> +        if (ri->fieldoffset == fieldoffset) {
> +            cpu->cpreg_values[i] = read_raw_cp_reg(&cpu->env, ri);
> +            return 0;
> +        }
> +    }
> +    return -EINVAL;
> +}
> +
> +/* Inject synchronous external abort */
> +static void kvm_inject_arm_sea(CPUState *c)
> +{
> +    ARMCPU *cpu = ARM_CPU(c);
> +    CPUARMState *env = &cpu->env;
> +    unsigned long cpsr = pstate_read(env);
> +    uint32_t esr, ret;
> +
> +    /* This exception is synchronous data abort*/
> +    c->exception_index = EXCP_DATA_ABORT;
> +    /* Inject the exception to guest El1 */
> +    env->exception.target_el = 1;
> +    CPUClass *cc = CPU_GET_CLASS(c);
> +
> +    /* Set the DFSC to synchronous external abort and set FnV to not valid,
> +     * this will tell guest the FAR_ELx is UNKNOWN for this abort.
> +     */
> +    esr = (0x10 | (1 << 10));
> +
> +    /* This exception comes from lower or current exception level. */
> +    if ((cpsr & 0xf) == PSTATE_MODE_EL0t) {
> +        esr |= (EC_DATAABORT << ARM_EL_EC_SHIFT);
> +    } else {
> +        esr |= (EC_DATAABORT_SAME_EL << ARM_EL_EC_SHIFT);
> +    }
> +
> +    /* For the AArch64, instruction length is 32-bit */
> +    esr |= ARM_EL_IL;
> +    env->exception.syndrome = esr;
> +
> +    cc->do_interrupt(c);
> +
> +    /* set ESR_EL1 */
> +    ret = kvm_arm_cpreg_value(cpu, offsetof(CPUARMState, cp15.esr_el[1]));
> +
> +    if (ret) {
> +        fprintf(stderr, "<%s> failed to set esr_el1\n", __func__);
> +        abort();
> +    }
> +}
> +
>  #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
>                   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>  
