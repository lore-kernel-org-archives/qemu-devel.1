Received: from eggs.gnu.org ([2001:4830:134:3::10]:37348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dYVek-0000Af-D0
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dYVej-0000yo-DT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:59:38 -0400
Received: from mail-lf0-x230.google.com ([2a00:1450:4010:c07::230]:34483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dYVej-0000x9-0X
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:59:37 -0400
Received: by mail-lf0-x230.google.com with SMTP id g25so18175075lfh.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 03:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20170721095553.10717-1-jfreimann@redhat.com>
	<20170721095553.10717-4-jfreimann@redhat.com>
In-Reply-To: <20170721095553.10717-4-jfreimann@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 21 Jul 2017 10:59:23 +0000
Message-ID: <CAJ+F1CJsCQWVeaGNwVz5ZNjv0b=mGR=ttOJQn9w5K3mUu4VLeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] libvhost-user: quit when no more data
 received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: maxime.coquelin@redhat.com, victork@redhat.com, stefanha@redhat.com, mst@redhat.com

On Fri, Jul 21, 2017 at 11:58 AM Jens Freimann <jfreimann@redhat.com> wrote=
:

> From: Jens Freimann <jfreiman@redhat.com>
>
> End processing of messages when VHOST_USER_NO_MESSAGE
> is received.
>
>
What is VHOST_USER_NO_MESSAGE?


> Without this we run into a vubr_panic() call and get
> "PANIC: Unhandled request: 0"
>
> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
>

---
>  contrib/libvhost-user/libvhost-user.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index 9efb9da..85523ca 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -161,7 +161,7 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg
> *vmsg)
>          rc =3D recvmsg(conn_fd, &msg, 0);
>      } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
>
> -    if (rc <=3D 0) {
> +    if (rc < 0) {
>

that's looks fine


>          vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>          return false;
>      }
> @@ -806,6 +806,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_get_queue_num_exec(dev, vmsg);
>      case VHOST_USER_SET_VRING_ENABLE:
>          return vu_set_vring_enable_exec(dev, vmsg);
> +    case VHOST_USER_NONE:
> +        return true;
>

return true means 'reply_requested', is that what you want so
vu_message_write() is called? If so, please explain in commit message.


>      default:
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> --
> 2.9.4
>
>
> --
Marc-Andr=C3=A9 Lureau
