Received: from eggs.gnu.org ([2001:4830:134:3::10]:34011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMHcz-0007pF-Po
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMHcv-0008Cb-K3
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:07:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eMHcv-0008CE-BU
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:07:29 -0500
Date: Tue, 5 Dec 2017 20:06:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171205200605-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
	<20171205145950.GF31150@stefanha-x1.localdomain>
	<20171205174833-mutt-send-email-mst@kernel.org>
	<20171205164154.GD6712@stefanha-x1.localdomain>
	<20171205184533-mutt-send-email-mst@kernel.org>
	<20171205180010.6aad232f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205180010.6aad232f.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 2/7] vhost-pci-net: add
 vhost-pci-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, avi.cohen@huawei.com, zhiyong.yang@intel.com, jan.kiszka@siemens.com, jasowang@redhat.com, qemu-devel@nongnu.org, Wei Wang <wei.w.wang@intel.com>, marcandre.lureau@redhat.com, pbonzini@redhat.com

On Tue, Dec 05, 2017 at 06:00:10PM +0100, Cornelia Huck wrote:
> On Tue, 5 Dec 2017 18:53:29 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Dec 05, 2017 at 04:41:54PM +0000, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 05:55:45PM +0200, Michael S. Tsirkin wrote:  
> > > > On Tue, Dec 05, 2017 at 02:59:50PM +0000, Stefan Hajnoczi wrote:  
> > > > > On Tue, Dec 05, 2017 at 11:33:11AM +0800, Wei Wang wrote:  
> > > > > > Add the vhost-pci-net device emulation. The device uses bar 2 to expose
> > > > > > the remote VM's memory to the guest. The first 4KB of the the bar area
> > > > > > stores the metadata which describes the remote memory and vring info.  
> > > > > 
> > > > > This device looks like the beginning of a new "vhost-pci" virtio device
> > > > > type.  There are layering violations:
> > > > > 
> > > > > 1. This has nothing to do with virtio-net or networking, it's purely
> > > > >    vhost-pci.  Why is it called vhost-pci-net instead of vhost-pci?
> > > > > 
> > > > > 2. VirtIODevice does not know about PCI.  It should work over virtio-ccw
> > > > >    or virtio-mmio.  This patch talks about BARs inside a VirtIODevice so
> > > > >    there is a problem here.  
> > > > 
> > > > I think the point is how memory is exposed to another guest.  This
> > > > device exposes it as a pci bar. I don't think e.g. ccw can do this,
> > > > it's all hypercall-based.  
> > > 
> > > Yes, that's why the BAR issue needs to be discussed.
> > > 
> > > In terms of the patches, the clean way to do it is for the
> > > vhost-pci device to have a memory region that is not called "BAR".  The
> > > virtio-pci transport can expose it as a BAR but the device doesn't need
> > > to know about it.  Other transports that support memory mapping could
> > > then work with this device too.  
> > 
> > True, though mmio is pretty much a legacy transport at this point
> > at least from qemu perspective as arm devs don't seem to be working
> > on virtio 1.0 support in qemu. So I am not sure how much
> > of a priority should transport isolation be.
> 
> I currently don't see an easy way to make this work via ccw, FWIW. We
> would need a dedicated mechanism for it, and I'm not sure what the gain
> would be.
> 
> > 
> > > The VIRTIO specification needs to capture this transport requirement
> > > somehow too so it's clear that the vhost device can only run over
> > > transports that support memory mapping.
> > > 
> > > That said, it's not clear to me why the vhost-pci device is a VIRTIO
> > > device.  It doesn't use virtqueues or the configuration space.  It only
> > > uses the vhost-user chardev and the mapped memory.  Isn't it better to
> > > make it a PCI device?
> > > 
> > > Stefan  
> > 
> > Seems similar enough to me, except The roles of device and driver are
> > reversed here.
> > 
> 
> But will anything other than pci ever make use of this?

That's just it, I am not entirely sure.

So IMHO it's fine to make it a pci specific thing for now.

virtio started like that too.

-- 
MST
