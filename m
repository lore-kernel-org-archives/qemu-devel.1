Received: from eggs.gnu.org ([2001:4830:134:3::10]:35811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eFm0N-0007ph-8t
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eFm0K-0004KR-2b
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:08:47 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eFm0J-0004KB-Se
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:08:43 -0500
Received: by mail-qt0-x244.google.com with SMTP id n32so8097000qtb.2
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 11:08:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-8-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4b7c7011-9041-e5c6-7514-811b6c426794@amsat.org>
Date: Fri, 17 Nov 2017 16:08:25 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-8-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/15] apb: return APBState from
 pci_apb_init() rather then PCIBus
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

"rather then PCIBus" -> "rather than PCIBus"

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> This is a first step towards removing pci_apb_init() completely.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/apb.c         |    8 ++++----
>  hw/sparc64/sun4u.c        |    6 ++++--
>  include/hw/pci-host/apb.h |    6 +++---
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index c7837ef..0c70999 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -612,9 +612,9 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>      pci_bridge_update_mappings(PCI_BRIDGE(br));
>  }
>  
> -PCIBus *pci_apb_init(hwaddr special_base,
> -                     hwaddr mem_base,
> -                     qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB)
> +APBState *pci_apb_init(hwaddr special_base,
> +                       hwaddr mem_base,
> +                       qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -675,7 +675,7 @@ PCIBus *pci_apb_init(hwaddr special_base,
>      qdev_init_nofail(&pci_dev->qdev);
>      *busA = pci_bridge_get_sec_bus(br);
>  
> -    return phb->bus;
> +    return d;
>  }
>  
>  static void pci_pbm_reset(DeviceState *d)
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index b441f1e..a64ddc5 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -482,6 +482,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      Nvram *nvram;
>      unsigned int i;
>      uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
> +    APBState *apb;
>      PCIBus *pci_bus, *pci_busA, *pci_busB;
>      PCIDevice *ebus, *pci_dev;
>      SysBusDevice *s;
> @@ -502,8 +503,9 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      prom_init(hwdef->prom_addr, bios_name);
>  
>      ivec_irqs = qemu_allocate_irqs(sparc64_cpu_set_ivec_irq, cpu, IVEC_MAX);
> -    pci_bus = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_busA,
> -                           &pci_busB);
> +    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_busA,
> +                       &pci_busB);
> +    pci_bus = PCI_HOST_BRIDGE(apb)->bus;
>  
>      /* Only in-built Simba PBMs can exist on the root bus, slot 0 on busA is
>         reserved (leaving no slots free after on-board devices) however slots
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index 35d7d5a..a4ef51a 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -89,7 +89,7 @@ typedef struct PBMPCIBridge {
>  #define PBM_PCI_BRIDGE(obj) \
>      OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
>  
> -PCIBus *pci_apb_init(hwaddr special_base,
> -                     hwaddr mem_base,
> -                     qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3);
> +APBState *pci_apb_init(hwaddr special_base,
> +                       hwaddr mem_base,
> +                       qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3);
>  #endif
> 
