Received: from eggs.gnu.org ([2001:4830:134:3::10]:37537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctxmH-00007p-Qa
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctxmD-00040o-I6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctxmD-0003zR-9Y
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:43:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17C38C1C5E00
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 14:43:44 +0000 (UTC)
Date: Fri, 31 Mar 2017 15:43:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331144338.GK4514@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-2-quintela@redhat.com>
	<20170324095517.GC17755@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324095517.GC17755@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 01/51] ram: Update all functions comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Peter Xu (peterx@redhat.com) wrote:
> Hi, Juan,
> 
> Got several nitpicks below... (along with some questions)
> 
> On Thu, Mar 23, 2017 at 09:44:54PM +0100, Juan Quintela wrote:
> 
> [...]

> > @@ -1157,11 +1186,12 @@ static bool get_queued_page(MigrationState *ms, PageSearchStatus *pss,
> >  }
> >  
> >  /**
> > - * flush_page_queue: Flush any remaining pages in the ram request queue
> > - *    it should be empty at the end anyway, but in error cases there may be
> > - *    some left.
> > + * flush_page_queue: flush any remaining pages in the ram request queue
> 
> Here the comment says (just like mentioned in function name) that we
> will "flush any remaining pages in the ram request queue", however in
> the implementation, we should be only freeing everything in
> src_page_requests. The problem is "flush" let me think about "flushing
> the rest of the pages to the other side"... while it's not.
> 
> Would it be nice we just rename the function into something else, like
> migration_page_queue_free()? We can tune the comments correspondingly
> as well.

Yes that probably would be a better name.

> [...]
> 
> > -/*
> > - * Helper for postcopy_chunk_hostpages; it's called twice to cleanup
> > - *   the two bitmaps, that are similar, but one is inverted.
> > +/**
> > + * postcopy_chuck_hostpages_pass: canocalize bitmap in hostpages
>                   ^ should be n?     ^^^^^^^^^^ canonicalize?
> 
> >   *
> > - * We search for runs of target-pages that don't start or end on a
> > - * host page boundary;
> > - * unsent_pass=true: Cleans up partially unsent host pages by searching
> > - *                 the unsentmap
> > - * unsent_pass=false: Cleans up partially dirty host pages by searching
> > - *                 the main migration bitmap
> > + * Helper for postcopy_chunk_hostpages; it's called twice to
> > + * canonicalize the two bitmaps, that are similar, but one is
> > + * inverted.
> >   *
> > + * Postcopy requires that all target pages in a hostpage are dirty or
> > + * clean, not a mix.  This function canonicalizes the bitmaps.
> > + *
> > + * @ms: current migration state
> > + * @unsent_pass: if true we need to canonicalize partially unsent host pages
> > + *               otherwise we need to canonicalize partially dirty host pages
> > + * @block: block that contains the page we want to canonicalize
> > + * @pds: state for postcopy
> >   */
> >  static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
> >                                            RAMBlock *block,
> 
> [...]
> 
> > +/**
> > + * ram_save_setup: iterative stage for migration
>       ^^^^^^^^^^^^^^ should be ram_save_iterate()?
> 
> > + *
> > + * Returns zero to indicate success and negative for error
> > + *
> > + * @f: QEMUFile where to send the data
> > + * @opaque: RAMState pointer
> > + */
> >  static int ram_save_iterate(QEMUFile *f, void *opaque)
> >  {
> >      int ret;
> > @@ -2091,7 +2169,16 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> >      return done;
> >  }
> 
> [...]
> 
> > -/*
> > - * Allocate data structures etc needed by incoming migration with postcopy-ram
> > - * postcopy-ram's similarly names postcopy_ram_incoming_init does the work
> > +/**
> > + * ram_postococpy_incoming_init: allocate postcopy data structures
> > + *
> > + * Returns 0 for success and negative if there was one error
> > + *
> > + * @mis: current migration incoming state
> > + *
> > + * Allocate data structures etc needed by incoming migration with
> > + * postcopy-ram postcopy-ram's similarly names
> > + * postcopy_ram_incoming_init does the work
> 
> This sentence is slightly hard to understand... But I think the
> function name explained itself enough though. :)

A '.' after the first 'postcopy-ram' would make it more readable.

Dave

> Thanks,
> 
> -- peterx
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
