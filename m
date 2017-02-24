Received: from eggs.gnu.org ([2001:4830:134:3::10]:40997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chIKO-0000gR-DJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chIKI-0002Da-FY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:02:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chIKI-0002DL-3v
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:02:34 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1DD081235
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 16:02:33 +0000 (UTC)
Date: Fri, 24 Feb 2017 16:02:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170224160228.GK8830@work-vm>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206173306.20603-7-dgilbert@redhat.com>
	<2b67acaa-7a65-3198-c51a-d23cac8c31e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b67acaa-7a65-3198-c51a-d23cac8c31e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/16] Fold postcopy_ram_discard_range
 into ram_discard_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, aarcange@redhat.com

* Laurent Vivier (lvivier@redhat.com) wrote:
> On 06/02/2017 18:32, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Using the previously created ram_block_discard_range,
> > kill off postcopy_ram_discard_range.
> > ram_discard_range is just a wrapper that does the name lookup.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/migration/postcopy-ram.h |  7 -------
> >  migration/postcopy-ram.c         | 30 +-----------------------------
> >  migration/ram.c                  | 24 +++---------------------
> >  migration/trace-events           |  2 +-
> >  4 files changed, 5 insertions(+), 58 deletions(-)
> > 
> > diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
> > index b6a7491f..43bbbca 100644
> > --- a/include/migration/postcopy-ram.h
> > +++ b/include/migration/postcopy-ram.h
> > @@ -35,13 +35,6 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages);
> >  int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis);
> >  
> >  /*
> > - * Discard the contents of 'length' bytes from 'start'
> > - * We can assume that if we've been called postcopy_ram_hosttest returned true
> > - */
> > -int postcopy_ram_discard_range(MigrationIncomingState *mis, uint8_t *start,
> > -                               size_t length);
> > -
> > -/*
> >   * Userfault requires us to mark RAM as NOHUGEPAGE prior to discard
> >   * however leaving it until after precopy means that most of the precopy
> >   * data is still THPd
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index a40dddb..1e3d22f 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -200,27 +200,6 @@ out:
> >      return ret;
> >  }
> >  
> > -/**
> > - * postcopy_ram_discard_range: Discard a range of memory.
> > - * We can assume that if we've been called postcopy_ram_hosttest returned true.
> > - *
> > - * @mis: Current incoming migration state.
> > - * @start, @length: range of memory to discard.
> > - *
> > - * returns: 0 on success.
> > - */
> > -int postcopy_ram_discard_range(MigrationIncomingState *mis, uint8_t *start,
> > -                               size_t length)
> > -{
> > -    trace_postcopy_ram_discard_range(start, length);
> > -    if (madvise(start, length, MADV_DONTNEED)) {
> > -        error_report("%s MADV_DONTNEED: %s", __func__, strerror(errno));
> > -        return -1;
> > -    }
> > -
> > -    return 0;
> > -}
> > -
> >  /*
> >   * Setup an area of RAM so that it *can* be used for postcopy later; this
> >   * must be done right at the start prior to pre-copy.
> > @@ -239,7 +218,7 @@ static int init_range(const char *block_name, void *host_addr,
> >       * - we're going to get the copy from the source anyway.
> >       * (Precopy will just overwrite this data, so doesn't need the discard)
> >       */
> > -    if (postcopy_ram_discard_range(mis, host_addr, length)) {
> > +    if (ram_discard_range(mis, block_name, 0, length)) {
> >          return -1;
> >      }
> >  
> > @@ -658,13 +637,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
> >      return -1;
> >  }
> >  
> > -int postcopy_ram_discard_range(MigrationIncomingState *mis, uint8_t *start,
> > -                               size_t length)
> > -{
> > -    assert(0);
> > -    return -1;
> > -}
> > -
> >  int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
> >  {
> >      assert(0);
> > diff --git a/migration/ram.c b/migration/ram.c
> > index d33bd21..136996a 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1845,6 +1845,8 @@ int ram_discard_range(MigrationIncomingState *mis,
> >  {
> >      int ret = -1;
> >  
> > +    trace_ram_discard_range(block_name, start, length);
> > +
> >      rcu_read_lock();
> 
> I think you take the rcu_read_lock() twice: here and in
> ram_block_discard_range().

Hmm, yes I can lose the one in ram_block_discard_range.

> I think you should merge this patch with PATCH 04/16, as it's just code
> copy.

OK, I'd done it as 'add the new one' and 'take the old one away';
but I can do that.

Dave

> 
> Laurent
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
