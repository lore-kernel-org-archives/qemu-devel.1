Received: from eggs.gnu.org ([2001:4830:134:3::10]:58725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePWMj-0004MF-QX
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePWMf-0007c2-Rg
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:28:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ePWMf-0007aM-Hi
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:28:05 -0500
Date: Thu, 14 Dec 2017 18:27:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171214180830-mutt-send-email-mst@kernel.org>
References: <286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<20171213165142-mutt-send-email-mst@kernel.org>
	<CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
	<825b8205-0b88-a198-b77d-63c8f2563c2e@redhat.com>
	<20171214154656.GR14433@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214154656.GR14433@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] [PATCH v3 0/7]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, snabb-devel@googlegroups.com, dgilbert@redhat.com

On Thu, Dec 14, 2017 at 03:46:56PM +0000, Stefan Hajnoczi wrote:
> On Wed, Dec 13, 2017 at 10:50:11PM +0100, Maxime Coquelin wrote:
> > On 12/13/2017 09:08 PM, Stefan Hajnoczi wrote:
> > > On Wed, Dec 13, 2017 at 3:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Wed, Dec 13, 2017 at 12:35:21PM +0000, Stefan Hajnoczi wrote:
> > > > > I'm not saying that DPDK should use libvhost-user.  I'm saying that it's
> > > > > easy to add vfio vhost-pci support (for the PCI adapter I described) to
> > > > > DPDK.  This patch series would require writing a completely new slave
> > > > > for vhost-pci because the device interface is so different from
> > > > > vhost-user.
> > > > 
> > > > The main question is how appropriate is the vhost user protocol
> > > > for passing to guests. And I am not sure at this point.
> > > > 
> > > > Someone should go over vhost user messages and see whether they are safe
> > > > to pass to guest. If most are then we can try the transparent approach.
> > > > If most aren't then we can't and might as well use the proposed protocol
> > > > which at least has code behind it.
> > > 
> > > I have done that:
> > > 
> > ...
> > >   * VHOST_USER_SET_MEM_TABLE
> > > 
> > >     Set up BARs before sending a VHOST_USER_SET_MEM_TABLE to the guest.
> > 
> > It would require to filter out userspace_addr from the payload not to
> > leak other QEMU process VAs to the guest.
> 
> QEMU's vhost-user master implementation is insecure because it leaks
> QEMU process VAs.  This also affects vhost-user host processes, not just
> vhost-pci.
> 
> The QEMU vhost-user master could send an post-IOMMU guest physical
> addresses whereever the vhost-user protocol specification says "user
> address".  That way no address space information is leaked although it
> does leak IOMMU mappings.
> 
> If we want to hide the IOMMU mappings too then we need another logical
> address space (kind a randomized ramaddr_t).
> 
> Anyway, my point is that the current vhost-user master implementation is
> insecure and should be fixed.  vhost-pci doesn't need to worry about
> this issue.
> 
> Stefan

I was going to make this point too.  It does not look like anyone uses
userspace_addr. It might have been a mistake to put it there -
maybe we should have reused it for map offset.

It does not look like anyone uses this for anything.

How about we put zero, or a copy of the GPA there?


-- 
MST
