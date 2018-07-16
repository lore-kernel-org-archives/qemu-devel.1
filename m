Received: from eggs.gnu.org ([2001:4830:134:3::10]:33149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBgI-0006pi-7H
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBgG-0006is-Vg
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:09:22 -0400
MIME-Version: 1.0
In-Reply-To: <1531745974-17187-18-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-18-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Jul 2018 15:08:48 -0700
Message-ID: <CAKmqyKNK9y8h+AABTt-+qjy=npi_nFbSh36pM3oNL6AaJofKkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 17/17] hw/arm/xlnx-zynqmp: Fix crash
 when introspecting the "xlnx, zynqmp" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On Mon, Jul 16, 2018 at 5:59 AM, Thomas Huth <thuth@redhat.com> wrote:
> QEMU currently crashes when e.g. doing something like this:
>
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'xlnx,zynqmp'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" \
>  |  aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
>
> Use the new object_initialize_child() and sysbus_init_child_obj()
> functions to get the refernce counting of the child objects right, so
> that they are properly cleaned up when the parent gets destroyed.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-zynqmp.c | 61 ++++++++++++++++++++++++----------------------------
>  1 file changed, 28 insertions(+), 33 deletions(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 29df35f..8de4868 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -166,64 +166,59 @@ static void xlnx_zynqmp_init(Object *obj)
>      int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
>
>      for (i = 0; i < num_apus; i++) {
> -        object_initialize(&s->apu_cpu[i], sizeof(s->apu_cpu[i]),
> -                          "cortex-a53-" TYPE_ARM_CPU);
> -        object_property_add_child(obj, "apu-cpu[*]", OBJECT(&s->apu_cpu[i]),
> -                                  &error_abort);
> +        object_initialize_child(obj, "apu-cpu[*]", &s->apu_cpu[i],
> +                                sizeof(s->apu_cpu[i]),
> +                                "cortex-a53-" TYPE_ARM_CPU, &error_abort, NULL);
>      }
>
> -    object_initialize(&s->gic, sizeof(s->gic), gic_class_name());
> -    qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
> +                          gic_class_name());
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
> -        object_initialize(&s->gem[i], sizeof(s->gem[i]), TYPE_CADENCE_GEM);
> -        qdev_set_parent_bus(DEVICE(&s->gem[i]), sysbus_get_default());
> +        sysbus_init_child_obj(obj, "gem[*]", &s->gem[i], sizeof(s->gem[i]),
> +                              TYPE_CADENCE_GEM);
>      }
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
> -        object_initialize(&s->uart[i], sizeof(s->uart[i]), TYPE_CADENCE_UART);
> -        qdev_set_parent_bus(DEVICE(&s->uart[i]), sysbus_get_default());
> +        sysbus_init_child_obj(obj, "uart[*]", &s->uart[i], sizeof(s->uart[i]),
> +                              TYPE_CADENCE_UART);
>      }
>
> -    object_initialize(&s->sata, sizeof(s->sata), TYPE_SYSBUS_AHCI);
> -    qdev_set_parent_bus(DEVICE(&s->sata), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "sata", &s->sata, sizeof(s->sata),
> +                          TYPE_SYSBUS_AHCI);
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
> -        object_initialize(&s->sdhci[i], sizeof(s->sdhci[i]),
> -                          TYPE_SYSBUS_SDHCI);
> -        qdev_set_parent_bus(DEVICE(&s->sdhci[i]),
> -                            sysbus_get_default());
> +        sysbus_init_child_obj(obj, "sdhci[*]", &s->sdhci[i],
> +                              sizeof(s->sdhci[i]), TYPE_SYSBUS_SDHCI);
>      }
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
> -        object_initialize(&s->spi[i], sizeof(s->spi[i]),
> -                          TYPE_XILINX_SPIPS);
> -        qdev_set_parent_bus(DEVICE(&s->spi[i]), sysbus_get_default());
> +        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
> +                              TYPE_XILINX_SPIPS);
>      }
>
> -    object_initialize(&s->qspi, sizeof(s->qspi), TYPE_XLNX_ZYNQMP_QSPIPS);
> -    qdev_set_parent_bus(DEVICE(&s->qspi), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "qspi", &s->qspi, sizeof(s->qspi),
> +                          TYPE_XLNX_ZYNQMP_QSPIPS);
>
> -    object_initialize(&s->dp, sizeof(s->dp), TYPE_XLNX_DP);
> -    qdev_set_parent_bus(DEVICE(&s->dp), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "xxxdp", &s->dp, sizeof(s->dp), TYPE_XLNX_DP);
>
> -    object_initialize(&s->dpdma, sizeof(s->dpdma), TYPE_XLNX_DPDMA);
> -    qdev_set_parent_bus(DEVICE(&s->dpdma), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "dp-dma", &s->dpdma, sizeof(s->dpdma),
> +                          TYPE_XLNX_DPDMA);
>
> -    object_initialize(&s->ipi, sizeof(s->ipi), TYPE_XLNX_ZYNQMP_IPI);
> -    qdev_set_parent_bus(DEVICE(&s->ipi), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "ipi", &s->ipi, sizeof(s->ipi),
> +                          TYPE_XLNX_ZYNQMP_IPI);
>
> -    object_initialize(&s->rtc, sizeof(s->rtc), TYPE_XLNX_ZYNQMP_RTC);
> -    qdev_set_parent_bus(DEVICE(&s->rtc), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
> +                          TYPE_XLNX_ZYNQMP_RTC);
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
> -        object_initialize(&s->gdma[i], sizeof(s->gdma[i]), TYPE_XLNX_ZDMA);
> -        qdev_set_parent_bus(DEVICE(&s->gdma[i]), sysbus_get_default());
> +        sysbus_init_child_obj(obj, "gdma[*]", &s->gdma[i], sizeof(s->gdma[i]),
> +                              TYPE_XLNX_ZDMA);
>      }
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
> -        object_initialize(&s->adma[i], sizeof(s->adma[i]), TYPE_XLNX_ZDMA);
> -        qdev_set_parent_bus(DEVICE(&s->adma[i]), sysbus_get_default());
> +        sysbus_init_child_obj(obj, "adma[*]", &s->adma[i], sizeof(s->adma[i]),
> +                              TYPE_XLNX_ZDMA);
>      }
>  }
>
> --
> 1.8.3.1
>
>
