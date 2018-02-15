Received: from eggs.gnu.org ([2001:4830:134:3::10]:57857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emNwF-0000mL-Sf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emNwE-0004K8-Tw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:07:19 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emNwE-0004Js-MP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:07:18 -0500
Received: by mail-oi0-x244.google.com with SMTP id 24so454334oij.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:07:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215175707.15491-3-peter.maydell@linaro.org>
References: <20180215175707.15491-1-peter.maydell@linaro.org>
	<20180215175707.15491-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 18:06:57 +0000
Message-ID: <CAFEAcA_UWVgwEsTq2Tebn+yL5Ckd_7_S_wUvsKMDZfEHxr9stQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/boot: Honour CPU's address
 space for image loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 15 February 2018 at 17:57, Peter Maydell <peter.maydell@linaro.org> wrote:
> Instead of loading kernels, device trees, and the like to
> the system address space, use the CPU's address space. This
> is important if we're trying to load the file to memory or
> via an alias memory region that is provided by an SoC
> object and thus not mapped into the system address space.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/boot.c | 119 +++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 76 insertions(+), 43 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 9b174b982c..0eac655c98 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -35,6 +35,25 @@
>  #define ARM64_TEXT_OFFSET_OFFSET    8
>  #define ARM64_MAGIC_OFFSET          56
>
> +static AddressSpace *arm_boot_addressspace(ARMCPU *cpu,
> +                                           const struct arm_boot_info *info)
> +{
> +    /* Return the address space to use for bootloader reads and writes.
> +     * We prefer the secure address space if the CPU has it and we're
> +     * going to boot the guest into it.
> +     */
> +    int asidx;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (arm_feature(&cpu->env, ARM_FEATURE_EL3) && info->secure_boot) {
> +        asidx = ARMASIdx_S;
> +    } else {
> +        asidx = ARMASIdx_NS;
> +    }
> +
> +    return cpu_get_address_space(cs, asidx);
> +}
> +
>  typedef enum {
>      FIXUP_NONE = 0,     /* do nothing */
>      FIXUP_TERMINATOR,   /* end of insns */
> @@ -124,7 +143,8 @@ static const ARMInsnFixup smpboot[] = {
>  };
>
>  static void write_bootloader(const char *name, hwaddr addr,
> -                             const ARMInsnFixup *insns, uint32_t *fixupcontext)
> +                             const ARMInsnFixup *insns, uint32_t *fixupcontext,
> +                             AddressSpace *as)
>  {
>      /* Fix up the specified bootloader fragment and write it into
>       * guest memory using rom_add_blob_fixed(). fixupcontext is
> @@ -163,7 +183,7 @@ static void write_bootloader(const char *name, hwaddr addr,
>          code[i] = tswap32(insn);
>      }
>
> -    rom_add_blob_fixed(name, code, len * sizeof(uint32_t), addr);
> +    rom_add_blob_fixed_as(name, code, len * sizeof(uint32_t), addr, as);
>
>      g_free(code);
>  }
> @@ -172,6 +192,7 @@ static void default_write_secondary(ARMCPU *cpu,
>                                      const struct arm_boot_info *info)
>  {
>      uint32_t fixupcontext[FIXUP_MAX];
> +    AddressSpace *as = CPU(cpu)->as;

Oops. This should be
    AddressSpace *as = arm_boot_addressspace(cpu, info);

>      fixupcontext[FIXUP_GIC_CPU_IF] = info->gic_cpu_if_addr;
>      fixupcontext[FIXUP_BOOTREG] = info->smp_bootreg_addr;
> @@ -182,13 +203,14 @@ static void default_write_secondary(ARMCPU *cpu,
>      }
>
>      write_bootloader("smpboot", info->smp_loader_start,
> -                     smpboot, fixupcontext);
> +                     smpboot, fixupcontext, as);
>  }
>
>  void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
>                                              const struct arm_boot_info *info,
>                                              hwaddr mvbar_addr)
>  {
> +    AddressSpace *as = CPU(cpu)->as;

...and so should this.

thanks
-- PMM
