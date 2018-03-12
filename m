Received: from eggs.gnu.org ([2001:4830:134:3::10]:60355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evNzw-0001ui-8T
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evNzp-0003p8-Ng
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:00:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evNzp-0003mL-GR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 10:00:13 -0400
Date: Mon, 12 Mar 2018 14:00:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312135959.GF3219@work-vm>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-13-dgilbert@redhat.com>
	<20180312095739.GC11787@xz-mi>
	<CAJ+F1CJf3cuxcaiL8DTCi3qaZyP5xDdAWb1-w2mfuTis5t5qHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJf3cuxcaiL8DTCi3qaZyP5xDdAWb1-w2mfuTis5t5qHw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 12/29] postcopy+vhost-user: Split
 set_mem_table for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Mon, Mar 12, 2018 at 10:57 AM, Peter Xu <peterx@redhat.com> wrote:
> > On Thu, Mar 08, 2018 at 07:57:54PM +0000, Dr. David Alan Gilbert (git=
) wrote:
> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>
> >> Split the set_mem_table routines in both qemu and libvhost-user
> >> because the postcopy versions are going to be quite different
> >> once changes in the later patches are added.
>=20
> You could add that this does not introduce functional change.

Done.

Dave

> >>
> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> ---
> >>  contrib/libvhost-user/libvhost-user.c | 53 ++++++++++++++++++++++++
> >>  hw/virtio/vhost-user.c                | 77 ++++++++++++++++++++++++=
++++++++++-
> >>  2 files changed, 128 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhos=
t-user/libvhost-user.c
> >> index beec7695a8..4922b2c722 100644
> >> --- a/contrib/libvhost-user/libvhost-user.c
> >> +++ b/contrib/libvhost-user/libvhost-user.c
> >> @@ -448,6 +448,55 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *=
vmsg)
> >>      return false;
> >>  }
> >>
> >> +static bool
> >> +vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
> >> +{
> >> +    int i;
> >> +    VhostUserMemory *memory =3D &vmsg->payload.memory;
> >> +    dev->nregions =3D memory->nregions;
> >> +    /* TODO: Postcopy specific code */
> >> +    DPRINT("Nregions: %d\n", memory->nregions);
> >> +    for (i =3D 0; i < dev->nregions; i++) {
> >> +        void *mmap_addr;
> >> +        VhostUserMemoryRegion *msg_region =3D &memory->regions[i];
> >> +        VuDevRegion *dev_region =3D &dev->regions[i];
> >> +
> >> +        DPRINT("Region %d\n", i);
> >> +        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
> >> +               msg_region->guest_phys_addr);
> >> +        DPRINT("    memory_size:     0x%016"PRIx64"\n",
> >> +               msg_region->memory_size);
> >> +        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
> >> +               msg_region->userspace_addr);
> >> +        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
> >> +               msg_region->mmap_offset);
> >> +
> >> +        dev_region->gpa =3D msg_region->guest_phys_addr;
> >> +        dev_region->size =3D msg_region->memory_size;
> >> +        dev_region->qva =3D msg_region->userspace_addr;
> >> +        dev_region->mmap_offset =3D msg_region->mmap_offset;
> >> +
> >> +        /* We don't use offset argument of mmap() since the
> >> +         * mapped address has to be page aligned, and we use huge
> >> +         * pages.  */
> >> +        mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_o=
ffset,
> >> +                         PROT_READ | PROT_WRITE, MAP_SHARED,
> >> +                         vmsg->fds[i], 0);
> >> +
> >> +        if (mmap_addr =3D=3D MAP_FAILED) {
> >> +            vu_panic(dev, "region mmap error: %s", strerror(errno))=
;
> >> +        } else {
> >> +            dev_region->mmap_addr =3D (uint64_t)(uintptr_t)mmap_add=
r;
> >> +            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
> >> +                   dev_region->mmap_addr);
> >> +        }
> >> +
> >> +        close(vmsg->fds[i]);
> >> +    }
> >> +
> >> +    return false;
> >> +}
> >> +
> >>  static bool
> >>  vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
> >>  {
> >> @@ -464,6 +513,10 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg =
*vmsg)
> >>      }
> >>      dev->nregions =3D memory->nregions;
> >>
> >> +    if (dev->postcopy_listening) {
> >> +        return vu_set_mem_table_exec_postcopy(dev, vmsg);
> >> +    }
> >> +
> >>      DPRINT("Nregions: %d\n", memory->nregions);
> >>      for (i =3D 0; i < dev->nregions; i++) {
> >>          void *mmap_addr;
> >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> index ee200f703e..311addc33b 100644
> >> --- a/hw/virtio/vhost-user.c
> >> +++ b/hw/virtio/vhost-user.c
> >> @@ -340,15 +340,86 @@ static int vhost_user_set_log_base(struct vhos=
t_dev *dev, uint64_t base,
> >>      return 0;
> >>  }
> >>
> >> +static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
> >> +                                             struct vhost_memory *m=
em)
> >> +{
> >> +    int fds[VHOST_MEMORY_MAX_NREGIONS];
> >> +    int i, fd;
> >> +    size_t fd_num =3D 0;
> >> +    bool reply_supported =3D virtio_has_feature(dev->protocol_featu=
res,
> >> +                                              VHOST_USER_PROTOCOL_F=
_REPLY_ACK);
> >> +    /* TODO: Add actual postcopy differences */
> >> +    VhostUserMsg msg =3D {
> >> +        .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
> >> +        .hdr.flags =3D VHOST_USER_VERSION,
> >> +    };
> >> +
> >> +    if (reply_supported) {
> >> +        msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> >> +    }
> >> +
> >> +    for (i =3D 0; i < dev->mem->nregions; ++i) {
> >> +        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> >> +        ram_addr_t offset;
> >> +        MemoryRegion *mr;
> >> +
> >> +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace=
_addr);
> >> +        mr =3D memory_region_from_host((void *)(uintptr_t)reg->user=
space_addr,
> >> +                                     &offset);
> >> +        fd =3D memory_region_get_fd(mr);
> >> +        if (fd > 0) {
> >> +            msg.payload.memory.regions[fd_num].userspace_addr =3D
> >> +                reg->userspace_addr;
> >> +            msg.payload.memory.regions[fd_num].memory_size  =3D reg=
->memory_size;
> >> +            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
> >> +                reg->guest_phys_addr;
> >> +            msg.payload.memory.regions[fd_num].mmap_offset =3D offs=
et;
> >> +            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> >> +            fds[fd_num++] =3D fd;
> >> +        }
> >> +    }
> >> +
> >> +    msg.payload.memory.nregions =3D fd_num;
> >> +
> >> +    if (!fd_num) {
> >> +        error_report("Failed initializing vhost-user memory map, "
> >> +                     "consider using -object memory-backend-file sh=
are=3Don");
> >> +        return -1;
> >> +    }
> >> +
> >> +    msg.hdr.size =3D sizeof(msg.payload.memory.nregions);
> >> +    msg.hdr.size +=3D sizeof(msg.payload.memory.padding);
> >> +    msg.hdr.size +=3D fd_num * sizeof(VhostUserMemoryRegion);
> >> +
> >> +    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> >> +        return -1;
> >> +    }
> >> +
> >> +    if (reply_supported) {
> >> +        return process_message_reply(dev, &msg);
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  static int vhost_user_set_mem_table(struct vhost_dev *dev,
> >>                                      struct vhost_memory *mem)
> >>  {
> >> +    struct vhost_user *u =3D dev->opaque;
> >>      int fds[VHOST_MEMORY_MAX_NREGIONS];
> >>      int i, fd;
> >>      size_t fd_num =3D 0;
> >> +    bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handl=
er;
> >>      bool reply_supported =3D virtio_has_feature(dev->protocol_featu=
res,
> >>                                                VHOST_USER_PROTOCOL_F=
_REPLY_ACK);
> >>
> >> +    if (do_postcopy) {
> >> +        /* Postcopy has enough differences that it's best done in i=
t's own
> >> +         * version
> >> +         */
> >> +        return vhost_user_set_mem_table_postcopy(dev, mem);
> >> +    }
> >> +
> >>      VhostUserMsg msg =3D {
> >>          .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
> >>          .hdr.flags =3D VHOST_USER_VERSION,
> >> @@ -372,9 +443,11 @@ static int vhost_user_set_mem_table(struct vhos=
t_dev *dev,
> >>                  error_report("Failed preparing vhost-user memory ta=
ble msg");
> >>                  return -1;
> >>              }
> >> -            msg.payload.memory.regions[fd_num].userspace_addr =3D r=
eg->userspace_addr;
> >> +            msg.payload.memory.regions[fd_num].userspace_addr =3D
> >> +                reg->userspace_addr;
> >>              msg.payload.memory.regions[fd_num].memory_size  =3D reg=
->memory_size;
> >> -            msg.payload.memory.regions[fd_num].guest_phys_addr =3D =
reg->guest_phys_addr;
> >> +            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
> >> +                reg->guest_phys_addr;
> >
> > I would still prefer to generalize things out as shared functions,
> > since otherwise we are adding somehow duplicate codes, which is IMHO
> > harder to maintain.  And even if to do the duplication, I would keep
> > the original code untouched (so these newlines will still not be
> > needed).
> >
> > But considering that the series has been there for a long time, I'll
> > try to be less harsh...  And yes, I know it's a burden to maintain
> > private trees and keep rebasing.
> >
> > Feel free to remove the newlines (so at least commit log of those
> > lines won't be modified), and either way I'll offer mine:
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
>=20
> I have the same feeling as Peter, but otherwise no objection - we can
> try to factorize again later if possible:
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks

Dave

>=20
> >
> > Thanks,
> >
> >>              msg.payload.memory.regions[fd_num].mmap_offset =3D offs=
et;
> >>              fds[fd_num++] =3D fd;
> >>          }
> >> --
> >> 2.14.3
> >>
> >
> > --
> > Peter Xu
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
