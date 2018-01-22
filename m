Received: from eggs.gnu.org ([2001:4830:134:3::10]:58201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddyd-0008Ow-2W
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddyc-0002Yg-6p
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:25:39 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eddyb-0002Y5-Ma
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:25:37 -0500
Received: by mail-ot0-x243.google.com with SMTP id t35so7753108otd.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:25:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119145756.7629-5-luc.michel@greensocs.com>
References: <20180119145756.7629-1-luc.michel@greensocs.com>
	<20180119145756.7629-5-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 15:25:16 +0000
Message-ID: <CAFEAcA--EPT4Ja-k=YiiOvUDvT_SEHxoQJat2bCg3RTj_cO-5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/intc/arm_gic: Fix group priority
 computation for group 1 IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luc.michel@greensocs.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luc MICHEL <luc.michel@git.antfield.fr>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

On 19 January 2018 at 14:57,  <luc.michel@greensocs.com> wrote:
> From: Luc MICHEL <luc.michel@git.antfield.fr>
>
> When determining the group priority of a group 1 IRQ, if C_CTRL.CBPR is
> 0, the non-secure BPR value is used. However, this value must be
> incremented by one so that it matches the secure world number of
> implemented priority bits (NS world has one less priority bit compared
> to the Secure world).
>
> Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
> ---
>  hw/intc/arm_gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 713de3084f..d0a41a89ae 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -256,7 +256,7 @@ static int gic_get_group_priority(GICState *s, int cpu, int irq)
>      if (gic_has_groups(s) &&
>          !(s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) &&
>          GIC_TEST_GROUP(irq, (1 << cpu))) {
> -        bpr = s->abpr[cpu];
> +        bpr = s->abpr[cpu] - 1;

I would suggest an "assert(bpr >= 0);" here. (We have a similar
assert for GICv3 in icv_gprio_mask() and icc_gprio_mask() in
arm_gicv3_cpuif.c.)

>      } else {
>          bpr = s->bpr[cpu];
>      }
> --
> 2.16.0

thanks
-- PMM
