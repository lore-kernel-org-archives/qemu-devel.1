Received: from eggs.gnu.org ([2001:4830:134:3::10]:32808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSdjN-0004hn-Nu
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSdjI-0004kx-RI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:24:09 -0400
Date: Wed, 5 Jul 2017 14:23:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170705062359.GC29382@lemon.lan>
References: <1499170866-9068-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499170866-9068-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: finalize IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, pbonzini@redhat.com, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, 07/04 20:21, Jason Wang wrote:
> After converting to use DMA api for virtio devices, we should use
> dma_as instead of address_space_memory. Otherwise it won't work if
> IOMMU is enabled.
> 
> Fixes: commit 8607f5c3072c ("virtio: convert to use DMA api")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index f46f06d..d076fe7 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -43,12 +43,13 @@ static inline SCSIDevice *virtio_scsi_device_find(VirtIOSCSI *s, uint8_t *lun)
>  
>  void virtio_scsi_init_req(VirtIOSCSI *s, VirtQueue *vq, VirtIOSCSIReq *req)
>  {
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>      const size_t zero_skip =
>          offsetof(VirtIOSCSIReq, resp_iov) + sizeof(req->resp_iov);
>  
>      req->vq = vq;
>      req->dev = s;
> -    qemu_sglist_init(&req->qsgl, DEVICE(s), 8, &address_space_memory);
> +    qemu_sglist_init(&req->qsgl, DEVICE(s), 8, vdev->dma_as);

Not related to this patch, but is our vIOMMU iotlb implementation safe for data
plane (both virtio-blk and virtio-scsi)? There we don't have BQL to synchronize
between IOVA lookup and update, which means threads can race when accessing the
iotlb GHashTable.

Did I overlook a synchronization mechanism? Or is it missing? Paolo, MST?

Fam

>      qemu_iovec_init(&req->resp_iov, 1);
>      memset((uint8_t *)req + zero_skip, 0, sizeof(*req) - zero_skip);
>  }
> -- 
> 2.7.4
> 
> 
