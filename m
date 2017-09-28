Received: from eggs.gnu.org ([2001:4830:134:3::10]:55859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxSiA-0002IS-Sc
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 02:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxSi5-0003YP-Rl
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 02:54:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxSi5-0003Y1-I7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 02:54:13 -0400
Date: Thu, 28 Sep 2017 14:54:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170928065407.GF17044@pxdev.xzpeter.org>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-33-git-send-email-peterx@redhat.com>
	<20170922203227.GP2620@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922203227.GP2620@work-vm>
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

On Fri, Sep 22, 2017 at 09:32:28PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > migrate_incoming command is previously only used when we were providing
> > "-incoming defer" in the command line, to defer the incoming migration
> > channel creation.
> > 
> > However there is similar requirement when we are paused during postcopy
> > migration. The old incoming channel might have been destroyed already.
> > We may need another new channel for the recovery to happen.
> > 
> > This patch leveraged the same interface, but allows the user to specify
> > incoming migration channel even for paused postcopy.
> > 
> > Meanwhile, now migration listening ports are always detached manually
> > using the tag, rather than using return values of dispatchers.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/exec.c      |  2 +-
> >  migration/fd.c        |  2 +-
> >  migration/migration.c | 39 +++++++++++++++++++++++++++++----------
> >  migration/socket.c    |  2 +-
> >  4 files changed, 32 insertions(+), 13 deletions(-)
> > 
> > diff --git a/migration/exec.c b/migration/exec.c
> > index ef1fb4c..26fc37d 100644
> > --- a/migration/exec.c
> > +++ b/migration/exec.c
> > @@ -49,7 +49,7 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
> >  {
> >      migration_channel_process_incoming(ioc);
> >      object_unref(OBJECT(ioc));
> > -    return FALSE; /* unregister */
> > +    return TRUE; /* keep it registered */
> >  }
> >  
> >  /*
> > diff --git a/migration/fd.c b/migration/fd.c
> > index e9a548c..7d0aefa 100644
> > --- a/migration/fd.c
> > +++ b/migration/fd.c
> > @@ -49,7 +49,7 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
> >  {
> >      migration_channel_process_incoming(ioc);
> >      object_unref(OBJECT(ioc));
> > -    return FALSE; /* unregister */
> > +    return TRUE; /* keep it registered */
> >  }
> >  
> >  /*
> > diff --git a/migration/migration.c b/migration/migration.c
> > index daf356b..5812478 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -175,6 +175,17 @@ void migration_incoming_state_destroy(void)
> >      qemu_event_destroy(&mis->main_thread_load_event);
> >  }
> >  
> > +static bool migrate_incoming_detach_listen(MigrationIncomingState *mis)
> > +{
> > +    if (mis->listen_task_tag) {
> > +        /* Never fail */
> > +        g_source_remove(mis->listen_task_tag);
> > +        mis->listen_task_tag = 0;
> > +        return true;
> > +    }
> > +    return false;
> > +}
> > +
> >  static void migrate_generate_event(int new_state)
> >  {
> >      if (migrate_use_events()) {
> > @@ -432,10 +443,9 @@ void migration_fd_process_incoming(QEMUFile *f)
> >  
> >      /*
> >       * When reach here, we should not need the listening port any
> > -     * more. We'll detach the listening task soon, let's reset the
> > -     * listen task tag.
> > +     * more.  Detach the listening port explicitly.
> >       */
> > -    mis->listen_task_tag = 0;
> > +    migrate_incoming_detach_listen(mis);
> >  }
> >  
> >  /*
> > @@ -1291,14 +1301,25 @@ void migrate_del_blocker(Error *reason)
> >  void qmp_migrate_incoming(const char *uri, Error **errp)
> >  {
> >      Error *local_err = NULL;
> > -    static bool once = true;
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> >  
> > -    if (!deferred_incoming) {
> > -        error_setg(errp, "For use with '-incoming defer'");
> > +    if (!deferred_incoming &&
> > +        mis->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > +        error_setg(errp, "For use with '-incoming defer'"
> > +                   " or PAUSED postcopy migration only.");
> >          return;
> >      }
> > -    if (!once) {
> > -        error_setg(errp, "The incoming migration has already been started");
> 
> What guards against someone doing a migrate_incoming after the succesful
> completion of an incoming migration?

If deferred incoming is not enabled, we should be protected by above
check on (mis->state != MIGRATION_STATUS_POSTCOPY_PAUSED).  But yes I
think this is a problem if deferred incoming is used.  Maybe I should
still keep the "once" check here for deferred migration, but I think I
can re-use the variable "deferred_incoming".  Please see below.

> Also with RDMA the following won't happen so I'm not quite sure what
> state we're in.

Indeed.  Currently there is still no good way to destroy the RDMA
accept handle easily since it's using its own qemu_set_fd_handler()
way to setup accept ports.  But I think maybe I can solve this problem
with below issue together.  Please see below.

> 
> When we get to non-blocking commands it's also a bit interesting - we
> could be getting an accept on the main thread at just the same time
> this is going down the OOB side.

This is an interesting point.  Thanks for noticing that.

How about I do it the strict way?  like this (hopefully this can solve
all the issues mentioned above):

qmp_migrate_incoming()
{
  if (deferred_incoming) {
    // PASS, deferred incoming is set, and never triggered
  } else if (state == POSTCOPY_PAUSED && listen_tag == 0) {
    // PASS, we don't have an accept port
  } else {
    // FAIL
  }

  qemu_start_incoming_migration(uri, &local_err);

  if (local_err) {
      error_propagate(errp, local_err);
      return;
  }

  // stop allowing this
  deferred_incoming = false;
}

To make sure it works, I may need to hack an unique listen tag for
RDMA for now, say, using (guint)(-1) to stands for RDMA tag (instead
of really re-write RDMA codes to use the watcher stuff with real
listen tags), like:

#define MIG_LISTEN_TAG_RDMA_FAKE ((guint)(-1))

bool migrate_incoming_detach_listen()
{
    if (listen_tag) {
        if (listen_tag != MIG_LISTEN_TAG_RDMA_FAKE) {
            // RDMA has already detached the accept port
            g_source_remove(listen_tag);
        }
        listen_tag = 0;
        return true;
    }
    return false;
}

Then when listen_tag != 0 it means that there is an acception port,
and as long as there is one port we don't allow to change it (like the
pesudo qmp_migrate_incoming() code I wrote).

Would this work?

> 
> Dave
> 
> > +
> > +    /*
> > +     * Destroy existing listening task if exist. Logically this should
> > +     * not really happen at all (for either deferred migration or
> > +     * postcopy migration, we should both detached the listening
> > +     * task). So raise an error but still we safely detach it.
> > +     */
> > +    if (migrate_incoming_detach_listen(mis)) {
> > +        error_report("%s: detected existing listen channel, "
> > +                     "while it should not exist", __func__);
> > +        /* Continue */
> >      }
> >  
> >      qemu_start_incoming_migration(uri, &local_err);
> > @@ -1307,8 +1328,6 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > -
> > -    once = false;
> >  }
> >  
> >  bool migration_is_blocked(Error **errp)
> > diff --git a/migration/socket.c b/migration/socket.c
> > index 6ee51ef..e3e453f 100644
> > --- a/migration/socket.c
> > +++ b/migration/socket.c
> > @@ -154,7 +154,7 @@ static gboolean socket_accept_incoming_migration(QIOChannel *ioc,
> >  out:
> >      /* Close listening socket as its no longer needed */
> >      qio_channel_close(ioc, NULL);
> > -    return FALSE; /* unregister */
> > +    return TRUE; /* keep it registered */
> >  }
> >  
> >  
> > -- 
> > 2.7.4
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Peter Xu
