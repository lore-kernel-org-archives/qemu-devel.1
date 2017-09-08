Received: from eggs.gnu.org ([2001:4830:134:3::10]:60915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqKce-0004KJ-VJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqKcZ-0007Lq-Vk
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:51:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dqKcZ-0007JL-MX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:51:03 -0400
Date: Fri, 8 Sep 2017 15:50:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170908145037.GB2836@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-16-dgilbert@redhat.com>
	<CAJ+F1CKEhTQ8JSNV9OHLDchn+wn3k1240grV3uw9nis0K6GWUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKEhTQ8JSNV9OHLDchn+wn3k1240grV3uw9nis0K6GWUg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 15/32] vhost+postcopy: Register new
 regions with the ufd
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
> Use "libvhost-user: " commit title tag/prefix?
>=20
> On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > When new regions are sent to the client using SET_MEM_TABLE, register
> > them with the userfaultfd.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 32 +++++++++++++++++++++++++=
+++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost=
-user/libvhost-user.c
> > index e8accf11db..e6ab059a03 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -449,6 +449,38 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *=
vmsg)
> >                     dev_region->mmap_addr);
> >          }
> >
> > +        if (dev->postcopy_listening) {
> > +            /* We should already have an open ufd need to mark each =
memory
> > +             * range as ufd.
> > +             * Note: Do we need any madvises? Well it's not been acc=
essed
> > +             * yet, still probably need no THP to be safe, discard t=
o be safe?
> > +             */
> > +            struct uffdio_register reg_struct;
> > +            reg_struct.range.start =3D (uintptr_t)dev_region->mmap_a=
ddr;
> > +            reg_struct.range.len =3D dev_region->size + dev_region->=
mmap_offset;
> > +            reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> > +
> > +            if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struc=
t)) {
> > +                vu_panic(dev, "%s: Failed to userfault region %d "
> > +                              "@%p + %zx: (ufd=3D%d)%s\n",
> > +                         __func__, i,
> > +                         dev_region->mmap_addr,
> > +                         dev_region->size + dev_region->mmap_offset,
> > +                         dev->postcopy_ufd, strerror(errno));
> > +                continue;
>=20
> panic is supposed to be unrecoverable errors, so I would suggest to ret=
urn here

Done.

> > +            }
> > +            if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
> > +                vu_panic(dev, "%s Region (%d) doesn't support COPY",
> > +                         __func__, i);
> > +                continue;
> > +            }
> > +            DPRINT("%s: region %d: Registered userfault for %llx + %=
llx\n",
> > +                    __func__, i, reg_struct.range.start, reg_struct.=
range.len);
> > +            /* TODO: Stash 'zero' support flags somewhere */
> > +            /* TODO: Get address back to QEMU */
> > +
> > +        }
> > +
> >          close(vmsg->fds[i]);
> >      }
>=20
> This patch would be nicer if it compiles on !Linux / without userfault.

Done; I've just ifdef UFFDIO_REGISTER the inside of this if;
I'll add other code that makes sure it doesn't get as far as setting
postcopy_listening either.

Dave

> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
