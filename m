Received: from eggs.gnu.org ([2001:4830:134:3::10]:45004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpA9n-0006N1-UI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpA9j-0006g3-6b
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpA9i-0006fd-VU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:28:27 -0400
Date: Tue, 5 Sep 2017 11:28:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905112822.0e9319cd.cohuck@redhat.com>
In-Reply-To: <1504239778-29893-4-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1504239778-29893-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1504239778-29893-4-git-send-email-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] s390x/pci: add iommu replay callback
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

On Fri,  1 Sep 2017 06:22:58 +0200
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
>  hw/s390x/s390-pci-bus.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index bd8a3e1e1c..69f45e3715 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -397,6 +397,16 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
>      return ret;
>  }
>  
> +static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
> +                                  IOMMUNotifier *notifier)
> +{
> +    /* It's impossible to plug a pci device on s390x that already has iommu
> +     * mappings which need to be replayed, that is due to the "one iommu per
> +     * zpci device" construct. So we don't need iommu replay currently.

I must say that 'currently' still throws me off. Does this refer to
vfio? If yes, reword to something like 'Should we support migration of
vfio-pci devices in the future, we need to revisit this.'?

> +     */
> +    return;
> +}
> +
>  static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
>                                          int devfn)
>  {
> @@ -1045,6 +1055,7 @@ static void s390_iommu_memory_region_class_init(ObjectClass *klass, void *data)
>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>  
>      imrc->translate = s390_translate_iommu;
> +    imrc->replay = s390_pci_iommu_replay;
>  }
>  
>  static const TypeInfo s390_iommu_memory_region_info = {
