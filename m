Received: from eggs.gnu.org ([2001:4830:134:3::10]:51350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eltdl-0004MX-6o
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eltdh-0001vx-9Q
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:46:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eltdh-0001vT-34
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 04:46:09 -0500
Date: Wed, 14 Feb 2018 09:45:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180214094550.GA2507@work-vm>
References: <151801810352.29167.4832480228518630626.stgit@bahia.lan>
	<20180207155500.GO2665@work-vm> <20180214104431.294a5280@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214104431.294a5280@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] migration: improve documentation of
 postcopy-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Greg Kurz (groug@kaod.org) wrote:
> On Wed, 7 Feb 2018 15:55:01 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Greg Kurz (groug@kaod.org) wrote:
> > > This capability must have the same value on both source and destination,
> > > otherwise migration fails (commit 875fcd013ab6 "migration: incoming
> > > postcopy advise sanity checks").
> > > 
> > > Let's write it down in various places where postcopy-ram is documented.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>  
> > 
> > Thanks,
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > 
> 
> Who should pick this up ?

I was going to pick it up in a migration pull today.

Dave

> > > ---
> > >  docs/devel/migration.rst |    4 ++--
> > >  hmp-commands.hx          |    3 ++-
> > >  qapi/migration.json      |   10 ++++++----
> > >  3 files changed, 10 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> > > index bf97080dac2f..9d1b7657f0cf 100644
> > > --- a/docs/devel/migration.rst
> > > +++ b/docs/devel/migration.rst
> > > @@ -387,8 +387,8 @@ doesn't finish in a given time the switch is made to postcopy.
> > >  Enabling postcopy
> > >  -----------------
> > >  
> > > -To enable postcopy, issue this command on the monitor prior to the
> > > -start of migration:
> > > +To enable postcopy, issue this command on the monitor (both source and
> > > +destination) prior to the start of migration:
> > >  
> > >  ``migrate_set_capability postcopy-ram on``
> > >  
> > > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > > index 15620c94d3fc..d26eb4119b9d 100644
> > > --- a/hmp-commands.hx
> > > +++ b/hmp-commands.hx
> > > @@ -1041,7 +1041,8 @@ ETEXI
> > >          .params     = "",
> > >          .help       = "Followup to a migration command to switch the migration"
> > >                        " to postcopy mode. The postcopy-ram capability must "
> > > -                      "be set before the original migration command.",
> > > +                      "be set on both source and destination before the "
> > > +                      "original migration command .",
> > >          .cmd        = hmp_migrate_start_postcopy,
> > >      },
> > >  
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index 4cd3d1315884..7f465a1902ce 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -327,8 +327,10 @@
> > >  #          to speed up convergence of RAM migration. (since 1.6)
> > >  #
> > >  # @postcopy-ram: Start executing on the migration target before all of RAM has
> > > -#          been migrated, pulling the remaining pages along as needed. NOTE: If
> > > -#          the migration fails during postcopy the VM will fail.  (since 2.6)
> > > +#          been migrated, pulling the remaining pages along as needed. The
> > > +#          capacity must have the same setting on both source and target
> > > +#          or migration will not even start. NOTE: If the migration fails during
> > > +#          postcopy the VM will fail.  (since 2.6)
> > >  #
> > >  # @x-colo: If enabled, migration will never end, and the state of the VM on the
> > >  #        primary side will be migrated continuously to the VM on secondary
> > > @@ -742,8 +744,8 @@
> > >  # @migrate-start-postcopy:
> > >  #
> > >  # Followup to a migration command to switch the migration to postcopy mode.
> > > -# The postcopy-ram capability must be set before the original migration
> > > -# command.
> > > +# The postcopy-ram capability must be set on both source and destination
> > > +# before the original migration command.
> > >  #
> > >  # Since: 2.5
> > >  #
> > >   
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
