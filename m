Received: from eggs.gnu.org ([2001:4830:134:3::10]:42655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0a8-0000p2-QJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0a8-0007FF-2K
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:50:48 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:33247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dn0a7-0007F6-UB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:50:47 -0400
Received: by mail-vk0-x242.google.com with SMTP id j189so2274158vka.0
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:50:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170824192730.8440-30-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-30-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Aug 2017 03:50:46 -0700
Message-ID: <CAJ+F1CKYhmHJu9y+ZnCVAuYSdP2Zgm+eABvkZ5kDFrTgCgStww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 29/32] vhost-user: Claim support for
 postcopy
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

Hi

Use "libvhost-user: ", so we don't confuse with qemu own vhost-user code.

On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Tell QEMU we understand the protocol features needed for postcopy.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 33 +++++++++++++++++++++++++++++=
++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 23bff47649..290748733b 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -144,6 +144,35 @@ vmsg_close_fds(VhostUserMsg *vmsg)
>      }
>  }
>
> +/* A test to see if we have userfault available */
> +static bool
> +have_userfault(void)
> +{
> +#if defined(__linux__) && defined(__NR_userfaultfd) &&\
> +        defined(UFFD_FEATURE_MISSING_SHMEM) &&\
> +        defined(UFFD_FEATURE_MISSING_HUGETLBFS)
> +    /* Now test the kernel we're running on really has the features */
> +    int ufd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> +    struct uffdio_api api_struct;
> +    if (ufd < 0) {
> +        return false;
> +    }
> +
> +    api_struct.api =3D UFFD_API;
> +    api_struct.features =3D UFFD_FEATURE_MISSING_SHMEM |
> +                          UFFD_FEATURE_MISSING_HUGETLBFS;
> +    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> +        close(ufd);
> +        return false;
> +    }
> +    close(ufd);
> +    return true;
> +
> +#else
> +    return false;
> +#endif
> +}
> +
>  static bool
>  vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>  {
> @@ -796,6 +825,10 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserM=
sg *vmsg)
>  {
>      uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
>
> +    if (have_userfault()) {
> +        features |=3D 1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT;
> +    }
> +
>      if (dev->iface->get_protocol_features) {
>          features |=3D dev->iface->get_protocol_features(dev);
>      }
> --
> 2.13.5
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




--=20
Marc-Andr=C3=A9 Lureau
