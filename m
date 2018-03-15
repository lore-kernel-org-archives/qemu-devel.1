Received: from eggs.gnu.org ([2001:4830:134:3::10]:49533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewa5n-0007kC-IR
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewa5k-0006oN-DJ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:07:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ewa5k-0006oC-99
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:07:16 -0400
Date: Thu, 15 Mar 2018 15:07:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180315150701.41f77280@w520.home>
In-Reply-To: <ca07aa34-c0c4-3a79-be4f-4143a10d97c3@redhat.com>
References: <20180228195504.25283.45666.stgit@gimli.home>
	<20180228201520.25283.97532.stgit@gimli.home>
	<ca07aa34-c0c4-3a79-be4f-4143a10d97c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Auger Eric <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, peterx@redhat.com, aik@ozlabs.ru

On Tue, 13 Mar 2018 14:12:34 +0100
Auger Eric <eric.auger@redhat.com> wrote:
> On 28/02/18 21:15, Alex Williamson wrote:
> > +long vfio_pci_ioeventfd(struct vfio_pci_device *vdev, loff_t offset,
> > +			uint64_t data, int count, int fd)
> > +{
> > +	struct pci_dev *pdev = vdev->pdev;
> > +	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
> > +	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
> > +	struct vfio_pci_ioeventfd *ioeventfd;
> > +	int (*handler)(void *addr, void *value);
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
> > +		break;
> > +	case 2:
> > +		handler = &vfio_pci_ioeventfd_handler16;
> > +		break;
> > +	case 4:
> > +		handler = &vfio_pci_ioeventfd_handler32;
> > +		break;
> > +#ifdef iowrite64
> > +	case 8:
> > +		handler = &vfio_pci_ioeventfd_handler64;
> > +		break;  
> from a user point of view, it is straightforward this setup will be
> rejected? This is not documented in the uapi at the moment.

I added a mention in the uapi, do you see any need for more?
Essentially I consider this an entirely optional accelerator, bus
drivers are free to implement as much or little as they want.
Userspace can clearly make due without it, we've gone this long, and
it's easy to reject cases we don't want to support.  Thanks,

Alex
