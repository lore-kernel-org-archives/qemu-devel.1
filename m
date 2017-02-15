Received: from eggs.gnu.org ([2001:4830:134:3::10]:36067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdz1Y-0007Vo-Iv
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdz1U-0006RP-P8
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:49:32 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdz1U-0006RG-G9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:49:28 -0500
Received: by mail-wm0-x22f.google.com with SMTP id r141so39779734wmg.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 04:49:28 -0800 (PST)
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-6-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1486065742-28639-6-git-send-email-peter.maydell@linaro.org>
Date: Wed, 15 Feb 2017 12:49:25 +0000
Message-ID: <87k28rvctm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/9] arm: gic: Remove references to NVIC
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
> Now that the NVIC is its own separate implementation, we can
> clean up the GIC code by removing REV_NVIC and conditionals
> which use it.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


> ---
>  hw/intc/gic_internal.h   |  7 ++-----
>  hw/intc/arm_gic.c        | 31 +++++--------------------------
>  hw/intc/arm_gic_common.c | 23 ++++++++---------------
>  3 files changed, 15 insertions(+), 46 deletions(-)
>
> diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
> index 3f31174..7fe87b1 100644
> --- a/hw/intc/gic_internal.h
> +++ b/hw/intc/gic_internal.h
> @@ -25,9 +25,7 @@
>
>  #define ALL_CPU_MASK ((unsigned)(((1 << GIC_NCPU) - 1)))
>
> -/* The NVIC has 16 internal vectors.  However these are not exposed
> -   through the normal GIC interface.  */
> -#define GIC_BASE_IRQ ((s->revision == REV_NVIC) ? 32 : 0)
> +#define GIC_BASE_IRQ 0
>
>  #define GIC_SET_ENABLED(irq, cm) s->irq_state[irq].enabled |= (cm)
>  #define GIC_CLEAR_ENABLED(irq, cm) s->irq_state[irq].enabled &= ~(cm)
> @@ -75,7 +73,6 @@
>
>  /* The special cases for the revision property: */
>  #define REV_11MPCORE 0
> -#define REV_NVIC 0xffffffff
>
>  void gic_set_pending_private(GICState *s, int cpu, int irq);
>  uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs);
> @@ -87,7 +84,7 @@ void gic_set_priority(GICState *s, int cpu, int irq, uint8_t val,
>
>  static inline bool gic_test_pending(GICState *s, int irq, int cm)
>  {
> -    if (s->revision == REV_NVIC || s->revision == REV_11MPCORE) {
> +    if (s->revision == REV_11MPCORE) {
>          return s->irq_state[irq].pending & cm;
>      } else {
>          /* Edge-triggered interrupts are marked pending on a rising edge, but
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 521aac3..8e5a9d8 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -156,17 +156,6 @@ static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
>      }
>  }
>
> -static void gic_set_irq_nvic(GICState *s, int irq, int level,
> -                                 int cm, int target)
> -{
> -    if (level) {
> -        GIC_SET_LEVEL(irq, cm);
> -        GIC_SET_PENDING(irq, target);
> -    } else {
> -        GIC_CLEAR_LEVEL(irq, cm);
> -    }
> -}
> -
>  static void gic_set_irq_generic(GICState *s, int irq, int level,
>                                  int cm, int target)
>  {
> @@ -214,8 +203,6 @@ static void gic_set_irq(void *opaque, int irq, int level)
>
>      if (s->revision == REV_11MPCORE) {
>          gic_set_irq_11mpcore(s, irq, level, cm, target);
> -    } else if (s->revision == REV_NVIC) {
> -        gic_set_irq_nvic(s, irq, level, cm, target);
>      } else {
>          gic_set_irq_generic(s, irq, level, cm, target);
>      }
> @@ -367,7 +354,7 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
>          return 1023;
>      }
>
> -    if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
> +    if (s->revision == REV_11MPCORE) {
>          /* Clear pending flags for both level and edge triggered interrupts.
>           * Level triggered IRQs will be reasserted once they become inactive.
>           */
> @@ -589,11 +576,6 @@ void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>              DPRINTF("Set %d pending mask %x\n", irq, cm);
>              GIC_SET_PENDING(irq, cm);
>          }
> -    } else if (s->revision == REV_NVIC) {
> -        if (GIC_TEST_LEVEL(irq, cm)) {
> -            DPRINTF("Set nvic %d pending mask %x\n", irq, cm);
> -            GIC_SET_PENDING(irq, cm);
> -        }
>      }
>
>      group = gic_has_groups(s) && GIC_TEST_GROUP(irq, cm);
> @@ -768,7 +750,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
>      } else if (offset < 0xf10) {
>          goto bad_reg;
>      } else if (offset < 0xf30) {
> -        if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
> +        if (s->revision == REV_11MPCORE) {
>              goto bad_reg;
>          }
>
> @@ -802,9 +784,6 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
>              case 2:
>                  res = gic_id_gicv2[(offset - 0xfd0) >> 2];
>                  break;
> -            case REV_NVIC:
> -                /* Shouldn't be able to get here */
> -                abort();
>              default:
>                  res = 0;
>              }
> @@ -1028,7 +1007,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
>                  continue; /* Ignore Non-secure access of Group0 IRQ */
>              }
>
> -            if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
> +            if (s->revision == REV_11MPCORE) {
>                  if (value & (1 << (i * 2))) {
>                      GIC_SET_MODEL(irq + i);
>                  } else {
> @@ -1046,7 +1025,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
>          goto bad_reg;
>      } else if (offset < 0xf20) {
>          /* GICD_CPENDSGIRn */
> -        if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
> +        if (s->revision == REV_11MPCORE) {
>              goto bad_reg;
>          }
>          irq = (offset - 0xf10);
> @@ -1060,7 +1039,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
>          }
>      } else if (offset < 0xf30) {
>          /* GICD_SPENDSGIRn */
> -        if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
> +        if (s->revision == REV_11MPCORE) {
>              goto bad_reg;
>          }
>          irq = (offset - 0xf20);
> diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
> index 4a8df44..70f1134 100644
> --- a/hw/intc/arm_gic_common.c
> +++ b/hw/intc/arm_gic_common.c
> @@ -99,9 +99,7 @@ void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
>       *  [N+32..N+63] PPIs for CPU 1
>       *   ...
>       */
> -    if (s->revision != REV_NVIC) {
> -        i += (GIC_INTERNAL * s->num_cpu);
> -    }
> +    i += (GIC_INTERNAL * s->num_cpu);
>      qdev_init_gpio_in(DEVICE(s), handler, i);
>
>      for (i = 0; i < s->num_cpu; i++) {
> @@ -121,16 +119,12 @@ void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
>      memory_region_init_io(&s->iomem, OBJECT(s), ops, s, "gic_dist", 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
>
> -    if (s->revision != REV_NVIC) {
> -        /* This is the main CPU interface "for this core". It is always
> -         * present because it is required by both software emulation and KVM.
> -         * NVIC is not handled here because its CPU interface is different,
> -         * neither it can use KVM.
> -         */
> -        memory_region_init_io(&s->cpuiomem[0], OBJECT(s), ops ? &ops[1] : NULL,
> -                              s, "gic_cpu", s->revision == 2 ? 0x2000 : 0x100);
> -        sysbus_init_mmio(sbd, &s->cpuiomem[0]);
> -    }
> +    /* This is the main CPU interface "for this core". It is always
> +     * present because it is required by both software emulation and KVM.
> +     */
> +    memory_region_init_io(&s->cpuiomem[0], OBJECT(s), ops ? &ops[1] : NULL,
> +                          s, "gic_cpu", s->revision == 2 ? 0x2000 : 0x100);
> +    sysbus_init_mmio(sbd, &s->cpuiomem[0]);
>  }
>
>  static void arm_gic_common_realize(DeviceState *dev, Error **errp)
> @@ -162,7 +156,7 @@ static void arm_gic_common_realize(DeviceState *dev, Error **errp)
>      }
>
>      if (s->security_extn &&
> -        (s->revision == REV_11MPCORE || s->revision == REV_NVIC)) {
> +        (s->revision == REV_11MPCORE)) {
>          error_setg(errp, "this GIC revision does not implement "
>                     "the security extensions");
>          return;
> @@ -255,7 +249,6 @@ static Property arm_gic_common_properties[] = {
>      DEFINE_PROP_UINT32("num-irq", GICState, num_irq, 32),
>      /* Revision can be 1 or 2 for GIC architecture specification
>       * versions 1 or 2, or 0 to indicate the legacy 11MPCore GIC.
> -     * (Internally, 0xffffffff also indicates "not a GIC but an NVIC".)
>       */
>      DEFINE_PROP_UINT32("revision", GICState, revision, 1),
>      /* True if the GIC should implement the security extensions */


--
Alex Bennée
