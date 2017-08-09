Received: from eggs.gnu.org ([2001:4830:134:3::10]:35309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfUVG-0002r8-7V
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfUVC-0000U9-3r
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfUVB-0000TP-Li
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:10:37 -0400
Date: Wed, 9 Aug 2017 20:10:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170809194506-mutt-send-email-mst@kernel.org>
References: <1502359951-29160-1-git-send-email-changpeng.liu@intel.com>
	<1502359951-29160-3-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502359951-29160-3-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] vhost-user-blk: introduce a new
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
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

I only had time for a quick look. More review when
you repost after release.


On Thu, Aug 10, 2017 at 06:12:29PM +0800, Changpeng Liu wrote:
> This commit introduces a new vhost-user device for block, it uses a
> chardev to connect with the backend, same with Qemu virito-blk device,
> Guest OS still uses the virtio-blk frontend driver.
> 
> To use it, start Qemu with command line like this:
> 
> qemu-system-x86_64 \
>     -chardev socket,id=char0,path=/path/vhost.socket \
>     -device vhost-user-blk-pci,chardev=char0,num_queues=...
> 
> Different with exist Qemu virtio-blk host device, it makes more easy
> for users to implement their own I/O processing logic, such as all
> user space I/O stack against hardware block device. It uses the new
> vhost messages(VHOST_USER_GET_CONFIG) to get block virtio config
> information from backend process.

I took a quick look. I think I would prefer a more direct approach
where qemu is more of a driver. So user specifies properties and
they get sent to backend at init time. Only handle geometry changes
specially.

> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  configure                          |  11 ++
>  hw/block/Makefile.objs             |   3 +
>  hw/block/vhost-user-blk.c          | 360 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c             |  55 ++++++
>  hw/virtio/virtio-pci.h             |  18 ++
>  include/hw/virtio/vhost-user-blk.h |  40 +++++
>  6 files changed, 487 insertions(+)
>  create mode 100644 hw/block/vhost-user-blk.c
>  create mode 100644 include/hw/virtio/vhost-user-blk.h
> 
> diff --git a/configure b/configure
> index dd73cce..1452c66 100755
> --- a/configure
> +++ b/configure
> @@ -305,6 +305,7 @@ tcg="yes"
>  
>  vhost_net="no"
>  vhost_scsi="no"
> +vhost_user_blk="no"
>  vhost_vsock="no"
>  vhost_user=""
>  kvm="no"
> @@ -779,6 +780,7 @@ Linux)
>    kvm="yes"
>    vhost_net="yes"
>    vhost_scsi="yes"
> +  vhost_user_blk="yes"
>    vhost_vsock="yes"
>    QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
>    supported_os="yes"
> @@ -1136,6 +1138,10 @@ for opt do
>    ;;
>    --enable-vhost-scsi) vhost_scsi="yes"
>    ;;
> +  --disable-vhost-user-blk) vhost_user_blk="no"
> +  ;;
> +  --enable-vhost-user-blk) vhost_user_blk="yes"
> +  ;;
>    --disable-vhost-vsock) vhost_vsock="no"
>    ;;
>    --enable-vhost-vsock) vhost_vsock="yes"
> @@ -1506,6 +1512,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    cap-ng          libcap-ng support
>    attr            attr and xattr support
>    vhost-net       vhost-net acceleration support
> +  vhost-user-blk  VM virtio-blk acceleration in user space
>    spice           spice
>    rbd             rados block device (rbd)
>    libiscsi        iscsi support
> @@ -5365,6 +5372,7 @@ echo "posix_madvise     $posix_madvise"
>  echo "libcap-ng support $cap_ng"
>  echo "vhost-net support $vhost_net"
>  echo "vhost-scsi support $vhost_scsi"
> +echo "vhost-user-blk support $vhost_user_blk"
>  echo "vhost-vsock support $vhost_vsock"
>  echo "vhost-user support $vhost_user"
>  echo "Trace backends    $trace_backends"
> @@ -5776,6 +5784,9 @@ fi
>  if test "$vhost_scsi" = "yes" ; then
>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>  fi
> +if test "$vhost_user_blk" = "yes" ; then
> +  echo "CONFIG_VHOST_USER_BLK=y" >> $config_host_mak
> +fi
>  if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
>    echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
>  fi
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index e0ed980..4c19a58 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -13,3 +13,6 @@ obj-$(CONFIG_SH4) += tc58128.o
>  
>  obj-$(CONFIG_VIRTIO) += virtio-blk.o
>  obj-$(CONFIG_VIRTIO) += dataplane/
> +ifeq ($(CONFIG_VIRTIO),y)
> +obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
> +endif
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> new file mode 100644
> index 0000000..8aa9fa9
> --- /dev/null
> +++ b/hw/block/vhost-user-blk.c
> @@ -0,0 +1,360 @@
> +/*
> + * vhost-user-blk host device
> + *
> + * Copyright IBM, Corp. 2011
> + * Copyright(C) 2017 Intel Corporation.
> + *
> + * Authors:
> + *  Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> + *  Changpeng Liu <changpeng.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/typedefs.h"
> +#include "qemu/cutils.h"
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user-blk.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/virtio-access.h"
> +
> +static const int user_feature_bits[] = {
> +    VIRTIO_BLK_F_SIZE_MAX,
> +    VIRTIO_BLK_F_SEG_MAX,
> +    VIRTIO_BLK_F_GEOMETRY,
> +    VIRTIO_BLK_F_BLK_SIZE,
> +    VIRTIO_BLK_F_TOPOLOGY,
> +    VIRTIO_BLK_F_SCSI,

I don't think we want to support this.


> +    VIRTIO_BLK_F_MQ,
> +    VIRTIO_BLK_F_RO,
> +    VIRTIO_BLK_F_FLUSH,
> +    VIRTIO_BLK_F_BARRIER,
> +    VIRTIO_BLK_F_WCE,
> +    VIRTIO_F_VERSION_1,

How about forcing all remotes to implement this instead?

> +    VIRTIO_RING_F_INDIRECT_DESC,
> +    VIRTIO_RING_F_EVENT_IDX,
> +    VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VHOST_INVALID_FEATURE_BIT

No reason to let remote play with that.

> +};

I think a more reasonable set of features is what Linux uses:

        VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
        VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
        VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
        VIRTIO_BLK_F_MQ,

and maybe
>     VIRTIO_RING_F_INDIRECT_DESC,
>     VIRTIO_RING_F_EVENT_IDX,

others should be forced by qemu.


> +
> +static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +
> +    memcpy(config, &s->blkcfg, sizeof(struct virtio_blk_config));
> +}
> +
> +static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
> +{
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    struct virtio_blk_config *blkcfg = (struct virtio_blk_config *)config;
> +    int ret;
> +
> +    if (blkcfg->wce == s->blkcfg.wce) {
> +        return;
> +    }
> +
> +    ret = vhost_dev_set_config(&s->dev, config,
> +                              sizeof(struct virtio_blk_config));
> +    if (ret) {
> +        error_report("set device config space failed");
> +        return;
> +    }
> +
> +    s->blkcfg.wce = blkcfg->wce;
> +}
> +
> +static void vhost_user_blk_handle_config_change(struct vhost_dev *dev)
> +{
> +    int ret;
> +    struct virtio_blk_config blkcfg;
> +    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
> +
> +    ret = vhost_dev_get_config(dev, (uint8_t *)&blkcfg,
> +                               sizeof(struct virtio_blk_config));
> +    if (ret < 0) {
> +        error_report("get config space failed");
> +        return;
> +    }
> +
> +    memcpy(&s->blkcfg, &blkcfg, sizeof(struct virtio_blk_config));
> +    memcpy(dev->vdev->config, &blkcfg, sizeof(struct virtio_blk_config));

Will break if virtio_blk_config becomes larger than 256
bytes. Better add a build time assertion.

> +
> +    virtio_notify_config(dev->vdev);
> +}
> +
> +const VhostDevConfigOps blk_ops = {
> +    .vhost_dev_config_notifier = vhost_user_blk_handle_config_change,
> +};
> +
> +static void vhost_user_blk_start(VirtIODevice *vdev)
> +{
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +    int i, ret;
> +
> +    if (!k->set_guest_notifiers) {
> +        error_report("binding does not support guest notifiers");
> +        return;
> +    }
> +
> +    ret = vhost_dev_enable_notifiers(&s->dev, vdev);
> +    if (ret < 0) {
> +        error_report("Error enabling host notifiers: %d", -ret);
> +        return;
> +    }
> +
> +    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, true);
> +    if (ret < 0) {
> +        error_report("Error binding guest notifier: %d", -ret);
> +        goto err_host_notifiers;
> +    }
> +
> +    s->dev.acked_features = vdev->guest_features;
> +    ret = vhost_dev_start(&s->dev, vdev);
> +    if (ret < 0) {
> +        error_report("Error starting vhost: %d", -ret);
> +        goto err_guest_notifiers;
> +    }
> +
> +    /* guest_notifier_mask/pending not used yet, so just unmask
> +     * everything here. virtio-pci will do the right thing by
> +     * enabling/disabling irqfd.
> +     */
> +    for (i = 0; i < s->dev.nvqs; i++) {
> +        vhost_virtqueue_mask(&s->dev, vdev, i, false);
> +    }
> +
> +    return;
> +
> +err_guest_notifiers:
> +    k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> +err_host_notifiers:
> +    vhost_dev_disable_notifiers(&s->dev, vdev);
> +}
> +
> +static void vhost_user_blk_stop(VirtIODevice *vdev)
> +{
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +    int ret;
> +
> +    if (!k->set_guest_notifiers) {
> +        return;
> +    }
> +
> +    vhost_dev_stop(&s->dev, vdev);
> +
> +    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
> +    if (ret < 0) {
> +        error_report("vhost guest notifier cleanup failed: %d", ret);
> +        return;
> +    }
> +
> +    vhost_dev_disable_notifiers(&s->dev, vdev);
> +}
> +
> +static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
> +{
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    bool should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
> +
> +    if (!vdev->vm_running) {
> +        should_start = false;
> +    }
> +
> +    if (s->dev.started == should_start) {
> +        return;
> +    }
> +
> +    if (should_start) {
> +        vhost_user_blk_start(vdev);
> +    } else {
> +        vhost_user_blk_stop(vdev);
> +    }
> +
> +}
> +
> +static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
> +                                            uint64_t features,
> +                                            Error **errp)
> +{
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    uint64_t get_features;
> +
> +    /* Turn on pre-defined features */
> +    features |= s->host_features;
> +
> +    get_features = vhost_get_features(&s->dev, user_feature_bits, features);
> +
> +    return get_features;
> +}
> +
> +static void vhost_user_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> +{

ever called? assert here?

> +
> +}
> +
> +static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    int i, ret;
> +
> +    if (!s->chardev.chr) {
> +        error_setg(errp, "vhost-user-blk: chardev is mandatory");
> +        return;
> +    }
> +
> +    if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
> +        error_setg(errp, "vhost-user-blk: invalid number of IO queues");
> +        return;
> +    }
> +
> +    if (!s->queue_size) {
> +        error_setg(errp, "vhost-user-blk: queue size must be non-zero");
> +        return;
> +    }
> +
> +    virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
> +                sizeof(struct virtio_blk_config));
> +
> +    for (i = 0; i < s->num_queues; i++) {
> +        virtio_add_queue(vdev, s->queue_size,
> +                         vhost_user_blk_handle_output);
> +    }
> +
> +    s->dev.nvqs = s->num_queues;
> +    s->dev.vqs = g_new(struct vhost_virtqueue, s->dev.nvqs);
> +    s->dev.vq_index = 0;
> +    s->dev.backend_features = 0;
> +
> +    ret = vhost_dev_init(&s->dev, &s->chardev, VHOST_BACKEND_TYPE_USER, 0);
> +    if (ret < 0) {
> +        error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
> +                   strerror(-ret));
> +        goto virtio_err;
> +    }
> +
> +    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
> +                              sizeof(struct virtio_blk_config));
> +    if (ret < 0) {
> +        error_setg(errp, "vhost-user-blk: get block config failed");
> +        goto vhost_err;
> +    }
> +
> +    if (s->blkcfg.num_queues != s->num_queues) {
> +        s->blkcfg.num_queues = s->num_queues;
> +    }
> +
> +    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> +
> +    return;
> +
> +vhost_err:
> +    vhost_dev_cleanup(&s->dev);
> +virtio_err:
> +    g_free(s->dev.vqs);
> +    virtio_cleanup(vdev);
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
> +    .minimum_version_id = 1,
> +    .version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static Property vhost_user_blk_properties[] = {
> +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> +    DEFINE_PROP_UINT16("num_queues", VHostUserBlk, num_queues, 1),
> +    DEFINE_PROP_UINT32("queue_size", VHostUserBlk, queue_size, 128),
> +    DEFINE_PROP_BIT64("f_size_max", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_SIZE_MAX, true),
> +    DEFINE_PROP_BIT64("f_sizemax", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_SIZE_MAX, true),
> +    DEFINE_PROP_BIT64("f_segmax", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_SEG_MAX, true),
> +    DEFINE_PROP_BIT64("f_geometry", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_GEOMETRY, true),
> +    DEFINE_PROP_BIT64("f_readonly", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_RO, false),
> +    DEFINE_PROP_BIT64("f_blocksize", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_BLK_SIZE, true),
> +    DEFINE_PROP_BIT64("f_topology", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_TOPOLOGY, true),
> +    DEFINE_PROP_BIT64("f_multiqueue", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_MQ, true),
> +    DEFINE_PROP_BIT64("f_flush", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_FLUSH, true),
> +    DEFINE_PROP_BIT64("f_barrier", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_BARRIER, false),
> +    DEFINE_PROP_BIT64("f_scsi", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_SCSI, false),
> +    DEFINE_PROP_BIT64("f_wce", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_WCE, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +

So if you let users specify these, why do you need to query
them from the backend with GET_CONFIG?

> +static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +
> +    dc->props = vhost_user_blk_properties;
> +    dc->vmsd = &vmstate_vhost_user_blk;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    vdc->realize = vhost_user_blk_device_realize;
> +    vdc->unrealize = vhost_user_blk_device_unrealize;
> +    vdc->get_config = vhost_user_blk_update_config;
> +    vdc->set_config = vhost_user_blk_set_config;
> +    vdc->get_features = vhost_user_blk_get_features;
> +    vdc->set_status = vhost_user_blk_set_status;
> +}
> +

Looks like this will pass config accesses directly to backend.
I am not sure it's a good approach.

> +static const TypeInfo vhost_user_blk_info = {
> +    .name = TYPE_VHOST_USER_BLK,
> +    .parent = TYPE_VIRTIO_DEVICE,
> +    .instance_size = sizeof(VHostUserBlk),
> +    .instance_init = vhost_user_blk_instance_init,
> +    .class_init = vhost_user_blk_class_init,
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&vhost_user_blk_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 8b0d6b6..be9a992 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2012,6 +2012,58 @@ static const TypeInfo virtio_blk_pci_info = {
>      .class_init    = virtio_blk_pci_class_init,
>  };
>  
> +#ifdef CONFIG_VHOST_USER_BLK
> +/* vhost-user-blk */
> +
> +static Property vhost_user_blk_pci_properties[] = {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void vhost_user_blk_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    dc->props = vhost_user_blk_pci_properties;
> +    k->realize = vhost_user_blk_pci_realize;
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id = PCI_CLASS_STORAGE_SCSI;
> +}
> +
> +static void vhost_user_blk_pci_instance_init(Object *obj)
> +{
> +    VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_USER_BLK);
> +    object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
> +                              "bootindex", &error_abort);
> +}
> +
> +static const TypeInfo vhost_user_blk_pci_info = {
> +    .name           = TYPE_VHOST_USER_BLK_PCI,
> +    .parent         = TYPE_VIRTIO_PCI,
> +    .instance_size  = sizeof(VHostUserBlkPCI),
> +    .instance_init  = vhost_user_blk_pci_instance_init,
> +    .class_init     = vhost_user_blk_pci_class_init,
> +};
> +#endif
> +
>  /* virtio-scsi-pci */
>  
>  static Property virtio_scsi_pci_properties[] = {
> @@ -2658,6 +2710,9 @@ static void virtio_pci_register_types(void)
>      type_register_static(&virtio_9p_pci_info);
>  #endif
>      type_register_static(&virtio_blk_pci_info);
> +#ifdef CONFIG_VHOST_USER_BLK
> +    type_register_static(&vhost_user_blk_pci_info);
> +#endif
>      type_register_static(&virtio_scsi_pci_info);
>      type_register_static(&virtio_balloon_pci_info);
>      type_register_static(&virtio_serial_pci_info);
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 69f5959..19a0d01 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -27,6 +27,9 @@
>  #include "hw/virtio/virtio-gpu.h"
>  #include "hw/virtio/virtio-crypto.h"
>  #include "hw/virtio/vhost-user-scsi.h"
> +#ifdef CONFIG_VHOST_USER_BLK
> +#include "hw/virtio/vhost-user-blk.h"
> +#endif
>  
>  #ifdef CONFIG_VIRTFS
>  #include "hw/9pfs/virtio-9p.h"
> @@ -46,6 +49,7 @@ typedef struct VirtIOSerialPCI VirtIOSerialPCI;
>  typedef struct VirtIONetPCI VirtIONetPCI;
>  typedef struct VHostSCSIPCI VHostSCSIPCI;
>  typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
> +typedef struct VHostUserBlkPCI VHostUserBlkPCI;
>  typedef struct VirtIORngPCI VirtIORngPCI;
>  typedef struct VirtIOInputPCI VirtIOInputPCI;
>  typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
> @@ -241,6 +245,20 @@ struct VHostUserSCSIPCI {
>      VHostUserSCSI vdev;
>  };
>  
> +#ifdef CONFIG_VHOST_USER_BLK
> +/*
> + * vhost-user-blk-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VHOST_USER_BLK_PCI "vhost-user-blk-pci"
> +#define VHOST_USER_BLK_PCI(obj) \
> +        OBJECT_CHECK(VHostUserBlkPCI, (obj), TYPE_VHOST_USER_BLK_PCI)
> +
> +struct VHostUserBlkPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VHostUserBlk vdev;
> +};
> +#endif
> +
>  /*
>   * virtio-blk-pci: This extends VirtioPCIProxy.
>   */
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> new file mode 100644
> index 0000000..77d20f0
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -0,0 +1,40 @@
> +/*
> + * vhost-user-blk host device
> + * Copyright IBM, Corp. 2011
> + * Copyright(C) 2017 Intel Corporation.
> + *
> + * Authors:
> + *  Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> + *  Changpeng Liu <changpeng.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#ifndef VHOST_USER_BLK_H
> +#define VHOST_USER_BLK_H
> +
> +#include "standard-headers/linux/virtio_blk.h"
> +#include "qemu-common.h"
> +#include "hw/qdev.h"
> +#include "hw/block/block.h"
> +#include "chardev/char-fe.h"
> +#include "hw/virtio/vhost.h"
> +
> +#define TYPE_VHOST_USER_BLK "vhost-user-blk"
> +#define VHOST_USER_BLK(obj) \
> +        OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
> +
> +typedef struct VHostUserBlk {
> +    VirtIODevice parent_obj;
> +    CharBackend chardev;
> +    int32_t bootindex;
> +    uint64_t host_features;
> +    struct virtio_blk_config blkcfg;
> +    uint16_t num_queues;
> +    uint32_t queue_size;
> +    struct vhost_dev dev;
> +} VHostUserBlk;
> +
> +#endif
> -- 
> 1.9.3
