Received: from eggs.gnu.org ([209.51.188.92]:56210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gpEpj-0006ts-K0
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gpEpi-0008Hl-5f
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:04:55 -0500
Date: Thu, 31 Jan 2019 11:04:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190131103056-mutt-send-email-mst@kernel.org>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131151914.164903-4-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] virtio-blk: add DISCARD and WRITE
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org

On Thu, Jan 31, 2019 at 04:19:12PM +0100, Stefano Garzarella wrote:
> This patch adds the support of DISCARD and WRITE ZEROES commands,
> that have been introduced in the virtio-blk protocol to have
> better performance when using SSD backend.
> 
> We support only one segment per request since multiple segments
> are not widely used and there are no userspace APIs that allow
> applications to submit multiple segments in a single call.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


This does not seem to match the spec clarifications
that Stefan Hajnoczi has posted on
the virtio TC.

I think this can go any of the following ways:

- we agree that a request should have at most one segment
	no padding allowed
- we agree that a request should have at most one segment
	we require padding to 512 bytes
- we agree that a request should have at most one segment
	we also support padding to 512 bytes
- we agree that a request should have at most one segment
	we also support arbitrary padding
- we agree that a request can have any # of segments

I would also need your feedback on whether all this
is a material change to 1.1 public review according to the oasis definition:

	"Material Change" is any change to the content of a Work Product that
	that would require a compliant application or implementation to be
	modified or rewritten in order to remain compliant or which adds new
	features or otherwise expands the scope of the work product.


> ---
>  hw/block/virtio-blk.c          | 173 +++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-blk.h |   2 +
>  2 files changed, 175 insertions(+)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 542ec52536..34ee676895 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -147,6 +147,30 @@ out:
>      aio_context_release(blk_get_aio_context(s->conf.conf.blk));
>  }
>  
> +static void virtio_blk_discard_wzeroes_complete(void *opaque, int ret)
> +{
> +    VirtIOBlockReq *req = opaque;
> +    VirtIOBlock *s = req->dev;
> +    bool is_wzeroes = (virtio_ldl_p(VIRTIO_DEVICE(req->dev), &req->out.type) &
> +                       ~VIRTIO_BLK_T_BARRIER) == VIRTIO_BLK_T_WRITE_ZEROES;
> +
> +    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
> +    if (ret) {
> +        if (virtio_blk_handle_rw_error(req, -ret, 0, is_wzeroes)) {
> +            goto out;
> +        }
> +    }
> +
> +    virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> +    if (is_wzeroes) {
> +        block_acct_done(blk_get_stats(req->dev->blk), &req->acct);
> +    }
> +    virtio_blk_free_request(req);
> +
> +out:
> +    aio_context_release(blk_get_aio_context(s->conf.conf.blk));
> +}
> +
>  #ifdef __linux__
>  
>  typedef struct {
> @@ -480,6 +504,82 @@ static bool virtio_blk_sect_range_ok(VirtIOBlock *dev,
>      return true;
>  }
>  
> +static uint8_t virtio_blk_handle_dwz(VirtIOBlockReq *req, bool is_wzeroes,
> +    struct virtio_blk_discard_write_zeroes *dwz_hdr)
> +{
> +    VirtIOBlock *s = req->dev;
> +    uint64_t sector;
> +    uint32_t num_sectors, flags;
> +    uint8_t err_status;
> +    int bytes;
> +
> +    sector = virtio_ldq_p(VIRTIO_DEVICE(req->dev), &dwz_hdr->sector);
> +    num_sectors = virtio_ldl_p(VIRTIO_DEVICE(req->dev), &dwz_hdr->num_sectors);
> +    flags = virtio_ldl_p(VIRTIO_DEVICE(req->dev), &dwz_hdr->flags);
> +
> +    /*
> +     * dwz_max_sectors is at most BDRV_REQUEST_MAX_SECTORS, this check
> +     * make us sure that "num_sectors << BDRV_SECTOR_BITS" can fit in
> +     * the integer variable.
> +     */
> +    if (unlikely(num_sectors > s->conf.dwz_max_sectors)) {
> +        err_status = VIRTIO_BLK_S_IOERR;
> +        goto err;
> +    }
> +
> +    bytes = num_sectors << BDRV_SECTOR_BITS;
> +
> +    if (unlikely(!virtio_blk_sect_range_ok(req->dev, sector, bytes))) {
> +        err_status = VIRTIO_BLK_S_IOERR;
> +        goto err;
> +    }
> +
> +    /*
> +     * The device MUST set the status byte to VIRTIO_BLK_S_UNSUPP for discard
> +     * and write zeroes commands if any unknown flag is set.
> +     */
> +    if (unlikely(flags & ~VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP)) {
> +        err_status = VIRTIO_BLK_S_UNSUPP;
> +        goto err;
> +    }
> +
> +    if (is_wzeroes) { /* VIRTIO_BLK_T_WRITE_ZEROES */
> +        int blk_aio_flags = 0;
> +
> +        if (s->conf.wz_may_unmap &&
> +            flags & VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP) {
> +            blk_aio_flags |= BDRV_REQ_MAY_UNMAP;
> +        }
> +
> +        block_acct_start(blk_get_stats(req->dev->blk), &req->acct, bytes,
> +                         BLOCK_ACCT_WRITE);
> +
> +        blk_aio_pwrite_zeroes(req->dev->blk, sector << BDRV_SECTOR_BITS,
> +                              bytes, blk_aio_flags,
> +                              virtio_blk_discard_wzeroes_complete, req);
> +    } else { /* VIRTIO_BLK_T_DISCARD */
> +        /*
> +         * The device MUST set the status byte to VIRTIO_BLK_S_UNSUPP for
> +         * discard commands if the unmap flag is set.
> +         */
> +        if (unlikely(flags & VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP)) {
> +            err_status = VIRTIO_BLK_S_UNSUPP;
> +            goto err;
> +        }
> +
> +        blk_aio_pdiscard(req->dev->blk, sector << BDRV_SECTOR_BITS, bytes,
> +                         virtio_blk_discard_wzeroes_complete, req);
> +    }
> +
> +    return VIRTIO_BLK_S_OK;
> +
> +err:
> +    if (is_wzeroes) {
> +        block_acct_invalid(blk_get_stats(req->dev->blk), BLOCK_ACCT_WRITE);
> +    }
> +    return err_status;
> +}
> +
>  static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>  {
>      uint32_t type;
> @@ -586,6 +686,45 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>          virtio_blk_free_request(req);
>          break;
>      }
> +    /*
> +     * VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZEROES are defined with
> +     * VIRTIO_BLK_T_OUT flag set. We masked this flag in the switch statement,
> +     * so we must mask it for these requests, then we will check if it is set.
> +     */
> +    case VIRTIO_BLK_T_DISCARD & ~VIRTIO_BLK_T_OUT:
> +    case VIRTIO_BLK_T_WRITE_ZEROES & ~VIRTIO_BLK_T_OUT:
> +    {
> +        struct virtio_blk_discard_write_zeroes dwz_hdr;
> +        size_t out_len = iov_size(out_iov, out_num);
> +        bool is_wzeroes = (type & ~VIRTIO_BLK_T_BARRIER) ==
> +                          VIRTIO_BLK_T_WRITE_ZEROES;
> +        uint8_t err_status;
> +
> +        /*
> +         * Unsupported if VIRTIO_BLK_T_OUT is not set or the request contains
> +         * more than one segment.
> +         */
> +        if (unlikely(!(type & VIRTIO_BLK_T_OUT) ||
> +                     out_len > sizeof(dwz_hdr))) {
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> +            virtio_blk_free_request(req);
> +            return 0;
> +        }
> +
> +        if (unlikely(iov_to_buf(out_iov, out_num, 0, &dwz_hdr,
> +                                sizeof(dwz_hdr)) != sizeof(dwz_hdr))) {
> +            virtio_error(vdev, "virtio-blk discard/wzeroes header too short");
> +            return -1;
> +        }
> +
> +        err_status = virtio_blk_handle_dwz(req, is_wzeroes, &dwz_hdr);
> +        if (err_status != VIRTIO_BLK_S_OK) {
> +            virtio_blk_req_complete(req, err_status);
> +            virtio_blk_free_request(req);
> +        }
> +
> +        break;
> +    }
>      default:
>          virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
>          virtio_blk_free_request(req);
> @@ -765,6 +904,22 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      blkcfg.alignment_offset = 0;
>      blkcfg.wce = blk_enable_write_cache(s->blk);
>      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> +    if (s->conf.discard_wzeroes) {
> +        virtio_stl_p(vdev, &blkcfg.max_discard_sectors,
> +                     s->conf.dwz_max_sectors);
> +        virtio_stl_p(vdev, &blkcfg.discard_sector_alignment,
> +                     blk_size >> BDRV_SECTOR_BITS);
> +        virtio_stl_p(vdev, &blkcfg.max_write_zeroes_sectors,
> +                     s->conf.dwz_max_sectors);
> +        blkcfg.write_zeroes_may_unmap = s->conf.wz_may_unmap;
> +        /*
> +         * We support only one segment per request since multiple segments
> +         * are not widely used and there are no userspace APIs that allow
> +         * applications to submit multiple segments in a single call.
> +         */
> +        virtio_stl_p(vdev, &blkcfg.max_discard_seg, 1);
> +        virtio_stl_p(vdev, &blkcfg.max_write_zeroes_seg, 1);
> +    }
>      memcpy(config, &blkcfg, sizeof(struct virtio_blk_config));
>  }
>  
> @@ -811,6 +966,10 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
>      if (s->conf.num_queues > 1) {
>          virtio_add_feature(&features, VIRTIO_BLK_F_MQ);
>      }
> +    if (s->conf.discard_wzeroes) {
> +        virtio_add_feature(&features, VIRTIO_BLK_F_DISCARD);
> +        virtio_add_feature(&features, VIRTIO_BLK_F_WRITE_ZEROES);
> +    }
>  
>      return features;
>  }
> @@ -956,6 +1115,16 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    if (conf->discard_wzeroes) {
> +        if (!conf->dwz_max_sectors ||
> +            conf->dwz_max_sectors > BDRV_REQUEST_MAX_SECTORS) {
> +            error_setg(errp, "invalid dwz-max-sectors property (%" PRIu32 "), "
> +                       "must be between 1 and %lu",
> +                       conf->dwz_max_sectors, BDRV_REQUEST_MAX_SECTORS);
> +            return;
> +        }
> +    }
> +
>      virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
>                  sizeof(struct virtio_blk_config));
>  
> @@ -1028,6 +1197,10 @@ static Property virtio_blk_properties[] = {
>                       IOThread *),
>      DEFINE_PROP_BIT("discard-wzeroes", VirtIOBlock, conf.discard_wzeroes, 0,
>                       true),
> +    DEFINE_PROP_UINT32("discard-wzeroes-max-sectors", VirtIOBlock,
> +                       conf.dwz_max_sectors, BDRV_REQUEST_MAX_SECTORS),
> +    DEFINE_PROP_BIT("wzeroes-may-unmap", VirtIOBlock, conf.wz_may_unmap, 0,
> +                    true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> index c336afb4cd..4e9d4434ff 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -41,6 +41,8 @@ struct VirtIOBlkConf
>      uint16_t num_queues;
>      uint16_t queue_size;
>      uint32_t discard_wzeroes;
> +    uint32_t dwz_max_sectors;
> +    uint32_t wz_may_unmap;
>  };
>  
>  struct VirtIOBlockDataPlane;
> -- 
> 2.20.1
