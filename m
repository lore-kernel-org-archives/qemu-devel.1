Received: from eggs.gnu.org ([2001:4830:134:3::10]:46794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9dya-0007h2-JL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1g9dyZ-0003H2-Gi
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 18:26:08 -0400
Date: Tue, 9 Oct 2018 00:25:41 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181008222541.GJ4229@toto>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-12-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA8xARoCTPMWs_XA06gRgzZL+RGS8XwwKNmS45b9C7mmzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8xARoCTPMWs_XA06gRgzZL+RGS8XwwKNmS45b9C7mmzA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 11/12] hw/arm: versal: Add a model of
 Xilinx Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On Mon, Oct 08, 2018 at 02:19:09PM +0100, Peter Maydell wrote:
> On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Add a model of Xilinx Versal SoC.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  default-configs/aarch64-softmmu.mak |   1 +
> >  hw/arm/Makefile.objs                |   1 +
> >  hw/arm/xlnx-versal.c                | 339 ++++++++++++++++++++++++++++++++++++
> >  include/hw/arm/xlnx-versal.h        | 122 +++++++++++++
> >  4 files changed, 463 insertions(+)
> >  create mode 100644 hw/arm/xlnx-versal.c
> >  create mode 100644 include/hw/arm/xlnx-versal.h
> >
> 
> 
> > +#define XLNX_VERSAL_ACPU_TYPE "cortex-a72" "-" TYPE_ARM_CPU
> 
> ARM_CPU_TYPE_NAME("cortex-a72") is preferable to hand-assembling
> the type name like this.

Fixed for v2.


> 
> > +#define GEM_REVISION        0x40070106
> > +
> 
> > +    for (i = 0; i < nr_apu_cpus; i++) {
> > +        DeviceState *cpudev = DEVICE(s->fpd.apu.cpu[i]);
> > +        int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
> > +        qemu_irq maint_irq;
> > +        int ti;
> > +        /* Mapping from the output timer irq lines from the CPU to the
> > +         * GIC PPI inputs we use for the virt board.
> > +         */
> 
> This isn't the virt board :-) -- cut-n-pasted comment ?

Fixed for v2.


> 
> > +        const int timer_irq[] = {
> > +            [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
> > +            [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
> > +            [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
> > +            [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
> > +        };
> > +
> > +        for (ti = 0; ti < ARRAY_SIZE(timer_irq); ti++) {
> > +            qdev_connect_gpio_out(cpudev, ti,
> > +                                  qdev_get_gpio_in(gicdev,
> > +                                                   ppibase + timer_irq[ti]));
> > +        }
> > +        maint_irq = qdev_get_gpio_in(gicdev,
> > +                                        ppibase + VERSAL_GIC_MAINT_IRQ);
> > +        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
> > +                                    0, maint_irq);
> > +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
> > +        sysbus_connect_irq(gicbusdev, i + nr_apu_cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
> > +        sysbus_connect_irq(gicbusdev, i + 2 * nr_apu_cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
> > +        sysbus_connect_irq(gicbusdev, i + 3 * nr_apu_cpus,
> > +                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
> > +    }
> > +
> > +    for (i = 0; i < XLNX_VERSAL_NR_IRQS; i++) {
> > +        pic[i] = qdev_get_gpio_in(gicdev, i);
> > +    }
> 
> > +/* This takes the board allocated linear DDR memory and creates aliases
> > + * for each split DDR range/apperture on the Versal address map.
> 
> "aperture"

Fixed


> 
> 
> 
> > +static void versal_realize(DeviceState *dev, Error **errp)
> > +{
> > +    Versal *s = XLNX_VERSAL(dev);
> > +    qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> > +
> > +    versal_create_apu_cpus(s, errp);
> > +    versal_create_apu_gic(s, pic, errp);
> > +    versal_create_uarts(s, pic);
> > +    versal_create_gems(s, pic);
> > +    versal_map_ddr(s);
> > +    versal_unimp(s);
> > +
> > +    /* Create the OCM.  */
> > +    memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
> > +                           MM_OCM_SIZE, &error_fatal);
> 
> What's an OCM? Is it really memory, or is this a stub for something?


I've changed the comment to spell out that it's an On Chip Memory.


> 
> > +
> > +    memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
> > +    memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
> > +}
> > +
> > +static void versal_init(Object *obj)
> > +{
> > +    Versal *s = XLNX_VERSAL(obj);
> > +
> > +    memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
> > +    memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
> > +}
> > +
> > +static const VMStateDescription versal_vmstate = {
> > +    .name = "xlnx-ve",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (VMStateField[]) {
> > +        /* FIXME.  */
> 
> Stray FIXME comment -- I think the answer may be "the
> SoC object has no state of its own so needs neither a
> vmsd nor a reset method" ? (If so and if you drop them,
> do put a comment in the class init about why they're not
> provided. Some day we may have a mechanism for a device
> to explicitly say "I need no vmstate" so we can assert if
> none is provided.)

Thanks, I'll do that.


> 
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static Property versal_properties[] = {
> > +    DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
> > +                     MemoryRegion *),
> > +    DEFINE_PROP_UINT32("psci-conduit", Versal, cfg.psci_conduit, 0),
> > +    DEFINE_PROP_END_OF_LIST()
> > +};
> > +
> > +static void versal_reset(DeviceState *dev)
> > +{
> > +}
> > +
> > +static void versal_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->realize = versal_realize;
> > +    dc->vmsd = &versal_vmstate;
> > +    dc->props = versal_properties;
> > +    dc->reset = versal_reset;
> > +}
> 
> Looks good otherwise.


Thanks,
Edgar
