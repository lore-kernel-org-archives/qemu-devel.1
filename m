Received: from eggs.gnu.org ([2001:4830:134:3::10]:50155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTMh-0008Oc-OO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTMg-0001p9-OF
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:14:03 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjTMg-0001os-HJ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:14:02 -0500
Received: by mail-wm0-x229.google.com with SMTP id i17so3709132wmf.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 08:14:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227173706.15210-3-drjones@redhat.com>
References: <20170227173706.15210-1-drjones@redhat.com>
	<20170227173706.15210-3-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 16:13:40 +0000
Message-ID: <CAFEAcA-ScxCc5-pizNjeV4S_NpNziWWmVTbP+zAs2KCY=V0wyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/2] arm: kvm: set MPIDR when we can
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Igor Mammedov <imammedo@redhat.com>

On 27 February 2017 at 17:37, Andrew Jones <drjones@redhat.com> wrote:
> If KVM supports user provided MPIDRs for the vcpus, then provide
> them. This simplifies management of vcpus as we can be sure of
> the identity of a vcpu even before it's been instantiated.
>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.c   |  3 +--
>  target/arm/kvm32.c | 22 ++++++++++++++--------
>  target/arm/kvm64.c | 22 ++++++++++++++--------
>  3 files changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f7157dc0e59d..83cd5eefbef8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -741,8 +741,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>
> -    /* This cpu-id-to-MPIDR affinity is used only for TCG; KVM will override it.
> -     * We don't support setting cluster ID ([16..23]) (known as Aff2
> +    /* We don't currently support setting cluster ID ([16..23]) (known as Aff2
>       * in later ARM ARM versions), or any of the higher affinity level fields,
>       * so these bits always RAZ.
>       */
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index 069da0c5fd10..5ad732498e5c 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -186,7 +186,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      int ret;
>      uint64_t v;
> -    uint32_t mpidr;
>      struct kvm_one_reg r;
>      ARMCPU *cpu = ARM_CPU(cs);
>
> @@ -223,16 +222,23 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return -EINVAL;
>      }
>
> -    /*
> -     * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
> -     * Currently KVM has its own idea about MPIDR assignment, so we
> -     * override our defaults with what we get from KVM.
> -     */
> -    ret = kvm_get_one_reg(cs, ARM_CP15_REG32(ARM_CPU_ID_MPIDR), &mpidr);
> +    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_USER_MPIDR)) {
> +        ret = kvm_set_one_reg(cs, ARM_CP15_REG32(ARM_CPU_ID_MPIDR),
> +                              &cpu->mp_affinity);

mp_affinity is only the affinity bits of the MPIDR. I would expect
the kernel set_one_reg interface for the MPIDR to want a complete
MPIDR value with M, U and MT bits.

(compare the way that when we set mp_affinity from the kernel
reg. value we mask out the bits we don't care about).

Similarly with the 64-bit version of this code.

> +    } else {
> +        /* If we can't set the MPIDR, then KVM will generate one. We must
> +         * update our copy to that one in order to stay synchronized.
> +         */
> +        uint32_t mpidr;
> +
> +        ret = kvm_get_one_reg(cs, ARM_CP15_REG32(ARM_CPU_ID_MPIDR), &mpidr);
> +        if (!ret) {
> +            cpu->mp_affinity = mpidr & ARM32_AFFINITY_MASK;
> +        }
> +    }
>      if (ret) {
>          return ret;
>      }
> -    cpu->mp_affinity = mpidr & ARM32_AFFINITY_MASK;
>
>      return kvm_arm_init_cpreg_list(cpu);

Otherwise this looks fine to me.

PS: I assume we are targeting 2.10 (or whatever we call it) with this.

thanks
-- PMM
