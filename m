Received: from eggs.gnu.org ([2001:4830:134:3::10]:37371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evjjT-0006fU-NB
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evjjQ-0001JO-Gb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:12:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1evjjQ-0001JA-9n
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 09:12:44 -0400
References: <20180228195504.25283.45666.stgit@gimli.home>
	<20180228201520.25283.97532.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ca07aa34-c0c4-3a79-be4f-4143a10d97c3@redhat.com>
Date: Tue, 13 Mar 2018 14:12:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180228201520.25283.97532.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio/pci: Add ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, peterx@redhat.com, aik@ozlabs.ru

Hi Alex,

On 28/02/18 21:15, Alex Williamson wrote:
> The ioeventfd here is actually irqfd handling of an ioeventfd such as
> supported in KVM.  A user is able to pre-program a device write to
> occur when the eventfd triggers.  This is yet another instance of
> eventfd-irqfd triggering between KVM and vfio.  The impetus for this
> is high frequency writes to pages which are virtualized in QEMU.
> Enabling this near-direct write path for selected registers within
> the virtualized page can improve performance and reduce overhead.
> Specifically this is initially targeted at NVIDIA graphics cards where
> the driver issues a write to an MMIO register within a virtualized
> region in order to allow the MSI interrupt to re-trigger.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         |   34 ++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |   18 +++++
>  drivers/vfio/pci/vfio_pci_rdwr.c    |  115 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h           |   27 ++++++++
>  4 files changed, 194 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index b0f759476900..ad18ed266dc0 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -305,6 +305,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct vfio_pci_dummy_resource *dummy_res, *tmp;
> +	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
>  	int i, bar;
>  
>  	/* Stop the device from further DMA */
> @@ -314,6 +315,15 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>  				VFIO_IRQ_SET_ACTION_TRIGGER,
>  				vdev->irq_type, 0, 0, NULL);
>  
> +	/* Device closed, don't need mutex here */
> +	list_for_each_entry_safe(ioeventfd, ioeventfd_tmp,
> +				 &vdev->ioeventfds_list, next) {
> +		vfio_virqfd_disable(&ioeventfd->virqfd);
> +		list_del(&ioeventfd->next);
> +		kfree(ioeventfd);
> +	}
> +	vdev->ioeventfds_nr = 0;
> +
>  	vdev->virq_disabled = false;
>  
>  	for (i = 0; i < vdev->num_regions; i++)
> @@ -1012,6 +1022,28 @@ static long vfio_pci_ioctl(void *device_data,
>  
>  		kfree(groups);
>  		return ret;
> +	} else if (cmd == VFIO_DEVICE_IOEVENTFD) {
> +		struct vfio_device_ioeventfd ioeventfd;
> +		int count;
> +
> +		minsz = offsetofend(struct vfio_device_ioeventfd, fd);
> +
> +		if (copy_from_user(&ioeventfd, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (ioeventfd.argsz < minsz)
> +			return -EINVAL;
> +
> +		if (ioeventfd.flags & ~VFIO_DEVICE_IOEVENTFD_SIZE_MASK)
> +			return -EINVAL;
> +
> +		count = ioeventfd.flags & VFIO_DEVICE_IOEVENTFD_SIZE_MASK;
> +
> +		if (hweight8(count) != 1 || ioeventfd.fd < -1)
> +			return -EINVAL;
> +
> +		return vfio_pci_ioeventfd(vdev, ioeventfd.offset,
> +					  ioeventfd.data, count, ioeventfd.fd);
>  	}
>  
>  	return -ENOTTY;
> @@ -1174,6 +1206,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
>  	mutex_init(&vdev->igate);
>  	spin_lock_init(&vdev->irqlock);
> +	mutex_init(&vdev->ioeventfds_lock);
> +	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>  
>  	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
>  	if (ret) {
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index f561ac1c78a0..33a48c3ba11c 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -29,6 +29,18 @@
>  #define PCI_CAP_ID_INVALID		0xFF	/* default raw access */
>  #define PCI_CAP_ID_INVALID_VIRT		0xFE	/* default virt access */
>  
> +/* Cap maximum number of ioeventfds per device (arbitrary) */
> +#define VFIO_PCI_IOEVENTFD_MAX		1000
> +
> +struct vfio_pci_ioeventfd {
> +	struct list_head	next;
> +	struct virqfd		*virqfd;
> +	loff_t			pos;
> +	uint64_t		data;
> +	int			bar;
> +	int			count;
> +};
> +
>  struct vfio_pci_irq_ctx {
>  	struct eventfd_ctx	*trigger;
>  	struct virqfd		*unmask;
> @@ -92,9 +104,12 @@ struct vfio_pci_device {
>  	bool			nointx;
>  	struct pci_saved_state	*pci_saved_state;
>  	int			refcnt;
> +	int			ioeventfds_nr;
>  	struct eventfd_ctx	*err_trigger;
>  	struct eventfd_ctx	*req_trigger;
>  	struct list_head	dummy_resources_list;
> +	struct mutex		ioeventfds_lock;
> +	struct list_head	ioeventfds_list;
>  };
>  
>  #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
> @@ -120,6 +135,9 @@ extern ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev, char __user *buf,
>  extern ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
>  			       size_t count, loff_t *ppos, bool iswrite);
>  
> +extern long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
> +			       uint64_t data, int count, int fd);
> +
>  extern int vfio_pci_init_perm_bits(void);
>  extern void vfio_pci_uninit_perm_bits(void);
>  
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 925419e0f459..43e4b5112337 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -17,6 +17,7 @@
>  #include <linux/pci.h>
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
> +#include <linux/vfio.h>
>  #include <linux/vgaarb.h>
>  
>  #include "vfio_pci_private.h"
> @@ -275,3 +276,117 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
>  
>  	return done;
>  }
> +
> +#define VFIO_PCI_IOEVENTFD_HANDLER(size)				\
> +static int vfio_pci_ioeventfd_handler##size(void *opaque, void *data)	\
> +{									\
> +	vfio_iowrite##size((unsigned long)data, opaque);		\
> +	return 0;							\
> +}
> +
> +#ifdef iowrite64
> +VFIO_PCI_IOEVENTFD_HANDLER(64)
> +#endif
> +VFIO_PCI_IOEVENTFD_HANDLER(32)
> +VFIO_PCI_IOEVENTFD_HANDLER(16)
> +VFIO_PCI_IOEVENTFD_HANDLER(8)
> +
> +long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
> +			uint64_t data, int count, int fd)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
> +	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
> +	struct vfio_pci_ioeventfd *ioeventfd;
> +	int (*handler)(void *addr, void *value);
> +
> +	/* Only support ioeventfds into BARs */
> +	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
> +		return -EINVAL;
> +
> +	if (pos + count > pci_resource_len(pdev, bar))
> +		return -EINVAL;
> +
> +	/* Disallow ioeventfds working around MSI-X table writes */
> +	if (bar == vdev->msix_bar &&
> +	    !(pos + count <= vdev->msix_offset ||
> +	      pos >= vdev->msix_offset + vdev->msix_size))
> +		return -EINVAL;
> +
> +	switch (count) {
> +	case 1:
> +		handler = &vfio_pci_ioeventfd_handler8;
> +		break;
> +	case 2:
> +		handler = &vfio_pci_ioeventfd_handler16;
> +		break;
> +	case 4:
> +		handler = &vfio_pci_ioeventfd_handler32;
> +		break;
> +#ifdef iowrite64
> +	case 8:
> +		handler = &vfio_pci_ioeventfd_handler64;
> +		break;
from a user point of view, it is straightforward this setup will be
rejected? This is not documented in the uapi at the moment.

Thanks

Eric
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = vfio_pci_setup_barmap(vdev, bar);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&vdev->ioeventfds_lock);
> +
> +	list_for_each_entry(ioeventfd, &vdev->ioeventfds_list, next) {
> +		if (ioeventfd->pos == pos && ioeventfd->bar == bar &&
> +		    ioeventfd->data == data && ioeventfd->count == count) {
> +			if (fd == -1) {
> +				vfio_virqfd_disable(&ioeventfd->virqfd);
> +				list_del(&ioeventfd->next);
> +				vdev->ioeventfds_nr--;
> +				kfree(ioeventfd);
> +				ret = 0;
> +			} else
> +				ret = -EEXIST;
> +
> +			goto out_unlock;
> +		}
> +	}
> +
> +	if (fd < 0) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	if (vdev->ioeventfds_nr >= VFIO_PCI_IOEVENTFD_MAX) {
> +		ret = -ENOSPC;
> +		goto out_unlock;
> +	}
> +
> +	ioeventfd = kzalloc(sizeof(*ioeventfd), GFP_KERNEL);
> +	if (!ioeventfd) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	ioeventfd->pos = pos;
> +	ioeventfd->bar = bar;
> +	ioeventfd->data = data;
> +	ioeventfd->count = count;
> +
> +	ret = vfio_virqfd_enable(vdev->barmap[bar] + pos, handler, NULL,
> +				 (void *)data, &ioeventfd->virqfd, fd);
> +	if (ret) {
> +		kfree(ioeventfd);
> +		goto out_unlock;
> +	}
> +
> +	list_add(&ioeventfd->next, &vdev->ioeventfds_list);
> +	vdev->ioeventfds_nr++;
> +
> +out_unlock:
> +	mutex_unlock(&vdev->ioeventfds_lock);
> +
> +	return ret;
> +}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index c74372163ed2..7e9d76203e86 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -575,6 +575,33 @@ struct vfio_device_gfx_plane_info {
>  
>  #define VFIO_DEVICE_GET_GFX_DMABUF _IO(VFIO_TYPE, VFIO_BASE + 15)
>  
> +/**
> + * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 16,
> + *                              struct vfio_device_ioeventfd)
> + *
> + * Perform a write to the device at the specified device fd offset, with
> + * the specified data and width when the provided eventfd is triggered.
> + * vfio bus drivers may not support this for all regions, or at all.
> + * vfio-pci currently only enables support for BAR regions and excludes
> + * the MSI-X vector table.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vfio_device_ioeventfd {
> +	__u32	argsz;
> +	__u32	flags;
> +#define VFIO_DEVICE_IOEVENTFD_8		(1 << 0) /* 1-byte write */
> +#define VFIO_DEVICE_IOEVENTFD_16	(1 << 1) /* 2-byte write */
> +#define VFIO_DEVICE_IOEVENTFD_32	(1 << 2) /* 4-byte write */
> +#define VFIO_DEVICE_IOEVENTFD_64	(1 << 3) /* 8-byte write */
> +#define VFIO_DEVICE_IOEVENTFD_SIZE_MASK	(0xf)
> +	__u64	offset;			/* device fd offset of write */
> +	__u64	data;			/* data to be written */
> +	__s32	fd;			/* -1 for de-assignment */
> +};
> +
> +#define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**
> 
