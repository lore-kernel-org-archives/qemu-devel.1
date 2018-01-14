Received: from eggs.gnu.org ([2001:4830:134:3::10]:36392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eai6y-0003Mt-Hy
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eai6u-00015l-Hk
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:14:08 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eai6u-00015c-D3
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 08:14:04 -0500
Received: by mail-qt0-x242.google.com with SMTP id d4so11264461qtj.5
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 05:14:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09a85810-1af5-e196-6ccb-c1012eb312b8@amsat.org>
Date: Sun, 14 Jan 2018 10:13:47 -0300
MIME-Version: 1.0
In-Reply-To: <20180114104751.21965-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/11] apb: QOMify sabre PCI host bridge
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

Hi Mark,

On 01/14/2018 07:47 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This device is already QOM'ified, but now the QOM abstract inheritance
is clearer, so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/apb.c         |  6 +++---
>  include/hw/pci-host/apb.h | 14 +++++++++++---
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 98c5f344f7..36c6251816 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -407,7 +407,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
>                                       &s->pci_ioport,
>                                       0, 32, TYPE_PCI_BUS);
>  
> -    pci_create_simple(phb->bus, 0, "pbm-pci");
> +    pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
>  
>      /* IOMMU */
>      memory_region_add_subregion_overlap(&s->apb_config, 0x200,
> @@ -498,9 +498,9 @@ static void sabre_pci_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo sabre_pci_info = {
> -    .name          = "pbm-pci",
> +    .name          = TYPE_SABRE_PCI_DEVICE,
>      .parent        = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(PCIDevice),
> +    .instance_size = sizeof(SabrePCIState),
>      .class_init    = sabre_pci_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index 41de012396..470863639a 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -14,9 +14,13 @@
>  #define OBIO_MSE_IRQ         0x2a
>  #define OBIO_SER_IRQ         0x2b
>  
> -#define TYPE_APB "pbm"
> -#define APB_DEVICE(obj) \
> -    OBJECT_CHECK(APBState, (obj), TYPE_APB)
> +typedef struct SabrePCIState {
> +    PCIDevice parent_obj;
> +} SabrePCIState;
> +
> +#define TYPE_SABRE_PCI_DEVICE "sabre-pci"
> +#define SABRE_PCI_DEVICE(obj) \
> +    OBJECT_CHECK(SabrePCIState, (obj), TYPE_SABRE_PCI_DEVICE)
>  
>  typedef struct APBState {
>      PCIHostState parent_obj;
> @@ -41,4 +45,8 @@ typedef struct APBState {
>      unsigned int nr_resets;
>  } APBState;
>  
> +#define TYPE_APB "apb"
> +#define APB_DEVICE(obj) \
> +    OBJECT_CHECK(APBState, (obj), TYPE_APB)
> +
>  #endif
> 
