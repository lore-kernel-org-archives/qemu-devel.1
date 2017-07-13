Received: from eggs.gnu.org ([2001:4830:134:3::10]:59154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dVgZm-000419-8W
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dVgZj-00055O-4X
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:02:50 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dVgZi-00055A-QI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:02:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21so6121529lfk.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20170712094149.23069-1-jfreimann@redhat.com>
	<20170712094149.23069-4-jfreimann@redhat.com>
In-Reply-To: <20170712094149.23069-4-jfreimann@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Jul 2017 16:01:34 +0000
Message-ID: <CAJ+F1CL0pjOaxHNcCUXqjbLi=Hr2TYaEpMjYoGApdkoob4Q3eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] libvhost-user: quit when no more
 data received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: maxime.coquelin@redhat.com, victork@redhat.com, mst@redhat.com

Hi

On Wed, Jul 12, 2017 at 1:47 PM Jens Freimann <jfreimann@redhat.com> wrote:

> From: Jens Freimann <jfreiman@redhat.com>
>
> When recvmsg() returns a message size of zero and
> errno is ENOENT end processing of vhost-user messages.
>
> Without this we run into a vubr_panic() call and get
>      PANIC: Error while recvmsg: No such file or directory
>      Error while dispatching.
>
>
How do you get ENOENT on recvmsg()?

Add a switch "quit" to the vhost user device and set true to stop
> processing messages.
>
> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 12 +++++++++++-
>  contrib/libvhost-user/libvhost-user.h |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index 9efb9da..5538859 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -161,7 +161,10 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMs=
g
> *vmsg)
>          rc =3D recvmsg(conn_fd, &msg, 0);
>      } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
>
> -    if (rc <=3D 0) {
> +    if (rc =3D=3D 0 && (errno =3D=3D ENOENT)) {
> +        vmsg->size =3D 0;
> +        dev->quit =3D true;
> +    } else if (rc < 0) {
>          vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>          return false;
>      }
> @@ -755,6 +758,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>      DPRINT("Flags:   0x%x\n", vmsg->flags);
>      DPRINT("Size:    %d\n", vmsg->size);
>
> +    if (dev->quit) {
> +        return true;
> +    }
>

Make it false, as no reply is expected then


> +
>      if (vmsg->fd_num) {
>          int i;
>          DPRINT("Fds:");
> @@ -822,6 +829,9 @@ vu_dispatch(VuDev *dev)
>      bool success =3D false;
>
>      if (!vu_message_read(dev, dev->sock, &vmsg)) {
> +        if (vmsg.size =3D=3D 0) {
> +            success =3D true;
> +        }
>

There might be better ways to indicate a disconnection than modifying and
checking vmsg.size. Perhaps dev->quit alone is enough?

         goto end;
>      }
>
> diff --git a/contrib/libvhost-user/libvhost-user.h
> b/contrib/libvhost-user/libvhost-user.h
> index 53ef222..c02215a 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -217,6 +217,7 @@ struct VuDev {
>      uint64_t features;
>      uint64_t protocol_features;
>      bool broken;
> +    bool quit;
>

I also think you could re-use broken in this case.


>
>      /* @set_watch: add or update the given fd to the watch set,
>       * call cb when condition is met */
> --
> 2.9.4
>
>
> --
Marc-Andr=C3=A9 Lureau
