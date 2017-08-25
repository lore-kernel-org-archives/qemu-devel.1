Received: from eggs.gnu.org ([2001:4830:134:3::10]:47129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlB1G-0002JQ-MT
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlB1B-0001s4-Q2
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dlB1B-0001r1-Gw
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:35:09 -0400
Date: Fri, 25 Aug 2017 10:34:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170825093455.GD2090@work-vm>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-9-git-send-email-peterx@redhat.com>
	<20170823180135.GI2648@work-vm>
	<20170825054928.GH14174@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825054928.GH14174@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 8/8] migration: add incoming mgmt lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Aug 23, 2017 at 07:01:35PM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > Now at least migrate_incoming can be run in parallel.  Let's provide a
> > > migration lock to protect it.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/migration.c | 6 ++++++
> > >  migration/migration.h | 3 +++
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index c3fe0ed..32058f7 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -145,6 +145,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
> > >          mis_current.state = MIGRATION_STATUS_NONE;
> > >          memset(&mis_current, 0, sizeof(MigrationIncomingState));
> > >          qemu_mutex_init(&mis_current.rp_mutex);
> > > +        qemu_mutex_init(&mis_current.mgmt_mutex);
> > >          qemu_event_init(&mis_current.main_thread_load_event, false);
> > >          once = true;
> > >      }
> > > @@ -1171,6 +1172,7 @@ void qmp_migrate_incoming(const char *uri, Error **errp)
> > >  {
> > >      Error *local_err = NULL;
> > >      static bool once = true;
> > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > 
> > migration_incoming_get_current isn't actually thread-safe itself unless
> > you can guarantee the initial allocation has happened - otherwise both
> > threads can race and do the 'once' code at the same time.
> 
> How about I init the incoming object as well in
> migration_object_init()?

Yes I think that might work.

> > 
> > Similarly, these locks - they don't protect our 'once' - so a second
> > thread could come in here and both get past the !once check.
> 
> Oh I missed this one since actually I am removing that "once" variable
> in postcopy recovery series. :)
> 
> I can put the last two patches into postcopy recovery series, then
> it'll be fine.

OK; these thigns just emphasise how hard it is to make a function really
lock free.

Dave

> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
