Received: from eggs.gnu.org ([2001:4830:134:3::10]:52321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ7Uf-0005Jz-29
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dQ7Ub-0006ZM-3D
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:34:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dQ7Ua-0006ZC-Qp
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:34:29 -0400
Date: Wed, 28 Jun 2017 15:34:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170628073421.GJ14652@pxdev.xzpeter.org>
References: <1498557027-18143-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170627095333eucas1p28a2d86104f8df64c05758cd08f1a48df@eucas1p2.samsung.com>
	<1498557027-18143-4-git-send-email-a.perevalov@samsung.com>
	<20170627101740.GB14652@pxdev.xzpeter.org>
	<20170627104057.GB4827@aperevalov-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170627104057.GB4827@aperevalov-ubuntu>
Subject: Re: [Qemu-devel] [PATCH v5 3/3] migration: add bitmap for received
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey <a.perevalov@samsung.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

On Tue, Jun 27, 2017 at 01:40:58PM +0300, Alexey wrote:
> On Tue, Jun 27, 2017 at 06:17:40PM +0800, Peter Xu wrote:
> > On Tue, Jun 27, 2017 at 05:50:27AM -0400, Alexey Perevalov wrote:
> > 
> > [...]
> > 
> > > @@ -60,6 +62,14 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
> > >      return (char *)block->host + offset;
> > >  }
> > >  
> > > +static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
> > > +                                                            RAMBlock *rb)
> > > +{
> > > +    uint64_t host_addr_offset =
> > > +            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
> > > +    return host_addr_offset >> TARGET_PAGE_BITS;
> > > +}
> > > +
> > >  long qemu_getrampagesize(void);
> > >  unsigned long last_ram_page(void);
> > >  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 71e38bc..53fbd41 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -143,6 +143,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
> > >          qemu_mutex_init(&mis_current.rp_mutex);
> > >          qemu_event_init(&mis_current.main_thread_load_event, false);
> > >          once = true;
> > > +        ramblock_recv_map_init();
> > 
> > One tiny more comment: shall we init this at the beginning of incoming
> > migration? Maybe into migration_fd_process_incoming(), before entering
> > the coroutine?
> maybe this function (migration_incoming_get_current) is not best place
> to initialize something in ramblock list from point of
> view maintainability.

Yes, the point is, it is only inited once per QEMU instance, while
actually it should be inited for each incoming migration procedure
(though I think yes we will normally have one incoming migration per
QEMU instance...).

> > 
> > Then, for the destruction of it below...
> > 
> > [...]
> > 
> > > @@ -2324,8 +2352,14 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
> > >  
> > >  static int ram_load_cleanup(void *opaque)
> > >  {
> > > +    RAMBlock *rb;
> > >      xbzrle_load_cleanup();
> > >      compress_threads_load_cleanup();
> > > +
> > > +    RAMBLOCK_FOREACH(rb) {
> > > +        g_free(rb->receivedmap);
> > > +        rb->receivedmap = NULL;
> > > +    }
> > 
> > ... maybe move to migration_incoming_state_destroy()?
> I'll think about it, because ram_load_cleanup in current Juan's
> patch set is not calling in postcopy scenario.

Sure.

> 
> > 
> > And, I didn't really find ram_load_cleanup() in my repo. Am I missing
> > something?
> you need Juan's [PATCH v2 0/5] Create setup/cleanup methods for
> migration incoming side

Ok. Then no problem. Thanks,

> 
> > 
> > Other than above, this patch looks good to me.  Thanks,
> > 
> > -- 
> > Peter Xu
> > 
> 
> -- 
> 
> BR
> Alexey

-- 
Peter Xu
