Received: from eggs.gnu.org ([2001:4830:134:3::10]:57187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgioV-00035y-D7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgioS-00075x-7F
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:07:23 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgioS-00075q-1D
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 21:07:20 -0500
Received: by mail-qt0-x241.google.com with SMTP id x35so2751602qtc.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:07:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
	<20170205133727.23424-5-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e41d9201-ab05-8777-6679-75a1d284dff9@amsat.org>
Date: Wed, 22 Feb 2017 23:07:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170205133727.23424-5-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RESEND PATCH 4/9] hw/misc: QOM'ify slavio_misc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, peter.maydell@linaro.org

On 02/05/2017 10:37 AM, xiaoqiang zhao wrote:
> Drop the old SysBus init function and use instance_init
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/slavio_misc.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
> index edd5de0702..e1a706e828 100644
> --- a/hw/misc/slavio_misc.c
> +++ b/hw/misc/slavio_misc.c
> @@ -414,76 +414,73 @@ static const VMStateDescription vmstate_misc = {
>      }
>  };
>
> -static int apc_init1(SysBusDevice *dev)
> +static void apc_init(Object *obj)
>  {
> -    APCState *s = APC(dev);
> +    APCState *s = APC(obj);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>
>      sysbus_init_irq(dev, &s->cpu_halt);
>
>      /* Power management (APC) XXX: not a Slavio device */
> -    memory_region_init_io(&s->iomem, OBJECT(s), &apc_mem_ops, s,
> +    memory_region_init_io(&s->iomem, obj, &apc_mem_ops, s,
>                            "apc", MISC_SIZE);
>      sysbus_init_mmio(dev, &s->iomem);
> -    return 0;
>  }
>
> -static int slavio_misc_init1(SysBusDevice *sbd)
> +static void slavio_misc_init(Object *obj)
>  {
> -    DeviceState *dev = DEVICE(sbd);
> -    MiscState *s = SLAVIO_MISC(dev);
> +    DeviceState *dev = DEVICE(obj);
> +    MiscState *s = SLAVIO_MISC(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>
>      sysbus_init_irq(sbd, &s->irq);
>      sysbus_init_irq(sbd, &s->fdc_tc);
>
>      /* 8 bit registers */
>      /* Slavio control */
> -    memory_region_init_io(&s->cfg_iomem, OBJECT(s), &slavio_cfg_mem_ops, s,
> +    memory_region_init_io(&s->cfg_iomem, obj, &slavio_cfg_mem_ops, s,
>                            "configuration", MISC_SIZE);
>      sysbus_init_mmio(sbd, &s->cfg_iomem);
>
>      /* Diagnostics */
> -    memory_region_init_io(&s->diag_iomem, OBJECT(s), &slavio_diag_mem_ops, s,
> +    memory_region_init_io(&s->diag_iomem, obj, &slavio_diag_mem_ops, s,
>                            "diagnostic", MISC_SIZE);
>      sysbus_init_mmio(sbd, &s->diag_iomem);
>
>      /* Modem control */
> -    memory_region_init_io(&s->mdm_iomem, OBJECT(s), &slavio_mdm_mem_ops, s,
> +    memory_region_init_io(&s->mdm_iomem, obj, &slavio_mdm_mem_ops, s,
>                            "modem", MISC_SIZE);
>      sysbus_init_mmio(sbd, &s->mdm_iomem);
>
>      /* 16 bit registers */
>      /* ss600mp diag LEDs */
> -    memory_region_init_io(&s->led_iomem, OBJECT(s), &slavio_led_mem_ops, s,
> +    memory_region_init_io(&s->led_iomem, obj, &slavio_led_mem_ops, s,
>                            "leds", LED_SIZE);
>      sysbus_init_mmio(sbd, &s->led_iomem);
>
>      /* 32 bit registers */
>      /* System control */
> -    memory_region_init_io(&s->sysctrl_iomem, OBJECT(s), &slavio_sysctrl_mem_ops, s,
> +    memory_region_init_io(&s->sysctrl_iomem, obj, &slavio_sysctrl_mem_ops, s,
>                            "system-control", SYSCTRL_SIZE);
>      sysbus_init_mmio(sbd, &s->sysctrl_iomem);
>
>      /* AUX 1 (Misc System Functions) */
> -    memory_region_init_io(&s->aux1_iomem, OBJECT(s), &slavio_aux1_mem_ops, s,
> +    memory_region_init_io(&s->aux1_iomem, obj, &slavio_aux1_mem_ops, s,
>                            "misc-system-functions", MISC_SIZE);
>      sysbus_init_mmio(sbd, &s->aux1_iomem);
>
>      /* AUX 2 (Software Powerdown Control) */
> -    memory_region_init_io(&s->aux2_iomem, OBJECT(s), &slavio_aux2_mem_ops, s,
> +    memory_region_init_io(&s->aux2_iomem, obj, &slavio_aux2_mem_ops, s,
>                            "software-powerdown-control", MISC_SIZE);
>      sysbus_init_mmio(sbd, &s->aux2_iomem);
>
>      qdev_init_gpio_in(dev, slavio_set_power_fail, 1);
> -
> -    return 0;
>  }
>
>  static void slavio_misc_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = slavio_misc_init1;
>      dc->reset = slavio_misc_reset;
>      dc->vmsd = &vmstate_misc;
>  }
> @@ -492,21 +489,15 @@ static const TypeInfo slavio_misc_info = {
>      .name          = TYPE_SLAVIO_MISC,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(MiscState),
> +    .instance_init = slavio_misc_init,
>      .class_init    = slavio_misc_class_init,
>  };
>
> -static void apc_class_init(ObjectClass *klass, void *data)
> -{
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
> -
> -    k->init = apc_init1;
> -}
> -
>  static const TypeInfo apc_info = {
>      .name          = TYPE_APC,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(MiscState),
> -    .class_init    = apc_class_init,
> +    .instance_init = apc_init,
>  };
>
>  static void slavio_misc_register_types(void)
>
