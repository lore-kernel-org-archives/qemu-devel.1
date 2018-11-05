Received: from eggs.gnu.org ([2001:4830:134:3::10]:50656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gJacT-0004gN-Lb
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:52:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gJaRM-0000Bn-6j
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:41:00 -0500
References: <1541139396-4727-1-git-send-email-dongli.zhang@oracle.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <1b8261f5-ddc8-7863-7a0a-0177c022787f@redhat.com>
Date: Mon, 5 Nov 2018 09:40:48 +0100
MIME-Version: 1.0
In-Reply-To: <1541139396-4727-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 1/1] virtio: pass argument
 by value for virtqueue_map_iovec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

CC: Paolo as the use of modified num_sg has been removed by his patch:

  3b3b062821 virtio: slim down allocation of VirtQueueElements

On 02/11/2018 07:16, Dongli Zhang wrote:
> Pass num_sg by value instead of by pointer, as num_sg is never modified in
> virtqueue_map_iovec().
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hw/virtio/virtio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4136d23..a5cb4e6 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -796,13 +796,13 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
>  }
>  
>  static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
> -                                hwaddr *addr, unsigned int *num_sg,
> +                                hwaddr *addr, unsigned int num_sg,
>                                  int is_write)
>  {
>      unsigned int i;
>      hwaddr len;
>  
> -    for (i = 0; i < *num_sg; i++) {
> +    for (i = 0; i < num_sg; i++) {
>          len = sg[i].iov_len;
>          sg[i].iov_base = dma_memory_map(vdev->dma_as,
>                                          addr[i], &len, is_write ?
> @@ -821,8 +821,8 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
>  
>  void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
>  {
> -    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, &elem->in_num, 1);
> -    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, &elem->out_num, 0);
> +    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num, 1);
> +    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, elem->out_num, 0);
>  }
>  
>  static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
> 
