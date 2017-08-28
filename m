Received: from eggs.gnu.org ([2001:4830:134:3::10]:35422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmMPn-0000Ab-N8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmMPm-0001su-VP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmMPm-0001pm-Oq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:57:26 -0400
Date: Mon, 28 Aug 2017 17:57:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170828175722.0b54b59a.cohuck@redhat.com>
In-Reply-To: <1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Mon, 28 Aug 2017 10:04:47 +0200
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> Let's introduce iommu replay callback for s390 pci iommu memory region.
> Currently we don't need any dma mapping replay. So let it return
> directly. This implementation will avoid meaningless loops calling
> translation callback.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 9e1f7ff5c5..359509ccea 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -407,6 +407,13 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
>      return ret;
>  }
>  
> +static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
> +                                  IOMMUNotifier *notifier)
> +{
> +    /* we don't need iommu replay currently */

This really needs to be heavier on the _why_. My guess is that anything
which would require replay goes through the rpcit instruction?

> +    return;
> +}
> +
>  static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
>                                          int devfn)
>  {
> @@ -1055,6 +1062,7 @@ static void s390_iommu_memory_region_class_init(ObjectClass *klass, void *data)
>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>  
>      imrc->translate = s390_translate_iommu;
> +    imrc->replay = s390_pci_iommu_replay;
>  }
>  
>  static const TypeInfo s390_iommu_memory_region_info = {
