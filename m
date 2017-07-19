Received: from eggs.gnu.org ([2001:4830:134:3::10]:56243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dXq24-0003BA-98
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dXq21-0007KZ-5g
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:32:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dXq20-0007Gt-Sn
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:32:53 -0400
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500470414-7911-2-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <dec6921c-7735-cea5-dd4f-f85b0b9e258d@redhat.com>
Date: Wed, 19 Jul 2017 17:24:27 +0300
MIME-Version: 1.0
In-Reply-To: <1500470414-7911-2-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] pci: add support for direct usage
 of bdf for capability lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org
Cc: qemu-devel@nongnu.org

On 19/07/2017 16:20, Aleksandr Bezzubikov wrote:
> Add a capability lookup function which gets bdf instead of pci_device
> as its first argument. It may be useful when we have bdf,
> but don't have the whole pci_device structure.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   src/hw/pcidevice.c | 24 ++++++++++++++++++++++++
>   src/hw/pcidevice.h |  1 +
>   2 files changed, 25 insertions(+)
> 
> diff --git a/src/hw/pcidevice.c b/src/hw/pcidevice.c
> index cfebf66..3fa240e 100644
> --- a/src/hw/pcidevice.c
> +++ b/src/hw/pcidevice.c
> @@ -158,6 +158,30 @@ u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap)
>       return 0;
>   }
>   

Hi Aleksandr,

> +u8 pci_find_capability_bdf(int bdf, u8 cap_id, u8 cap)
> +{

Please do not duplicate the code for the 'pci_find_capability'.
In this case you can reuse the code by
making 'pci_find_capability' call 'pci_find_capability_bdf',
or better, instead of a new function, change the signature
as you proposed and make the calling code use bdf
instead of the pci device, since is the only info needed.

Thanks,
Marcel

> +    int i;
> +    u16 status = pci_config_readw(bdf, PCI_STATUS);
> +
> +    if (!(status & PCI_STATUS_CAP_LIST))
> +        return 0;
> +
> +    if (cap == 0) {
> +        /* find first */
> +        cap = pci_config_readb(bdf, PCI_CAPABILITY_LIST);
> +    } else {
> +        /* find next */
> +        cap = pci_config_readb(bdf, cap + PCI_CAP_LIST_NEXT);
> +    }
> +    for (i = 0; cap && i <= 0xff; i++) {
> +        if (pci_config_readb(bdf, cap + PCI_CAP_LIST_ID) == cap_id)
> +            return cap;
> +        cap = pci_config_readb(bdf, cap + PCI_CAP_LIST_NEXT);
> +    }
> +
> +    return 0;
> +}
> +
>   // Enable PCI bus-mastering (ie, DMA) support on a pci device
>   void
>   pci_enable_busmaster(struct pci_device *pci)
> diff --git a/src/hw/pcidevice.h b/src/hw/pcidevice.h
> index 354b549..e4ed5cf 100644
> --- a/src/hw/pcidevice.h
> +++ b/src/hw/pcidevice.h
> @@ -70,6 +70,7 @@ int pci_init_device(const struct pci_device_id *ids
>   struct pci_device *pci_find_init_device(const struct pci_device_id *ids
>                                           , void *arg);
>   u8 pci_find_capability(struct pci_device *pci, u8 cap_id, u8 cap);
> +u8 pci_find_capability_bdf(int bdf, u8 cap_id, u8 cap);
>   void pci_enable_busmaster(struct pci_device *pci);
>   u16 pci_enable_iobar(struct pci_device *pci, u32 addr);
>   void *pci_enable_membar(struct pci_device *pci, u32 addr);
> 
