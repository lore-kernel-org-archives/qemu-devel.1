Received: from eggs.gnu.org ([2001:4830:134:3::10]:52266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTbdq-0007wN-Mj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTbdq-0005rG-2A
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 16:50:10 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1483977924-14522-2-git-send-email-peter.maydell@linaro.org>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
	<1483977924-14522-2-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 17 Jan 2017 13:49:35 -0800
Message-ID: <CAKmqyKMBpvETvPGEG+amBBaubA7GDban8fc+iDMexVNdm6BC5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 01/18] hw/intc/arm_gicv3: Add external
 IRQ lines for VIRQ and VFIQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrew Jones <drjones@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Christoffer Dall <christoffer.dall@linaro.org>, Patch Tracking <patches@linaro.org>

On Mon, Jan 9, 2017 at 8:05 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> Augment the GICv3's QOM device interface by adding two
> new sets of sysbus IRQ lines, to signal VIRQ and VFIQ to
> each CPU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  include/hw/intc/arm_gicv3_common.h | 2 ++
>  hw/intc/arm_gicv3_common.c         | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 341a311..beb2c77 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -145,6 +145,8 @@ struct GICv3CPUState {
>      CPUState *cpu;
>      qemu_irq parent_irq;
>      qemu_irq parent_fiq;
> +    qemu_irq parent_virq;
> +    qemu_irq parent_vfiq;
>
>      /* Redistributor */
>      uint32_t level;                  /* Current IRQ level */
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 0aa9b9c..0ee67a4 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -126,6 +126,12 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
>      for (i = 0; i < s->num_cpu; i++) {
>          sysbus_init_irq(sbd, &s->cpu[i].parent_fiq);
>      }
> +    for (i = 0; i < s->num_cpu; i++) {
> +        sysbus_init_irq(sbd, &s->cpu[i].parent_virq);
> +    }
> +    for (i = 0; i < s->num_cpu; i++) {
> +        sysbus_init_irq(sbd, &s->cpu[i].parent_vfiq);
> +    }
>
>      memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
>                            "gicv3_dist", 0x10000);
> --
> 2.7.4
>
>
