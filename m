Received: from eggs.gnu.org ([2001:4830:134:3::10]:38930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj2BE-0000FV-6O
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj2BC-0004Dl-2s
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:49:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
	<20180727095421.386-10-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <799aa201-ee60-a04d-d241-ad60b8150cd6@amsat.org>
Date: Fri, 27 Jul 2018 09:48:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180727095421.386-10-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 09/20] intc/arm_gic: Add
 virtualization enabled IRQ helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, mark.burton@greensocs.com, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>

On 07/27/2018 06:54 AM, Luc Michel wrote:
> Add some helper functions to gic_internal.h to get or change the state
> of an IRQ. When the current CPU is not a vCPU, the call is forwarded to
> the GIC distributor. Otherwise, it acts on the list register matching
> the IRQ in the current CPU virtual interface.
> 
> gic_clear_active can have a side effect on the distributor, even in the
> vCPU case, when the correponding LR has the HW field set.
> 
> Use those functions in the CPU interface code path to prepare for the
> vCPU interface implementation.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gic.c      | 32 +++++++---------
>  hw/intc/gic_internal.h | 83 ++++++++++++++++++++++++++++++++++++++++++

You can set scripts/git.orderfile up for a more natural 'headers changes
before source' review.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  2 files changed, 97 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 94d5982e2a..26ed7ea58a 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -220,11 +220,12 @@ static uint16_t gic_get_current_pending_irq(GICState *s, int cpu,
>                                              MemTxAttrs attrs)
>  {
>      uint16_t pending_irq = s->current_pending[cpu];
>  
>      if (pending_irq < GIC_MAXIRQ && gic_has_groups(s)) {
> -        int group = GIC_DIST_TEST_GROUP(pending_irq, (1 << cpu));
> +        int group = gic_test_group(s, pending_irq, cpu);
> +
>          /* On a GIC without the security extensions, reading this register
>           * behaves in the same way as a secure access to a GIC with them.
>           */
>          bool secure = !gic_cpu_ns_access(s, cpu, attrs);
>  
> @@ -251,11 +252,11 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
>      int bpr;
>      uint32_t mask;
>  
>      if (gic_has_groups(s) &&
>          !(s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) &&
> -        GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
> +        gic_test_group(s, irq, cpu)) {
>          bpr = s->abpr[cpu] - 1;
>          assert(bpr >= 0);
>      } else {
>          bpr = s->bpr[cpu];
>      }
> @@ -264,11 +265,11 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
>       * a BPR of 1 means they are [7:2], and so on down to
>       * a BPR of 7 meaning no group priority bits at all.
>       */
>      mask = ~0U << ((bpr & 7) + 1);
>  
> -    return GIC_DIST_GET_PRIORITY(irq, cpu) & mask;
> +    return gic_get_priority(s, irq, cpu) & mask;
>  }
>  
>  static void gic_activate_irq(GICState *s, int cpu, int irq)
>  {
>      /* Set the appropriate Active Priority Register bit for this IRQ,
> @@ -277,18 +278,18 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
>      int prio = gic_get_group_priority(s, cpu, irq);
>      int preemption_level = prio >> (GIC_MIN_BPR + 1);
>      int regno = preemption_level / 32;
>      int bitno = preemption_level % 32;
>  
> -    if (gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
> +    if (gic_has_groups(s) && gic_test_group(s, irq, cpu)) {
>          s->nsapr[regno][cpu] |= (1 << bitno);
>      } else {
>          s->apr[regno][cpu] |= (1 << bitno);
>      }
>  
>      s->running_priority[cpu] = prio;
> -    GIC_DIST_SET_ACTIVE(irq, 1 << cpu);
> +    gic_set_active(s, irq, cpu);
>  }
>  
>  static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
>  {
>      /* Recalculate the current running priority for this CPU based
> @@ -353,21 +354,20 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
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
>  
>      if (s->revision == REV_11MPCORE) {
>          /* Clear pending flags for both level and edge triggered interrupts.
>           * Level triggered IRQs will be reasserted once they become inactive.
>           */
> -        GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
> -                                                             : cm);
> +        gic_clear_pending(s, irq, cpu);
>          ret = irq;
>      } else {
>          if (irq < GIC_NR_SGIS) {
>              /* Lookup the source CPU for the SGI and clear this in the
>               * sgi_pending map.  Return the src and clear the overall pending
> @@ -375,22 +375,19 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
>               */
>              assert(s->sgi_pending[irq][cpu] != 0);
>              src = ctz32(s->sgi_pending[irq][cpu]);
>              s->sgi_pending[irq][cpu] &= ~(1 << src);
>              if (s->sgi_pending[irq][cpu] == 0) {
> -                GIC_DIST_CLEAR_PENDING(irq,
> -                                       GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
> -                                                                : cm);
> +                gic_clear_pending(s, irq, cpu);
>              }
>              ret = irq | ((src & 0x7) << 10);
>          } else {
>              /* Clear pending state for both level and edge triggered
>               * interrupts. (level triggered interrupts with an active line
>               * remain pending, see gic_test_pending)
>               */
> -            GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CPU_MASK
> -                                                                 : cm);
> +            gic_clear_pending(s, irq, cpu);
>              ret = irq;
>          }
>      }
>  
>      gic_activate_irq(s, cpu, irq);
> @@ -542,11 +539,10 @@ static bool gic_eoi_split(GICState *s, int cpu, MemTxAttrs attrs)
>      return s->cpu_ctlr[cpu] & GICC_CTLR_EOIMODE;
>  }
>  
>  static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>  {
> -    int cm = 1 << cpu;
>      int group;
>  
>      if (irq >= s->num_irq) {
>          /*
>           * This handles two cases:
> @@ -557,11 +553,11 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>           * and so this is UNPREDICTABLE. We choose to ignore it.
>           */
>          return;
>      }
>  
> -    group = gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
> +    group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
>  
>      if (!gic_eoi_split(s, cpu, attrs)) {
>          /* This is UNPREDICTABLE; we choose to ignore it */
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "gic_deactivate_irq: GICC_DIR write when EOIMode clear");
> @@ -571,11 +567,11 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>      if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
>          DPRINTF("Non-secure DI for Group0 interrupt %d ignored\n", irq);
>          return;
>      }
>  
> -    GIC_DIST_CLEAR_ACTIVE(irq, cm);
> +    gic_clear_active(s, irq, cpu);
>  }
>  
>  static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>  {
>      int cm = 1 << cpu;
> @@ -606,11 +602,11 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>              DPRINTF("Set %d pending mask %x\n", irq, cm);
>              GIC_DIST_SET_PENDING(irq, cm);
>          }
>      }
>  
> -    group = gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
> +    group = gic_has_groups(s) && gic_test_group(s, irq, cpu);
>  
>      if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
>          DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq);
>          return;
>      }
> @@ -622,11 +618,11 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>  
>      gic_drop_prio(s, cpu, group);
>  
>      /* In GICv2 the guest can choose to split priority-drop and deactivate */
>      if (!gic_eoi_split(s, cpu, attrs)) {
> -        GIC_DIST_CLEAR_ACTIVE(irq, cm);
> +        gic_clear_active(s, irq, cpu);
>      }
>      gic_update(s);
>  }
>  
>  static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
> diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
> index cc5acc5d41..45c2af0bf5 100644
> --- a/hw/intc/gic_internal.h
> +++ b/hw/intc/gic_internal.h
> @@ -141,10 +141,17 @@ REG32(GICH_LR63, 0x1fc)
>  #define GICH_LR_PRIORITY(entry) (FIELD_EX32(entry, GICH_LR0, Priority) << 3)
>  #define GICH_LR_STATE(entry) (FIELD_EX32(entry, GICH_LR0, State))
>  #define GICH_LR_GROUP(entry) (FIELD_EX32(entry, GICH_LR0, Grp1))
>  #define GICH_LR_HW(entry) (FIELD_EX32(entry, GICH_LR0, HW))
>  
> +#define GICH_LR_CLEAR_PENDING(entry) \
> +        ((entry) &= ~(GICH_LR_STATE_PENDING << R_GICH_LR0_State_SHIFT))
> +#define GICH_LR_SET_ACTIVE(entry) \
> +        ((entry) |= (GICH_LR_STATE_ACTIVE << R_GICH_LR0_State_SHIFT))
> +#define GICH_LR_CLEAR_ACTIVE(entry) \
> +        ((entry) &= ~(GICH_LR_STATE_ACTIVE << R_GICH_LR0_State_SHIFT))
> +
>  /* Valid bits for GICC_CTLR for GICv1, v1 with security extensions,
>   * GICv2 and GICv2 with security extensions:
>   */
>  #define GICC_CTLR_V1_MASK    0x1
>  #define GICC_CTLR_V1_S_MASK  0x1f
> @@ -236,6 +243,82 @@ static inline uint32_t *gic_get_lr_entry(GICState *s, int irq, int vcpu)
>      }
>  
>      g_assert_not_reached();
>  }
>  
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
> +             * the distributor.
> +             */
> +            int phys_irq = GICH_LR_PHYS_ID(*entry);
> +            int rcpu = gic_get_vcpu_real_id(cpu);
> +
> +            if (phys_irq < GIC_NR_SGIS || phys_irq >= GIC_MAXIRQ) {
> +                /* UNPREDICTABLE behaviour, we choose to ignore the request */
> +                return;
> +            }
> +
> +            /* This is equivalent to a NS write to DIR on the physical CPU
> +             * interface. Hence group0 interrupt deactivation is ignored if
> +             * the GIC is secure.
> +             */
> +            if (!s->security_extn || GIC_DIST_TEST_GROUP(phys_irq, 1 << rcpu)) {
> +                GIC_DIST_CLEAR_ACTIVE(phys_irq, 1 << rcpu);
> +            }
> +        }
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
> 
