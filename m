Received: from eggs.gnu.org ([2001:4830:134:3::10]:33771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPemG-0006v8-Ae
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPemD-0003pT-7l
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPemC-0003oa-Vl
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 992D1C04B303
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 00:54:43 +0000 (UTC)
From: "Eduardo Habkost" <ehabkost@redhat.com>
Date: Mon, 26 Jun 2017 21:54:37 -0300
Message-ID: <20170627005437.GK12152@localhost.localdomain>
References: <1498193206-18007-1-git-send-email-peterx@redhat.com>
	<1498193206-18007-5-git-send-email-peterx@redhat.com>
	<20170623221819.GE10776@localhost.localdomain>
	<20170626025035.GH3936@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626025035.GH3936@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v5 04/10] migration: let MigrationState be
 a qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jun 26, 2017 at 10:50:35AM +0800, Peter Xu wrote:
> On Fri, Jun 23, 2017 at 07:18:19PM -0300, Eduardo Habkost wrote:
> > On Fri, Jun 23, 2017 at 12:46:40PM +0800, Peter Xu wrote:
> > > Let the old man "MigrationState" join the object family. Direct benefit
> > > is that we can start to use all the property features derived from
> > > current QDev, like: HW_COMPAT_* bits, command line setup for migration
> > > parameters (so will never need to set them up each time using HMP/QMP,
> > > this is really, really attractive for test writters), etc.
> > > 
> > > I see no reason to disallow this happen yet. So let's start from this
> > > one, to see whether it would be anything good.
> > > 
> > > Now we init the MigrationState struct statically in main() to make sure
> > > it's initialized after global properties are applied, since we'll use
> > > them during creation of the object.
> > > 
> > > No functional change at all.
> > > 
> > > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  include/migration/misc.h |  1 +
> > >  migration/migration.c    | 78 ++++++++++++++++++++++++++++++++++--------------
> > >  migration/migration.h    | 19 ++++++++++++
> > >  vl.c                     |  6 ++++
> > >  4 files changed, 81 insertions(+), 23 deletions(-)
> > > 
> > [...]
> > > diff --git a/vl.c b/vl.c
> > > index cdd2ec8..9b04ba7 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -4596,6 +4596,12 @@ int main(int argc, char **argv, char **envp)
> > >       */
> > >      register_global_properties(current_machine);
> > >  
> > > +    /*
> > > +     * Migration object can only be created after global properties
> > > +     * are applied correctly.
> > > +     */
> > > +    migration_object_init();
> > > +
> > 
> > Do we really need this? Can't be we just do:
> > 
> >     if (!current_migration) {
> >         current_migration = MIGRATION_OBJ(object_new(TYPE_MIGRATION));
> >     }
> > 
> > inside migration_get_current()?
> 
> I did this change on purpose (after AccelClass.global_props is
> introduced). The comment above tried to explain it but looks like it's
> still not clear enough... The reason is that currently the creation of
> migration object is depending on the global properties, so we need to
> create the object after register_global_properties(), while the old
> migrate_get_current() cannot really be sure of this ordering: it just
> creates the object on the first call of the function, but the first
> call can be even before register_global_properties(). If so, we'll
> have a problem (e.g. Xen compat properties will be missing).
> 
> Now this restriction is strictly followed if we create the migrate
> object here. If anyone calls migrate_get_current() before
> register_global_properties(), there will be an assert, and that should
> be treated as a programming error.

Makes sense to me.  Thanks!

-- 
Eduardo
