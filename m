Received: from eggs.gnu.org ([209.51.188.92]:35154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLtz-0003dX-8G
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLmk-0000DP-MN
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:18:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtLmk-0000AQ-BC
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 19:18:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so1104587wmh.3
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 16:18:48 -0800 (PST)
References: <cover.1549857716.git.balaton@eik.bme.hu>
	<e26ca956807437844403d835cb2d67bf306244fd.1549857716.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <16772f2f-51a5-c4f2-9da2-df1b30380050@redhat.com>
Date: Tue, 12 Feb 2019 01:18:44 +0100
MIME-Version: 1.0
In-Reply-To: <e26ca956807437844403d835cb2d67bf306244fd.1549857716.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/pci-host/bonito.c: Add PCI mem
 region mapped at the correct address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Huacai Chen <zltjiangshi@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2/11/19 5:01 AM, BALATON Zoltan wrote:
> Stop using system memory as PCI memory otherwise devices such as VGA
> that have regions mapped to PCI memory clash with RAM. Use a separate
> memory region for PCI memory and map it to the correct address in
> system memory which allows PCI mem regions to show at the correct
> address where clients expect them.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/pci-host/bonito.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 9f33582706..c940ec6e48 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -598,11 +598,14 @@ static const VMStateDescription vmstate_bonito = {
>  static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
>  {
>      PCIHostState *phb = PCI_HOST_BRIDGE(dev);
> +    MemoryRegion *mr = g_new0(MemoryRegion, 1);

No need to alloc, move that to BonitoState, see [*].

>  
> +    memory_region_init(mr, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
>      phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
>                                       pci_bonito_set_irq, pci_bonito_map_irq,
> -                                     dev, get_system_memory(), get_system_io(),
> +                                     dev, mr, get_system_io(),
>                                       0x28, 32, TYPE_PCI_BUS);
> +    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE, mr);
>  }
>  
>  static void bonito_realize(PCIDevice *dev, Error **errp)
> 

[*]:
-- >8 --
@@ -217,6 +217,7 @@ struct BonitoState {
     PCIHostState parent_obj;
     qemu_irq *pic;
     PCIBonitoState *pci_dev;
+    MemoryRegion pci_mmio;
 };

 #define TYPE_BONITO_PCI_HOST_BRIDGE "Bonito-pcihost"
@@ -598,14 +599,15 @@ static const VMStateDescription vmstate_bonito = {
 static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
-    MemoryRegion *mr = g_new0(MemoryRegion, 1);
+    BonitoState *s = BONITO_PCI_HOST_BRIDGE(dev);

-    memory_region_init(mr, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
+    memory_region_init(&s->pci_mmio, OBJECT(dev), "pci.mem",
BONITO_PCILO_SIZE);
     phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
                                      pci_bonito_set_irq,
pci_bonito_map_irq,
-                                     dev, mr, get_system_io(),
+                                     dev, &s->pci_mmio, get_system_io(),
                                      0x28, 32, TYPE_PCI_BUS);
-    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE,
mr);
+    memory_region_add_subregion(get_system_memory(),
+                                BONITO_PCILO_BASE, &s->pci_mmio);
 }
---

Using snippet:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
