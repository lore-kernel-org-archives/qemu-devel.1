Received: from eggs.gnu.org ([2001:4830:134:3::10]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcNQp-0005Sc-Hp
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 23:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcNQk-0000mV-JC
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 23:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcNQk-0000lw-Do
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 23:01:10 -0400
Date: Tue, 1 Aug 2017 11:01:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170801030104.GD15697@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-10-git-send-email-peterx@redhat.com>
	<20170731184538.GK2122@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170731184538.GK2122@work-vm>
Subject: Re: [Qemu-devel] [RFC 09/29] migration: provide
 postcopy_fault_thread_notify()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Mon, Jul 31, 2017 at 07:45:38PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > A general helper to notify the fault thread.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/postcopy-ram.c | 35 ++++++++++++++++++++---------------
> >  migration/postcopy-ram.h |  2 ++
> >  2 files changed, 22 insertions(+), 15 deletions(-)
> > 
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 4278fe7..9ce391d 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -287,6 +287,21 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages)
> >      return 0;
> >  }
> >  
> > +void postcopy_fault_thread_notify(MigrationIncomingState *mis)
> > +{
> > +    uint64_t tmp64 = 1;
> > +
> > +    /*
> > +     * Tell the fault_thread to exit, it's an eventfd that should
> > +     * currently be at 0, we're going to increment it to 1
> > +     */
> > +    if (write(mis->userfault_event_fd, &tmp64, 8) != 8) {
> > +        /* Not much we can do here, but may as well report it */
> > +        error_report("%s: incrementing userfault_quit_fd: %s", __func__,
> 
> minor; that error message needs updating with the new name, or since
> it's a standalone function, 'incrementing failed:'  would work.
> Other than that:

Will fix (possibly should be in previous patch since that patch did
the name change).  Also, I think I need to touch up the comment as well
with s/exit/wake/.

> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

-- 
Peter Xu
