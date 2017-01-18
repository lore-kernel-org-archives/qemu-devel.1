Received: from eggs.gnu.org ([2001:4830:134:3::10]:34248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTvd7-00038q-Af
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTvd6-0005Rw-Gp
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:10:45 -0500
Date: Wed, 18 Jan 2017 21:10:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170118210535-mutt-send-email-mst@kernel.org>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-5-git-send-email-mst@redhat.com>
	<14ee35d6-3b41-31da-69d6-5d25da95548b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ee35d6-3b41-31da-69d6-5d25da95548b@redhat.com>
Subject: Re: [Qemu-devel] [PULL 04/41] virtio: convert to use DMA api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit.shah@redhat.com>

On Wed, Jan 18, 2017 at 12:59:03PM +0100, Paolo Bonzini wrote:
> 
> 
> On 10/01/2017 06:39, Michael S. Tsirkin wrote:
> > -void virtqueue_map(VirtQueueElement *elem)
> > +void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
> >  {
> > -    virtqueue_map_iovec(elem->in_sg, elem->in_addr, &elem->in_num,
> > -                        VIRTQUEUE_MAX_SIZE, 1);
> > -    virtqueue_map_iovec(elem->out_sg, elem->out_addr, &elem->out_num,
> > -                        VIRTQUEUE_MAX_SIZE, 0);
> > +    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, &elem->in_num,
> > +                        MIN(ARRAY_SIZE(elem->in_sg), ARRAY_SIZE(elem->in_addr)),
> > +                        1);
> > +    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, &elem->out_num,
> > +                        MIN(ARRAY_SIZE(elem->out_sg),
> > +                        ARRAY_SIZE(elem->out_addr)),
> > +                        0);
> 
> Coverity reports that ARRAY_SIZE(elem->out_sg) (and all the others too)
> is wrong because elem->out_sg is a pointer.
> 
> However, the check is not in the right place and the max_size argument
> of virtqueue_map_iovec can be removed.  The check on in_num/out_num can
> be moved to qemu_get_virtqueue_element instead, before the call to
> virtqueue_alloc_element.
> 
> Thanks,
> 
> Paolo

I guess the effect of this bug is basically false-positive asserts, correct?

-- 
MST
