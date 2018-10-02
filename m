Received: from eggs.gnu.org ([2001:4830:134:3::10]:42408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7S9X-0002AK-9m
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7S9S-0006fS-Bk
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:24:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7S9R-0006f3-EB
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:24:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id z204-v6so2741096wmc.5
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 14:24:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8dc26fdf-eedf-4ca5-e4b4-80148e78da6e@amsat.org>
Date: Tue, 2 Oct 2018 23:24:14 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/15] hw/pci-host/bonito: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 10/2/18 12:09 AM, Philippe Mathieu-Daudé wrote:
> Move from the legacy SysBusDevice::init method to using DeviceState::realize.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/pci-host/bonito.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 9868e2eccc..03d1ec33e3 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -595,7 +595,7 @@ static const VMStateDescription vmstate_bonito = {
>      }
>  };
>  
> -static int bonito_pcihost_initfn(SysBusDevice *dev)
> +static void bonito_pcihost_realize(PCIDevice *dev, Error **errp)

This patch is incorrect, see:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00378.html

>  {
>      PCIHostState *phb = PCI_HOST_BRIDGE(dev);
>  
> @@ -603,8 +603,6 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
>                                       pci_bonito_set_irq, pci_bonito_map_irq,
>                                       dev, get_system_memory(), get_system_io(),
>                                       0x28, 32, TYPE_PCI_BUS);
> -
> -    return 0;
>  }
>  
>  static void bonito_realize(PCIDevice *dev, Error **errp)
> @@ -684,7 +682,6 @@ PCIBus *bonito_init(qemu_irq *pic)
>      pcihost->pic = pic;
>      qdev_init_nofail(dev);
>  
> -    /* set the pcihost pointer before bonito_initfn is called */
>      d = pci_create(phb->bus, PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
>      s = PCI_BONITO(d);
>      s->pcihost = pcihost;
> @@ -726,9 +723,9 @@ static const TypeInfo bonito_info = {
>  
>  static void bonito_pcihost_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->init = bonito_pcihost_initfn;
> +    k->realize = bonito_pcihost_realize;
>  }
>  
>  static const TypeInfo bonito_pcihost_info = {
> 
