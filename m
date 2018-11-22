Received: from eggs.gnu.org ([2001:4830:134:3::10]:51856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPfvD-0008PC-7k
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPfv7-0000qi-Qi
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:44:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gPfv7-0000ln-32
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:44:49 -0500
Date: Thu, 22 Nov 2018 11:43:17 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20181122034317.GA27426@wei-ubt>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<20181121143920.GA7375@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121143920.GA7375@debian>
Subject: Re: [Qemu-devel] [RFC v3 00/12] packed ring virtio-net userspace
 backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

On Wed, Nov 21, 2018 at 10:39:20PM +0800, Tiwei Bie wrote:
> Hi Wei,
> 
> FYI, the latest packed ring series for guest driver doesn't set
> the _F_NEXT bit for indirect descriptors any more. So below hack
> in guest driver is needed to make it work with this series:

OK, will do a test, thanks.

Wei

> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..42faea7d8cf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -980,6 +980,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
> +	int c = 0;
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1001,8 +1002,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			if (vring_mapping_error(vq, addr))
>  				goto unmap_release;
>  
> -			desc[i].flags = cpu_to_le16(n < out_sgs ?
> -						0 : VRING_DESC_F_WRITE);
> +			desc[i].flags = cpu_to_le16((n < out_sgs ?
> +						0 : VRING_DESC_F_WRITE) |
> +				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT));
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			i++;
> -- 
> 2.14.1
> 
> On Thu, Oct 11, 2018 at 10:08:23AM -0400, wexu@redhat.com wrote:
> > From: Wei Xu <wexu@redhat.com>
> > 
> > code base:
> > https://github.com/Whishay/qemu.git
> > 
> > Todo:
> > - migration has not been support yet
> > 
> > v2->v3
> > - addressed performance issue
> > - fixed feedback from v2
> > 
> > v1->v2
> > - sync to tiwei's v5
> > - reuse memory cache function with 1.0
> > - dropped detach patch and notification helper(04 & 05 in v1)
> > - guest virtio-net driver unload/reload support
> > - event suppression support(not tested)
> > - addressed feedback from v1
> > 
> > Wei Xu (12):
> >   virtio: introduce packed ring definitions
> >   virtio: redefine structure & memory cache for packed ring
> >   virtio: init memory cache for packed ring
> >   virtio: init wrap counter for packed ring
> >   virtio: init and desc empty check for packed ring
> >   virtio: get avail bytes check for packed ring
> >   virtio: fill/flush/pop for packed ring
> >   virtio: event suppression support for packed ring
> >   virtio-net: fill head desc after done all in a chain
> >   virtio: packed ring feature bit for userspace backend
> >   virtio: enable packed ring via a new command line
> >   virtio: feature vhost-net support for packed ring
> > 
> >  hw/net/vhost_net.c                             |   1 +
> >  hw/net/virtio-net.c                            |  11 +-
> >  hw/virtio/vhost.c                              |  19 +-
> >  hw/virtio/virtio.c                             | 685 +++++++++++++++++++++++--
> >  include/hw/virtio/virtio.h                     |   9 +-
> >  include/standard-headers/linux/virtio_config.h |  15 +
> >  include/standard-headers/linux/virtio_ring.h   |  43 ++
> >  7 files changed, 736 insertions(+), 47 deletions(-)
> > 
> > -- 
> > 1.8.3.1
> > 
