Received: from eggs.gnu.org ([2001:4830:134:3::10]:34950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f85JT-0003as-VF
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f85JP-0005RV-0Q
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:41:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f85JO-0005QZ-S3
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:40:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBC6FA200C
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 14:40:50 +0000 (UTC)
Date: Mon, 16 Apr 2018 16:40:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180416164041.38444edd@redhat.com>
In-Reply-To: <1523588509-4868-1-git-send-email-jasowang@redhat.com>
References: <1523588509-4868-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: do not verify ring mappings when
 IOMMU is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, 13 Apr 2018 11:01:49 +0800
Jason Wang <jasowang@redhat.com> wrote:

> When IOMMU is enabled, we store virtqueue metadata as iova (though it
> may has _phys suffix) and access them through dma helpers. Any
> translation failures could be reported by IOMMU.
> 
> In this case, trying to validate iova against gpa won't work and will
> cause a false error reporting. So this patch bypasses the ring
> verification if IOMMU is enabled which is similar to the behavior
> before 0ca1fd2d6878 that calls vhost_memory_map() which is a nop when
> IOMMU is enabled.
> 
> Fixes: 0ca1fd2d6878 ("vhost: Simplify ring verification checks")
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>


Looks like candidat for 2.12 if it's not too late?

> ---
>  hw/virtio/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index f51bf57..9d5850a 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -342,6 +342,10 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
>          "used ring"
>      };
>  
> +    if (vhost_dev_has_iommu(dev)) {
> +        return 0;
> +    }
> +
>      for (i = 0; i < dev->nvqs; ++i) {
>          struct vhost_virtqueue *vq = dev->vqs + i;
>  
