Received: from eggs.gnu.org ([2001:4830:134:3::10]:39029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eki1Y-0006u5-60
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 22:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eki1V-000602-B7
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 22:09:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eki1V-0005zd-4Y
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 22:09:49 -0500
Date: Sun, 11 Feb 2018 11:09:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180211030936.GH2783@xz-mi>
References: <20180207000731.32764.95992.stgit@gimli.home>
	<20180209070511.GD2783@xz-mi> <20180209144541.059554bf@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180209144541.059554bf@w520.home>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio/pci: Add ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org

On Fri, Feb 09, 2018 at 02:45:41PM -0700, Alex Williamson wrote:
> On Fri, 9 Feb 2018 15:05:11 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, Feb 06, 2018 at 05:08:14PM -0700, Alex Williamson wrote:
> > 
> > [...]
> > 
> > > +long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
> > > +			uint64_t data, int count, int fd)
> > > +{
> > > +	struct pci_dev *pdev = vdev->pdev;
> > > +	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
> > > +	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
> > > +	struct vfio_pci_ioeventfd *ioeventfd;
> > > +	int (*handler)(void *, void *);
> > > +	unsigned long val;
> > > +
> > > +	/* Only support ioeventfds into BARs */
> > > +	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
> > > +		return -EINVAL;
> > > +
> > > +	if (pos + count > pci_resource_len(pdev, bar))
> > > +		return -EINVAL;
> > > +
> > > +	/* Disallow ioeventfds working around MSI-X table writes */
> > > +	if (bar == vdev->msix_bar &&
> > > +	    !(pos + count <= vdev->msix_offset ||
> > > +	      pos >= vdev->msix_offset + vdev->msix_size))
> > > +		return -EINVAL;
> > > +
> > > +	switch (count) {
> > > +	case 1:
> > > +		handler = &vfio_pci_ioeventfd_handler8;
> > > +		val = data;
> > > +		break;
> > > +	case 2:
> > > +		handler = &vfio_pci_ioeventfd_handler16;
> > > +		val = le16_to_cpu(data);
> > > +		break;
> > > +	case 4:
> > > +		handler = &vfio_pci_ioeventfd_handler32;
> > > +		val = le32_to_cpu(data);
> > > +		break;
> > > +#ifdef iowrite64
> > > +	case 8:
> > > +		handler = &vfio_pci_ioeventfd_handler64;
> > > +		val = le64_to_cpu(data);
> > > +		break;
> > > +#endif
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = vfio_pci_setup_barmap(vdev, bar);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mutex_lock(&vdev->ioeventfds_lock);
> > > +
> > > +	list_for_each_entry(ioeventfd, &vdev->ioeventfds_list, next) {
> > > +		if (ioeventfd->pos == pos && ioeventfd->bar == bar &&
> > > +		    ioeventfd->data == data && ioeventfd->count == count) {
> > > +			if (fd == -1) {
> > > +				vfio_virqfd_disable(&ioeventfd->virqfd);
> > > +				list_del(&ioeventfd->next);
> > > +				kfree(ioeventfd);
> > > +				ret = 0;
> > > +			} else
> > > +				ret = -EEXIST;
> > > +
> > > +			goto out_unlock;
> > > +		}
> > > +	}
> > > +
> > > +	if (fd < 0) {
> > > +		ret = -ENODEV;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	ioeventfd = kzalloc(sizeof(*ioeventfd), GFP_KERNEL);
> > > +	if (!ioeventfd) {
> > > +		ret = -ENOMEM;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	ioeventfd->pos = pos;
> > > +	ioeventfd->bar = bar;
> > > +	ioeventfd->data = data;
> > > +	ioeventfd->count = count;
> > > +
> > > +	ret = vfio_virqfd_enable(vdev->barmap[ioeventfd->bar] + ioeventfd->pos,
> > > +				 handler, NULL, (void *)val,
> > > +				 &ioeventfd->virqfd, fd);
> > > +	if (ret) {
> > > +		kfree(ioeventfd);
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	list_add(&ioeventfd->next, &vdev->ioeventfds_list);  
> > 
> > Is there a limit on how many ioeventfds that can be created?
> > 
> > IIUC we'll create this eventfd "automatically" if a MMIO addr/data
> > triggered continuously for N=10 times, then would it be safer we have
> > a limitation on maximum eventfds?  Or not sure whether a malicious
> > guest can consume the host memory by sending:
> > 
> > - addr1/data1, 10 times
> > - addr2/data2, 10 times
> > - ...
> > 
> > To create unlimited ioeventfds?  Thanks,
> 
> Good question, it is somewhat exploitable in the guest the way it's
> written, however a user process does have an open file limit and each
> eventfd consumes a file handle, so unless someone is running QEMU with
> unlimited file handles, there is a built-in limit.  Two problems remain
> though:
> 
> First, is it still a bad idea that a user within a guest can target
> this device page to consume all of the QEMU process' open file handles,
> even if ultimately they're only harming themselves?  What would a
> reasonable cap of file descriptors for this purpose be?  How would we
> know which are actively used and which could be expired?  Currently
> only 2 are registered, the MSI-ACK address and some unknown secondary
> one that's low frequency, but enough to trigger the algorithm here (and
> doesn't seem harmful to let it get enabled).  We could therefore
> arbitrarily pick 5 as an upper limit here, maybe with a warning if the
> code hits that limit.
> 
> Second, is there still an exploit in the proposed vfio interface that a
> user could re-use a single file descriptor for multiple vfio
> ioeventfds.  I don't know.  I thought about looking to see whether a
> file descriptor is re-used, but then I wondered if that might actually
> be kind of a neat and potentially useful interface that a single
> eventfd could trigger multiple device writes.

Do you know any of possible scenario for this?  Since that sounds like
an interesting idea.

> It looks like KVM
> arbitrarily sets a limit of 1000 iobus devices, where each ioeventfd
> would be such a device.  Perhaps we take the same approach and pick an
> arbitrary high upper limit per vfio device.  What's your opinion?

I did a "ulimit -n" and I got 1024 as default.  So even if someone
granted the QEMU process with more/unlimited file handles, we'll still
have a hard limit of ~1000 vfio-ioeventfds, which sounds safe.

But I agree that we can still have a even smaller limit for vfio,
especially we know explicitly on how many we may need in most cases.
I'll follow your choice of number because I totally have no good idea
on that.  While if we are going to have a limitation, I'm thinking
whether it'll be good we have a WARN_ONCE when that limit is reached.

Thanks,

-- 
Peter Xu
