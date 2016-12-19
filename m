Received: from eggs.gnu.org ([2001:4830:134:3::10]:42473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cJ5tM-0000Nc-Ji
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cJ5tL-0005uZ-Pk
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 16:54:44 -0500
MIME-Version: 1.0
In-Reply-To: <1481625384-15077-10-git-send-email-peter.maydell@linaro.org>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-10-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Dec 2016 13:54:10 -0800
Message-ID: <CAKmqyKPcO3SS6ZF7+3_a-oPeXvg1N3-zhhwj1krvew7NmpcgUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 09/23] hw/intc/arm_gic: Add external IRQ
 lines for VIRQ and VFIQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Patch Tracking <patches@linaro.org>

On Tue, Dec 13, 2016 at 2:36 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Augment the GIC's QOM device interface by adding two
> new sets of sysbus IRQ lines, to signal VIRQ and VFIQ to
> each CPU.
>
> We never use these, but it's helpful to keep the v2-and-earlier
> GIC's external interface in line with that of the GICv3 to
> avoid board code having to add extra code conditional on which
> version of the GIC is in use.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  include/hw/intc/arm_gic_common.h | 2 ++
>  hw/intc/arm_gic_common.c         | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
> index f4c349a..af3ca18 100644
> --- a/include/hw/intc/arm_gic_common.h
> +++ b/include/hw/intc/arm_gic_common.h
> @@ -55,6 +55,8 @@ typedef struct GICState {
>
>      qemu_irq parent_irq[GIC_NCPU];
>      qemu_irq parent_fiq[GIC_NCPU];
> +    qemu_irq parent_virq[GIC_NCPU];
> +    qemu_irq parent_vfiq[GIC_NCPU];
>      /* GICD_CTLR; for a GIC with the security extensions the NS banked version
>       * of this register is just an alias of bit 1 of the S banked version.
>       */
> diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
> index 0a1f56a..4a8df44 100644
> --- a/hw/intc/arm_gic_common.c
> +++ b/hw/intc/arm_gic_common.c
> @@ -110,6 +110,12 @@ void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
>      for (i = 0; i < s->num_cpu; i++) {
>          sysbus_init_irq(sbd, &s->parent_fiq[i]);
>      }
> +    for (i = 0; i < s->num_cpu; i++) {
> +        sysbus_init_irq(sbd, &s->parent_virq[i]);
> +    }
> +    for (i = 0; i < s->num_cpu; i++) {
> +        sysbus_init_irq(sbd, &s->parent_vfiq[i]);
> +    }
>
>      /* Distributor */
>      memory_region_init_io(&s->iomem, OBJECT(s), ops, s, "gic_dist", 0x1000);
> --
> 2.7.4
>
>
