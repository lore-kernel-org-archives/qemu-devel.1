Received: from eggs.gnu.org ([2001:4830:134:3::10]:32849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTotV-00071c-GO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 06:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTotU-00017e-OV
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 06:59:13 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-5-git-send-email-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14ee35d6-3b41-31da-69d6-5d25da95548b@redhat.com>
Date: Wed, 18 Jan 2017 12:59:03 +0100
MIME-Version: 1.0
In-Reply-To: <1484026704-28027-5-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 04/41] virtio: convert to use DMA api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit.shah@redhat.com>



On 10/01/2017 06:39, Michael S. Tsirkin wrote:
> -void virtqueue_map(VirtQueueElement *elem)
> +void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
>  {
> -    virtqueue_map_iovec(elem->in_sg, elem->in_addr, &elem->in_num,
> -                        VIRTQUEUE_MAX_SIZE, 1);
> -    virtqueue_map_iovec(elem->out_sg, elem->out_addr, &elem->out_num,
> -                        VIRTQUEUE_MAX_SIZE, 0);
> +    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, &elem->in_num,
> +                        MIN(ARRAY_SIZE(elem->in_sg), ARRAY_SIZE(elem->in_addr)),
> +                        1);
> +    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, &elem->out_num,
> +                        MIN(ARRAY_SIZE(elem->out_sg),
> +                        ARRAY_SIZE(elem->out_addr)),
> +                        0);

Coverity reports that ARRAY_SIZE(elem->out_sg) (and all the others too)
is wrong because elem->out_sg is a pointer.

However, the check is not in the right place and the max_size argument
of virtqueue_map_iovec can be removed.  The check on in_num/out_num can
be moved to qemu_get_virtqueue_element instead, before the call to
virtqueue_alloc_element.

Thanks,

Paolo
