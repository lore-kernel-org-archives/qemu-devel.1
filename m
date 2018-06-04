Received: from eggs.gnu.org ([2001:4830:134:3::10]:34964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fPlT0-0004uY-9c
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fPlSx-0002l3-55
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:07:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35346 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fPlSw-0002j6-VO
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:07:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5EBA738E0
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 09:07:49 +0000 (UTC)
Date: Mon, 4 Jun 2018 10:07:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180604090746.GA2629@work-vm>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180601162749.27406-7-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 06/12] vhost-user: add
 vhost_user_input_get_config()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Ask vhost user input backend the list of virtio_input_config.

Why is this vhost-user specific; shouldn't the vhost-input
behaviour be the same irrespective of if it's vhost-user or plain vhost?

Dave


> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/vhost-backend.h |  4 +++
>  hw/virtio/vhost-user.c            | 59 +++++++++++++++++++++++++++++++
>  docs/interop/vhost-user.txt       |  6 ++++
>  3 files changed, 69 insertions(+)
>=20
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhos=
t-backend.h
> index 5dac61f9ea..6cc2edacc5 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -12,6 +12,7 @@
>  #define VHOST_BACKEND_H
> =20
>  #include "exec/memory.h"
> +#include "standard-headers/linux/virtio_input.h"
> =20
>  typedef enum VhostBackendType {
>      VHOST_BACKEND_TYPE_NONE =3D 0,
> @@ -156,4 +157,7 @@ int vhost_backend_invalidate_device_iotlb(struct vh=
ost_dev *dev,
>  int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
>                                            struct vhost_iotlb_msg *imsg=
);
> =20
> +int vhost_user_input_get_config(struct vhost_dev *dev,
> +                                struct virtio_input_config **config);
> +
>  #endif /* VHOST_BACKEND_H */
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index a87db01e55..19ed87d07c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -84,6 +84,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_POSTCOPY_ADVISE  =3D 28,
>      VHOST_USER_POSTCOPY_LISTEN  =3D 29,
>      VHOST_USER_POSTCOPY_END     =3D 30,
> +    VHOST_USER_INPUT_GET_CONFIG,
>      VHOST_USER_MAX
>  } VhostUserRequest;
> =20
> @@ -324,6 +325,64 @@ static int vhost_user_write(struct vhost_dev *dev,=
 VhostUserMsg *msg,
>      return 0;
>  }
> =20
> +static void *vhost_user_read_size(struct vhost_dev *dev, uint32_t size=
)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    CharBackend *chr =3D u->chr;
> +    int r;
> +    uint8_t *p =3D g_malloc(size);
> +
> +    r =3D qemu_chr_fe_read_all(chr, p, size);
> +    if (r !=3D size) {
> +        error_report("Failed to read msg payload."
> +                     " Read %d instead of %d.", r, size);
> +        return NULL;
> +    }
> +
> +    return p;
> +}
> +
> +int vhost_user_input_get_config(struct vhost_dev *dev,
> +                                struct virtio_input_config **config)
> +{
> +    void *p =3D NULL;
> +    VhostUserMsg msg =3D {
> +        .hdr.request =3D VHOST_USER_INPUT_GET_CONFIG,
> +        .hdr.flags =3D VHOST_USER_VERSION,
> +    };
> +
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        goto err;
> +    }
> +
> +    if (vhost_user_read_header(dev, &msg) < 0) {
> +        goto err;
> +    }
> +
> +    p =3D vhost_user_read_size(dev, msg.hdr.size);
> +    if (!p) {
> +        goto err;
> +    }
> +
> +    if (msg.hdr.request !=3D VHOST_USER_INPUT_GET_CONFIG) {
> +        error_report("Received unexpected msg type. Expected %d receiv=
ed %d",
> +                     VHOST_USER_INPUT_GET_CONFIG, msg.hdr.request);
> +        goto err;
> +    }
> +
> +    if (msg.hdr.size % sizeof(struct virtio_input_config)) {
> +        error_report("Invalid msg size");
> +        goto err;
> +    }
> +
> +    *config =3D p;
> +    return msg.hdr.size / sizeof(struct virtio_input_config);
> +
> +err:
> +    g_free(p);
> +    return -1;
> +}
> +
>  static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t bas=
e,
>                                     struct vhost_log *log)
>  {
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 534caab18a..3df9927386 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -744,6 +744,12 @@ Master message types
>        was previously sent.
>        The value returned is an error indication; 0 is success.
> =20
> + * VHOST_USER_INPUT_GET_CONFIG
> +
> +      Slave payload: (struct virtio_input_config)*
> +
> +      Ask vhost user input backend the list of virtio_input_config.
> +
>  Slave message types
>  -------------------
> =20
> --=20
> 2.17.1.906.g10fd178552
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
