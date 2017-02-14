Received: from eggs.gnu.org ([2001:4830:134:3::10]:42202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdbNO-0007R3-KT
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdbNL-00068x-BX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:34:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdbNL-00068L-3O
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:34:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11ECB7E9DF
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 11:34:27 +0000 (UTC)
Date: Tue, 14 Feb 2017 11:34:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170214113421.GG2463@work-vm>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-15-git-send-email-quintela@redhat.com>
	<20170203112402.GD3208@work-vm> <87o9y63u85.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9y63u85.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH 14/17] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> We make the locking and the transfer of information specific, even if we
> >> are still receiving things through the main thread.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  migration/ram.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++--------
> >>  1 file changed, 67 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index ca94704..4e530ea 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -523,7 +523,7 @@ void migrate_multifd_send_threads_create(void)
> >>      }
> >>  }
> >> 
> >> -static int multifd_send_page(uint8_t *address)
> >> +static uint16_t multifd_send_page(uint8_t *address, bool last_page)
> >>  {
> >>      int i, j, thread_count;
> >>      bool found = false;
> >> @@ -538,8 +538,10 @@ static int multifd_send_page(uint8_t *address)
> >>      pages.address[pages.num] = address;
> >>      pages.num++;
> >> 
> >> -    if (pages.num < (pages.size - 1)) {
> >> -        return UINT16_MAX;
> >> +    if (!last_page) {
> >> +        if (pages.num < (pages.size - 1)) {
> >> +            return UINT16_MAX;
> >> +        }
> >>      }
> >
> > This should be in the previous patch?
> > (and the place that adds the last_page parameter below)?
> 
> ok.
> 
> >> @@ -2920,10 +2980,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >> 
> >>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
> >>              fd_num = qemu_get_be16(f);
> >> -            if (fd_num != 0) {
> >> -                /* this is yet an unused variable, changed later */
> >> -                fd_num = fd_num;
> >> -            }
> >> +            multifd_recv_page(host, fd_num);
> >
> > This is going to be quite tricky to fit into ram_load_postcopy
> > in this form; somehow it's going to have to find addresses to use for place page
> > and with anything with a page size != target page size it gets messy.
> 
> What do you have in mind?

The problem is that for postcopy we read the data into a temporary buffer
and then call a system call to 'place' the page atomically in memory.
At the moment there's a single temporary buffer; for x86 this is easy -
read a page into buffer; place it.  For Power/ARM or hugepages we
read consecutive target-pages into the temporary buffer and at the end
of the page place the whole host/huge page at once.
If you're reading multiple pages in parallel then you're going to need
to take care with multiple temporary buffers; having one hugepage/hostpage
per fd would probably be the easiest way.

A related thing to take care of is that when switching to postcopy mode
we probably need to take care to sync all of the fds to make sure
any outstanding RAM load has completed before we start doing any postcopy
magic.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
