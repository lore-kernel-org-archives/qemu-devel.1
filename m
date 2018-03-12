Received: from eggs.gnu.org ([2001:4830:134:3::10]:33914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQ6P-0008CB-HO
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQ6O-00037F-H2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:15:09 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evQ6N-00036i-T6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:15:08 -0400
Received: by mail-wr0-x244.google.com with SMTP id m4so3483303wrb.7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:15:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-24-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-24-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 17:15:05 +0100
Message-ID: <CAJ+F1CK3A3Z18ez8-9MzrD_+tsF=E+nq_3fUCEbm-TQE6xPRVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 23/29] libvhost-user: mprotect &
 madvises for postcopy
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

Hi

On Thu, Mar 8, 2018 at 8:58 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Clear the area and turn off THP.
> PROT_NONE the area until after we've userfault advised it
> to catch any unexpected changes.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 46 +++++++++++++++++++++++++++++=
++----
>  1 file changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index e02e5d6f46..1b224af706 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -454,7 +454,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserM=
sg *vmsg)
>      int i;
>      VhostUserMemory *memory =3D &vmsg->payload.memory;
>      dev->nregions =3D memory->nregions;
> -    /* TODO: Postcopy specific code */
> +
>      DPRINT("Nregions: %d\n", memory->nregions);
>      for (i =3D 0; i < dev->nregions; i++) {
>          void *mmap_addr;
> @@ -478,9 +478,12 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUser=
Msg *vmsg)
>
>          /* We don't use offset argument of mmap() since the
>           * mapped address has to be page aligned, and we use huge
> -         * pages.  */
> +         * pages.
> +         * In postcopy we're using PROT_NONE here to catch anyone
> +         * accessing it before we userfault
> +         */
>          mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
> -                         PROT_READ | PROT_WRITE, MAP_SHARED,
> +                         PROT_NONE, MAP_SHARED,
>                           vmsg->fds[i], 0);
>
>          if (mmap_addr =3D=3D MAP_FAILED) {
> @@ -519,12 +522,38 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUse=
rMsg *vmsg)
>      /* OK, now we can go and register the memory and generate faults */
>      for (i =3D 0; i < dev->nregions; i++) {
>          VuDevRegion *dev_region =3D &dev->regions[i];
> +        int ret;
>  #ifdef UFFDIO_REGISTER
>          /* We should already have an open ufd. Mark each memory
>           * range as ufd.
> -         * Note: Do we need any madvises? Well it's not been accessed
> -         * yet, still probably need no THP to be safe, discard to be saf=
e?
> +         * Discard any mapping we have here; note I can't use MADV_REMOV=
E
> +         * or fallocate to make the hole since I don't want to lose
> +         * data that's already arrived in the shared process.
> +         * TODO: How to do hugepage
>           */
> +        ret =3D madvise((void *)dev_region->mmap_addr,
> +                      dev_region->size + dev_region->mmap_offset,
> +                      MADV_DONTNEED);
> +        if (ret) {
> +            fprintf(stderr,
> +                    "%s: Failed to madvise(DONTNEED) region %d: %s\n",
> +                    __func__, i, strerror(errno));
> +        }
> +        /* Turn off transparent hugepages so we dont get lose wakeups
> +         * in neighbouring pages.
> +         * TODO: Turn this backon later.
> +         */
> +        ret =3D madvise((void *)dev_region->mmap_addr,
> +                      dev_region->size + dev_region->mmap_offset,
> +                      MADV_NOHUGEPAGE);
> +        if (ret) {
> +            /* Note: This can happen legally on kernels that are configu=
red
> +             * without madvise'able hugepages
> +             */
> +            fprintf(stderr,
> +                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
> +                    __func__, i, strerror(errno));
> +        }
>          struct uffdio_register reg_struct;
>          reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
>          reg_struct.range.len =3D dev_region->size + dev_region->mmap_off=
set;
> @@ -546,6 +575,13 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUser=
Msg *vmsg)
>          }
>          DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
>                  __func__, i, reg_struct.range.start, reg_struct.range.le=
n);
> +        /* Now it's registered we can let the client at it */
> +        if (mprotect((void *)dev_region->mmap_addr,
> +                     dev_region->size + dev_region->mmap_offset,
> +                     PROT_READ | PROT_WRITE)) {
> +            vu_panic(dev, "failed to mprotect region %d for postcopy", i=
);

You could also strerror(errno) here.

> +            return false;
> +        }
>          /* TODO: Stash 'zero' support flags somewhere */
>  #endif
>      }
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
