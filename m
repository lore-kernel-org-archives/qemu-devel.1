Received: from eggs.gnu.org ([2001:4830:134:3::10]:35456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dVDf4-0006nZ-6W
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dVDf3-0006cE-3f
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:10:22 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1dVDf2-0006Rr-Ue
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:10:21 -0400
Received: by mail-oi0-x243.google.com with SMTP id n2so2188823oig.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:09:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499810007-28613-6-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499810007-28613-6-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 12 Jul 2017 11:09:37 +0200
Message-ID: <CACXAS8CoGeihXR8LDk7QHBr1RJK3j2AJx5TNXTXYwsHTJinoHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/8] apb: fix endianness for APB and PCI
 config accesses
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

On Tue, Jul 11, 2017 at 11:53 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci-host/apb.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 622c341..5ad7678 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -561,7 +561,7 @@ static uint64_t apb_config_readl (void *opaque,
>  static const MemoryRegionOps apb_config_ops = {
>      .read = apb_config_readl,
>      .write = apb_config_writel,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_BIG_ENDIAN,

Is this correct? I thought all the PCI config registers are always
little-endian.

>  };
>
>  static void apb_pci_config_write(void *opaque, hwaddr addr,
> @@ -570,7 +570,6 @@ static void apb_pci_config_write(void *opaque, hwaddr addr,
>      APBState *s = opaque;
>      PCIHostState *phb = PCI_HOST_BRIDGE(s);
>
> -    val = qemu_bswap_len(val, size);
>      APB_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__, addr, val);
>      pci_data_write(phb->bus, addr, val, size);
>  }
> @@ -583,7 +582,6 @@ static uint64_t apb_pci_config_read(void *opaque, hwaddr addr,
>      PCIHostState *phb = PCI_HOST_BRIDGE(s);
>
>      ret = pci_data_read(phb->bus, addr, size);
> -    ret = qemu_bswap_len(ret, size);
>      APB_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, ret);
>      return ret;
>  }
> @@ -744,7 +742,7 @@ static void pci_pbm_reset(DeviceState *d)
>  static const MemoryRegionOps pci_config_ops = {
>      .read = apb_pci_config_read,
>      .write = apb_pci_config_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>
>  static int pci_pbm_init_device(SysBusDevice *dev)
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
