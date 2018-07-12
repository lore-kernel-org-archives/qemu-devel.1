Received: from eggs.gnu.org ([2001:4830:134:3::10]:40769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fday5-000505-7A
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdaxz-0004mw-HR
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:45:09 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdaxz-0004mM-3x
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:45:03 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so55509362oie.5
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 05:45:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-10-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-10-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 13:44:41 +0100
Message-ID: <CAFEAcA9u0q9YXEGd+NqSHVBtDO921jCyU_Qs8FQVqeHFwQNbAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 09/20] intc/arm_gic: Add virtualization
 enabled IRQ helper functions
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

My review remarks on patch 7 will affect this patch a bit but
generally this looks good.

> +static inline void gic_clear_active(GICState *s, int irq, int cpu)
> +{
> +    if (gic_is_vcpu(cpu)) {
> +        uint32_t *entry = gic_get_lr_entry_nofail(s, irq, cpu);
> +        GICH_LR_CLEAR_ACTIVE(*entry);
> +
> +        if (GICH_LR_HW(*entry)) {
> +            /* Hardware interrupt. We must forward the deactivation request to
> +             * the distributor.
> +             */
> +            int phys_irq = GICH_LR_PHYS_ID(*entry);
> +            int rcpu = gic_get_vcpu_real_id(cpu);

You should check here that phys_irq is not one of the reserved
values >= GIC_MAXIRQ (ie 1020-1023). Otherwise the GIC_DIST_CLEAR_ACTIVE()
below will index off the end of the irq_state[] array.

(The current code for the physical GIC doesn't make this check, which
is a bit lax of it, but we should treat that as a separate bug rather
than trying to fix it here. I'll send a patch that fixes that for 3.0.)

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

>  #endif /* QEMU_ARM_GIC_INTERNAL_H */

thanks
-- PMM
