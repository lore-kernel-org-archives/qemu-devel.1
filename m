Received: from eggs.gnu.org ([2001:4830:134:3::10]:45943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgT2p-0001hb-8m
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgT2k-0003R6-8W
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:17:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgT2j-0003Qt-Ut
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:17:02 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1M9F0Wq036124
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:17:00 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28rt1ke705-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 04:16:59 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 22 Feb 2017 09:16:57 -0000
Date: Wed, 22 Feb 2017 10:16:53 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170221185901.3256-3-stefanha@redhat.com>
References: <20170221185901.3256-1-stefanha@redhat.com>
	<20170221185901.3256-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170222101653.4df25bc4.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: add missing region cache init
 in virtio_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 21 Feb 2017 18:59:01 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Commit 97cd965c070152bc626c7507df9fb356bbe1cd81 ("virtio: use
> VRingMemoryRegionCaches for avail and used rings") switched to a memory
> region cache to avoid repeated map/unmap operations.
> 
> The virtio_load() process is a little tricky because vring addresses are
> serialized in two separate places.  VIRTIO 1.0 devices serialize desc
> and then a subsection with used and avail.  Legacy devices only
> serialize desc.
> 
> Live migration of VIRTIO 1.0 devices fails on the destination host with:
> 
>   VQ 0 size 0x80 < last_avail_idx 0x12f8 - used_idx 0x0
>   Failed to load virtio-blk:virtio
>   error while loading state for instance 0x0 of device '0000:00:04.0/virtio-blk'
> 
> This happens because the memory region cache is only initialized after
> desc is loaded and not after the used and avail subsection is loaded.
> If the guest chose memory addresses that don't match the legacy ring
> layout then the wrong guest memory location is accessed.
> 
> Clarify comments about VIRTIO 1.0 and force memory region cache
> initialization at the point where all ring addresses are known.

Yes, the XXX comments should have been changed when the subsection for
used/avail had been introduced.

> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index da5c6fe..5bbc34b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1853,7 +1853,10 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
>          if (k->has_variable_vring_alignment) {
>              qemu_put_be32(f, vdev->vq[i].vring.align);
>          }
> -        /* XXX virtio-1 devices */
> +        /*
> +         * Save desc now, the rest of the ring addresses are saved in
> +         * subsections for VIRTIO-1 devices.
> +         */
>          qemu_put_be64(f, vdev->vq[i].vring.desc);
>          qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
>          if (k->save_queue) {
> @@ -1995,7 +1998,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>          vdev->vq[i].notification = true;
> 
>          if (vdev->vq[i].vring.desc) {
> -            /* XXX virtio-1 devices */
> +            /*
> +             * VIRTIO-1 devices may not have final ring addresses here.  The
> +             * used and avail ring addresses are loaded in subsections later.
> +             */
>              virtio_queue_update_rings(vdev, i);
>          } else if (vdev->vq[i].last_avail_idx) {
>              error_report("VQ %d address 0x0 "
> @@ -2062,6 +2068,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>      for (i = 0; i < num; i++) {
>          if (vdev->vq[i].vring.desc) {
>              uint16_t nheads;
> +
> +            /* All ring addresses have been loaded now... */
> +            virtio_init_region_cache(vdev, i);

It feels a bit weird that the region cache was already initialized when
update rings was called. Should the call to init_region_cache be moved
from update_rings() to virtio_queue_set_addr()?

> +
>              nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
>              /* Check it isn't doing strange things with descriptor numbers. */
>              if (nheads > vdev->vq[i].vring.num) {
