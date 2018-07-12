Received: from eggs.gnu.org ([2001:4830:134:3::10]:38723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdc5q-0005HA-7Q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdc5p-0007Vv-2n
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:57:14 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdc5o-0007V0-LQ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:57:13 -0400
Received: by mail-oi0-x243.google.com with SMTP id q11-v6so30350399oic.12
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 06:57:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-17-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-17-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 14:56:51 +0100
Message-ID: <CAFEAcA_fFsqwr316OLcZVwBs72ESLob1AKDZN24JfFo78zQ=AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 16/20] intc/arm_gic: Implement
 gic_update_virt() function
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
> Add the gic_update_virt() function to update the vCPU interface states
> and raise vIRQ and vFIQ as needed. This commit renames gic_update() to
> gic_update_internal() and generalizes it to handle both cases, with a
> `virt' parameter to track whether we are updating the CPU or vCPU
> interfaces.
>
> The main difference between CPU and vCPU is the way we select the best
> IRQ. This part has been split into the gic_get_best_(v)irq functions.
> For the virt case, the LRs are iterated to find the best candidate.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c | 170 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 130 insertions(+), 40 deletions(-)


> +
> +/* Return true if IRQ signaling is enabled:
> + *   - !virt -> from the distributor to the CPU interfaces,
> + *              for the given group mask,
> + *   -  virt -> from the given virtual interface to the CPU virtual interface.
> + */
> +static inline bool gic_irq_signaling_enabled(GICState *s, int cpu, bool virt,
> +                                    int group_mask)
> +{
> +    return (virt && (s->h_hcr[cpu] & R_GICH_HCR_EN_MASK))
> +        || (!virt && (s->ctlr & group_mask));
> +}

For a real CPU interface we test the GICC_CTLR EnableGrp0/1 bits here.
For a virt CPU interface shouldn't we test the GICV_CTLR bits ?

(This doesn't actually cause any wrong behaviour because this check
is just an efficiency check: "if interrupts are entirely disabled
then we don't need to do the expensive look-at-all-irqs checks".)


Otherwise looks OK.

thanks
-- PMM
