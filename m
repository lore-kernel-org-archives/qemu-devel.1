Received: from eggs.gnu.org ([2001:4830:134:3::10]:37622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdahg-0007kE-Hz
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdahe-00017D-Tw
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:28:12 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdahe-00014z-Hu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:28:10 -0400
Received: by mail-oi0-x243.google.com with SMTP id i12-v6so55423757oik.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 05:28:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-8-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-8-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 13:27:49 +0100
Message-ID: <CAFEAcA_h9bZu1OF2ntDMK-UfWcue9udSxTD0apQ-R_hgqJRBjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 07/20] intc/arm_gic: Add virtualization
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

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
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
> gic_get_lr_entry() tries to find the LR entry for a given (vCPU, irq)
> pair. gic_get_lr_entry_nofail() is meant to be used in contexts where we
> know for sure that the entry exists, so we can avoid the NULL check on
> the returned pointer.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c      |  5 ++++
>  hw/intc/gic_internal.h | 65 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index b2dd379bd2..f25d1b1270 100644
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
> index 1aa888a576..4242a16bd4 100644
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
> @@ -164,4 +178,55 @@ static inline bool gic_is_vcpu(int cpu)
>      return cpu >= GIC_NCPU;
>  }
>
> +static inline int gic_get_vcpu_real_id(int cpu)
> +{
> +    return (cpu >= GIC_NCPU) ? (cpu - GIC_NCPU) : cpu;
> +}

Unless these utility routines are needed in more than one .c
file, I would suggest just putting them in the .c file where
they're used (ie arm_gic.c).

> +
> +static inline bool gic_lr_entry_is_free(uint32_t entry)
> +{
> +    return (GICH_LR_STATE(entry) == GICH_LR_STATE_INVALID)
> +        && (GICH_LR_HW(entry) || !GICH_LR_EOI(entry));
> +}
> +
> +static inline bool gic_lr_entry_is_eoi(uint32_t entry)
> +{
> +    return (GICH_LR_STATE(entry) == GICH_LR_STATE_INVALID)
> +        && !GICH_LR_HW(entry) && GICH_LR_EOI(entry);
> +}

These could usefully have brief comments, something like
/* Return true if this LR is empty, ie the corresponding bit
 * in ELRSR is set.
 */

and similarly for the other one with a comment referencing EISR.
That makes it easier for the reader to understand where the
expressions being tested come from in the spec.

> +
> +/* Return a pointer on the LR entry for a given (irq,vcpu) pair.
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
> +            (!gic_lr_entry_is_free(*entry))) {
> +            return entry;
> +        }
> +    }
> +
> +    return NULL;
> +}

I found this function and its callers quite tricky to review for
correctness. I looked ahead at the remaining patches and this is
what I found:

 * A lot of the places where we call this, we're doing it because
we've already identified the LR entry we are working on, but
instead of passing an LR index around (which is what the GICv3 code
does), we pass an interrupt number, and then need to re-find the
same LR entry later in order to answer questions like "which
group is this virtual interrupt?"
 * At the start of the major flow-of-execution paths we get
a possibly-untrusted IRQ number from the guest and need to
validate that it's OK

These things don't necessarily want to be testing the same condition.

The flows-of-execution in question are:

(1) gic_complete_irq, ie write to EOI register
(2) gic_deactivate_irq, ie write to DIR register
(3) gic_get_current_pending_irq, ie read from HPPI register
(4) gic_acknowledge_irq, ie read from IAR register

1 and 2 should both be covered by the same validity test.
You call gic_virq_is_valid() in gic_complete_irq(), but we
must also call this in gic_deactivate_irq() -- DIR has the
same "if interrupt not in list register, increment EOIcount"
behaviour as the EOI register. Also, if we don't guard this
then the guest can make us assert in gic_test_group() by writing
a bogus value to DIR.

3 and 4 both operate on the interrupt number obtained from
current_pending[], which is filled in as a value from
gic_get_best_virq().

So we have three different cases where we're scanning the
list registers:
 (1) in gic_get_best_virq():  we pick an LR entry which has
      STATE == PENDING (as your code does)
 (2) in gic_virq_is_valid(): the GICv2 spec is not very clear here,
 but the GICv3 equivalent code is in
 hw/intc/arm_gicv3_cpuif.c:icv_find_active() and it just looks
 for an LR with the right VINTID and the Active bit set
 (matching the GICv3 pseudocode function FindActiveVirtualInterrupt).
 Unless we know the GICv2 behaves differently here, I would go
 with doing the same thing the GICv3 spec does.
 (3) when we are trying to find again the LR which we initially
 found via (1) or (2). Here I think we need to search for
 STATE != INVALID and can assert that we find something.
 (It's important that this check is at least the superset of
 the checks from (1) and (2), so we don't pass the check in 1/2
 and then assert here.)

So I would suggest:
 * gic_virq_is_valid() should look for just "right VINTID
   and state is Active or Active&Pending (ie Active bit set)"
 * gic_get_lr_entry() should look for "right VINTID and
   state not Invalid", and do the assert(), ie don't have
   a separate _nofail() function
 * have a big comment explaining what's going on

thanks
-- PMM
