Received: from eggs.gnu.org ([2001:4830:134:3::10]:33644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eEmHu-0004Bq-FT
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eEmHs-0008De-37
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 20:14:45 -0500
MIME-Version: 1.0
In-Reply-To: <1510066898-3725-1-git-send-email-peter.maydell@linaro.org>
References: <1510066898-3725-1-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Nov 2017 17:14:09 -0800
Message-ID: <CAKmqyKORH2jwGP4ULZv6B8=262OhznHkwOzONd9HFQoJkKzD=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11] target/arm: Report GICv3 sysregs
 present in ID registers if needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Patch Tracking <patches@linaro.org>

On Tue, Nov 7, 2017 at 7:01 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> The CPU ID registers ID_AA64PFR0_EL1, ID_PFR1_EL1 and ID_PFR1
> have a field for reporting presence of GICv3 system registers.
> We need to report this field correctly in order for Xen to
> work as a guest inside QEMU emulation. We mustn't incorrectly
> claim the sysregs exist when they don't, though, or Linux will
> crash.
>
> Unfortunately the way we've designed the GICv3 emulation in QEMU
> puts the system registers as part of the GICv3 device, which
> may be created after the CPU proper has been realized. This
> means that we don't know at the point when we define the ID
> registers what the correct value is. Handle this by switching
> them to calling a function at runtime to read the value, where
> we can fill in the GIC field appropriately.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Is this going to make it into 2.11?

Alistair

> ---
> In retrospect I think having the sysregs emulation in the
> GIC device was a bit of a design error -- we should have
> split it like the hardware does, with a defined protocol
> between the GIC and the CPU interface. (In real hardware the
> CPU can have the GIC system registers even though it's not
> connected to an actual GICv3, and we don't/can't emulate
> that with our current design.)
> ---
>  target/arm/helper.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f61fb3e..35c5bd6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4549,6 +4549,33 @@ static void define_debug_regs(ARMCPU *cpu)
>      }
>  }
>
> +/* We don't know until after realize whether there's a GICv3
> + * attached, and that is what registers the gicv3 sysregs.
> + * So we have to fill in the GIC fields in ID_PFR/ID_PFR1_EL1/ID_AA64PFR0_EL1
> + * at runtime.
> + */
> +static uint64_t id_pfr1_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    ARMCPU *cpu = arm_env_get_cpu(env);
> +    uint64_t pfr1 = cpu->id_pfr1;
> +
> +    if (env->gicv3state) {
> +        pfr1 |= 1 << 28;
> +    }
> +    return pfr1;
> +}
> +
> +static uint64_t id_aa64pfr0_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    ARMCPU *cpu = arm_env_get_cpu(env);
> +    uint64_t pfr0 = cpu->id_aa64pfr0;
> +
> +    if (env->gicv3state) {
> +        pfr0 |= 1 << 24;
> +    }
> +    return pfr0;
> +}
> +
>  void register_cp_regs_for_features(ARMCPU *cpu)
>  {
>      /* Register all the coprocessor registers based on feature bits */
> @@ -4573,10 +4600,14 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 0,
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .resetvalue = cpu->id_pfr0 },
> +            /* ID_PFR1 is not a plain ARM_CP_CONST because we don't know
> +             * the value of the GIC field until after we define these regs.
> +             */
>              { .name = "ID_PFR1", .state = ARM_CP_STATE_BOTH,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 1,
> -              .access = PL1_R, .type = ARM_CP_CONST,
> -              .resetvalue = cpu->id_pfr1 },
> +              .access = PL1_R, .type = ARM_CP_NO_RAW,
> +              .readfn = id_pfr1_read,
> +              .writefn = arm_cp_write_ignore },
>              { .name = "ID_DFR0", .state = ARM_CP_STATE_BOTH,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
>                .access = PL1_R, .type = ARM_CP_CONST,
> @@ -4692,10 +4723,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>           * define new registers here.
>           */
>          ARMCPRegInfo v8_idregs[] = {
> +            /* ID_AA64PFR0_EL1 is not a plain ARM_CP_CONST because we don't
> +             * know the right value for the GIC field until after we
> +             * define these regs.
> +             */
>              { .name = "ID_AA64PFR0_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 0,
> -              .access = PL1_R, .type = ARM_CP_CONST,
> -              .resetvalue = cpu->id_aa64pfr0 },
> +              .access = PL1_R, .type = ARM_CP_NO_RAW,
> +              .readfn = id_aa64pfr0_read,
> +              .writefn = arm_cp_write_ignore },
>              { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
>                .access = PL1_R, .type = ARM_CP_CONST,
> --
> 2.7.4
>
>
