Received: from eggs.gnu.org ([2001:4830:134:3::10]:56287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdxo-00049I-Ol
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdxl-0003Ea-AA
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:38:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFdxl-00036r-2A
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:38:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so5171162wrw.12
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 04:38:04 -0700 (PDT)
References: <1540495397-88089-1-git-send-email-peng.hao2@zte.com.cn>
	<1540495397-88089-4-git-send-email-peng.hao2@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <467e77d8-48af-5361-3e31-b9eac79d968d@redhat.com>
Date: Thu, 25 Oct 2018 13:38:01 +0200
MIME-Version: 1.0
In-Reply-To: <1540495397-88089-4-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 3/5] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 25/10/18 21:23, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   hw/misc/pvpanic.c         | 74 ++++++++++++++++++++++++++++++++++++++---------
>   include/hw/misc/pvpanic.h |  2 ++
>   2 files changed, 62 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index dd3aef2..b575e01 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -2,10 +2,12 @@
>    * QEMU simulated pvpanic device.
>    *
>    * Copyright Fujitsu, Corp. 2013
> + * Copyright (c) 2018 ZTE Ltd.
>    *
>    * Authors:
>    *     Wen Congyang <wency@cn.fujitsu.com>
>    *     Hu Tao <hutao@cn.fujitsu.com>
> + *     Peng Hao <peng.hao2@zte.com.cn>
>    *
>    * This work is licensed under the terms of the GNU GPL, version 2 or later.
>    * See the COPYING file in the top-level directory.
> @@ -45,30 +47,48 @@ static void handle_event(int event)
>   
>   #include "hw/isa/isa.h"
>   
> -typedef struct PVPanicState {
> +typedef struct PVPanicCommonState {
> +    MemoryRegion mr;
> +} PVPanicCommonState;

Maybe we can drop this type now.

> +
> +typedef struct PVPanicISAState {
>       /* private */
>       ISADevice isadev;

Here goes this comment:

         /* public */

> +    uint16_t ioport;
> +    /* public */
> +    PVPanicCommonState common;
> +} PVPanicISAState;
> +
> +typedef struct PVPanicMMIOState {
> +    /* private */
> +    SysBusDevice busdev;
>   
>       /* public */
> -    MemoryRegion mr;
> -    uint16_t ioport;
> -} PVPanicState;
> +    PVPanicCommonState common;
> +} PVPanicMMIOState;
> +
> +#define PVPANIC_ISA(obj)    \
> +    OBJECT_CHECK(PVPanicISAState, (obj), TYPE_PVPANIC)
> +
> +#define PVPANIC_MMIO(obj)    \
> +    OBJECT_CHECK(PVPanicMMIOState, (obj), TYPE_PVPANIC_MMIO)
> +
>   
>   /* return supported events on read */
> -static uint64_t pvpanic_ioport_read(void *opaque, hwaddr addr, unsigned size)
> +static uint64_t pvpanic_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       return PVPANIC_PANICKED;
>   }
>   
> -static void pvpanic_ioport_write(void *opaque, hwaddr addr, uint64_t val,
> +static void pvpanic_write(void *opaque, hwaddr addr, uint64_t val,
>                                    unsigned size)
>   {
>       handle_event(val);
>   }
>   
>   static const MemoryRegionOps pvpanic_ops = {
> -    .read = pvpanic_ioport_read,
> -    .write = pvpanic_ioport_write,
> +    .read = pvpanic_read,
> +    .write = pvpanic_write,
>       .impl = {
>           .min_access_size = 1,
>           .max_access_size = 1,
> @@ -77,15 +97,15 @@ static const MemoryRegionOps pvpanic_ops = {
>   
>   static void pvpanic_isa_initfn(Object *obj)
>   {
> -    PVPanicState *s = PVPANIC(obj);
> +    PVPanicISAState *s = PVPANIC_ISA(obj);
>   
> -    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s, "pvpanic", 1);
> +    memory_region_init_io(&s->common.mr, OBJECT(s), &pvpanic_ops, s, TYPE_PVPANIC, 1);
>   }
>   
>   static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
>   {
>       ISADevice *d = ISA_DEVICE(dev);
> -    PVPanicState *s = PVPANIC(dev);
> +    PVPanicISAState *s = PVPANIC_ISA(dev);
>       FWCfgState *fw_cfg = fw_cfg_find();
>       uint16_t *pvpanic_port;
>   
> @@ -98,11 +118,11 @@ static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
>       fw_cfg_add_file(fw_cfg, "etc/pvpanic-port", pvpanic_port,
>                       sizeof(*pvpanic_port));
>   
> -    isa_register_ioport(d, &s->mr, s->ioport);
> +    isa_register_ioport(d, &s->common.mr, s->ioport);
>   }
>   
>   static Property pvpanic_isa_properties[] = {
> -    DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicState, ioport, 0x505),
> +    DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x505),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -118,14 +138,40 @@ static void pvpanic_isa_class_init(ObjectClass *klass, void *data)
>   static TypeInfo pvpanic_isa_info = {
>       .name          = TYPE_PVPANIC,
>       .parent        = TYPE_ISA_DEVICE,
> -    .instance_size = sizeof(PVPanicState),
> +    .instance_size = sizeof(PVPanicISAState),
>       .instance_init = pvpanic_isa_initfn,
>       .class_init    = pvpanic_isa_class_init,
>   };
>   
> +static void pvpanic_mmio_initfn(Object *obj)
> +{
> +    PVPanicMMIOState *s = PVPANIC_MMIO(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->common.mr, OBJECT(s), &pvpanic_ops, s,
> +                          TYPE_PVPANIC_MMIO, 2);
> +    sysbus_init_mmio(sbd, &s->common.mr);
> +}
> +
> +static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static TypeInfo pvpanic_mmio_info = {
> +    .name          = TYPE_PVPANIC_MMIO,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(PVPanicMMIOState),
> +    .instance_init = pvpanic_mmio_initfn,
> +    .class_init    = pvpanic_mmio_class_init,
> +};
> +
>   static void pvpanic_register_types(void)
>   {
>       type_register_static(&pvpanic_isa_info);
> +    type_register_static(&pvpanic_mmio_info);
>   }
>   
>   type_init(pvpanic_register_types)
> diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
> index 1ee071a..c0d2d38 100644
> --- a/include/hw/misc/pvpanic.h
> +++ b/include/hw/misc/pvpanic.h
> @@ -16,6 +16,8 @@
>   
>   #define TYPE_PVPANIC "pvpanic"
>   
> +#define TYPE_PVPANIC_MMIO "pvpanic-mmio"
> +
>   #define PVPANIC_IOPORT_PROP "ioport"
>   
>   static inline uint16_t pvpanic_port(void)
> 

Depending of the response to Peter's question [*]:

     I'd also like some confirmation from folks more familiar with the
     current state of the art in guest-to-management-layer communication
     that pvpanic is still the recommended way to achieve this goal,
     and hasn't been obsoleted by something else.

I might work a bit on this patch next week.

[*] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03861.html
