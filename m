Received: from eggs.gnu.org ([209.51.188.92]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gn37q-0003tP-Ie
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gn2wd-0000RY-5b
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:59:00 -0500
Date: Fri, 25 Jan 2019 14:58:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190125145856.GC28305@stefanha-x1.localdomain>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
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


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2019 at 06:23:22PM +0100, Stefano Garzarella wrote:
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

"The data used for discard or write zeroes command is described by one
or more virtio_blk_discard_write_zeroes structs."

This needs to be a loop so that multiple dwz structs can be processed up
to the length of virtio_blk_req->data[].

> +            virtio_error(vdev, "virtio-blk discard/wzeroes header too short");
> +            return -1;
> +        }
> +
> +        sector = virtio_ldq_p(VIRTIO_DEVICE(req->dev), &dwz_hdr.sector);
> +        bytes = virtio_ldl_p(VIRTIO_DEVICE(req->dev),
> +                             &dwz_hdr.num_sectors) << BDRV_SECTOR_BITS;

Please handle num_sectors << BDRV_SECTOR_BITS overflow so that we don't
need to worry about what happens with an overflowed value later on.

> +
> +        if (!virtio_blk_sect_range_ok(req->dev, sector, bytes)) {
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_IOERR);
> +            virtio_blk_free_request(req);
> +            return 0;
> +        }
> +
> +        if ((type & ~(VIRTIO_BLK_T_BARRIER)) == VIRTIO_BLK_T_DISCARD) {

Missing device requirement: "the device MUST set the status byte to VIRTIO_BLK_S_UNSUPP for discard commands if the unmap flag is set."

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

Please add block_acct_start(), this is treated as a write.

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

Please check hw/scsi/scsi-disk.c for an example of how to initialize
these limits.  It should be possible to set some of them via s->conf so
I'm surprised so many fields are hardcoded in this patch.

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSyQwAAoJEJykq7OBq3PIW6QH/1g6SZokGKaxp/6IStD2RCFk
SP5BfRaKwLiIM600U6gl4vglhkzUxATAqzBBlnyXhQg7PW1ZNYbCGaI+taKc7tSP
BL6/qmsn+r3OSALyjeWJMdU6T2j7pkPn2rT2EYLx+iH0y0rGlIZFo+Ajx1/UuWX1
NLtg+5c8JR3sdelvrdFMKexhPcaCSsFj6/Ez3NYCNgzQORJKtvMGrol1cC8GW4zb
jqkfrIfGgQN7ZpfHoQXiiN5TQ3mboZu9/Jr2mYHutg//NdV3hdULbPpwPSBKoe0J
pmd5y35IztMebH2cBaxUHnFZo1rpK5H0pvWKIgTpROcy0x15jOliaMHuArBmhTU=
=ipas
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
