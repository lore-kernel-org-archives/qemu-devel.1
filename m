Received: from eggs.gnu.org ([2001:4830:134:3::10]:45398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evQkI-0007Tt-Ah
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evQkF-00075V-0n
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:56:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evQkE-000754-QU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:56:18 -0400
Date: Mon, 12 Mar 2018 16:56:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312165614.GO3219@work-vm>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-24-dgilbert@redhat.com>
	<CAJ+F1CK3A3Z18ez8-9MzrD_+tsF=E+nq_3fUCEbm-TQE6xPRVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK3A3Z18ez8-9MzrD_+tsF=E+nq_3fUCEbm-TQE6xPRVg@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Mar 8, 2018 at 8:58 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Clear the area and turn off THP.
> > PROT_NONE the area until after we've userfault advised it
> > to catch any unexpected changes.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
>=20
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 46 +++++++++++++++++++++++++=
++++++----
> >  1 file changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost=
-user/libvhost-user.c
> > index e02e5d6f46..1b224af706 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -454,7 +454,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostU=
serMsg *vmsg)
> >      int i;
> >      VhostUserMemory *memory =3D &vmsg->payload.memory;
> >      dev->nregions =3D memory->nregions;
> > -    /* TODO: Postcopy specific code */
> > +
> >      DPRINT("Nregions: %d\n", memory->nregions);
> >      for (i =3D 0; i < dev->nregions; i++) {
> >          void *mmap_addr;
> > @@ -478,9 +478,12 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, Vhost=
UserMsg *vmsg)
> >
> >          /* We don't use offset argument of mmap() since the
> >           * mapped address has to be page aligned, and we use huge
> > -         * pages.  */
> > +         * pages.
> > +         * In postcopy we're using PROT_NONE here to catch anyone
> > +         * accessing it before we userfault
> > +         */
> >          mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_of=
fset,
> > -                         PROT_READ | PROT_WRITE, MAP_SHARED,
> > +                         PROT_NONE, MAP_SHARED,
> >                           vmsg->fds[i], 0);
> >
> >          if (mmap_addr =3D=3D MAP_FAILED) {
> > @@ -519,12 +522,38 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, Vhos=
tUserMsg *vmsg)
> >      /* OK, now we can go and register the memory and generate faults=
 */
> >      for (i =3D 0; i < dev->nregions; i++) {
> >          VuDevRegion *dev_region =3D &dev->regions[i];
> > +        int ret;
> >  #ifdef UFFDIO_REGISTER
> >          /* We should already have an open ufd. Mark each memory
> >           * range as ufd.
> > -         * Note: Do we need any madvises? Well it's not been accesse=
d
> > -         * yet, still probably need no THP to be safe, discard to be=
 safe?
> > +         * Discard any mapping we have here; note I can't use MADV_R=
EMOVE
> > +         * or fallocate to make the hole since I don't want to lose
> > +         * data that's already arrived in the shared process.
> > +         * TODO: How to do hugepage
> >           */
> > +        ret =3D madvise((void *)dev_region->mmap_addr,
> > +                      dev_region->size + dev_region->mmap_offset,
> > +                      MADV_DONTNEED);
> > +        if (ret) {
> > +            fprintf(stderr,
> > +                    "%s: Failed to madvise(DONTNEED) region %d: %s\n=
",
> > +                    __func__, i, strerror(errno));
> > +        }
> > +        /* Turn off transparent hugepages so we dont get lose wakeup=
s
> > +         * in neighbouring pages.
> > +         * TODO: Turn this backon later.
> > +         */
> > +        ret =3D madvise((void *)dev_region->mmap_addr,
> > +                      dev_region->size + dev_region->mmap_offset,
> > +                      MADV_NOHUGEPAGE);
> > +        if (ret) {
> > +            /* Note: This can happen legally on kernels that are con=
figured
> > +             * without madvise'able hugepages
> > +             */
> > +            fprintf(stderr,
> > +                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s=
\n",
> > +                    __func__, i, strerror(errno));
> > +        }
> >          struct uffdio_register reg_struct;
> >          reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
> >          reg_struct.range.len =3D dev_region->size + dev_region->mmap=
_offset;
> > @@ -546,6 +575,13 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, Vhost=
UserMsg *vmsg)
> >          }
> >          DPRINT("%s: region %d: Registered userfault for %llx + %llx\=
n",
> >                  __func__, i, reg_struct.range.start, reg_struct.rang=
e.len);
> > +        /* Now it's registered we can let the client at it */
> > +        if (mprotect((void *)dev_region->mmap_addr,
> > +                     dev_region->size + dev_region->mmap_offset,
> > +                     PROT_READ | PROT_WRITE)) {
> > +            vu_panic(dev, "failed to mprotect region %d for postcopy=
", i);
>=20
> You could also strerror(errno) here.

Done

> > +            return false;
> > +        }
> >          /* TODO: Stash 'zero' support flags somewhere */
> >  #endif
> >      }
> > --
> > 2.14.3
> >
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
