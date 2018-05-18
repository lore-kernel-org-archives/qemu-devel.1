Received: from eggs.gnu.org ([2001:4830:134:3::10]:59823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYWt-0005KA-Pa
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYWp-0000Ad-QD
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:06:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJYWp-0000AP-LA
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:06:11 -0400
Date: Fri, 18 May 2018 14:06:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180518060604.GG2569@xz-mi>
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180504030811.28111-10-peterx@redhat.com>
	<a314f61b-b40e-5d50-0e4d-4ead93b8d0f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a314f61b-b40e-5d50-0e4d-4ead93b8d0f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/10] intel-iommu: don't unmap all for
 shadow page table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Thu, May 17, 2018 at 07:23:33PM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 05/04/2018 05:08 AM, Peter Xu wrote:
> > IOMMU replay was carried out before in many use cases, e.g., context
> > cache invalidations, domain flushes.  We used this mechanism to sync the
> > shadow page table by firstly (1) unmap the whole address space, then
> > (2) walk the page table to remap what's in the table.
> > 
> > This is very dangerous.
> > 
> > The problem is that we'll have a very small window (in my measurement,
> > it can be about 3ms) during above step (1) and (2) that the device will
> > see no (or incomplete) device page table.  Howerver the device never
> > knows that.  This can cause DMA error of devices, who assumes the page
> > table is always there.
> But now you have the QemuMutex can we have a translate and an
> invalidation that occur concurrently? Don't the iotlb flush and replay
> happen while the lock is held?

Note that when we are using vfio-pci devices we can't really know when
the device started a DMA since that's totally happening only between
the host IOMMU and the hardware.  Say, vfio-pci device page
translation is happening in the shadow page table, not really in QEMU.
So IMO we aren't protected by anything.

Also, this patch is dropped in version 3, and I did something else to
achieve similar goal (by introducing the shadow page sync helper, and
then for DSIs we'll use that instead of calling IOMMU replay here).
Please have a look.  Thanks,

-- 
Peter Xu
