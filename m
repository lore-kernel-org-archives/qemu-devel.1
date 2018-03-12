Received: from eggs.gnu.org ([2001:4830:134:3::10]:48062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evQr6-0005Zi-BD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evQr3-0004R3-Sj
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:03:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evQr3-0004Ql-MM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:03:21 -0400
Date: Mon, 12 Mar 2018 17:03:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312170310.GQ3219@work-vm>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-19-dgilbert@redhat.com>
	<CAJ+F1C+UkQSYLoGzrvoUpMz+sJ5N-265hHBhjP8OE42a+9MpQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+UkQSYLoGzrvoUpMz+sJ5N-265hHBhjP8OE42a+9MpQg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 18/29] vhost+postcopy: Resolve client
 address
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
> > Resolve fault addresses read off the clients UFD into RAMBlock
> > and offset, and call back to the postcopy code to ask for the page.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks,

>=20
> > ---
> >  hw/virtio/trace-events |  3 +++
> >  hw/virtio/vhost-user.c | 31 ++++++++++++++++++++++++++++++-
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index d7e9e1084b..3afd12cfea 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -7,6 +7,9 @@ vhost_region_add_section_abut(const char *name, uint6=
4_t new_size) "%s: 0x%"PRIx
> >  vhost_section(const char *name, int r) "%s:%d"
> >
> >  # hw/virtio/vhost-user.c
> > +vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_a=
ddress, int nregions) "%s: @0x%"PRIx64" nregions:%d"
> > +vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, =
uint64_t size) "%d: client 0x%"PRIx64" +0x%"PRIx64
> > +vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offse=
t, uint64_t rb_offset) "%d: region_offset: 0x%"PRIx64" rb_offset:0x%"PRIx=
64
> >  vhost_user_postcopy_listen(void) ""
> >  vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhv=
a, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" re=
ply %d region %d"
> >  vhost_user_set_mem_table_withfd(int index, const char *name, uint64_=
t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_=
t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx=
64" RB offset:0x%"PRIx64
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index fd65616961..e19b9ef9cf 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -26,6 +26,7 @@
> >  #include <sys/socket.h>
> >  #include <sys/un.h>
> >  #include <linux/vhost.h>
> > +#include <linux/userfaultfd.h>
> >
> >  #define VHOST_MEMORY_MAX_NREGIONS    8
> >  #define VHOST_USER_F_PROTOCOL_FEATURES 30
> > @@ -974,7 +975,35 @@ out:
> >  static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd=
,
> >                                               void *ufd)
> >  {
> > -    return 0;
> > +    struct vhost_dev *dev =3D pcfd->data;
> > +    struct vhost_user *u =3D dev->opaque;
> > +    struct uffd_msg *msg =3D ufd;
> > +    uint64_t faultaddr =3D msg->arg.pagefault.address;
> > +    RAMBlock *rb =3D NULL;
> > +    uint64_t rb_offset;
> > +    int i;
> > +
> > +    trace_vhost_user_postcopy_fault_handler(pcfd->idstr, faultaddr,
> > +                                            dev->mem->nregions);
> > +    for (i =3D 0; i < MIN(dev->mem->nregions, u->region_rb_len); i++=
) {
> > +        trace_vhost_user_postcopy_fault_handler_loop(i,
> > +                u->postcopy_client_bases[i], dev->mem->regions[i].me=
mory_size);
> > +        if (faultaddr >=3D u->postcopy_client_bases[i]) {
> > +            /* Ofset of the fault address in the vhost region */
> > +            uint64_t region_offset =3D faultaddr - u->postcopy_clien=
t_bases[i];
> > +            if (region_offset < dev->mem->regions[i].memory_size) {
> > +                rb_offset =3D region_offset + u->region_rb_offset[i]=
;
>=20
> It may be worth to add an assert (i < u->region_rb_len) ?

The loop limit guarantees that anyway with the 2nd term of the
MIN.

Dave

>=20
> > +                trace_vhost_user_postcopy_fault_handler_found(i,
> > +                        region_offset, rb_offset);
> > +                rb =3D u->region_rb[i];
> > +                return postcopy_request_shared_page(pcfd, rb, faulta=
ddr,
> > +                                                    rb_offset);
> > +            }
> > +        }
> > +    }
> > +    error_report("%s: Failed to find region for fault %" PRIx64,
> > +                 __func__, faultaddr);
> > +    return -1;
> >  }
> >
> >  /*
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
