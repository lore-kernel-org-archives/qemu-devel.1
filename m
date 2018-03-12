Received: from eggs.gnu.org ([2001:4830:134:3::10]:57255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evNmn-00085f-CF
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evNml-0007fe-5d
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:46:45 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evNmk-0007e9-Tl
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:46:43 -0400
Received: by mail-wr0-x242.google.com with SMTP id v65so15737110wrc.11
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:46:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-11-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-11-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 14:46:41 +0100
Message-ID: <CAJ+F1C+Q8=S5Rgb43Q-zzSsenL03rxiW0DV=Sb8jdQ68eokRaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/29] vhost+postcopy: Register shared
 ufd with postcopy
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
> Register the UFD that comes in as the response to the 'advise' method
> with the postcopy code.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/virtio/vhost-user.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 431858b219..9f74111e92 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -171,6 +171,7 @@ struct vhost_user {
>      CharBackend *chr;
>      int slave_fd;
>      NotifierWithReturn postcopy_notifier;
> +    struct PostCopyFD  postcopy_fd;
>  };
>
>  static bool ioeventfd_enabled(void)
> @@ -796,6 +797,17 @@ out:
>      return ret;
>  }
>
> +/*
> + * Called back from the postcopy fault thread when a fault is received o=
n our
> + * ufd.
> + * TODO: This is Linux specific
> + */
> +static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
> +                                             void *ufd)
> +{
> +    return 0;
> +}
> +
>  /*
>   * Called at the start of an inbound postcopy on reception of the
>   * 'advise' command.
> @@ -835,8 +847,14 @@ static int vhost_user_postcopy_advise(struct vhost_d=
ev *dev, Error **errp)
>          error_setg(errp, "%s: Failed to get ufd", __func__);
>          return -1;
>      }
> +    fcntl(ufd, F_SETFL, O_NONBLOCK);
>
> -    /* TODO: register ufd with userfault thread */
> +    /* register ufd with userfault thread */
> +    u->postcopy_fd.fd =3D ufd;
> +    u->postcopy_fd.data =3D dev;
> +    u->postcopy_fd.handler =3D vhost_user_postcopy_fault_handler;
> +    u->postcopy_fd.idstr =3D "vhost-user"; /* Need to find unique name *=
/
> +    postcopy_register_shared_ufd(&u->postcopy_fd);
>      return 0;
>  }
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
