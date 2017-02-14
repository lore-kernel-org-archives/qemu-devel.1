Received: from eggs.gnu.org ([2001:4830:134:3::10]:59152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cdYT1-0003T2-Hy
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 03:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cdYSw-0002qp-Br
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 03:28:07 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:51077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cdYSw-0002oY-0u
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 03:28:02 -0500
References: <1486939835-3452-1-git-send-email-huth@tuxfamily.org>
	<1486939835-3452-2-git-send-email-huth@tuxfamily.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <88189d96-ba7e-23bd-45e4-31130f548eb1@vivier.eu>
Date: Tue, 14 Feb 2017 09:27:55 +0100
MIME-Version: 1.0
In-Reply-To: <1486939835-3452-2-git-send-email-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/m68k: QOMify the ColdFire interrupt
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org

Le 12/02/2017 à 23:50, Thomas Huth a écrit :
> Use type_init() and friends to adapt the ColdFire interrupt
> controller to the latest QEMU device conventions.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>  hw/m68k/mcf_intc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
> index cf58132..8198afa 100644
> --- a/hw/m68k/mcf_intc.c
> +++ b/hw/m68k/mcf_intc.c
> @@ -9,10 +9,16 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> +#include "hw/sysbus.h"
>  #include "hw/m68k/mcf.h"
>  #include "exec/address-spaces.h"
>  
> +#define TYPE_MCF_INTC "mcf-intc"
> +#define MCF_INTC(obj) OBJECT_CHECK(mcf_intc_state, (obj), TYPE_MCF_INTC)
> +
>  typedef struct {
> +    SysBusDevice parent_obj;
> +
>      MemoryRegion iomem;
>      uint64_t ipr;
>      uint64_t imr;
> @@ -138,8 +144,10 @@ static void mcf_intc_set_irq(void *opaque, int irq, int level)
>      mcf_intc_update(s);
>  }
>  
> -static void mcf_intc_reset(mcf_intc_state *s)
> +static void mcf_intc_reset(DeviceState *dev)
>  {
> +    mcf_intc_state *s = MCF_INTC(dev);
> +
>      s->imr = ~0ull;
>      s->ipr = 0;
>      s->ifr = 0;
> @@ -154,17 +162,49 @@ static const MemoryRegionOps mcf_intc_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> +static void mcf_intc_instance_init(Object *obj)
> +{
> +    mcf_intc_state *s = MCF_INTC(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &mcf_intc_ops, s, "mcf", 0x100);
> +}
> +
> +static void mcf_intc_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->reset = mcf_intc_reset;
> +}
> +
> +static const TypeInfo mcf_intc_gate_info = {
> +    .name          = TYPE_MCF_INTC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(mcf_intc_state),
> +    .instance_init = mcf_intc_instance_init,
> +    .class_init    = mcf_intc_class_init,
> +};
> +
> +static void mcf_intc_register_types(void)
> +{
> +    type_register_static(&mcf_intc_gate_info);
> +}
> +
> +type_init(mcf_intc_register_types)
> +
>  qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
>                          hwaddr base,
>                          M68kCPU *cpu)
>  {
> +    DeviceState  *dev;
>      mcf_intc_state *s;
>  
> -    s = g_malloc0(sizeof(mcf_intc_state));
> +    dev = qdev_create(NULL, TYPE_MCF_INTC);
> +    qdev_init_nofail(dev);
> +
> +    s = MCF_INTC(dev);
>      s->cpu = cpu;
> -    mcf_intc_reset(s);
>  
> -    memory_region_init_io(&s->iomem, NULL, &mcf_intc_ops, s, "mcf", 0x100);
>      memory_region_add_subregion(sysmem, base, &s->iomem);
>  
>      return qemu_allocate_irqs(mcf_intc_set_irq, s, 64);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Later, we should consider to move this to mcf5208.c and to use
sysbus_mmio_map()/qdev_get_gpio_in().

Laurent
