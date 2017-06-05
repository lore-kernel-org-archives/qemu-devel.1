Received: from eggs.gnu.org ([2001:4830:134:3::10]:35226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dHuC4-00005X-Pb
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dHuC1-0007pv-O3
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:45:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dHuC1-0007pR-Hz
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:45:21 -0400
Date: Mon, 5 Jun 2017 18:45:08 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170605184313-mutt-send-email-mst@kernel.org>
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
	<4a21db67-4c02-7895-6b5c-1d60fe85c7f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a21db67-4c02-7895-6b5c-1d60fe85c7f2@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, armbru@redhat.com

On Mon, Jun 05, 2017 at 10:41:56AM -0500, Eric Blake wrote:
> On 06/05/2017 10:38 AM, Michael S. Tsirkin wrote:
> > On Mon, Jun 05, 2017 at 04:57:29PM +0800, Wei Wang wrote:
> >> This patch enables the virtio-net tx queue size to be configurable
> >> between 256 and 1024 by the user. The queue size specified by the
> >> user should be power of 2. If "tx_queue_size" is not offered by the
> >> user, the default queue size, 1024, will be used.
> >>
> 
> >> +    if (n->net_conf.tx_queue_size < VIRTIO_NET_TX_QUEUE_MIN_SIZE ||
> >> +        n->net_conf.tx_queue_size > VIRTQUEUE_MAX_SIZE ||
> >> +        (n->net_conf.tx_queue_size & (n->net_conf.tx_queue_size - 1))) {
> > 
> > Pls use is_power_of_2.
> > 
> >> +        error_setg(errp, "Invalid tx_queue_size (= %" PRIu16 "), "
> >> +                   "must be a power of 2 between %d and %d.",
> 
> No trailing '.' in error_setg() messages, please.
> 
> >> +                   n->net_conf.tx_queue_size, VIRTIO_NET_TX_QUEUE_MIN_SIZE,
> >> +                   VIRTQUEUE_MAX_SIZE);
> > 
> > I think management will need a way to discover the limits for
> > this value. Not sure how. Cc QAPI maintainers.
> 
> Is this something that can be documented? Or is it a runtime-variable
> limit, where you will need to query the limit on a per-machine basis?
> Given that it looks like compile-time documentation, I'm leaning towards
> documentation being sufficient.

We are likely to change the limits with time. E.g.
VIRTIO_NET_TX_QUEUE_MIN_SIZE is arbitrary.

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
