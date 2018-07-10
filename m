Received: from eggs.gnu.org ([2001:4830:134:3::10]:41172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcw9c-0006U2-CQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcw9b-0000jj-8t
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:10:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcw9b-0000jM-2Y
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:10:19 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so44023079oib.9
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 10:10:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-2-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-2-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 18:09:56 +0100
Message-ID: <CAFEAcA_MRBtqwKzk1KMLpDLO7vRsrenYjzuC4_EX=N0YvZXF=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 01/20] intc/arm_gic: Implement write to
 GICD_ISACTIVERn and GICD_ICACTIVERn registers
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
> Implement write access to GICD_ISACTIVERn and GICD_ICACTIVERn registers
> in the GICv2. Those registers allow to set or clear the active state of
> an IRQ in the distributor.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index ea0323f969..5755a4fb2c 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -982,9 +982,46 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
>                  GIC_CLEAR_PENDING(irq + i, ALL_CPU_MASK);
>              }
>          }
> +    } else if (offset < 0x380) {
> +        /* Interrupt Set Active.  */

These are read-only for the GICv1 and 11MPCore, so we need
to guard this code with a check on s->revision == 2:
           if (s->revision != 2) {
               goto bad_reg;
           }

> +        irq = (offset - 0x300) * 8 + GIC_BASE_IRQ;
> +        if (irq >= s->num_irq) {
> +            goto bad_reg;
> +        }
> +
> +        /* This register is banked per-cpu for PPIs */
> +        int cm = irq < GIC_INTERNAL ? (1 << cpu) : ALL_CPU_MASK;
> +
> +        for (i = 0; i < 8; i++) {
> +            if (s->security_extn && !attrs.secure &&
> +                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
> +                continue; /* Ignore Non-secure access of Group0 IRQ */
> +            }
> +
> +            if (value & (1 << i)) {
> +                GIC_DIST_SET_ACTIVE(irq + i, cm);

You don't introduce this macro until patch 2, so this patch
has to go after that, so that we still compile at all points
in the patch sequence.

> +            }
> +        }
>      } else if (offset < 0x400) {
> -        /* Interrupt Active.  */
> -        goto bad_reg;
> +        /* Interrupt Clear Active.  */
> +        irq = (offset - 0x380) * 8 + GIC_BASE_IRQ;
> +        if (irq >= s->num_irq) {
> +            goto bad_reg;
> +        }

These registers only exist for GICv2, so again a check
on s->revision is required.

You also need to implement reading of GICD_ICACTIVERn for
GICv2 -- the code in gic_dist_readb() only implements reads of
GICD_ISACTIVERn (which is all that GICv1 needed).

> +
> +        /* This register is banked per-cpu for PPIs */
> +        int cm = irq < GIC_INTERNAL ? (1 << cpu) : ALL_CPU_MASK;
> +
> +        for (i = 0; i < 8; i++) {
> +            if (s->security_extn && !attrs.secure &&
> +                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
> +                continue; /* Ignore Non-secure access of Group0 IRQ */
> +            }
> +
> +            if (value & (1 << i)) {
> +                GIC_DIST_CLEAR_ACTIVE(irq + i, cm);
> +            }
> +        }
>      } else if (offset < 0x800) {
>          /* Interrupt Priority.  */
>          irq = (offset - 0x400) + GIC_BASE_IRQ;
> --
> 2.17.1

Looks good otherwise.

thanks
-- PMM
