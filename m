Received: from eggs.gnu.org ([2001:4830:134:3::10]:40130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP72A-0005I0-Cu
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP729-0005kQ-6p
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:29:46 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP729-0005k0-02
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:29:45 -0500
Received: by mail-oi1-x244.google.com with SMTP id x202so1602110oif.13
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:29:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542365406-81310-4-git-send-email-peng.hao2@zte.com.cn>
References: <1542365406-81310-1-git-send-email-peng.hao2@zte.com.cn>
	<1542365406-81310-4-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:29:23 +0000
Message-ID: <CAFEAcA_2ScVO3=K4b+r5RTTnNs3uqyeXwX=tH=qYS2To+y7PRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V7 3/6] hw/misc/pvpanic: Add the MMIO
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 16 November 2018 at 10:50, Peng Hao <peng.hao2@zte.com.cn> wrote:
> Add pvpanic new type "TYPE_PVPANIC_MMIO"
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I'm not entirely sure I understand why we have two
signed-off-by lines here -- who is the author of this patch?

> ---
>  hw/misc/pvpanic.c         | 81 +++++++++++++++++++++++++++++++++++++----=
------
>  include/hw/misc/pvpanic.h |  1 +
>  2 files changed, 65 insertions(+), 17 deletions(-)
>
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index dd3aef2..5d0fbc6 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -2,10 +2,12 @@
>   * QEMU simulated pvpanic device.
>   *
>   * Copyright Fujitsu, Corp. 2013
> + * Copyright (c) 2018 ZTE Ltd.
>   *
>   * Authors:
>   *     Wen Congyang <wency@cn.fujitsu.com>
>   *     Hu Tao <hutao@cn.fujitsu.com>
> + *     Peng Hao <peng.hao2@zte.com.cn>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
>   * See the COPYING file in the top-level directory.
> @@ -25,9 +27,6 @@
>  /* The pv event value */
>  #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
>
> -#define PVPANIC(obj)    \
> -    OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
> -

We just added (renamed) this macro in the previous patch:
has something gone wrong in a rebase ?

>  static void handle_event(int event)
>  {
>      static bool logged;
> @@ -45,30 +44,50 @@ static void handle_event(int event)
>
>  #include "hw/isa/isa.h"
>
> -typedef struct PVPanicState {
> -    /* private */
> -    ISADevice isadev;
> +/* PVPanicISAState for ISA device and
> + * use ioport.
> + */
> +typedef struct PVPanicISAState {
> +     /* private */
> +     ISADevice isadev;

This should be "ISADevice parent_obj;" and go above the /* private */
comment, because a PVPanicISAState is-a ISADevice (this is not
a has-a relation).

Again, this seems to be undoing changes from the previous patch
somewhat ?

> +     uint16_t ioport;
>
>      /* public */
>      MemoryRegion mr;
> -    uint16_t ioport;
> -} PVPanicState;
> +} PVPanicISAState;
> +
> +/* PVPanicMMIOState for sysbus device and
> + * use mmio.
> + */
> +typedef struct PVPanicMMIOState {
> +    /* private */
> +    SysBusDevice busdev;
> +
> +     /* public */
> +    MemoryRegion mr;
> +} PVPanicMMIOState;
> +
> +#define PVPANIC_ISA(obj)    \
> +    OBJECT_CHECK(PVPanicISAState, (obj), TYPE_PVPANIC)
> +
> +#define PVPANIC_MMIO(obj)    \
> +    OBJECT_CHECK(PVPanicMMIOState, (obj), TYPE_PVPANIC_MMIO)
>
>  /* return supported events on read */
> -static uint64_t pvpanic_ioport_read(void *opaque, hwaddr addr, unsigned =
size)
> +static uint64_t pvpanic_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      return PVPANIC_PANICKED;
>  }
>
> -static void pvpanic_ioport_write(void *opaque, hwaddr addr, uint64_t val=
,
> +static void pvpanic_write(void *opaque, hwaddr addr, uint64_t val,
>                                   unsigned size)
>  {
>      handle_event(val);
>  }
>
>  static const MemoryRegionOps pvpanic_ops =3D {
> -    .read =3D pvpanic_ioport_read,
> -    .write =3D pvpanic_ioport_write,
> +    .read =3D pvpanic_read,
> +    .write =3D pvpanic_write,
>      .impl =3D {
>          .min_access_size =3D 1,
>          .max_access_size =3D 1,
> @@ -77,15 +96,16 @@ static const MemoryRegionOps pvpanic_ops =3D {
>
>  static void pvpanic_isa_initfn(Object *obj)
>  {
> -    PVPanicState *s =3D PVPANIC(obj);
> +    PVPanicISAState *s =3D PVPANIC_ISA(obj);
>
> -    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s, "pvpanic",=
 1);
> +    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s,
> +                          TYPE_PVPANIC, 1);
>  }
>
>  static void pvpanic_isa_realizefn(DeviceState *dev, Error **errp)
>  {
>      ISADevice *d =3D ISA_DEVICE(dev);
> -    PVPanicState *s =3D PVPANIC(dev);
> +    PVPanicISAState *s =3D PVPANIC_ISA(dev);
>      FWCfgState *fw_cfg =3D fw_cfg_find();
>      uint16_t *pvpanic_port;
>
> @@ -102,7 +122,7 @@ static void pvpanic_isa_realizefn(DeviceState *dev, E=
rror **errp)
>  }
>
>  static Property pvpanic_isa_properties[] =3D {
> -    DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicState, ioport, 0x505)=
,
> +    DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x5=
05),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -118,14 +138,41 @@ static void pvpanic_isa_class_init(ObjectClass *kla=
ss, void *data)
>  static TypeInfo pvpanic_isa_info =3D {
>      .name          =3D TYPE_PVPANIC,
>      .parent        =3D TYPE_ISA_DEVICE,
> -    .instance_size =3D sizeof(PVPanicState),
> +    .instance_size =3D sizeof(PVPanicISAState),
>      .instance_init =3D pvpanic_isa_initfn,
>      .class_init    =3D pvpanic_isa_class_init,
>  };
>
> +
> +static void pvpanic_mmio_initfn(Object *obj)
> +{
> +    PVPanicMMIOState *s =3D PVPANIC_MMIO(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->mr, OBJECT(s), &pvpanic_ops, s,
> +                          TYPE_PVPANIC_MMIO, 2);
> +    sysbus_init_mmio(sbd, &s->mr);
> +}
> +
> +static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static TypeInfo pvpanic_mmio_info =3D {
> +    .name          =3D TYPE_PVPANIC_MMIO,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(PVPanicMMIOState),
> +    .instance_init =3D pvpanic_mmio_initfn,
> +    .class_init    =3D pvpanic_mmio_class_init,
> +};
> +
>  static void pvpanic_register_types(void)
>  {
>      type_register_static(&pvpanic_isa_info);
> +    type_register_static(&pvpanic_mmio_info);
>  }

I would suggest refactoring the ISA device in one patch,
and then adding the MMIO device in a second patch. Currently
this patch is mixing the two.

thanks
-- PMM
