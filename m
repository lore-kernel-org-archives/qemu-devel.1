Received: from eggs.gnu.org ([2001:4830:134:3::10]:48665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctL92-00034r-Vt
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 17:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctL8y-0005qb-2L
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 17:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctL8x-0005qB-St
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 17:28:40 -0400
Date: Thu, 30 Mar 2017 00:28:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170330002755-mutt-send-email-mst@kernel.org>
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
	<aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
Subject: Re: [Qemu-devel] issues of region cache and iommu reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>

On Wed, Mar 29, 2017 at 10:09:10AM +0200, Paolo Bonzini wrote:
> 
> 
> On 29/03/2017 10:00, Jason Wang wrote:
> > 
> > 
> > 1) vtd was reset first
> > 
> > 2) during the reset of virtio-net-pci #1, deletion of msix subregion
> > will cause a commit of all memory listeners
> > 
> > 3) virito-net-pci #2's region cache will be update, but since vtd has
> > already been reset, it can't get a valid mappings here
> >
> > Any ideas on how to fix this? Need region cache be aware of IOMMU/IOTLB
> > state in this case? Or can we simply reset IOMMU as the last one?
> 
> Something like this?
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 03592c5..73e69ac 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -176,6 +176,10 @@ err_used:
>      address_space_cache_destroy(&new->desc);
>  err_desc:
>      g_free(new);
> +    atomic_rcu_set(&vq->vring.caches, NULL);
> +    if (old) {
> +        call_rcu(old, virtio_free_region_cache, rcu);
> +    }
>  }
> 
>  /* virt queue functions */

I would be worried about call_rcu here - this means
something can hang on to and use the old cache,
and reset really must act as a sync/flush point.


> Paolo
