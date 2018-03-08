Received: from eggs.gnu.org ([2001:4830:134:3::10]:46313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etowi-0006On-OG
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 01:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etowd-0001SI-Q7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 01:22:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etowd-0001Rn-KC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 01:22:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40AEF406E8A4
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 06:22:16 +0000 (UTC)
Date: Thu, 8 Mar 2018 14:22:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180308062200.GC32252@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-23-dgilbert@redhat.com>
	<20180302080524.GO27381@xz-mi> <20180306103652.GC3096@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306103652.GC3096@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 22/29] vhost+postcopy: Call wakeups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Tue, Mar 06, 2018 at 10:36:52AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Fri, Feb 16, 2018 at 01:16:18PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Cause the vhost-user client to be woken up whenever:
> > >   a) We place a page in postcopy mode
> > >   b) We get a fault and the page has already been received
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  migration/postcopy-ram.c | 14 ++++++++++----
> > >  migration/trace-events   |  1 +
> > >  2 files changed, 11 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > index 879711968c..13561703b5 100644
> > > --- a/migration/postcopy-ram.c
> > > +++ b/migration/postcopy-ram.c
> > > @@ -566,7 +566,11 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> > >  
> > >      trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(rb),
> > >                                         rb_offset);
> > > -    /* TODO: Check bitmap to see if we already have the page */
> > > +    if (ramblock_recv_bitmap_test_byte_offset(rb, aligned_rbo)) {
> > > +        trace_postcopy_request_shared_page_present(pcfd->idstr,
> > > +                                        qemu_ram_get_idstr(rb), rb_offset);
> > > +        return postcopy_wake_shared(pcfd, client_addr, rb);
> > > +    }
> > >      if (rb != mis->last_rb) {
> > >          mis->last_rb = rb;
> > >          migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
> > > @@ -863,7 +867,8 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
> > >      }
> > >  
> > >      trace_postcopy_place_page(host);
> > > -    return 0;
> > > +    return postcopy_notify_shared_wake(rb,
> > > +                                       qemu_ram_block_host_offset(rb, host));
> > >  }
> > >  
> > >  /*
> > > @@ -887,6 +892,9 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
> > >  
> > >              return -e;
> > >          }
> > > +        return postcopy_notify_shared_wake(rb,
> > > +                                           qemu_ram_block_host_offset(rb,
> > > +                                                                      host));
> > >      } else {
> > >          /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
> > >          if (!mis->postcopy_tmp_zero_page) {
> > > @@ -906,8 +914,6 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
> > >          return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
> > >                                     rb);
> > >      }
> > > -
> > > -    return 0;
> > >  }
> > 
> > Could there be race?  E.g.:
> > 
> >               ram_load_thread             page_fault_thread
> >              -----------------           -------------------
> > 
> >                                           if (recv_bitmap_set())
> >                                               wake()
> >              copy_page()
> >              recv_bitmap_set()
> >              wake()
> >                                           request_page()
> > 
> > Then the last requested page may never be serviced?
> 
> The postcopy finishes when the last page is received, and thus when that
> also performs the wake() (from the load thread); so that's not a
> problem.
> You can get the case where a page that qemu has already received, still
> needs to be woken for the shared users (which is why we have the wake in
> the fault_thread).
> When the postcopy finishes, the client is sent a POSTCOPY_END, at which
> point it closes it's userfaultfd and it should wake everything remaining
> up; so any late requests shouldn't be a problem (the END is sent
> before the fault-thread quits).

Yeah now I think the race is invalid - the wake() in ram_load_thread
will wake up the paused thread in this case.  I misunderstood.

Thanks,

-- 
Peter Xu
