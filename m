Received: from eggs.gnu.org ([2001:4830:134:3::10]:46101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ct9EH-00039b-F7
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ct9EE-00025Z-BC
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:45:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55515
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1ct9EE-00025K-61
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:45:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2T8hwE5040757
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 04:45:17 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ftv24frp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 04:45:17 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 29 Mar 2017 09:45:15 +0100
Date: Wed, 29 Mar 2017 10:45:11 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
	<aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170329104511.6dfa132c.cornelia.huck@de.ibm.com>
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
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, qemu devel <qemu-devel@nongnu.org>

On Wed, 29 Mar 2017 10:09:10 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

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

Maybe I'm just confused here, but isn't ->broken enough to prevent
further accesses? And a reset will unset both ->broken and the caches
anyway? What am I missing?

>  }
> 
>  /* virt queue functions */
> 
> Paolo
> 
