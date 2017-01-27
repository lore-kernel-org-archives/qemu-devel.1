Received: from eggs.gnu.org ([2001:4830:134:3::10]:34997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cX8mf-0003Mt-16
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cX8ma-0002bA-6T
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:49:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cX8mZ-0002av-U2
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:49:48 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA56B7FE9C
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 15:49:47 +0000 (UTC)
Date: Fri, 27 Jan 2017 15:49:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170127154942.GG3323@work-vm>
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-8-dgilbert@redhat.com>
	<87efzr77xy.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efzr77xy.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH 07/15] postcopy: Plumb pagesize down into
 place helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Now we deal with normal size pages and huge pages we need
> > to tell the place handlers the size we're dealing with
> > and make sure the temporary page is large enough.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> I understand the what you are trying here, but ....
> 
> Why do we always map/upmap with the bigger pagesize?  I would assume
> that this deppends on the block we are dealing with, no?

It's only a temporary, so it seems easier to map it once at the start
of the migration at the size we need and clean it up at the end, that
way we don't have to allocate/deallocate on each block.

> > @@ -321,7 +321,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
> >      migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
> >  
> >      if (mis->postcopy_tmp_page) {
> > -        munmap(mis->postcopy_tmp_page, getpagesize());
> > +        munmap(mis->postcopy_tmp_page, mis->largest_page_size);
> >          mis->postcopy_tmp_page = NULL;
> >      }
> >      trace_postcopy_ram_incoming_cleanup_exit();
> 
> Here
> 
> >  void *postcopy_get_tmp_page(MigrationIncomingState *mis)
> >  {
> >      if (!mis->postcopy_tmp_page) {
> > -        mis->postcopy_tmp_page = mmap(NULL, getpagesize(),
> > +        mis->postcopy_tmp_page = mmap(NULL, mis->largest_page_size,
> >                               PROT_READ | PROT_WRITE, MAP_PRIVATE |
> >                               MAP_ANONYMOUS, -1, 0);
> >          if (mis->postcopy_tmp_page == MAP_FAILED) {
> 
> And here ...
> 
> >              if (all_zero) {
> >                  ret = postcopy_place_page_zero(mis,
> >                                                 host + TARGET_PAGE_SIZE -
> > -                                               qemu_host_page_size);
> > +                                               block->page_size,
> > +                                               block->page_size);
> >              } else {
> >                  ret = postcopy_place_page(mis, host + TARGET_PAGE_SIZE -
> > -                                               qemu_host_page_size,
> > -                                               place_source);
> > +                                               block->page_size,
> > +                                               place_source, block->page_size);
> >              }
> >          }
> >          if (!ret) {
> 
> creating a temp for
> 
> addr = host + TARGET_PAGE_SIZE - block->page_size;
> 
> would make things more readable IMHO.  I was missreading the - by a ,
> and didn't understand so many parameters O:-)

Done.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
