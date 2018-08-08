Received: from eggs.gnu.org ([2001:4830:134:3::10]:48867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnTmz-0004tJ-8v
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnTmw-0007am-2Y
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:06:33 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:44860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnTmv-0007aU-Py
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:06:30 -0400
Received: by mail-ua0-x243.google.com with SMTP id k25-v6so3554477uao.11
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 12:06:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180808141700.21333-1-jthumshirn@suse.de>
	<20180808141700.21333-4-jthumshirn@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a575ca39-74f9-ed47-810a-370e070f7da2@amsat.org>
Date: Wed, 8 Aug 2018 16:06:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180808141700.21333-4-jthumshirn@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="g0psZRj46v5hxQIPa21G1XJ7PeDYV8g4H"
Subject: Re: [Qemu-devel] [PATCH 3/4] serial-mcb: Add serial via MEN
 chameleon bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Johannes Thumshirn <jthumshirn@suse.de>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g0psZRj46v5hxQIPa21G1XJ7PeDYV8g4H
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Johannes Thumshirn <jthumshirn@suse.de>, qemu-devel@nongnu.org
Message-ID: <a575ca39-74f9-ed47-810a-370e070f7da2@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 3/4] serial-mcb: Add serial via MEN chameleon
 bus
References: <20180808141700.21333-1-jthumshirn@suse.de>
 <20180808141700.21333-4-jthumshirn@suse.de>
In-Reply-To: <20180808141700.21333-4-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On 08/08/2018 11:16 AM, Johannes Thumshirn wrote:
> Add MEN z125 UART over MEN Chameleon Bus emulation.
>=20
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  hw/char/Makefile.objs |  1 +
>  hw/char/serial-mcb.c  | 97 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 hw/char/serial-mcb.c
>=20
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index b57053129107..063f1720974d 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_PL011) +=3D pl011.o
>  common-obj-$(CONFIG_SERIAL) +=3D serial.o
>  common-obj-$(CONFIG_SERIAL_ISA) +=3D serial-isa.o
>  common-obj-$(CONFIG_SERIAL_PCI) +=3D serial-pci.o
> +common-obj-$(CONFIG_MCB) +=3D serial-mcb.o
>  common-obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-console.o
>  common-obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o
>  common-obj-$(CONFIG_XEN) +=3D xen_console.o
> diff --git a/hw/char/serial-mcb.c b/hw/char/serial-mcb.c
> new file mode 100644
> index 000000000000..a1087bc369dd
> --- /dev/null
> +++ b/hw/char/serial-mcb.c
> @@ -0,0 +1,97 @@
> +/*
> + * QEMU MEN 16z125 UART over MCB emulation
> + *
> + * Copyright (C) 2016 Johannes Thumshirn <jthumshirn@suse.de>
> + *
> + * This code is licensed under the GNU GPL v2 or (at your opinion) any=

> + * later version
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/char/serial.h"
> +#include "hw/mcb/mcb.h"
> +
> +typedef struct {

IMHO adding ...

       /*< private >*/


> +    MCBDevice dev;

       /*< public >*/

=2E.. makes it more explicit that MCBDevice contains the QOM parent
DeviceState. Since you don't seem to use it you can even name it parent_o=
bj:

       /*< private >*/
       MCBDevice parent_obj;
       /*< public >*/
       ...

> +    SerialState state;
> +} MCBSerialState;
> +
> +static void serial_mcb_realize(DeviceState *dev, Error **errp)
> +{
> +    MCBDevice *mdev =3D MCB_DEVICE(dev);
> +    MCBSerialState *mss =3D DO_UPCAST(MCBSerialState, dev, mdev);
> +    MCBus *bus =3D MCB_BUS(qdev_get_parent_bus(DEVICE(dev)));
> +    SerialState *s =3D &mss->state;
> +    Error *err =3D 0;
> +
> +    mdev->gdd =3D mcb_new_chameleon_descriptor(bus, 125, mdev->rev,
> +                                             mdev->var, 0x10);
> +    if (!mdev->gdd) {
> +        return;
> +    }
> +
> +    s->baudbase =3D 115200;
> +    serial_realize_core(s, &err);
> +    if (err !=3D NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    s->irq =3D mcb_allocate_irq(&mss->dev);
> +    memory_region_init_io(&s->io, OBJECT(mss), &serial_io_ops, s, "ser=
ial", 8);
> +    memory_region_add_subregion(&bus->mmio_region, mdev->gdd->offset, =
&s->io);
> +}
> +
> +static void serial_mcb_unrealize(DeviceState *dev, Error **errp)
> +{
> +    MCBDevice *mdev =3D MCB_DEVICE(dev);
> +
> +    g_free(&mdev->gdd);
> +}
> +
> +static const VMStateDescription vmstate_mcb_serial =3D {
> +    .name =3D "mcb-serial",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_MCB_DEVICE(dev, MCBSerialState),
> +        VMSTATE_STRUCT(state, MCBSerialState, 0, vmstate_serial, Seria=
lState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property serial_mcb_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev", MCBSerialState, state.chr),
> +    DEFINE_PROP_UINT8("rev", MCBSerialState, dev.rev, 0),
> +    DEFINE_PROP_UINT8("var", MCBSerialState, dev.var, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void serial_mcb_class_initfn(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    MCBDeviceClass *mc =3D MCB_DEVICE_CLASS(klass);
> +
> +    mc->realize =3D serial_mcb_realize;
> +    mc->unrealize =3D serial_mcb_unrealize;
> +
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +    dc->desc =3D "MEN 16z125 UART over MCB";
> +    dc->vmsd =3D &vmstate_mcb_serial;
> +    dc->props =3D serial_mcb_properties;
> +}
> +
> +static const TypeInfo serial_mcb_info =3D {
> +    .name =3D "mcb-serial",
> +    .parent =3D TYPE_MCB_DEVICE,
> +    .instance_size =3D sizeof(MCBSerialState),
> +    .class_init =3D serial_mcb_class_initfn,
> +};
> +
> +static void serial_mcb_register_types(void)
> +{
> +    type_register_static(&serial_mcb_info);
> +}
> +
> +type_init(serial_mcb_register_types);
>=20


--g0psZRj46v5hxQIPa21G1XJ7PeDYV8g4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAltrPy8ACgkQ4+MsLN6t
wN4n6w//eToUyY5Ao9bJwAMFpu21p1qsbw2xfcNMMIdfJAvpX/aOLJiesypGdIyZ
+auG4iUufkOG/1eyNSn6BK1TwOdQlvZYK3qCCSmcFawhgEybxAaVVchoZsiuLKHf
aTolIsjJbYGUC0OkMrkhKi9fxnu6AVedwpUoK52Zhq6W4dlMdvylriPIy0s7+f/5
DWUiBWYq6Vz61YroonQMQ8RshaedIdjcZ0lVlJUcKUJfQCazqDY7Bx6FtlUyyFxG
qaUQjWrqfn/ItKlNqjeHCOteicUBGMtedWW68vK3b9b3dp4cOklaDLdJxHQW0HVF
aVEs1FYMxCOIxUcX823v2H+XYmrdhmUGj6uoE5rIUPj2ZG5moNp9SHkCqBdZ7GtH
ueoCjLkS4Tzx7QZRKHNWrnrUVwctWUHQcHrfyEtSbSMRUbXqjdDGuR3LeQERmgjv
52ZqJLeAiWHWKxcEzhMm6kBIQi6OGWb6IP3ZjJsspayC8qzcPV20ClNMAnxcFwLR
su9o24X7y7Nm+wqHrnkIbvYXq2Me3NC9ZhXUb5frXmLStYPMwRvcD9meimAQEKaJ
anqg//5V6Hh0m4jABZv/W01W4zSZ0TSk8EX5VU+RdM+bOHdkwiHNoFcWCg88rSfL
E4xVtWQx4gHiLvvZXxaQ0GMKg9ruyZdMTIvq40qt0EZFc0DnelU=
=lrRS
-----END PGP SIGNATURE-----

--g0psZRj46v5hxQIPa21G1XJ7PeDYV8g4H--
