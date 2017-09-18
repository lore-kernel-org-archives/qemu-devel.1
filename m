Received: from eggs.gnu.org ([2001:4830:134:3::10]:36942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dtsqv-0006D4-Fb
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dtsqp-0003vx-4m
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:00:33 -0400
Date: Mon, 18 Sep 2017 11:00:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170918100014.GB2581@work-vm>
References: <20170915054404.19914-1-famz@redhat.com>
	<20170915054404.19914-3-famz@redhat.com>
	<20170915080350.GS3617@pxdev.xzpeter.org>
	<20170915082026.GG17199@lemon> <20170915084234.GA2170@work-vm>
	<20170915085247.GH17199@lemon> <20170915092242.GB2170@work-vm>
	<20170918073159.GZ3617@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918073159.GZ3617@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Cancel migration at exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Sep 15, 2017 at 10:22:43AM +0100, Dr. David Alan Gilbert wrote:
> > * Fam Zheng (famz@redhat.com) wrote:
> > > On Fri, 09/15 09:42, Dr. David Alan Gilbert wrote:
> > > > * Fam Zheng (famz@redhat.com) wrote:
> > > > > On Fri, 09/15 16:03, Peter Xu wrote:
> > > > > > On Fri, Sep 15, 2017 at 01:44:03PM +0800, Fam Zheng wrote:
> > > > > > > bdrv_close_all() would abort() due to op blockers added by BMDS, clean
> > > > > > > up migration states when main loop quits to avoid that.
> > > > > > > 
> > > > > > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > > > > > ---
> > > > > > >  include/migration/misc.h | 1 +
> > > > > > >  migration/migration.c    | 7 ++++++-
> > > > > > >  vl.c                     | 3 +++
> > > > > > >  3 files changed, 10 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > > > > > > index c079b7771b..b9a26b0898 100644
> > > > > > > --- a/include/migration/misc.h
> > > > > > > +++ b/include/migration/misc.h
> > > > > > > @@ -54,5 +54,6 @@ bool migration_has_failed(MigrationState *);
> > > > > > >  /* ...and after the device transmission */
> > > > > > >  bool migration_in_postcopy_after_devices(MigrationState *);
> > > > > > >  void migration_global_dump(Monitor *mon);
> > > > > > > +void migrate_cancel(void);
> > > > > > >  
> > > > > > >  #endif
> > > > > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > > > > index 959e8ec88e..2c844945c7 100644
> > > > > > > --- a/migration/migration.c
> > > > > > > +++ b/migration/migration.c
> > > > > > > @@ -1274,11 +1274,16 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
> > > > > > >      }
> > > > > > >  }
> > > > > > >  
> > > > > > > -void qmp_migrate_cancel(Error **errp)
> > > > > > > +void migrate_cancel(void)
> > > > > > >  {
> > > > > > >      migrate_fd_cancel(migrate_get_current());
> > > > > > >  }
> > > > > > >  
> > > > > > > +void qmp_migrate_cancel(Error **errp)
> > > > > > > +{
> > > > > > > +    migrate_cancel();
> > > > > > > +}
> > > > > > > +
> > > > > > 
> > > > > > Nit: I would prefer just call migrate_fd_cancel() below, since I don't
> > > > > > see much point to introduce migrate_cancel() which only calls
> > > > > > migrate_fd_cancel()...
> > > > > 
> > > > > migrate_get_current() is a migration internal IMHO. But that can be moved to
> > > > > migrate_fd_cancel() so the parameter is dropped.
> > > > > 
> > > > > > 
> > > > > > >  void qmp_migrate_set_cache_size(int64_t value, Error **errp)
> > > > > > >  {
> > > > > > >      MigrationState *s = migrate_get_current();
> > > > > > > diff --git a/vl.c b/vl.c
> > > > > > > index fb1f05b937..abbe61f40b 100644
> > > > > > > --- a/vl.c
> > > > > > > +++ b/vl.c
> > > > > > > @@ -87,6 +87,7 @@ int main(int argc, char **argv)
> > > > > > >  #include "sysemu/blockdev.h"
> > > > > > >  #include "hw/block/block.h"
> > > > > > >  #include "migration/misc.h"
> > > > > > > +#include "migration/savevm.h"
> > > > > > >  #include "migration/snapshot.h"
> > > > > > >  #include "migration/global_state.h"
> > > > > > >  #include "sysemu/tpm.h"
> > > > > > > @@ -4799,6 +4800,8 @@ int main(int argc, char **argv, char **envp)
> > > > > > >      iothread_stop_all();
> > > > > > >  
> > > > > > >      pause_all_vcpus();
> > > > > > > +    migrate_cancel();
> > > > > > 
> > > > > > IIUC this is an async cancel, so when reach here the migration thread
> > > > > > can still be alive.  Then...
> > > > > > 
> > > > > > > +    qemu_savevm_state_cleanup();
> > > > > > 
> > > > > > ... Here calling qemu_savevm_state_cleanup() may be problematic if
> > > > > > migration thread has not yet quitted.
> > > > > > 
> > > > > > I'm thinking whether we should make migrate_fd_cancel() wait until the
> > > > > > migration thread finishes (state change to CANCELLED).  Then the
> > > > > > migration thread will do the cleanup, and here we can avoid calling
> > > > > > qemu_savevm_state_cleanup() as well.
> > > > > 
> > > > > But if the migration thread is stuck and CANCELLED is never reached, we'll hang
> > > > > here?
> > > > 
> > > > I'm not sure I see an easy fix; I agree with Peter that calling
> > > > migrate_cancel() followed by qemu_savevm_state_cleanup() is racy,
> > > > because the cancel just forces the state to CANCELLING before coming
> > > > back to you, and the migration thread asynchronously starts to
> > > > fail/cleanup.
> > > > 
> > > > migrate_cancel() can forcibly unblock some cases because it calls
> > > > shutdown(2) on the network fd, but there are other ways for a migration
> > > > to hang.
> > > > 
> > > > Having said that,  the migration thread does it's calls
> > > > to qemu_savevm_state_cleanup under the lock_iothread;
> > > > Do we have that lock at this point?
> > > 
> > > Yes we do.  Main loop releases the lock only during poll(), other parts of
> > > main() all have the lock.
> > 
> > Having said that though this is pretty confusing; because at this point
> > we're after main_loop has exited.
> > I don't think the migration thread will exit without having taken the
> > iothread lock; so if we've got it at this point then the migration
> > thread will never exit, and it will never call qemu_savevm_state_cleanup
> > itself - so that race might not exist?
> 
> Is that because we are taking the BQL in migration_thread()?  Please
> see my below questions...

Yes; there are a few places we take it.

> > However, assuming the migration is at an earlier point, it might be
> > calling one of the state handlers that you're cleaning up, and that's
> > racy in individual devices.
> > 
> > If we have the lock I don't think we can wait for the migration to
> > complete/cancel.   The transition from cancelling->cancelled happens
> > in migrate_fd_cleanup() - and that's run of a bh which I assume don't
> > work any more at this point.
> > 
> > Perhaps the answer is to move this to qemu_system_shutdown_request prior
> > to the point where shutdown_requested is set?  At that point we've
> > still got the main loop, although hmm I'm not convinced if it's
> > consistent whether that's called with or without the lock held.
> 
> I do think the migration cleanup part needs some cleanup itself... :)
> 
> Actually I have two questions here about BQL and migration:
> 
> (1) I see that we took BQL in migration_thread(), but if the migration
>     thread is to be cancelled, could we avoid taking the lock for the
>     cancelling case right after we break from the big migration loop?
>     Since I don't see why we need it if we are after all going to
>     cancel the migration...  (though this one may need some other
>     cleanups to let it work I guess)

If you mean the lock just before 'The resource has been allocated...'
no I don't think so; I'm not sure - I worry about what would happen if
someone issued a migrate_cancel or another migrate command during that
time - but then that could happen just before the lock_iothread so I'm
not sure we're any worse off.


> (2) I see that we took BQL in migrate_fd_cleanup().  Could I ask why
>     we had that?  Can we remove it?

Note migrate_fd_cleanup is called in a bh, so I think that means it's
entered with the lock held and that just drops it while we wait
for the other thread.

Dave

> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
