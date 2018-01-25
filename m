Received: from eggs.gnu.org ([2001:4830:134:3::10]:33923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeiqW-0000Y8-Md
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeiqR-0005LE-NH
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:49:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eeiqR-0005IY-Gr
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:49:39 -0500
Date: Thu, 25 Jan 2018 16:48:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180125160916-mutt-send-email-mst@kernel.org>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
	<20180122121751.GD31621@stefanha-x1.localdomain>
	<20180122215348-mutt-send-email-mst@kernel.org>
	<b0568f2d-928c-5124-757e-fe5b706c4df7@redhat.com>
	<20180123180515-mutt-send-email-mst@kernel.org>
	<514b4874-802a-3405-485e-1f84d760ec67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514b4874-802a-3405-485e-1f84d760ec67@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jan 25, 2018 at 03:07:23PM +0100, Paolo Bonzini wrote:
> On 23/01/2018 17:07, Michael S. Tsirkin wrote:
> >> It's not clear to me how to do this. E.g need a way to report failure to VM2
> >> or #PF?
> > 
> > Why would there be a failure? qemu running vm1 would be responsible for
> > preventing access to vm2's memory not mapped through an IOMMU.
> > Basically munmap these.
> 
> Access to VM2's memory would use VM2's configured IOVAs for VM1's
> requester id.  VM2's QEMU send device IOTLB messages to VM1's QEMU,
> which would remap VM2's memory on the fly into VM1's BAR2.

Right. Almost.

One problem is that IOVA range is bigger than RAM range,
so you will have trouble making arbitrary virtual addresses
fit in a BAR.

This is why I suggested a hybrid approach where
translation happens within guest, qemu only does protection.

Another problem with it is that IOMMU has page granularity
while with hugetlbfs we might not be able to remap at that
granularity.

Not sure what to do about it - teach host to break
up pages? Pass limitation to guest through virtio-iommu?

Ideas?

> It's not trivial to do it efficiently, but it's possible.  The important
> thing is that, if VM2 has an IOMMU, QEMU must *not* connect to a
> virtio-vhost-user device that lacks IOTLB support.  But that would be a
> vhost-user bug, not a virtio-vhost-user bug---and that's the beauty of
> Stefan's approach. :)
> 
> Paolo
