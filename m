Received: from eggs.gnu.org ([2001:4830:134:3::10]:49222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDSIo-0001Eo-Kr
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDSIn-0005C8-CJ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:09:58 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDSIn-0005Ac-0O
	for qemu-devel@nongnu.org; Wed, 24 May 2017 05:09:57 -0400
Received: by mail-lf0-x241.google.com with SMTP id h4so10336974lfj.3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 02:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20170524090520.321-1-maxime.coquelin@redhat.com>
In-Reply-To: <20170524090520.321-1-maxime.coquelin@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 May 2017 09:09:44 +0000
Message-ID: <CAJ+F1CKj0q1ez0o5g60Wyb0trxm2_xbxe1Tng68OUtJ+NXBS2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: pass message as a pointer
 to process_message_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, zhiyong.yang@intel.com, mst@redhat.com, qemu-devel@nongnu.org, jfreiman@redhat.com

Hi

On Wed, May 24, 2017 at 1:06 PM Maxime Coquelin <maxime.coquelin@redhat.com=
>
wrote:

> process_message_reply() was recently updated to get full message
> content instead of only its request field.
>
> There is no need to copy all the struct content into the stack,
> so just pass its pointer as const.
>
> Cc: Zhiyong Yang <zhiyong.yang@intel.com>
> Fixes: 60cd11024f41 ("hw/virtio: fix vhost user fails to startup when MQ"=
)
> Reviewed-by: Jens Freimann <jfreiman@redhat.com>
> Reviewed-by: Zhiyong Yang <zhiyong.yang@intel.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> V2:
>  - Make msg pointer const (Marc-Andre)
>  - Apply R-b's
>
>  hw/virtio/vhost-user.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b87a176..dde094a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -162,11 +162,11 @@ fail:
>  }
>
>  static int process_message_reply(struct vhost_dev *dev,
> -                                 VhostUserMsg msg)
> +                                 const VhostUserMsg *msg)
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
