Received: from eggs.gnu.org ([2001:4830:134:3::10]:57452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8PC3-0005Cf-DR
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8OyN-0001Ep-Qj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:12:48 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8OyN-0001D6-FP
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:12:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id o13-v6so12464106otl.4
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 05:12:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181002212522.23303-6-f4bug@amsat.org>
References: <20181002212522.23303-1-f4bug@amsat.org>
	<20181002212522.23303-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 13:12:26 +0100
Message-ID: <CAFEAcA-Z=7ufWJ5bsDYL9f+Ek4NsUSA2Dt8C42DCGE9d0MhpOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/12] hw/sh4/sh_pci: Use
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2 October 2018 at 22:25, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sh4/sh_pci.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index 4ec2e35500..379d0685ed 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -120,16 +120,15 @@ static void sh_pci_set_irq(void *opaque, int irq_nu=
m, int level)
>      qemu_set_irq(pic[irq_num], level);
>  }
>
> -static int sh_pci_device_init(SysBusDevice *dev)
> +static void sh_pci_device_realize(DeviceState *dev, Error **errp)
>  {
> -    PCIHostState *phb;
> -    SHPCIState *s;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    SHPCIState *s =3D SH_PCI_HOST_BRIDGE(dev);
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
>      int i;
>
> -    s =3D SH_PCI_HOST_BRIDGE(dev);
> -    phb =3D PCI_HOST_BRIDGE(s);
>      for (i =3D 0; i < 4; i++) {
> -        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_init_irq(sbd, &s->irq[i]);
>      }
>      phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
>                                       sh_pci_set_irq, sh_pci_map_irq,
> @@ -143,13 +142,12 @@ static int sh_pci_device_init(SysBusDevice *dev)
>                               &s->memconfig_p4, 0, 0x224);
>      memory_region_init_alias(&s->isa, OBJECT(s), "sh_pci.isa",
>                               get_system_io(), 0, 0x40000);
> -    sysbus_init_mmio(dev, &s->memconfig_p4);
> -    sysbus_init_mmio(dev, &s->memconfig_a7);
> +    sysbus_init_mmio(sbd, &s->memconfig_p4);
> +    sysbus_init_mmio(sbd, &s->memconfig_a7);
>      s->iobr =3D 0xfe240000;
>      memory_region_add_subregion(get_system_memory(), s->iobr, &s->isa);
>
>      s->dev =3D pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host=
");
> -    return 0;
>  }
>
>  static void sh_pci_host_realize(PCIDevice *d, Error **errp)
> @@ -187,9 +185,9 @@ static const TypeInfo sh_pci_host_info =3D {
>
>  static void sh_pci_device_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sdc =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    sdc->init =3D sh_pci_device_init;
> +    dc->realize =3D sh_pci_device_realize;
>  }
>
>  static const TypeInfo sh_pci_device_info =3D {
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
