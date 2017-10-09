Received: from eggs.gnu.org ([2001:4830:134:3::10]:44875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bRd-0006PG-LE
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bRU-0008Oe-2N
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:02:21 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:51662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1bRT-0008O5-Nv
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:02:12 -0400
Received: by mail-wm0-x22a.google.com with SMTP id f4so25315880wme.0
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:02:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-7-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-7-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:01:49 +0100
Message-ID: <CAFEAcA_kWEeNTNrAucGuMKfN0iMg9hZcM8KnS-cst+ehGVtqsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 06/20] hw/arm/smmuv3: Wired IRQ and
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
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> We introduce some helpers to handle wired IRQs and especially
> GERROR interrupt. SMMU writes GERROR register on GERROR event
> and SW acks GERROR interrupts by setting GERRORn.
>
> The Wired interrupts are edge sensitive.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> Is CMD_SYNC interrupt enabled somewhere?
> ---
>  hw/arm/smmuv3-internal.h | 20 ++++++++++++++++++
>  hw/arm/smmuv3.c          | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events      |  2 ++
>  3 files changed, 77 insertions(+)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 488acc8..2b44ee2 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -198,4 +198,24 @@ static inline int smmu_enabled(SMMUV3State *s)
>      return smmu_read32_reg(s, SMMU_REG_CR0) & SMMU_CR0_SMMU_ENABLE;
>  }
>
> +/*****************************
> + * Interrupts
> + *****************************/
> +
> +#define smmu_evt_irq_enabled(s)                   \
> +    (smmu_read64_reg(s, SMMU_REG_IRQ_CTRL) & SMMU_IRQ_CTRL_EVENT_EN)
> +#define smmu_gerror_irq_enabled(s)                  \
> +    (smmu_read64_reg(s, SMMU_REG_IRQ_CTRL) & SMMU_IRQ_CTRL_GERROR_EN)
> +#define smmu_pri_irq_enabled(s)                 \
> +    (smmu_read64_reg(s, SMMU_REG_IRQ_CTRL) & SMMU_IRQ_CTRL_PRI_EN)
> +
> +#define SMMU_PENDING_GERRORS(s) \
> +    (smmu_read32_reg(s, SMMU_REG_GERROR) ^ \
> +     smmu_read32_reg(s, SMMU_REG_GERRORN))

Hiding this XOR inside a macro is very confusing.

> +
> +#define SMMU_CMDQ_ERR(s) (SMMU_PENDING_GERRORS(s) & SMMU_GERROR_CMDQ)
> +
> +void smmuv3_irq_trigger(SMMUV3State *s, SMMUIrq irq, uint32_t gerror_val);
> +void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn);
> +
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0a7cd1c..468134f 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -29,6 +29,61 @@
>  #include "hw/arm/smmuv3.h"
>  #include "smmuv3-internal.h"
>
> +/**
> + * smmuv3_irq_trigger - pulse @irq if enabled and update
> + * GERROR register in case of GERROR interrupt
> + *
> + * @irq: irq type
> + * @gerror: gerror new value, only relevant if @irq is GERROR
> + */
> +void smmuv3_irq_trigger(SMMUV3State *s, SMMUIrq irq, uint32_t gerror_val)
> +{
> +    uint32_t pending_gerrors = SMMU_PENDING_GERRORS(s);
> +    bool pulse = false;
> +
> +    switch (irq) {
> +    case SMMU_IRQ_EVTQ:
> +        pulse = smmu_evt_irq_enabled(s);
> +        break;
> +    case SMMU_IRQ_PRIQ:
> +        pulse = smmu_pri_irq_enabled(s);
> +        break;
> +    case SMMU_IRQ_CMD_SYNC:
> +        pulse = true;
> +        break;
> +    case SMMU_IRQ_GERROR:
> +    {
> +        /* don't toggle an already pending error */
> +        bool new_gerrors = ~pending_gerrors & gerror_val;
> +        uint32_t gerror = smmu_read32_reg(s, SMMU_REG_GERROR);
> +
> +        smmu_write32_reg(s, SMMU_REG_GERROR, gerror | new_gerrors);

The SMMU toggles GERROR bits to indicate that they have been
set, it doesn't just set them to 1.

> +
> +        /* pulse the GERROR irq only if all fields were acked */
> +        pulse = smmu_gerror_irq_enabled(s) && !pending_gerrors;
> +        break;
> +    }
> +    }
> +    if (pulse) {
> +            trace_smmuv3_irq_trigger(irq,
> +                                     smmu_read32_reg(s, SMMU_REG_GERROR),
> +                                     SMMU_PENDING_GERRORS(s));
> +            qemu_irq_pulse(s->irq[irq]);

qemu_irq_pulse() is very rarely the right thing for an interrupt
line, but it looks like it's right here (per spec 3.18.2).

> +    }
> +}
> +
> +void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn)
> +{
> +    uint32_t pending_gerrors = SMMU_PENDING_GERRORS(s);
> +    uint32_t sanitized;
> +
> +    /* Make sure SW does not toggle irqs that are not active */

If it does, this is CONSTRAINED UNPREDICTABLE. That is worth
remarking in either a comment or a LOG_GUEST_ERROR warning.

> +    sanitized = gerrorn & pending_gerrors;

This isn't right -- if you want to sanitize the result
being written then you need to make it only change bits
that are in pending_errors, but this expression allows
the guest to write a 0 to a field that is for a non-pending
error. (Or you could just not sanitize at all, that's allowed
by the CONSTRAINED UNPREDICTABLE.)

> +
> +    smmu_write32_reg(s, SMMU_REG_GERRORN, sanitized);
> +    trace_smmuv3_write_gerrorn(gerrorn, sanitized, SMMU_PENDING_GERRORS(s));
> +}
> +
>  static void smmuv3_init_regs(SMMUV3State *s)
>  {
>      uint32_t data =
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 8affbf7..c1ce8eb 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -17,3 +17,5 @@ smmu_set_translated_address(hwaddr iova, hwaddr pa) "iova = 0x%"PRIx64" -> pa =
>
>  #hw/arm/smmuv3.c
>  smmuv3_read_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x"
> +smmuv3_irq_trigger(int irq, uint32_t gerror, uint32_t pending) "irq=%d gerror=0x%x pending gerrors=0x%x"
> +smmuv3_write_gerrorn(uint32_t gerrorn, uint32_t sanitized, uint32_t pending) "gerrorn=0x%x sanitized=0x%x pending=0x%x"
> --
> 2.5.5

thanks
-- PMM
