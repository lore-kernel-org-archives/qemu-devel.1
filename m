Received: from eggs.gnu.org ([209.51.188.92]:50357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAtbY-0002Av-QI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAtbX-0002ke-7Q
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:51:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hAtbW-0002kG-Rl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:51:47 -0400
Date: Mon, 1 Apr 2019 10:51:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190401095139.GD3524@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190401090827.20793-1-armbru@redhat.com>
	<20190401090827.20793-3-armbru@redhat.com>
	<20190401092748.GB2606@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401092748.GB2606@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, anthony.perard@citrix.com, imammedo@redhat.com

On Mon, Apr 01, 2019 at 10:27:49AM +0100, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
> > This reverts commit 3df663e575f1876d7f3bc684f80e72fca0703d39.
> > This reverts commit b605c47b57b58e61a901a50a0762dccf43d94783.
> > 
> > Command line option --only-migratable is for disallowing any
> > configuration that can block migration.
> > 
> > Initially, --only-migratable set global variable @only_migratable.
> > 
> > Commit 3df663e575 "migration: move only_migratable to MigrationState"
> > replaced it by MigrationState member @only_migratable.  That was a
> > mistake.
> > 
> > First, it doesn't make sense on the design level.  MigrationState
> > captures the state of an individual migration, but --only-migratable
> > isn't a property of an individual migration, it's a restriction on
> > QEMU configuration.  With fault tolerance, we could have several
> > migrations at once.  --only-migratable would certainly protect all of
> > them.  Storing it in MigrationState feels inappropriate.
> > 
> > Second, it contributes to a dependency cycle that manifests itself as
> > a bug now.
> > 
> > Putting @only_migratable into MigrationState means its available only
> > after migration_object_init().
> > 
> > We can't set it before migration_object_init(), so we delay setting it
> > with a global property (this is fixup commit b605c47b57 "migration:
> > fix handling for --only-migratable").
> > 
> > We can't get it before migration_object_init(), so anything that uses
> > it can only run afterwards.
> > 
> > Since migrate_add_blocker() needs to obey --only-migratable, any code
> > adding migration blockers can run only afterwards.  This contributes
> > to the following dependency cycle:
> > 
> > * configure_blockdev() must run before machine_set_property()
> >   so machine properties can refer to block backends
> > 
> > * machine_set_property() before configure_accelerator()
> >   so machine properties like kvm-irqchip get applied
> > 
> > * configure_accelerator() before migration_object_init()
> >   so that Xen's accelerator compat properties get applied.
> > 
> > * migration_object_init() before configure_blockdev()
> >   so configure_blockdev() can add migration blockers
> > 
> > The cycle was closed when recent commit cda4aa9a5a0 "Create block
> > backends before setting machine properties" added the first
> > dependency, and satisfied it by violating the last one.  Broke block
> > backends that add migration blockers.
> > 
> > Moving @only_migratable into MigrationState was a mistake.  Revert it.
> > 
> > This doesn't quite break the "migration_object_init() before
> > configure_blockdev() dependency, since migrate_add_blocker() still has
> > another dependency on migration_object_init().  To be addressed the
> > next commit
> > 
> > Conflicts:
> > 	include/migration/misc.h
> > 	migration/migration.c
> > 	migration/migration.h
> > 	vl.c
> > 
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  include/sysemu/sysemu.h | 1 +
> >  migration/migration.c   | 5 ++---
> >  migration/migration.h   | 3 ---
> >  migration/savevm.c      | 2 +-
> >  vl.c                    | 9 ++-------
> >  5 files changed, 6 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index 6065d9e420..5f133cae83 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -14,6 +14,7 @@
> >  /* vl.c */
> >  
> >  extern const char *bios_name;
> > +extern int only_migratable;
> >  extern const char *qemu_name;
> >  extern QemuUUID qemu_uuid;
> >  extern bool qemu_uuid_set;
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 69f75124c9..f6076e5295 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1707,7 +1707,7 @@ static GSList *migration_blockers;
> >  
> >  int migrate_add_blocker(Error *reason, Error **errp)
> >  {
> > -    if (migrate_get_current()->only_migratable) {
> > +    if (only_migratable) {
> >          error_propagate_prepend(errp, error_copy(reason),
> >                                  "disallowing migration blocker "
> >                                  "(--only_migratable) for: ");
> > @@ -3337,7 +3337,7 @@ void migration_global_dump(Monitor *mon)
> >      monitor_printf(mon, "store-global-state: %s\n",
> >                     ms->store_global_state ? "on" : "off");
> >      monitor_printf(mon, "only-migratable: %s\n",
> > -                   ms->only_migratable ? "on" : "off");
> > +                   only_migratable ? "on" : "off");
> >      monitor_printf(mon, "send-configuration: %s\n",
> >                     ms->send_configuration ? "on" : "off");
> >      monitor_printf(mon, "send-section-footer: %s\n",
> > @@ -3352,7 +3352,6 @@ void migration_global_dump(Monitor *mon)
> >  static Property migration_properties[] = {
> >      DEFINE_PROP_BOOL("store-global-state", MigrationState,
> >                       store_global_state, true),
> > -    DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migratable, false),
> 
> So I'm generally OK at this patch, but I'm worried whether this
> is API?

IIUC, old code can use either

  -global migration.only-migratable=true
  -only-migratable

After this patch only

  -only-migratable

is valid. So from that POV it is an API break. 

>From libvirt's POV this is a non-issue as we never use either of these options.
We did have a BZ filed to support it, but never did.

To avoid the API break I guess there would been to be a special case early
loop iterating over argv[] looking for '-global migration.only-migratable=true',
making that set the static 'bool only_migratable', instead of letting it get
handled by the object infra.


> >      DEFINE_PROP_BOOL("send-configuration", MigrationState,
> >                       send_configuration, true),
> >      DEFINE_PROP_BOOL("send-section-footer", MigrationState,
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 0f986935e1..438f17edad 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -219,9 +219,6 @@ struct MigrationState
> >       */
> >      bool store_global_state;
> >  
> > -    /* Whether the VM is only allowing for migratable devices */
> > -    bool only_migratable;
> > -
> >      /* Whether we send QEMU_VM_CONFIGURATION during migration */
> >      bool send_configuration;
> >      /* Whether we send section footer during migration */
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 1415001d1c..34bcad3807 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2844,7 +2844,7 @@ void vmstate_register_ram_global(MemoryRegion *mr)
> >  bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
> >  {
> >      /* check needed if --only-migratable is specified */
> > -    if (!migrate_get_current()->only_migratable) {
> > +    if (!only_migratable) {
> >          return true;
> >      }
> >  
> > diff --git a/vl.c b/vl.c
> > index c1d5484e12..e4d7ad6b85 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -185,6 +185,7 @@ const char *prom_envs[MAX_PROM_ENVS];
> >  int boot_menu;
> >  bool boot_strict;
> >  uint8_t *boot_splash_filedata;
> > +int only_migratable; /* turn it off unless user states otherwise */
> >  bool wakeup_suspend_enabled;
> >  
> >  int icount_align_option;
> > @@ -3799,13 +3800,7 @@ int main(int argc, char **argv, char **envp)
> >                  incoming = optarg;
> >                  break;
> >              case QEMU_OPTION_only_migratable:
> > -                /*
> > -                 * TODO: we can remove this option one day, and we
> > -                 * should all use:
> > -                 *
> > -                 * "-global migration.only-migratable=true"
> > -                 */
> > -                qemu_global_option("migration.only-migratable=true");
> > +                only_migratable = 1;
> >                  break;
> >              case QEMU_OPTION_nodefaults:
> >                  has_defaults = 0;
> > -- 
> > 2.17.2
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
