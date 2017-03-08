Received: from eggs.gnu.org ([2001:4830:134:3::10]:36182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1clSo4-0003pQ-33
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1clSo2-0003P0-T8
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:02:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1clSo2-0003OY-JL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:02:30 -0500
Date: Wed, 8 Mar 2017 06:02:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170308060158-mutt-send-email-mst@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-5-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488519630-89058-5-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 kernel 4/5] virtio-balloon: define flags
 and head for host request vq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liang.z.li@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Fri, Mar 03, 2017 at 01:40:29PM +0800, Wei Wang wrote:
> From: Liang Li <liang.z.li@intel.com>
> 
> Define the flags and head struct for a new host request virtual
> queue. Guest can get requests from host and then responds to
> them on this new virtual queue.
> Host can make use of this virtqueue to request the guest to do
> some operations, e.g. drop page cache, synchronize file system,
> etc. The hypervisor can get some of guest's runtime information
> through this virtual queue too, e.g. the guest's unused page
> information, which can be used for live migration optimization.
> 
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Amit Shah <amit.shah@redhat.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Liang Li <liliang324@gmail.com>
> Cc: Wei Wang <wei.w.wang@intel.com>

I prefer this squashed into next patch makes review easier.


> ---
>  include/uapi/linux/virtio_balloon.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ed627b2..630b0ef 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -35,6 +35,7 @@
>  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_CHUNK_TRANSFER	3 /* Transfer pages in chunks */
> +#define VIRTIO_BALLOON_F_HOST_REQ_VQ	4 /* Host request virtqueue */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -94,4 +95,25 @@ struct virtio_balloon_resp_hdr {
>  	__le32 data_len; /* Payload len in bytes */
>  };
>  
> +enum virtio_balloon_req_id {
> +	/* Get unused page information */
> +	BALLOON_GET_UNUSED_PAGES,
> +};
> +
> +enum virtio_balloon_flag {
> +	/* Have more data for a request */
> +	BALLOON_FLAG_CONT,
> +	/* No more data for a request */
> +	BALLOON_FLAG_DONE,
> +};
> +
> +struct virtio_balloon_req_hdr {
> +	/* Used to distinguish different requests */
> +	__le16 cmd;
> +	/* Reserved */
> +	__le16 reserved[3];
> +	/* Request parameter */
> +	__le64 param;
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */
> -- 
> 2.7.4
