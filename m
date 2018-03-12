Received: from eggs.gnu.org ([2001:4830:134:3::10]:41658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evQX7-0000OZ-Iw
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evQX3-00074R-ED
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:42:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evQX3-000744-96
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:42:41 -0400
Date: Mon, 12 Mar 2018 16:42:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180312164230.GM3219@work-vm>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-20-dgilbert@redhat.com>
	<CAJ+F1CJr-HJ2CDCNkYSRvUZebyqJVX=KUMj0V1iXQ-==h6CeYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJr-HJ2CDCNkYSRvUZebyqJVX=KUMj0V1iXQ-==h6CeYQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/29] postcopy: wake shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Fri, Feb 16, 2018 at 2:16 PM, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Send a 'wake' request on a userfaultfd for a shared process.
> > The address in the clients address space is specified together
> > with the RAMBlock it was resolved to.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Thanks.

>=20
> > ---
> >  migration/postcopy-ram.c | 26 ++++++++++++++++++++++++++
> >  migration/postcopy-ram.h |  6 ++++++
> >  migration/trace-events   |  1 +
> >  3 files changed, 33 insertions(+)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 277ff749a0..67deae7e1c 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -534,6 +534,25 @@ static int ram_block_enable_notify(const char *b=
lock_name, void *host_addr,
> >      return 0;
> >  }
> >
> > +int postcopy_wake_shared(struct PostCopyFD *pcfd,
> > +                         uint64_t client_addr,
> > +                         RAMBlock *rb)
> > +{
> > +    size_t pagesize =3D qemu_ram_pagesize(rb);
> > +    struct uffdio_range range;
> > +    int ret;
> > +    trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
> > +    range.start =3D client_addr & ~(pagesize - 1);
> > +    range.len =3D pagesize;
> > +    ret =3D ioctl(pcfd->fd, UFFDIO_WAKE, &range);
> > +    if (ret) {
> > +        error_report("%s: Failed to wake: %zx in %s (%s)",
> > +                     __func__, (size_t)client_addr, qemu_ram_get_ids=
tr(rb),
> > +                     strerror(errno));
> > +    }
> > +    return ret;
> > +}
> > +
> >  /*
> >   * Callback from shared fault handlers to ask for a page,
> >   * the page must be specified by a RAMBlock and an offset in that rb
> > @@ -951,6 +970,13 @@ void *postcopy_get_tmp_page(MigrationIncomingSta=
te *mis)
> >      return NULL;
> >  }
> >
> > +int postcopy_wake_shared(struct PostCopyFD *pcfd,
> > +                         uint64_t client_addr,
> > +                         RAMBlock *rb)
> > +{
> > +    assert(0);
> > +    return -1;
> > +}
> >  #endif
> >
> >  /* -----------------------------------------------------------------=
-------- */
> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> > index 4c63f20df4..2e3dd844d5 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -162,6 +162,12 @@ struct PostCopyFD {
> >   */
> >  void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
> >  void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
> > +/* Notify a client ufd that a page is available
> > + * Note: The 'client_address' is in the address space of the client
> > + * program not QEMU
> > + */
>=20
> Any reason not to follow the classic function declaration / API
> documentation style:
> /**
>  * func:
>  * @arg: blah
>  *
>  * Lorem ipsum...
>  */
>=20
> (future documentation tooling will hopefully parse it etc)

I've added it; it's not something I generally do except for big external
interfaces.

Dave

>=20
> > +int postcopy_wake_shared(struct PostCopyFD *pcfd, uint64_t client_ad=
dr,
> > +                         RAMBlock *rb);
> >  /* Callback from shared fault handlers to ask for a page */
> >  int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *=
rb,
> >                                   uint64_t client_addr, uint64_t offs=
et);
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 7c910b5479..b0acaaa8a0 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -199,6 +199,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
> >  postcopy_ram_incoming_cleanup_exit(void) ""
> >  postcopy_ram_incoming_cleanup_join(void) ""
> >  postcopy_request_shared_page(const char *sharer, const char *rb, uin=
t64_t rb_offset) "for %s in %s offset 0x%"PRIx64
> > +postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"P=
RIx64" in %s"
> >
> >  save_xbzrle_page_skipping(void) ""
> >  save_xbzrle_page_overflow(void) ""
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
