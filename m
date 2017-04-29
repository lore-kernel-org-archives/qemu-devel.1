Received: from eggs.gnu.org ([2001:4830:134:3::10]:33058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4asN-0004Bk-3Z
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4asK-00085j-0x
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:30:03 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d4asJ-00085e-SR
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 18:29:59 -0400
Received: by mail-qk0-x242.google.com with SMTP id h123so184194qke.2
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 15:29:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
	<20170429104937.31341-10-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <77b2e8b3-83ab-5a14-484e-e4c6dfac2b63@amsat.org>
Date: Sat, 29 Apr 2017 19:29:55 -0300
MIME-Version: 1.0
In-Reply-To: <20170429104937.31341-10-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 9/9] hw/sparc64: QOM'ify sun4u.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au

On 04/29/2017 07:49 AM, xiaoqiang zhao wrote:
> Drop the old SysBusDeviceClass::init and use instance_init
> or DeviceClass::realize instead
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sparc64/sun4u.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index d347b6616d..18b8f8bcba 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -329,16 +329,16 @@ static void prom_init(hwaddr addr, const char *bios_name)
>      }
>  }
>
> -static int prom_init1(SysBusDevice *dev)
> +static void prom_init1(Object *obj)
>  {
> -    PROMState *s = OPENPROM(dev);
> +    PROMState *s = OPENPROM(obj);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>
> -    memory_region_init_ram(&s->prom, OBJECT(s), "sun4u.prom", PROM_SIZE_MAX,
> +    memory_region_init_ram(&s->prom, obj, "sun4u.prom", PROM_SIZE_MAX,
>                             &error_fatal);
>      vmstate_register_ram_global(&s->prom);
>      memory_region_set_readonly(&s->prom, true);
>      sysbus_init_mmio(dev, &s->prom);
> -    return 0;
>  }
>
>  static Property prom_properties[] = {
> @@ -348,9 +348,7 @@ static Property prom_properties[] = {
>  static void prom_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = prom_init1;
>      dc->props = prom_properties;
>  }
>
> @@ -359,6 +357,7 @@ static const TypeInfo prom_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(PROMState),
>      .class_init    = prom_class_init,
> +    .instance_init = prom_init1,
>  };
>
>
> @@ -373,15 +372,15 @@ typedef struct RamDevice {
>  } RamDevice;
>
>  /* System RAM */
> -static int ram_init1(SysBusDevice *dev)
> +static void ram_realize(DeviceState *dev, Error **errp)
>  {
>      RamDevice *d = SUN4U_RAM(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>
>      memory_region_init_ram(&d->ram, OBJECT(d), "sun4u.ram", d->size,
>                             &error_fatal);
>      vmstate_register_ram_global(&d->ram);
> -    sysbus_init_mmio(dev, &d->ram);
> -    return 0;
> +    sysbus_init_mmio(sbd, &d->ram);
>  }
>
>  static void ram_init(hwaddr addr, ram_addr_t RAM_size)
> @@ -409,9 +408,8 @@ static Property ram_properties[] = {
>  static void ram_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>
> -    k->init = ram_init1;
> +    dc->realize = ram_realize;
>      dc->props = ram_properties;
>  }
>
>
