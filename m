Received: from eggs.gnu.org ([2001:4830:134:3::10]:47629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dwUPZ-0004f9-Nc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dwUPT-0006Ox-JT
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 10:31:05 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-5-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8a52b6be-ce55-307f-2bba-85858f739210@redhat.com>
Date: Mon, 25 Sep 2017 17:30:35 +0300
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 27/34] hw/pci: declare
 pci_nic_init_nofail() in "hw/net/pci.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Hi Philippe,

It seems the patch is doing much more than
what is mentioned in the subject.

On 22/09/2017 19:01, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/pci/pci_internal.h | 16 +++++++++++
>   include/hw/net/pci.h  | 20 +++++++++++++
>   include/hw/pci/pci.h  |  4 ---
>   hw/arm/virt.c         |  1 +
>   hw/mips/mips_malta.c  |  1 +
>   hw/pci/pci.c          | 67 ++----------------------------------------=
--
>   hw/pci/pci_nic.c      | 77 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   hw/ppc/e500.c         |  1 +
>   hw/ppc/spapr.c        |  1 +
>   hw/pci/Makefile.objs  |  1 +
>   10 files changed, 120 insertions(+), 69 deletions(-)
>   create mode 100644 hw/pci/pci_internal.h
>   create mode 100644 include/hw/net/pci.h
>   create mode 100644 hw/pci/pci_nic.c
>=20
> diff --git a/hw/pci/pci_internal.h b/hw/pci/pci_internal.h
> new file mode 100644
> index 0000000000..d967468767
> --- /dev/null
> +++ b/hw/pci/pci_internal.h
> @@ -0,0 +1,16 @@
> +/*
> + * QEMU PCI internal
> + *
> + * Copyright (c) 2005 Fabrice Bellard
> + * > + * This work is licensed under the terms of the GNU GPL, version=
 2=20
or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef QEMU_HW_PCI_INTERNAL_H
> +#define QEMU_HW_PCI_INTERNAL_H
> +
> +#include "hw/pci/pci_bus.h"
> +
> +PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root, const char *devad=
dr);
> +
> +#endif

Why don't add the function directly to hw/pci/pci_nic.c ?
We have only one calling site anyway.

I have nothing against adding an internal H file, but then
we would need to add there *all* the functions used
only by the pci sub-system. And that may be out of the scope
of your series.




> diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
> new file mode 100644
> index 0000000000..529591b7f3
> --- /dev/null
> +++ b/include/hw/net/pci.h
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU network devices
> + *
> + * Copyright (c) 2005 Fabrice Bellard
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef QEMU_HW_NET_PCI_H
> +#define QEMU_HW_NET_PCI_H
> +
> +#include "net/net.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_bus.h"
> +
> +PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
> +                               const char *default_model,
> +                               const char *default_devaddr);
> +

Can you add a short explanation on how the split
helps removing i386/pc dependency from non-PC world?
- it is not straight forward, at least for me.


Thanks,
Marcel

> +#endif
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index aa7ef9cf69..6a0f7b5472 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -422,10 +422,6 @@ void pci_device_set_intx_routing_notifier(PCIDevic=
e *dev,
>                                             PCIINTxRoutingNotifier noti=
fier);
>   void pci_device_reset(PCIDevice *dev);
>  =20
> -PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
> -                               const char *default_model,
> -                               const char *default_devaddr);
> -
>   PCIDevice *pci_vga_init(PCIBus *bus);
>  =20
>   int pci_bus_num(PCIBus *s);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9e18b410d7..39fab3acb9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -35,6 +35,7 @@
>   #include "hw/arm/primecell.h"
>   #include "hw/arm/virt.h"
>   #include "hw/devices.h"
> +#include "hw/net/pci.h"
>   #include "net/net.h"
>   #include "sysemu/block-backend.h"
>   #include "sysemu/device_tree.h"
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 6945fa47c3..fb6a2f9363 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -48,6 +48,7 @@
>   #include "hw/timer/mc146818rtc.h"
>   #include "hw/input/i8042.h"
>   #include "hw/timer/i8254.h"
> +#include "hw/net/pci.h"
>   #include "sysemu/blockdev.h"
>   #include "exec/address-spaces.h"
>   #include "hw/sysbus.h"             /* SysBusDevice */
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88eba..9b678c8fd0 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -28,7 +28,6 @@
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci_host.h"
>   #include "monitor/monitor.h"
> -#include "net/net.h"
>   #include "sysemu/sysemu.h"
>   #include "hw/loader.h"
>   #include "qemu/error-report.h"
> @@ -41,6 +40,7 @@
>   #include "hw/hotplug.h"
>   #include "hw/boards.h"
>   #include "qemu/cutils.h"
> +#include "pci_internal.h"
>  =20
>   //#define DEBUG_PCI
>   #ifdef DEBUG_PCI
> @@ -671,8 +671,7 @@ static int pci_parse_devaddr(const char *addr, int =
*domp, int *busp,
>       return 0;
>   }
>  =20
> -static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root,
> -                                 const char *devaddr)
> +PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root, const char *devad=
dr)
>   {
>       int dom, bus;
>       unsigned slot;
> @@ -1812,68 +1811,6 @@ PciInfoList *qmp_query_pci(Error **errp)
>       return head;
>   }
>  =20
> -static const char * const pci_nic_models[] =3D {
> -    "ne2k_pci",
> -    "i82551",
> -    "i82557b",
> -    "i82559er",
> -    "rtl8139",
> -    "e1000",
> -    "pcnet",
> -    "virtio",
> -    "sungem",
> -    NULL
> -};
> -
> -static const char * const pci_nic_names[] =3D {
> -    "ne2k_pci",
> -    "i82551",
> -    "i82557b",
> -    "i82559er",
> -    "rtl8139",
> -    "e1000",
> -    "pcnet",
> -    "virtio-net-pci",
> -    "sungem",
> -    NULL
> -};
> -
> -/* Initialize a PCI NIC.  */
> -PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
> -                               const char *default_model,
> -                               const char *default_devaddr)
> -{
> -    const char *devaddr =3D nd->devaddr ? nd->devaddr : default_devadd=
r;
> -    PCIBus *bus;
> -    PCIDevice *pci_dev;
> -    DeviceState *dev;
> -    int devfn;
> -    int i;
> -
> -    if (qemu_show_nic_models(nd->model, pci_nic_models)) {
> -        exit(0);
> -    }
> -
> -    i =3D qemu_find_nic_model(nd, pci_nic_models, default_model);
> -    if (i < 0) {
> -        exit(1);
> -    }
> -
> -    bus =3D pci_get_bus_devfn(&devfn, rootbus, devaddr);
> -    if (!bus) {
> -        error_report("Invalid PCI device address %s for device %s",
> -                     devaddr, pci_nic_names[i]);
> -        exit(1);
> -    }
> -
> -    pci_dev =3D pci_create(bus, devfn, pci_nic_names[i]);
> -    dev =3D &pci_dev->qdev;
> -    qdev_set_nic_properties(dev, nd);
> -    qdev_init_nofail(dev);
> -
> -    return pci_dev;
> -}
> -
>   PCIDevice *pci_vga_init(PCIBus *bus)
>   {
>       switch (vga_interface_type) {
> diff --git a/hw/pci/pci_nic.c b/hw/pci/pci_nic.c
> new file mode 100644
> index 0000000000..fb1a10ff12
> --- /dev/null
> +++ b/hw/pci/pci_nic.c
> @@ -0,0 +1,77 @@
> +/*
> + * QEMU PCI network interface
> + *
> + * Copyright (c) 2004 Fabrice Bellard
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/net/pci.h"
> +#include "net/net.h"
> +#include "pci_internal.h"
> +
> +static const char *const pci_nic_models[] =3D {
> +    "ne2k_pci",
> +    "i82551",
> +    "i82557b",
> +    "i82559er",
> +    "rtl8139",
> +    "e1000",
> +    "pcnet",
> +    "virtio",
> +    "sungem",
> +    NULL
> +};
> +
> +static const char *const pci_nic_names[] =3D {
> +    "ne2k_pci",
> +    "i82551",
> +    "i82557b",
> +    "i82559er",
> +    "rtl8139",
> +    "e1000",
> +    "pcnet",
> +    "virtio-net-pci",
> +    "sungem",
> +    NULL
> +};
> +
> +/* Initialize a PCI NIC.  */
> +PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
> +                               const char *default_model,
> +                               const char *default_devaddr)
> +{
> +    const char *devaddr =3D nd->devaddr ? nd->devaddr : default_devadd=
r;
> +    PCIBus *bus;
> +    PCIDevice *pci_dev;
> +    DeviceState *dev;
> +    int devfn;
> +    int i;
> +
> +    if (qemu_show_nic_models(nd->model, pci_nic_models)) {
> +        exit(0);
> +    }
> +
> +    i =3D qemu_find_nic_model(nd, pci_nic_models, default_model);
> +    if (i < 0) {
> +        exit(1);
> +    }
> +
> +    bus =3D pci_get_bus_devfn(&devfn, rootbus, devaddr);
> +    if (!bus) {
> +        error_report("Invalid PCI device address %s for device %s",
> +                     devaddr, pci_nic_names[i]);
> +        exit(1);
> +    }
> +
> +    pci_dev =3D pci_create(bus, devfn, pci_nic_names[i]);
> +    dev =3D &pci_dev->qdev;
> +    qdev_set_nic_properties(dev, nd);
> +    qdev_init_nofail(dev);
> +
> +    return pci_dev;
> +}
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index db0e49ab8f..482757ca7b 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -24,6 +24,7 @@
>   #include "hw/hw.h"
>   #include "hw/char/serial.h"
>   #include "hw/pci/pci.h"
> +#include "hw/net/pci.h"
>   #include "hw/boards.h"
>   #include "sysemu/sysemu.h"
>   #include "sysemu/kvm.h"
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 17ea77618c..96007051e2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -56,6 +56,7 @@
>   #include "hw/pci-host/spapr.h"
>   #include "hw/ppc/xics.h"
>   #include "hw/pci/msi.h"
> +#include "hw/net/pci.h"
>  =20
>   #include "hw/pci/pci.h"
>   #include "hw/scsi/scsi.h"
> diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
> index 9f905e6344..125428fd54 100644
> --- a/hw/pci/Makefile.objs
> +++ b/hw/pci/Makefile.objs
> @@ -1,4 +1,5 @@
>   common-obj-$(CONFIG_PCI) +=3D pci.o pci_bridge.o
> +common-obj-$(CONFIG_PCI) +=3D pci_nic.o
>   common-obj-$(CONFIG_PCI) +=3D msix.o msi.o
>   common-obj-$(CONFIG_PCI) +=3D shpc.o
>   common-obj-$(CONFIG_PCI) +=3D slotid_cap.o
>=20
