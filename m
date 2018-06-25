Received: from eggs.gnu.org ([2001:4830:134:3::10]:54672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXSP3-0007Ym-0w
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXSOu-0000eI-Mk
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:23:37 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXSOu-0000cI-BA
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:23:28 -0400
Received: by mail-oi0-x242.google.com with SMTP id l22-v6so12645047oib.4
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 07:23:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619093124.24011-6-luc.michel@greensocs.com>
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<20180619093124.24011-6-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 15:23:06 +0100
Message-ID: <CAFEAcA8rKk+G_PYr4t5L=0zy3Hv-wB_7Wbe9zn+H_ZE9bLLn=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] intc/arm_gic: Add virtualization
 extensions logic
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

On 19 June 2018 at 10:31,  <luc.michel@greensocs.com> wrote:
> From: Luc MICHEL <luc.michel@greensocs.com>
>
> This commit adds the actual implementation of the GICv2 virtualization
> extensions logic.
>
> For the vCPU interfaces, most of the existing CPU interface code is
> reused. Calls to macros or functions modifying the distributor state are
> replaced with equivalent generic inline functions that act either on the
> distributor or on the virtual interface, given that the current CPU is a
> physical or a virtual one. For vCPU MMIO, the call is simply forwarded
> to the CPU read/write functions, with the CPU id being incremented by
> GIC_CPU_NR (vCPU id = CPU id + GIC_CPU_NR), and by faking a secure
> access (exposed vCPU interfaces do not implement security extensions.
> Faking a secure access allows to go through the "secure or no security
> extension" logic in the CPU interface).
>
> The gic_update logic is generalized to handle vCPUs. The main difference
> is the way the best IRQ is selected. This part has been split into two
> inline functions `gic_get_best_(v)irq`. The other difference is how we
> determine if IRQ distribution is enabled or not (split in
> `gic_dist_enabled`).
>
> Regarding list registers (LR) handling, some caching is done in the GIC
> state to avoid repetitive LR iteration. The following information is
> cached:
>   * vIRQ to LR mapping, in s->virq_lr_entry,
>   * the EISR and ELRSR registers,
>   * the LRs in the pending state, in s->pending_lrs.
> This cache is kept up-to-date with some maintenance functions, and is
> recomputed when the GIC state is loaded from a VMState restoration.

Did you measure to determine whether the caching is worth the effort?
The kernel has to rewrite the LR registers fairly often as it enters
and exits the guest, whereas for instance it doesn't ever read the EISR
at all as far as I can tell, and whenever it reads the ELRSR it then
writes all the LRs, so LR writes are definitely more frequent than
ELRSR reads. If you take my suggestion from patch 4 of implementing
4 LRs rather than 64 then the overhead of iterating them all is also
8x smaller.)

> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c      | 648 +++++++++++++++++++++++++++++++++++------
>  hw/intc/gic_internal.h | 198 +++++++++++++
>  2 files changed, 754 insertions(+), 92 deletions(-)

This is painfully large to review. Compare the patchset that
added virt support to GICv3, which broke things down into
more digestible pieces (mostly ~250 lines a patch):
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg01243.html

I've added a few review notes below but just scanned the rest,
as it's too hard to review as it is.

> +static inline void gic_get_best_virq(GICState *s, int cpu,
> +                                     int *best_irq, int *best_prio, int *group)
> +{
> +    int lr = 0;
> +    uint64_t lrs_in_use;
> +
> +    /* In-use LRs have their corresponding bit cleared. */
> +    lrs_in_use = ~(s->h_elrsr[cpu]);
> +
> +#if GIC_NR_LR < 64
> +    /* Ignore unimplemented LRs */
> +    lrs_in_use &= (1 << GIC_NR_LR) - 1;
> +#endif

MAKE_64BIT_MASK() allows you to avoid the ifdef.

> +
> +    *best_irq = 1023;
> +    *best_prio = 0x100;
> +
> +    while (lrs_in_use) {
> +        if (lrs_in_use & 0x1) {
> +            uint32_t lr_entry = s->h_lr[lr][cpu];
> +            int state = GICH_LR_STATE(lr_entry);
> +
> +            if (state == GICH_LR_STATE_PENDING) {
> +                int prio = GICH_LR_PRIORITY(lr_entry);
> +
> +                if (prio < *best_prio) {
> +                    *best_prio = prio;
> +                    *best_irq = GICH_LR_VIRT_ID(lr_entry);
> +                    *group = GICH_LR_GROUP(lr_entry);
> +                }
> +            }
> +        }
> +
> +        lrs_in_use >>= 1;
> +        lr++;
> +    }
> +}
> +
> +/* Return true if IRQ distribution is enabled:
> + *      - in the distributor, for the given group mask if virt if false,
> + *      - in the given CPU virtual interface if virt is true. */
> +static inline bool gic_dist_enabled(GICState *s, int cpu, bool virt,
> +                                    int group_mask)
> +{
> +    return (virt && (s->h_hcr[cpu] & GICH_HCR_EN))
> +        || (!virt && (s->ctlr & group_mask));
> +}

HCR.EN doesn't have anything to do with the distributor
(which is part of the non-virt related bits of the GIC),
so it's a bit weird that we're testing it in a function
named gic_dist_enabled().

> +
>  /* TODO: Many places that call this routine could be optimized.  */
>  /* Update interrupt status after enabled or pending bits have been changed.  */
> -static void gic_update(GICState *s)
> +static inline void gic_update_internal(GICState *s, bool virt)
>  {
>      int best_irq;
>      int best_prio;
> -    int irq;
>      int irq_level, fiq_level;
> -    int cpu;
> -    int cm;
> +    int cpu, cpu_iface;
> +    int group = 0;
> +    qemu_irq *irq_lines = virt ? s->parent_virq : s->parent_irq;
> +    qemu_irq *fiq_lines = virt ? s->parent_vfiq : s->parent_fiq;
>
>      for (cpu = 0; cpu < s->num_cpu; cpu++) {
> -        cm = 1 << cpu;
> -        s->current_pending[cpu] = 1023;
> -        if (!(s->ctlr & (GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1))
> -            || !(s->cpu_ctlr[cpu] & (GICC_CTLR_EN_GRP0 | GICC_CTLR_EN_GRP1))) {
> -            qemu_irq_lower(s->parent_irq[cpu]);
> -            qemu_irq_lower(s->parent_fiq[cpu]);
> +        cpu_iface = virt ? (cpu + GIC_NCPU) : cpu;
> +
> +        s->current_pending[cpu_iface] = 1023;
> +        if (!gic_dist_enabled(s, cpu, virt,
> +                              GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1)
> +            || !(s->cpu_ctlr[cpu_iface] &
> +                 (GICC_CTLR_EN_GRP0 | GICC_CTLR_EN_GRP1))) {
> +            qemu_irq_lower(irq_lines[cpu]);
> +            qemu_irq_lower(fiq_lines[cpu]);
>              continue;
>          }
> -        best_prio = 0x100;
> -        best_irq = 1023;
> -        for (irq = 0; irq < s->num_irq; irq++) {
> -            if (GIC_DIST_TEST_ENABLED(irq, cm) &&
> -                gic_test_pending(s, irq, cm) &&
> -                (!GIC_DIST_TEST_ACTIVE(irq, cm)) &&
> -                (irq < GIC_INTERNAL || GIC_DIST_TARGET(irq) & cm)) {
> -                if (GIC_DIST_GET_PRIORITY(irq, cpu) < best_prio) {
> -                    best_prio = GIC_DIST_GET_PRIORITY(irq, cpu);
> -                    best_irq = irq;
> -                }
> -            }
> +
> +        if (virt) {
> +            gic_get_best_virq(s, cpu, &best_irq, &best_prio, &group);
> +        } else {
> +            gic_get_best_irq(s, cpu, &best_irq, &best_prio, &group);
>          }
>
>          if (best_irq != 1023) {
>              trace_gic_update_bestirq(cpu, best_irq, best_prio,
> -                s->priority_mask[cpu], s->running_priority[cpu]);
> +                s->priority_mask[cpu_iface], s->running_priority[cpu_iface]);
>          }
>
>          irq_level = fiq_level = 0;
>
> -        if (best_prio < s->priority_mask[cpu]) {
> -            s->current_pending[cpu] = best_irq;
> -            if (best_prio < s->running_priority[cpu]) {
> -                int group = GIC_DIST_TEST_GROUP(best_irq, cm);
> -
> -                if (extract32(s->ctlr, group, 1) &&
> -                    extract32(s->cpu_ctlr[cpu], group, 1)) {
> -                    if (group == 0 && s->cpu_ctlr[cpu] & GICC_CTLR_FIQ_EN) {
> +        if (best_prio < s->priority_mask[cpu_iface]) {
> +            s->current_pending[cpu_iface] = best_irq;
> +            if (best_prio < s->running_priority[cpu_iface]) {
> +                if (gic_dist_enabled(s, cpu, virt, 1 << group) &&
> +                    extract32(s->cpu_ctlr[cpu_iface], group, 1)) {
> +                    if (group == 0 &&
> +                        s->cpu_ctlr[cpu_iface] & GICC_CTLR_FIQ_EN) {
>                          DPRINTF("Raised pending FIQ %d (cpu %d)\n",
> -                                best_irq, cpu);
> +                                best_irq, cpu_iface);
>                          fiq_level = 1;
> -                        trace_gic_update_set_irq(cpu, "fiq", fiq_level);
> +                        trace_gic_update_set_irq(cpu, virt ? "vfiq" : "fiq",
> +                                                 fiq_level);
>                      } else {
>                          DPRINTF("Raised pending IRQ %d (cpu %d)\n",
> -                                best_irq, cpu);
> +                                best_irq, cpu_iface);
>                          irq_level = 1;
> -                        trace_gic_update_set_irq(cpu, "irq", irq_level);
> +                        trace_gic_update_set_irq(cpu, virt ? "virq" : "irq",
> +                                                 irq_level);
>                      }
>                  }
>              }
>          }
>
> -        qemu_set_irq(s->parent_irq[cpu], irq_level);
> -        qemu_set_irq(s->parent_fiq[cpu], fiq_level);
> +        qemu_set_irq(irq_lines[cpu], irq_level);
> +        qemu_set_irq(fiq_lines[cpu], fiq_level);
>      }
>  }
>
> +static void gic_compute_misr(GICState *s, int cpu)
> +{
> +    int val;
> +    int vcpu = cpu + GIC_NCPU;
> +
> +    /* EOI */
> +    val = s->h_eisr[cpu] != 0;
> +    s->h_misr[cpu] = val << 0;

It would be nice to define and use some constant names for
the MISR bits here. (Consider using the FIELD macro to
define shift/mask/etc constants for you.)

> +
> +    /* U: true if only 0 or 1 LR entry is valid */
> +    val = s->h_hcr[cpu] & GICH_HCR_UIE &&
> +        ((GIC_NR_LR - ctpop64(s->h_elrsr[cpu])) < 2);
> +    s->h_misr[cpu] |= val << 1;

I don't think this is correct. Bits in GICH_ELRSRn
are set if (LRn.State == 0 && (LRn.HW == 1 || LRn.EOI == 0).
But the U bit is set based on how many of the LRs have
an LRn.State field != 0 -- there is no check on the
HW or EOI bits here.



> +
> +    /* LRENP: EOICount is not 0 */
> +    val = s->h_hcr[cpu] & GICH_HCR_LRENPIE &&
> +        ((s->h_hcr[cpu] & GICH_HCR_EOICOUNT) != 0);
> +    s->h_misr[cpu] |= val << 2;
> +
> +    /* NP: no pending interrupts. The number of LRs in pending state is cached
> +     * in s->pending_lrs[cpu]. */
> +    val = s->h_hcr[cpu] & GICH_HCR_NPIE &&
> +        (s->pending_lrs[cpu] == 0);
> +    s->h_misr[cpu] |= val << 3;
> +
> +    /* VGrp0E: group0 virq signaling enabled */
> +    val = s->h_hcr[cpu] & GICH_HCR_VGRP0EIE &&
> +        (s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP0);
> +    s->h_misr[cpu] |= val << 4;
> +
> +    /* VGrp0D: group0 virq signaling disabled */
> +    val = s->h_hcr[cpu] & GICH_HCR_VGRP0DIE &&
> +        !(s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP0);
> +    s->h_misr[cpu] |= val << 5;
> +
> +    /* VGrp1E: group1 virq signaling enabled */
> +    val = s->h_hcr[cpu] & GICH_HCR_VGRP1EIE &&
> +        (s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP1);
> +    s->h_misr[cpu] |= val << 6;
> +
> +    /* VGrp1D: group1 virq signaling disabled */
> +    val = s->h_hcr[cpu] & GICH_HCR_VGRP1DIE &&
> +        !(s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP1);
> +    s->h_misr[cpu] |= val << 7;
> +}
> +
> +static void gic_update_maintenance(GICState *s)
> +{
> +    int cpu = 0;
> +    int maint_level;
> +
> +    for (cpu = 0; cpu < s->num_cpu; cpu++) {
> +        gic_compute_misr(s, cpu);
> +        maint_level = (s->h_hcr[cpu] & GICH_HCR_EN) && s->h_misr[cpu];
> +
> +        qemu_set_irq(s->maintenance_irq[cpu], maint_level);
> +    }
> +}
> +
> +static void gic_update(GICState *s)
> +{
> +    gic_update_internal(s, false);
> +}
> +
> +static void gic_update_virt(GICState *s)
> +{
> +    gic_update_internal(s, true);
> +    gic_update_maintenance(s);
> +}
> +
>  static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
>                                   int cm, int target)
>  {
> @@ -212,7 +358,8 @@ static uint16_t gic_get_current_pending_irq(GICState *s, int cpu,
>      uint16_t pending_irq = s->current_pending[cpu];
>
>      if (pending_irq < GIC_MAXIRQ && gic_has_groups(s)) {
> -        int group = GIC_DIST_TEST_GROUP(pending_irq, (1 << cpu));
> +        int group = gic_test_group(s, pending_irq, cpu);
> +
>          /* On a GIC without the security extensions, reading this register
>           * behaves in the same way as a secure access to a GIC with them.
>           */
> @@ -243,7 +390,7 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
>
>      if (gic_has_groups(s) &&
>          !(s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) &&
> -        GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
> +        gic_test_group(s, irq, cpu)) {
>          bpr = s->abpr[cpu] - 1;
>          assert(bpr >= 0);
>      } else {
> @@ -256,7 +403,7 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
>       */
>      mask = ~0U << ((bpr & 7) + 1);
>
> -    return GIC_DIST_GET_PRIORITY(irq, cpu) & mask;
> +    return gic_get_priority(s, irq, cpu) & mask;
>  }
>
>  static void gic_activate_irq(GICState *s, int cpu, int irq)
> @@ -265,18 +412,25 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
>       * and update the running priority.
>       */
>      int prio = gic_get_group_priority(s, cpu, irq);
> -    int preemption_level = prio >> (GIC_MIN_BPR + 1);
> +    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
> +    int preemption_level = prio >> (min_bpr + 1);
>      int regno = preemption_level / 32;
>      int bitno = preemption_level % 32;
> +    uint32_t *papr = NULL;
>
> -    if (gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
> -        s->nsapr[regno][cpu] |= (1 << bitno);
> +    if (gic_is_vcpu(cpu)) {
> +        assert(regno == 0);
> +        papr = &s->h_apr[gic_get_vcpu_real_id(cpu)];
> +    } else if (gic_has_groups(s) && gic_test_group(s, irq, cpu)) {
> +        papr = &s->nsapr[regno][cpu];
>      } else {
> -        s->apr[regno][cpu] |= (1 << bitno);
> +        papr = &s->apr[regno][cpu];
>      }
>
> +    *papr |= (1 << bitno);
> +
>      s->running_priority[cpu] = prio;
> -    GIC_DIST_SET_ACTIVE(irq, 1 << cpu);
> +    gic_set_active(s, irq, cpu);
>  }
>
>  static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
> @@ -285,12 +439,22 @@ static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
>       * on the set bits in the Active Priority Registers.
>       */
>      int i;
> -    for (i = 0; i < GIC_NR_APRS; i++) {
> -        uint32_t apr = s->apr[i][cpu] | s->nsapr[i][cpu];
> +    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
> +    int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
> +
> +    for (i = 0; i < nr_aprs; i++) {
> +        uint32_t apr;
> +
> +        if (gic_is_vcpu(cpu)) {
> +            apr = s->h_apr[gic_get_vcpu_real_id(cpu)];
> +        } else {
> +            apr = s->apr[i][cpu] | s->nsapr[i][cpu];
> +        }
> +
>          if (!apr) {
>              continue;
>          }
> -        return (i * 32 + ctz32(apr)) << (GIC_MIN_BPR + 1);
> +        return (i * 32 + ctz32(apr)) << (min_bpr + 1);
>      }
>      return 0x100;
>  }
> @@ -314,9 +478,19 @@ static void gic_drop_prio(GICState *s, int cpu, int group)
>       * might not do so, and interrupts that should not preempt might do so.
>       */
>      int i;
> +    int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
> +
> +    for (i = 0; i < nr_aprs; i++) {
> +        uint32_t *papr = NULL;
> +
> +        if (gic_is_vcpu(cpu)) {
> +            papr = &s->h_apr[gic_get_vcpu_real_id(cpu)];
> +        } else if (group) {
> +            papr = &s->nsapr[i][cpu];
> +        } else {
> +            papr = &s->apr[i][cpu];
> +        }
>
> -    for (i = 0; i < GIC_NR_APRS; i++) {
> -        uint32_t *papr = group ? &s->nsapr[i][cpu] : &s->apr[i][cpu];
>          if (!*papr) {
>              continue;
>          }
> @@ -328,24 +502,51 @@ static void gic_drop_prio(GICState *s, int cpu, int group)
>      s->running_priority[cpu] = gic_get_prio_from_apr_bits(s, cpu);
>  }
>
> +static inline uint32_t gic_clear_pending_sgi(GICState *s, int irq, int cpu)
> +{
> +    int src;
> +    uint32_t ret;
> +
> +    if (!gic_is_vcpu(cpu)) {
> +        /* Lookup the source CPU for the SGI and clear this in the
> +         * sgi_pending map.  Return the src and clear the overall pending
> +         * state on this CPU if the SGI is not pending from any CPUs.
> +         */
> +        assert(s->sgi_pending[irq][cpu] != 0);
> +        src = ctz32(s->sgi_pending[irq][cpu]);
> +        s->sgi_pending[irq][cpu] &= ~(1 << src);
> +        if (s->sgi_pending[irq][cpu] == 0) {
> +            gic_clear_pending(s, irq, cpu);
> +        }
> +        ret = irq | ((src & 0x7) << 10);
> +    } else {
> +        uint32_t *lr_entry = gic_get_lr_entry(s, irq, cpu);
> +        src = GICH_LR_CPUID(*lr_entry);
> +
> +        gic_clear_pending(s, irq, cpu);
> +        ret = irq | (src << 10);
> +    }
> +
> +    return ret;
> +}
> +
>  uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
>  {
> -    int ret, irq, src;
> -    int cm = 1 << cpu;
> +    int ret, irq;
>
>      /* gic_get_current_pending_irq() will return 1022 or 1023 appropriately
>       * for the case where this GIC supports grouping and the pending interrupt
>       * is in the wrong group.
>       */
>      irq = gic_get_current_pending_irq(s, cpu, attrs);
> -    trace_gic_acknowledge_irq(cpu, irq);
> +    trace_gic_acknowledge_irq(gic_get_vcpu_real_id(cpu), irq);
>
>      if (irq >= GIC_MAXIRQ) {
>          DPRINTF("ACK, no pending interrupt or it is hidden: %d\n", irq);
>          return irq;
>      }
>
> -    if (GIC_DIST_GET_PRIORITY(irq, cpu) >= s->running_priority[cpu]) {
> +    if (gic_get_priority(s, irq, cpu) >= s->running_priority[cpu]) {
>          DPRINTF("ACK, pending interrupt (%d) has insufficient priority\n", irq);
>          return 1023;
>      }
> @@ -354,37 +555,23 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
>          /* Clear pending flags for both level and edge triggered interrupts.
>           * Level triggered IRQs will be reasserted once they become inactive.
>           */
> -        GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
> -                                                             : cm);
> +        gic_clear_pending(s, irq, cpu);
>          ret = irq;
>      } else {
>          if (irq < GIC_NR_SGIS) {
> -            /* Lookup the source CPU for the SGI and clear this in the
> -             * sgi_pending map.  Return the src and clear the overall pending
> -             * state on this CPU if the SGI is not pending from any CPUs.
> -             */
> -            assert(s->sgi_pending[irq][cpu] != 0);
> -            src = ctz32(s->sgi_pending[irq][cpu]);
> -            s->sgi_pending[irq][cpu] &= ~(1 << src);
> -            if (s->sgi_pending[irq][cpu] == 0) {
> -                GIC_DIST_CLEAR_PENDING(irq,
> -                                       GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
> -                                                                : cm);
> -            }
> -            ret = irq | ((src & 0x7) << 10);
> +            ret = gic_clear_pending_sgi(s, irq, cpu);
>          } else {
> -            /* Clear pending state for both level and edge triggered
> -             * interrupts. (level triggered interrupts with an active line
> -             * remain pending, see gic_test_pending)
> -             */
> -            GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
> -                                                                 : cm);
> +            gic_clear_pending(s, irq, cpu);
>              ret = irq;
>          }
>      }
>
>      gic_activate_irq(s, cpu, irq);
> -    gic_update(s);
> +    if (gic_is_vcpu(cpu)) {
> +        gic_update_virt(s);
> +    } else {
> +        gic_update(s);
> +    }
>      DPRINTF("ACK %d\n", irq);
>      return ret;
>  }
> @@ -534,8 +721,7 @@ static bool gic_eoi_split(GICState *s, int cpu, MemTxAttrs attrs)
>
>  static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>  {
> -    int cm = 1 << cpu;
> -    int group = gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
> +    int group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
>
>      if (!gic_eoi_split(s, cpu, attrs)) {
>          /* This is UNPREDICTABLE; we choose to ignore it */
> @@ -549,7 +735,7 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>          return;
>      }
>
> -    GIC_DIST_CLEAR_ACTIVE(irq, cm);
> +    gic_clear_active(s, irq, cpu);
>  }
>
>  static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
> @@ -558,6 +744,20 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>      int group;
>
>      DPRINTF("EOI %d\n", irq);
> +    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
> +        /* This vIRQ does not have a valid LR entry. Increment EOICount and
> +         * ignore the write. */
> +
> +        int rcpu = gic_get_vcpu_real_id(cpu);
> +        int eoicount = extract32(s->h_hcr[rcpu], 27, 5) + 1;
> +
> +        /* This 5 bits counter wraps to 0 */
> +        eoicount &= 0x1f;
> +
> +        s->h_hcr[rcpu] = deposit32(s->h_hcr[rcpu], 27, 5, eoicount);

Since EOIcount is at the top of a 32-bit register which we represent
using a uint32_t, we can do the increment and wrap-to-zero without
having to extract the field and put it back:

   s->h_hcr[rcpu] += 1 << 27;

> +        return;
> +    }
> +
>      if (irq >= s->num_irq) {
>          /* This handles two cases:
>           * 1. If software writes the ID of a spurious interrupt [ie 1023]
> @@ -584,7 +784,7 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>          }
>      }
>
> -    group = gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
> +    group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
>
>      if (s->security_extn && !attrs.secure && !group) {
>          DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq);
> @@ -600,9 +800,14 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>
>      /* In GICv2 the guest can choose to split priority-drop and deactivate */
>      if (!gic_eoi_split(s, cpu, attrs)) {
> -        GIC_DIST_CLEAR_ACTIVE(irq, cm);
> +        gic_clear_active(s, irq, cpu);
> +    }
> +
> +    if (gic_is_vcpu(cpu)) {
> +        gic_update_virt(s);
> +    } else {
> +        gic_update(s);
>      }
> -    gic_update(s);
>  }
>
>  static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
> @@ -888,8 +1093,9 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
>
>          for (i = 0; i < 8; i++) {
>              if (value & (1 << i)) {
> -                int mask = (irq < GIC_INTERNAL) ? (1 << cpu)
> -                                                : GIC_DIST_TARGET(irq + i);
> +                int mask =
> +                    (irq < GIC_INTERNAL) ? (1 << cpu)
> +                                         : GIC_DIST_TARGET(irq + i);
>                  int cm = (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;
>
>                  if (s->security_extn && !attrs.secure &&
> @@ -1242,12 +1448,15 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>      case 0xd0: case 0xd4: case 0xd8: case 0xdc:
>      {
>          int regno = (offset - 0xd0) / 4;
> +        int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
>
> -        if (regno >= GIC_NR_APRS || s->revision != 2) {
> +        if (regno >= nr_aprs || s->revision != 2) {
>              *data = 0;
>          } else if (s->security_extn && !attrs.secure) {
>              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
>              *data = gic_apr_ns_view(s, regno, cpu);
> +        } else if (gic_is_vcpu(cpu)) {
> +            *data = s->h_apr[gic_get_vcpu_real_id(cpu)];

This should go earlier in the if-ladder -- it's weird to rely on the
"is this an NS access to a TZ-aware GIC" check not firing.

>          } else {
>              *data = s->apr[regno][cpu];
>          }
> @@ -1258,7 +1467,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>          int regno = (offset - 0xe0) / 4;
>
>          if (regno >= GIC_NR_APRS || s->revision != 2 || !gic_has_groups(s) ||
> -            (s->security_extn && !attrs.secure)) {
> +            (s->security_extn && !attrs.secure) || gic_is_vcpu(cpu)) {
>              *data = 0;
>          } else {
>              *data = s->nsapr[regno][cpu];
> @@ -1293,7 +1502,8 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>                  s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
>              }
>          } else {
> -            s->bpr[cpu] = MAX(value & 0x7, GIC_MIN_BPR);
> +            int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
> +            s->bpr[cpu] = MAX(value & 0x7, min_bpr);
>          }
>          break;
>      case 0x10: /* End Of Interrupt */
> @@ -1310,13 +1520,16 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>      case 0xd0: case 0xd4: case 0xd8: case 0xdc:
>      {
>          int regno = (offset - 0xd0) / 4;
> +        int nr_aprs = gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS;
>
> -        if (regno >= GIC_NR_APRS || s->revision != 2) {
> +        if (regno >= nr_aprs || s->revision != 2) {
>              return MEMTX_OK;
>          }
>          if (s->security_extn && !attrs.secure) {
>              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
>              gic_apr_write_ns_view(s, regno, cpu, value);
> +        } else if (gic_is_vcpu(cpu)) {
> +            s->h_apr[gic_get_vcpu_real_id(cpu)] = value;
>          } else {
>              s->apr[regno][cpu] = value;
>          }
> @@ -1332,6 +1545,9 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>          if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
>              return MEMTX_OK;
>          }
> +        if (gic_is_vcpu(cpu)) {
> +            return MEMTX_OK;
> +        }
>          s->nsapr[regno][cpu] = value;
>          break;
>      }
> @@ -1344,7 +1560,13 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>                        "gic_cpu_write: Bad offset %x\n", (int)offset);
>          return MEMTX_OK;
>      }
> -    gic_update(s);
> +
> +    if (gic_is_vcpu(cpu)) {
> +        gic_update_virt(s);
> +    } else {
> +        gic_update(s);
> +    }
> +
>      return MEMTX_OK;
>  }
>
> @@ -1384,6 +1606,217 @@ static MemTxResult gic_do_cpu_write(void *opaque, hwaddr addr,
>      GICState *s = *backref;
>      int id = (backref - s->backref);
>      return gic_cpu_write(s, id, addr, value, attrs);
> +
> +}
> +
> +static MemTxResult gic_thisvcpu_read(void *opaque, hwaddr addr, uint64_t *data,
> +                                    unsigned size, MemTxAttrs attrs)
> +{
> +    GICState *s = (GICState *)opaque;
> +
> +    /* The exposed vCPU interface does not implement security extensions.
> +     * Pretend this access is secure to go through the "no security extension
> +     * or secure access" path in the CPU interface. */
> +    attrs.secure = 1;

I'm not really a fan of this. How much extra checking does it
actually save us?

> +
> +    return gic_cpu_read(s, gic_get_current_cpu(s) + GIC_NCPU,
> +                        addr, data, attrs);
> +}
> +
> +static MemTxResult gic_thisvcpu_write(void *opaque, hwaddr addr,
> +                                     uint64_t value, unsigned size,
> +                                     MemTxAttrs attrs)
> +{
> +    GICState *s = (GICState *)opaque;
> +
> +    attrs.secure = 1;
> +
> +    return gic_cpu_write(s, gic_get_current_cpu(s) + GIC_NCPU,
> +                         addr, value, attrs);
> +}
> +
> +static MemTxResult gic_do_vcpu_read(void *opaque, hwaddr addr, uint64_t *data,
> +                                    unsigned size, MemTxAttrs attrs)
> +{
> +    GICState **backref = (GICState **)opaque;
> +    GICState *s = *backref;
> +    int id = (backref - s->backref);
> +
> +    attrs.secure = 1;
> +
> +    return gic_cpu_read(s, id + GIC_NCPU, addr, data, attrs);
> +}
> +
> +static MemTxResult gic_do_vcpu_write(void *opaque, hwaddr addr,
> +                                     uint64_t value, unsigned size,
> +                                     MemTxAttrs attrs)
> +{
> +    GICState **backref = (GICState **)opaque;
> +    GICState *s = *backref;
> +    int id = (backref - s->backref);
> +
> +    attrs.secure = 1;
> +
> +    return gic_cpu_write(s, id + GIC_NCPU, addr, value, attrs);
> +
> +}
> +
> +static void gic_vmcr_write(GICState *s, uint32_t value)
> +{
> +    int vcpu = gic_get_current_vcpu(s);
> +    uint32_t ctlr;
> +    uint32_t abpr;
> +    uint32_t bpr;
> +    uint32_t prio_mask;
> +
> +    /* Always pretend to do a secure access */
> +    MemTxAttrs attrs = { .secure = 1 };
> +
> +    ctlr = extract32(value, 0, 5) & 0x0000021f;

The result of extract32() will only have bits [4:0]
set, so the 0x200 in this mask will never have an
effect -- why is it here?


> +    abpr = extract32(value, 18, 3);
> +    bpr = extract32(value, 21, 3);
> +    prio_mask = extract32(value, 27, 5) << 3;
> +
> +    gic_set_cpu_control(s, vcpu, ctlr, attrs);
> +    s->abpr[vcpu] = MAX(abpr, GIC_VIRT_MIN_ABPR);
> +    s->bpr[vcpu] = MAX(bpr, GIC_VIRT_MIN_BPR);
> +    gic_set_priority_mask(s, vcpu, prio_mask, attrs);
> +}
> +
> +static void gic_set_lr_entry(GICState *s, int cpu, int lr_num, uint32_t entry)
> +{
> +    assert(lr_num < GIC_NR_LR);
> +
> +    uint32_t prev_entry = s->h_lr[lr_num][cpu];
> +    int irq;
> +    bool is_free;
> +
> +    if (!gic_lr_entry_is_free(prev_entry)) {
> +        /* The entry was valid, flush it */
> +        irq = GICH_LR_VIRT_ID(prev_entry);
> +        gic_clear_virq_cache(s, irq, cpu);
> +    }
> +
> +    s->h_lr[lr_num][cpu] = entry;
> +    is_free = gic_lr_update(s, lr_num, cpu);
> +
> +    if (!is_free) {
> +        /* Update the vIRQ -> LR entry cache */
> +        irq = GICH_LR_VIRT_ID(entry);
> +        gic_set_virq_cache(s, irq, cpu, lr_num);
> +    }
> +}
> +
> +static MemTxResult gic_hyp_read(void *opaque, hwaddr addr, uint64_t *data,
> +                                unsigned size, MemTxAttrs attrs)
> +{
> +    GICState *s = ARM_GIC(opaque);
> +    int cpu = gic_get_current_cpu(s);
> +    int vcpu = gic_get_current_vcpu(s);
> +
> +    switch (addr) {
> +    case 0x0: /* Hypervisor Control */
> +        *data = s->h_hcr[cpu];
> +        break;
> +
> +    case 0x4: /* VGIC Type */
> +        *data = ((6 - GIC_VIRT_MIN_BPR) << 29)
> +            | ((GIC_VIRT_MAX_GROUP_PRIO_BITS - 1) << 26)
> +            | (GIC_NR_LR - 1);
> +        break;
> +
> +    case 0x8: /* Virtual Machine Control */
> +        *data = extract32(s->cpu_ctlr[vcpu], 0, 10);
> +        *data |= extract32(s->abpr[vcpu], 0, 3) << 18;
> +        *data |= extract32(s->bpr[vcpu], 0, 3) << 21;
> +        *data |= extract32(s->priority_mask[vcpu], 3, 5) << 27;
> +        break;
> +
> +    case 0x10: /* Maintenance Interrupt Status */
> +        *data = s->h_misr[cpu];
> +        break;
> +
> +    case 0x20: /* End of Interrupt Status 0 and 1 */
> +    case 0x24:
> +        *data = (uint32_t) extract64(s->h_eisr[cpu], (addr - 0x20) * 8, 32);

The uint32_t cast is unnecessary here, I think (also below).

> +        break;
> +
> +    case 0x30: /* Empty List Status 0 and 1 */
> +    case 0x34:
> +        *data = (uint32_t) extract64(s->h_elrsr[cpu], (addr - 0x30) * 8, 32);
> +        break;
> +
> +    case 0xf0: /* Active Priorities */
> +        *data = s->h_apr[cpu];
> +        break;
> +
> +    case 0x100 ... 0x1fc: /* List Registers */
> +    {
> +        int lr_num = (addr - 0x100) / 4;
> +
> +        if (lr_num > GIC_NR_LR) {
> +            *data = 0;
> +        } else {
> +            *data = s->h_lr[lr_num][cpu];
> +        }
> +        break;
> +    }
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "gic_hyp_read: Bad offset %" HWADDR_PRIx "\n", addr);
> +        return MEMTX_OK;
> +    }
> +
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult gic_hyp_write(void *opaque, hwaddr addr, uint64_t value,
> +                                 unsigned size, MemTxAttrs attrs)
> +{
> +    GICState *s = ARM_GIC(opaque);
> +    int cpu = gic_get_current_cpu(s);
> +
> +    switch (addr) {
> +    case 0x0: /* Hypervisor Control */
> +        s->h_hcr[cpu] = value & 0xf80000ff;

You have constants defined for HCR fields so you don't need the
magic number here.

> +        break;
> +
> +    case 0x8: /* Virtual Machine Control */
> +        gic_vmcr_write(s, value);
> +        break;
> +
> +    case 0xf0: /* Active Priorities */
> +        s->h_apr[cpu] = value;
> +        break;
> +
> +    case 0x100 ... 0x1fc: /* List Registers */
> +    {
> +        int lr_num = (addr - 0x100) / 4;
> +
> +        if (lr_num > GIC_NR_LR) {
> +            return MEMTX_OK;
> +        }
> +
> +        gic_set_lr_entry(s, cpu, lr_num, value & 0xff8fffff);
> +        break;
> +    }
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "gic_hyp_write: Bad offset %" HWADDR_PRIx "\n", addr);
> +        return MEMTX_OK;
> +    }
> +
> +    gic_update_virt(s);
> +    return MEMTX_OK;
> +}
> +
> +static void arm_gic_post_load(GICState *s)
> +{
> +    if (s->virt_extn) {
> +        gic_recompute_virt_cache(s);
> +    }
>  }
>
>  static const MemoryRegionOps gic_ops[2] = {
> @@ -1405,6 +1838,25 @@ static const MemoryRegionOps gic_cpu_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>
> +static const MemoryRegionOps gic_virt_ops[2] = {
> +    {
> +        .read_with_attrs = gic_hyp_read,
> +        .write_with_attrs = gic_hyp_write,
> +        .endianness = DEVICE_NATIVE_ENDIAN,
> +    },
> +    {
> +        .read_with_attrs = gic_thisvcpu_read,
> +        .write_with_attrs = gic_thisvcpu_write,
> +        .endianness = DEVICE_NATIVE_ENDIAN,
> +    }
> +};
> +
> +static const MemoryRegionOps gic_vcpu_ops = {
> +    .read_with_attrs = gic_do_vcpu_read,
> +    .write_with_attrs = gic_do_vcpu_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
>  static void arm_gic_realize(DeviceState *dev, Error **errp)
>  {
>      /* Device instance realize function for the GIC sysbus device */
> @@ -1427,7 +1879,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>      }
>
>      /* This creates distributor and main CPU interface (s->cpuiomem[0]) */
> -    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, NULL);
> +    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, gic_virt_ops);
>
>      /* Extra core-specific regions for the CPU interfaces. This is
>       * necessary for "franken-GIC" implementations, for example on
> @@ -1439,17 +1891,29 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>       */
>      for (i = 0; i < s->num_cpu; i++) {
>          s->backref[i] = s;
> -        memory_region_init_io(&s->cpuiomem[i+1], OBJECT(s), &gic_cpu_ops,
> +        memory_region_init_io(&s->cpuiomem[i + 1], OBJECT(s), &gic_cpu_ops,
>                                &s->backref[i], "gic_cpu", 0x100);
> -        sysbus_init_mmio(sbd, &s->cpuiomem[i+1]);
> +        sysbus_init_mmio(sbd, &s->cpuiomem[i + 1]);

This sort of stylistic fix to existing code should be in its own patch.

>      }
> +
> +    if (s->virt_extn) {
> +        for (i = 0; i < s->num_cpu; i++) {
> +            memory_region_init_io(&s->vcpuiomem[i + 1], OBJECT(s),
> +                                  &gic_vcpu_ops, &s->backref[i],
> +                                  "gic_vcpu", 0x2000);
> +            sysbus_init_mmio(sbd, &s->vcpuiomem[i + 1]);
> +        }
> +    }
> +
>  }
>
>  static void arm_gic_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ARMGICCommonClass *agcc = ARM_GIC_COMMON_CLASS(klass);
>      ARMGICClass *agc = ARM_GIC_CLASS(klass);
>
> +    agcc->post_load = arm_gic_post_load;
>      device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
>  }
>
> diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
> index c85427c8e3..998e4b7854 100644
> --- a/hw/intc/gic_internal.h
> +++ b/hw/intc/gic_internal.h
> @@ -64,6 +64,34 @@
>  #define GICC_CTLR_EOIMODE    (1U << 9)
>  #define GICC_CTLR_EOIMODE_NS (1U << 10)
>
> +#define GICH_HCR_EN       (1U << 0)
> +#define GICH_HCR_UIE      (1U << 1)
> +#define GICH_HCR_LRENPIE  (1U << 2)
> +#define GICH_HCR_NPIE     (1U << 3)
> +#define GICH_HCR_VGRP0EIE (1U << 4)
> +#define GICH_HCR_VGRP0DIE (1U << 5)
> +#define GICH_HCR_VGRP1EIE (1U << 6)
> +#define GICH_HCR_VGRP1DIE (1U << 7)
> +#define GICH_HCR_EOICOUNT (0x1fU << 27)
> +
> +#define GICH_LR_STATE_INVALID         0
> +#define GICH_LR_STATE_PENDING         1
> +#define GICH_LR_STATE_ACTIVE          2
> +#define GICH_LR_STATE_ACTIVE_PENDING  3
> +
> +#define GICH_LR_VIRT_ID(entry) (extract32(entry, 0, 10))
> +#define GICH_LR_PHYS_ID(entry) (extract32(entry, 10, 10))
> +#define GICH_LR_PRIORITY(entry) (extract32(entry, 23, 5) << 3)
> +#define GICH_LR_STATE(entry) (extract32(entry, 28, 2))
> +#define GICH_LR_GROUP(entry) (extract32(entry, 30, 1))
> +#define GICH_LR_HW(entry) (extract32(entry, 31, 1))
> +#define GICH_LR_EOI(entry) (extract32(entry, 19, 1))
> +#define GICH_LR_CPUID(entry) (extract32(entry, 10, 3))
> +
> +#define GICH_LR_CLEAR_PENDING(entry) ((entry) &= ~(1 << 28))
> +#define GICH_LR_SET_ACTIVE(entry) ((entry) |= (1 << 29))
> +#define GICH_LR_CLEAR_ACTIVE(entry) ((entry) &= ~(1 << 29))
> +
>  /* Valid bits for GICC_CTLR for GICv1, v1 with security extensions,
>   * GICv2 and GICv2 with security extensions:
>   */
> @@ -99,4 +127,174 @@ static inline bool gic_is_vcpu(int cpu)
>      return cpu >= GIC_NCPU;
>  }
>
> +static inline int gic_get_vcpu_real_id(int cpu)
> +{
> +    return (cpu >= GIC_NCPU) ? (cpu - GIC_NCPU) : cpu;
> +}
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
> +
> +static inline bool gic_virq_is_valid(GICState *s, int irq, int vcpu)
> +{
> +    int cpu = gic_get_vcpu_real_id(vcpu);
> +    return s->virq_lr_entry[irq][cpu] != GIC_NR_LR;
> +}
> +
> +/* Return a pointer on the LR entry for a given (irq,vcpu) couple.
> + * This function requires that the entry actually exists somewhere in
> + * the LRs. */
> +static inline uint32_t *gic_get_lr_entry(GICState *s, int irq, int vcpu)
> +{
> +    int cpu = gic_get_vcpu_real_id(vcpu);
> +    int lr_num = s->virq_lr_entry[irq][cpu];
> +
> +    assert(lr_num >= 0 && lr_num < GIC_NR_LR);
> +    return &s->h_lr[lr_num][cpu];
> +}
> +
> +static inline void gic_set_virq_cache(GICState *s, int irq,
> +                                      int vcpu, int lr_num)
> +{
> +    int cpu = gic_get_vcpu_real_id(vcpu);
> +    s->virq_lr_entry[irq][cpu] = lr_num;
> +}
> +
> +static inline void gic_clear_virq_cache(GICState *s, int irq, int vcpu)
> +{
> +    gic_set_virq_cache(s, irq, vcpu, GIC_NR_LR);
> +}
> +
> +static inline bool gic_lr_update(GICState *s, int lr_num, int vcpu)
> +{
> +    int cpu = gic_get_vcpu_real_id(vcpu);
> +
> +    assert(lr_num >= 0 && lr_num < GIC_NR_LR);
> +    uint32_t *entry = &s->h_lr[lr_num][cpu];
> +
> +    int is_eoi = gic_lr_entry_is_eoi(*entry);
> +    int is_free = gic_lr_entry_is_free(*entry);
> +    int is_pending = (GICH_LR_STATE(*entry) == GICH_LR_STATE_PENDING);
> +
> +    s->h_eisr[cpu] = deposit64(s->h_eisr[cpu], lr_num, 1, is_eoi);
> +    s->h_elrsr[cpu] = deposit64(s->h_elrsr[cpu], lr_num, 1, is_free);
> +    s->pending_lrs[cpu] = deposit64(s->pending_lrs[cpu], lr_num, 1, is_pending);
> +
> +    return is_free;
> +}
> +
> +static inline void gic_lr_update_by_irq(GICState *s, int irq, int vcpu)
> +{
> +    int cpu = gic_get_vcpu_real_id(vcpu);
> +    int lr_num = s->virq_lr_entry[irq][cpu];
> +
> +    assert(lr_num != GIC_NR_LR);
> +    bool is_free = gic_lr_update(s, lr_num, vcpu);
> +
> +    if (is_free) {
> +        gic_clear_virq_cache(s, irq, vcpu);
> +    }
> +}
> +
> +/* Recompute the whole virt cache, including the vIRQ to LR mapping, the EISR
> + * and ELRSR registers, and the LRs in the pending state.
> + * This function is called after restoring the GIC state from a VMState. */
> +static inline void gic_recompute_virt_cache(GICState *s)
> +{
> +    int cpu, lr_num;
> +
> +    for (cpu = 0; cpu < s->num_cpu; cpu++) {
> +        for (lr_num = 0; lr_num < GIC_NR_LR; lr_num++) {
> +            bool is_free = gic_lr_update(s, lr_num, cpu);
> +            uint32_t entry = s->h_lr[lr_num][cpu];
> +
> +            if (!is_free) {
> +                int irq = GICH_LR_VIRT_ID(entry);
> +                gic_set_virq_cache(s, irq, cpu, lr_num);
> +            }
> +        }
> +    }
> +}

Oh, you do have this function; it just wasn't in the patch I
expected it to be in...

> +
> +static inline bool gic_test_group(GICState *s, int irq, int cpu)
> +{
> +    if (gic_is_vcpu(cpu)) {
> +        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
> +        return GICH_LR_GROUP(*entry);
> +    } else {
> +        return GIC_DIST_TEST_GROUP(irq, 1 << cpu);
> +    }
> +}
> +
> +static inline void gic_clear_pending(GICState *s, int irq, int cpu)
> +{
> +    if (gic_is_vcpu(cpu)) {
> +        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
> +        GICH_LR_CLEAR_PENDING(*entry);
> +        /* Don't recompute the LR cache yet as a clear pending request is
> +         * always followed by a set active one. */
> +    } else {
> +        /* Clear pending state for both level and edge triggered
> +         * interrupts. (level triggered interrupts with an active line
> +         * remain pending, see gic_test_pending)
> +         */
> +        GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
> +                                                             : (1 << cpu));
> +    }
> +}
> +
> +static inline void gic_set_active(GICState *s, int irq, int cpu)
> +{
> +    if (gic_is_vcpu(cpu)) {
> +        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
> +        GICH_LR_SET_ACTIVE(*entry);
> +        gic_lr_update_by_irq(s, irq, cpu);
> +    } else {
> +        GIC_DIST_SET_ACTIVE(irq, 1 << cpu);
> +    }
> +}
> +
> +static inline void gic_clear_active(GICState *s, int irq, int cpu)
> +{
> +    if (gic_is_vcpu(cpu)) {
> +        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
> +        GICH_LR_CLEAR_ACTIVE(*entry);
> +
> +        if (GICH_LR_HW(*entry)) {
> +            /* Hardware interrupt. We must forward the deactivation request to
> +             * the distributor */
> +            int phys_irq = GICH_LR_PHYS_ID(*entry);
> +            int rcpu = gic_get_vcpu_real_id(cpu);
> +
> +            /* Group 0 IRQs deactivation requests are ignored. */
> +            if (GIC_DIST_TEST_GROUP(phys_irq, 1 << rcpu)) {
> +                GIC_DIST_CLEAR_ACTIVE(phys_irq, 1 << rcpu);
> +            }
> +        }
> +
> +        gic_lr_update_by_irq(s, irq, cpu);
> +    } else {
> +        GIC_DIST_CLEAR_ACTIVE(irq, 1 << cpu);
> +    }
> +}
> +
> +static inline int gic_get_priority(GICState *s, int irq, int cpu)
> +{
> +    if (gic_is_vcpu(cpu)) {
> +        uint32_t *entry = gic_get_lr_entry(s, irq, cpu);
> +        return GICH_LR_PRIORITY(*entry);
> +    } else {
> +        return GIC_DIST_GET_PRIORITY(irq, cpu);
> +    }
> +}
> +
>  #endif /* QEMU_ARM_GIC_INTERNAL_H */
> --
> 2.17.1

thanks
-- PMM
