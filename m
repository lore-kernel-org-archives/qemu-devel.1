Received: from eggs.gnu.org ([2001:4830:134:3::10]:41402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0YG-00085T-Ry
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0YF-000660-Oo
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:48:52 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:38399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dn0YF-00065s-JY
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:48:51 -0400
Received: by mail-ua0-x241.google.com with SMTP id j46so2443351uag.5
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:48:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170824192730.8440-25-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-25-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Aug 2017 03:48:50 -0700
Message-ID: <CAJ+F1C+SGRe8v1_+UkyOBmAKdxki-DZj6qL4qXh2eCXMODUQOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 24/32] vub+postcopy: madvises
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

"libvhost-user: madvises for postcopy" for ex, would be nicer imho

On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Clear the area and turn off THP.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 32 +++++++++++++++++++++++++++++=
+--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 5ec54f7d60..d816851c6d 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -450,11 +450,39 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vms=
g)
>          }
>
>          if (dev->postcopy_listening) {
> +            int ret;
>              /* We should already have an open ufd need to mark each memo=
ry
>               * range as ufd.
> -             * Note: Do we need any madvises? Well it's not been accesse=
d
> -             * yet, still probably need no THP to be safe, discard to be=
 safe?
>               */
> +
> +            /* Discard any mapping we have here; note I can't use MADV_R=
EMOVE
> +             * or fallocate to make the hole since I don't want to lose
> +             * data that's already arrived in the shared process.
> +             * TODO: How to do hugepage
> +             */
> +            ret =3D madvise((void *)dev_region->mmap_addr,
> +                          dev_region->size + dev_region->mmap_offset,
> +                          MADV_DONTNEED);
> +            if (ret) {
> +                fprintf(stderr,
> +                        "%s: Failed to madvise(DONTNEED) region %d: %s\n=
",
> +                        __func__, i, strerror(errno));
> +            }
> +            /* Turn off transparent hugepages so we dont get lose wakeup=
s
> +             * in neighbouring pages.
> +             * TODO: Turn this backon later.
> +             */
> +            ret =3D madvise((void *)dev_region->mmap_addr,
> +                          dev_region->size + dev_region->mmap_offset,
> +                          MADV_NOHUGEPAGE);
> +            if (ret) {
> +                /* Note: This can happen legally on kernels that are con=
figured
> +                 * without madvise'able hugepages
> +                 */
> +                fprintf(stderr,
> +                        "%s: Failed to madvise(NOHUGEPAGE) region %d: %s=
\n",
> +                        __func__, i, strerror(errno));
> +            }
>              struct uffdio_register reg_struct;
>              reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
>              reg_struct.range.len =3D dev_region->size + dev_region->mmap=
_offset;
> --
> 2.13.5
>

Errors are non-fatal? patch looks ok to me, despite the TODOs :).
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>





--=20
Marc-Andr=C3=A9 Lureau
