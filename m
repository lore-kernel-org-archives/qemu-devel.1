Received: from eggs.gnu.org ([2001:4830:134:3::10]:57037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8PB9-0004aC-EC
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8P7p-0001Hb-5W
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:22:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8P7p-0001HN-0C
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:22:33 -0400
Received: by mail-oi1-x243.google.com with SMTP id s69-v6so10198200oie.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 05:22:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181002212522.23303-7-f4bug@amsat.org>
References: <20181002212522.23303-1-f4bug@amsat.org>
	<20181002212522.23303-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 13:22:11 +0100
Message-ID: <CAFEAcA9pkncFUWfMmjLOYnPp09xFR+eaZc7i9roa+vCGM93V1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/12] hw/pci-host/bonito: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On 2 October 2018 at 22:25, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/bonito.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 9868e2eccc..9f33582706 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -595,7 +595,7 @@ static const VMStateDescription vmstate_bonito =3D {
>      }
>  };
>
> -static int bonito_pcihost_initfn(SysBusDevice *dev)
> +static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
>  {
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
>
> @@ -603,8 +603,6 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
>                                       pci_bonito_set_irq, pci_bonito_map_=
irq,
>                                       dev, get_system_memory(), get_syste=
m_io(),
>                                       0x28, 32, TYPE_PCI_BUS);
> -
> -    return 0;
>  }
>
>  static void bonito_realize(PCIDevice *dev, Error **errp)
> @@ -684,7 +682,6 @@ PCIBus *bonito_init(qemu_irq *pic)
>      pcihost->pic =3D pic;
>      qdev_init_nofail(dev);
>
> -    /* set the pcihost pointer before bonito_initfn is called */
>      d =3D pci_create(phb->bus, PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
>      s =3D PCI_BONITO(d);
>      s->pcihost =3D pcihost;
> @@ -726,9 +723,9 @@ static const TypeInfo bonito_info =3D {
>
>  static void bonito_pcihost_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    k->init =3D bonito_pcihost_initfn;
> +    dc->realize =3D bonito_pcihost_realize;
>  }
>
>  static const TypeInfo bonito_pcihost_info =3D {
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
