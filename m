Received: from eggs.gnu.org ([2001:4830:134:3::10]:36805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0G8-0000xL-BT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0G2-0006W6-C9
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:30:08 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:36365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dn0G2-0006Vu-73
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:30:02 -0400
Received: by mail-vk0-x241.google.com with SMTP id d124so2268605vkf.3
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:30:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170824192730.8440-12-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-12-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Aug 2017 03:30:00 -0700
Message-ID: <CAJ+F1CLxV2JxRMUStYr7hrTjy7iKauHonPJrhDZf5_T4abjTnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 11/32] vhub: Open userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, a.perevalov@samsung.com, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, aarcange@redhat.com, Felipe Franciosi <felipe@nutanix.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

I would rather use libvhost-user: message prefix (same for similar
libvhost-user patches)

On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Open a userfaultfd (on a postcopy_advise) and send it back in
> the reply to the qemu for it to monitor.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++++++++++++---
>  contrib/libvhost-user/libvhost-user.h |  3 +++
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 47884c0a15..f9b5b12b28 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -15,6 +15,7 @@
>
>  #include <qemu/osdep.h>
>  #include <sys/eventfd.h>
> +#include <sys/syscall.h>
>  #include <linux/vhost.h>
>
>  #include "qemu/atomic.h"
> @@ -773,11 +774,30 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *=
vmsg)
>  static bool
>  vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
>  {
> -    /* TODO: Open ufd, pass it back in the request
> -     * TODO: Add addresses
> -     */
> +    struct uffdio_api api_struct;
> +
> +    dev->postcopy_ufd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLO=
CK);

This will likely fail to compile on !Linux, could you add some
appropriate #ifdef?

> +    /* TODO: Add addresses */
>      vmsg->payload.u64 =3D 0xcafe;
>      vmsg->size =3D sizeof(vmsg->payload.u64);
> +
> +    if (dev->postcopy_ufd =3D=3D -1) {
> +        vu_panic(dev, "Userfaultfd not available: %s", strerror(errno));
> +        goto out;
> +    }
> +    api_struct.api =3D UFFD_API;
> +    api_struct.features =3D 0;
> +    if (ioctl(dev->postcopy_ufd, UFFDIO_API, &api_struct)) {
> +        vu_panic(dev, "Failed UFFDIO_API: %s", strerror(errno));
> +        close(dev->postcopy_ufd);
> +        dev->postcopy_ufd =3D -1;
> +        goto out;
> +    }
> +    /* TODO: Stash feature flags somewhere */
> +out:
> +    /* Return a ufd to the QEMU */
> +    vmsg->fd_num =3D 1;
> +    vmsg->fds[0] =3D dev->postcopy_ufd;
>      return true; /* =3D send a reply */
>  }
>
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 3987ce643d..3e8efdd919 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -234,6 +234,9 @@ struct VuDev {
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
> 2.13.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
