Received: from eggs.gnu.org ([2001:4830:134:3::10]:35090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etzfy-00072S-Bt
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etzfx-00053O-0c
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:49:58 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:46389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etzfw-00052w-Pl
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:49:56 -0500
Received: by mail-ot0-x229.google.com with SMTP id g97so6177420otg.13
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 09:49:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-6-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-6-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 17:49:35 +0000
Message-ID: <CAFEAcA_4ANVq-Rd63R7BOhd2axy7_Jn-BchzAksKR6g7JbjnTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 05/14] hw/arm/smmuv3: Wired IRQ and
 GERROR helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> We introduce some helpers to handle wired IRQs and especially
> GERROR interrupt. SMMU writes GERROR register on GERROR event
> and SW acks GERROR interrupts by setting GERRORn.
>
> The Wired interrupts are edge sensitive hence the pulse usage.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v7 -> v8:
> - remove SMMU_PENDING_GERRORS macro
> - properly toggle gerror
> - properly sanitize gerrorn write
> ---
>  hw/arm/smmuv3-internal.h | 10 ++++++++
>  hw/arm/smmuv3.c          | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events      |  3 +++
>  3 files changed, 77 insertions(+)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 5be8303..40b39a1 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -152,4 +152,14 @@ static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
>      return extract64(r, offset << 3, 32);
>  }
>
> +/* Interrupts */
> +
> +#define smmuv3_eventq_irq_enabled(s)                   \
> +    (FIELD_EX32(s->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN))
> +#define smmuv3_gerror_irq_enabled(s)                  \
> +    (FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN))

These are only ever used in smmuv3.c, so you can just move them
to there (and make them inline functions, ideally).

> +
> +void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
> +void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);

I guess these are global to avoid the compiler complaining about
unused static functions at this point? If so, add a comment
saying so, and flip them back to being static functions when
their callers get added. (Or just add the callers here, if they're
not too complicated.)

> +
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index dc03c9e..8779d3f 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -30,6 +30,70 @@
>  #include "hw/arm/smmuv3.h"
>  #include "smmuv3-internal.h"
>
> +/**
> + * smmuv3_trigger_irq - pulse @irq if enabled and update
> + * GERROR register in case of GERROR interrupt
> + *
> + * @irq: irq type
> + * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
> + */
> +void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask)
> +{
> +
> +    bool pulse = false;
> +
> +    switch (irq) {
> +    case SMMU_IRQ_EVTQ:
> +        pulse = smmuv3_eventq_irq_enabled(s);
> +        break;
> +    case SMMU_IRQ_PRIQ:
> +        error_setg(&error_fatal, "PRI not supported");

This should either assert() if it would be a bug in the rest
of the smmu code, or LOG_UNIMP if the guest can trigger it.

> +        break;
> +    case SMMU_IRQ_CMD_SYNC:
> +        pulse = true;
> +        break;
> +    case SMMU_IRQ_GERROR:
> +    {
> +        uint32_t pending = s->gerror ^ s->gerrorn;
> +        uint32_t new_gerrors = ~pending & gerror_mask;
> +
> +        if (!new_gerrors) {
> +            /* only toggle non pending errors */
> +            return;
> +        }
> +        s->gerror ^= new_gerrors;
> +        trace_smmuv3_write_gerror(new_gerrors, s->gerror);
> +
> +        /* pulse the GERROR irq only if all previous gerrors were acked */

It's not entirely clear to me that this is correct; should
we generate only one pulse if the implementation raises error A,
and then later raises error B before software acknowledges A ?
There's some language in 3.18 about the SMMU implementation
being able to coalesce events and identical interrupts, but
I think that would mean that we could skip raising the first
pulse for error A if error B arrived sufficiently quickly after it.
(Not something we're going to care about for a s/w model.)

I think the right behaviour is probably that we should pulse
the interrupt if there are any new gerrors, which is to
say to drop this !pending test:

> +        pulse = smmuv3_gerror_irq_enabled(s) && !pending;
> +        break;
> +    }
> +    }
> +    if (pulse) {
> +            trace_smmuv3_trigger_irq(irq);
> +            qemu_irq_pulse(s->irq[irq]);
> +    }
> +}
> +
> +void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
> +{
> +    uint32_t pending = s->gerror ^ s->gerrorn;
> +    uint32_t toggled = s->gerrorn ^ new_gerrorn;
> +    uint32_t acked;
> +
> +    if (toggled & ~pending) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "guest toggles non pending errors = 0x%x\n",
> +                      toggled & ~pending);
> +    }
> +
> +    /* Make sure SW does not toggle irqs that are not active */
> +    acked = toggled & pending;
> +    s->gerrorn ^= acked;
> +

I don't think this behaviour is correct. From the hardware's
perspective, we should just take the value the user writes
to SMMU_GERRORN and put it in the register (and update the
status of the irq accordingly).

It is CONSTRAINED UNPREDICTABLE whether we actually raise an
interrupt if the guest toggles a field that corresponds to an
inactive error, so we should just do whatever is easiest.

> +    trace_smmuv3_write_gerrorn(acked, s->gerrorn);
> +}
> +
>  static void smmuv3_init_regs(SMMUv3State *s)
>  {
>      /**
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 64d2b9b..2ddae40 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -15,3 +15,6 @@ smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "base
>
>  #hw/arm/smmuv3.c
>  smmuv3_read_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x"
> +smmuv3_trigger_irq(int irq) "irq=%d"
> +smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new gerror=0x%x"
> +smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new gerrorn=0x%x"

Capitalizing names of registers like GERROR in trace messages would
make them match the convention in the SMMUv3 spec.

> --
> 2.5.5
>

thanks
-- PMM
