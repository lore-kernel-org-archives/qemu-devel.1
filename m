Received: from eggs.gnu.org ([2001:4830:134:3::10]:49429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFhif-0004G9-HG
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eFhie-00019a-4r
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:34:13 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:45594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eFhid-00018X-Vm
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:34:12 -0500
Received: by mail-io0-x241.google.com with SMTP id z74so8920261iof.12
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 06:34:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-12-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-12-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 17 Nov 2017 15:33:50 +0100
Message-ID: <CACXAS8D7kJ7sk3Z+72-PaUnWwLUK7Xwb1_zHUjQe0BXBaYoKyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 11/15] apb: split pci_pbm_map_irq() into
 separate functions for bus A and bus B
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Nov 17, 2017 at 2:42 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> After the previous refactoring it is now possible to use separate functions
> to improve clarity of the interrupt paths. Similarly by checking the PCI
> devnfn to identify busA during apb_pci_bridge_realize() it becomes possible
> to completely remove the busA property from the PBMPCIBridge state.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci-host/apb.c         |   54 ++++++++++++++++++---------------------------
>  include/hw/pci-host/apb.h |    3 ---
>  2 files changed, 21 insertions(+), 36 deletions(-)
>
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 6c20285..268100e 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -517,32 +517,27 @@ static int pci_apb_map_irq(PCIDevice *pci_dev, int irq_num)
>      return irq_num;
>  }
>
> -static int pci_pbm_map_irq(PCIDevice *pci_dev, int irq_num)
> +static int pci_pbmA_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
> -    PBMPCIBridge *br = PBM_PCI_BRIDGE(pci_bridge_get_device(
> -                           PCI_BUS(qdev_get_parent_bus(DEVICE(pci_dev)))));
> -
> -    int bus_offset;
> -    if (br->busA) {
> -        bus_offset = 0x0;
> +    /* The on-board devices have fixed (legacy) OBIO intnos */
> +    switch (PCI_SLOT(pci_dev->devfn)) {
> +    case 1:
> +        /* Onboard NIC */
> +        return 0x21;
> +    case 3:
> +        /* Onboard IDE */
> +        return 0x20;
> +    default:
> +        /* Normal intno, fall through */
> +        break;
> +    }
>
> -        /* The on-board devices have fixed (legacy) OBIO intnos */
> -        switch (PCI_SLOT(pci_dev->devfn)) {
> -        case 1:
> -            /* Onboard NIC */
> -            return 0x21;
> -        case 3:
> -            /* Onboard IDE */
> -            return 0x20;
> +    return ((PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
> +}
>
> -        default:
> -            /* Normal intno, fall through */
> -            break;
> -        }
> -    } else {
> -        bus_offset = 0x10;
> -    }
> -    return (bus_offset + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
> +static int pci_pbmB_map_irq(PCIDevice *pci_dev, int irq_num)
> +{
> +    return (0x10 + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
>  }
>
>  static void pci_apb_set_irq(void *opaque, int irq_num, int level)
> @@ -593,7 +588,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>
>      /* If initialising busA, ensure that we allow IO transactions so that
>         we get the early serial console until OpenBIOS configures the bridge */
> -    if (br->busA) {
> +    if (dev->devfn == PCI_DEVFN(1, 1)) {

I think the previous syntax was more explicit here. A comment would be nice.


>          cmd |= PCI_COMMAND_IO;
>      }
>
> @@ -673,14 +668,13 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
>                                     TYPE_PBM_PCI_BRIDGE);
>      s->bridgeB = PCI_BRIDGE(pci_dev);
> -    pci_bridge_map_irq(s->bridgeB, "pciB", pci_pbm_map_irq);
> +    pci_bridge_map_irq(s->bridgeB, "pciB", pci_pbmB_map_irq);
>      qdev_init_nofail(&pci_dev->qdev);
>
>      pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
>                                     TYPE_PBM_PCI_BRIDGE);
>      s->bridgeA = PCI_BRIDGE(pci_dev);
> -    pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbm_map_irq);
> -    qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
> +    pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbmA_map_irq);
>      qdev_init_nofail(&pci_dev->qdev);
>  }
>
> @@ -789,11 +783,6 @@ static const TypeInfo pbm_host_info = {
>      .class_init    = pbm_host_class_init,
>  };
>
> -static Property pbm_pci_properties[] = {
> -    DEFINE_PROP_BOOL("busA", PBMPCIBridge, busA, false),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -809,7 +798,6 @@ static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->reset = pci_bridge_reset;
>      dc->vmsd = &vmstate_pci_device;
> -    dc->props = pbm_pci_properties;
>  }
>
>  static const TypeInfo pbm_pci_bridge_info = {
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index f0074f7..dd49437 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -86,9 +86,6 @@ typedef struct APBState {
>  typedef struct PBMPCIBridge {
>      /*< private >*/
>      PCIBridge parent_obj;
> -
> -    /* Is this busA with in-built devices (ebus)? */
> -    bool busA;
>  } PBMPCIBridge;
>
>  #define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
