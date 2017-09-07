Received: from eggs.gnu.org ([2001:4830:134:3::10]:37809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpvx3-00046s-4a
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpvwv-0000kx-9x
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpvwv-0000kf-0X
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:30:25 -0400
Date: Thu, 7 Sep 2017 13:30:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907123007.GO2098@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-25-dgilbert@redhat.com>
	<CAJ+F1C+SGRe8v1_+UkyOBmAKdxki-DZj6qL4qXh2eCXMODUQOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+SGRe8v1_+UkyOBmAKdxki-DZj6qL4qXh2eCXMODUQOA@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, a.perevalov@samsung.com, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, aarcange@redhat.com, Felipe Franciosi <felipe@nutanix.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> "libvhost-user: madvises for postcopy" for ex, would be nicer imho

Done.

> On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Clear the area and turn off THP.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 32 +++++++++++++++++++++++++=
+++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost=
-user/libvhost-user.c
> > index 5ec54f7d60..d816851c6d 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -450,11 +450,39 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg =
*vmsg)
> >          }
> >
> >          if (dev->postcopy_listening) {
> > +            int ret;
> >              /* We should already have an open ufd need to mark each =
memory
> >               * range as ufd.
> > -             * Note: Do we need any madvises? Well it's not been acc=
essed
> > -             * yet, still probably need no THP to be safe, discard t=
o be safe?
> >               */
> > +
> > +            /* Discard any mapping we have here; note I can't use MA=
DV_REMOVE
> > +             * or fallocate to make the hole since I don't want to l=
ose
> > +             * data that's already arrived in the shared process.
> > +             * TODO: How to do hugepage
> > +             */
> > +            ret =3D madvise((void *)dev_region->mmap_addr,
> > +                          dev_region->size + dev_region->mmap_offset=
,
> > +                          MADV_DONTNEED);
> > +            if (ret) {
> > +                fprintf(stderr,
> > +                        "%s: Failed to madvise(DONTNEED) region %d: =
%s\n",
> > +                        __func__, i, strerror(errno));
> > +            }
> > +            /* Turn off transparent hugepages so we dont get lose wa=
keups
> > +             * in neighbouring pages.
> > +             * TODO: Turn this backon later.
> > +             */
> > +            ret =3D madvise((void *)dev_region->mmap_addr,
> > +                          dev_region->size + dev_region->mmap_offset=
,
> > +                          MADV_NOHUGEPAGE);
> > +            if (ret) {
> > +                /* Note: This can happen legally on kernels that are=
 configured
> > +                 * without madvise'able hugepages
> > +                 */
> > +                fprintf(stderr,
> > +                        "%s: Failed to madvise(NOHUGEPAGE) region %d=
: %s\n",
> > +                        __func__, i, strerror(errno));
> > +            }
> >              struct uffdio_register reg_struct;
> >              reg_struct.range.start =3D (uintptr_t)dev_region->mmap_a=
ddr;
> >              reg_struct.range.len =3D dev_region->size + dev_region->=
mmap_offset;
> > --
> > 2.13.5
> >
>=20
> Errors are non-fatal? patch looks ok to me, despite the TODOs :).

The DONTNEED is actually not critical in this case; since we've
only just mmap'd it there should be nothing mapped in there that
needs clearing with DONTNEED; however it's a good safe guard.
There's no equivalent syscall we can make for postcopy.

The madvise(NOHUGEPAGE) can fail on a kernel that's configured
without CONFIG_TRANSPARENT_HUGEPAGE_MADVISE if TRANSPARENT_HUGEPAGE=3Dn
then that's OK since it just means we don't have transparent hugepages
and thus we can't turn them off (I think we saw this on s390 or aarch64)

if CONFIG_TRANSAPRENT_HUGEPAGE_ALWAYS is set then things get
messy. IMHO there's way too many kernel config flags for transparent
hugepages!


> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>


Thanks,

Dave

>=20
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
