Received: from eggs.gnu.org ([2001:4830:134:3::10]:32833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1csgf9-0006pQ-QU
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1csgf6-00045b-Jg
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:15:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:30734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1csgf6-00042g-5b
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 22:15:08 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 28 Mar 2017 02:15:03 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5670CD@SHSMSX103.ccr.corp.intel.com>
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
	<20170327202018.GH28620@stefanha-x1.localdomain>
In-Reply-To: <20170327202018.GH28620@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Tuesday, March 28, 2017 4:20 AM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: virtio-dev@lists.oasis-open.org; virtualization@lists.linux-foundatio=
n.org; linux-
> kernel@vger.kernel.org; hch@lst.de; qemu-devel@nongnu.org
> Subject: Re: [PATCH] virtio-blk: add DISCARD support to virtio-blk driver
>=20
> On Tue, Mar 28, 2017 at 04:39:25PM +0800, Changpeng Liu wrote:
> > Currently virtio-blk driver does not provide discard feature flag, so t=
he
> > filesystems which built on top of the block device will not send discar=
d
> > command. This is okay for HDD backend, but it will impact the performan=
ce
> > for SSD backend.
> >
> > Add a feature flag VIRTIO_BLK_F_DISCARD and command
> VIRTIO_BLK_T_DISCARD
> > to extend exist virtio-blk protocol. virtio-blk protocol uses a single
> > 8 bytes descriptor containing type,reserved and sector, currently Linux
> > uses the reserved field as IO priority, here we also re-use the reserve=
d
> > field as number of discard sectors.
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > ---
> >  drivers/block/virtio_blk.c      | 38 +++++++++++++++++++++++++++++----=
-----
> >  include/uapi/linux/virtio_blk.h | 12 ++++++++++--
> >  2 files changed, 39 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 1d4c9f8..550cfe7 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -241,6 +241,9 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hc=
tx,
> >  	case REQ_OP_FLUSH:
> >  		type =3D VIRTIO_BLK_T_FLUSH;
> >  		break;
> > +	case REQ_OP_DISCARD:
> > +		type =3D VIRTIO_BLK_T_DISCARD;
> > +		break;
> >  	case REQ_OP_SCSI_IN:
> >  	case REQ_OP_SCSI_OUT:
> >  		type =3D VIRTIO_BLK_T_SCSI_CMD;
> > @@ -256,16 +259,24 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *=
hctx,
> >  	vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, type);
> >  	vbr->out_hdr.sector =3D type ?
> >  		0 : cpu_to_virtio64(vblk->vdev, blk_rq_pos(req));
> > -	vbr->out_hdr.ioprio =3D cpu_to_virtio32(vblk->vdev, req_get_ioprio(re=
q));
> > +	vbr->out_hdr.u.ioprio =3D cpu_to_virtio32(vblk->vdev, req_get_ioprio(=
req));
> >
> >  	blk_mq_start_request(req);
> >
> > -	num =3D blk_rq_map_sg(hctx->queue, req, vbr->sg);
> > -	if (num) {
> > -		if (rq_data_dir(req) =3D=3D WRITE)
> > -			vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev,
> VIRTIO_BLK_T_OUT);
> > -		else
> > -			vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev,
> VIRTIO_BLK_T_IN);
> > +	if (type =3D=3D VIRTIO_BLK_T_DISCARD) {
> > +		vbr->out_hdr.u.discard_nr_sectors =3D cpu_to_virtio32(vblk->vdev,
> > +
> blk_rq_sectors(req));
> > +		num =3D 0;
> > +	} else {
> > +		num =3D blk_rq_map_sg(hctx->queue, req, vbr->sg);
> > +		if (num) {
> > +			if (rq_data_dir(req) =3D=3D WRITE)
> > +				vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev,
> > +
> VIRTIO_BLK_T_OUT);
> > +			else
> > +				vbr->out_hdr.type |=3D cpu_to_virtio32(vblk->vdev,
> > +
> VIRTIO_BLK_T_IN);
> > +		}
> >  	}
> >
> >  	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> > @@ -775,6 +786,15 @@ static int virtblk_probe(struct virtio_device *vde=
v)
> >  	if (!err && opt_io_size)
> >  		blk_queue_io_opt(q, blk_size * opt_io_size);
> >
> > +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> > +		q->limits.discard_zeroes_data =3D 0;
> > +		q->limits.discard_alignment =3D blk_size;
> > +		q->limits.discard_granularity =3D blk_size;
> > +		blk_queue_max_discard_sectors(q, UINT_MAX);
> > +		blk_queue_max_discard_segments(q, 1);
> > +		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
> > +	}
>=20
> Please add configuration space fields for these limits.  Looking at the
> virtio-scsi block limits code in QEMU's scsi_disk_emulate_inquiry() I
> can see that the hypervisor has useful values that it wants to
> communicate.  They shouldn't be hardcoded to blk_size.
Yes, move discard related parameters to configuration space make sense.
>=20
> > +
> >  	virtio_device_ready(vdev);
> >
> >  	device_add_disk(&vdev->dev, vblk->disk);
> > @@ -882,14 +902,14 @@ static int virtblk_restore(struct virtio_device *=
vdev)
> >  	VIRTIO_BLK_F_SCSI,
> >  #endif
> >  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
> VIRTIO_BLK_F_CONFIG_WCE,
> > -	VIRTIO_BLK_F_MQ,
> > +	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
> >  }
> >  ;
> >  static unsigned int features[] =3D {
> >  	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX,
> VIRTIO_BLK_F_GEOMETRY,
> >  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
> >  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
> VIRTIO_BLK_F_CONFIG_WCE,
> > -	VIRTIO_BLK_F_MQ,
> > +	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
> >  };
> >
> >  static struct virtio_driver virtio_blk =3D {
> > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virti=
o_blk.h
> > index 9ebe4d9..d608649 100644
> > --- a/include/uapi/linux/virtio_blk.h
> > +++ b/include/uapi/linux/virtio_blk.h
> > @@ -38,6 +38,7 @@
> >  #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
> >  #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is
> available */
> >  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
> > +#define VIRTIO_BLK_F_DISCARD	13	/* DISCARD command is supported
> */
> >
> >  /* Legacy feature bits */
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> > @@ -114,6 +115,9 @@ struct virtio_blk_config {
> >  /* Get device ID command */
> >  #define VIRTIO_BLK_T_GET_ID    8
> >
> > +/* Discard command */
> > +#define VIRTIO_BLK_T_DISCARD	16
> > +
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> >  /* Barrier before this op. */
> >  #define VIRTIO_BLK_T_BARRIER	0x80000000
> > @@ -127,8 +131,12 @@ struct virtio_blk_config {
> >  struct virtio_blk_outhdr {
> >  	/* VIRTIO_BLK_T* */
> >  	__virtio32 type;
> > -	/* io priority. */
> > -	__virtio32 ioprio;
> > +	union {
> > +		/* io priority. */
> > +		__virtio32 ioprio;
> > +		/* discard number of sectors */
> > +		__virtio32 discard_nr_sectors;
> > +	} u;
>=20
> DISCARD commands have no io priority?  Perhaps it's better to add an
> extended header.
What I think now is that, keep the ioprio field, and let DISCARD command ha=
s input data buffers, 16 bytes aligned descriptor for each
DISCARD segment(can support mult-range feature), and this is also aligned w=
ith SCSI and NVMe specification.
