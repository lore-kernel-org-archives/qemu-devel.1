Received: from eggs.gnu.org ([2001:4830:134:3::10]:34668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpuTd-0002Hi-N0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpuTZ-0001D4-Qz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpuTZ-0001Ck-IW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 06:56:01 -0400
Date: Thu, 7 Sep 2017 11:55:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170907105547.GH2098@work-vm>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-7-dgilbert@redhat.com>
	<CAJ+F1CLjgCR18+WmTrEB72pDyRMv5azL1en5K4HHdpfU5KRt-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLjgCR18+WmTrEB72pDyRMv5azL1en5K4HHdpfU5KRt-A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 06/32] postcopy: use UFFDIO_ZEROPAGE only
 when available
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
> On Thu, Aug 24, 2017 at 9:27 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Use a flag on the RAMBlock to state whether it has the
> > UFFDIO_ZEROPAGE capability, use it when it's available.
> >
> > This allows the use of postcopy on tmpfs as well as hugepage
> > backed files.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  exec.c                    | 15 +++++++++++++++
> >  include/exec/cpu-common.h |  3 +++
> >  migration/postcopy-ram.c  | 14 +++++++++++---
> >  3 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/exec.c b/exec.c
> > index 35b4cea2ed..80c3d1d121 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -103,6 +103,11 @@ static MemoryRegion io_mem_unassigned;
> >   */
> >  #define RAM_RESIZEABLE (1 << 2)
> >
> > +/* UFFDIO_ZEROPAGE is available on this RAMBlock to atomically
> > + * zero the page and wake waiting processes.
> > + * (Set during postcopy)
> > + */
> > +#define RAM_UF_ZEROPAGE (1 << 3)
> >  #endif
> >
> >  #ifdef TARGET_PAGE_BITS_VARY
> > @@ -1705,6 +1710,16 @@ bool qemu_ram_is_shared(RAMBlock *rb)
> >      return rb->flags & RAM_SHARED;
> >  }
> >
> > +bool qemu_ram_is_uf_zeroable(RAMBlock *rb)
> > +{
> > +    return rb->flags & RAM_UF_ZEROPAGE;
> > +}
> > +
> > +void qemu_ram_set_uf_zeroable(RAMBlock *rb)
> > +{
> > +    rb->flags |=3D RAM_UF_ZEROPAGE;
> > +}
> > +
> >  /* Called with iothread lock held.  */
> >  void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, Devic=
eState *dev)
> >  {
> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> > index 0d861a6289..24d335f95d 100644
> > --- a/include/exec/cpu-common.h
> > +++ b/include/exec/cpu-common.h
> > @@ -73,6 +73,9 @@ void qemu_ram_set_idstr(RAMBlock *block, const char=
 *name, DeviceState *dev);
> >  void qemu_ram_unset_idstr(RAMBlock *block);
> >  const char *qemu_ram_get_idstr(RAMBlock *rb);
> >  bool qemu_ram_is_shared(RAMBlock *rb);
> > +bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
> > +void qemu_ram_set_uf_zeroable(RAMBlock *rb);
> > +
> >  size_t qemu_ram_pagesize(RAMBlock *block);
> >  size_t qemu_ram_pagesize_largest(void);
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 7a414ebad8..640b72d86d 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -408,6 +408,11 @@ static int ram_block_enable_notify(const char *b=
lock_name, void *host_addr,
> >          error_report("%s userfault: Region doesn't support COPY", __=
func__);
> >          return -1;
> >      }
> > +    if (reg_struct.ioctls & ((__u64)1 << _UFFDIO_ZEROPAGE)) {
> > +        RAMBlock *rb =3D qemu_ram_block_by_name(block_name);
> > +        qemu_ram_set_uf_zeroable(rb);
> > +    }
> > +
> >
>=20
> extra empty line

Thanks, gone.

> >      return 0;
> >  }
> > @@ -617,11 +622,14 @@ int postcopy_place_page(MigrationIncomingState =
*mis, void *host, void *from,
> >  int postcopy_place_page_zero(MigrationIncomingState *mis, void *host=
,
> >                               RAMBlock *rb)
> >  {
> > +    size_t pagesize =3D qemu_ram_pagesize(rb);
> >      trace_postcopy_place_page_zero(host);
> >
> > -    if (qemu_ram_pagesize(rb) =3D=3D getpagesize()) {
>=20
> Is this check drop intentionally?

Yes, it used to be the case that we knew that for hugepages we couldn't
do zeroing and that was the rule we used.   Now we're using the
capability flag returned from the uffdio registration on this RAMBlock
and it tells us if we can use the ZERO ioctl on this block.

Dave

> > -        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, getpa=
gesize(),
> > -                                rb)) {
> > +    /* Normal RAMBlocks can zero a page using UFFDIO_ZEROPAGE
> > +     * but it's not available for everything (e.g. hugetlbpages)
> > +     */
> > +    if (qemu_ram_is_uf_zeroable(rb)) {
> > +        if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, pages=
ize, rb)) {
> >              int e =3D errno;
> >              error_report("%s: %s zero host: %p",
> >                           __func__, strerror(e), host);
> > --
> > 2.13.5
> >
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
