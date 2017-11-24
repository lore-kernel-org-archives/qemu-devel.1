Received: from eggs.gnu.org ([2001:4830:134:3::10]:37517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eII2M-0005oh-RP
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eII2J-0000N7-LB
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:45:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eII2J-0000J9-Bi
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:45:11 -0500
References: <20171124134644.490-1-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1d5665fa-f425-25b5-041e-5f226192296c@redhat.com>
Date: Fri, 24 Nov 2017 18:44:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171124134644.490-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3] dma/i82374: avoid double creation of
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

 Hi Eduardo,

On 24.11.2017 14:46, Eduardo Otubo wrote:
> v3:
>  * Removed all unecessary local_err
>  * Change return of isa_bus_dma() and DMA_init() from void to int8_t,
>    returning -EBUSY on error and 0 on success
>  * Added qdev_cleanup_nofail() in case isa_bus_dma() returns error. The
>    cleanup looks safe, but please review if I didn't miss any detail
>=20
> v2:
>  * Removed user_creatable=3Dfalse and replaced by error handling using
>    Error **errp and error_propagate();

Version changelog should go below the "---" separator, otherwise it will
be included in the git changelog as well, which is kind of ugly.

> QEMU fails when used with the following command line:
>=20
>     ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=3Dtcg -devi=
ce i82374
>     qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!b=
us->dma[0] && !bus->dma[1]' failed.
>     Aborted (core dumped)
>=20
> The 40p machine type already created the device i82374. If specified in=
 the
> command line, it will try to create it again, hence generating the erro=
r. The
> function isa_bus_dma() isn't supposed to be called twice for the same b=
us. One
> way to avoid this problem is to set user_creatable=3Dfalse.

You don't do that user_creatable=3Dfalse here anymore, so please remove i=
t
from the description.

> A possible fix in a near future would be making
> isa_bus_dma()/DMA_init()/i82374_realize() return an error instead of as=
serting
> as well.

You should rephrase that sentence as well.

> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  hw/core/qdev.c         | 16 ++++++++++++++++
>  hw/dma/i82374.c        | 13 +++++++------
>  hw/dma/i8257.c         | 38 ++++++++++++++++++++++----------------
>  hw/isa/isa-bus.c       |  8 ++++++--
>  include/hw/isa/isa.h   |  4 ++--
>  include/hw/qdev-core.h |  1 +
>  6 files changed, 54 insertions(+), 26 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 606ab53c42..0ef03ee461 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -344,6 +344,22 @@ void qdev_init_nofail(DeviceState *dev)
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
> +
>  void qdev_machine_creation_done(void)
>  {
>      /*
> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
> index 6c0f975df0..9b792890b2 100644
> --- a/hw/dma/i82374.c
> +++ b/hw/dma/i82374.c
> @@ -24,6 +24,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/isa/isa.h"
> +#include "qapi/error.h"
> =20
>  #define TYPE_I82374 "i82374"
>  #define I82374(obj) OBJECT_CHECK(I82374State, (obj), TYPE_I82374)
> @@ -118,13 +119,13 @@ static void i82374_realize(DeviceState *dev, Erro=
r **errp)
>  {
>      I82374State *s =3D I82374(dev);
> =20
> -    portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list, s,
> -                     "i82374");
> -    portio_list_add(&s->port_list, isa_address_space_io(&s->parent_obj=
),
> +    if (DMA_init(isa_bus_from_device(ISA_DEVICE(dev)), 1, errp) =3D=3D=
 0) {

I think I'd rather prefer if (DMA_init()) { return; } here ... but
that's just my personal taste.

> +        portio_list_init(&s->port_list, OBJECT(s), i82374_portio_list,=
 s,
> +                    "i82374");
> +        portio_list_add(&s->port_list, isa_address_space_io(&s->parent=
_obj),
>                      s->iobase);
> -
> -    DMA_init(isa_bus_from_device(ISA_DEVICE(dev)), 1);
> -    memset(s->commands, 0, sizeof(s->commands));
> +        memset(s->commands, 0, sizeof(s->commands));
> +    }
>  }
> =20
>  static Property i82374_properties[] =3D {
> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
> index bd23e893bf..7488e3dd12 100644
> --- a/hw/dma/i8257.c
> +++ b/hw/dma/i8257.c
> @@ -622,26 +622,32 @@ static void i8257_register_types(void)
> =20
>  type_init(i8257_register_types)
> =20
> -void DMA_init(ISABus *bus, int high_page_enable)
> +int8_t DMA_init(ISABus *bus, int high_page_enable, Error **errp)

Why int8_t ? Error codes are normally propagated as normal "int", and in
the very worst case -EBUSY might even not fit anymore into a normal
int8_t on some systems...

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
> +    if (isa_bus_dma(bus, ISADMA(isa1), ISADMA(isa2), errp) < 0) {
> +        qdev_cleanup_nofail(d1);
> +        qdev_cleanup_nofail(d2);
> +        return -EBUSY;
> +    }
> +
> +    return 0;
>  }
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 348e0eab9d..4781dddaf9 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -104,12 +104,16 @@ void isa_connect_gpio_out(ISADevice *isadev, int =
gpioirq, int isairq)
>      qdev_connect_gpio_out(DEVICE(isadev), gpioirq, irq);
>  }
> =20
> -void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16)
> +int8_t isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16, Error **e=
rrp)

dito - this should be "int", not "int8_t".

>  {
>      assert(bus && dma8 && dma16);
> -    assert(!bus->dma[0] && !bus->dma[1]);
> +    if (bus->dma[0] || bus->dma[1]) {
> +        error_setg(errp, "DMA already initialized on ISA bus");
> +        return -EBUSY;
> +    }
>      bus->dma[0] =3D dma8;
>      bus->dma[1] =3D dma16;
> +    return 0;
>  }
> =20
 Thomas
