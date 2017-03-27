Received: from eggs.gnu.org ([2001:4830:134:3::10]:39272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csb7u-0006LF-Ic
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csb7p-0006KI-KH
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:20:30 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1csb7p-0006K3-BT
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 16:20:25 -0400
Received: by mail-wr0-x243.google.com with SMTP id 20so16592220wrx.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 13:20:25 -0700 (PDT)
Date: Mon, 27 Mar 2017 21:20:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170327202018.GH28620@stefanha-x1.localdomain>
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Content-Disposition: inline
In-Reply-To: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: add DISCARD support to
 virtio-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de, qemu-devel@nongnu.org


--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 04:39:25PM +0800, Changpeng Liu wrote:
> Currently virtio-blk driver does not provide discard feature flag, so the
> filesystems which built on top of the block device will not send discard
> command. This is okay for HDD backend, but it will impact the performance
> for SSD backend.
>=20
> Add a feature flag VIRTIO_BLK_F_DISCARD and command VIRTIO_BLK_T_DISCARD
> to extend exist virtio-blk protocol. virtio-blk protocol uses a single
> 8 bytes descriptor containing type,reserved and sector, currently Linux
> uses the reserved field as IO priority, here we also re-use the reserved
> field as number of discard sectors.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  drivers/block/virtio_blk.c      | 38 +++++++++++++++++++++++++++++------=
---
>  include/uapi/linux/virtio_blk.h | 12 ++++++++++--
>  2 files changed, 39 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 1d4c9f8..550cfe7 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -241,6 +241,9 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	case REQ_OP_FLUSH:
>  		type =3D VIRTIO_BLK_T_FLUSH;
>  		break;
> +	case REQ_OP_DISCARD:
> +		type =3D VIRTIO_BLK_T_DISCARD;
> +		break;
>  	case REQ_OP_SCSI_IN:
>  	case REQ_OP_SCSI_OUT:
>  		type =3D VIRTIO_BLK_T_SCSI_CMD;
> @@ -256,16 +259,24 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hc=
tx,
>  	vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, type);
>  	vbr->out_hdr.sector =3D type ?
>  		0 : cpu_to_virtio64(vblk->vdev, blk_rq_pos(req));
> -	vbr->out_hdr.ioprio =3D cpu_to_virtio32(vblk->vdev, req_get_ioprio(req)=
);
> +	vbr->out_hdr.u.ioprio =3D cpu_to_virtio32(vblk->vdev, req_get_ioprio(re=
q));
> =20
>  	blk_mq_start_request(req);
> =20
> -	num =3D blk_rq_map_sg(hctx->queue, req, vbr->sg);
> -	if (num) {
> -		if (rq_data_dir(req) =3D=3D WRITE)
> -			vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_OUT);
> -		else
> -			vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_IN);
> +	if (type =3D=3D VIRTIO_BLK_T_DISCARD) {
> +		vbr->out_hdr.u.discard_nr_sectors =3D cpu_to_virtio32(vblk->vdev,
> +								    blk_rq_sectors(req));
> +		num =3D 0;
> +	} else {
> +		num =3D blk_rq_map_sg(hctx->queue, req, vbr->sg);
> +		if (num) {
> +			if (rq_data_dir(req) =3D=3D WRITE)
> +				vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev,
> +								     VIRTIO_BLK_T_OUT);
> +			else
> +				vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev,
> +								     VIRTIO_BLK_T_IN);
> +		}
>  	}
> =20
>  	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> @@ -775,6 +786,15 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	if (!err && opt_io_size)
>  		blk_queue_io_opt(q, blk_size * opt_io_size);
> =20
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> +		q->limits.discard_zeroes_data =3D 0;
> +		q->limits.discard_alignment =3D blk_size;
> +		q->limits.discard_granularity =3D blk_size;
> +		blk_queue_max_discard_sectors(q, UINT_MAX);
> +		blk_queue_max_discard_segments(q, 1);
> +		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
> +	}

Please add configuration space fields for these limits.  Looking at the
virtio-scsi block limits code in QEMU's scsi_disk_emulate_inquiry() I
can see that the hypervisor has useful values that it wants to
communicate.  They shouldn't be hardcoded to blk_size.

> +
>  	virtio_device_ready(vdev);
> =20
>  	device_add_disk(&vdev->dev, vblk->disk);
> @@ -882,14 +902,14 @@ static int virtblk_restore(struct virtio_device *vd=
ev)
>  	VIRTIO_BLK_F_SCSI,
>  #endif
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
> -	VIRTIO_BLK_F_MQ,
> +	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
>  }
>  ;
>  static unsigned int features[] =3D {
>  	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
> -	VIRTIO_BLK_F_MQ,
> +	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
>  };
> =20
>  static struct virtio_driver virtio_blk =3D {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_=
blk.h
> index 9ebe4d9..d608649 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -38,6 +38,7 @@
>  #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
>  #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
> +#define VIRTIO_BLK_F_DISCARD	13	/* DISCARD command is supported */
> =20
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -114,6 +115,9 @@ struct virtio_blk_config {
>  /* Get device ID command */
>  #define VIRTIO_BLK_T_GET_ID    8
> =20
> +/* Discard command */
> +#define VIRTIO_BLK_T_DISCARD	16
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000
> @@ -127,8 +131,12 @@ struct virtio_blk_config {
>  struct virtio_blk_outhdr {
>  	/* VIRTIO_BLK_T* */
>  	__virtio32 type;
> -	/* io priority. */
> -	__virtio32 ioprio;
> +	union {
> +		/* io priority. */
> +		__virtio32 ioprio;
> +		/* discard number of sectors */
> +		__virtio32 discard_nr_sectors;
> +	} u;

DISCARD commands have no io priority?  Perhaps it's better to add an
extended header.

--0OWHXb1mYLuhj1Ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2XQCAAoJEJykq7OBq3PImHoIALPVWiFF4/dYtmbsdwJ7I0YZ
KcaflfM8whVxKTXEV3t0WCJCms+6rQEbxWhO92x3O5vvy2bpgSFVGb8kby+3mJa+
IlQDla+3DOtJw7wTWEk76fY8Nuk/HUGbPiJ9cfVl1iyc6ZGwJIR1dAmjK8Sf9U2h
kxgz5NGUOGhb/BKhIAtT73dGMN3GBJWzCXi82Di657a6EyCk4tbjRZoZep6inApg
3cCebuU39AKqqzI7H9PxLWjyTbB2P6p38m04odq9R++BBmIogDUXdxLhc/EV/iTI
uzgXe8JbtNSIX0xgEQ+Lial3aaQhylsvx/wcr1Zk1JPzPAL7SHY+WyoxSpJjwZM=
=Hr5i
-----END PGP SIGNATURE-----

--0OWHXb1mYLuhj1Ox--
