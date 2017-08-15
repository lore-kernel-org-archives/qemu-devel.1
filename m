Received: from eggs.gnu.org ([2001:4830:134:3::10]:47908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhYRS-0003T2-RV
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dhYRN-0000vb-Sb
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dhYRN-0000uu-Ib
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:47:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D70C80B29
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:47:12 +0000 (UTC)
Date: Tue, 15 Aug 2017 17:47:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170815094708.GB19446@pxdev.xzpeter.org>
References: <1502777827-18874-1-git-send-email-peterx@redhat.com>
	<1502777827-18874-6-git-send-email-peterx@redhat.com>
	<20170815083714.GA9674@redhat.com>
	<20170815085006.GA19446@pxdev.xzpeter.org>
	<20170815092707.GE9674@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815092707.GE9674@redhat.com>
Subject: Re: [Qemu-devel] [RFC 5/6] migration: store listen task tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 15, 2017 at 10:27:07AM +0100, Daniel P. Berrange wrote:
> On Tue, Aug 15, 2017 at 04:50:06PM +0800, Peter Xu wrote:
> > On Tue, Aug 15, 2017 at 09:37:14AM +0100, Daniel P. Berrange wrote:
> > > On Tue, Aug 15, 2017 at 02:17:06PM +0800, Peter Xu wrote:
> > > > Store the task tag for migration types: tcp/unix/fd/exec in current
> > > > MigrationIncomingState struct.
> > > > 
> > > > For defered migration, no need to store task tag since there is no task
> > > > running in the main loop at all. For RDMA, let's mark it as todo.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  migration/migration.c | 22 ++++++++++++++++++----
> > > >  migration/migration.h |  2 ++
> > > >  2 files changed, 20 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index c9b7085..daf356b 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -171,6 +171,7 @@ void migration_incoming_state_destroy(void)
> > > >          mis->from_src_file = NULL;
> > > >      }
> > > >  
> > > > +    mis->listen_task_tag = 0;
> > > >      qemu_event_destroy(&mis->main_thread_load_event);
> > > >  }
> > > >  
> > > > @@ -265,25 +266,31 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
> > > >  void qemu_start_incoming_migration(const char *uri, Error **errp)
> > > >  {
> > > >      const char *p;
> > > > +    guint task_tag = 0;
> > > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > >  
> > > >      qapi_event_send_migration(MIGRATION_STATUS_SETUP, &error_abort);
> > > >      if (!strcmp(uri, "defer")) {
> > > >          deferred_incoming_migration(errp);
> > > >      } else if (strstart(uri, "tcp:", &p)) {
> > > > -        tcp_start_incoming_migration(p, errp);
> > > > +        task_tag = tcp_start_incoming_migration(p, errp);
> > > >  #ifdef CONFIG_RDMA
> > > >      } else if (strstart(uri, "rdma:", &p)) {
> > > > +        /* TODO: store task tag for RDMA migrations */
> > > >          rdma_start_incoming_migration(p, errp);
> > > >  #endif
> > > >      } else if (strstart(uri, "exec:", &p)) {
> > > > -        exec_start_incoming_migration(p, errp);
> > > > +        task_tag = exec_start_incoming_migration(p, errp);
> > > >      } else if (strstart(uri, "unix:", &p)) {
> > > > -        unix_start_incoming_migration(p, errp);
> > > > +        task_tag = unix_start_incoming_migration(p, errp);
> > > >      } else if (strstart(uri, "fd:", &p)) {
> > > > -        fd_start_incoming_migration(p, errp);
> > > > +        task_tag = fd_start_incoming_migration(p, errp);
> > > >      } else {
> > > >          error_setg(errp, "unknown migration protocol: %s", uri);
> > > > +        return;
> > > >      }
> > > > +
> > > > +    mis->listen_task_tag = task_tag;
> > > 
> > > This is unsafe as currently written. The main loop watches that are
> > > associated with these tags are all unregistered when incoming migration
> > > starts. So if you save them, and then unregister later when postcopy
> > > is "stuck", then you're likely unregistering a tag associated with
> > > some other random part of QEMU, because the saved value is no longer
> > > valid.
> > 
> > IIUC for incoming migration, the watch is not detached until
> > migration_fd_process_incoming() completes. So:
> > 
> > - for precopy, the watch should be detached when migration completes
> > 
> > - for postcopy, the watch should be detached when postcopy starts,
> >   then main loop thread returns, while the ram_load_thread starts to
> >   continue the migration.
> > 
> > So basically the watch is detaching itself after
> > migration_fd_process_incoming() completes. To handle that, this patch
> > has this change:
> > 
> > @@ -422,6 +429,13 @@ void migration_fd_process_incoming(QEMUFile *f)
> >          co = qemu_coroutine_create(process_incoming_migration_co, f);
> >          qemu_coroutine_enter(co);
> >      }
> > +
> > +    /*
> > +     * When reach here, we should not need the listening port any
> > +     * more. We'll detach the listening task soon, let's reset the
> > +     * listen task tag.
> > +     */
> > +    mis->listen_task_tag = 0;
> > 
> > Would this make sure the listen_task_tag is always valid if nonzero?
> 
> Mixing 'return FALSE' from callbacks, with g_source_remove is a recipe
> for hard to diagnose bugs, so should be avoided in general.

Makes sense.

> 
> So, IMHO, you should change all the callbacks to 'return TRUE' so that
> they keep the watch registered, and then explicitly call g_source_remove()
> passing the listen tag, when incoming migration starts.

Yes this sounds better.  Thanks!

-- 
Peter Xu
