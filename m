Received: from eggs.gnu.org ([2001:4830:134:3::10]:55249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fMArS-0005a2-TV
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fMArO-0004nm-1t
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:26:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fMArN-0004nD-SI
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:26:13 -0400
References: <20180525110441.7185-1-tiwei.bie@intel.com>
	<20180525110441.7185-4-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ae867b0d-2f70-f3ab-6d32-914935b5dd23@redhat.com>
Date: Fri, 25 May 2018 19:26:05 +0800
MIME-Version: 1.0
In-Reply-To: <20180525110441.7185-4-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vhost-user: support registering
 external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org



On 2018=E5=B9=B405=E6=9C=8825=E6=97=A5 19:04, Tiwei Bie wrote:
> This patch introduces VHOST_USER_PROTOCOL_F_HOST_NOTIFIER.
> With this feature negotiated, vhost-user backend can register
> memory region based host notifiers. And it will allow the guest
> driver in the VM to notify the hardware accelerator at the
> vhost-user backend directly.
>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>   docs/interop/vhost-user.txt    |  33 +++++++++
>   hw/virtio/vhost-user.c         | 123 ++++++++++++++++++++++++++++++++=
+
>   include/hw/virtio/vhost-user.h |   8 +++
>   3 files changed, 164 insertions(+)
>
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 534caab18a..9e57b36b20 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -132,6 +132,16 @@ Depending on the request type, payload can be:
>      Payload: Size bytes array holding the contents of the virtio
>          device's configuration space
>  =20
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
>   In QEMU the vhost-user message is implemented with the following stru=
ct:
>  =20
>   typedef struct VhostUserMsg {
> @@ -146,6 +156,7 @@ typedef struct VhostUserMsg {
>           VhostUserLog log;
>           struct vhost_iotlb_msg iotlb;
>           VhostUserConfig config;
> +        VhostUserVringArea area;
>       };
>   } QEMU_PACKED VhostUserMsg;
>  =20
> @@ -380,6 +391,7 @@ Protocol features
>   #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
>   #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
>   #define VHOST_USER_PROTOCOL_F_CONFIG         9
> +#define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  10
>  =20
>   Master message types
>   --------------------
> @@ -777,6 +789,27 @@ Slave message types
>        the VHOST_USER_NEED_REPLY flag, master must respond with zero wh=
en
>        operation is successfully completed, or non-zero otherwise.
>  =20
> + * VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG
> +
> +      Id: 3
> +      Equivalent ioctl: N/A
> +      Slave payload: vring area description
> +      Master payload: N/A
> +
> +      Sets host notifier for a specified queue. The queue index is con=
tained
> +      in the u64 field of the vring area description. The host notifie=
r is
> +      described by the file descriptor (typically it's a VFIO device f=
d) which
> +      is passed as ancillary data and the size (which is mmap size and=
 should
> +      be the same as host page size) and offset (which is mmap offset)=
 carried
> +      in the vring area description. QEMU can mmap the file descriptor=
 based
> +      on the size and offset to get a memory range. Registering a host=
 notifier
> +      means mapping this memory range to the VM as the specified queue=
's notify
> +      MMIO region. Slave sends this request to tell QEMU to de-registe=
r the
> +      existing notifier if any and register the new notifier if the re=
quest is
> +      sent with a file descriptor.
> +      This request should be sent only when VHOST_USER_PROTOCOL_F_HOST=
_NOTIFIER
> +      protocol feature has been successfully negotiated.
> +
>   VHOST_USER_PROTOCOL_F_REPLY_ACK:
>   -------------------------------
>   The original vhost-user specification only demands replies for certai=
n
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 5f72ed68da..259a841af9 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -13,6 +13,7 @@
>   #include "hw/virtio/vhost.h"
>   #include "hw/virtio/vhost-user.h"
>   #include "hw/virtio/vhost-backend.h"
> +#include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-net.h"
>   #include "chardev/char-fe.h"
>   #include "sysemu/kvm.h"
> @@ -48,6 +49,7 @@ enum VhostUserProtocolFeature {
>       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION =3D 7,
>       VHOST_USER_PROTOCOL_F_PAGEFAULT =3D 8,
>       VHOST_USER_PROTOCOL_F_CONFIG =3D 9,
> +    VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 10,
>       VHOST_USER_PROTOCOL_F_MAX
>   };
>  =20
> @@ -92,6 +94,7 @@ typedef enum VhostUserSlaveRequest {
>       VHOST_USER_SLAVE_NONE =3D 0,
>       VHOST_USER_SLAVE_IOTLB_MSG =3D 1,
>       VHOST_USER_SLAVE_CONFIG_CHANGE_MSG =3D 2,
> +    VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG =3D 3,
>       VHOST_USER_SLAVE_MAX
>   }  VhostUserSlaveRequest;
>  =20
> @@ -136,6 +139,12 @@ static VhostUserConfig c __attribute__ ((unused));
>                                      + sizeof(c.size) \
>                                      + sizeof(c.flags))
>  =20
> +typedef struct VhostUserVringArea {
> +    uint64_t u64;
> +    uint64_t size;
> +    uint64_t offset;
> +} VhostUserVringArea;
> +
>   typedef struct {
>       VhostUserRequest request;
>  =20
> @@ -157,6 +166,7 @@ typedef union {
>           struct vhost_iotlb_msg iotlb;
>           VhostUserConfig config;
>           VhostUserCryptoSession session;
> +        VhostUserVringArea area;
>   } VhostUserPayload;
>  =20
>   typedef struct VhostUserMsg {
> @@ -638,9 +648,37 @@ static int vhost_user_set_vring_num(struct vhost_d=
ev *dev,
>       return vhost_set_vring(dev, VHOST_USER_SET_VRING_NUM, ring);
>   }
>  =20
> +static void vhost_user_host_notifier_restore(struct vhost_dev *dev,
> +                                             int queue_idx)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    VhostUserHostNotifier *n =3D &u->user->notifier[queue_idx];
> +    VirtIODevice *vdev =3D dev->vdev;
> +
> +    if (n->addr && !n->set) {
> +        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, tru=
e);
> +        n->set =3D true;
> +    }
> +}
> +
> +static void vhost_user_host_notifier_remove(struct vhost_dev *dev,
> +                                            int queue_idx)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    VhostUserHostNotifier *n =3D &u->user->notifier[queue_idx];
> +    VirtIODevice *vdev =3D dev->vdev;
> +
> +    if (n->addr && n->set) {
> +        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, fal=
se);
> +        n->set =3D false;
> +    }
> +}
> +
>   static int vhost_user_set_vring_base(struct vhost_dev *dev,
>                                        struct vhost_vring_state *ring)
>   {
> +    vhost_user_host_notifier_restore(dev, ring->index);
> +
>       return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring);
>   }
>  =20
> @@ -674,6 +712,8 @@ static int vhost_user_get_vring_base(struct vhost_d=
ev *dev,
>           .hdr.size =3D sizeof(msg.payload.state),
>       };
>  =20
> +    vhost_user_host_notifier_remove(dev, ring->index);
> +
>       if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
>           return -1;
>       }
> @@ -847,6 +887,76 @@ static int vhost_user_slave_handle_config_change(s=
truct vhost_dev *dev)
>       return ret;
>   }
>  =20
> +static int vhost_user_slave_handle_vring_host_notifier(struct vhost_de=
v *dev,
> +                                                       VhostUserVringA=
rea *area,
> +                                                       int fd)
> +{
> +    int queue_idx =3D area->u64 & VHOST_USER_VRING_IDX_MASK;
> +    size_t page_size =3D qemu_real_host_page_size;
> +    struct vhost_user *u =3D dev->opaque;
> +    VhostUserState *user =3D u->user;
> +    VirtIODevice *vdev =3D dev->vdev;
> +    VhostUserHostNotifier *n;
> +    int ret =3D 0;
> +    void *addr;
> +    char *name;
> +
> +    if (!virtio_has_feature(dev->protocol_features,
> +                            VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
> +        vdev =3D=3D NULL || queue_idx >=3D virtio_get_num_queues(vdev)=
) {
> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    n =3D &user->notifier[queue_idx];
> +
> +    if (n->addr) {
> +        virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, fal=
se);
> +        object_unparent(OBJECT(&n->mr));
> +        munmap(n->addr, page_size);
> +        n->addr =3D NULL;
> +    }
> +
> +    if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
> +        goto out;
> +    }
> +
> +    /* Sanity check. */
> +    if (area->size !=3D page_size) {
> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    addr =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,

It looks to me that PROT_WRITE is sufficient here?

Thanks

> +                fd, area->offset);
> +    if (addr =3D=3D MAP_FAILED) {
> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    name =3D g_strdup_printf("vhost-user/host-notifier@%p mmaps[%d]",
> +                           user, queue_idx);
> +    memory_region_init_ram_device_ptr(&n->mr, OBJECT(vdev), name,
> +                                      page_size, addr);
> +    g_free(name);
> +
> +    if (virtio_queue_set_host_notifier_mr(vdev, queue_idx, &n->mr, tru=
e)) {
> +        munmap(addr, page_size);
> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    n->addr =3D addr;
> +    n->set =3D true;
> +
> +out:
> +    /* Always close the fd. */
> +    if (fd !=3D -1) {
> +        close(fd);
> +    }
> +    return ret;
> +}
> +
>   static void slave_read(void *opaque)
>   {
>       struct vhost_dev *dev =3D opaque;
> @@ -913,6 +1023,10 @@ static void slave_read(void *opaque)
>       case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG :
>           ret =3D vhost_user_slave_handle_config_change(dev);
>           break;
> +    case VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG:
> +        ret =3D vhost_user_slave_handle_vring_host_notifier(dev, &payl=
oad.area,
> +                                                          fd);
> +        break;
>       default:
>           error_report("Received unexpected msg type.");
>           if (fd !=3D -1) {
> @@ -1641,6 +1755,15 @@ VhostUserState *vhost_user_init(void)
>  =20
>   void vhost_user_cleanup(VhostUserState *user)
>   {
> +    int i;
> +
> +    for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> +        if (user->notifier[i].addr) {
> +            object_unparent(OBJECT(&user->notifier[i].mr));
> +            munmap(user->notifier[i].addr, qemu_real_host_page_size);
> +            user->notifier[i].addr =3D NULL;
> +        }
> +    }
>   }
>  =20
>   const VhostOps user_ops =3D {
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-u=
ser.h
> index eb8bc0d90d..fd660393a0 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -9,9 +9,17 @@
>   #define HW_VIRTIO_VHOST_USER_H
>  =20
>   #include "chardev/char-fe.h"
> +#include "hw/virtio/virtio.h"
> +
> +typedef struct VhostUserHostNotifier {
> +    MemoryRegion mr;
> +    void *addr;
> +    bool set;
> +} VhostUserHostNotifier;
>  =20
>   typedef struct VhostUserState {
>       CharBackend *chr;
> +    VhostUserHostNotifier notifier[VIRTIO_QUEUE_MAX];
>   } VhostUserState;
>  =20
>   VhostUserState *vhost_user_init(void);
