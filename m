Received: from eggs.gnu.org ([2001:4830:134:3::10]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eahzO-0007w4-P3
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eahzJ-0003px-O8
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:06:18 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eahzJ-0003po-IW
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:06:13 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so11261219qtj.6
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 05:06:13 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <97191789-6ea6-9484-99f8-1544a2eed4be@amsat.org>
Date: Sun, 14 Jan 2018 10:05:57 -0300
MIME-Version: 1.0
In-Reply-To: <20180114104751.21965-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/11] simba: rename PBMPCIBridge and QOM
 types to reflect simba naming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org

On 01/14/2018 07:47 AM, Mark Cave-Ayland wrote:
> Here we rename PBMPCIBridge to SimbaPCIBridge and the QOM type from
> TYPE_PBM_PCI_BRIDGE to TYPE_SIMBA_PCI_BRIDGE in improve the clarity
> of the device name.
> 
> Also touch up the relevant spots in apb.c and various other function
> names as appropriate.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-bridge/simba.c         | 22 +++++++++++-----------
>  hw/pci-host/apb.c             | 12 ++++++------
>  include/hw/pci-bridge/simba.h | 10 +++++-----
>  3 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
> index 05ba6f0f34..dea4c8c5e7 100644
> --- a/hw/pci-bridge/simba.c
> +++ b/hw/pci-bridge/simba.c
> @@ -36,7 +36,7 @@
>   * http://www.sun.com/processors/manuals/805-1251.pdf
>   */
>  
> -static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
> +static void simba_pci_bridge_realize(PCIDevice *dev, Error **errp)
>  {
>      /*
>       * command register:
> @@ -47,7 +47,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>       *   the reset value should be zero unless the boot pin is tied high
>       *   (which is true) and thus it should be PCI_COMMAND_MEMORY.
>       */
> -    PBMPCIBridge *br = PBM_PCI_BRIDGE(dev);
> +    SimbaPCIBridge *br = SIMBA_PCI_BRIDGE(dev);
>  
>      pci_bridge_initfn(dev, TYPE_PCI_BUS);
>  
> @@ -65,12 +65,12 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>      pci_bridge_update_mappings(PCI_BRIDGE(br));
>  }
>  
> -static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
> +static void simba_pci_bridge_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->realize = apb_pci_bridge_realize;
> +    k->realize = simba_pci_bridge_realize;
>      k->exit = pci_bridge_exitfn;
>      k->vendor_id = PCI_VENDOR_ID_SUN;
>      k->device_id = PCI_DEVICE_ID_SUN_SIMBA;
> @@ -82,20 +82,20 @@ static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
>      dc->vmsd = &vmstate_pci_device;
>  }
>  
> -static const TypeInfo pbm_pci_bridge_info = {
> -    .name          = TYPE_PBM_PCI_BRIDGE,
> +static const TypeInfo simba_pci_bridge_info = {
> +    .name          = TYPE_SIMBA_PCI_BRIDGE,
>      .parent        = TYPE_PCI_BRIDGE,
> -    .class_init    = pbm_pci_bridge_class_init,
> -    .instance_size = sizeof(PBMPCIBridge),
> +    .class_init    = simba_pci_bridge_class_init,
> +    .instance_size = sizeof(SimbaPCIBridge),
>      .interfaces = (InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
>      },
>  };
>  
> -static void pbm_register_types(void)
> +static void simba_register_types(void)
>  {
> -    type_register_static(&pbm_pci_bridge_info);
> +    type_register_static(&simba_pci_bridge_info);
>  }
>  
> -type_init(pbm_register_types)
> +type_init(simba_register_types)
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 3a5c046794..43ee42d170 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -293,7 +293,7 @@ static int pci_apb_map_irq(PCIDevice *pci_dev, int irq_num)
>      return irq_num;
>  }
>  
> -static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
> +static int pci_simbaA_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
>      /* The on-board devices have fixed (legacy) OBIO intnos */
>      switch (PCI_SLOT(pci_dev->devfn)) {
> @@ -311,7 +311,7 @@ static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
>      return ((PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
>  }
>  
> -static int pci_pbmB_map_irq(PCIDevice *pci_dev, int irq_num)
> +static int pci_simbaB_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
>      return (0x10 + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
>  }
> @@ -417,15 +417,15 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
>  
>      /* APB secondary busses */
>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
> -                                   TYPE_PBM_PCI_BRIDGE);
> +                                       TYPE_SIMBA_PCI_BRIDGE);
>      s->bridgeB = PCI_BRIDGE(pci_dev);
> -    pci_bridge_map_irq(s->bridgeB, "pciB", pci_pbmB_map_irq);
> +    pci_bridge_map_irq(s->bridgeB, "pciB", pci_simbaB_map_irq);
>      qdev_init_nofail(&pci_dev->qdev);
>  
>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
> -                                   TYPE_PBM_PCI_BRIDGE);
> +                                       TYPE_SIMBA_PCI_BRIDGE);
>      s->bridgeA = PCI_BRIDGE(pci_dev);
> -    pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbmA_map_irq);
> +    pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
>      qdev_init_nofail(&pci_dev->qdev);
>  }
>  
> diff --git a/include/hw/pci-bridge/simba.h b/include/hw/pci-bridge/simba.h
> index 5ab1330236..fac56ab1cf 100644
> --- a/include/hw/pci-bridge/simba.h
> +++ b/include/hw/pci-bridge/simba.h
> @@ -28,11 +28,11 @@
>  #include "hw/pci/pci_bridge.h"
>  
>  
> -typedef struct PBMPCIBridge {
> +typedef struct SimbaPCIBridge {
>      /*< private >*/
>      PCIBridge parent_obj;
> -} PBMPCIBridge;
> +} SimbaPCIBridge;
>  
> -#define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
> -#define PBM_PCI_BRIDGE(obj) \
> -    OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
> +#define TYPE_SIMBA_PCI_BRIDGE "pbm-bridge"
> +#define SIMBA_PCI_BRIDGE(obj) \
> +    OBJECT_CHECK(SimbaPCIBridge, (obj), TYPE_SIMBA_PCI_BRIDGE)
> 
