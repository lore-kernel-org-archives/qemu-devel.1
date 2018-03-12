Received: from eggs.gnu.org ([2001:4830:134:3::10]:40849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evOcY-0000Tl-4g
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evOcS-0007Mm-7J
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:40:14 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evOcR-0007LK-VU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:40:08 -0400
Received: by mail-wm0-x243.google.com with SMTP id i3so16560297wmi.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 07:40:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-15-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-15-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 15:40:06 +0100
Message-ID: <CAJ+F1C+MwCfErrO5c8B4+37UvAxCPd_SbX_fHsfFNZ0Z_O6jFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 14/29] libvhost-user+postcopy: Register
 new regions with the ufd
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
> When new regions are sent to the client using SET_MEM_TABLE, register
> them with the userfaultfd.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 34 +++++++++++++++++++++++++++++=
+++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 4922b2c722..a18bc74a7c 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -494,6 +494,40 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUser=
Msg *vmsg)
>          close(vmsg->fds[i]);
>      }
>
> +    /* TODO: Get address back to QEMU */
> +    for (i =3D 0; i < dev->nregions; i++) {
> +        VuDevRegion *dev_region =3D &dev->regions[i];
> +#ifdef UFFDIO_REGISTER
> +        /* We should already have an open ufd. Mark each memory
> +         * range as ufd.
> +         * Note: Do we need any madvises? Well it's not been accessed
> +         * yet, still probably need no THP to be safe, discard to be saf=
e?
> +         */
> +        struct uffdio_register reg_struct;
> +        reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
> +        reg_struct.range.len =3D dev_region->size + dev_region->mmap_off=
set;
> +        reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> +
> +        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
> +            vu_panic(dev, "%s: Failed to userfault region %d "
> +                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
> +                     __func__, i,
> +                     dev_region->mmap_addr,
> +                     dev_region->size, dev_region->mmap_offset,
> +                     dev->postcopy_ufd, strerror(errno));
> +            return false;
> +        }
> +        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
> +            vu_panic(dev, "%s Region (%d) doesn't support COPY",
> +                     __func__, i);
> +            return false;
> +        }
> +        DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
> +                __func__, i, reg_struct.range.start, reg_struct.range.le=
n);
> +        /* TODO: Stash 'zero' support flags somewhere */
> +#endif
> +    }
> +
>      return false;
>  }
>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
