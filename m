Received: from eggs.gnu.org ([2001:4830:134:3::10]:34029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gChgv-0003lU-Bj
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gChgu-0007El-BF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gChgu-0007Dg-1A
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:00:32 -0400
Date: Wed, 17 Oct 2018 11:00:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181017110022.24af9ed1.cohuck@redhat.com>
In-Reply-To: <1539713558-2453-3-git-send-email-kwankhede@nvidia.com>
References: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
	<1539713558-2453-3-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 2/4] Add migration functions for
 VFIO devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, 16 Oct 2018 23:42:36 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> - Migration function are implemented for VFIO_DEVICE_TYPE_PCI device.
> - Added SaveVMHandlers and implemented all basic functions required for live
>   migration.
> - Added VM state change handler to know running or stopped state of VM.
> - Added migration state change notifier to get notification on migration state
>   change. This state is translated to VFIO device state and conveyed to vendor
>   driver.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/migration.c           | 716 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |  23 ++
>  3 files changed, 740 insertions(+), 1 deletion(-)
>  create mode 100644 hw/vfio/migration.c
> 
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index a2e7a0a7cf02..6206ad47e90e 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,6 +1,6 @@
>  ifeq ($(CONFIG_LINUX), y)
>  obj-$(CONFIG_SOFTMMU) += common.o
> -obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
> +obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o migration.o

I don't think you want to make this explicitly pci-specific, but build
in a proper split of common infrastructure and pci handling from the
beginning.

>  obj-$(CONFIG_VFIO_CCW) += ccw.o
>  obj-$(CONFIG_SOFTMMU) += platform.o
>  obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> new file mode 100644
> index 000000000000..8a4f515226e0
> --- /dev/null
> +++ b/hw/vfio/migration.c

(...)

> +static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
> +
> +    if (vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
> +        VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +        PCIDevice *pdev = &vdev->pdev;
> +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> +        bool msi_64bit;
> +        int i;
> +
> +        for (i = 0; i < PCI_ROM_SLOT; i++) {
> +            uint32_t bar;
> +
> +            bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
> +            qemu_put_be32(f, bar);
> +        }
> +
> +        msi_flags = pci_default_read_config(pdev,
> +                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> +
> +        msi_addr_lo = pci_default_read_config(pdev,
> +                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> +        qemu_put_be32(f, msi_addr_lo);
> +
> +        if (msi_64bit) {
> +            msi_addr_hi = pci_default_read_config(pdev,
> +                                            pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> +                                            4);
> +        }
> +        qemu_put_be32(f, msi_addr_hi);
> +
> +        msi_data = pci_default_read_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +                2);
> +        qemu_put_be32(f, msi_data);
> +    }

This is an example of a function that should go into a pci-specific
file. Especially as config space is not a universal concept.

> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    return qemu_file_get_error(f);
> +}
