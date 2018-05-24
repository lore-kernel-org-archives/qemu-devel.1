Received: from eggs.gnu.org ([2001:4830:134:3::10]:53685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsUy-00043X-RP
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsUu-0004sx-TJ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:49:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLsUu-0004sh-MS
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:49:48 -0400
Date: Thu, 24 May 2018 18:49:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524184438-mutt-send-email-mst@kernel.org>
References: <20180524103336.21233-1-tiwei.bie@intel.com>
	<20180524103336.21233-5-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524103336.21233-5-tiwei.bie@intel.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] vhost-user: support registering
 external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On Thu, May 24, 2018 at 06:33:34PM +0800, Tiwei Bie wrote:
> This patch introduces VHOST_USER_PROTOCOL_F_HOST_NOTIFIER.
> With this feature negotiated, vhost-user backend can register
> memory region based host notifiers. And it will allow the guest
> driver in the VM to notify the hardware accelerator at the
> vhost-user backend directly.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

So maybe we don't need a new VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD?
Let's check VHOST_USER_PROTOCOL_F_HOST_NOTIFIER instead?

> ---
>  docs/interop/vhost-user.txt    |  33 ++++++++++
>  hw/virtio/vhost-user.c         | 113 +++++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-user.h |   8 +++
>  3 files changed, 154 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 682a683eb4..d51fd58242 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -132,6 +132,16 @@ Depending on the request type, payload can be:
>     Payload: Size bytes array holding the contents of the virtio
>         device's configuration space
>  
> + * Vring area description
> +   -----------------------
> +   | u64 | size | offset |
> +   -----------------------
> +
> +   u64: a 64-bit integer contains vring index and flags
> +   Size: a 64-bit size of this area
> +   Offset: a 64-bit offset of this area from the start of the
> +       supplied file descriptor
> +
>  In QEMU the vhost-user message is implemented with the following struct:
>  
>  typedef struct VhostUserMsg {
> @@ -146,6 +156,7 @@ typedef struct VhostUserMsg {
>          VhostUserLog log;
>          struct vhost_iotlb_msg iotlb;
>          VhostUserConfig config;
> +        VhostUserVringArea area;
>      };
>  } QEMU_PACKED VhostUserMsg;
>  
> @@ -385,6 +396,7 @@ Protocol features
>  #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
>  #define VHOST_USER_PROTOCOL_F_CONFIG         9
>  #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
> +#define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
>  
>  Master message types
>  --------------------
> @@ -782,6 +794,27 @@ Slave message types
>       the VHOST_USER_NEED_REPLY flag, master must respond with zero when
>       operation is successfully completed, or non-zero otherwise.
>  
> + * VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG
> +
> +      Id: 3
> +      Equivalent ioctl: N/A
> +      Slave payload: vring area description
> +      Master payload: N/A
> +
> +      Sets host notifier for a specified queue. The queue index is contained
> +      in the u64 field of the vring area description. The host notifier is
> +      described by the file descriptor (typically it's a VFIO device fd) which
> +      is passed as ancillary data and the size (which is mmap size and should
> +      be the same as host page size) and offset (which is mmap offset) carried
> +      in the vring area description. QEMU can mmap the file descriptor based
> +      on the size and offset to get a memory range. Registering a host notifier
> +      means mapping this memory range to the VM as the specified queue's notify
> +      MMIO region. Slave sends this request to tell QEMU to de-register the
> +      existing notifier if any and register the new notifier if the request is
> +      sent with a file descriptor.
> +      This request should be sent only when VHOST_USER_PROTOCOL_F_HOST_NOTIFIER
> +      protocol feature has been successfully negotiated.
> +
>  VHOST_USER_PROTOCOL_F_REPLY_ACK:
>  -------------------------------
>  The original vhost-user specification only demands replies for certain
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 70b9610c87..b041343632 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -13,6 +13,7 @@
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-user.h"
>  #include "hw/virtio/vhost-backend.h"
> +#include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "chardev/char-fe.h"
>  #include "sysemu/kvm.h"
> @@ -50,6 +51,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
>      VHOST_USER_PROTOCOL_F_CONFIG = 9,
>      VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
> +    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER = 11,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>  
> @@ -94,6 +96,7 @@ typedef enum VhostUserSlaveRequest {
>      VHOST_USER_SLAVE_NONE = 0,
>      VHOST_USER_SLAVE_IOTLB_MSG = 1,
>      VHOST_USER_SLAVE_CONFIG_CHANGE_MSG = 2,
> +    VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG = 3,
>      VHOST_USER_SLAVE_MAX
>  }  VhostUserSlaveRequest;
>  
> @@ -138,6 +141,12 @@ static VhostUserConfig c __attribute__ ((unused));
>                                     + sizeof(c.size) \
>                                     + sizeof(c.flags))
>  
> +typedef struct VhostUserVringArea {
> +    uint64_t u64;
> +    uint64_t size;
> +    uint64_t offset;
> +} VhostUserVringArea;
> +
>  typedef struct {
>      VhostUserRequest request;
>  
> @@ -159,6 +168,7 @@ typedef union {
>          struct vhost_iotlb_msg iotlb;
>          VhostUserConfig config;
>          VhostUserCryptoSession session;
> +        VhostUserVringArea area;
>  } VhostUserPayload;
>  
>  typedef struct VhostUserMsg {
> @@ -640,9 +650,37 @@ static int vhost_user_set_vring_num(struct vhost_dev *dev,
>      return vhost_set_vring(dev, VHOST_USER_SET_VRING_NUM, ring);
>  }
>  
> +static void vhost_user_host_notifier_restore(struct vhost_dev *dev,
> +                                             int queue_idx)
> +{
> +    struct vhost_user *u = dev->opaque;
> +    VhostUserHostNotifier *n = &u->user->notifier[queue_idx];
> +    VirtIODevice *vdev = dev->vdev;
> +
> +    if (n->addr && !n->set) {
> +        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, true);
> +        n->set = true;
> +    }
> +}
> +
> +static void vhost_user_host_notifier_remove(struct vhost_dev *dev,
> +                                            int queue_idx)
> +{
> +    struct vhost_user *u = dev->opaque;
> +    VhostUserHostNotifier *n = &u->user->notifier[queue_idx];
> +    VirtIODevice *vdev = dev->vdev;
> +
> +    if (n->addr && n->set) {
> +        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, false);
> +        n->set = false;
> +    }
> +}
> +
>  static int vhost_user_set_vring_base(struct vhost_dev *dev,
>                                       struct vhost_vring_state *ring)
>  {
> +    vhost_user_host_notifier_restore(dev, ring->index);
> +
>      return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring);
>  }
>  
> @@ -676,6 +714,8 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
>          .hdr.size = sizeof(msg.payload.state),
>      };
>  
> +    vhost_user_host_notifier_remove(dev, ring->index);
> +
>      if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
>          return -1;
>      }
> @@ -849,6 +889,66 @@ static int vhost_user_slave_handle_config_change(struct vhost_dev *dev)
>      return ret;
>  }
>  
> +static int vhost_user_slave_handle_vring_host_notifier(struct vhost_dev *dev,
> +                                                       VhostUserVringArea *area,
> +                                                       int fd)
> +{
> +    int queue_idx = area->u64 & VHOST_USER_VRING_IDX_MASK;
> +    size_t page_size = qemu_real_host_page_size;
> +    struct vhost_user *u = dev->opaque;
> +    VhostUserState *user = u->user;
> +    VirtIODevice *vdev = dev->vdev;
> +    VhostUserHostNotifier *n;
> +    void *addr;
> +    char *name;
> +
> +    if (!virtio_has_feature(dev->protocol_features,
> +                            VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
> +        vdev == NULL || queue_idx >= virtio_get_num_queues(vdev)) {
> +        return -1;
> +    }
> +
> +    n = &user->notifier[queue_idx];
> +
> +    if (n->addr) {
> +        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, false);
> +        object_unparent(OBJECT(&n->mr));
> +        munmap(n->addr, page_size);
> +        n->addr = NULL;
> +    }
> +
> +    if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
> +        return 0;
> +    }
> +
> +    /* Sanity check. */
> +    if (area->size != page_size) {
> +        return -1;
> +    }
> +
> +    addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +                fd, area->offset);
> +    if (addr == MAP_FAILED) {
> +        return -1;
> +    }
> +
> +    name = g_strdup_printf("vhost-user/host-notifier@%p mmaps[%d]",
> +                           user, queue_idx);
> +    memory_region_init_ram_device_ptr(&n->mr, OBJECT(vdev), name,
> +                                      page_size, addr);
> +    g_free(name);
> +
> +    if (virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, true)) {
> +        munmap(addr, page_size);
> +        return -1;
> +    }
> +
> +    n->addr = addr;
> +    n->set = true;
> +
> +    return 0;
> +}
> +
>  static void slave_read(void *opaque)
>  {
>      struct vhost_dev *dev = opaque;
> @@ -917,6 +1017,10 @@ static void slave_read(void *opaque)
>      case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG :
>          ret = vhost_user_slave_handle_config_change(dev);
>          break;
> +    case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
> +        ret = vhost_user_slave_handle_vring_host_notifier(dev, &payload.area,
> +                                                          fd[0]);
> +        break;
>      default:
>          error_report("Received unexpected msg type.");
>          ret = -EINVAL;
> @@ -1648,6 +1752,15 @@ VhostUserState *vhost_user_init(void)
>  
>  void vhost_user_cleanup(VhostUserState *user)
>  {
> +    int i;
> +
> +    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
> +        if (user->notifier[i].addr) {
> +            object_unparent(OBJECT(&user->notifier[i].mr));
> +            munmap(user->notifier[i].addr, qemu_real_host_page_size);
> +            user->notifier[i].addr = NULL;
> +        }
> +    }
>  }
>  
>  const VhostOps user_ops = {
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> index eb8bc0d90d..fd660393a0 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -9,9 +9,17 @@
>  #define HW_VIRTIO_VHOST_USER_H
>  
>  #include "chardev/char-fe.h"
> +#include "hw/virtio/virtio.h"
> +
> +typedef struct VhostUserHostNotifier {
> +    MemoryRegion mr;
> +    void *addr;
> +    bool set;
> +} VhostUserHostNotifier;
>  
>  typedef struct VhostUserState {
>      CharBackend *chr;
> +    VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
>  } VhostUserState;

So this notifier is per-queue. Can't we maintain it in
NetVhostUserState then?


>  
>  VhostUserState *vhost_user_init(void);
> -- 
> 2.17.0
