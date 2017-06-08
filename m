Received: from eggs.gnu.org ([2001:4830:134:3::10]:50851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ2gy-0005XJ-8V
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ2gv-0007TT-6v
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dJ2gv-0007TO-0a
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:01:57 -0400
Date: Thu, 8 Jun 2017 22:01:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170608220006-mutt-send-email-mst@kernel.org>
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
	<5937511D.5070205@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5937511D.5070205@intel.com>
Subject: Re: [Qemu-devel] [PATCH v1] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, eblake@redhat.com, armbru@redhat.com

On Wed, Jun 07, 2017 at 09:04:29AM +0800, Wei Wang wrote:
> On 06/05/2017 11:38 PM, Michael S. Tsirkin wrote:
> > On Mon, Jun 05, 2017 at 04:57:29PM +0800, Wei Wang wrote:
> > > This patch enables the virtio-net tx queue size to be configurable
> > > between 256 and 1024 by the user. The queue size specified by the
> > > user should be power of 2. If "tx_queue_size" is not offered by the
> > > user, the default queue size, 1024, will be used.
> > > 
> > > For the traditional QEMU backend, setting the tx queue size to be 1024
> > > requires the guest virtio driver to support the VIRTIO_F_MAX_CHAIN_SIZE
> > > feature. This feature restricts the guest driver from chaining 1024
> > > vring descriptors, which may cause the device side implementation to
> > > send more than 1024 iov to writev.
> > > 
> > > VIRTIO_F_MAX_CHAIN_SIZE is a common transport feature added for all
> > > virtio devices. However, each device has the flexibility to set the max
> > > chain size to limit its driver to chain vring descriptors. Currently,
> > > the max chain size of the virtio-net device is set to 1023.
> > > 
> > > In the case that the tx queue size is set to 1024 and the
> > > VIRTIO_F_MAX_CHAIN_SIZE feature is not supported by the guest driver,
> > > the tx queue size will be reconfigured to be 512.
> > I'd like to see the reverse. Start with the current default.
> > If VIRTIO_F_MAX_CHAIN_SIZE is negotiated, increase the queue size.
> > 
> 
> OK, we can let the queue size start with 256, and how about
> increasing it to 1024 in the following two cases:

I think it should be
1) VIRTIO_F_MAX_CHAIN_SIZE is negotiated
and
2) user requested large size

> 1) VIRTIO_F_MAX_CHAIN_SIZE is negotiated; or
> 2) the backend is vhost.

For vhost we also need vhost backend to support VIRTIO_F_MAX_CHAIN_SIZE.
We also need to send the max chain size to backend.

> Best,
> Wei
