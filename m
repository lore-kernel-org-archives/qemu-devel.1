Received: from eggs.gnu.org ([2001:4830:134:3::10]:35061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLU4a-0002iQ-Im
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLU4T-0003Cz-Gl
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:45:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLU4T-0003CL-9q
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:44:53 -0400
Date: Wed, 23 May 2018 16:44:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180523163116-mutt-send-email-mst@kernel.org>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-3-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412151232.17506-3-tiwei.bie@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] vhost-user: introduce shared
 vhost-user state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, Apr 12, 2018 at 11:12:28PM +0800, Tiwei Bie wrote:
> When multi queue is enabled e.g. for a virtio-net device,
> each queue pair will have a vhost_dev, and the only thing
> shared between vhost devs currently is the chardev. This
> patch introduces a vhost-user state structure which will
> be shared by all vhost devs of the same virtio device.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

Unfortunately this patch seems to cause crashes.
To reproduce, simply run
make check-qtest-x86_64

Sorry that it took me a while to find - it triggers 90% of runs but not
100% which complicates bisection somewhat.

> ---
>  backends/cryptodev-vhost-user.c     | 20 ++++++++++++++++++-
>  hw/block/vhost-user-blk.c           | 22 +++++++++++++++++++-
>  hw/scsi/vhost-user-scsi.c           | 20 ++++++++++++++++++-
>  hw/virtio/Makefile.objs             |  2 +-
>  hw/virtio/vhost-stub.c              | 10 ++++++++++
>  hw/virtio/vhost-user.c              | 31 +++++++++++++++++++---------
>  include/hw/virtio/vhost-user-blk.h  |  2 ++
>  include/hw/virtio/vhost-user-scsi.h |  2 ++
>  include/hw/virtio/vhost-user.h      | 20 +++++++++++++++++++
>  net/vhost-user.c                    | 40 ++++++++++++++++++++++++++++++-------
>  10 files changed, 149 insertions(+), 20 deletions(-)
>  create mode 100644 include/hw/virtio/vhost-user.h
> 
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
> index 862d4f2580..d52daccfcd 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
> +#include "hw/virtio/vhost-user.h"
>  #include "standard-headers/linux/virtio_crypto.h"
>  #include "sysemu/cryptodev-vhost.h"
>  #include "chardev/char-fe.h"
> @@ -46,6 +47,7 @@
>  typedef struct CryptoDevBackendVhostUser {
>      CryptoDevBackend parent_obj;
>  
> +    VhostUserState *vhost_user;
>      CharBackend chr;
>      char *chr_name;
>      bool opened;
> @@ -102,7 +104,7 @@ cryptodev_vhost_user_start(int queues,
>              continue;
>          }
>  
> -        options.opaque = &s->chr;
> +        options.opaque = s->vhost_user;
>          options.backend_type = VHOST_BACKEND_TYPE_USER;
>          options.cc = b->conf.peers.ccs[i];
>          s->vhost_crypto[i] = cryptodev_vhost_init(&options);
> @@ -185,6 +187,7 @@ static void cryptodev_vhost_user_init(
>      size_t i;
>      Error *local_err = NULL;
>      Chardev *chr;
> +    VhostUserState *user;
>      CryptoDevBackendClient *cc;
>      CryptoDevBackendVhostUser *s =
>                        CRYPTODEV_BACKEND_VHOST_USER(backend);
> @@ -215,6 +218,15 @@ static void cryptodev_vhost_user_init(
>          }
>      }
>  
> +    user = vhost_user_init();
> +    if (!user) {
> +        error_setg(errp, "Failed to init vhost_user");
> +        return;
> +    }
> +
> +    user->chr = &s->chr;
> +    s->vhost_user = user;
> +
>      qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
>                       cryptodev_vhost_user_event, NULL, s, NULL, true);
>  
> @@ -299,6 +311,12 @@ static void cryptodev_vhost_user_cleanup(
>              backend->conf.peers.ccs[i] = NULL;
>          }
>      }
> +
> +    if (s->vhost_user) {
> +        vhost_user_cleanup(s->vhost_user);
> +        g_free(s->vhost_user);
> +        s->vhost_user = NULL;
> +    }
>  }
>  
>  static void cryptodev_vhost_user_set_chardev(Object *obj,
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 262baca432..4021d71c31 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -229,6 +229,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> +    VhostUserState *user;
>      int i, ret;
>  
>      if (!s->chardev.chr) {
> @@ -246,6 +247,15 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    user = vhost_user_init();
> +    if (!user) {
> +        error_setg(errp, "vhost-user-blk: failed to init vhost_user");
> +        return;
> +    }
> +
> +    user->chr = &s->chardev;
> +    s->vhost_user = user;
> +
>      virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
>                  sizeof(struct virtio_blk_config));
>  
> @@ -261,7 +271,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>  
>      vhost_dev_set_config_notifier(&s->dev, &blk_ops);
>  
> -    ret = vhost_dev_init(&s->dev, &s->chardev, VHOST_BACKEND_TYPE_USER, 0);
> +    ret = vhost_dev_init(&s->dev, s->vhost_user, VHOST_BACKEND_TYPE_USER, 0);
>      if (ret < 0) {
>          error_setg(errp, "vhost-user-blk: vhost initialization failed: %s",
>                     strerror(-ret));
> @@ -286,6 +296,10 @@ vhost_err:
>  virtio_err:
>      g_free(s->dev.vqs);
>      virtio_cleanup(vdev);
> +
> +    vhost_user_cleanup(user);
> +    g_free(user);
> +    s->vhost_user = NULL;
>  }
>  
>  static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
> @@ -297,6 +311,12 @@ static void vhost_user_blk_device_unrealize(DeviceState *dev, Error **errp)
>      vhost_dev_cleanup(&s->dev);
>      g_free(s->dev.vqs);
>      virtio_cleanup(vdev);
> +
> +    if (s->vhost_user) {
> +        vhost_user_cleanup(s->vhost_user);
> +        g_free(s->vhost_user);
> +        s->vhost_user = NULL;
> +    }
>  }
>  
>  static void vhost_user_blk_instance_init(Object *obj)
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 9389ed48e0..9355cfdf07 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -69,6 +69,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
>      VHostUserSCSI *s = VHOST_USER_SCSI(dev);
>      VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
> +    VhostUserState *user;
>      Error *err = NULL;
>      int ret;
>  
> @@ -85,19 +86,30 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    user = vhost_user_init();
> +    if (!user) {
> +        error_setg(errp, "vhost-user-scsi: failed to init vhost_user");
> +        return;
> +    }
> +    user->chr = &vs->conf.chardev;
> +
>      vsc->dev.nvqs = 2 + vs->conf.num_queues;
>      vsc->dev.vqs = g_new(struct vhost_virtqueue, vsc->dev.nvqs);
>      vsc->dev.vq_index = 0;
>      vsc->dev.backend_features = 0;
>  
> -    ret = vhost_dev_init(&vsc->dev, (void *)&vs->conf.chardev,
> +    ret = vhost_dev_init(&vsc->dev, user,
>                           VHOST_BACKEND_TYPE_USER, 0);
>      if (ret < 0) {
>          error_setg(errp, "vhost-user-scsi: vhost initialization failed: %s",
>                     strerror(-ret));
> +        vhost_user_cleanup(user);
> +        g_free(user);
>          return;
>      }
>  
> +    s->vhost_user = user;
> +
>      /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
>      vsc->channel = 0;
>      vsc->lun = 0;
> @@ -117,6 +129,12 @@ static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
>      g_free(vsc->dev.vqs);
>  
>      virtio_scsi_common_unrealize(dev, errp);
> +
> +    if (s->vhost_user) {
> +        vhost_user_cleanup(s->vhost_user);
> +        g_free(s->vhost_user);
> +        s->vhost_user = NULL;
> +    }
>  }
>  
>  static uint64_t vhost_user_scsi_get_features(VirtIODevice *vdev,
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 765d363c1f..030969e28c 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -11,5 +11,5 @@ obj-y += virtio-crypto.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
>  endif
>  
> -common-obj-$(call lnot,$(CONFIG_LINUX)) += vhost-stub.o
> +common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
>  common-obj-$(CONFIG_ALL) += vhost-stub.o
> diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
> index 2d76cdebdc..049089b5e2 100644
> --- a/hw/virtio/vhost-stub.c
> +++ b/hw/virtio/vhost-stub.c
> @@ -1,7 +1,17 @@
>  #include "qemu/osdep.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
>  
>  bool vhost_has_free_slot(void)
>  {
>      return true;
>  }
> +
> +VhostUserState *vhost_user_init(void)
> +{
> +    return NULL;
> +}
> +
> +void vhost_user_cleanup(VhostUserState *user)
> +{
> +}
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 38da8692bb..91edd95453 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -11,6 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
>  #include "hw/virtio/vhost-backend.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "chardev/char-fe.h"
> @@ -173,7 +174,8 @@ static VhostUserMsg m __attribute__ ((unused));
>  
>  struct vhost_user {
>      struct vhost_dev *dev;
> -    CharBackend *chr;
> +    /* Shared between vhost devs of the same virtio device */
> +    VhostUserState *user;
>      int slave_fd;
>      NotifierWithReturn postcopy_notifier;
>      struct PostCopyFD  postcopy_fd;
> @@ -199,7 +201,7 @@ static bool ioeventfd_enabled(void)
>  static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
>  {
>      struct vhost_user *u = dev->opaque;
> -    CharBackend *chr = u->chr;
> +    CharBackend *chr = u->user->chr;
>      uint8_t *p = (uint8_t *) msg;
>      int r, size = VHOST_USER_HDR_SIZE;
>  
> @@ -285,7 +287,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
>                              int *fds, int fd_num)
>  {
>      struct vhost_user *u = dev->opaque;
> -    CharBackend *chr = u->chr;
> +    CharBackend *chr = u->user->chr;
>      int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
>  
>      /*
> @@ -1044,7 +1046,7 @@ static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *rb,
>  static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
>  {
>      struct vhost_user *u = dev->opaque;
> -    CharBackend *chr = u->chr;
> +    CharBackend *chr = u->user->chr;
>      int ufd;
>      VhostUserMsg msg = {
>          .hdr.request = VHOST_USER_POSTCOPY_ADVISE,
> @@ -1182,7 +1184,7 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
>      return 0;
>  }
>  
> -static int vhost_user_init(struct vhost_dev *dev, void *opaque)
> +static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque)
>  {
>      uint64_t features, protocol_features;
>      struct vhost_user *u;
> @@ -1191,7 +1193,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
>      assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
>  
>      u = g_new0(struct vhost_user, 1);
> -    u->chr = opaque;
> +    u->user = opaque;
>      u->slave_fd = -1;
>      u->dev = dev;
>      dev->opaque = u;
> @@ -1267,7 +1269,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
>      return 0;
>  }
>  
> -static int vhost_user_cleanup(struct vhost_dev *dev)
> +static int vhost_user_backend_cleanup(struct vhost_dev *dev)
>  {
>      struct vhost_user *u;
>  
> @@ -1581,10 +1583,21 @@ vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
>      return 0;
>  }
>  
> +VhostUserState *vhost_user_init(void)
> +{
> +    VhostUserState *user = g_new0(struct VhostUserState, 1);
> +
> +    return user;
> +}
> +
> +void vhost_user_cleanup(VhostUserState *user)
> +{
> +}
> +
>  const VhostOps user_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_USER,
> -        .vhost_backend_init = vhost_user_init,
> -        .vhost_backend_cleanup = vhost_user_cleanup,
> +        .vhost_backend_init = vhost_user_backend_init,
> +        .vhost_backend_cleanup = vhost_user_backend_cleanup,
>          .vhost_backend_memslots_limit = vhost_user_memslots_limit,
>          .vhost_set_log_base = vhost_user_set_log_base,
>          .vhost_set_mem_table = vhost_user_set_mem_table,
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> index 5804cc904a..f1258ae545 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -21,6 +21,7 @@
>  #include "hw/block/block.h"
>  #include "chardev/char-fe.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
>  
>  #define TYPE_VHOST_USER_BLK "vhost-user-blk"
>  #define VHOST_USER_BLK(obj) \
> @@ -36,6 +37,7 @@ typedef struct VHostUserBlk {
>      uint32_t config_wce;
>      uint32_t config_ro;
>      struct vhost_dev dev;
> +    VhostUserState *vhost_user;
>  } VHostUserBlk;
>  
>  #endif
> diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhost-user-scsi.h
> index 01861f78d0..3ec34ae867 100644
> --- a/include/hw/virtio/vhost-user-scsi.h
> +++ b/include/hw/virtio/vhost-user-scsi.h
> @@ -21,6 +21,7 @@
>  #include "hw/qdev.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
>  #include "hw/virtio/vhost-scsi-common.h"
>  
>  #define TYPE_VHOST_USER_SCSI "vhost-user-scsi"
> @@ -30,6 +31,7 @@
>  typedef struct VHostUserSCSI {
>      VHostSCSICommon parent_obj;
>      uint64_t host_features;
> +    VhostUserState *vhost_user;
>  } VHostUserSCSI;
>  
>  #endif /* VHOST_USER_SCSI_H */
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> new file mode 100644
> index 0000000000..eb8bc0d90d
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user.h
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (c) 2017-2018 Intel Corporation
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_VIRTIO_VHOST_USER_H
> +#define HW_VIRTIO_VHOST_USER_H
> +
> +#include "chardev/char-fe.h"
> +
> +typedef struct VhostUserState {
> +    CharBackend *chr;
> +} VhostUserState;
> +
> +VhostUserState *vhost_user_init(void);
> +void vhost_user_cleanup(VhostUserState *user);
> +
> +#endif
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index fa28aad12d..525a061acf 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -12,6 +12,7 @@
>  #include "clients.h"
>  #include "net/vhost_net.h"
>  #include "net/vhost-user.h"
> +#include "hw/virtio/vhost-user.h"
>  #include "chardev/char-fe.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-net.h"
> @@ -23,6 +24,7 @@
>  typedef struct NetVhostUserState {
>      NetClientState nc;
>      CharBackend chr; /* only queue index 0 */
> +    VhostUserState *vhost_user;
>      VHostNetState *vhost_net;
>      guint watch;
>      uint64_t acked_features;
> @@ -64,7 +66,8 @@ static void vhost_user_stop(int queues, NetClientState *ncs[])
>      }
>  }
>  
> -static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
> +static int vhost_user_start(int queues, NetClientState *ncs[],
> +                            VhostUserState *be)
>  {
>      VhostNetOptions options;
>      struct vhost_net *net = NULL;
> @@ -144,7 +147,7 @@ static ssize_t vhost_user_receive(NetClientState *nc, const uint8_t *buf,
>      return size;
>  }
>  
> -static void vhost_user_cleanup(NetClientState *nc)
> +static void net_vhost_user_cleanup(NetClientState *nc)
>  {
>      NetVhostUserState *s = DO_UPCAST(NetVhostUserState, nc, nc);
>  
> @@ -153,6 +156,11 @@ static void vhost_user_cleanup(NetClientState *nc)
>          g_free(s->vhost_net);
>          s->vhost_net = NULL;
>      }
> +    if (s->vhost_user) {
> +        vhost_user_cleanup(s->vhost_user);
> +        g_free(s->vhost_user);
> +        s->vhost_user = NULL;
> +    }
>      if (nc->queue_index == 0) {
>          if (s->watch) {
>              g_source_remove(s->watch);
> @@ -182,7 +190,7 @@ static NetClientInfo net_vhost_user_info = {
>          .type = NET_CLIENT_DRIVER_VHOST_USER,
>          .size = sizeof(NetVhostUserState),
>          .receive = vhost_user_receive,
> -        .cleanup = vhost_user_cleanup,
> +        .cleanup = net_vhost_user_cleanup,
>          .has_vnet_hdr = vhost_user_has_vnet_hdr,
>          .has_ufo = vhost_user_has_ufo,
>  };
> @@ -244,7 +252,7 @@ static void net_vhost_user_event(void *opaque, int event)
>      trace_vhost_user_event(chr->label, event);
>      switch (event) {
>      case CHR_EVENT_OPENED:
> -        if (vhost_user_start(queues, ncs, &s->chr) < 0) {
> +        if (vhost_user_start(queues, ncs, s->vhost_user) < 0) {
>              qemu_chr_fe_disconnect(&s->chr);
>              return;
>          }
> @@ -283,12 +291,19 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
>  {
>      Error *err = NULL;
>      NetClientState *nc, *nc0 = NULL;
> +    VhostUserState *user = NULL;
>      NetVhostUserState *s;
>      int i;
>  
>      assert(name);
>      assert(queues > 0);
>  
> +    user = vhost_user_init();
> +    if (!user) {
> +        error_report("failed to init vhost_user");
> +        goto err;
> +    }
> +
>      for (i = 0; i < queues; i++) {
>          nc = qemu_new_net_client(&net_vhost_user_info, peer, device, name);
>          snprintf(nc->info_str, sizeof(nc->info_str), "vhost-user%d to %s",
> @@ -299,17 +314,19 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
>              s = DO_UPCAST(NetVhostUserState, nc, nc);
>              if (!qemu_chr_fe_init(&s->chr, chr, &err)) {
>                  error_report_err(err);
> -                return -1;
> +                goto err;
>              }
> +            user->chr = &s->chr;
>          }
> -
> +        s = DO_UPCAST(NetVhostUserState, nc, nc);
> +        s->vhost_user = user;
>      }
>  
>      s = DO_UPCAST(NetVhostUserState, nc, nc0);
>      do {
>          if (qemu_chr_fe_wait_connected(&s->chr, &err) < 0) {
>              error_report_err(err);
> -            return -1;
> +            goto err;
>          }
>          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
>                                   net_vhost_user_event, NULL, nc0->name, NULL,
> @@ -319,6 +336,15 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
>      assert(s->vhost_net);
>  
>      return 0;
> +
> +err:
> +    if (user) {
> +        vhost_user_cleanup(user);
> +        g_free(user);
> +        s->vhost_user = NULL;
> +    }
> +
> +    return -1;
>  }
>  
>  static Chardev *net_vhost_claim_chardev(
> -- 
> 2.11.0
