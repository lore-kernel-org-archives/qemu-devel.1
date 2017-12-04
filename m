Received: from eggs.gnu.org ([2001:4830:134:3::10]:38218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eLuGP-0003ew-Vq
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eLuGL-0005EK-V0
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:10:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eLuGL-0005Dh-Lk
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:10:37 -0500
Date: Mon, 4 Dec 2017 17:10:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171204171028.GG2420@work-vm>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-32-peterx@redhat.com>
	<20171201165327.GB2318@work-vm> <20171204044813.GD7916@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171204044813.GD7916@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v4 31/32] migration,
 qmp: new command "migrate-pause"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Dec 01, 2017 at 04:53:28PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > It is used to manually trigger the postcopy pause state.  It works just
> > > like when we found the migration stream failed during postcopy, but
> > > provide an explicit way for user in case of misterious socket hangs.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > Can we change the name to something like 'migrate-disconnect' - pause
> > is a bit easy to confuse with other things and this is really more
> > an explicit network disconnect (Is it worth just making it a flag to
> > migrate-cancel?)
> 
> Then I would prefer to reuse the migrate_cancel command.  
> 
> Actually this reminded me about what would happen now if someone on
> src VM sends a "migrate_cancel" during postcopy active.  It should
> crash the VM, right?
> 
> Considering above, I'm thinking whether we should just make it a
> default behavior that when do migrate_cancel during postcopy-active we
> just do a pause instead of real cancel. After all it cannot re-start
> the VM any more on source, so IMHO a real cancel does not mean much
> here.  More importantly, what if someone wants to manually trigger
> this pause but accidentally forgot to type that new flag (say,
> -D[isconnect])?  It'll crash the VM directly.
> 
> What do you think?

Yes, that's OK, just be careful about race conditions between the
states,  for example what happens if you do a cancel and you enter
migrate_fd_cancel in postcopy-active, but before you can actually
cancel you end up completing, or the opposite where you do a
migrate-start-postcopy almost immediately before migrade-cancel;
do you get to cancel in teh active or postcopy-active state?


> 
> > 
> > 
> > > ---
> > >  migration/migration.c | 18 ++++++++++++++++++
> > >  qapi/migration.json   | 22 ++++++++++++++++++++++
> > >  2 files changed, 40 insertions(+)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 536a771803..30348a5e27 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -1485,6 +1485,24 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
> > >      once = false;
> > >  }
> > >  
> > > +void qmp_migrate_pause(Error **errp)
> > > +{
> > > +    int ret;
> > > +    MigrationState *ms = migrate_get_current();
> > > +
> > > +    if (ms->state != MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > > +        error_setg(errp, "Migration pause is currently only allowed during"
> > > +                   " an active postcopy phase.");
> > > +        return;
> > > +    }
> > > +
> > > +    ret = qemu_file_shutdown(ms->to_dst_file);
> > > +
> > > +    if (ret) {
> > > +        error_setg(errp, "Failed to pause migration stream.");
> > > +    }
> > > +}
> > > +
> > >  bool migration_is_blocked(Error **errp)
> > >  {
> > >      if (qemu_savevm_state_blocked(errp)) {
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 4a3eff62f1..52901f7e2e 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -1074,6 +1074,28 @@
> > >  { 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
> > >  
> > >  ##
> > > +# @migrate-pause:
> > > +#
> > > +# Pause an migration.  Currently it can only pause a postcopy
> > > +# migration.  Pausing a precopy migration is not supported yet.
> > > +#
> > > +# It is mostly used as a manual way to trigger the postcopy paused
> > > +# state when the network sockets hang due to some reason, so that we
> > > +# can try a recovery afterward.
> > 
> > Can we say this explicitly;
> > 'Force closes the migration connection to trigger the postcopy paused
> >  state when the network sockets hang due to some reason, so that we
> > can try a recovery afterwards'
> 
> Sure!  I'll just see where I should properly put these sentences.

Thanks.

Dave

> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
