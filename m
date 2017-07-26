Received: from eggs.gnu.org ([2001:4830:134:3::10]:47288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daJf1-0000hi-H9
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daJew-0008UP-AM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:35:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1daJew-0008U7-0f
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:35:18 -0400
Date: Wed, 26 Jul 2017 11:35:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726103513.GB18489@stefanha-x1.localdomain>
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, felipe@nutanix.com, mst@redhat.com


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 27, 2017 at 10:00:50AM +0800, Changpeng Liu wrote:
> +static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
> +{
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    struct virtio_blk_config blkcfg;
> +
> +    memcpy(&blkcfg, config, sizeof(blkcfg));
> +
> +    if (blkcfg.wce != s->config_wce) {
> +        error_report("vhost-user-blk: does not support the operation");

If vhost-user-blk doesn't support the operation then please remove the
VIRTIO_BLK_F_CONFIG_WCE feature bit.  That way the guest knows it cannot
modify this field.

> +static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    int ret;
> +    uint64_t size;
> +
> +    if (!s->chardev.chr) {
> +        error_setg(errp, "vhost-user-blk: chardev is mandatary");

mandatory

> +        return;
> +    }
> +
> +    if (!s->num_queues) {
> +        error_setg(errp, "vhost-user-blk: invalid number of IO queues");
> +        return;
> +    }
> +
> +    if (!s->queue_size) {
> +        error_setg(errp, "vhost-user-blk: invalid count of the IO queue");

"count of the IO queue" sounds like number of queues.  I suggest saying
"queue size must be non-zero".

> +        return;
> +    }
> +
> +    if (!s->size) {
> +        error_setg(errp, "vhost-user-blk: block capacity must be assigned,"
> +                  "size can be specified by GiB or MiB");
> +        return;
> +    }
> +
> +    ret = qemu_strtosz_MiB(s->size, NULL, &size);
> +    if (ret < 0) {
> +        error_setg(errp, "vhost-user-blk: invalid size %s in GiB/MiB", s->size);
> +        return;
> +    }
> +    s->capacity = size / 512;
> +
> +    /* block size with default 512 Bytes */
> +    if (!s->blkcfg.logical_block_size) {
> +        s->blkcfg.logical_block_size = 512;
> +    }
> +
> +    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
> +                sizeof(struct virtio_blk_config));
> +    virtio_add_queue(vdev, s->queue_size, vhost_user_blk_handle_output);
> +
> +    s->dev.nvqs = s->num_queues;
> +    s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);

Please test multi-queue, it's currently broken.  virtio_add_queue() must
be called for each queue.

> +    s->dev.vq_index = 0;
> +    s->dev.backend_features = 0;
> +
> +    ret = vhost_dev_init(&s->dev, (void *)&s->chardev,

The compiler automatically converts any pointer type to void * without a
warning in C.  (This is different from C++!)

The (void *) cast can be dropped.

> +                         VHOST_BACKEND_TYPE_USER, 0);
> +    if (ret < 0) {
> +        error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
> +                   strerror(-ret));

If realize fails unrealize() will not be called.  Cleanup must be
performed here.

> +        return;
> +    }
> +}
> +
> +static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBlk *s = VHOST_USER_BLK(dev);
> +
> +    vhost_user_blk_set_status(vdev, 0);
> +    vhost_dev_cleanup(&s->dev);
> +    g_free(s->dev.vqs);
> +    virtio_cleanup(vdev);
> +}
> +
> +static void vhost_user_blk_instance_init(Object *obj)
> +{
> +    VHostUserBlk *s = VHOST_USER_BLK(obj);
> +
> +    device_add_bootindex_property(obj, &s->bootindex, "bootindex",
> +                                  "/disk@0,0", DEVICE(obj), NULL);
> +}
> +
> +static const VMStateDescription vmstate_vhost_user_blk = {
> +    .name = "vhost-user-blk",
> +    .minimum_version_id = 2,
> +    .version_id = 2,

Why is version_id 2?  There has never been a vhost-user-blk device in
qemu.git before, so I would expect version to be 1.

> +    .fields = (VMStateField[]) {
> +        VMSTATE_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static Property vhost_user_blk_properties[] = {
> +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> +    DEFINE_BLOCK_PROPERTIES(VHostUserBlk, blkcfg),

DEFINE_BLOCK_PROPERTIES cannot be used directly because it includes the
'drive' (blkcfg.blk) parameter.  The command-line should not allow a
drive= parameter.

Also, parameters like the discard granularity, optimal I/O size, logical
block size, etc can be initialized to sensible defaults by QEMU's block
layer when drive= is used.  Since you are bypassing QEMU's block layer
there is no way for QEMU to set good defaults.

Are you relying on the managment tools populating these parameters with
the correct values from the vhost-user-blk process?  Or did you have
some other mechanism in mind?

> +    DEFINE_BLOCK_CHS_PROPERTIES(VHostUserBlk, blkcfg),
> +    DEFINE_PROP_STRING("size", VHostUserBlk, size),

virtio-blk supports online resize.  QEMU and the vhost-user-blk process
need a way to exchange disk capacity information for online resize.

Please add the necessary vhost-user protocol messages now so size
information can be automatically exchanged and updated for resize.

> +typedef struct VHostUserBlk {
> +    VirtIODevice parent_obj;
> +    CharBackend chardev;
> +    Error *migration_blocker;

This field is unused, please drop it.

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeHBhAAoJEJykq7OBq3PIFMAH/jLE8FUXK+a/9zDxXW3yiv7H
mLCysqwPOXDp08xFYtKzmB66q4pyCxxaoN5eO7C3yIm7MxtAzHsF+g5HnQaJfR9i
W/uvIYdivMGVUpSFEzhjc81nOMpN5VW0HNsPR2rtBzTWYL7do3+LiaORHjzU9iQM
bMLfx/5cKh4rxq/gX4mXzIgZlBjgoBZ5QA983KB1awu39/yPANtBWjWiwKVaBFS/
wkp6bOG0+PPAVkMLZjQQjAwcTJKh6Hkh86iipj11zgRxm/iFSK1KFLNxkJuF5CPE
e3ZuWGHZr3IzTdDeKdWZp2WRL0dzxkc/ChQDRAyRss04fFO60zs8iZAqcMIfdyA=
=GUR/
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
