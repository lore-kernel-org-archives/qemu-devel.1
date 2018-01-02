Received: from eggs.gnu.org ([2001:4830:134:3::10]:53491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWOLs-0003eF-F1
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWOLq-0007pV-At
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:19:40 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWOLq-0007ow-0O
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:19:38 -0500
Received: by mail-wr0-x242.google.com with SMTP id l41so36613134wre.11
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 07:19:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514865329-29258-2-git-send-email-changpeng.liu@intel.com>
References: <1514865329-29258-1-git-send-email-changpeng.liu@intel.com>
	<1514865329-29258-2-git-send-email-changpeng.liu@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2018 16:19:35 +0100
Message-ID: <CAJ+F1CKTQ_tngms6r4_4KcX3MUt88V5xTRE+J=YYvk-MG_5yug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, james.r.harris@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>

 Hi

On Tue, Jan 2, 2018 at 4:55 AM, Changpeng Liu <changpeng.liu@intel.com> wro=
te:
> Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
> used for live migration of vhost user devices, also vhost user devices
> can benefit from the messages to get/set virtio config space from/to the
> I/O target. For the purpose to support virtio config space change,
> VHOST_USER_SLAVE_CONFIG_CHANGE_MSG message is added as the event notifier
> in case virtio config space change in the slave I/O target.
>
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  docs/interop/vhost-user.txt       |  53 +++++++++++++++++
>  hw/virtio/vhost-user.c            | 118 ++++++++++++++++++++++++++++++++=
++++++
>  hw/virtio/vhost.c                 |  32 +++++++++++
>  include/hw/virtio/vhost-backend.h |  12 ++++
>  include/hw/virtio/vhost.h         |  15 +++++
>  5 files changed, 230 insertions(+)
>
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 954771d..1788fff 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -116,6 +116,19 @@ Depending on the request type, payload can be:
>      - 3: IOTLB invalidate
>      - 4: IOTLB access fail
>
> + * Virtio device config space
> +   -----------------------------------
> +   | offset | size | flags | payload |
> +   -----------------------------------
> +
> +   Offset: a 32-bit offset of virtio device's configuration space
> +   Size: a 32-bit configuration space access size in bytes
> +   Flags: a 32-bit value:
> +    - 0: Vhost master messages used for writeable fields
> +    - 1: Vhost master messages used for live migration
> +   Payload: Size bytes array holding the contents of the virtio
> +       device's configuration space
> +
>  In QEMU the vhost-user message is implemented with the following struct:
>
>  typedef struct VhostUserMsg {
> @@ -129,6 +142,7 @@ typedef struct VhostUserMsg {
>          VhostUserMemory memory;
>          VhostUserLog log;
>          struct vhost_iotlb_msg iotlb;
> +        VhostUserConfig config;
>      };
>  } QEMU_PACKED VhostUserMsg;
>
> @@ -596,6 +610,30 @@ Master message types
>        and expect this message once (per VQ) during device configuration
>        (ie. before the master starts the VQ).
>
> + * VHOST_USER_GET_CONFIG
> +
> +      Id: 24
> +      Equivalent ioctl: N/A

Please document the Master payload. (msg.size !=3D 0)


> +      Slave payload: virtio device config space
> +
> +      Submitted by the vhost-user master to fetch the contents of the vi=
rtio
> +      device configuration space, vhost-user slave's payload size MUST m=
atch
> +      master's request, vhost-user slave uses zero length of payload to
> +      indicate an error to vhost-user master. The vhost-user master may
> +      cache the contents to avoid repeated VHOST_USER_GET_CONFIG calls.
> +
> +* VHOST_USER_SET_CONFIG
> +
> +      Id: 25
> +      Equivalent ioctl: N/A

Same here

> +      Master payload: virtio device config space
> +
> +      Submitted by the vhost-user master when the Guest changes the virt=
io
> +      device configuration space and also can be used for live migration
> +      on the destination host. The vhost-user slave must check the flags
> +      field, and slaves MUST NOT accept SET_CONFIG for read-only
> +      configuration space fields unless the live migration bit is set.
> +
>  Slave message types
>  -------------------
>
> @@ -614,6 +652,21 @@ Slave message types
>        This request should be send only when VIRTIO_F_IOMMU_PLATFORM feat=
ure
>        has been successfully negotiated.
>
> +* VHOST_USER_SLAVE_CONFIG_CHANGE_MSG
> +
> +     Id: 2
> +     Equivalent ioctl: N/A
> +     Slave payload: N/A
> +     Master payload: N/A
> +
> +     Vhost-user slave sends such messages to notify that the virtio devi=
ce's
> +     configuration space has changed, for those host devices which can s=
upport
> +     such feature, host driver can send VHOST_USER_GET_CONFIG message to=
 slave
> +     to get the latest content. If VHOST_USER_PROTOCOL_F_REPLY_ACK is
> +     negotiated, and slave set the VHOST_USER_NEED_REPLY flag, master mu=
st
> +     respond with zero when operation is successfully completed, or non-=
zero
> +     otherwise.
> +
>  VHOST_USER_PROTOCOL_F_REPLY_ACK:
>  -------------------------------
>  The original vhost-user specification only demands replies for certain
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 093675e..8b94688 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -26,6 +26,11 @@
>  #define VHOST_MEMORY_MAX_NREGIONS    8
>  #define VHOST_USER_F_PROTOCOL_FEATURES 30
>
> +/*
> + * Maximum size of virtio device config space
> + */
> +#define VHOST_USER_MAX_CONFIG_SIZE 256
> +
>  enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_MQ =3D 0,
>      VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
> @@ -65,12 +70,15 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
>      VHOST_USER_IOTLB_MSG =3D 22,
>      VHOST_USER_SET_VRING_ENDIAN =3D 23,
> +    VHOST_USER_GET_CONFIG =3D 24,
> +    VHOST_USER_SET_CONFIG =3D 25,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
>  typedef enum VhostUserSlaveRequest {
>      VHOST_USER_SLAVE_NONE =3D 0,
>      VHOST_USER_SLAVE_IOTLB_MSG =3D 1,
> +    VHOST_USER_SLAVE_CONFIG_CHANGE_MSG =3D 2,
>      VHOST_USER_SLAVE_MAX
>  }  VhostUserSlaveRequest;
>
> @@ -92,6 +100,18 @@ typedef struct VhostUserLog {
>      uint64_t mmap_offset;
>  } VhostUserLog;
>
> +typedef struct VhostUserConfig {
> +    uint32_t offset;
> +    uint32_t size;
> +    uint32_t flags;
> +    uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
> +} VhostUserConfig;
> +
> +static VhostUserConfig c __attribute__ ((unused));
> +#define VHOST_USER_CONFIG_HDR_SIZE (sizeof(c.offset) \
> +                                   + sizeof(c.size) \
> +                                   + sizeof(c.flags))
> +
>  typedef struct VhostUserMsg {
>      VhostUserRequest request;
>
> @@ -109,6 +129,7 @@ typedef struct VhostUserMsg {
>          VhostUserMemory memory;
>          VhostUserLog log;
>          struct vhost_iotlb_msg iotlb;
> +        VhostUserConfig config;
>      } payload;
>  } QEMU_PACKED VhostUserMsg;
>
> @@ -608,6 +629,21 @@ static int vhost_user_reset_device(struct vhost_dev =
*dev)
>      return 0;
>  }
>
> +static int vhost_user_slave_handle_config_change(struct vhost_dev *dev)
> +{
> +    int ret =3D -1;
> +
> +    if (!dev->config_ops) {
> +        return -1;
> +    }
> +
> +    if (dev->config_ops->vhost_dev_config_notifier) {
> +        ret =3D dev->config_ops->vhost_dev_config_notifier(dev);
> +    }
> +
> +    return ret;
> +}
> +
>  static void slave_read(void *opaque)
>  {
>      struct vhost_dev *dev =3D opaque;
> @@ -640,6 +676,9 @@ static void slave_read(void *opaque)
>      case VHOST_USER_SLAVE_IOTLB_MSG:
>          ret =3D vhost_backend_handle_iotlb_msg(dev, &msg.payload.iotlb);
>          break;
> +    case VHOST_USER_SLAVE_CONFIG_CHANGE_MSG :
> +        ret =3D vhost_user_slave_handle_config_change(dev);
> +        break;
>      default:
>          error_report("Received unexpected msg type.");
>          ret =3D -EINVAL;
> @@ -922,6 +961,83 @@ static void vhost_user_set_iotlb_callback(struct vho=
st_dev *dev, int enabled)
>      /* No-op as the receive channel is not dedicated to IOTLB messages. =
*/
>  }
>
> +static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
> +                                 uint32_t config_len)
> +{
> +    VhostUserMsg msg =3D {
> +        msg.request =3D VHOST_USER_GET_CONFIG,
> +        msg.flags =3D VHOST_USER_VERSION,
> +        msg.size =3D VHOST_USER_CONFIG_HDR_SIZE + config_len,

Not really clear to me why we would need to send config_len zero's for regi=
on[].

> +    };
> +
> +    if (config_len > VHOST_USER_MAX_CONFIG_SIZE) {
> +        return -1;
> +    }
> +
> +    msg.payload.config.offset =3D 0;
> +    msg.payload.config.size =3D config_len;
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        return -1;
> +    }
> +
> +    if (vhost_user_read(dev, &msg) < 0) {
> +        return -1;
> +    }
> +
> +    if (msg.request !=3D VHOST_USER_GET_CONFIG) {
> +        error_report("Received unexpected msg type. Expected %d received=
 %d",
> +                     VHOST_USER_GET_CONFIG, msg.request);
> +        return -1;
> +    }
> +
> +    if (msg.size !=3D VHOST_USER_CONFIG_HDR_SIZE + config_len) {
> +        error_report("Received bad msg size.");
> +        return -1;
> +    }
> +
> +    memcpy(config, msg.payload.config.region, config_len);
> +
> +    return 0;
> +}
> +
> +static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t *d=
ata,
> +                                 uint32_t offset, uint32_t size, uint32_=
t flags)
> +{
> +    uint8_t *p;
> +    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> +                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +
> +    VhostUserMsg msg =3D {
> +        msg.request =3D VHOST_USER_SET_CONFIG,
> +        msg.flags =3D VHOST_USER_VERSION,
> +        msg.size =3D VHOST_USER_CONFIG_HDR_SIZE + size,
> +    };
> +
> +    if (reply_supported) {
> +        msg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    if (size > VHOST_USER_MAX_CONFIG_SIZE) {
> +        return -1;
> +    }
> +
> +    msg.payload.config.offset =3D offset,
> +    msg.payload.config.size =3D size,
> +    msg.payload.config.flags =3D flags,
> +    p =3D msg.payload.config.region;
> +    memcpy(p, data, size);
> +
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        return -1;
> +    }
> +
> +    if (reply_supported) {
> +        return process_message_reply(dev, &msg);
> +    }
> +
> +    return 0;
> +}
> +
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_init,
> @@ -948,4 +1064,6 @@ const VhostOps user_ops =3D {
>          .vhost_net_set_mtu =3D vhost_user_net_set_mtu,
>          .vhost_set_iotlb_callback =3D vhost_user_set_iotlb_callback,
>          .vhost_send_device_iotlb_msg =3D vhost_user_send_device_iotlb_ms=
g,
> +        .vhost_get_config =3D vhost_user_get_config,
> +        .vhost_set_config =3D vhost_user_set_config,
>  };
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e4290ce..386aef8 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1505,6 +1505,38 @@ void vhost_ack_features(struct vhost_dev *hdev, co=
nst int *feature_bits,
>      }
>  }
>
> +int vhost_dev_get_config(struct vhost_dev *hdev, uint8_t *config,
> +                         uint32_t config_len)
> +{
> +    assert(hdev->vhost_ops);
> +
> +    if (hdev->vhost_ops->vhost_get_config) {
> +        return hdev->vhost_ops->vhost_get_config(hdev, config, config_le=
n);
> +    }
> +
> +    return -1;
> +}
> +
> +int vhost_dev_set_config(struct vhost_dev *hdev, const uint8_t *data,
> +                         uint32_t offset, uint32_t size, uint32_t flags)
> +{
> +    assert(hdev->vhost_ops);
> +
> +    if (hdev->vhost_ops->vhost_set_config) {
> +        return hdev->vhost_ops->vhost_set_config(hdev, data, offset,
> +                                                 size, flags);
> +    }
> +
> +    return -1;
> +}
> +
> +void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
> +                                   const VhostDevConfigOps *ops)
> +{
> +    assert(hdev->vhost_ops);
> +    hdev->config_ops =3D ops;
> +}
> +
>  /* Host notifiers must be enabled at this point. */
>  int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
>  {
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index a7a5f22..592254f 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -20,6 +20,11 @@ typedef enum VhostBackendType {
>      VHOST_BACKEND_TYPE_MAX =3D 3,
>  } VhostBackendType;
>
> +typedef enum VhostSetConfigType {
> +    VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
> +    VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
> +} VhostSetConfigType;
> +
>  struct vhost_dev;
>  struct vhost_log;
>  struct vhost_memory;
> @@ -84,6 +89,11 @@ typedef void (*vhost_set_iotlb_callback_op)(struct vho=
st_dev *dev,
>                                             int enabled);
>  typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
>                                                struct vhost_iotlb_msg *im=
sg);
> +typedef int (*vhost_set_config_op)(struct vhost_dev *dev, const uint8_t =
*data,
> +                                   uint32_t offset, uint32_t size,
> +                                   uint32_t flags);
> +typedef int (*vhost_get_config_op)(struct vhost_dev *dev, uint8_t *confi=
g,
> +                                   uint32_t config_len);
>
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
> @@ -118,6 +128,8 @@ typedef struct VhostOps {
>      vhost_vsock_set_running_op vhost_vsock_set_running;
>      vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
>      vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
> +    vhost_get_config_op vhost_get_config;
> +    vhost_set_config_op vhost_set_config;
>  } VhostOps;
>
>  extern const VhostOps user_ops;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 467dc77..1dc2d73 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -46,6 +46,12 @@ struct vhost_iommu {
>      QLIST_ENTRY(vhost_iommu) iommu_next;
>  };
>
> +typedef struct VhostDevConfigOps {
> +    /* Vhost device config space changed callback
> +     */
> +    int (*vhost_dev_config_notifier)(struct vhost_dev *dev);
> +} VhostDevConfigOps;
> +
>  struct vhost_memory;
>  struct vhost_dev {
>      VirtIODevice *vdev;
> @@ -76,6 +82,7 @@ struct vhost_dev {
>      QLIST_ENTRY(vhost_dev) entry;
>      QLIST_HEAD(, vhost_iommu) iommu_list;
>      IOMMUNotifier n;
> +    const VhostDevConfigOps *config_ops;
>  };
>
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> @@ -106,4 +113,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
>                            struct vhost_vring_file *file);
>
>  int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int wr=
ite);
> +int vhost_dev_get_config(struct vhost_dev *dev, uint8_t *config,
> +                         uint32_t config_len);
> +int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *data,
> +                         uint32_t offset, uint32_t size, uint32_t flags)=
;
> +/* notifier callback in case vhost device config space changed
> + */
> +void vhost_dev_set_config_notifier(struct vhost_dev *dev,
> +                                   const VhostDevConfigOps *ops);
>  #endif
> --
> 1.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
