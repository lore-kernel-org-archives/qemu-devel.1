Received: from eggs.gnu.org ([2001:4830:134:3::10]:41322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDRqx-0001X9-8f
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDRqw-0000OU-7W
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:41:11 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDRqv-0000OK-Qe
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:41:10 -0400
Received: by mail-lf0-x242.google.com with SMTP id q24so10255503lfb.1
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 01:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20170524083446.32261-1-maxime.coquelin@redhat.com>
In-Reply-To: <20170524083446.32261-1-maxime.coquelin@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 May 2017 08:40:57 +0000
Message-ID: <CAJ+F1C+t_RqLfHCuEm0c32VapbZ33FrV_-FQhxtuamj5i6up6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: pass message as a pointer to
 process_message_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, zhiyong.yang@intel.com, mst@redhat.com, qemu-devel@nongnu.org, jfreiman@redhat.com

On Wed, May 24, 2017 at 11:35 AM Maxime Coquelin <maxime.coquelin@redhat.co=
m>
wrote:

> process_message_reply() was recently updated to get full message
> content instead of only its request field.
>
> There is no need to copy all the struct content into the stack,
> so just pass its pointer.
>
> Cc: Zhiyong Yang <zhiyong.yang@intel.com>
> Fixes: 60cd11024f41 ("hw/virtio: fix vhost user fails to startup when MQ"=
)
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b87a176..baf2487 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -162,11 +162,11 @@ fail:
>  }
>
>  static int process_message_reply(struct vhost_dev *dev,
> -                                 VhostUserMsg msg)
> +                                 VhostUserMsg *msg)
>

Can you make it const?


>  {
>      VhostUserMsg msg_reply;
>
> -    if ((msg.flags & VHOST_USER_NEED_REPLY_MASK) =3D=3D 0) {
> +    if ((msg->flags & VHOST_USER_NEED_REPLY_MASK) =3D=3D 0) {
>          return 0;
>      }
>
> @@ -174,10 +174,10 @@ static int process_message_reply(struct vhost_dev
> *dev,
>          return -1;
>      }
>
> -    if (msg_reply.request !=3D msg.request) {
> +    if (msg_reply.request !=3D msg->request) {
>          error_report("Received unexpected msg type."
>                       "Expected %d received %d",
> -                     msg.request, msg_reply.request);
> +                     msg->request, msg_reply.request);
>          return -1;
>      }
>
> @@ -324,7 +324,7 @@ static int vhost_user_set_mem_table(struct vhost_dev
> *dev,
>      }
>
>      if (reply_supported) {
> -        return process_message_reply(dev, msg);
> +        return process_message_reply(dev, &msg);
>      }
>
>      return 0;
> @@ -716,7 +716,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev
> *dev, uint16_t mtu)
>
>      /* If reply_ack supported, slave has to ack specified MTU is valid *=
/
>      if (reply_supported) {
> -        return process_message_reply(dev, msg);
> +        return process_message_reply(dev, &msg);
>      }
>
>      return 0;
> --
> 2.9.4
>
>
> --
Marc-Andr=C3=A9 Lureau
