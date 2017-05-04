Received: from eggs.gnu.org ([2001:4830:134:3::10]:55011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6O1g-0006OE-2L
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6O1e-0005VJ-J4
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:11:04 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d6O1e-0005Ut-6C
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:11:02 -0400
Received: by mail-lf0-x243.google.com with SMTP id t144so2411721lff.2
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 14:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <1493363372-16861-1-git-send-email-zhiyong.yang@intel.com>
	<1493915136-19150-1-git-send-email-zhiyong.yang@intel.com>
In-Reply-To: <1493915136-19150-1-git-send-email-zhiyong.yang@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 04 May 2017 21:10:50 +0000
Message-ID: <CAJ+F1CLhsf78nWpo=XFstSw00cCCCEL3ifJ2mof-qTdRHKJ6MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/virtio: fix vhost user fails to
 startup when MQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhiyong Yang <zhiyong.yang@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, maxime.coquelin@redhat.com

On Thu, May 4, 2017 at 8:30 PM Zhiyong Yang <zhiyong.yang@intel.com> wrote:

>  Qemu2.7~2.9 and vhost user for dpdk 17.02 release work together
> to cause failures of new connection when negotiating to set MQ.
> (one queue pair works well).
>    Because there exist some bugs in qemu code when introducing
> VHOST_USER_PROTOCOL_F_REPLY_ACK to qemu. When vhost_user_set_mem_table
> is invoked to deal with the vhost message VHOST_USER_SET_MEM_TABLE
> for the second time, qemu indeed doesn't send the messge (The message
> needs to be sent only once)but still will be waiting for dpdk's reply
> ack, then, qemu is always freezing, while DPDK is always waiting for
> next vhost message from qemu.
>   The patch aims to fix the bug, MQ can work well.
>   The same bug is found in function vhost_user_net_set_mtu, it is fixed
> at the same time.
>   DPDK related patch is as following:
>   http://www.dpdk.org/dev/patchwork/patch/23955/
>
> Signed-off-by: Zhiyong Yang <zhiyong.yang@intel.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


---
>
> Changes in V2:
> Thanks for Maxime's suggestion, if one-time request, clear the
> VHOST_USER_NEED_REPLY flag in function vhost_user_write,
> in process_message_reply(), return early, if this flag isn't set.
>
>  hw/virtio/vhost-user.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 9334a8a..32a95a8 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -163,22 +163,26 @@ fail:
>  }
>
>  static int process_message_reply(struct vhost_dev *dev,
> -                                 VhostUserRequest request)
> +                                 VhostUserMsg msg)
>  {
> -    VhostUserMsg msg;
> +    VhostUserMsg msg_reply;
>
> -    if (vhost_user_read(dev, &msg) < 0) {
> +    if ((msg.flags & VHOST_USER_NEED_REPLY_MASK) =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    if (vhost_user_read(dev, &msg_reply) < 0) {
>          return -1;
>      }
>
> -    if (msg.request !=3D request) {
> +    if (msg_reply.request !=3D msg.request) {
>          error_report("Received unexpected msg type."
>                       "Expected %d received %d",
> -                     request, msg.request);
> +                     msg.request, msg_reply.request);
>          return -1;
>      }
>
> -    return msg.payload.u64 ? -1 : 0;
> +    return msg_reply.payload.u64 ? -1 : 0;
>  }
>
>  static bool vhost_user_one_time_request(VhostUserRequest request)
> @@ -208,6 +212,7 @@ static int vhost_user_write(struct vhost_dev *dev,
> VhostUserMsg *msg,
>       * request, we just ignore it.
>       */
>      if (vhost_user_one_time_request(msg->request) && dev->vq_index !=3D =
0) {
> +        msg->flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
>          return 0;
>      }
>
> @@ -320,7 +325,7 @@ static int vhost_user_set_mem_table(struct vhost_dev
> *dev,
>      }
>
>      if (reply_supported) {
> -        return process_message_reply(dev, msg.request);
> +        return process_message_reply(dev, msg);
>      }
>
>      return 0;
> @@ -712,7 +717,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev
> *dev, uint16_t mtu)
>
>      /* If reply_ack supported, slave has to ack specified MTU is valid *=
/
>      if (reply_supported) {
> -        return process_message_reply(dev, msg.request);
> +        return process_message_reply(dev, msg);
>      }
>
>      return 0;
> --
> 2.7.4
>
> --
Marc-Andr=C3=A9 Lureau
