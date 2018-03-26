Received: from eggs.gnu.org ([2001:4830:134:3::10]:32952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0R1G-0001fD-Tx
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0R1C-0004h6-Rm
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:14:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f0R1C-0004gi-MM
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 08:14:30 -0400
References: <20180326111857.26146-1-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <773067e7-21e6-351b-16d4-4d4558f68825@redhat.com>
Date: Mon, 26 Mar 2018 14:14:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180326111857.26146-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru, agraf@suse.de, ehabkost@redhat.com

On 26.03.2018 13:18, Eduardo Otubo wrote:
> QEMU fails when used with the following command line:
>=20
>     ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=3Dtcg -devi=
ce i82374
>     qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!b=
us->dma[0] && !bus->dma[1]' failed.
>     Aborted (core dumped)
>=20
> The 40p machine type already creates the device i82374. If specified in=
 the
> command line, it will try to create it again, hence generating the erro=
r. The
> function isa_bus_dma() isn't supposed to be called twice for the same b=
us. This
> patch fixes this issue by calling involved functions with Error **error=
_fatal
> and propagating back the error so QEMU can fail nicely without Abort an=
d core
> dump.
>=20
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
> v4:
>  * Change return value from int8_t to int
>  * Changed function calling for other architectures.
>=20
> v3:
>  * Removed all unecessary local_err                                    =
                                                                         =
                                                                    =20
>  * Change return of isa_bus_dma() and DMA_init() from void to int8_t,  =
                                                                         =
                                                                    =20
>    returning -EBUSY on error and 0 on success                          =
                                                                         =
                                                                    =20
>  * Added qdev_cleanup_nofail() in case isa_bus_dma() returns error. The=
                                                                         =
                                                                    =20
>    cleanup looks safe, but please review if I didn't miss any detail   =
                                                                         =
                                                                    =20
>                                                                        =
                                                                         =
                                                                    =20
> v2:                                                                    =
                                                                         =
                                                                    =20
>  * Removed user_creatable=3Dfalse and replaced by error handling using =
                                                                         =
                                                                      =20
>    Error **errp and error_propagate();         =20
>=20
>  hw/core/qdev.c          | 16 ++++++++++++++++
>  hw/dma/i82374.c         |  3 ++-
>  hw/dma/i8257.c          | 35 +++++++++++++++++++----------------
>  hw/i386/pc.c            |  2 +-
>  hw/isa/isa-bus.c        |  8 ++++++--
>  hw/mips/mips_fulong2e.c |  2 +-
>  hw/mips/mips_jazz.c     |  2 +-
>  hw/mips/mips_malta.c    |  2 +-
>  include/hw/dma/i8257.h  |  2 +-
>  include/hw/isa/isa.h    |  2 +-
>  include/hw/qdev-core.h  |  1 +
>  11 files changed, 50 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f6f92473b8..e14164526f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -345,6 +345,22 @@ void qdev_init_nofail(DeviceState *dev)
>      object_unref(OBJECT(dev));
>  }
> =20
> +void qdev_cleanup_nofail(DeviceState *dev)
> +{
> +    Error *err =3D NULL;
> +
> +    assert(dev->realized);
> +
> +    object_ref(OBJECT(dev));
> +    object_property_set_bool(OBJECT(dev), false, "realized", &err);
> +    if (err) {
> +        error_reportf_err(err, "Clean up of device %s failed: ",
> +                          object_get_typename(OBJECT(dev)));
> +        exit(1);
> +    }
> +    object_unref(OBJECT(dev));
> +}

I'm not a qdev expert, but I wonder whether we need the full object_ref
+ unref dance here? If not, you could get rid of this function and
simply do the object_property_set_bool(OBJECT(dev), false, "realized",
&error_fatal) twice in i8257_dma_init() instead.

>  void qdev_machine_creation_done(void)
>  {
>      /*
> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
> index 83c87d92e0..718cd632fd 100644
> --- a/hw/dma/i82374.c
> +++ b/hw/dma/i82374.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/isa/isa.h"
>  #include "hw/dma/i8257.h"
> +#include "qapi/error.h"
> =20
>  #define TYPE_I82374 "i82374"
>  #define I82374(obj) OBJECT_CHECK(I82374State, (obj), TYPE_I82374)
> @@ -124,7 +125,7 @@ static void i82374_realize(DeviceState *dev, Error =
**errp)
>      portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj=
),
>                      s->iobase);
> =20
> -    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true);
> +    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true, errp);

I think it would be better to move this at the beginning of the
i82374_realize function and return in case of errors, so that the
portio_list_init() is not called in such a case:

    Error *local_err =3D NULL;

    i8257_dma_init(isa_bus_from_device(ISA_DEVICE(dev)), true, local_err)=
;
    if (local_err) {
        error_propagate(errp, local_err);
        return;
    }

    portio_list_init(...);
    ...

>      memset(s->commands, 0, sizeof(s->commands));
>  }
> =20
> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
> index 52675e97c9..84978f9459 100644
> --- a/hw/dma/i8257.c
> +++ b/hw/dma/i8257.c
> @@ -622,26 +622,29 @@ static void i8257_register_types(void)
> =20
>  type_init(i8257_register_types)
> =20
> -void i8257_dma_init(ISABus *bus, bool high_page_enable)
> +void i8257_dma_init(ISABus *bus, bool high_page_enable, Error **error_=
fatal)

Please don't call this parameter "error_fatal" since this shadows the
global error_fatal variable and thus is very confusing. Use "errp" like
everywhere else instead.

>  {
>      ISADevice *isa1, *isa2;
> -    DeviceState *d;
> +    DeviceState *d1, *d2;
> =20
>      isa1 =3D isa_create(bus, TYPE_I8257);
> -    d =3D DEVICE(isa1);
> -    qdev_prop_set_int32(d, "base", 0x00);
> -    qdev_prop_set_int32(d, "page-base", 0x80);
> -    qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x480 : -1=
);
> -    qdev_prop_set_int32(d, "dshift", 0);
> -    qdev_init_nofail(d);
> +    d1 =3D DEVICE(isa1);
> +    qdev_prop_set_int32(d1, "base", 0x00);
> +    qdev_prop_set_int32(d1, "page-base", 0x80);
> +    qdev_prop_set_int32(d1, "pageh-base", high_page_enable ? 0x480 : -=
1);
> +    qdev_prop_set_int32(d1, "dshift", 0);
> +    qdev_init_nofail(d1);
> =20
>      isa2 =3D isa_create(bus, TYPE_I8257);
> -    d =3D DEVICE(isa2);
> -    qdev_prop_set_int32(d, "base", 0xc0);
> -    qdev_prop_set_int32(d, "page-base", 0x88);
> -    qdev_prop_set_int32(d, "pageh-base", high_page_enable ? 0x488 : -1=
);
> -    qdev_prop_set_int32(d, "dshift", 1);
> -    qdev_init_nofail(d);
> -
> -    isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2));
> +    d2 =3D DEVICE(isa2);
> +    qdev_prop_set_int32(d2, "base", 0xc0);
> +    qdev_prop_set_int32(d2, "page-base", 0x88);
> +    qdev_prop_set_int32(d2, "pageh-base", high_page_enable ? 0x488 : -=
1);
> +    qdev_prop_set_int32(d2, "dshift", 1);
> +    qdev_init_nofail(d2);
> +
> +    if (isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2), error_fatal) < 0)=
 {

s/error_fatal/errp/

> +        qdev_cleanup_nofail(d1);
> +        qdev_cleanup_nofail(d2);
> +    }
>  }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d36bac8c89..31777a7ed5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1624,7 +1624,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_i=
rq *gsi,
>          pcspk_init(isa_bus, pit);
>      }
> =20
> -    i8257_dma_init(isa_bus, 0);
> +    i8257_dma_init(isa_bus, 0, &error_fatal);
> =20
>      /* Super I/O */
>      pc_superio_init(isa_bus, create_fdctrl, no_vmport);
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 63fa77effc..f0f9a1f8e0 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -104,12 +104,16 @@ void isa_connect_gpio_out(ISADevice *isadev, int =
gpioirq, int isairq)
>      qdev_connect_gpio_out(DEVICE(isadev), gpioirq, irq);
>  }
> =20
> -void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16)
> +int isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16, Error **erro=
r_fatal)

s/error_fatal/errp/

>  {
>      assert(bus && dma8 && dma16);
> -    assert(!bus->dma[0] && !bus->dma[1]);
> +    if (bus->dma[0] || bus->dma[1]) {
> +        error_setg(error_fatal, "DMA already initialized on ISA bus");

s/error_fatal/errp/

> +        return -EBUSY;
> +    }
>      bus->dma[0] =3D dma8;
>      bus->dma[1] =3D dma16;
> +    return 0;
>  }
> =20
>  IsaDma *isa_get_dma(ISABus *bus, int nchan)
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 02fb2fdcc4..e98d994f3a 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -243,7 +243,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_=
bus, int slot, qemu_irq intc,
>      isa_bus_irqs(isa_bus, i8259);
>      /* init other devices */
>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
> -    i8257_dma_init(isa_bus, 0);
> +    i8257_dma_init(isa_bus, 0, &error_fatal);
>      /* Super I/O */
>      isa_create_simple(isa_bus, TYPE_VT82C686B_SUPERIO);
> =20
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 7223085547..a1c071e311 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -222,7 +222,7 @@ static void mips_jazz_init(MachineState *machine,
>      /* ISA devices */
>      i8259 =3D i8259_init(isa_bus, env->irq[4]);
>      isa_bus_irqs(isa_bus, i8259);
> -    i8257_dma_init(isa_bus, 0);
> +    i8257_dma_init(isa_bus, 0, &error_fatal);
>      pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
>      pcspk_init(isa_bus, pit);
> =20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index f6513a4fd5..7bb9b6071d 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1198,7 +1198,7 @@ void mips_malta_init(MachineState *machine)
>      smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
>                            isa_get_irq(NULL, 9), NULL, 0, NULL);
>      pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
> -    i8257_dma_init(isa_bus, 0);
> +    i8257_dma_init(isa_bus, 0, &error_fatal);
>      mc146818_rtc_init(isa_bus, 2000, NULL);
> =20
>      /* generate SPD EEPROM data */
> diff --git a/include/hw/dma/i8257.h b/include/hw/dma/i8257.h
> index 2cab50bb6c..d3f89393fe 100644
> --- a/include/hw/dma/i8257.h
> +++ b/include/hw/dma/i8257.h
> @@ -44,6 +44,6 @@ typedef struct I8257State {
>      PortioList portio_pageh;
>  } I8257State;
> =20
> -void i8257_dma_init(ISABus *bus, bool high_page_enable);
> +void i8257_dma_init(ISABus *bus, bool high_page_enable, Error **error_=
fatal);

s/error_fatal/errp/

>  #endif
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index b9dbab24b4..eb89654d24 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -103,7 +103,7 @@ void isa_bus_irqs(ISABus *bus, qemu_irq *irqs);
>  qemu_irq isa_get_irq(ISADevice *dev, int isairq);
>  void isa_init_irq(ISADevice *dev, qemu_irq *p, int isairq);
>  void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq);
> -void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16);
> +int isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16, Error ** err=
or_fatal);

s/error_fatal/errp/

>  IsaDma *isa_get_dma(ISABus *bus, int nchan);
>  MemoryRegion *isa_address_space(ISADevice *dev);
>  MemoryRegion *isa_address_space_io(ISADevice *dev);
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9453588160..238ad2f6f3 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -283,6 +283,7 @@ typedef struct GlobalProperty {
>  DeviceState *qdev_create(BusState *bus, const char *name);
>  DeviceState *qdev_try_create(BusState *bus, const char *name);
>  void qdev_init_nofail(DeviceState *dev);
> +void qdev_cleanup_nofail(DeviceState *dev);
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
>  HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
>=20

 Thomas
