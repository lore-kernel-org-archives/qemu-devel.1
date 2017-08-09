Received: from eggs.gnu.org ([2001:4830:134:3::10]:37442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dfVoJ-0005A1-8w
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 14:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dfVoF-0002qF-4I
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 14:34:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dfVoE-0002oV-R8
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 14:34:23 -0400
Date: Wed, 9 Aug 2017 14:34:15 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <223333740.69259397.1502303655657.JavaMail.zimbra@redhat.com>
In-Reply-To: <1502359951-29160-4-git-send-email-changpeng.liu@intel.com>
References: <1502359951-29160-1-git-send-email-changpeng.liu@intel.com>
	<1502359951-29160-4-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] contrib/libvhost-user: enable
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
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, pbonzini@redhat.com, mst@redhat.com, felipe@nutanix.com, james r harris <james.r.harris@intel.com>

Hi

----- Original Message -----
> Enable VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG/VHOST_USER_SET_CONFIG_FD
> messages in libvhost-user library, users can implement their own I/O target
> based on the library. This enable the virtio config space delivered between
> Qemu host device and the I/O target, also event notifier is added in case
> of virtio config space changed.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 51
>  +++++++++++++++++++++++++++++++++++
>  contrib/libvhost-user/libvhost-user.h | 14 ++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index 9efb9da..002cf15 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -63,6 +63,9 @@ vu_request_to_string(int req)
>          REQ(VHOST_USER_SET_VRING_ENABLE),
>          REQ(VHOST_USER_SEND_RARP),
>          REQ(VHOST_USER_INPUT_GET_CONFIG),
> +        REQ(VHOST_USER_GET_CONFIG),
> +        REQ(VHOST_USER_SET_CONFIG),
> +        REQ(VHOST_USER_SET_CONFIG_FD),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> @@ -744,6 +747,43 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
>  }
>  
>  static bool
> +vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    if (dev->iface->get_config) {
> +        dev->iface->get_config(dev, vmsg->payload.config, vmsg->size);

better check the return value on error to avoid sending garbage back to master.

> +    }
> +
> +    return true;
> +}
> +
> +static bool
> +vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    if (dev->iface->set_config) {
> +        dev->iface->set_config(dev, vmsg->payload.config, vmsg->size);

you could perhaps make that function return void instead (since error isn't reported to master)


> +    }
> +
> +    return false;
> +}
> +
> +static bool
> +vu_set_config_fd(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +   if (vmsg->fd_num != 1) {
> +        vu_panic(dev, "Invalid config_fd message");
> +        return false;
> +    }
> +
> +    if (dev->config_fd != -1) {
> +        close(dev->config_fd);
> +    }
> +    dev->config_fd = vmsg->fds[0];
> +    DPRINT("Got config_fd: %d\n", vmsg->fds[0]);
> +
> +    return false;
> +}
> +
> +static bool
>  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      int do_reply = 0;
> @@ -806,6 +846,12 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_get_queue_num_exec(dev, vmsg);
>      case VHOST_USER_SET_VRING_ENABLE:
>          return vu_set_vring_enable_exec(dev, vmsg);
> +    case VHOST_USER_GET_CONFIG:
> +        return vu_get_config(dev, vmsg);
> +    case VHOST_USER_SET_CONFIG:
> +        return vu_set_config(dev, vmsg);
> +    case VHOST_USER_SET_CONFIG_FD:
> +        return vu_set_config_fd(dev, vmsg);
>      default:
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> @@ -878,6 +924,10 @@ vu_deinit(VuDev *dev)
>  
>      vu_close_log(dev);
>  
> +    if (dev->config_fd != -1) {
> +        close(dev->config_fd);
> +    }
> +
>      if (dev->sock != -1) {
>          close(dev->sock);
>      }
> @@ -907,6 +957,7 @@ vu_init(VuDev *dev,
>      dev->remove_watch = remove_watch;
>      dev->iface = iface;
>      dev->log_call_fd = -1;
> +    dev->config_fd = -1;
>      for (i = 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
>          dev->vq[i] = (VuVirtq) {
>              .call_fd = -1, .kick_fd = -1, .err_fd = -1,
> diff --git a/contrib/libvhost-user/libvhost-user.h
> b/contrib/libvhost-user/libvhost-user.h
> index 53ef222..899dee1 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -30,6 +30,8 @@
>  
>  #define VHOST_MEMORY_MAX_NREGIONS 8
>  
> +#define VHOST_USER_MAX_CONFIG_SIZE 256
> +
>  enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_MQ = 0,
>      VHOST_USER_PROTOCOL_F_LOG_SHMFD = 1,
> @@ -62,6 +64,9 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_VRING_ENABLE = 18,
>      VHOST_USER_SEND_RARP = 19,
>      VHOST_USER_INPUT_GET_CONFIG = 20,
> +    VHOST_USER_GET_CONFIG = 24,
> +    VHOST_USER_SET_CONFIG = 25,
> +    VHOST_USER_SET_CONFIG_FD = 26,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>  
> @@ -105,6 +110,7 @@ typedef struct VhostUserMsg {
>          struct vhost_vring_addr addr;
>          VhostUserMemory memory;
>          VhostUserLog log;
> +        uint8_t config[VHOST_USER_MAX_CONFIG_SIZE];
>      } payload;
>  
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
> @@ -132,6 +138,9 @@ typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t
> features);
>  typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
>                                    int *do_reply);
>  typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool
>  started);
> +typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, size_t len);
> +typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *config,
> +                                 size_t len);
>  
>  typedef struct VuDevIface {
>      /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
> @@ -148,6 +157,10 @@ typedef struct VuDevIface {
>      vu_process_msg_cb process_msg;
>      /* tells when queues can be processed */
>      vu_queue_set_started_cb queue_set_started;
> +    /* get the config space of the device */
> +    vu_get_config_cb get_config;
> +    /* set the config space of the device */
> +    vu_set_config_cb set_config;
>  } VuDevIface;
>  
>  typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
> @@ -212,6 +225,7 @@ struct VuDev {
>      VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>      VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
>      int log_call_fd;
> +    int config_fd;
>      uint64_t log_size;
>      uint8_t *log_table;
>      uint64_t features;
> --
> 1.9.3
> 
> 
