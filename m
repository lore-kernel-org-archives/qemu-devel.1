Received: from eggs.gnu.org ([2001:4830:134:3::10]:58529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRj6O-0008LM-DU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRj6G-0007Nn-Rh
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:28:24 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:46760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eRj6G-0007MC-9g
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:28:16 -0500
Received: by mail-wm0-x22f.google.com with SMTP id r78so11700493wme.5
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 10:28:16 -0800 (PST)
MIME-Version: 1.0
References: <1513132143-10758-1-git-send-email-changpeng.liu@intel.com>
	<1513132143-10758-2-git-send-email-changpeng.liu@intel.com>
	<CAJ+F1CKDUvseu=FsTXGY=2u1kiC0xh0xUMTmi4kuhA-KO2981Q@mail.gmail.com>
In-Reply-To: <CAJ+F1CKDUvseu=FsTXGY=2u1kiC0xh0xUMTmi4kuhA-KO2981Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Dec 2017 18:28:04 +0000
Message-ID: <CAJ+F1CJsTk9uTfxyvVQtKSNbyyz9he+CSV5KH6PXQ6ym3QLwSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, james.r.harris@intel.com

Michael, did you merge that one too? I think the series shouldn't be
applied yet until my concerns are cleared.  Thanks

Le mer. 20 d=C3=A9c. 2017 =C3=A0 16:47, Marc-Andr=C3=A9 Lureau <marcandre.l=
ureau@gmail.com>
a =C3=A9crit :

> Hi
>
> On Wed, Dec 13, 2017 at 3:29 AM, Changpeng Liu <changpeng.liu@intel.com>
> wrote:
> > Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
> > used for live migration of vhost user devices, also vhost user devices
> > can benefit from the messages to get/set virtio config space from/to th=
e
> > I/O target. For the purpose to support virtio config space change,
> > VHOST_USER_SET_CONFIG_FD message is added as the event notifier
> > in case virtio config space change in the I/O target.
>
> Why not use a new slave message instead of adding another fd to watch for=
?
>
> VHOST_USER_SLAVE_SET_CONFIG: notify the master of device configuration
> space change
>
>
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > ---
> >  docs/interop/vhost-user.txt       |  45 ++++++++++++++++
> >  hw/virtio/vhost-user.c            | 107
> ++++++++++++++++++++++++++++++++++++++
> >  hw/virtio/vhost.c                 |  64 +++++++++++++++++++++++
> >  include/hw/virtio/vhost-backend.h |  14 +++++
> >  include/hw/virtio/vhost.h         |  16 ++++++
> >  5 files changed, 246 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > index 954771d..826ba18 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -116,6 +116,19 @@ Depending on the request type, payload can be:
> >      - 3: IOTLB invalidate
> >      - 4: IOTLB access fail
> >
> > + * Virtio device config space
> > +   -----------------------------------
> > +   | offset | size | flags | payload |
> > +   -----------------------------------
> > +
> > +   Offset: a 32-bit offset of virtio device's configuration space
> > +   Size: a 32-bit configuration space access size in bytes
> > +   Flags: a 32-bit value:
> > +    - 0: Vhost master messages used for writeable fields
> > +    - 1: Vhost master messages used for live migration
> > +   Payload: Size bytes array holding the contents of the virtio
> > +       device's configuration space
> > +
> >  In QEMU the vhost-user message is implemented with the following struc=
t:
> >
> >  typedef struct VhostUserMsg {
> > @@ -129,6 +142,7 @@ typedef struct VhostUserMsg {
> >          VhostUserMemory memory;
> >          VhostUserLog log;
> >          struct vhost_iotlb_msg iotlb;
> > +        VhostUserConfig config;
> >      };
> >  } QEMU_PACKED VhostUserMsg;
> >
> > @@ -596,6 +610,37 @@ Master message types
> >        and expect this message once (per VQ) during device configuratio=
n
> >        (ie. before the master starts the VQ).
> >
> > + * VHOST_USER_GET_CONFIG
>
> Please add an empty line (same style as other messages). Same for
> other messages.
>
> > +      Id: 24
> > +      Equivalent ioctl: N/A
> > +      Master payload: virtio device config space
>
> Why is the master sending the current config space? I suppose the
> content should be meaningful then. Make that explicit in the spec
> please
>
> + missing Slave payload (make it explicit that size must match)
>
> > +
> > +      Submitted by the vhost-user master to fetch the contents of the
> virtio
> > +      device configuration space, vhost-user slave uses zero length of
> payload
> > +      to indicate an error to vhost-user master. The vhost-user master
> may
> > +      cache the contents to avoid repeated VHOST_USER_GET_CONFIG calls=
.
> > +
> > +* VHOST_USER_SET_CONFIG
> > +      Id: 25
> > +      Equivalent ioctl: N/A
> > +      Master payload: virtio device config space
> > +
> > +      Submitted by the vhost-user master when the Guest changes the
> virtio
> > +      device configuration space and also can be used for live migrati=
on
> > +      on the destination host. The vhost-user slave must check the fla=
gs
> > +      field, and slaves MUST NOT accept SET_CONFIG for read-only
> > +      configuration space fields unless the live migration bit is set.
>
> I would make reply mandatory for any newly introduced message. If not,
> please add the message to the list that don't in "Communication"
>
> > +
> > +* VHOST_USER_SET_CONFIG_FD
> > +      Id: 26
> > +      Equivalent ioctl: N/A
> > +      Master payload: N/A
> > +
> > +      Sets the notifier file descriptor, which is passed as ancillary
> data.
> > +      The vhost-user slave uses the file descriptor to notify the
> vhost-user
> > +      master of changes to the virtio configuration space. The
> vhost-user
> > +      master can read the virtio configuration space to get the latest
> update.
>
> Imho there should be a slave message instead.
>
> > +
> >  Slave message types
> >  -------------------
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 093675e..037c165 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -26,6 +26,11 @@
> >  #define VHOST_MEMORY_MAX_NREGIONS    8
> >  #define VHOST_USER_F_PROTOCOL_FEATURES 30
> >
> > +/*
> > + * Maximum size of virtio device config space
> > + */
> > +#define VHOST_USER_MAX_CONFIG_SIZE 256
> > +
> >  enum VhostUserProtocolFeature {
> >      VHOST_USER_PROTOCOL_F_MQ =3D 0,
> >      VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
> > @@ -65,6 +70,9 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
> >      VHOST_USER_IOTLB_MSG =3D 22,
> >      VHOST_USER_SET_VRING_ENDIAN =3D 23,
> > +    VHOST_USER_GET_CONFIG =3D 24,
> > +    VHOST_USER_SET_CONFIG =3D 25,
> > +    VHOST_USER_SET_CONFIG_FD =3D 26,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > @@ -92,6 +100,18 @@ typedef struct VhostUserLog {
> >      uint64_t mmap_offset;
> >  } VhostUserLog;
> >
> > +typedef struct VhostUserConfig {
> > +    uint32_t offset;
> > +    uint32_t size;
> > +    uint32_t flags;
> > +    uint8_t region[VHOST_USER_MAX_CONFIG_SIZE];
> > +} VhostUserConfig;
> > +
> > +static VhostUserConfig c __attribute__ ((unused));
> > +#define VHOST_USER_CONFIG_HDR_SIZE (sizeof(c.offset) \
> > +                                   + sizeof(c.size) \
> > +                                   + sizeof(c.flags))
> > +
> >  typedef struct VhostUserMsg {
> >      VhostUserRequest request;
> >
> > @@ -109,6 +129,7 @@ typedef struct VhostUserMsg {
> >          VhostUserMemory memory;
> >          VhostUserLog log;
> >          struct vhost_iotlb_msg iotlb;
> > +        VhostUserConfig config;
> >      } payload;
> >  } QEMU_PACKED VhostUserMsg;
> >
> > @@ -922,6 +943,89 @@ static void vhost_user_set_iotlb_callback(struct
> vhost_dev *dev, int enabled)
> >      /* No-op as the receive channel is not dedicated to IOTLB messages=
.
> */
> >  }
> >
> > +static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *confi=
g,
> > +                                 uint32_t config_len)
> > +{
> > +    VhostUserMsg msg =3D {
> > +        msg.request =3D VHOST_USER_GET_CONFIG,
> > +        msg.flags =3D VHOST_USER_VERSION,
> > +        msg.size =3D VHOST_USER_CONFIG_HDR_SIZE + config_len,
> > +    };
> > +
> > +    msg.payload.config.offset =3D 0;
> > +    msg.payload.config.size =3D config_len;
> > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > +        return -1;
> > +    }
>
> if config_len > VHOST_USER_MAX_CONFIG_SIZE, I think there will be a
> stack overflow. Add an assert() ?
>
> > +
> > +    if (vhost_user_read(dev, &msg) < 0) {
> > +        return -1;
> > +    }
> > +
> > +    if (msg.request !=3D VHOST_USER_GET_CONFIG) {
> > +        error_report("Received unexpected msg type. Expected %d
> received %d",
> > +                     VHOST_USER_GET_CONFIG, msg.request);
> > +        return -1;
> > +    }
> > +
> > +    if (msg.size !=3D VHOST_USER_CONFIG_HDR_SIZE + config_len) {
> > +        error_report("Received bad msg size.");
> > +        return -1;
> > +    }
> > +
> > +    memcpy(config, msg.payload.config.region, config_len);
> > +
> > +    return 0;
> > +}
> > +
> > +static int vhost_user_set_config(struct vhost_dev *dev, const uint8_t
> *data,
> > +                                 uint32_t offset, uint32_t size,
> uint32_t flags)
> > +{
> > +    uint8_t *p;
> > +    bool reply_supported =3D virtio_has_feature(dev->protocol_features=
,
> > +
> VHOST_USER_PROTOCOL_F_REPLY_ACK);
> > +
> > +    VhostUserMsg msg =3D {
> > +        msg.request =3D VHOST_USER_SET_CONFIG,
> > +        msg.flags =3D VHOST_USER_VERSION,
> > +        msg.size =3D VHOST_USER_CONFIG_HDR_SIZE + size,
> > +    };
> > +
> > +    if (reply_supported) {
> > +        msg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > +    }
> > +
> > +    msg.payload.config.offset =3D offset,
> > +    msg.payload.config.size =3D size,
> > +    msg.payload.config.flags =3D flags,
> > +    p =3D msg.payload.config.region;
> > +    memcpy(p, data, size);
>
> here again, max config size should be checked.
>
> > +
> > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > +        return -1;
> > +    }
> > +
> > +    if (reply_supported) {
> > +        return process_message_reply(dev, &msg);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int vhost_user_set_config_fd(struct vhost_dev *dev, int fd)
> > +{
> > +    VhostUserMsg msg =3D {
> > +       .request =3D VHOST_USER_SET_CONFIG_FD,
> > +       .flags =3D VHOST_USER_VERSION,
> > +    };
> > +
> > +    if (vhost_user_write(dev, &msg, &fd, 1) < 0) {
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  const VhostOps user_ops =3D {
> >          .backend_type =3D VHOST_BACKEND_TYPE_USER,
> >          .vhost_backend_init =3D vhost_user_init,
> > @@ -948,4 +1052,7 @@ const VhostOps user_ops =3D {
> >          .vhost_net_set_mtu =3D vhost_user_net_set_mtu,
> >          .vhost_set_iotlb_callback =3D vhost_user_set_iotlb_callback,
> >          .vhost_send_device_iotlb_msg =3D vhost_user_send_device_iotlb_=
msg,
> > +        .vhost_get_config =3D vhost_user_get_config,
> > +        .vhost_set_config =3D vhost_user_set_config,
> > +        .vhost_set_config_fd =3D vhost_user_set_config_fd,
> >  };
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index e4290ce..aa93398 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -1358,6 +1358,9 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
> >      for (i =3D 0; i < hdev->nvqs; ++i) {
> >          vhost_virtqueue_cleanup(hdev->vqs + i);
> >      }
> > +    if (hdev->config_ops) {
> > +        event_notifier_cleanup(&hdev->config_notifier);
> > +    }
> >      if (hdev->mem) {
> >          /* those are only safe after successful init */
> >          memory_listener_unregister(&hdev->memory_listener);
> > @@ -1505,6 +1508,67 @@ void vhost_ack_features(struct vhost_dev *hdev,
> const int *feature_bits,
> >      }
> >  }
> >
> > +int vhost_dev_get_config(struct vhost_dev *hdev, uint8_t *config,
> > +                         uint32_t config_len)
> > +{
> > +    assert(hdev->vhost_ops);
> > +
> > +    if (hdev->vhost_ops->vhost_get_config) {
> > +        return hdev->vhost_ops->vhost_get_config(hdev, config,
> config_len);
> > +    }
> > +
> > +    return -1;
> > +}
> > +
> > +int vhost_dev_set_config(struct vhost_dev *hdev, const uint8_t *data,
> > +                         uint32_t offset, uint32_t size, uint32_t flag=
s)
> > +{
> > +    assert(hdev->vhost_ops);
> > +
> > +    if (hdev->vhost_ops->vhost_set_config) {
> > +        return hdev->vhost_ops->vhost_set_config(hdev, data, offset,
> > +                                                 size, flags);
> > +    }
> > +
> > +    return -1;
> > +}
> > +
> > +static void vhost_dev_config_notifier_read(EventNotifier *n)
> > +{
> > +    struct vhost_dev *hdev =3D container_of(n, struct vhost_dev,
> > +                                         config_notifier);
> > +
> > +    if (event_notifier_test_and_clear(n)) {
> > +        if (hdev->config_ops) {
> > +            hdev->config_ops->vhost_dev_config_notifier(hdev);
> > +        }
> > +    }
> > +}
> > +
> > +int vhost_dev_set_config_notifier(struct vhost_dev *hdev,
> > +                                  const VhostDevConfigOps *ops)
> > +{
> > +    int r, fd;
> > +
> > +    assert(hdev->vhost_ops);
> > +
> > +    r =3D event_notifier_init(&hdev->config_notifier, 0);
> > +    if (r < 0) {
> > +        return r;
> > +    }
> > +
> > +    hdev->config_ops =3D ops;
> > +    event_notifier_set_handler(&hdev->config_notifier,
> > +                               vhost_dev_config_notifier_read);
> > +
> > +    if (hdev->vhost_ops->vhost_set_config_fd) {
> > +        fd  =3D event_notifier_get_fd(&hdev->config_notifier);
> > +        return hdev->vhost_ops->vhost_set_config_fd(hdev, fd);
> > +    }
> > +
> > +    return -1;
> > +}
> > +
> >  /* Host notifiers must be enabled at this point. */
> >  int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >  {
> > diff --git a/include/hw/virtio/vhost-backend.h
> b/include/hw/virtio/vhost-backend.h
> > index a7a5f22..8996d5f 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -20,6 +20,11 @@ typedef enum VhostBackendType {
> >      VHOST_BACKEND_TYPE_MAX =3D 3,
> >  } VhostBackendType;
> >
> > +typedef enum VhostSetConfigType {
> > +    VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
> > +    VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
> > +} VhostSetConfigType;
> > +
> >  struct vhost_dev;
> >  struct vhost_log;
> >  struct vhost_memory;
> > @@ -84,6 +89,12 @@ typedef void (*vhost_set_iotlb_callback_op)(struct
> vhost_dev *dev,
> >                                             int enabled);
> >  typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
> >                                                struct vhost_iotlb_msg
> *imsg);
> > +typedef int (*vhost_set_config_op)(struct vhost_dev *dev, const uint8_=
t
> *data,
> > +                                   uint32_t offset, uint32_t size,
> > +                                   uint32_t flags);
> > +typedef int (*vhost_get_config_op)(struct vhost_dev *dev, uint8_t
> *config,
> > +                                   uint32_t config_len);
> > +typedef int (*vhost_set_config_fd_op)(struct vhost_dev *dev, int fd);
> >
> >  typedef struct VhostOps {
> >      VhostBackendType backend_type;
> > @@ -118,6 +129,9 @@ typedef struct VhostOps {
> >      vhost_vsock_set_running_op vhost_vsock_set_running;
> >      vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
> >      vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
> > +    vhost_get_config_op vhost_get_config;
> > +    vhost_set_config_op vhost_set_config;
> > +    vhost_set_config_fd_op vhost_set_config_fd;
> >  } VhostOps;
> >
> >  extern const VhostOps user_ops;
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 467dc77..7f43a82 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -46,6 +46,12 @@ struct vhost_iommu {
> >      QLIST_ENTRY(vhost_iommu) iommu_next;
> >  };
> >
> > +typedef struct VhostDevConfigOps {
> > +    /* Vhost device config space changed callback
> > +     */
> > +    void (*vhost_dev_config_notifier)(struct vhost_dev *dev);
> > +} VhostDevConfigOps;
> > +
> >  struct vhost_memory;
> >  struct vhost_dev {
> >      VirtIODevice *vdev;
> > @@ -76,6 +82,8 @@ struct vhost_dev {
> >      QLIST_ENTRY(vhost_dev) entry;
> >      QLIST_HEAD(, vhost_iommu) iommu_list;
> >      IOMMUNotifier n;
> > +    EventNotifier config_notifier;
> > +    const VhostDevConfigOps *config_ops;
> >  };
> >
> >  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> > @@ -106,4 +114,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
> >                            struct vhost_vring_file *file);
> >
> >  int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int
> write);
> > +int vhost_dev_get_config(struct vhost_dev *dev, uint8_t *config,
> > +                         uint32_t config_len);
> > +int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *data,
> > +                         uint32_t offset, uint32_t size, uint32_t
> flags);
> > +/* notifier callback in case vhost device config space changed
> > + */
> > +int vhost_dev_set_config_notifier(struct vhost_dev *dev,
> > +                                  const VhostDevConfigOps *ops);
> >  #endif
> > --
> > 1.9.3
> >
> >
>
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
--=20
Marc-Andr=C3=A9 Lureau
