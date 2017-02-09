Received: from eggs.gnu.org ([2001:4830:134:3::10]:37243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbwtN-0000eo-JG
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbwtJ-0007Xn-Fc
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:08:41 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbwtJ-0007Xj-BF
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:08:37 -0500
Received: by mail-qt0-x244.google.com with SMTP id w20so2366275qtb.1
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 14:08:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170205133727.23424-1-zxq_yx_007@163.com>
	<20170205133727.23424-6-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e2ac801-68ec-ca0a-5f15-92767e4b12cf@amsat.org>
Date: Thu, 9 Feb 2017 19:08:33 -0300
MIME-Version: 1.0
In-Reply-To: <20170205133727.23424-6-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RESEND PATCH 5/9] hw/timer: QOM'ify m48txx_sysbus
 (pass 1)
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
> * split the old SysBus init function into an instance_init
>   and a Device realize function
> * use DeviceClass::realize instead of SysBusDeviceClass::init
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/timer/m48t59.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
> index e46ca88391..39e425e950 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/timer/m48t59.c
> @@ -765,30 +765,31 @@ static void m48t59_isa_realize(DeviceState *dev, Error **errp)
>      }
>  }
>
> -static int m48t59_init1(SysBusDevice *dev)
> +static void m48t59_init1(Object *obj)
>  {
> -    M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_GET_CLASS(dev);
> -    M48txxSysBusState *d = M48TXX_SYS_BUS(dev);
> -    Object *o = OBJECT(dev);
> +    M48txxSysBusDeviceClass *u = M48TXX_SYS_BUS_GET_CLASS(obj);
> +    M48txxSysBusState *d = M48TXX_SYS_BUS(obj);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>      M48t59State *s = &d->state;
> -    Error *err = NULL;
>
>      s->model = u->info.model;
>      s->size = u->info.size;
>      sysbus_init_irq(dev, &s->IRQ);
>
> -    memory_region_init_io(&s->iomem, o, &nvram_ops, s, "m48t59.nvram",
> +    memory_region_init_io(&s->iomem, obj, &nvram_ops, s, "m48t59.nvram",
>                            s->size);
> -    memory_region_init_io(&d->io, o, &m48t59_io_ops, s, "m48t59", 4);
> -    sysbus_init_mmio(dev, &s->iomem);
> -    sysbus_init_mmio(dev, &d->io);
> -    m48t59_realize_common(s, &err);
> -    if (err != NULL) {
> -        error_free(err);
> -        return -1;
> -    }
> +    memory_region_init_io(&d->io, obj, &m48t59_io_ops, s, "m48t59", 4);
> +}
>
> -    return 0;
> +static void m48t59_realize(DeviceState *dev, Error **errp)
> +{
> +    M48txxSysBusState *d = M48TXX_SYS_BUS(dev);
> +    M48t59State *s = &d->state;
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_mmio(sbd, &d->io);
> +    m48t59_realize_common(s, errp);
>  }
>
>  static uint32_t m48txx_isa_read(Nvram *obj, uint32_t addr)
> @@ -862,10 +863,9 @@ static Property m48t59_sysbus_properties[] = {
>  static void m48txx_sysbus_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>      NvramClass *nc = NVRAM_CLASS(klass);
>
> -    k->init = m48t59_init1;
> +    dc->realize = m48t59_realize;
>      dc->reset = m48t59_reset_sysbus;
>      dc->props = m48t59_sysbus_properties;
>      nc->read = m48txx_sysbus_read;
> @@ -891,6 +891,7 @@ static const TypeInfo m48txx_sysbus_type_info = {
>      .name = TYPE_M48TXX_SYS_BUS,
>      .parent = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(M48txxSysBusState),
> +    .instance_init = m48t59_init1,
>      .abstract = true,
>      .class_init = m48txx_sysbus_class_init,
>      .interfaces = (InterfaceInfo[]) {
>
