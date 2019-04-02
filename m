Received: from eggs.gnu.org ([209.51.188.92]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBIHz-0002S7-3J
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBIHy-00008v-0I
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:13:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hBIHx-00005t-Li
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:13:13 -0400
Date: Tue, 2 Apr 2019 13:03:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190402120350.GA2861@work-vm>
References: <20190401090827.20793-1-armbru@redhat.com>
	<20190401090827.20793-3-armbru@redhat.com>
	<20190402125241.14c84d67@redhat.com>
	<87lg0sd3tt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg0sd3tt.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] Revert "migration: move
 only_migratable to MigrationState"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, kwolf@redhat.com, quintela@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org, anthony.perard@citrix.com

* Markus Armbruster (armbru@redhat.com) wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Mon,  1 Apr 2019 11:08:24 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> >> This reverts commit 3df663e575f1876d7f3bc684f80e72fca0703d39.
> >> This reverts commit b605c47b57b58e61a901a50a0762dccf43d94783.
> >> 
> >> Command line option --only-migratable is for disallowing any
> >> configuration that can block migration.
> >> 
> >> Initially, --only-migratable set global variable @only_migratable.
> >> 
> >> Commit 3df663e575 "migration: move only_migratable to MigrationState"
> >> replaced it by MigrationState member @only_migratable.  That was a
> >> mistake.
> >> 
> >> First, it doesn't make sense on the design level.  MigrationState
> >> captures the state of an individual migration, but --only-migratable
> >> isn't a property of an individual migration, it's a restriction on
> >> QEMU configuration.  With fault tolerance, we could have several
> >> migrations at once.  --only-migratable would certainly protect all of
> >> them.  Storing it in MigrationState feels inappropriate.
> >> 
> >> Second, it contributes to a dependency cycle that manifests itself as
> >> a bug now.
> >> 
> >> Putting @only_migratable into MigrationState means its available only
> >> after migration_object_init().
> >> 
> >> We can't set it before migration_object_init(), so we delay setting it
> >> with a global property (this is fixup commit b605c47b57 "migration:
> >> fix handling for --only-migratable").
> >> 
> >> We can't get it before migration_object_init(), so anything that uses
> >> it can only run afterwards.
> >> 
> >> Since migrate_add_blocker() needs to obey --only-migratable, any code
> >> adding migration blockers can run only afterwards.  This contributes
> >> to the following dependency cycle:
> >> 
> >> * configure_blockdev() must run before machine_set_property()
> >>   so machine properties can refer to block backends
> >> 
> >> * machine_set_property() before configure_accelerator()
> >>   so machine properties like kvm-irqchip get applied
> >> 
> >> * configure_accelerator() before migration_object_init()
> >>   so that Xen's accelerator compat properties get applied.
> >> 
> >> * migration_object_init() before configure_blockdev()
> >>   so configure_blockdev() can add migration blockers
> >> 
> >> The cycle was closed when recent commit cda4aa9a5a0 "Create block
> >> backends before setting machine properties" added the first
> >> dependency, and satisfied it by violating the last one.  Broke block
> >> backends that add migration blockers.
> >> 
> >> Moving @only_migratable into MigrationState was a mistake.  Revert it.
> >> 
> >> This doesn't quite break the "migration_object_init() before
> >> configure_blockdev() dependency, since migrate_add_blocker() still has
> >> another dependency on migration_object_init().  To be addressed the
> >> next commit
> >> 
> >> Conflicts:
> >> 	include/migration/misc.h
> >> 	migration/migration.c
> >> 	migration/migration.h
> >> 	vl.c
> >> 
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > with commit message amended like mentioned by David
> > (wrt removed "only-migratable" property)
> 
> Inserting right before the "Conflicts:" line:
> 
>     Note that the reverted commit made -only-migratable sugar for -global
>     migration.only-migratable=on below the hood.  Documentation has only
>     ever mentioned -only-migratable.  This commit removes the arcane &
>     undocumented alternative to -only-migratable again.  Nobody should be
>     using it.

Yes, that's fine:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> Thanks!
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
