Received: from eggs.gnu.org ([2001:4830:134:3::10]:46299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1drO2c-0001bt-SD
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1drO2W-0000le-S1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:42:18 -0400
Date: Mon, 11 Sep 2017 14:41:54 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170911124154.lpckigdp32kfiisd@hawk.localdomain>
References: <1499634139-20399-1-git-send-email-eric.auger@redhat.com>
	<1499634139-20399-2-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499634139-20399-2-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v3 1/3] hw/pci-host/gpex: Set INTx
 index/gsi mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, wei@redhat.com, agraf@suse.de, christoffer.dall@linaro.org, pranavkumar@linaro.org

On Sun, Jul 09, 2017 at 11:02:17PM +0200, Eric Auger wrote:
> From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> 
> To implement INTx to gsi routing we need to pass the gpex host
> bridge the gsi associated to each INTx index. Let's introduce
> irq_num array and gpex_set_irq_num setter function.
> 
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/pci-host/gpex.c         | 10 ++++++++++
>  include/hw/pci-host/gpex.h |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index 83084b9..0d42ac2 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -43,6 +43,16 @@ static void gpex_set_irq(void *opaque, int irq_num, int level)
>      qemu_set_irq(s->irq[irq_num], level);
>  }
>  
> +int gpex_set_irq_num(GPEXHost *s, int index, uint32_t gsi)
> +{
> +    if (index >=  GPEX_NUM_IRQS) {
                    ^extra space
> +        return -EINVAL;
> +    }
> +
> +    s->irq_num[index] = gsi;
> +    return 0;
> +}
> +
>  static void gpex_host_realize(DeviceState *dev, Error **errp)
>  {
>      PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index 68c9348..db26b3e 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -51,6 +51,9 @@ typedef struct GPEXHost {
>      MemoryRegion io_ioport;
>      MemoryRegion io_mmio;
>      qemu_irq irq[GPEX_NUM_IRQS];
> +    uint32_t irq_num[GPEX_NUM_IRQS];

This is an int when calling gpex_set_irq_num() and then used as an int
later, requiring a cast. Why not just make it an int here and in the API?

>  } GPEXHost;
>  
> +int gpex_set_irq_num(GPEXHost *s, int index, uint32_t gsi);
> +
>  #endif /* HW_GPEX_H */
> -- 
> 2.5.5
> 
> 
