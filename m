Received: from eggs.gnu.org ([2001:4830:134:3::10]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQnR-0007lD-P7
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffQnQ-0004Ib-H2
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:17:45 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffQnQ-0004IG-Ah
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:17:44 -0400
Received: by mail-oi0-x243.google.com with SMTP id n84-v6so2298464oib.9
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:17:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180714171601.5734-8-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
	<20180714171601.5734-8-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:17:23 +0100
Message-ID: <CAFEAcA-drY59TwsKaheA6zaocXb0L4bwdD+K=j4DKPJqfCkXYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 07/20] intc/arm_gic: Add virtualization
 extensions helper macros and functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 14 July 2018 at 18:15, Luc Michel <luc.michel@greensocs.com> wrote:
> Add some helper macros and functions related to the virtualization
> extensions to gic_internal.h.
>
> The GICH_LR_* macros help extracting specific fields of a list register
> value. The only tricky one is the priority field as only the MSB are
> stored. The value must be shifted accordingly to obtain the correct
> priority value.
>
> gic_is_vcpu() and gic_get_vcpu_real_id() help with (v)CPU id manipulation
> to abstract the fact that vCPU id are in the range
> [ GIC_NCPU; (GIC_NCPU + num_cpu) [.
>
> gic_lr_* and gic_virq_is_valid() help with the list registers.
> gic_get_lr_entry() returns the LR entry for a given (vCPU, irq) pair. It
> is meant to be used in contexts where we know for sure that the entry
> exists, so we assert that entry is actually found, and the caller can
> avoid the NULL check on the returned pointer.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c      |  5 +++
>  hw/intc/gic_internal.h | 75 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index aaa34426a1..1ac0fe740c 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -61,6 +61,11 @@ static inline int gic_get_current_cpu(GICState *s)
>      return 0;
>  }
>
> +static inline int gic_get_current_vcpu(GICState *s)
> +{
> +    return gic_get_current_cpu(s) + GIC_NCPU;
> +}
> +
>  /* Return true if this GIC config has interrupt groups, which is
>   * true if we're a GICv2, or a GICv1 with the security extensions.
>   */
> diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
> index 1aa888a576..56e203aeb9 100644
> --- a/hw/intc/gic_internal.h
> +++ b/hw/intc/gic_internal.h
> @@ -129,6 +129,20 @@ REG32(GICH_LR63, 0x1fc)
>       R_GICH_LR0_Priority_MASK | R_GICH_LR0_State_MASK | \
>       R_GICH_LR0_Grp1_MASK | R_GICH_LR0_HW_MASK)
>
> +#define GICH_LR_STATE_INVALID         0
> +#define GICH_LR_STATE_PENDING         1
> +#define GICH_LR_STATE_ACTIVE          2
> +#define GICH_LR_STATE_ACTIVE_PENDING  3
> +
> +#define GICH_LR_VIRT_ID(entry) (FIELD_EX32(entry, GICH_LR0, VirtualID))
> +#define GICH_LR_PHYS_ID(entry) (FIELD_EX32(entry, GICH_LR0, PhysicalID))
> +#define GICH_LR_CPUID(entry) (FIELD_EX32(entry, GICH_LR0, CPUID))
> +#define GICH_LR_EOI(entry) (FIELD_EX32(entry, GICH_LR0, EOI))
> +#define GICH_LR_PRIORITY(entry) (FIELD_EX32(entry, GICH_LR0, Priority) << 3)
> +#define GICH_LR_STATE(entry) (FIELD_EX32(entry, GICH_LR0, State))
> +#define GICH_LR_GROUP(entry) (FIELD_EX32(entry, GICH_LR0, Grp1))
> +#define GICH_LR_HW(entry) (FIELD_EX32(entry, GICH_LR0, HW))
> +
>  /* Valid bits for GICC_CTLR for GICv1, v1 with security extensions,
>   * GICv2 and GICv2 with security extensions:
>   */
> @@ -164,4 +178,65 @@ static inline bool gic_is_vcpu(int cpu)
>      return cpu >= GIC_NCPU;
>  }
>
> +static inline int gic_get_vcpu_real_id(int cpu)
> +{
> +    return (cpu >= GIC_NCPU) ? (cpu - GIC_NCPU) : cpu;
> +}
> +
> +/* Return true if the given vIRQ state exists in a LR and is either active or
> + * pending and active.
> + *
> + * This function is used to check that a guest's `end of interrupt' or
> + * `interrupts deactivation' request is valid, and matches with a LR of an
> + * already acknowledged vIRQ (i.e. has the active bit set in its state).
> + */
> +static inline bool gic_virq_is_valid(GICState *s, int irq, int vcpu)
> +{
> +    int cpu = gic_get_vcpu_real_id(vcpu);
> +    int lr_idx;
> +
> +    for (lr_idx = 0; lr_idx < s->num_lrs; lr_idx++) {
> +        uint32_t *entry = &s->h_lr[lr_idx][cpu];
> +
> +        if ((GICH_LR_VIRT_ID(*entry) == irq) &&
> +            (GICH_LR_STATE(*entry) & GICH_LR_STATE_ACTIVE)) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +/* Return a pointer on the LR entry matching the given vIRQ.
> + *
> + * This function is used to retrieve an LR for which we know for sure that the
> + * corresponding vIRQ exists in the current context (i.e. its current state is
> + * not `invalid'):
> + *   - Either the corresponding vIRQ has been validated with gic_virq_is_valid()
> + *     so it is `active' or `active and pending',
> + *   - Or it was pending and has been selected by gic_get_best_virq(). It is now
> + *     `pending', `active' or `active and pending', depending on what the guest
> + *     already did with this vIRQ.
> + *
> + * Having multiple LRs with the same VirtualID leads to UNPREDICTABLE
> + * behaviour in the GIC. We choose to return the first one that matches.
> + */
> +static inline uint32_t *gic_get_lr_entry(GICState *s, int irq, int vcpu)
> +{
> +    int cpu = gic_get_vcpu_real_id(vcpu);
> +    int lr_idx;
> +
> +    for (lr_idx = 0; lr_idx < s->num_lrs; lr_idx++) {
> +        uint32_t *entry = &s->h_lr[lr_idx][cpu];
> +
> +        if ((GICH_LR_VIRT_ID(*entry) == irq) &&
> +            (GICH_LR_STATE(*entry) != GICH_LR_STATE_INVALID)) {
> +            return entry;
> +        }
> +    }
> +
> +    g_assert_not_reached();
> +    return NULL;
> +}

You can drop the 'return NULL' as that is unreachable code.
Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
