Received: from eggs.gnu.org ([2001:4830:134:3::10]:56490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evNlB-0006g9-RT
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evNlA-0004s2-PU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:05 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evNlA-0004qc-Iy
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:04 -0400
Received: by mail-wr0-x241.google.com with SMTP id r66so8143396wrb.6
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:45:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-9-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-9-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 14:45:02 +0100
Message-ID: <CAJ+F1C+tu7YO9NAsTc1VVOzR1MA6jtHDbB6uMJw_oR5unkFV2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 08/29] libvhost-user: Open userfaultfd
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
> Open a userfaultfd (on a postcopy_advise) and send it back in
> the reply to the qemu for it to monitor.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 45 +++++++++++++++++++++++++++++=
++----
>  contrib/libvhost-user/libvhost-user.h |  3 +++
>  2 files changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index eb0ab9338c..0b563fc5ae 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -26,9 +26,20 @@
>  #include <sys/socket.h>
>  #include <sys/eventfd.h>
>  #include <sys/mman.h>
> +#include "qemu/compiler.h"
> +
> +#if defined(__linux__)
> +#include <sys/syscall.h>
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
>  #include <linux/vhost.h>
>
> -#include "qemu/compiler.h"
> +#ifdef __NR_userfaultfd
> +#include <linux/userfaultfd.h>
> +#endif
> +
> +#endif
> +
>  #include "qemu/atomic.h"
>
>  #include "libvhost-user.h"
> @@ -888,11 +899,37 @@ vu_set_config(VuDev *dev, VhostUserMsg *vmsg)
>  static bool
>  vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
>  {
> -    /* TODO: Open ufd, pass it back in the request
> -     * TODO: Add addresses
> -     */
> +    dev->postcopy_ufd =3D -1;
> +#ifdef UFFDIO_API
> +    struct uffdio_api api_struct;
> +
> +    dev->postcopy_ufd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLO=
CK);
> +    /* TODO: Add addresses */
>      vmsg->payload.u64 =3D 0xcafe;
>      vmsg->size =3D sizeof(vmsg->payload.u64);
> +#endif
> +
> +    if (dev->postcopy_ufd =3D=3D -1) {
> +        vu_panic(dev, "Userfaultfd not available: %s", strerror(errno));
> +        goto out;
> +    }
> +
> +#ifdef UFFDIO_API
> +    api_struct.api =3D UFFD_API;
> +    api_struct.features =3D 0;
> +    if (ioctl(dev->postcopy_ufd, UFFDIO_API, &api_struct)) {
> +        vu_panic(dev, "Failed UFFDIO_API: %s", strerror(errno));
> +        close(dev->postcopy_ufd);
> +        dev->postcopy_ufd =3D -1;
> +        goto out;
> +    }
> +    /* TODO: Stash feature flags somewhere */
> +#endif
> +
> +out:
> +    /* Return a ufd to the QEMU */
> +    vmsg->fd_num =3D 1;
> +    vmsg->fds[0] =3D dev->postcopy_ufd;
>      return true; /* =3D send a reply */
>  }
>
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 00d78a8810..074b7860f6 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -282,6 +282,9 @@ struct VuDev {
>       * re-initialize */
>      vu_panic_cb panic;
>      const VuDevIface *iface;
> +
> +    /* Postcopy data */
> +    int postcopy_ufd;
>  };
>
>  typedef struct VuVirtqElement {
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
