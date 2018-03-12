Received: from eggs.gnu.org ([2001:4830:134:3::10]:33144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evO5B-000546-Lh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evO55-00063B-FR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:05:45 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evO55-0005zT-5X
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:05:39 -0400
Received: by mail-wr0-x244.google.com with SMTP id h2so8523797wre.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 07:05:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-6-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-6-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 15:05:37 +0100
Message-ID: <CAJ+F1C+fxKoZncBqPvFxtRj_zqbLKoCpnULYZrGd2hc9t_0Qxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 05/29] postcopy: Add vhost-user flag for
 postcopy and check it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Mar 8, 2018 at 8:57 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add a vhost feature flag for postcopy support, and
> use the postcopy notifier to check it before allowing postcopy.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.h |  2 ++
>  docs/interop/vhost-user.txt           | 10 +++++++++
>  hw/virtio/vhost-user.c                | 41 +++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 18f95f65d7..96db29c4ce 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -48,6 +48,8 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_NET_MTU =3D 4,
>      VHOST_USER_PROTOCOL_F_SLAVE_REQ =3D 5,
>      VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
> +    VHOST_USER_PROTOCOL_F_CRYPTO_SESSION =3D 7,
> +    VHOST_USER_PROTOCOL_F_PAGEFAULT =3D 8,
>
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index cb3a7595aa..91a572d781 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -290,6 +290,15 @@ Once the source has finished migration, rings will b=
e stopped by
>  the source. No further update must be done before rings are
>  restarted.
>
> +In postcopy migration the slave is started before all the memory has bee=
n
> +received from the source host, and care must be taken to avoid accessing=
 pages
> +that have yet to be received.  The slave opens a 'userfault'-fd and regi=
sters
> +the memory with it; this fd is then passed back over to the master.
> +The master services requests on the userfaultfd for pages that are acces=
sed
> +and when the page is available it performs WAKE ioctl's on the userfault=
fd
> +to wake the stalled slave.  The client indicates support for this via th=
e
> +VHOST_USER_PROTOCOL_F_PAGEFAULT feature.
> +
>  Memory access
>  -------------
>
> @@ -369,6 +378,7 @@ Protocol features
>  #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
>  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
>  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
> +#define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
>
>  Master message types
>  --------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 41ff5cff41..aab35c4845 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -18,6 +18,8 @@
>  #include "qemu/error-report.h"
>  #include "qemu/sockets.h"
>  #include "sysemu/cryptodev.h"
> +#include "migration/migration.h"
> +#include "migration/postcopy-ram.h"
>
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
> @@ -41,7 +43,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_SLAVE_REQ =3D 5,
>      VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
>      VHOST_USER_PROTOCOL_F_CRYPTO_SESSION =3D 7,
> -
> +    VHOST_USER_PROTOCOL_F_PAGEFAULT =3D 8,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>
> @@ -164,8 +166,10 @@ static VhostUserMsg m __attribute__ ((unused));
>  #define VHOST_USER_VERSION    (0x1)
>
>  struct vhost_user {
> +    struct vhost_dev *dev;
>      CharBackend *chr;
>      int slave_fd;
> +    NotifierWithReturn postcopy_notifier;
>  };
>
>  static bool ioeventfd_enabled(void)
> @@ -791,6 +795,33 @@ out:
>      return ret;
>  }
>
> +static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
> +                                        void *opaque)
> +{
> +    struct PostcopyNotifyData *pnd =3D opaque;
> +    struct vhost_user *u =3D container_of(notifier, struct vhost_user,
> +                                         postcopy_notifier);
> +    struct vhost_dev *dev =3D u->dev;
> +
> +    switch (pnd->reason) {
> +    case POSTCOPY_NOTIFY_PROBE:
> +        if (!virtio_has_feature(dev->protocol_features,
> +                                VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
> +            /* TODO: Get the device name into this error somehow */
> +            error_setg(pnd->errp,
> +                       "vhost-user backend not capable of postcopy");
> +            return -ENOENT;
> +        }
> +        break;
> +
> +    default:
> +        /* We ignore notifications we don't know */
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_user_init(struct vhost_dev *dev, void *opaque)
>  {
>      uint64_t features, protocol_features;
> @@ -802,6 +833,7 @@ static int vhost_user_init(struct vhost_dev *dev, voi=
d *opaque)
>      u =3D g_new0(struct vhost_user, 1);
>      u->chr =3D opaque;
>      u->slave_fd =3D -1;
> +    u->dev =3D dev;
>      dev->opaque =3D u;
>
>      err =3D vhost_user_get_features(dev, &features);
> @@ -858,6 +890,9 @@ static int vhost_user_init(struct vhost_dev *dev, voi=
d *opaque)
>          return err;
>      }
>
> +    u->postcopy_notifier.notify =3D vhost_user_postcopy_notifier;
> +    postcopy_add_notifier(&u->postcopy_notifier);
> +
>      return 0;
>  }
>
> @@ -868,6 +903,10 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
>      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
>
>      u =3D dev->opaque;
> +    if (u->postcopy_notifier.notify) {
> +        postcopy_remove_notifier(&u->postcopy_notifier);
> +        u->postcopy_notifier.notify =3D NULL;
> +    }
>      if (u->slave_fd >=3D 0) {
>          qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
>          close(u->slave_fd);
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
