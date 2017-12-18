Received: from eggs.gnu.org ([2001:4830:134:3::10]:37768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQpWu-0008Uk-Fj
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eQpWp-0004ss-TO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:08:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eQpWp-0004sU-My
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:07:59 -0500
References: <20171217204912.12420-1-f4bug@amsat.org>
	<20171217204912.12420-5-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <00f819e6-4253-7f74-f3a5-cbe1059b3d2c@redhat.com>
Date: Mon, 18 Dec 2017 09:07:52 +0200
MIME-Version: 1.0
In-Reply-To: <20171217204912.12420-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/pci: remove obsolete
 PCIDevice->init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On 17/12/2017 22:49, Philippe Mathieu-Daud=C3=A9 wrote:
> All PCI devices are now QOM'ified.
>=20

Finally!


> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   include/hw/pci/pci.h |  1 -
>   hw/pci/pci.c         | 14 --------------
>   2 files changed, 15 deletions(-)
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 8d02a0a383..0f1ed64c2f 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -217,7 +217,6 @@ typedef struct PCIDeviceClass {
>       DeviceClass parent_class;
>  =20
>       void (*realize)(PCIDevice *dev, Error **errp);
> -    int (*init)(PCIDevice *dev);/* TODO convert to realize() and remov=
e */
>       PCIUnregisterFunc *exit;
>       PCIConfigReadFunc *config_read;
>       PCIConfigWriteFunc *config_write;
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b2d139bd9a..cd25ab6f6b 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2054,18 +2054,6 @@ static void pci_qdev_realize(DeviceState *qdev, =
Error **errp)
>       }
>   }
>  =20
> -static void pci_default_realize(PCIDevice *dev, Error **errp)
> -{
> -    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
> -
> -    if (pc->init) {
> -        if (pc->init(dev) < 0) {
> -            error_setg(errp, "Device initialization failed");
> -            return;
> -        }
> -    }
> -}
> -
>   PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool mult=
ifunction,
>                                       const char *name)
>   {
> @@ -2538,13 +2526,11 @@ MemoryRegion *pci_address_space_io(PCIDevice *d=
ev)
>   static void pci_device_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *k =3D DEVICE_CLASS(klass);
> -    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(klass);
>  =20
>       k->realize =3D pci_qdev_realize;
>       k->unrealize =3D pci_qdev_unrealize;
>       k->bus_type =3D TYPE_PCI_BUS;
>       k->props =3D pci_props;
> -    pc->realize =3D pci_default_realize;
>   }
>  =20
>   static void pci_device_class_base_init(ObjectClass *klass, void *data=
)
>=20

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
