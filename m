Received: from eggs.gnu.org ([2001:4830:134:3::10]:37739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deniz.eren@icloud.com>) id 1eaVlW-00032H-Ri
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 19:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deniz.eren@icloud.com>) id 1eaVlS-00080Y-Mx
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 19:03:10 -0500
Received: from st13p11im-asmtp004.me.com ([17.164.40.219]:51511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deniz.eren@icloud.com>)
	id 1eaVlS-0007zv-Ey
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 19:03:06 -0500
Received: from process-dkim-sign-daemon.st13p11im-asmtp004.me.com by
	st13p11im-asmtp004.me.com
	(Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built
	Jun 7 2017)) id <0P2I00300QSEIY00@st13p11im-asmtp004.me.com> for
	qemu-devel@nongnu.org; Sun, 14 Jan 2018 00:03:01 +0000 (GMT)
MIME-version: 1.0 (1.0)
From: Deniz Eren <deniz.eren@icloud.com>
In-reply-to: <9d07dec0056ce48504c0f41da37a34a70a8acf6c.1515260163.git.pisa@cmp.felk.cvut.cz>
Date: Sun, 14 Jan 2018 11:02:54 +1100
Message-id: <98F3087E-0D14-469C-ABF3-7CB73033C17E@icloud.com>
References: <cover.1515260163.git.pisa@cmp.felk.cvut.cz>
	<9d07dec0056ce48504c0f41da37a34a70a8acf6c.1515260163.git.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] CAN bus PCM-3680I PCI (dual SJA1000
 channel) emulation added.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pisa@cmp.felk.cvut.cz
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Konrad Frederic <frederic.konrad@adacore.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marek Vasut <marex@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Oleksij Rempel <o.rempel@pengutronix.de>

Signed-off-by: Deniz Eren <deniz.eren@icloud.com>

I=E2=80=99ve tested and used this work actively at for developing driverless=
 Straddle and AGV embedded software with QNX and Linux hosts with Advantech C=
AN-bus cards.

Sent from my iPhone

Deniz Eren
+61 400 307 762

> On 7 Jan 2018, at 7:47 am, pisa@cmp.felk.cvut.cz wrote:
>=20
> From: Deniz Eren <deniz.eren@icloud.com>
>=20
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
> hw/can/Makefile.objs     |   1 +
> hw/can/can_pcm3680_pci.c | 335 +++++++++++++++++++++++++++++++++++++++++++=
++++
> 2 files changed, 336 insertions(+)
> create mode 100644 hw/can/can_pcm3680_pci.c
>=20
> diff --git a/hw/can/Makefile.objs b/hw/can/Makefile.objs
> index c9d07b9b16..6a328f0c3a 100644
> --- a/hw/can/Makefile.objs
> +++ b/hw/can/Makefile.objs
> @@ -9,4 +9,5 @@ common-obj-y +=3D can_host_stub.o
> endif
> common-obj-$(CONFIG_CAN_SJA1000) +=3D can_sja1000.o
> common-obj-$(CONFIG_CAN_PCI) +=3D can_kvaser_pci.o
> +common-obj-$(CONFIG_CAN_PCI) +=3D can_pcm3680_pci.o
> endif
> diff --git a/hw/can/can_pcm3680_pci.c b/hw/can/can_pcm3680_pci.c
> new file mode 100644
> index 0000000000..692aab6ab8
> --- /dev/null
> +++ b/hw/can/can_pcm3680_pci.c
> @@ -0,0 +1,335 @@
> +/*
> + * PCM-3680i PCI CAN device (SJA1000 based) emulation
> + *
> + * Copyright (c) 2016 Deniz Eren (deniz.eren@icloud.com)
> + *
> + * Based on Kvaser PCI CAN device (SJA1000 based) emulation implemented b=
y
> + * Jin Yang and Pavel Pisa
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
> + * of this software and associated documentation files (the "Software"), t=
o deal
> + * in the Software without restriction, including without limitation the r=
ights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or s=
ell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be include=
d in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRES=
S OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILIT=
Y,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHAL=
L
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR O=
THER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISIN=
G FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS=
 IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/event_notifier.h"
> +#include "qemu/thread.h"
> +#include "qemu/sockets.h"
> +#include "qemu/error-report.h"
> +#include "chardev/char.h"
> +#include "hw/hw.h"
> +#include "hw/pci/pci.h"
> +#include "can/can_emu.h"
> +
> +#include "can_sja1000.h"
> +
> +#define TYPE_CAN_PCI_DEV "pcm3680_pci"
> +
> +#define PCM3680i_PCI_DEV(obj) \
> +    OBJECT_CHECK(Pcm3680iPCIState, (obj), TYPE_CAN_PCI_DEV)
> +
> +#ifndef PCM3680i_PCI_VENDOR_ID1
> +#define PCM3680i_PCI_VENDOR_ID1     0x13fe    /* the PCI device and vendo=
r IDs */
> +#endif
> +
> +#ifndef PCM3680i_PCI_DEVICE_ID1
> +#define PCM3680i_PCI_DEVICE_ID1     0xc002
> +#endif
> +
> +#define PCM3680i_PCI_SJA_RANGE     0x200
> +
> +#define PCM3680i_PCI_BYTES_PER_SJA 0x20
> +
> +typedef struct Pcm3680iPCIState {
> +    /*< private >*/
> +    PCIDevice       dev;
> +    /*< public >*/
> +    MemoryRegion    sja_io[2];
> +
> +    CanSJA1000State sja_state[2];
> +    qemu_irq        irq;
> +
> +    char            *model; /* The model that support, only SJA1000 now. *=
/
> +    char            *canbus[2];
> +    char            *host[2];
> +} Pcm3680iPCIState;
> +
> +static void pcm3680i_pci_irq_raise(void *opaque)
> +{
> +    Pcm3680iPCIState *d =3D (Pcm3680iPCIState *)opaque;
> +
> +    qemu_irq_raise(d->irq);
> +}
> +
> +static void pcm3680i_pci_irq_lower(void *opaque)
> +{
> +    Pcm3680iPCIState *d =3D (Pcm3680iPCIState *)opaque;
> +
> +    qemu_irq_lower(d->irq);
> +}
> +
> +static void
> +pcm3680i_pci_reset(void *opaque)
> +{
> +    Pcm3680iPCIState *d =3D (Pcm3680iPCIState *)opaque;
> +    CanSJA1000State *s1 =3D &d->sja_state[0];
> +    CanSJA1000State *s2 =3D &d->sja_state[1];
> +
> +    can_sja_hardware_reset(s1);
> +    can_sja_hardware_reset(s2);
> +}
> +
> +static uint64_t pcm3680i_pci_sja1_io_read(void *opaque, hwaddr addr,
> +                                          unsigned size)
> +{
> +    Pcm3680iPCIState *d =3D opaque;
> +    CanSJA1000State *s =3D &d->sja_state[0];
> +
> +    if (addr >=3D PCM3680i_PCI_BYTES_PER_SJA) {
> +        return 0;
> +    }
> +
> +    return can_sja_mem_read(s, addr, size);
> +}
> +
> +static void pcm3680i_pci_sja1_io_write(void *opaque, hwaddr addr,
> +                                       uint64_t data, unsigned size)
> +{
> +    Pcm3680iPCIState *d =3D opaque;
> +    CanSJA1000State *s =3D &d->sja_state[0];
> +
> +    if (addr >=3D PCM3680i_PCI_BYTES_PER_SJA) {
> +        return;
> +    }
> +
> +    can_sja_mem_write(s, addr, data, size);
> +}
> +
> +static uint64_t pcm3680i_pci_sja2_io_read(void *opaque, hwaddr addr,
> +                                          unsigned size)
> +{
> +    Pcm3680iPCIState *d =3D opaque;
> +    CanSJA1000State *s =3D &d->sja_state[1];
> +
> +    if (addr >=3D PCM3680i_PCI_BYTES_PER_SJA) {
> +        return 0;
> +    }
> +
> +    return can_sja_mem_read(s, addr, size);
> +}
> +
> +static void pcm3680i_pci_sja2_io_write(void *opaque, hwaddr addr, uint64_=
t data,
> +                             unsigned size)
> +{
> +    Pcm3680iPCIState *d =3D opaque;
> +    CanSJA1000State *s =3D &d->sja_state[1];
> +
> +    if (addr >=3D PCM3680i_PCI_BYTES_PER_SJA) {
> +        return;
> +    }
> +
> +    can_sja_mem_write(s, addr, data, size);
> +}
> +
> +static const MemoryRegionOps pcm3680i_pci_sja1_io_ops =3D {
> +    .read =3D pcm3680i_pci_sja1_io_read,
> +    .write =3D pcm3680i_pci_sja1_io_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +};
> +
> +static const MemoryRegionOps pcm3680i_pci_sja2_io_ops =3D {
> +    .read =3D pcm3680i_pci_sja2_io_read,
> +    .write =3D pcm3680i_pci_sja2_io_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +};
> +
> +static int pcm3680i_pci_init(PCIDevice *pci_dev)
> +{
> +    Pcm3680iPCIState *d =3D PCM3680i_PCI_DEV(pci_dev);
> +    CanSJA1000State *s1 =3D &d->sja_state[0];
> +    CanSJA1000State *s2 =3D &d->sja_state[1];
> +    uint8_t *pci_conf;
> +    CanBusState *can_bus1;
> +    CanBusState *can_bus2;
> +
> +    if (d->model) {
> +        if (strncmp(d->model, "pcican-s", 256)) { /* for security reason *=
/
> +            error_report("Can't create CAN device, "
> +                         "the model %s is not supported now.", d->model);=

> +            exit(1);
> +        }
> +    }
> +
> +    can_bus1 =3D can_bus_find_by_name(d->canbus[0], true);
> +    if (can_bus1 =3D=3D NULL) {
> +        error_report("Cannot create can find/allocate CAN bus #1");
> +        exit(1);
> +    }
> +
> +    can_bus2 =3D can_bus_find_by_name(d->canbus[1], true);
> +    if (can_bus2 =3D=3D NULL) {
> +        error_report("Cannot create can find/allocate CAN bus #2");
> +        exit(1);
> +    }
> +
> +    if (d->host[0] !=3D NULL) {
> +        if (can_bus_connect_to_host_device(can_bus1, d->host[0]) < 0) {
> +            error_report("Cannot connect CAN bus to host #1 device \"%s\"=
",
> +                         d->host[0]);
> +            exit(1);
> +        }
> +    }
> +
> +    if (d->host[1] !=3D NULL) {
> +        if (can_bus_connect_to_host_device(can_bus2, d->host[1]) < 0) {
> +            error_report("Cannot connect CAN bus to host #2 device \"%s\"=
",
> +                         d->host[1]);
> +            exit(1);
> +        }
> +    }
> +
> +    pci_conf =3D pci_dev->config;
> +    pci_conf[PCI_INTERRUPT_PIN] =3D 0x01; /* interrupt pin A */
> +
> +    d->irq =3D pci_allocate_irq(&d->dev);
> +
> +    can_sja_init(s1, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
> +    can_sja_init(s2, pcm3680i_pci_irq_raise, pcm3680i_pci_irq_lower, d);
> +
> +    qemu_register_reset(pcm3680i_pci_reset, d);
> +
> +    if (can_sja_connect_to_bus(s1, can_bus1) < 0) {
> +        error_report("can_sja_connect_to_bus failed");
> +        exit(1);
> +    }
> +
> +    if (can_sja_connect_to_bus(s2, can_bus2) < 0) {
> +        error_report("can_sja_connect_to_bus failed");
> +        exit(1);
> +    }
> +
> +    memory_region_init_io(&d->sja_io[0], OBJECT(d), &pcm3680i_pci_sja1_io=
_ops,
> +                          d, "pcm3680i_pci-sja1", PCM3680i_PCI_SJA_RANGE /=
 2);
> +    memory_region_init_io(&d->sja_io[1], OBJECT(d), &pcm3680i_pci_sja2_io=
_ops,
> +                          d, "pcm3680i_pci-sja2", PCM3680i_PCI_SJA_RANGE /=
 2);
> +
> +    pci_register_bar(&d->dev, /*BAR*/ 0, PCI_BASE_ADDRESS_SPACE_IO,
> +                                             &d->sja_io[0]);
> +    pci_register_bar(&d->dev, /*BAR*/ 1, PCI_BASE_ADDRESS_SPACE_IO,
> +                                             &d->sja_io[1]);
> +
> +    return 0;
> +}
> +
> +static void pcm3680i_pci_exit(PCIDevice *pci_dev)
> +{
> +    Pcm3680iPCIState *d =3D PCM3680i_PCI_DEV(pci_dev);
> +    CanSJA1000State *s1 =3D &d->sja_state[0];
> +    CanSJA1000State *s2 =3D &d->sja_state[1];
> +
> +    can_sja_disconnect(s1);
> +    can_sja_disconnect(s2);
> +
> +    qemu_unregister_reset(pcm3680i_pci_reset, d);
> +
> +    /*
> +     * region d->sja_io is destroyed by QOM now
> +     */
> +    /* memory_region_destroy(&d->sja_io[0]); */
> +    /* memory_region_destroy(&d->sja_io[1]); */
> +
> +    can_sja_exit(s1);
> +    can_sja_exit(s2);
> +
> +    qemu_free_irq(d->irq);
> +}
> +
> +static const VMStateDescription vmstate_pcm3680i_pci =3D {
> +    .name =3D "pcm3680i_pci",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .minimum_version_id_old =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(dev, Pcm3680iPCIState),
> +        VMSTATE_STRUCT(sja_state[0], Pcm3680iPCIState, 0,
> +                       vmstate_can_sja, CanSJA1000State),
> +        VMSTATE_STRUCT(sja_state[1], Pcm3680iPCIState, 0,
> +                       vmstate_can_sja, CanSJA1000State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void qdev_pcm3680i_pci_reset(DeviceState *dev)
> +{
> +    Pcm3680iPCIState *d =3D PCM3680i_PCI_DEV(dev);
> +    pcm3680i_pci_reset(d);
> +}
> +
> +static Property pcm3680i_pci_properties[] =3D {
> +    DEFINE_PROP_STRING("canbus1",   Pcm3680iPCIState, canbus[0]),
> +    DEFINE_PROP_STRING("canbus2",   Pcm3680iPCIState, canbus[1]),
> +    DEFINE_PROP_STRING("host1",  Pcm3680iPCIState, host[0]),
> +    DEFINE_PROP_STRING("host2",  Pcm3680iPCIState, host[1]),
> +    DEFINE_PROP_STRING("model", Pcm3680iPCIState, model),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pcm3680i_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> +
> +    k->init =3D pcm3680i_pci_init;
> +    k->exit =3D pcm3680i_pci_exit;
> +    k->vendor_id =3D PCM3680i_PCI_VENDOR_ID1;
> +    k->device_id =3D PCM3680i_PCI_DEVICE_ID1;
> +    k->revision =3D 0x00;
> +    k->class_id =3D 0x000c09;
> +    k->subsystem_vendor_id =3D PCM3680i_PCI_VENDOR_ID1;
> +    k->subsystem_id =3D PCM3680i_PCI_DEVICE_ID1;
> +    dc->desc =3D "Pcm3680i PCICANx";
> +    dc->props =3D pcm3680i_pci_properties;
> +    dc->vmsd =3D &vmstate_pcm3680i_pci;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->reset =3D qdev_pcm3680i_pci_reset;
> +}
> +
> +static const TypeInfo pcm3680i_pci_info =3D {
> +    .name          =3D TYPE_CAN_PCI_DEV,
> +    .parent        =3D TYPE_PCI_DEVICE,
> +    .instance_size =3D sizeof(Pcm3680iPCIState),
> +    .class_init    =3D pcm3680i_pci_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void pcm3680i_pci_register_types(void)
> +{
> +    type_register_static(&pcm3680i_pci_info);
> +}
> +
> +type_init(pcm3680i_pci_register_types)
> --=20
> 2.11.0
>=20
