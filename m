Received: from eggs.gnu.org ([2001:4830:134:3::10]:41815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRxuE-0001uz-Rp
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eRxuA-0002KV-Dw
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:16:50 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:41454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eRxuA-0002Jx-7G
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 05:16:46 -0500
Received: by mail-io0-x241.google.com with SMTP id o2so20478592ioe.8
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 02:16:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221082045.14022-13-mark.cave-ayland@ilande.co.uk>
References: <20171221082045.14022-1-mark.cave-ayland@ilande.co.uk>
	<20171221082045.14022-13-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Thu, 21 Dec 2017 11:16:25 +0100
Message-ID: <CACXAS8CZyx7eEph4iCddbuNqO2xz-33OX9fFbuktsygQ3tQpzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv3 12/16] apb: remove busA property from
 PBMPCIBridge state
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

On Thu, Dec 21, 2017 at 9:20 AM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Since the previous commit the only remaining use of the qdev busA property is
> to configure the PCI bridge in front of the onboard ebus devices differently
> to allow early OpenBIOS serial console access.
>
> Instead we can now manually update the PCI configuration for bridge A in
> pci_pbm_reset() and thus completely remove the busA property from the
> PBMPCIBridge state.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/pci-host/apb.c         | 29 +++++++++++++----------------
>  include/hw/pci-host/apb.h |  3 ---
>  2 files changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 3ebb9dc304..53de1c93c1 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -581,18 +581,11 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>       *   the reset value should be zero unless the boot pin is tied high
>       *   (which is true) and thus it should be PCI_COMMAND_MEMORY.
>       */
> -    uint16_t cmd = PCI_COMMAND_MEMORY;
>      PBMPCIBridge *br = PBM_PCI_BRIDGE(dev);
>
>      pci_bridge_initfn(dev, TYPE_PCI_BUS);
>
> -    /* If initialising busA, ensure that we allow IO transactions so that
> -       we get the early serial console until OpenBIOS configures the bridge */
> -    if (br->busA) {
> -        cmd |= PCI_COMMAND_IO;
> -    }
> -
> -    pci_set_word(dev->config + PCI_COMMAND, cmd);
> +    pci_set_word(dev->config + PCI_COMMAND, PCI_COMMAND_MEMORY);
>      pci_set_word(dev->config + PCI_STATUS,
>                   PCI_STATUS_FAST_BACK | PCI_STATUS_66MHZ |
>                   PCI_STATUS_DEVSEL_MEDIUM);
> @@ -608,8 +601,10 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>
>  static void pci_pbm_reset(DeviceState *d)
>  {
> -    unsigned int i;
>      APBState *s = APB_DEVICE(d);
> +    PCIDevice *pci_dev;
> +    unsigned int i;
> +    uint16_t cmd;
>
>      for (i = 0; i < 8; i++) {
>          s->pci_irq_map[i] &= PBM_PCI_IMR_MASK;
> @@ -625,6 +620,15 @@ static void pci_pbm_reset(DeviceState *d)
>          /* Power on reset */
>          s->reset_control = POR;
>      }
> +
> +    /* As this is the busA PCI bridge which contains the on-board devices
> +     * attached to the ebus, ensure that we initially allow IO transactions
> +     * so that we get the early serial console until OpenBIOS can properly
> +     * configure the PCI bridge itself */
> +    pci_dev = PCI_DEVICE(s->bridgeA);
> +    cmd = pci_get_word(pci_dev->config + PCI_COMMAND);
> +    pci_set_word(pci_dev->config + PCI_COMMAND, cmd | PCI_COMMAND_IO);
> +    pci_bridge_update_mappings(PCI_BRIDGE(pci_dev));
>  }
>
>  static const MemoryRegionOps pci_config_ops = {
> @@ -675,7 +679,6 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
>                                     TYPE_PBM_PCI_BRIDGE);
>      s->bridgeA = PCI_BRIDGE(pci_dev);
>      pci_bridge_map_irq(s->bridgeA, "pciA", pci_pbmA_map_irq);
> -    qdev_prop_set_bit(DEVICE(pci_dev), "busA", true);
>      qdev_init_nofail(&pci_dev->qdev);
>  }
>
> @@ -784,11 +787,6 @@ static const TypeInfo pbm_host_info = {
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
> @@ -804,7 +802,6 @@ static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->reset = pci_bridge_reset;
>      dc->vmsd = &vmstate_pci_device;
> -    dc->props = pbm_pci_properties;
>  }
>
>  static const TypeInfo pbm_pci_bridge_info = {
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index f0074f7a51..dd49437ff1 100644
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
> 2.11.0
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
