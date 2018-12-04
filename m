Received: from eggs.gnu.org ([2001:4830:134:3::10]:58680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gU7wI-0002TX-Rp
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gU7wH-00041Q-VX
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:28:26 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:38926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gU7wH-00040u-QG
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 05:28:25 -0500
Received: by mail-oi1-x235.google.com with SMTP id i6so13782550oia.6
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 02:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20181102171638.24069-1-peter.maydell@linaro.org>
	<20181102171638.24069-11-peter.maydell@linaro.org>
In-Reply-To: <20181102171638.24069-11-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 10:28:13 +0000
Message-ID: <CAFEAcA_Fp8r7HPY6hORagGo=1ypAn-U_wqq7e3HkouUHJAQW5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 10/10] hw/arm: versal: Add a virtual Xilinx
 Versal board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Fri, 2 Nov 2018 at 17:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add a virtual Xilinx Versal board.
>
> This board is based on the Xilinx Versal SoC. The exact
> details of what peripherals are attached to this board
> will remain in control of QEMU. QEMU will generate an
> FDT on the fly for Linux and other software to auto-discover
> peripherals.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Message-id: 20181102131913.1535-3-edgar.iglesias@xilinx.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi Edgar -- I've been running the clang-7 leak sanitizer
on "make check", and it spotted a couple of minor memory
leaks in the versal board code:

> +static void fdt_add_gic_nodes(VersalVirt *s)
> +{
> +    char *nodename;
> +
> +    nodename = g_strdup_printf("/gic@%x", MM_GIC_APU_DIST_MAIN);
> +    qemu_fdt_add_subnode(s->fdt, nodename);
> +    qemu_fdt_setprop_cell(s->fdt, nodename, "phandle", s->phandle.gic);
> +    qemu_fdt_setprop_cells(s->fdt, nodename, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop(s->fdt, nodename, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
> +                                 2, MM_GIC_APU_DIST_MAIN,
> +                                 2, MM_GIC_APU_DIST_MAIN_SIZE,
> +                                 2, MM_GIC_APU_REDIST_0,
> +                                 2, MM_GIC_APU_REDIST_0_SIZE);
> +    qemu_fdt_setprop_cell(s->fdt, nodename, "#interrupt-cells", 3);
> +    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "arm,gic-v3");

nodename is allocated but never freed here.

> +}


> +#define NUM_VIRTIO_TRANSPORT 32
> +static void create_virtio_regions(VersalVirt *s)
> +{
> +    int virtio_mmio_size = 0x200;
> +    int i;
> +
> +    for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
> +        char *name = g_strdup_printf("virtio%d", i);;
> +        hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
> +        int irq = VERSAL_RSVD_HIGH_IRQ_FIRST + i;
> +        MemoryRegion *mr;
> +        DeviceState *dev;
> +        qemu_irq pic_irq;
> +
> +        pic_irq = qdev_get_gpio_in(DEVICE(&s->soc.fpd.apu.gic), irq);
> +        dev = qdev_create(NULL, "virtio-mmio");
> +        object_property_add_child(OBJECT(&s->soc), name, OBJECT(dev),
> +                                  &error_fatal);
> +        qdev_init_nofail(dev);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +        memory_region_add_subregion(&s->soc.mr_ps, base, mr);
> +        sysbus_create_simple("virtio-mmio", base, pic_irq);

The body of this loop allocates name but forgets to free it.

> +    }

thanks
-- PMM
