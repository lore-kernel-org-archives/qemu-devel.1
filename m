Received: from eggs.gnu.org ([2001:4830:134:3::10]:52748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCM6t-0008TJ-UO
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCM6q-0001cg-Pv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:53:24 -0500
Date: Wed, 8 Nov 2017 09:53:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171108095314.7687676e.cohuck@redhat.com>
In-Reply-To: <20171107175455.73793-2-borntraeger@de.ibm.com>
References: <20171107175455.73793-1-borntraeger@de.ibm.com>
	<20171107175455.73793-2-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/pci: let pci devices start in
 configured mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

On Tue,  7 Nov 2017 18:54:55 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Currently, to enable a pci device in the guest, the user has to issue
> echo 1 > /sys/bus/pci/slots/00000000/power. This is not what people
> expect. On an LPAR, the user can put a PCI device in configured or
> deconfigured state via IOCDS. The "start in deconfigured state" can be
> used for "sharing" a pci function across LPARs. This is not what we are
> going to use in KVM, so always start configured.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e7a58e8..2b1e140 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -715,7 +715,7 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
>          pbdev->pdev = pdev;
>          pbdev->iommu = s390_pci_get_iommu(s, pdev->bus, pdev->devfn);
>          pbdev->iommu->pbdev = pbdev;
> -        pbdev->state = ZPCI_FS_STANDBY;
> +        pbdev->state = ZPCI_FS_DISABLED;
>  
>          if (s390_pci_msix_init(pbdev)) {
>              error_setg(errp, "MSI-X support is mandatory "

A pci function already has to be configured before we can assign it via
vfio, right?

I think I'll queue this for 2.11.
