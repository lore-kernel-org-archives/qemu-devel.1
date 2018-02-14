Received: from eggs.gnu.org ([2001:4830:134:3::10]:39006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eloiV-00030e-9D
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eloiR-0000fi-W2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:30:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eloiR-0000eh-Qw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:30:43 -0500
Date: Wed, 14 Feb 2018 12:30:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180214043030.GG4472@xz-mi>
References: <20180208103132.28452-1-peterx@redhat.com>
	<20180208103132.28452-26-peterx@redhat.com>
	<20180213185650.GR2378@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213185650.GR2378@work-vm>
Subject: Re: [Qemu-devel] [PATCH v6 25/28] qmp/migration: new command
 migrate-recover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Feb 13, 2018 at 06:56:51PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > The first allow-oob=true command.  It's used on destination side when
> > the postcopy migration is paused and ready for a recovery.  After
> > execution, a new migration channel will be established for postcopy to
> > continue.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 26 ++++++++++++++++++++++++++
> >  migration/migration.h |  1 +
> >  migration/savevm.c    |  3 +++
> >  qapi/migration.json   | 20 ++++++++++++++++++++
> >  4 files changed, 50 insertions(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index cf3a3f416c..bb57ed9ade 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1422,6 +1422,32 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
> >      once = false;
> >  }
> >  
> > +void qmp_migrate_recover(const char *uri, Error **errp)
> > +{
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +
> > +    if (mis->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > +        error_setg(errp, "Migrate recover can only be run "
> > +                   "when postcopy is paused.");
> > +        return;
> > +    }
> 
> OK, if it did come back as Paused I don't think it can leave it again
> except this way, so I'm not too worried it being thread safe.
> 
> > +    if (mis->postcopy_recover_triggered) {
> > +        error_setg(errp, "Migrate recovery is triggered already");
> > +        return;
> > +    }
> > +
> > +    /* This will make sure we'll only allow one recover for one pause */
> > +    mis->postcopy_recover_triggered = true;
> 
> However, does that need to be done with a :
>    if (atomic_cmpxchg(mis->postcopy_recovery_triggered, false, true) ==
>        true) {
>       error_setg(errp, "Migrate recovery is triggered already");
>    }
> 
> for the slim chance that someone did this command on the main and the
> oob monitor?

Yes, slim chance, but I agree. :)

I wasn't that strict on this, but I should.  Since we are at it, maybe
I'll also...

> 
> Dave
> 
> > +    /*
> > +     * Note that this call will never start a real migration; it will
> > +     * only re-setup the migration stream and poke existing migration
> > +     * to continue using that newly established channel.
> > +     */
> > +    qemu_start_incoming_migration(uri, errp);
> > +}
> > +
> >  bool migration_is_blocked(Error **errp)
> >  {
> >      if (qemu_savevm_state_blocked(errp)) {
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 88f5614b90..581bf4668b 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -65,6 +65,7 @@ struct MigrationIncomingState {
> >      QemuSemaphore colo_incoming_sem;
> >  
> >      /* notify PAUSED postcopy incoming migrations to try to continue */
> > +    bool postcopy_recover_triggered;
> >      QemuSemaphore postcopy_pause_sem_dst;
> >      QemuSemaphore postcopy_pause_sem_fault;
> >  };
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index d40092a2b6..5f41b062ba 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2182,6 +2182,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
> >      /* Notify the fault thread for the invalidated file handle */
> >      postcopy_fault_thread_notify(mis);
> >  
> > +    /* Clear the triggered bit to allow one recovery */
> > +    mis->postcopy_recover_triggered = false;
> > +

... move this set operation above migrate_set_state() since there can
also be a slim chance too that we may be handling migrate-recover even
before setting up postcopy_recover_triggered=false first.

Thanks,

-- 
Peter Xu
