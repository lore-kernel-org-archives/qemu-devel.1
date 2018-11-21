Received: from eggs.gnu.org ([2001:4830:134:3::10]:52952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gPL7j-0002PI-2F
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gPL7d-0001g5-TQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:32:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gPL7c-0001cW-N3
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:32:20 -0500
Date: Wed, 21 Nov 2018 13:32:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181121053205.GD24163@xz-x1>
References: <1542746383-18288-1-git-send-email-kwankhede@nvidia.com>
	<1542746383-18288-3-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1542746383-18288-3-git-send-email-kwankhede@nvidia.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] Add save and load functions for VFIO
 PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com

On Wed, Nov 21, 2018 at 02:09:40AM +0530, Kirti Wankhede wrote:
> Save and restore with MSIX type is not tested.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/pci.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h | 29 ++++++++++++++++++
>  2 files changed, 124 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6cbb8fa0549d..72daf1a358a0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1234,6 +1234,101 @@ void vfio_pci_write_config(PCIDevice *pdev,
>      }
>  }
>  
> +void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +    int i;
> +
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        uint32_t bar;
> +
> +        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
> +        qemu_put_be32(f, bar);

Is it possible to avoid calling qemu_put_*() directly from vfio code?
E.g., using VMStateDescription and hooks like pre_save, post_load and
etc.  Then we update all the data into the data structure and leave
all the rest of IO operations to general migration framework.

Regards,

-- 
Peter Xu
