Received: from eggs.gnu.org ([2001:4830:134:3::10]:55438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evfhW-0005la-2H
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evfhR-0002KE-3c
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:54:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evfhQ-0002J9-Tw
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 04:54:25 -0400
Date: Tue, 13 Mar 2018 16:54:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180313085404.GH11787@xz-mi>
References: <20180309091535.13315-1-peterx@redhat.com>
	<20180309091535.13315-23-peterx@redhat.com>
	<20180312173609.GV3219@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312173609.GV3219@work-vm>
Subject: Re: [Qemu-devel] [PATCH v7 22/23] migration/qmp: add command
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
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>

On Mon, Mar 12, 2018 at 05:36:09PM +0000, Dr. David Alan Gilbert wrote:
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
> > index 180552329c..f31fcbb0d5 100644
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
> How did this fix the race I mentioned last time?

Ah sorry I missed that one.  I'll reply there.

-- 
Peter Xu
