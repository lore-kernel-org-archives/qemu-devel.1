Received: from eggs.gnu.org ([2001:4830:134:3::10]:38643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdao5-0002IU-I3
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdao4-0006wn-Jk
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:34:49 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdao4-0006wM-Em
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:34:48 -0400
Received: by mail-oi0-x241.google.com with SMTP id k81-v6so55424369oib.4
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 05:34:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-13-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-13-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 13:34:27 +0100
Message-ID: <CAFEAcA9KLckO343yv86oQGN3kvEj918oLhLuxakqXNtR=C0CVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 12/20] intc/arm_gic: Implement
 virtualization extensions in gic_complete_irq
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
> Implement virtualization extensions in the gic_complete_irq() function.
> When a guest tries to end an IRQ that does not exist in the LRs, the
> EOICount field of the virtual interface HCR register is incremented by
> one, and the request is ignored.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index a7577ac073..434dc9c7b2 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -605,6 +605,15 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>      int group;
>
>      DPRINTF("EOI %d\n", irq);
> +    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
> +        /* This vIRQ does not have a valid LR entry. Increment EOICount and
> +         * ignore the write.
> +         */
> +        int rcpu = gic_get_vcpu_real_id(cpu);
> +        s->h_hcr[rcpu] += 1 << R_GICH_HCR_EOICount_SHIFT;
> +        return;
> +    }
> +

This check and handling of EOICount must also be done in
gic_deactivate_irq() -- see my comments on patch 7.

thanks
-- PMM
