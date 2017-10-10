Received: from eggs.gnu.org ([2001:4830:134:3::10]:52436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1rSt-0005xg-1F
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e1rSo-0006OG-3P
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e1rSn-0006Nu-QN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:08:38 -0400
Date: Tue, 10 Oct 2017 18:08:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171010100830.GD20686@pxdev.xzpeter.org>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-33-git-send-email-peterx@redhat.com>
	<20170922203227.GP2620@work-vm>
	<20170928065407.GF17044@pxdev.xzpeter.org>
	<20171009172805.GP2374@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171009172805.GP2374@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 32/33] migration: allow migrate_incoming
 for paused VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Mon, Oct 09, 2017 at 06:28:06PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > > >  /*
> > > > @@ -1291,14 +1301,25 @@ void migrate_del_blocker(Error *reason)
> > > >  void qmp_migrate_incoming(const char *uri, Error **errp)
> > > >  {
> > > >      Error *local_err = NULL;
> > > > -    static bool once = true;
> > > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > >  
> > > > -    if (!deferred_incoming) {
> > > > -        error_setg(errp, "For use with '-incoming defer'");
> > > > +    if (!deferred_incoming &&
> > > > +        mis->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > > > +        error_setg(errp, "For use with '-incoming defer'"
> > > > +                   " or PAUSED postcopy migration only.");
> > > >          return;
> > > >      }
> > > > -    if (!once) {
> > > > -        error_setg(errp, "The incoming migration has already been started");
> > > 
> > > What guards against someone doing a migrate_incoming after the succesful
> > > completion of an incoming migration?
> > 
> > If deferred incoming is not enabled, we should be protected by above
> > check on (mis->state != MIGRATION_STATUS_POSTCOPY_PAUSED).  But yes I
> > think this is a problem if deferred incoming is used.  Maybe I should
> > still keep the "once" check here for deferred migration, but I think I
> > can re-use the variable "deferred_incoming".  Please see below.
> > 
> > > Also with RDMA the following won't happen so I'm not quite sure what
> > > state we're in.
> > 
> > Indeed.  Currently there is still no good way to destroy the RDMA
> > accept handle easily since it's using its own qemu_set_fd_handler()
> > way to setup accept ports.  But I think maybe I can solve this problem
> > with below issue together.  Please see below.
> > 
> > > 
> > > When we get to non-blocking commands it's also a bit interesting - we
> > > could be getting an accept on the main thread at just the same time
> > > this is going down the OOB side.
> > 
> > This is an interesting point.  Thanks for noticing that.
> > 
> > How about I do it the strict way?  like this (hopefully this can solve
> > all the issues mentioned above):
> > 
> > qmp_migrate_incoming()
> > {
> >   if (deferred_incoming) {
> >     // PASS, deferred incoming is set, and never triggered
> >   } else if (state == POSTCOPY_PAUSED && listen_tag == 0) {
> >     // PASS, we don't have an accept port
> >   } else {
> >     // FAIL
> 
> One problem is at this point you can't say much about why you failed;
> my original migrate_incoming was like this, but then in 4debb5f5 I
> added the 'once' to allow you to distinguish the cases of trying to use
> migrate_incoming twice from never having used -incoming defer;
> Markus asked for that in the review: http://lists.gnu.org/archive/html/qemu-devel/2015-02/msg04079.html

Ah.  Then let me revive the "once" parameter:

  if (state == POSTCOPY_PAUSED && listen_tag == 0) {
    // PASS, we don't have an accept port and need recovery
  } else if (deferred_incoming) {
    if (!once) {
      once = true;
      // PASS, incoming is deferred
    } else {
      // FAIL: deferred incoming has been specified already
    }
  } else {
    // FAIL: neither do we need recovery, nor do we have deferred incoming
  }

> 
> >   }
> > 
> >   qemu_start_incoming_migration(uri, &local_err);
> 
> We still have to make sure that nothin in that takes a lock.

I think the monitor_lock is needed when sending events, but I think
it's fine - during critical section of monitor_lock, there is no
chance for page fault.

For the rest, I didn't see a chance.  Hope I didn't miss anything...

> 
> >   if (local_err) {
> >       error_propagate(errp, local_err);
> >       return;
> >   }
> > 
> >   // stop allowing this
> >   deferred_incoming = false;
> 
> OK, this works I think as long as we have the requirement that
> only one OOB command can be executing at once.  So that depends
> on the structure of your OOB stuff;  if you can run multiple OOB
> at once then you can have two instances of this command running
> at the same time and this setting passes each other.

Indeed.  IIUC Markus's proposal (and lastest version of the series)
won't allow OOB to be run in parallel. They (the commands) should be
fast commands, fast enough that won't need to bother to be run
concurrently.  If that can be paralleled, we may need a lock.

> 
> (You may have to be careful of the read of state and listen_tag
> since those are getting set from another thread).

IMHO think it should be fine here - I'm checking on listen_tag against
zero, and this function is the only chance we change it from zero to
non-zero. So as long as we don't parallel this function (or have lock
as mentioned above) IMHO we should be good.

> 
> > }
> > 
> > To make sure it works, I may need to hack an unique listen tag for
> > RDMA for now, say, using (guint)(-1) to stands for RDMA tag (instead
> > of really re-write RDMA codes to use the watcher stuff with real
> > listen tags), like:
> > 
> > #define MIG_LISTEN_TAG_RDMA_FAKE ((guint)(-1))
> > 
> > bool migrate_incoming_detach_listen()
> > {
> >     if (listen_tag) {
> >         if (listen_tag != MIG_LISTEN_TAG_RDMA_FAKE) {
> >             // RDMA has already detached the accept port
> >             g_source_remove(listen_tag);
> >         }
> >         listen_tag = 0;
> >         return true;
> >     }
> >     return false;
> > }
> > 
> > Then when listen_tag != 0 it means that there is an acception port,
> > and as long as there is one port we don't allow to change it (like the
> > pesudo qmp_migrate_incoming() code I wrote).
> 
> It's worth noting anyway that RDMA doesn't work with postcopy yet
> anyway (although I now have some ideas how we could fix that).

Ah, good to know.

Then I think I can avoid introducing this hacky tag any more. Instead,
I may do proper commenting showing that the check should not apply to
RDMA (since we will first check POSTCOPY_PAUSED state before checking
listen_tag, then it would never be RDMA migration).

Thanks,

-- 
Peter Xu
