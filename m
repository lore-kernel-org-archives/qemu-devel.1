Received: from eggs.gnu.org ([209.51.188.92]:47647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmjEL-00034k-UK
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmjEK-0000w6-Oy
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:55:57 -0500
Date: Thu, 24 Jan 2019 17:55:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190124175533.GC2404@work-vm>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124172323.230296-2-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

* Stefano Garzarella (sgarzare@redhat.com) wrote:
> This patch adds the support of DISCARD and WRITE ZEROES commands,
> that have been introduced in the virtio-blk protocol to have
> better performance when using SSD backend.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Hi,
  Do you need to make those features machine-type dependent
so that a VM started on a nice new qemu with this feature doesn't
get confused when live migrated back to an older version?

Dave

> ---
>  hw/block/virtio-blk.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index f208c6ddb9..8850957751 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -145,6 +145,25 @@ out:
>      aio_context_release(blk_get_aio_context(s->conf.conf.blk));
>  }
>  
> +static void virtio_blk_discard_wzeroes_complete(void *opaque, int ret)
> +{
> +    VirtIOBlockReq *req = opaque;
> +    VirtIOBlock *s = req->dev;
> +
> +    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
> +    if (ret) {
> +        if (virtio_blk_handle_rw_error(req, -ret, 0)) {
> +            goto out;
> +        }
> +    }
> +
> +    virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> +    virtio_blk_free_request(req);
> +
> +out:
> +    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
> +}
> +
>  #ifdef __linux__
>  
>  typedef struct {
> @@ -584,6 +603,56 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>          virtio_blk_free_request(req);
>          break;
>      }
> +    /*
> +     * VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZEROES are defined with
> +     * VIRTIO_BLK_T_OUT flag set. We masked this flag in the switch statement,
> +     * so we must mask it for these requests, then we will check the type.
> +     */
> +    case VIRTIO_BLK_T_DISCARD & ~VIRTIO_BLK_T_OUT:
> +    case VIRTIO_BLK_T_WRITE_ZEROES & ~VIRTIO_BLK_T_OUT:
> +    {
> +        struct virtio_blk_discard_write_zeroes dwz_hdr;
> +        uint64_t sector;
> +        int bytes;
> +
> +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &dwz_hdr,
> +                                sizeof(dwz_hdr)) != sizeof(dwz_hdr))) {
> +            virtio_error(vdev, "virtio-blk discard/wzeroes header too short");
> +            return -1;
> +        }
> +
> +        sector = virtio_ldq_p(VIRTIO_DEVICE(req->dev), &dwz_hdr.sector);
> +        bytes = virtio_ldl_p(VIRTIO_DEVICE(req->dev),
> +                             &dwz_hdr.num_sectors) << BDRV_SECTOR_BITS;
> +
> +        if (!virtio_blk_sect_range_ok(req->dev, sector, bytes)) {
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_IOERR);
> +            virtio_blk_free_request(req);
> +            return 0;
> +        }
> +
> +        if ((type & ~(VIRTIO_BLK_T_BARRIER)) == VIRTIO_BLK_T_DISCARD) {
> +            blk_aio_pdiscard(req->dev->blk, sector << BDRV_SECTOR_BITS, bytes,
> +                             virtio_blk_discard_wzeroes_complete, req);
> +        } else if ((type & ~(VIRTIO_BLK_T_BARRIER)) ==
> +                   VIRTIO_BLK_T_WRITE_ZEROES) {
> +            int flags = 0;
> +
> +            if (virtio_ldl_p(VIRTIO_DEVICE(req->dev), &dwz_hdr.flags) &
> +                VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP) {
> +                flags |= BDRV_REQ_MAY_UNMAP;
> +            }
> +
> +            blk_aio_pwrite_zeroes(req->dev->blk, sector << BDRV_SECTOR_BITS,
> +                                  bytes, flags,
> +                                  virtio_blk_discard_wzeroes_complete, req);
> +        } else { /* Unsupported if VIRTIO_BLK_T_OUT is not set */
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> +            virtio_blk_free_request(req);
> +        }
> +
> +        break;
> +    }
>      default:
>          virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
>          virtio_blk_free_request(req);
> @@ -763,6 +832,14 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      blkcfg.alignment_offset = 0;
>      blkcfg.wce = blk_enable_write_cache(s->blk);
>      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> +    virtio_stl_p(vdev, &blkcfg.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS);
> +    virtio_stl_p(vdev, &blkcfg.max_discard_seg, 1);
> +    virtio_stl_p(vdev, &blkcfg.discard_sector_alignment,
> +                 blk_size >> BDRV_SECTOR_BITS);
> +    virtio_stl_p(vdev, &blkcfg.max_write_zeroes_sectors,
> +                 BDRV_REQUEST_MAX_SECTORS);
> +    virtio_stl_p(vdev, &blkcfg.max_write_zeroes_seg, 1);
> +    blkcfg.write_zeroes_may_unmap = 1;
>      memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
>  }
>  
> @@ -787,6 +864,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
>      virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
>      virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
>      virtio_add_feature(&features, VIRTIO_BLK_F_BLK_SIZE);
> +    virtio_add_feature(&features, VIRTIO_BLK_F_DISCARD);
> +    virtio_add_feature(&features, VIRTIO_BLK_F_WRITE_ZEROES);
>      if (virtio_has_feature(features, VIRTIO_F_VERSION_1)) {
>          if (s->conf.scsi) {
>              error_setg(errp, "Please set scsi=off for virtio-blk devices in order to use virtio 1.0");
> -- 
> 2.20.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
