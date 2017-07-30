Received: from eggs.gnu.org ([2001:4830:134:3::10]:48470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbqvV-0005Vr-Uo
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 12:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbqvS-0004GM-Ri
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 12:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dbqvS-0004GE-I4
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 12:18:42 -0400
Date: Sun, 30 Jul 2017 19:18:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170730191735-mutt-send-email-mst@kernel.org>
References: <20170713210819-mutt-send-email-mst@kernel.org>
	<59686EEB.8080805@intel.com>
	<20170723044036-mutt-send-email-mst@kernel.org>
	<59781119.8010200@intel.com>
	<20170726155856-mutt-send-email-mst@kernel.org>
	<597954E3.2070801@intel.com>
	<20170729020231-mutt-send-email-mst@kernel.org>
	<597C83CC.7060702@intel.com>
	<20170730043922-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F739288D85@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F739288D85@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>

On Sun, Jul 30, 2017 at 05:59:17AM +0000, Wang, Wei W wrote:
> On Sunday, July 30, 2017 12:23 PM, Michael S. Tsirkin wrote:
> > On Sat, Jul 29, 2017 at 08:47:08PM +0800, Wei Wang wrote:
> > > On 07/29/2017 07:08 AM, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 27, 2017 at 10:50:11AM +0800, Wei Wang wrote:
> > > > > > > > OK I thought this over. While we might need these new APIs
> > > > > > > > in the future, I think that at the moment, there's a way to
> > > > > > > > implement this feature that is significantly simpler. Just
> > > > > > > > add each s/g as a separate input buffer.
> > > > > > > Should it be an output buffer?
> > > > > > Hypervisor overwrites these pages with zeroes. Therefore it is
> > > > > > writeable by device: DMA_FROM_DEVICE.
> > > > > Why would the hypervisor need to zero the buffer?
> > > > The page is supplied to hypervisor and can lose the value that is
> > > > there.  That is the definition of writeable by device.
> > >
> > > I think for the free pages, it should be clear that they will be added
> > > as output buffer to the device, because (as we discussed) they are
> > > just hints, and some of them may be used by the guest after the report_ API is
> > invoked.
> > > The device/hypervisor should not use or discard them.
> > 
> > Discarding contents is exactly what you propose doing if migration is going on,
> > isn't it?
> 
> That's actually a different concept. Please let me explain it with this example:
> 
> The hypervisor receives the hint saying the guest PageX is a free page, but as we know, 
> after that report_ API exits, the guest kernel may take PageX to use, so PageX is not free
> page any more. At this time, if the hypervisor writes to the page, that would crash the guest.
> So, I think the cornerstone of this work is that the hypervisor should not touch the
> reported pages.
> 
> Best,
> Wei    

That's a hypervisor implementation detail. From guest point of view,
discarding contents can not be distinguished from writing old contents.
