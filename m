Received: from eggs.gnu.org ([2001:4830:134:3::10]:42350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1elp7o-0007y7-32
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1elp7l-0007Cw-Gp
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:56:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43782 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1elp7l-0007CL-9z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 23:56:53 -0500
Date: Wed, 14 Feb 2018 12:56:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180214045639.GI4472@xz-mi>
References: <20180208103132.28452-1-peterx@redhat.com>
	<20180208103132.28452-28-peterx@redhat.com>
	<20180213201059.GU2378@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213201059.GU2378@work-vm>
Subject: Re: [Qemu-devel] [PATCH v6 27/28] migration/qmp: add command
 migrate-pause
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

On Tue, Feb 13, 2018 at 08:11:00PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > It pauses an ongoing migration.  Currently it only supports postcopy.
> > Note that this command will work on either side of the migration.
> > Basically when we trigger this on one side, it'll interrupt the other
> > side as well since the other side will get notified on the disconnect
> > event.
> > 
> > However, it's still possible that the other side is not notified, for
> > example, when the network is totally broken, or due to some firewall
> > configuration changes.  In that case, we will also need to run the same
> > command on the other side so both sides will go into the paused state.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c | 27 +++++++++++++++++++++++++++
> >  qapi/migration.json   | 16 ++++++++++++++++
> >  2 files changed, 43 insertions(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index bb57ed9ade..139abec0c3 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1448,6 +1448,33 @@ void qmp_migrate_recover(const char *uri, Error **errp)
> >      qemu_start_incoming_migration(uri, errp);
> >  }
> >  
> > +void qmp_migrate_pause(Error **errp)
> > +{
> > +    MigrationState *ms = migrate_get_current();
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    int ret;
> > +
> > +    if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > +        /* Source side, during postcopy */
> > +        ret = qemu_file_shutdown(ms->to_dst_file);
> 
> This doesn't feel thread safe; although I'm not sure how to make it so.
> If the migration finishes just after we check the state but before the
> shutdown we end up using a bogus QEMUFile*
> Making all the places that close a QEMUFile* set hte pointer Null before
> they do the close doesn't help because you still race with that.
> 
> (The race is small, but still)

IMHO we can fix it by adding a migration lock for management code. If
you see my previous migrate cleanup series, it's in my todo. ;)

The basic idea is that we take the lock for critical paths (but not
during most of the migration process).  E.g., we may need the lock
for:

- very beginning of migration, during setup
- reaching the end of migration
- every single migration QMP command (since HMP calls them so HMP will
  also acquire the lock)
- anywhere else I didn't mention that may necessary, e.g., when we
  change migrate state, meanwhile we do something else - basically
  that should be an "atomic operation", and we need the lock to make
  sure of that.

For the recovery series, I would prefer that we ignore this issue for
now - since this problem is there for quite a long time AFAICT in the
whole migration code rather than this series only, and we need to
solve it once and for all.

Thanks,

-- 
Peter Xu
