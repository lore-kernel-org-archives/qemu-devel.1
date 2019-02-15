Received: from eggs.gnu.org ([209.51.188.92]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gufPW-0001Gl-Ax
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gufPV-0007Ba-Gr
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:28:18 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gufPV-000732-9a
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 10:28:17 -0500
Received: by mail-wr1-x442.google.com with SMTP id c8so10754309wrs.4
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 07:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190208112357.31615-14-marcandre.lureau@redhat.com>
In-Reply-To: <20190208112357.31615-14-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Feb 2019 16:28:03 +0100
Message-ID: <CAJ+F1C+-WzELiV9-pFOi0i3pUx16YE1Egtzo_XxJ6xx-zFVS1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/13] RFC: add explicit can_migrate to
 vhost_user_backend_dev_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Michael,

On Fri, Feb 8, 2019 at 12:34 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> In general, there is not much support for migrating a vhost-user slave
> process. Many virtio devices however implement vmsd, and the
> vhost-user instances (as child objects) may be migrated.
>
> Since there is no other support at this point, the slave is assumed to
> be state less (outside of VM state), or using a migration method
> outside of qemu migration stream.
>
> Since this is not well specified, add a common blocker for the
> VhostUserBackend users (vhost-user-input and upcoming gpu will use
> it).
>
> RFC since I am not sure that's what Michael had in mind when
> requesting such blocker.

Could you look at that proposal?

thanks

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/vhost-user-backend.h | 2 +-
>  backends/vhost-user.c               | 7 ++++++-
>  hw/input/vhost-user-input.c         | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost-u=
ser-backend.h
> index 60f811cae7..feb331288f 100644
> --- a/include/sysemu/vhost-user-backend.h
> +++ b/include/sysemu/vhost-user-backend.h
> @@ -53,7 +53,7 @@ struct VhostUserBackend {
>  };
>
>  int vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
> -                                unsigned nvqs, Error **errp);
> +                                unsigned nvqs, bool can_migrate, Error *=
*errp);
>  void vhost_user_backend_start(VhostUserBackend *b);
>  void vhost_user_backend_stop(VhostUserBackend *b);
>
> diff --git a/backends/vhost-user.c b/backends/vhost-user.c
> index 289dbd9e6d..7fa52d2f47 100644
> --- a/backends/vhost-user.c
> +++ b/backends/vhost-user.c
> @@ -30,7 +30,7 @@ ioeventfd_enabled(void)
>
>  int
>  vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vdev,
> -                            unsigned nvqs, Error **errp)
> +                            unsigned nvqs, bool can_migrate, Error **err=
p)
>  {
>      int ret;
>
> @@ -49,6 +49,11 @@ vhost_user_backend_dev_init(VhostUserBackend *b, VirtI=
ODevice *vdev,
>      b->dev.nvqs =3D nvqs;
>      b->dev.vqs =3D g_new(struct vhost_virtqueue, nvqs);
>
> +    if (!can_migrate && !b->dev.migration_blocker) {
> +        error_setg(&b->dev.migration_blocker,
> +                   "Migration disabled: vhost-user device can't migrate"=
);
> +    }
> +
>      ret =3D vhost_dev_init(&b->dev, &b->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "vhost initialization failed");
> diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
> index 2ea1e50ab7..58b1684156 100644
> --- a/hw/input/vhost-user-input.c
> +++ b/hw/input/vhost-user-input.c
> @@ -24,7 +24,7 @@ static void vhost_input_realize(DeviceState *dev, Error=
 **errp)
>          return;
>      }
>
> -    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, errp) =3D=3D -1=
) {
> +    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, false, errp) =
=3D=3D -1) {
>          return;
>      }
>
> --
> 2.20.1.519.g8feddda32c
>
>


--=20
Marc-Andr=C3=A9 Lureau
