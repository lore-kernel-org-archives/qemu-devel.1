Received: from eggs.gnu.org ([2001:4830:134:3::10]:35440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdyz5-0004tz-GV
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdyz0-0005Dv-IL
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:46:59 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdyz0-0005DM-2X
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:46:54 -0500
Received: by mail-wm0-x230.google.com with SMTP id c85so40985710wmi.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 04:46:53 -0800 (PST)
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
Date: Wed, 15 Feb 2017 12:46:50 +0000
Message-ID: <87mvdnvcxx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/9] armv7m: Rewrite NVIC to not use any
 GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Michael Davidsaver <mdavidsaver@gmail.com>, Liviu Ionescu <ilg@livius.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> Despite some superficial similarities of register layout, the
> M-profile NVIC is really very different from the A-profile GIC.
> Our current attempt to reuse the GIC code means that we have
> significant bugs in our NVIC.
>
> Implement the NVIC as an entirely separate device, to give
> us somewhere we can get the behaviour correct.
>
> This initial commit does not attempt to implement exception
> priority escalation, since the GIC-based code didn't either.
> It does fix a few bugs in passing:
>  * ICSR.RETTOBASE polarity was wrong and didn't account for
>    internal exceptions
>  * ICSR.VECTPENDING was 16 too high if the pending exception
>    was for an external interrupt
>  * UsageFault, BusFault and MemFault were not disabled on reset
>    as they are supposed to be
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM: reworked, various bugs and stylistic cleanups]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 721 ++++++++++++++++++++++++++++++++++++++++----------
>  hw/intc/trace-events  |  15 ++
>  2 files changed, 592 insertions(+), 144 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index ce22001..e319077 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -17,48 +17,79 @@
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "hw/arm/arm.h"
> +#include "target/arm/cpu.h"
>  #include "exec/address-spaces.h"
> -#include "gic_internal.h"
>  #include "qemu/log.h"
> +#include "trace.h"
> +
> +/* IRQ number counting:
> + *
> + * the num-irq property counts the number of external IRQ lines
> + *
> + * NVICState::num_irq counts the total number of exceptions
> + * (external IRQs, the 15 internal exceptions including reset,
> + * and one for the unused exception number 0).
> + *
> + * NVIC_MAX_IRQ is the highest permitted number of external IRQ lines.
> + *
> + * NVIC_MAX_VECTORS is the highest permitted number of exceptions.
> + *
> + * Iterating through all exceptions should typically be done with
> + * for (i = 1; i < s->num_irq; i++) to avoid the unused slot 0.
> + *
> + * The external qemu_irq lines are the NVIC's external IRQ lines,
> + * so line 0 is exception 16.
> + */
> +#define NVIC_FIRST_IRQ 16
> +#define NVIC_MAX_VECTORS 512
> +#define NVIC_MAX_IRQ (NVIC_MAX_VECTORS - NVIC_FIRST_IRQ)
> +
> +/* Effective running priority of the CPU when no exception is active
> + * (higher than the highest possible priority value)
> + */
> +#define NVIC_NOEXC_PRIO 0x100
> +
> +typedef struct VecInfo {
> +    int16_t prio; /* priorities can range from -3 to 255 */
> +    uint8_t enabled;
> +    uint8_t pending;
> +    uint8_t active;
> +    uint8_t level; /* exceptions <=15 never set level */
> +} VecInfo;
>
>  typedef struct NVICState {
> -    GICState gic;
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
>      ARMCPU *cpu;
>
> +    VecInfo vectors[NVIC_MAX_VECTORS];
>      uint32_t prigroup;
>
> +    /* vectpending and exception_prio are both cached state that can
> +     * be recalculated from the vectors[] array and the prigroup field.
> +     */
> +    unsigned int vectpending; /* highest prio pending enabled exception */
> +    int exception_prio; /* group prio of the highest prio active exception */
> +

nit: the field comments could be more neatly rolled into the block
comment above them.

>      struct {
>          uint32_t control;
>          uint32_t reload;
>          int64_t tick;
>          QEMUTimer *timer;
>      } systick;
> +
>      MemoryRegion sysregmem;
> -    MemoryRegion gic_iomem_alias;
>      MemoryRegion container;
> +
>      uint32_t num_irq;
> +    qemu_irq excpout;
>      qemu_irq sysresetreq;
>  } NVICState;
>
>  #define TYPE_NVIC "armv7m_nvic"
> -/**
> - * NVICClass:
> - * @parent_reset: the parent class' reset handler.
> - *
> - * A model of the v7M NVIC and System Controller
> - */
> -typedef struct NVICClass {
> -    /*< private >*/
> -    ARMGICClass parent_class;
> -    /*< public >*/
> -    DeviceRealize parent_realize;
> -    void (*parent_reset)(DeviceState *dev);
> -} NVICClass;
> -
> -#define NVIC_CLASS(klass) \
> -    OBJECT_CLASS_CHECK(NVICClass, (klass), TYPE_NVIC)
> -#define NVIC_GET_CLASS(obj) \
> -    OBJECT_GET_CLASS(NVICClass, (obj), TYPE_NVIC)
> +
>  #define NVIC(obj) \
>      OBJECT_CHECK(NVICState, (obj), TYPE_NVIC)
>
> @@ -125,47 +156,274 @@ static void systick_reset(NVICState *s)
>      timer_del(s->systick.timer);
>  }
>
> -/* The external routines use the hardware vector numbering, ie. the first
> -   IRQ is #16.  The internal GIC routines use #32 as the first IRQ.  */
> +static int nvic_pending_prio(NVICState *s)
> +{
> +    /* return the priority of the current pending interrupt,
> +     * or NVIC_NOEXC_PRIO if no interrupt is pending
> +     */
> +    return s->vectpending ? s->vectors[s->vectpending].prio : NVIC_NOEXC_PRIO;
> +}
> +
> +/* Return the value of the ISCR RETTOBASE bit:
> + * 1 if there is exactly one active exception
> + * 0 if there is more than one active exception
> + * UNKNOWN if there are no active exceptions (we choose 0)
> + */

This doesn't match what the ARMv7M ARM says (for Handler mode):

  0 There is an active exception other than the exception shown by IPSR.
  1 There is no active exception other than any exception shown by IPSR.

> +static bool nvic_rettobase(NVICState *s)
> +{
> +    int irq, nhand = 0;
> +
> +    for (irq = ARMV7M_EXCP_RESET; irq < s->num_irq; irq++) {
> +        if (s->vectors[irq].active) {

I would expect && !what the ISPR is reporting. However looking at the
code it doesn't look like we ever report an exception in the IPSR
(assuming HELPER(v7m_mrs) is the right one).

> +            nhand++;
> +            if (nhand == 2) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    return nhand == 1;
> +}
> +
> +/* Return the value of the ISCR ISRPENDING bit:
> + * 1 if an external interrupt is pending
> + * 0 if no external interrupt is pending
> + */
> +static bool nvic_isrpending(NVICState *s)
> +{
> +    int irq;
> +
> +    /* We can shortcut if the highest priority pending interrupt
> +     * happens to be external or if there is nothing pending.
> +     */
> +    if (s->vectpending > NVIC_FIRST_IRQ) {
> +        return true;
> +    }
> +    if (s->vectpending == 0) {
> +        return false;
> +    }
> +
> +    for (irq = NVIC_FIRST_IRQ; irq < s->num_irq; irq++) {

Should NVIC_FIRST_IRQ be renamed to NVIC_FIRST_EXTERNAL_IRQ?

> +        if (s->vectors[irq].pending) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +/* Return a mask word which clears the subpriority bits from
> + * a priority value for an M-profile exception, leaving only
> + * the group priority.
> + */
> +static inline uint32_t nvic_gprio_mask(NVICState *s)
> +{
> +    return ~0U << (s->prigroup + 1);

I wonder if it is worth adding MAKE_32BIT_MASK to bitops.h?

> +}
> +
> +/* Recompute vectpending and exception_prio */
> +static void nvic_recompute_state(NVICState *s)
> +{
> +    int i;
> +    int pend_prio = NVIC_NOEXC_PRIO;
> +    int active_prio = NVIC_NOEXC_PRIO;
> +    int pend_irq = 0;
> +
> +    for (i = 1; i < s->num_irq; i++) {
> +        VecInfo *vec = &s->vectors[i];
> +
> +        if (vec->enabled && vec->pending && vec->prio < pend_prio) {
> +            pend_prio = vec->prio;
> +            pend_irq = i;
> +        }
> +        if (vec->active && vec->prio < active_prio) {
> +            active_prio = vec->prio;
> +        }
> +    }
> +
> +    s->vectpending = pend_irq;
> +    s->exception_prio = active_prio & nvic_gprio_mask(s);
> +
> +    trace_nvic_recompute_state(s->vectpending, s->exception_prio);
> +}
> +
> +/* Return the current execution priority of the CPU
> + * (equivalent to the pseudocode ExecutionPriority function).
> + * This is a value between -2 (NMI priority) and NVIC_NOEXC_PRIO.
> + */
> +static inline int nvic_exec_prio(NVICState *s)
> +{
> +    CPUARMState *env = &s->cpu->env;
> +    int running;
> +
> +    if (env->daif & PSTATE_F) { /* FAULTMASK */
> +        running = -1;
> +    } else if (env->daif & PSTATE_I) { /* PRIMASK */
> +        running = 0;
> +    } else if (env->v7m.basepri > 0) {
> +        running = env->v7m.basepri & nvic_gprio_mask(s);
> +    } else {
> +        running = NVIC_NOEXC_PRIO; /* lower than any possible priority */
> +    }
> +    /* consider priority of active handler */
> +    return MIN(running, s->exception_prio);
> +}
> +
> +/* caller must call nvic_irq_update() after this */
> +static void set_prio(NVICState *s, unsigned irq, uint8_t prio)
> +{
> +    assert(irq > ARMV7M_EXCP_NMI); /* only use for configurable prios */
> +    assert(irq < s->num_irq);
> +
> +    s->vectors[irq].prio = prio;

So this means the negative priorities are hardwired parts of the NVIC
for NMI/RESET? Maybe we should make that clearer in the comment for
VecInfo.

> +
> +    trace_nvic_set_prio(irq, prio);
> +}
> +
> +/* Recompute state and assert irq line accordingly.
> + * Must be called after changes to:
> + *  vec->active, vec->enabled, vec->pending or vec->prio for any vector
> + *  prigroup
> + */
> +static void nvic_irq_update(NVICState *s)
> +{
> +    int lvl;
> +    int pend_prio;
> +
> +    nvic_recompute_state(s);
> +    pend_prio = nvic_pending_prio(s);
> +
> +    /* Raise NVIC output if this IRQ would be taken, except that we
> +     * ignore the effects of the BASEPRI, FAULTMASK and PRIMASK (which
> +     * will be checked for in arm_v7m_cpu_exec_interrupt()); changes
> +     * to those CPU registers don't cause us to recalculate the NVIC
> +     * pending info.
> +     */
> +    lvl = (pend_prio < s->exception_prio);
> +    trace_nvic_irq_update(s->vectpending, pend_prio, s->exception_prio, lvl);
> +    qemu_set_irq(s->excpout, lvl);
> +}
> +
> +static void armv7m_nvic_clear_pending(void *opaque, int irq)
> +{
> +    NVICState *s = (NVICState *)opaque;
> +    VecInfo *vec;
> +
> +    assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
> +
> +    vec = &s->vectors[irq];
> +    trace_nvic_clear_pending(irq, vec->enabled, vec->prio);
> +    if (vec->pending) {
> +        vec->pending = 0;
> +        nvic_irq_update(s);
> +    }
> +}
> +
>  void armv7m_nvic_set_pending(void *opaque, int irq)
>  {
>      NVICState *s = (NVICState *)opaque;
> -    if (irq >= 16)
> -        irq += 16;
> -    gic_set_pending_private(&s->gic, 0, irq);
> +    VecInfo *vec;
> +
> +    assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
> +
> +    vec = &s->vectors[irq];
> +    trace_nvic_set_pending(irq, vec->enabled, vec->prio);
> +    if (!vec->pending) {
> +        vec->pending = 1;
> +        nvic_irq_update(s);
> +    }
>  }
>
>  /* Make pending IRQ active.  */
>  int armv7m_nvic_acknowledge_irq(void *opaque)
>  {
>      NVICState *s = (NVICState *)opaque;
> -    uint32_t irq;
> -
> -    irq = gic_acknowledge_irq(&s->gic, 0, MEMTXATTRS_UNSPECIFIED);
> -    if (irq == 1023)
> -        hw_error("Interrupt but no vector\n");
> -    if (irq >= 32)
> -        irq -= 16;
> -    return irq;
> +    CPUARMState *env = &s->cpu->env;
> +    const int pending = s->vectpending;
> +    const int running = nvic_exec_prio(s);
> +    int pendgroupprio;
> +    VecInfo *vec;
> +
> +    assert(pending > ARMV7M_EXCP_RESET && pending < s->num_irq);
> +
> +    vec = &s->vectors[pending];
> +
> +    assert(vec->enabled);
> +    assert(vec->pending);
> +
> +    pendgroupprio = vec->prio & nvic_gprio_mask(s);
> +    assert(pendgroupprio < running);

I'm all for asserts to declare what the API is expecting. These are
starting to look like being unsure of the nvic being in the correct
state. Are they left over from debugging?

> +
> +    trace_nvic_acknowledge_irq(pending, vec->prio);
> +
> +    vec->active = 1;
> +    vec->pending = 0;
> +
> +    env->v7m.exception = s->vectpending;
> +
> +    nvic_irq_update(s);
> +
> +    return env->v7m.exception;
>  }
>
>  void armv7m_nvic_complete_irq(void *opaque, int irq)
>  {
>      NVICState *s = (NVICState *)opaque;
> -    if (irq >= 16)
> -        irq += 16;
> -    gic_complete_irq(&s->gic, 0, irq, MEMTXATTRS_UNSPECIFIED);
> +    VecInfo *vec;
> +
> +    assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
> +
> +    vec = &s->vectors[irq];
> +
> +    trace_nvic_complete_irq(irq);
> +
> +    vec->active = 0;
> +    if (vec->level) {
> +        /* Re-pend the exception if it's still held high; only
> +         * happens for extenal IRQs
> +         */
> +        assert(irq >= NVIC_FIRST_IRQ);
> +        vec->pending = 1;
> +    }
> +
> +    nvic_irq_update(s);
> +}
> +
> +/* callback when external interrupt line is changed */
> +static void set_irq_level(void *opaque, int n, int level)
> +{
> +    NVICState *s = opaque;
> +    VecInfo *vec;
> +
> +    n += NVIC_FIRST_IRQ;
> +
> +    assert(n >= NVIC_FIRST_IRQ && n < s->num_irq);
> +
> +    trace_nvic_set_irq_level(n, level);
> +
> +    /* The pending status of an external interrupt is
> +     * latched on rising edge and exception handler return.
> +     *
> +     * Pulsing the IRQ will always run the handler
> +     * once, and the handler will re-run until the
> +     * level is low when the handler completes.
> +     */
> +    vec = &s->vectors[n];
> +    if (level != vec->level) {
> +        vec->level = level;
> +        if (level) {
> +            armv7m_nvic_set_pending(s, n);
> +        }
> +    }
>  }
>
>  static uint32_t nvic_readl(NVICState *s, uint32_t offset)
>  {
>      ARMCPU *cpu = s->cpu;
>      uint32_t val;
> -    int irq;
>
>      switch (offset) {
>      case 4: /* Interrupt Control Type.  */
> -        return (s->num_irq / 32) - 1;
> +        return ((s->num_irq - NVIC_FIRST_IRQ) / 32) - 1;
>      case 0x10: /* SysTick Control and Status.  */
>          val = s->systick.control;
>          s->systick.control &= ~SYSTICK_COUNTFLAG;
> @@ -195,33 +453,29 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
>      case 0xd04: /* Interrupt Control State.  */
>          /* VECTACTIVE */
>          val = cpu->env.v7m.exception;
> -        if (val == 1023) {
> -            val = 0;
> -        } else if (val >= 32) {
> -            val -= 16;
> -        }
>          /* VECTPENDING */
> -        if (s->gic.current_pending[0] != 1023)
> -            val |= (s->gic.current_pending[0] << 12);
> -        /* ISRPENDING and RETTOBASE */
> -        for (irq = 32; irq < s->num_irq; irq++) {
> -            if (s->gic.irq_state[irq].pending) {
> -                val |= (1 << 22);
> -                break;
> -            }
> -            if (irq != cpu->env.v7m.exception && s->gic.irq_state[irq].active) {
> -                val |= (1 << 11);
> -            }
> +        val |= (s->vectpending & 0xff) << 12;
> +        /* ISRPENDING - set if any external IRQ is pending */
> +        if (nvic_isrpending(s)) {
> +            val |= (1 << 22);
> +        }
> +        /* RETTOBASE - set if only one handler is active */
> +        if (nvic_rettobase(s)) {
> +            val |= (1 << 11);
>          }
>          /* PENDSTSET */
> -        if (s->gic.irq_state[ARMV7M_EXCP_SYSTICK].pending)
> +        if (s->vectors[ARMV7M_EXCP_SYSTICK].pending) {
>              val |= (1 << 26);
> +        }
>          /* PENDSVSET */
> -        if (s->gic.irq_state[ARMV7M_EXCP_PENDSV].pending)
> +        if (s->vectors[ARMV7M_EXCP_PENDSV].pending) {
>              val |= (1 << 28);
> +        }
>          /* NMIPENDSET */
> -        if (s->gic.irq_state[ARMV7M_EXCP_NMI].pending)
> +        if (s->vectors[ARMV7M_EXCP_NMI].pending) {
>              val |= (1 << 31);
> +        }
> +        /* ISRPREEMPT not implemented */
>          return val;
>      case 0xd08: /* Vector Table Offset.  */
>          return cpu->env.v7m.vecbase;
> @@ -234,20 +488,48 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset)
>          return cpu->env.v7m.ccr;
>      case 0xd24: /* System Handler Status.  */
>          val = 0;
> -        if (s->gic.irq_state[ARMV7M_EXCP_MEM].active) val |= (1 << 0);
> -        if (s->gic.irq_state[ARMV7M_EXCP_BUS].active) val |= (1 << 1);
> -        if (s->gic.irq_state[ARMV7M_EXCP_USAGE].active) val |= (1 << 3);
> -        if (s->gic.irq_state[ARMV7M_EXCP_SVC].active) val |= (1 << 7);
> -        if (s->gic.irq_state[ARMV7M_EXCP_DEBUG].active) val |= (1 << 8);
> -        if (s->gic.irq_state[ARMV7M_EXCP_PENDSV].active) val |= (1 << 10);
> -        if (s->gic.irq_state[ARMV7M_EXCP_SYSTICK].active) val |= (1 << 11);
> -        if (s->gic.irq_state[ARMV7M_EXCP_USAGE].pending) val |= (1 << 12);
> -        if (s->gic.irq_state[ARMV7M_EXCP_MEM].pending) val |= (1 << 13);
> -        if (s->gic.irq_state[ARMV7M_EXCP_BUS].pending) val |= (1 << 14);
> -        if (s->gic.irq_state[ARMV7M_EXCP_SVC].pending) val |= (1 << 15);
> -        if (s->gic.irq_state[ARMV7M_EXCP_MEM].enabled) val |= (1 << 16);
> -        if (s->gic.irq_state[ARMV7M_EXCP_BUS].enabled) val |= (1 << 17);
> -        if (s->gic.irq_state[ARMV7M_EXCP_USAGE].enabled) val |= (1 << 18);
> +        if (s->vectors[ARMV7M_EXCP_MEM].active) {
> +            val |= (1 << 0);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_BUS].active) {
> +            val |= (1 << 1);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_USAGE].active) {
> +            val |= (1 << 3);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_SVC].active) {
> +            val |= (1 << 7);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_DEBUG].active) {
> +            val |= (1 << 8);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_PENDSV].active) {
> +            val |= (1 << 10);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_SYSTICK].active) {
> +            val |= (1 << 11);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_USAGE].pending) {
> +            val |= (1 << 12);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_MEM].pending) {
> +            val |= (1 << 13);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_BUS].pending) {
> +            val |= (1 << 14);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_SVC].pending) {
> +            val |= (1 << 15);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_MEM].enabled) {
> +            val |= (1 << 16);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_BUS].enabled) {
> +            val |= (1 << 17);
> +        }
> +        if (s->vectors[ARMV7M_EXCP_USAGE].enabled) {
> +            val |= (1 << 18);
> +        }
>          return val;
>      case 0xd28: /* Configurable Fault Status.  */
>          return cpu->env.v7m.cfsr;
> @@ -341,14 +623,12 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
>          if (value & (1 << 28)) {
>              armv7m_nvic_set_pending(s, ARMV7M_EXCP_PENDSV);
>          } else if (value & (1 << 27)) {
> -            s->gic.irq_state[ARMV7M_EXCP_PENDSV].pending = 0;
> -            gic_update(&s->gic);
> +            armv7m_nvic_clear_pending(s, ARMV7M_EXCP_PENDSV);
>          }
>          if (value & (1 << 26)) {
>              armv7m_nvic_set_pending(s, ARMV7M_EXCP_SYSTICK);
>          } else if (value & (1 << 25)) {
> -            s->gic.irq_state[ARMV7M_EXCP_SYSTICK].pending = 0;
> -            gic_update(&s->gic);
> +            armv7m_nvic_clear_pending(s, ARMV7M_EXCP_SYSTICK);
>          }
>          break;
>      case 0xd08: /* Vector Table Offset.  */
> @@ -366,6 +646,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
>                  qemu_log_mask(LOG_UNIMP, "AIRCR system reset unimplemented\n");
>              }
>              s->prigroup = extract32(value, 8, 3);
> +            nvic_irq_update(s);
>          }
>          break;
>      case 0xd10: /* System Control.  */
> @@ -386,9 +667,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
>      case 0xd24: /* System Handler Control.  */
>          /* TODO: Real hardware allows you to set/clear the active bits
>             under some circumstances.  We don't implement this.  */
> -        s->gic.irq_state[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
> -        s->gic.irq_state[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
> -        s->gic.irq_state[ARMV7M_EXCP_USAGE].enabled = (value & (1 << 18)) != 0;
> +        s->vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
> +        s->vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
> +        s->vectors[ARMV7M_EXCP_USAGE].enabled = (value & (1 << 18)) != 0;
> +        nvic_irq_update(s);
>          break;
>      case 0xd28: /* Configurable Fault Status.  */
>          cpu->env.v7m.cfsr &= ~value; /* W1C */
> @@ -410,13 +692,16 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
>                        "NVIC: Aux fault status registers unimplemented\n");
>          break;
>      case 0xf00: /* Software Triggered Interrupt Register */
> +    {
>          /* user mode can only write to STIR if CCR.USERSETMPEND permits it */
> -        if ((value & 0x1ff) < s->num_irq &&
> +        int excnum = (value & 0x1ff) + NVIC_FIRST_IRQ;
> +        if (excnum < s->num_irq &&
>              (arm_current_el(&cpu->env) ||
>               (cpu->env.v7m.ccr & R_V7M_CCR_USERSETMPEND_MASK))) {
> -            gic_set_pending_private(&s->gic, 0, value & 0x1ff);
> +            armv7m_nvic_set_pending(s, excnum);
>          }
>          break;
> +    }
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "NVIC: Bad write offset 0x%x\n", offset);
> @@ -428,28 +713,81 @@ static uint64_t nvic_sysreg_read(void *opaque, hwaddr addr,
>  {
>      NVICState *s = (NVICState *)opaque;
>      uint32_t offset = addr;
> -    int i;
> +    unsigned i, end;
>      uint32_t val;
>
>      switch (offset) {
> +    /* reads of set and clear both return the status */
> +    case 0x100 ... 0x13f: /* NVIC Set enable */
> +        offset += 0x80;
> +        /* fall through */
> +    case 0x180 ... 0x1bf: /* NVIC Clear enable */
> +        val = 0;
> +        offset = offset - 0x180 + NVIC_FIRST_IRQ; /* vector # */

Can we not calculate a vector index rather than abusing the meaning of
offset while switching on it?

> +
> +        for (i = 0, end = size * 8; i < end && offset + i < s->num_irq; i++) {
> +            if (s->vectors[offset + i].enabled) {
> +                val |= (1 << i);
> +            }
> +        }
> +        break;
> +    case 0x200 ... 0x23f: /* NVIC Set pend */
> +        offset += 0x80;
> +        /* fall through */
> +    case 0x280 ... 0x2bf: /* NVIC Clear pend */
> +        val = 0;
> +        offset = offset - 0x280 + NVIC_FIRST_IRQ; /* vector # */
> +
> +        for (i = 0, end = size * 8; i < end && offset + i < s->num_irq; i++) {
> +            if (s->vectors[offset + i].pending) {
> +                val |= (1 << i);
> +            }
> +        }
> +        break;
> +    case 0x300 ... 0x33f: /* NVIC Active */
> +        val = 0;
> +        offset = offset - 0x300 + NVIC_FIRST_IRQ; /* vector # */
> +
> +        for (i = 0, end = size * 8; i < end && offset + i < s->num_irq; i++) {
> +            if (s->vectors[offset + i].active) {
> +                val |= (1 << i);
> +            }
> +        }
> +        break;
> +    case 0x400 ... 0x5ef: /* NVIC Priority */
> +        val = 0;
> +        offset = offset - 0x400 + NVIC_FIRST_IRQ; /* vector # */
> +
> +        for (i = 0; i < size && offset + i < s->num_irq; i++) {
> +            val |= s->vectors[offset + i].prio << (8 * i);
> +        }
> +        break;
>      case 0xd18 ... 0xd23: /* System Handler Priority.  */
>          val = 0;
>          for (i = 0; i < size; i++) {
> -            val |= s->gic.priority1[(offset - 0xd14) + i][0] << (i * 8);
> +            val |= s->vectors[(offset - 0xd14) + i].prio << (i * 8);
>          }
> -        return val;
> +        break;
>      case 0xfe0 ... 0xfff: /* ID.  */
>          if (offset & 3) {
> -            return 0;
> +            val = 0;
> +        } else {
> +            val = nvic_id[(offset - 0xfe0) >> 2];
> +        }
> +        break;
> +    default:
> +        if (size == 4) {
> +            val = nvic_readl(s, offset);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "NVIC: Bad read of size %d at offset 0x%x\n",
> +                          size, offset);
> +            val = 0;
>          }
> -        return nvic_id[(offset - 0xfe0) >> 2];
> -    }
> -    if (size == 4) {
> -        return nvic_readl(s, offset);
>      }
> -    qemu_log_mask(LOG_GUEST_ERROR,
> -                  "NVIC: Bad read of size %d at offset 0x%x\n", size, offset);
> -    return 0;
> +
> +    trace_nvic_sysreg_read(addr, val, size);
> +    return val;
>  }
>
>  static void nvic_sysreg_write(void *opaque, hwaddr addr,
> @@ -457,15 +795,59 @@ static void nvic_sysreg_write(void *opaque, hwaddr addr,
>  {
>      NVICState *s = (NVICState *)opaque;
>      uint32_t offset = addr;
> -    int i;
> +    unsigned i, end;
> +    unsigned setval = 0;
> +
> +    trace_nvic_sysreg_write(addr, value, size);
>
>      switch (offset) {
> +    case 0x100 ... 0x13f: /* NVIC Set enable */
> +        offset += 0x80;
> +        setval = 1;
> +        /* fall through */
> +    case 0x180 ... 0x1bf: /* NVIC Clear enable */
> +        offset = 8 * (offset - 0x180) + NVIC_FIRST_IRQ; /* vector # */
> +
> +        for (i = 0, end = size * 8; i < end && offset + i < s->num_irq; i++) {
> +            if (value & (1 << i)) {
> +                s->vectors[offset + i].enabled = setval;
> +            }
> +        }
> +        nvic_irq_update(s);
> +        return;
> +    case 0x200 ... 0x23f: /* NVIC Set pend */
> +        /* the special logic in armv7m_nvic_set_pending()
> +         * is not needed since IRQs are never escalated
> +         */
> +        offset += 0x80;
> +        setval = 1;
> +        /* fall through */
> +    case 0x280 ... 0x2bf: /* NVIC Clear pend */
> +        offset = 8 * (offset - 0x280) + NVIC_FIRST_IRQ; /* vector # */
> +
> +        for (i = 0, end = size * 8; i < end && offset + i < s->num_irq; i++) {
> +            if (value & (1 << i)) {
> +                s->vectors[offset + i].pending = setval;
> +            }
> +        }
> +        nvic_irq_update(s);
> +        return;
> +    case 0x300 ... 0x33f: /* NVIC Active */
> +        return; /* R/O */
> +    case 0x400 ... 0x5ef: /* NVIC Priority */
> +        offset = 8 * (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
> +
> +        for (i = 0; i < size; i++) {
> +            set_prio(s, offset + i, (value >> (i * 8)) & 0xff);
> +        }
> +        nvic_irq_update(s);
> +        return;
>      case 0xd18 ... 0xd23: /* System Handler Priority.  */
>          for (i = 0; i < size; i++) {
> -            s->gic.priority1[(offset - 0xd14) + i][0] =
> -                (value >> (i * 8)) & 0xff;
> +            unsigned hdlidx = (offset - 0xd14) + i;
> +            set_prio(s, hdlidx, (value >> (i * 8)) & 0xff);
>          }
> -        gic_update(&s->gic);
> +        nvic_irq_update(s);
>          return;
>      }
>      if (size == 4) {
> @@ -482,11 +864,50 @@ static const MemoryRegionOps nvic_sysreg_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>
> +static int nvic_post_load(void *opaque, int version_id)
> +{
> +    NVICState *s = opaque;
> +    unsigned i;
> +
> +    /* Check for out of range priority settings */
> +    if (s->vectors[ARMV7M_EXCP_RESET].prio != -3 ||
> +        s->vectors[ARMV7M_EXCP_NMI].prio != -2 ||
> +        s->vectors[ARMV7M_EXCP_HARD].prio != -1) {
> +        return 1;
> +    }
> +    for (i = ARMV7M_EXCP_MEM; i < s->num_irq; i++) {
> +        if (s->vectors[i].prio & ~0xff) {
> +            return 1;
> +        }
> +    }
> +
> +    nvic_recompute_state(s);
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_VecInfo = {
> +    .name = "armv7m_nvic_info",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT16(prio, VecInfo),
> +        VMSTATE_UINT8(enabled, VecInfo),
> +        VMSTATE_UINT8(pending, VecInfo),
> +        VMSTATE_UINT8(active, VecInfo),
> +        VMSTATE_UINT8(level, VecInfo),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_nvic = {
>      .name = "armv7m_nvic",
> -    .version_id = 2,
> -    .minimum_version_id = 2,
> +    .version_id = 3,
> +    .minimum_version_id = 3,
> +    .post_load = &nvic_post_load,
>      .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_ARRAY(vectors, NVICState, NVIC_MAX_VECTORS, 1,
> +                             vmstate_VecInfo, VecInfo),
>          VMSTATE_UINT32(systick.control, NVICState),
>          VMSTATE_UINT32(systick.reload, NVICState),
>          VMSTATE_INT64(systick.tick, NVICState),
> @@ -496,48 +917,72 @@ static const VMStateDescription vmstate_nvic = {
>      }
>  };
>
> +static Property props_nvic[] = {
> +    /* Number of external IRQ lines (so excluding the 16 internal exceptions) */
> +    DEFINE_PROP_UINT32("num-irq", NVICState, num_irq, 64),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>  static void armv7m_nvic_reset(DeviceState *dev)
>  {
>      NVICState *s = NVIC(dev);
> -    NVICClass *nc = NVIC_GET_CLASS(s);
> -    nc->parent_reset(dev);
> -    /* Common GIC reset resets to disabled; the NVIC doesn't have
> -     * per-CPU interfaces so mark our non-existent CPU interface
> -     * as enabled by default, and with a priority mask which allows
> -     * all interrupts through.
> +
> +    s->vectors[ARMV7M_EXCP_NMI].enabled = 1;
> +    s->vectors[ARMV7M_EXCP_HARD].enabled = 1;
> +    /* MEM, BUS, and USAGE are enabled through
> +     * the System Handler Control register
>       */
> -    s->gic.cpu_ctlr[0] = GICC_CTLR_EN_GRP0;
> -    s->gic.priority_mask[0] = 0x100;
> -    /* The NVIC as a whole is always enabled. */
> -    s->gic.ctlr = 1;
> +    s->vectors[ARMV7M_EXCP_SVC].enabled = 1;
> +    s->vectors[ARMV7M_EXCP_DEBUG].enabled = 1;
> +    s->vectors[ARMV7M_EXCP_PENDSV].enabled = 1;
> +    s->vectors[ARMV7M_EXCP_SYSTICK].enabled = 1;
> +
> +    s->vectors[ARMV7M_EXCP_RESET].prio = -3;
> +    s->vectors[ARMV7M_EXCP_NMI].prio = -2;
> +    s->vectors[ARMV7M_EXCP_HARD].prio = -1;
> +
> +    /* Strictly speaking the reset handler should be enabled.
> +     * However, we don't simulate soft resets through the NVIC,
> +     * and the reset vector should never be pended.
> +     * So we leave it disabled to catch logic errors.
> +     */
> +
> +    s->exception_prio = NVIC_NOEXC_PRIO;
> +    s->vectpending = 0;
> +
>      systick_reset(s);
>  }
>
>  static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>  {
>      NVICState *s = NVIC(dev);
> -    NVICClass *nc = NVIC_GET_CLASS(s);
> -    Error *local_err = NULL;
>
>      s->cpu = ARM_CPU(qemu_get_cpu(0));
>      assert(s->cpu);
> -    /* The NVIC always has only one CPU */
> -    s->gic.num_cpu = 1;
> -    /* Tell the common code we're an NVIC */
> -    s->gic.revision = 0xffffffff;
> -    s->num_irq = s->gic.num_irq;
> -    nc->parent_realize(dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +
> +    if (s->num_irq > NVIC_MAX_IRQ) {
> +        error_setg(errp, "num-irq %d exceeds NVIC maximum", s->num_irq);
>          return;
>      }
> -    gic_init_irqs_and_distributor(&s->gic);
> -    /* The NVIC and system controller register area looks like this:
> -     *  0..0xff : system control registers, including systick
> -     *  0x100..0xcff : GIC-like registers
> -     *  0xd00..0xfff : system control registers
> -     * We use overlaying to put the GIC like registers
> -     * over the top of the system control register region.
> +
> +    qdev_init_gpio_in(dev, set_irq_level, s->num_irq);
> +
> +    /* include space for internal exception vectors */
> +    s->num_irq += NVIC_FIRST_IRQ;
> +
> +    /* The NVIC and system controller register area starts at 0xe000e000
> +     * and looks like this:

s/system controller register area/System Control Space (SCS)/ to make it
easier to find in the ARM ARM.

> +     *  0x004 - ICTR
> +     *  0x010 - 0x1c - systick
> +     *  0x100..0x7ec - NVIC
> +     *  0x7f0..0xcff - Reserved
> +     *  0xd00..0xd3c - SCS registers
> +     *  0xd40..0xeff - Reserved or Not implemented
> +     *  0xf00 - STIR
> +     *
> +     * At the moment there is only one thing in the container region,
> +     * but we leave it in place to allow us to pull systick out into
> +     * its own device object later.
>       */
>      memory_region_init(&s->container, OBJECT(s), "nvic", 0x1000);
>      /* The system register region goes at the bottom of the priority
> @@ -546,14 +991,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>      memory_region_init_io(&s->sysregmem, OBJECT(s), &nvic_sysreg_ops, s,
>                            "nvic_sysregs", 0x1000);
>      memory_region_add_subregion(&s->container, 0, &s->sysregmem);
> -    /* Alias the GIC region so we can get only the section of it
> -     * we need, and layer it on top of the system register region.
> -     */
> -    memory_region_init_alias(&s->gic_iomem_alias, OBJECT(s),
> -                             "nvic-gic", &s->gic.iomem,
> -                             0x100, 0xc00);
> -    memory_region_add_subregion_overlap(&s->container, 0x100,
> -                                        &s->gic_iomem_alias, 1);
> +
>      /* Map the whole thing into system memory at the location required
>       * by the v7M architecture.
>       */
> @@ -569,36 +1007,31 @@ static void armv7m_nvic_instance_init(Object *obj)
>       * any user-specified property setting, so just modify the
>       * value in the GICState struct.
>       */
> -    GICState *s = ARM_GIC_COMMON(obj);
>      DeviceState *dev = DEVICE(obj);
>      NVICState *nvic = NVIC(obj);
> -    /* The ARM v7m may have anything from 0 to 496 external interrupt
> -     * IRQ lines. We default to 64. Other boards may differ and should
> -     * set the num-irq property appropriately.
> -     */
> -    s->num_irq = 64;
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    sysbus_init_irq(sbd, &nvic->excpout);
>      qdev_init_gpio_out_named(dev, &nvic->sysresetreq, "SYSRESETREQ", 1);
>  }
>
>  static void armv7m_nvic_class_init(ObjectClass *klass, void *data)
>  {
> -    NVICClass *nc = NVIC_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>
> -    nc->parent_reset = dc->reset;
> -    nc->parent_realize = dc->realize;
>      dc->vmsd  = &vmstate_nvic;
> +    dc->props = props_nvic;
>      dc->reset = armv7m_nvic_reset;
>      dc->realize = armv7m_nvic_realize;
>  }
>
>  static const TypeInfo armv7m_nvic_info = {
>      .name          = TYPE_NVIC,
> -    .parent        = TYPE_ARM_GIC_COMMON,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_init = armv7m_nvic_instance_init,
>      .instance_size = sizeof(NVICState),
>      .class_init    = armv7m_nvic_class_init,
> -    .class_size    = sizeof(NVICClass),
> +    .class_size    = sizeof(SysBusDeviceClass),
>  };
>
>  static void armv7m_nvic_register_types(void)
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 39a538d..729c128 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -161,3 +161,18 @@ gicv3_redist_write(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size,
>  gicv3_redist_badwrite(uint32_t cpu, uint64_t offset, uint64_t data, unsigned size, bool secure) "GICv3 redistributor %x write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u secure %d: error"
>  gicv3_redist_set_irq(uint32_t cpu, int irq, int level) "GICv3 redistributor %x interrupt %d level changed to %d"
>  gicv3_redist_send_sgi(uint32_t cpu, int irq) "GICv3 redistributor %x pending SGI %d"
> +
> +# hw/intc/armv7m_nvic.c
> +nvic_recompute_state(int vectpending, int exception_prio) "NVIC state recomputed: vectpending %d exception_prio %d"
> +nvic_set_prio(int irq, uint8_t prio) "NVIC set irq %d priority %d"
> +nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
> +nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
> +nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
> +nvic_set_pending(int irq, int en, int prio) "NVIC set pending irq %d (enabled: %d priority %d)"
> +nvic_clear_pending(int irq, int en, int prio) "NVIC clear pending irq %d (enabled: %d priority %d)"
> +nvic_set_pending_level(int irq) "NVIC set pending: irq %d higher prio than vectpending: setting irq line to 1"
> +nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
> +nvic_complete_irq(int irq) "NVIC complete IRQ %d"
> +nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
> +nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
> +nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"


--
Alex Bennée
