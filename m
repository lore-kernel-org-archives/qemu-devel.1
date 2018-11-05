Received: from eggs.gnu.org ([2001:4830:134:3::10]:50513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1gJdMS-0007Gv-6p
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1gJdMR-00082O-3l
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:48:04 -0500
Date: Mon, 5 Nov 2018 11:47:51 +0000
From: Mark Rutland <mark.rutland@arm.com>
Message-ID: <20181105114751.7d3xulnflnmamjbq@lakrids.cambridge.arm.com>
References: <20181102145433.4553-1-richard.henderson@linaro.org>
	<CAFEAcA_tcR_33Q+2ZFHdzo4_9khXggum=gRfZ8+L49KmP3hHiw@mail.gmail.com>
	<20181102193529.GB12057@e113682-lin.lund.arm.com>
	<effa3839-f0ab-e6ab-e034-a1a6d1d06923@linaro.org>
	<20181103123246.16b5b101@why.wild-wind.fr.eu.org>
	<1ee4127a-aa3e-4e19-1dde-af83147f8bc4@linaro.org>
	<86zhupdr03.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86zhupdr03.wl-marc.zyngier@arm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/arm: KVM vs ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Christoffer Dall <christoffer.dall@arm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Dave Martin <Dave.Martin@arm.com>

On Sun, Nov 04, 2018 at 11:25:00AM +0000, Marc Zyngier wrote:
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 22fbbdbece3c..d50f912d3f4a 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -314,10 +314,15 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
>  		return read_zero(vcpu, p);
>  }
>  
> -static bool trap_undef(struct kvm_vcpu *vcpu,
> -		       struct sys_reg_params *p,
> -		       const struct sys_reg_desc *r)

We should probably have a comment here, like:

/*
 * ARMv8.1 mandates at least a trivial LORegion implementation, where
 * all the RW registers are RES0 (which we can implement as RAZ/WI). On
 * an ARMv8.0 system, these registers should UNDEF.
 */

> +static bool trap_loregion(struct kvm_vcpu *vcpu,
> +			  struct sys_reg_params *p,
> +			  const struct sys_reg_desc *r)
>  {
> +	u64 val = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> +
> +	if (val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))
> +		return trap_raz_wi(vcpu, p, r);
> +
>  	kvm_inject_undefined(vcpu);
>  	return false;
>  }
> @@ -1040,11 +1045,6 @@ static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
>  			kvm_debug("SVE unsupported for guests, suppressing\n");
>  
>  		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> -	} else if (id == SYS_ID_AA64MMFR1_EL1) {
> -		if (val & (0xfUL << ID_AA64MMFR1_LOR_SHIFT))
> -			kvm_debug("LORegions unsupported for guests, suppressing\n");
> -
> -		val &= ~(0xfUL << ID_AA64MMFR1_LOR_SHIFT);
>  	}
>  
>  	return val;
> @@ -1330,11 +1330,11 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
>  	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
>  
> -	{ SYS_DESC(SYS_LORSA_EL1), trap_undef },
> -	{ SYS_DESC(SYS_LOREA_EL1), trap_undef },
> -	{ SYS_DESC(SYS_LORN_EL1), trap_undef },
> -	{ SYS_DESC(SYS_LORC_EL1), trap_undef },
> -	{ SYS_DESC(SYS_LORID_EL1), trap_undef },
> +	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
> +	{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
> +	{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
> +	{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
> +	{ SYS_DESC(SYS_LORID_EL1), trap_loregion },

LORID_EL1 is always RO, so we need to UNDEF on writes. Either we add a
separate helper, or special-case LORID_EL1 in trap_loregion().

Otherwise, this looks good to me.

Thanks,
Mark.
