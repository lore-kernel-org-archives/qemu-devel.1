Received: from eggs.gnu.org ([2001:4830:134:3::10]:59283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWOVU-0000sF-Ql
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eWOVT-0005wT-CD
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:29:36 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eWOVT-0005wB-1V
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 10:29:35 -0500
Received: by mail-wr0-x241.google.com with SMTP id y9so6720185wrb.5
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 07:29:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514865329-29258-4-git-send-email-changpeng.liu@intel.com>
References: <1514865329-29258-1-git-send-email-changpeng.liu@intel.com>
	<1514865329-29258-4-git-send-email-changpeng.liu@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2018 16:29:33 +0100
Message-ID: <CAJ+F1CJ22QQbLYBfi4QijDZ7fEg06-7uuVz3F8jdAaLqCU4X3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 3/4] contrib/libvhost-user: enable
 virtio config space messages
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
> Enable VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages in
> libvhost-user library, users can implement their own I/O target
> based on the library. This enable the virtio config space delivered
> between QEMU host device and the I/O target.
>
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 54 +++++++++++++++++++++++++++++=
++++++
>  contrib/libvhost-user/libvhost-user.h | 34 +++++++++++++++++++++-
>  2 files changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index f409bd3..9e12eb1 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -84,6 +84,8 @@ vu_request_to_string(unsigned int req)
>          REQ(VHOST_USER_SET_SLAVE_REQ_FD),
>          REQ(VHOST_USER_IOTLB_MSG),
>          REQ(VHOST_USER_SET_VRING_ENDIAN),
> +        REQ(VHOST_USER_GET_CONFIG),
> +        REQ(VHOST_USER_SET_CONFIG),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> @@ -798,6 +800,53 @@ vu_set_slave_req_fd(VuDev *dev, VhostUserMsg *vmsg)
>  }
>
>  static bool
> +vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    int ret =3D -1;
> +
> +    if (dev->iface->get_config) {
> +        ret =3D dev->iface->get_config(dev, vmsg->payload.config.region,
> +                                     vmsg->payload.config.size);
> +    }
> +
> +    if (ret) {
> +        /* resize to zero to indicate an error to master */
> +        vmsg->size =3D 0;
> +    }
> +
> +    return true;
> +}
> +
> +static bool
> +vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    int ret =3D -1;
> +    bool reply_supported =3D !!(dev->protocol_features &
> +                             (1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK));
> +

None of the other messages in libvhost-user support the REPLY_ACK
flag. Do you need it? If not, please drop it.

If you need it, it's a better idea to make the reply explicit and
mandatory in the protocol for SET_CONFIG.

> +    if (dev->iface->set_config) {
> +        ret =3D dev->iface->set_config(dev, vmsg->payload.config.region,
> +                                     vmsg->payload.config.offset,
> +                                     vmsg->payload.config.size,
> +                                     vmsg->payload.config.flags);
> +    }
> +
> +    vmsg->size =3D sizeof(vmsg->payload.u64);
> +    if (!ret) {
> +        vmsg->payload.u64 =3D 0;
> +    } else {
> +        /* indicate an error in case reply supported */
> +        vmsg->payload.u64 =3D 1;
> +    }
> +
> +    if (reply_supported) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static bool
>  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      int do_reply =3D 0;
> @@ -862,6 +911,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_set_vring_enable_exec(dev, vmsg);
>      case VHOST_USER_SET_SLAVE_REQ_FD:
>          return vu_set_slave_req_fd(dev, vmsg);
> +    case VHOST_USER_GET_CONFIG:
> +        return vu_get_config(dev, vmsg);
> +    case VHOST_USER_SET_CONFIG:
> +        return vu_set_config(dev, vmsg);
>      case VHOST_USER_NONE:
>          break;
>      default:
> @@ -970,6 +1023,7 @@ vu_init(VuDev *dev,
>      dev->iface =3D iface;
>      dev->log_call_fd =3D -1;
>      dev->slave_fd =3D -1;
> +

unrelated coding style change, please drop

>      for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
>          dev->vq[i] =3D (VuVirtq) {
>              .call_fd =3D -1, .kick_fd =3D -1, .err_fd =3D -1,
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 2f5864b..b38959e 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -30,6 +30,16 @@
>
>  #define VHOST_MEMORY_MAX_NREGIONS 8
>
> +typedef enum VhostSetConfigType {
> +    VHOST_SET_CONFIG_TYPE_MASTER =3D 0,
> +    VHOST_SET_CONFIG_TYPE_MIGRATION =3D 1,
> +} VhostSetConfigType;
> +
> +/*
> + * Maximum size of virtio device config space
> + */
> +#define VHOST_USER_MAX_CONFIG_SIZE 256
> +
>  enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_MQ =3D 0,
>      VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
> @@ -38,7 +48,6 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_NET_MTU =3D 4,
>      VHOST_USER_PROTOCOL_F_SLAVE_REQ =3D 5,
>      VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
> -


unrelated coding style change, please drop

>      VHOST_USER_PROTOCOL_F_MAX
>  };
>
> @@ -69,6 +78,8 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
>      VHOST_USER_IOTLB_MSG =3D 22,
>      VHOST_USER_SET_VRING_ENDIAN =3D 23,
> +    VHOST_USER_GET_CONFIG =3D 24,
> +    VHOST_USER_SET_CONFIG =3D 25,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> @@ -90,6 +101,18 @@ typedef struct VhostUserLog {
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
>  #if defined(_WIN32)
>  # define VU_PACKED __attribute__((gcc_struct, packed))
>  #else
> @@ -112,6 +135,7 @@ typedef struct VhostUserMsg {
>          struct vhost_vring_addr addr;
>          VhostUserMemory memory;
>          VhostUserLog log;
> +        VhostUserConfig config;
>      } payload;
>
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
> @@ -140,6 +164,10 @@ typedef int (*vu_process_msg_cb) (VuDev *dev, VhostU=
serMsg *vmsg,
>                                    int *do_reply);
>  typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool star=
ted);
>  typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx)=
;
> +typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t l=
en);
> +typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *data,
> +                                 uint32_t offset, uint32_t size,
> +                                 uint32_t flags);
>
>  typedef struct VuDevIface {
>      /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
> @@ -162,6 +190,10 @@ typedef struct VuDevIface {
>       * on unmanaged exit/crash.
>       */
>      vu_queue_is_processed_in_order_cb queue_is_processed_in_order;
> +    /* get the config space of the device */
> +    vu_get_config_cb get_config;
> +    /* set the config space of the device */
> +    vu_set_config_cb set_config;
>  } VuDevIface;
>
>  typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
> --
> 1.9.3
>


--=20
Marc-Andr=C3=A9 Lureau
