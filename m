Received: from eggs.gnu.org ([2001:4830:134:3::10]:37472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejT2n-0007Je-3a
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejT2i-0001lU-2m
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:58:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ejT2h-0001l8-PI
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:57:55 -0500
Date: Wed, 7 Feb 2018 09:57:46 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180207095746.14cef887@w520.home>
In-Reply-To: <c98a2d5c-19e9-813c-c58f-77583e7873ff@redhat.com>
References: <20180207000731.32764.95992.stgit@gimli.home>
	<c98a2d5c-19e9-813c-c58f-77583e7873ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] vfio/pci: Add ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org

On Wed, 7 Feb 2018 16:46:19 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 07/02/18 01:08, Alex Williamson wrote:
> > The ioeventfd here is actually irqfd handling of an ioeventfd such as
> > supported in KVM.  A user is able to pre-program a device write to
> > occur when the eventfd triggers.  This is yet another instance of
> > eventfd-irqfd triggering between KVM and vfio.  The impetus for this
> > is high frequency writes to pages which are virtualized in QEMU.
> > Enabling this near-direct write path for selected registers within
> > the virtualized page can improve performance and reduce overhead.
> > Specifically this is initially targeted at NVIDIA graphics cards where
> > the driver issues a write to an MMIO register within a virtualized
> > region in order to allow the MSI interrupt to re-trigger.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> fyi it does not apply anymore on master (conflict in
> include/uapi/linux/vfio.h on GFX stuff)

Sorry, I should have noted that this was against v4.15, I didn't want
the churn of the merge window since I was benchmarking against this.
Will update for non-RFC.

...
> > +long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
> > +			uint64_t data, int count, int fd)
> > +{
> > +	struct pci_dev *pdev = vdev->pdev;
> > +	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
> > +	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
> > +	struct vfio_pci_ioeventfd *ioeventfd;
> > +	int (*handler)(void *, void *);
> > +	unsigned long val;
> > +
> > +	/* Only support ioeventfds into BARs */
> > +	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
> > +		return -EINVAL;
> > +
> > +	if (pos + count > pci_resource_len(pdev, bar))
> > +		return -EINVAL;
> > +
> > +	/* Disallow ioeventfds working around MSI-X table writes */
> > +	if (bar == vdev->msix_bar &&
> > +	    !(pos + count <= vdev->msix_offset ||
> > +	      pos >= vdev->msix_offset + vdev->msix_size))
> > +		return -EINVAL;
> > +
> > +	switch (count) {
> > +	case 1:
> > +		handler = &vfio_pci_ioeventfd_handler8;
> > +		val = data;
> > +		break;
> > +	case 2:
> > +		handler = &vfio_pci_ioeventfd_handler16;
> > +		val = le16_to_cpu(data);
> > +		break;
> > +	case 4:
> > +		handler = &vfio_pci_ioeventfd_handler32;
> > +		val = le32_to_cpu(data);
> > +		break;
> > +#ifdef iowrite64
> > +	case 8:
> > +		handler = &vfio_pci_ioeventfd_handler64;
> > +		val = le64_to_cpu(data);
> > +		break;
> > +#endif
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = vfio_pci_setup_barmap(vdev, bar);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_lock(&vdev->ioeventfds_lock);
> > +
> > +	list_for_each_entry(ioeventfd, &vdev->ioeventfds_list, next) {
> > +		if (ioeventfd->pos == pos && ioeventfd->bar == bar &&
> > +		    ioeventfd->data == data && ioeventfd->count == count) {
> > +			if (fd == -1) {
> > +				vfio_virqfd_disable(&ioeventfd->virqfd);
> > +				list_del(&ioeventfd->next);
> > +				kfree(ioeventfd);
> > +				ret = 0;
> > +			} else
> > +				ret = -EEXIST;
> > +
> > +			goto out_unlock;
> > +		}
> > +	}
> > +
> > +	if (fd < 0) {
> > +		ret = -ENODEV;
> > +		goto out_unlock;
> > +	}
> > +
> > +	ioeventfd = kzalloc(sizeof(*ioeventfd), GFP_KERNEL);
> > +	if (!ioeventfd) {
> > +		ret = -ENOMEM;
> > +		goto out_unlock;
> > +	}
> > +
> > +	ioeventfd->pos = pos;
> > +	ioeventfd->bar = bar;
> > +	ioeventfd->data = data;
> > +	ioeventfd->count = count;
> > +
> > +	ret = vfio_virqfd_enable(vdev->barmap[ioeventfd->bar] + ioeventfd->pos,  
> nit: bar and pos could be used directly

Indeed, probably leftover from development.  Fixed and re-wrapped the
following lines.

> > +				 handler, NULL, (void *)val,
> > +				 &ioeventfd->virqfd, fd);
> > +	if (ret) {
> > +		kfree(ioeventfd);
> > +		goto out_unlock;
> > +	}
> > +
> > +	list_add(&ioeventfd->next, &vdev->ioeventfds_list);
> > +
> > +out_unlock:
> > +	mutex_unlock(&vdev->ioeventfds_lock);
> > +
> > +	return ret;
> > +}
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index e3301dbd27d4..07966a5f0832 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -503,6 +503,30 @@ struct vfio_pci_hot_reset {
> >  
> >  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
> >  
> > +/**
> > + * VFIO_DEVICE_IOEVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 14,
> > + *                              struct vfio_device_ioeventfd)
> > + *
> > + * Perform a write to the device at the specified device fd offset, with
> > + * the specified data and width when the provided eventfd is triggered.  
> don't you want to document the limitation on BAR only and excluding the
> MSIx table.

Sure, we could.  This is also just an acceleration interface, it's not
required for functionality, so a user can probe the capabilities by
trying to enable an ioeventfd to test for support.  I don't really want
to add a flag to each region to identify support or create yet another
sparse map identifying which sections of regions are supported.  We
could enable this for PCI config space, but I didn't think it really
made sense (and I was too lazy).  Real PCI config space (not MMIO
mirrors of config space on GPUs) should never be a performance path,
therefore I question if there's any ROI for the code to support it.
Device specific regions would need to be handled on a case by case
basis, and I don't think we have any cases yet were it makes sense
(IIRC the IGD regions are read-only).  Of course ROMs are read-only, so
it doesn't make sense to support them.

I also note that this patch of course only supports directly assigned
vfio-pci devices, not vfio-platform and not mdev devices.  Since the
ioctl is intended to be device agnostic, maybe we could have a default
handler that simply uses the device file write interface.  At least one
issue there is that those expect a user buffer.  I'll look into how I
might add the support more generically, if perhaps less optimized.

Does it seem like a sufficient user API to try and ioeventfd and be
prepared for it to fail?  Given that this is a new ioctl, users need to
do that for backwards compatibility anyway.

Something I forgot to mention in my rush to send this out is that I
debated whether to create a new ioctl or re-use the SET_IRQS ioctl.  In
the end, I couldn't resolve how to handle the index, start, and count
fields, so I created this new ioctl.  Would we create an ioeventfd
index?  We couldn't simply pass an array of ioeventfds since each needs
to be associated with an offset, data, and size, so we'd need a new
data type with a structure encompassing those fields.  In the end it
obviously didn't make sense to me to re-use SET_IRQS, but if others can
come up with something that makes sense, I'm open to it.  Thanks,

Alex
