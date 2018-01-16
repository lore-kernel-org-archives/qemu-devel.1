Received: from eggs.gnu.org ([2001:4830:134:3::10]:54415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebHYv-0004Sr-Nh
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebHYs-0005TJ-IE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:05:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebHYs-0005P0-89
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:05:18 -0500
Date: Tue, 16 Jan 2018 05:05:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116050246-mutt-send-email-mst@kernel.org>
References: <20180112145658.17121-1-maxime.coquelin@redhat.com>
	<20180112145658.17121-3-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112145658.17121-3-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] vhost-user: specify and implement
 VHOST_USER_SET_QUEUE_NUM request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, mlureau@redhat.com, zhengxiang9@huawei.com, lersek@redhat.com, pbonzini@redhat.com

On Fri, Jan 12, 2018 at 03:56:56PM +0100, Maxime Coquelin wrote:
> When the slave cannot add queues dynamically,


Could you please clarify the motivation a bit?
Why is it such a big deal to resize the queue array?
We know no queues are used before all of them are initialized,
so you don't need to worry about synchronizing with threads
processing the queues at the same time.

> it needs to know for
> how many queues to wait to be initialized.
> 
> This patch introduce new vhost-user protocol feature & request for
> the master to send the number of queue pairs allocated by the
> driver.

Assuming we can fix the previous message, I think specifying
the # of queues would be better.


> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  docs/interop/vhost-user.txt       | 16 ++++++++++++++++
>  hw/virtio/vhost-user.c            | 24 ++++++++++++++++++++++++
>  include/hw/virtio/vhost-backend.h |  3 +++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 8a14191a1e..85c0e03a95 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -218,6 +218,9 @@ The max number of queue pairs the slave supports can be queried with message
>  VHOST_USER_GET_QUEUE_NUM. Master should stop when the number of
>  requested queues is bigger than that.
>  
> +When VHOST_USER_PROTOCOL_F_SET_QUEUE_NUM is negotiated, the master must send
> +the number of queue pairs initialized with message VHOST_USER_SET_QUEUE_NUM.
> +
>  As all queues share one connection, the master uses a unique index for each
>  queue in the sent message to identify a specified queue. One queue pair
>  is enabled initially. More queues are enabled dynamically, by sending
> @@ -354,6 +357,7 @@ Protocol features
>  #define VHOST_USER_PROTOCOL_F_MTU            4
>  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
>  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
> +#define VHOST_USER_PROTOCOL_F_SET_QUEUE_NUM  7
>  
>  Master message types
>  --------------------
> @@ -623,6 +627,18 @@ Master message types
>        and expect this message once (per VQ) during device configuration
>        (ie. before the master starts the VQ).
>  
> + * VHOST_USER_SET_QUEUE_NUM
> +
> +      Id: 24
> +      Equivalent ioctl: N/A
> +      Master payload: u64
> +
> +      Set the number of queue pairs initialized.
> +      Master sends such request to notify the slave the number of queue pairs
> +      that have been initialized.
> +      This request should only be sent if VHOST_USER_PROTOCOL_F_SET_QUEUE_NUM
> +      feature has been successfully negotiated.
> +
>  Slave message types
>  -------------------
>  
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 093675ed98..9e7728d2da 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -34,6 +34,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_NET_MTU = 4,
>      VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
>      VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
> +    VHOST_USER_PROTOCOL_F_SET_QUEUE_NUM = 7,
>  
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> @@ -65,6 +66,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_SLAVE_REQ_FD = 21,
>      VHOST_USER_IOTLB_MSG = 22,
>      VHOST_USER_SET_VRING_ENDIAN = 23,
> +    VHOST_USER_SET_QUEUE_NUM = 24,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>  
> @@ -922,6 +924,27 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
>      /* No-op as the receive channel is not dedicated to IOTLB messages. */
>  }
>  
> +static int vhost_user_set_queue_num(struct vhost_dev *dev, uint64_t queues)
> +{
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_SET_QUEUE_NUM,
> +        .size = sizeof(msg.payload.u64),
> +        .flags = VHOST_USER_VERSION,
> +        .payload.u64 = queues,
> +    };
> +
> +    if (!(dev->protocol_features &
> +                (1ULL << VHOST_USER_PROTOCOL_F_SET_QUEUE_NUM))) {
> +        return 0;
> +    }
> +
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  const VhostOps user_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init = vhost_user_init,
> @@ -948,4 +971,5 @@ const VhostOps user_ops = {
>          .vhost_net_set_mtu = vhost_user_net_set_mtu,
>          .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
>          .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
> +        .vhost_set_queue_num = vhost_user_set_queue_num,
>  };
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
> index a7a5f22bc6..1dd3e4bbf3 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -84,6 +84,8 @@ typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
>                                             int enabled);
>  typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
>                                                struct vhost_iotlb_msg *imsg);
> +typedef int (*vhost_set_queue_num_op)(struct vhost_dev *dev,
> +                                      uint64_t queues);
>  
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
> @@ -118,6 +120,7 @@ typedef struct VhostOps {
>      vhost_vsock_set_running_op vhost_vsock_set_running;
>      vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
>      vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
> +    vhost_set_queue_num_op vhost_set_queue_num;
>  } VhostOps;
>  
>  extern const VhostOps user_ops;
> -- 
> 2.14.3
