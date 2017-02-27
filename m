Received: from eggs.gnu.org ([2001:4830:134:3::10]:59263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciLwN-0005Mo-7W
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciLwJ-0008Ea-Bx
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:06:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1ciLwJ-0008Dv-2r
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:06:11 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RDwwHT004239
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 09:06:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u641c5qx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 09:06:09 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 27 Feb 2017 14:06:07 -0000
Date: Mon, 27 Feb 2017 15:06:01 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170222163734.13104-3-stefanha@redhat.com>
References: <20170222163734.13104-1-stefanha@redhat.com>
	<20170222163734.13104-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170227150601.41849383.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio: add missing region cache
 init in virtio_load()
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

On Wed, 22 Feb 2017 16:37:34 +0000
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
> Wait until all ring addresses are known before trying to initialize the
> region cache.  Also clarify the incomplete comment about VIRTIO-1 ring
> address subsection.
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
