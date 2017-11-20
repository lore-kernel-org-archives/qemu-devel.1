Received: from eggs.gnu.org ([2001:4830:134:3::10]:35045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaGO-0003fK-Oq
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaGN-0002oU-Vk
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:48:40 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGaGN-0002oI-Qk
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 19:48:39 -0500
Received: by mail-qk0-x242.google.com with SMTP id p19so5618156qke.2
	for <qemu-devel@nongnu.org>; Sun, 19 Nov 2017 16:48:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-7-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b0b4e243-fc18-639c-a891-e0522ebd02d4@amsat.org>
Date: Sun, 19 Nov 2017 21:48:36 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-7-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/15] apb: APB QOMify tidy-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> Use DeviceClass rather than SysBusDeviceClass in pbm_host_class_init() and
> adjust pci_pbm_init_device() accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/apb.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index b0f80f6..c7837ef 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -705,12 +705,12 @@ static const MemoryRegionOps pci_config_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> -static int pci_pbm_init_device(SysBusDevice *dev)
> +static int pci_pbm_init_device(DeviceState *dev)
>  {
> -    APBState *s;
> +    APBState *s = APB_DEVICE(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
>      unsigned int i;
>  
> -    s = APB_DEVICE(dev);
>      for (i = 0; i < 8; i++) {
>          s->pci_irq_map[i] = (0x1f << 6) | (i << 2);
>      }
> @@ -728,18 +728,18 @@ static int pci_pbm_init_device(SysBusDevice *dev)
>      memory_region_init_io(&s->apb_config, OBJECT(s), &apb_config_ops, s,
>                            "apb-config", 0x10000);
>      /* at region 0 */
> -    sysbus_init_mmio(dev, &s->apb_config);
> +    sysbus_init_mmio(sbd, &s->apb_config);
>  
>      memory_region_init_io(&s->pci_config, OBJECT(s), &pci_config_ops, s,
>                            "apb-pci-config", 0x1000000);
>      /* at region 1 */
> -    sysbus_init_mmio(dev, &s->pci_config);
> +    sysbus_init_mmio(sbd, &s->pci_config);
>  
>      /* pci_ioport */
>      memory_region_init(&s->pci_ioport, OBJECT(s), "apb-pci-ioport", 0x1000000);
>  
>      /* at region 2 */
> -    sysbus_init_mmio(dev, &s->pci_ioport);
> +    sysbus_init_mmio(sbd, &s->pci_ioport);
>  
>      return 0;
>  }
> @@ -783,11 +783,10 @@ static const TypeInfo pbm_pci_host_info = {
>  static void pbm_host_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>  
> -    k->init = pci_pbm_init_device;
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->init = pci_pbm_init_device;
>      dc->reset = pci_pbm_reset;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
>  
>  static const TypeInfo pbm_host_info = {
> 
