Received: from eggs.gnu.org ([2001:4830:134:3::10]:35048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddVRl-0005tp-5G
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddVRh-0001Op-NL
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddVRh-0001Iu-H2
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:46:49 -0400
Date: Fri, 4 Aug 2017 13:46:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804054642.GE5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-21-git-send-email-peterx@redhat.com>
	<20170803092820.GB2076@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803092820.GB2076@work-vm>
Subject: Re: [Qemu-devel] [RFC 20/29] migration: wakeup dst ram-load-thread
 for recover
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

On Thu, Aug 03, 2017 at 10:28:20AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On the destination side, we cannot wake up all the threads when we got
> > reconnected. The first thing to do is to wake up the main load thread,
> > so that we can continue to receive valid messages from source again and
> > reply when needed.
> > 
> > At this point, we switch the destination VM state from postcopy-paused
> > back to postcopy-recover.
> > 
> > Now we are finally ready to do the resume logic.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 34 +++++++++++++++++++++++++++++++---
> >  1 file changed, 31 insertions(+), 3 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 3aabe11..e498fa4 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -389,10 +389,38 @@ static void process_incoming_migration_co(void *opaque)
> >  
> >  void migration_fd_process_incoming(QEMUFile *f)
> >  {
> > -    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, f);
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    Coroutine *co;
> > +
> > +    mis->from_src_file = f;
> > +
> > +    if (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > +        /* Resumed migration to postcopy state */

(I guess here it should be "Resumed from a paused postcopy migration")

> > +
> > +        /* Postcopy has standalone thread to do vm load */
> > +        qemu_file_set_blocking(f, true);
> > +
> > +        /* Re-configure the return path */
> > +        mis->to_src_file = qemu_file_get_return_path(f);
> >  
> > -    qemu_file_set_blocking(f, false);
> > -    qemu_coroutine_enter(co);
> > +        /* Reset the migration status to postcopy-active */
> > +        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
> > +                          MIGRATION_STATUS_POSTCOPY_RECOVER);
> 
> The comment doesn't match the code.

Indeed. I'll remove the comment since the code explains.

> 
> Other than that;
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks,

-- 
Peter Xu
