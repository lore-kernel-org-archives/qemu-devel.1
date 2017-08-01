Received: from eggs.gnu.org ([2001:4830:134:3::10]:60682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcQfi-0003CH-FD
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dcQfe-0001KR-FV
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dcQfe-0001JO-6V
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:28:46 -0400
Date: Tue, 1 Aug 2017 14:28:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170801062840.GH15697@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-12-git-send-email-peterx@redhat.com>
	<20170731190617.GC3095@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170731190617.GC3095@work-vm>
Subject: Re: [Qemu-devel] [RFC 11/29] migration: new postcopy-pause state
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

On Mon, Jul 31, 2017 at 08:06:18PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Introducing a new state "postcopy-paused", which can be used to pause a
> > postcopy migration. It is targeted to support network failures during
> > postcopy migration. Now when network down for postcopy, the source side
> > will not fail the migration. Instead we convert the status into this new
> > paused state, and we will try to wait for a rescue in the future.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> I think this should probably be split into:
>    a) A patch that adds a new state and the entries in query_migrate etc
>    b) A patch that wires up the semaphore and the use of the state.

Reasonable.  Let me split it.

> 
> > ---
> >  migration/migration.c  | 78 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  migration/migration.h  |  3 ++
> >  migration/trace-events |  1 +
> >  qapi-schema.json       |  5 +++-
> >  4 files changed, 82 insertions(+), 5 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index efee87e..0bc70c8 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -470,6 +470,7 @@ static bool migration_is_setup_or_active(int state)
> >      switch (state) {
> >      case MIGRATION_STATUS_ACTIVE:
> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> > +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> >      case MIGRATION_STATUS_SETUP:
> >          return true;
> >  
> > @@ -545,6 +546,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
> >      case MIGRATION_STATUS_ACTIVE:
> >      case MIGRATION_STATUS_CANCELLING:
> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> > +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> >           /* TODO add some postcopy stats */
> >          info->has_status = true;
> >          info->has_total_time = true;
> > @@ -991,6 +993,8 @@ static void migrate_fd_cleanup(void *opaque)
> >  
> >      notifier_list_notify(&migration_state_notifiers, s);
> >      block_cleanup_parameters(s);
> > +
> > +    qemu_sem_destroy(&s->postcopy_pause_sem);
> >  }
> >  
> >  void migrate_fd_error(MigrationState *s, const Error *error)
> > @@ -1134,6 +1138,7 @@ MigrationState *migrate_init(void)
> >      s->migration_thread_running = false;
> >      error_free(s->error);
> >      s->error = NULL;
> > +    qemu_sem_init(&s->postcopy_pause_sem, 0);
> >  
> >      migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
> >  
> > @@ -1942,6 +1947,69 @@ static bool postcopy_should_start(MigrationState *s)
> >  }
> >  
> >  /*
> > + * We don't return until we are in a safe state to continue current
> > + * postcopy migration.  Returns true to continue the migration, or
> > + * false to terminate current migration.
> > + */
> > +static bool postcopy_pause(MigrationState *s)
> > +{
> > +    assert(s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> 
> I never like asserts on the sending side.

Indeed aborting on source side is dangerous (e.g., source may loss
data). However this is definitely a "valid assertion" - if current
state is not "postcopy-active", we should be in a very strange state.
If we just continue to run the latter codes, imho it is as dangerous
as if we assert() here and stop the program. Even, that may be more
dangerous considering that we don't really know what will happen
next...

> 
> > +    migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > +                      MIGRATION_STATUS_POSTCOPY_PAUSED);
> > +
> > +    /* Current channel is possibly broken. Release it. */
> > +    assert(s->to_dst_file);
> > +    qemu_file_shutdown(s->to_dst_file);
> > +    qemu_fclose(s->to_dst_file);
> > +    s->to_dst_file = NULL;
> 
> That does scare me a little; I think it's OK, I'm not sure what happens
> to the ->from_dst_file fd and the return-path processing.

For sockets: I think the QIOChannelSocket.fd will be set to -1 during
close, then the return path code will not be able to read from that
channel any more (it'll get -EIO then as well), and it'll pause as
well. If it was blocking at recvmsg(), it should return with a
failure.

But yes, I think there may have possible indeed risk conditions
between the to/from QEMUFiles considering they are sharing the same
channel... Maybe that is a separate problem of "whether QIO channel
codes are thread safe"? I am not sure of it yet, otherwise we may need
some locking mechanism.

> 
> > +    /*
> > +     * We wait until things fixed up. Then someone will setup the
> > +     * status back for us.
> > +     */
> > +    while (s->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > +        qemu_sem_wait(&s->postcopy_pause_sem);
> > +    }
> 
> Something should get written to stderr prior to this, so when we
> find a migration apparently stuck we can tell why.

Yes I think so.  Thanks,

-- 
Peter Xu
