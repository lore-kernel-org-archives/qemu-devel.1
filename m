Received: from eggs.gnu.org ([2001:4830:134:3::10]:38700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dFlZp-0003uB-3L
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dFlZk-0001Y2-4c
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:09:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dFlZj-0001Xj-SD
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:09:00 -0400
Date: Tue, 30 May 2017 21:08:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170530210457-mutt-send-email-mst@kernel.org>
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170526142858.19931-7-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170526142858.19931-7-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] spec/vhost-user spec: Add IOMMU
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com

On Fri, May 26, 2017 at 04:28:58PM +0200, Maxime Coquelin wrote:
> This patch specifies and implements the master/slave communication
> to support device IOTLB in slave.
> 
> The vhost_iotlb_msg structure introduced for kernel backends is
> re-used, making the design close between the two backends.
> 
> An exception is the use of the secondary channel to enable the
> slave to send IOTLB miss requests to the master.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
> 
> v2:
>  - spec: fixed possible permission field values
>  - spec: rewrote "IOMMU support" section
>  docs/specs/vhost-user.txt | 86 +++++++++++++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user.c    | 31 +++++++++++++++++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
> index 5fa7016..0799ef1 100644
> --- a/docs/specs/vhost-user.txt
> +++ b/docs/specs/vhost-user.txt
> @@ -97,6 +97,25 @@ Depending on the request type, payload can be:
>     log offset: offset from start of supplied file descriptor
>         where logging starts (i.e. where guest address 0 would be logged)
>  
> + * An IOTLB message
> +   ---------------------------------------------------------
> +   | iova | size | user address | permissions flags | type |
> +   ---------------------------------------------------------
> +
> +   IOVA: a 64-bit I/O virtual address programmed by the guest
> +   Size: a 64-bit size
> +   User address: a 64-bit user address
> +   Permissions: a 8-bit value:
> +    - 0: No access
> +    - 1: Read access
> +    - 2: Write access
> +    - 3: Read/Write access
> +   Type: a 8-bit IOTLB message type:
> +    - 1: IOTLB miss
> +    - 2: IOTLB update
> +    - 3: IOTLB invalidate
> +    - 4: IOTLB access fail
> +
>  In QEMU the vhost-user message is implemented with the following struct:
>  
>  typedef struct VhostUserMsg {
> @@ -109,6 +128,7 @@ typedef struct VhostUserMsg {
>          struct vhost_vring_addr addr;
>          VhostUserMemory memory;
>          VhostUserLog log;
> +        struct vhost_iotlb_msg iotlb;
>      };
>  } QEMU_PACKED VhostUserMsg;
>  
> @@ -253,6 +273,40 @@ Once the source has finished migration, rings will be stopped by
>  the source. No further update must be done before rings are
>  restarted.
>  
> +IOMMU support
> +-------------
> +
> +When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated, the master
> +sends IOTLB entries update & invalidation by sending VHOST_USER_IOTLB_MSG
> +requests to the slave with a struct vhost_iotlb_msg as payload. For update
> +events, the iotlb payload has to be filled with the update message type (2),
> +the I/O virtual address, the size, the user virtual address, and the
> +permissions flags. Addresses and size must be within vhost memory regions set
> +via the VHOST_USER_SET_MEM_TABLE request. For invalidation events, the iotlb
> +payload has to be filled with the invalidation message type (3), the I/O virtual
> +address and the size. On success, the slave is expected to reply with a zero
> +payload, non-zero otherwise.
> +
> +The slave relies on the slave communcation channel (see "Slave communication"
> +section below) to send IOTLB miss and access failure events, by sending
> +VHOST_USER_SLAVE_IOTLB_MSG requests to the master with a struct vhost_iotlb_msg
> +as payload. For miss events, the iotlb payload has to be filled with the miss
> +message type (1), the I/O virtual address and the permissions flags. For access
> +failure event, the iotlb payload has to be filled with the access failure
> +message type (4), the I/O virtual address and the permissions flags.
> +For synchronization purpose, the slave may rely on the reply-ack feature,
> +so the master may send a reply when operation is completed if the reply-ack
> +feature is negotiated and slaves requests a reply. For miss events, completed
> +operation means either master sent an update message containing the IOTLB entry
> +containing requested address and permission, or master sent nothing if the IOTLB
> +miss message is invalid (invalid IOVA or permission).
> +
> +The master isn't generally expected to take the initiative to send IOTLB update
> +messages, as the slave sends IOTLB miss messages for the guest virtual memory
> +areas it needs to access. The exception is the rings information addresses
> +shared with the VHOST_USER_SET_VRING_ADDR request, for which the master must
> +send corresponding IOTLB updates before the rings are enabled.
> +

Is the implication that invalidates do not affect ring translations
true? I find this problematic.

If not then can we replace above with "may send"?

>  Slave communication
>  -------------------
>  
> @@ -514,6 +568,38 @@ Master message types
>        If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, slave must respond
>        with zero for success, non-zero otherwise.
>  
> + * VHOST_USER_IOTLB_MSG
> +
> +      Id: 22
> +      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
> +      Master payload: struct vhost_iotlb_msg
> +      Slave payload: u64
> +
> +      Send IOTLB messages with struct vhost_iotlb_msg as payload.
> +      Master sends such requests to update and invalidate entries in the device
> +      IOTLB. The slave has to acknowledge the request with sending zero as u64
> +      payload for success, non-zero otherwise.
> +      This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
> +      has been successfully negotiated.
> +
> +Slave message types
> +-------------------
> +
> + * VHOST_USER_SLAVE_IOTLB_MSG
> +
> +      Id: 1
> +      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
> +      Slave payload: struct vhost_iotlb_msg
> +      Master payload: N/A
> +
> +      Send IOTLB messages with struct vhost_iotlb_msg as payload.
> +      Slave sends such requests to notify of an IOTLB miss, or an IOTLB
> +      access failure. If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated,
> +      and slave set the VHOST_USER_NEED_REPLY flag, master must respond with
> +      zero when operation is successfully completed, or non-zero otherwise.
> +      This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
> +      has been successfully negotiated.
> +
>  VHOST_USER_PROTOCOL_F_REPLY_ACK:
>  -------------------------------
>  The original vhost-user specification only demands replies for certain
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ea988fe..170fa68 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -62,11 +62,13 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SEND_RARP = 19,
>      VHOST_USER_NET_SET_MTU = 20,
>      VHOST_USER_SET_SLAVE_REQ_FD = 21,
> +    VHOST_USER_IOTLB_MSG = 22,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>  
>  typedef enum VhostUserSlaveRequest {
>      VHOST_USER_SLAVE_NONE = 0,
> +    VHOST_USER_SLAVE_IOTLB_MSG = 1,
>      VHOST_USER_SLAVE_MAX
>  }  VhostUserSlaveRequest;
>  
> @@ -104,6 +106,7 @@ typedef struct VhostUserMsg {
>          struct vhost_vring_addr addr;
>          VhostUserMemory memory;
>          VhostUserLog log;
> +        struct vhost_iotlb_msg iotlb;
>      } payload;
>  } QEMU_PACKED VhostUserMsg;
>  
> @@ -615,6 +618,9 @@ static void slave_read(void *opaque)
>      }
>  
>      switch (msg.request) {
> +    case VHOST_USER_SLAVE_IOTLB_MSG:
> +        ret = vhost_backend_handle_iotlb_msg(dev, &msg.payload.iotlb);
> +        break;
>      default:
>          error_report("Received unexpected msg type.");
>          ret = -EINVAL;
> @@ -862,6 +868,29 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
>      return 0;
>  }
>  
> +static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
> +                                            struct vhost_iotlb_msg *imsg)
> +{
> +    VhostUserMsg msg = {
> +        .request = VHOST_USER_IOTLB_MSG,
> +        .size = sizeof(msg.payload.iotlb),
> +        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> +        .payload.iotlb = *imsg,
> +    };
> +
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        return -EFAULT;
> +    }
> +
> +    return process_message_reply(dev, msg);
> +}
> +
> +
> +static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
> +{
> +    /* No-op as the receive channel is not dedicated to IOTLB messages. */
> +}
> +
>  const VhostOps user_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init = vhost_user_init,
> @@ -886,4 +915,6 @@ const VhostOps user_ops = {
>          .vhost_migration_done = vhost_user_migration_done,
>          .vhost_backend_can_merge = vhost_user_can_merge,
>          .vhost_net_set_mtu = vhost_user_net_set_mtu,
> +        .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
> +        .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
>  };
> -- 
> 2.9.4
