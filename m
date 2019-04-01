Received: from eggs.gnu.org ([209.51.188.92]:38280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hAx6A-0007SR-L6
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hAx69-0004LX-4v
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:35:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hAx68-0004Ko-Os
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 09:35:37 -0400
Date: Mon, 1 Apr 2019 14:35:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190401133525.GC2606@work-vm>
References: <20190401090827.20793-1-armbru@redhat.com>
	<20190401090827.20793-3-armbru@redhat.com>
	<20190401092748.GB2606@work-vm> <20190401095139.GD3524@redhat.com>
	<87d0m60xng.fsf@dusky.pond.sub.org>
	<20190401114350.GI3524@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190401114350.GI3524@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, kwolf@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, anthony.perard@citrix.com, imammedo@redhat.com

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Mon, Apr 01, 2019 at 01:31:47PM +0200, Markus Armbruster wrote:
> > Daniel P. Berrang=E9 <berrange@redhat.com> writes:
> >=20
> > > On Mon, Apr 01, 2019 at 10:27:49AM +0100, Dr. David Alan Gilbert wr=
ote:
> > >> * Markus Armbruster (armbru@redhat.com) wrote:
> > >> > This reverts commit 3df663e575f1876d7f3bc684f80e72fca0703d39.
> > >> > This reverts commit b605c47b57b58e61a901a50a0762dccf43d94783.
> > >> >=20
> > >> > Command line option --only-migratable is for disallowing any
> > >> > configuration that can block migration.
> > >> >=20
> > >> > Initially, --only-migratable set global variable @only_migratabl=
e.
> > >> >=20
> > >> > Commit 3df663e575 "migration: move only_migratable to MigrationS=
tate"
> > >> > replaced it by MigrationState member @only_migratable.  That was=
 a
> > >> > mistake.
> > >> >=20
> > >> > First, it doesn't make sense on the design level.  MigrationStat=
e
> > >> > captures the state of an individual migration, but --only-migrat=
able
> > >> > isn't a property of an individual migration, it's a restriction =
on
> > >> > QEMU configuration.  With fault tolerance, we could have several
> > >> > migrations at once.  --only-migratable would certainly protect a=
ll of
> > >> > them.  Storing it in MigrationState feels inappropriate.
> > >> >=20
> > >> > Second, it contributes to a dependency cycle that manifests itse=
lf as
> > >> > a bug now.
> > >> >=20
> > >> > Putting @only_migratable into MigrationState means its available=
 only
> > >> > after migration_object_init().
> > >> >=20
> > >> > We can't set it before migration_object_init(), so we delay sett=
ing it
> > >> > with a global property (this is fixup commit b605c47b57 "migrati=
on:
> > >> > fix handling for --only-migratable").
> > >> >=20
> > >> > We can't get it before migration_object_init(), so anything that=
 uses
> > >> > it can only run afterwards.
> > >> >=20
> > >> > Since migrate_add_blocker() needs to obey --only-migratable, any=
 code
> > >> > adding migration blockers can run only afterwards.  This contrib=
utes
> > >> > to the following dependency cycle:
> > >> >=20
> > >> > * configure_blockdev() must run before machine_set_property()
> > >> >   so machine properties can refer to block backends
> > >> >=20
> > >> > * machine_set_property() before configure_accelerator()
> > >> >   so machine properties like kvm-irqchip get applied
> > >> >=20
> > >> > * configure_accelerator() before migration_object_init()
> > >> >   so that Xen's accelerator compat properties get applied.
> > >> >=20
> > >> > * migration_object_init() before configure_blockdev()
> > >> >   so configure_blockdev() can add migration blockers
> > >> >=20
> > >> > The cycle was closed when recent commit cda4aa9a5a0 "Create bloc=
k
> > >> > backends before setting machine properties" added the first
> > >> > dependency, and satisfied it by violating the last one.  Broke b=
lock
> > >> > backends that add migration blockers.
> > >> >=20
> > >> > Moving @only_migratable into MigrationState was a mistake.  Reve=
rt it.
> > >> >=20
> > >> > This doesn't quite break the "migration_object_init() before
> > >> > configure_blockdev() dependency, since migrate_add_blocker() sti=
ll has
> > >> > another dependency on migration_object_init().  To be addressed =
the
> > >> > next commit
> > >> >=20
> > >> > Conflicts:
> > >> > 	include/migration/misc.h
> > >> > 	migration/migration.c
> > >> > 	migration/migration.h
> > >> > 	vl.c
> > >> >=20
> > >> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > >> > ---
> > >> >  include/sysemu/sysemu.h | 1 +
> > >> >  migration/migration.c   | 5 ++---
> > >> >  migration/migration.h   | 3 ---
> > >> >  migration/savevm.c      | 2 +-
> > >> >  vl.c                    | 9 ++-------
> > >> >  5 files changed, 6 insertions(+), 14 deletions(-)
> > >> >=20
> > >> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > >> > index 6065d9e420..5f133cae83 100644
> > >> > --- a/include/sysemu/sysemu.h
> > >> > +++ b/include/sysemu/sysemu.h
> > >> > @@ -14,6 +14,7 @@
> > >> >  /* vl.c */
> > >> > =20
> > >> >  extern const char *bios_name;
> > >> > +extern int only_migratable;
> > >> >  extern const char *qemu_name;
> > >> >  extern QemuUUID qemu_uuid;
> > >> >  extern bool qemu_uuid_set;
> > >> > diff --git a/migration/migration.c b/migration/migration.c
> > >> > index 69f75124c9..f6076e5295 100644
> > >> > --- a/migration/migration.c
> > >> > +++ b/migration/migration.c
> > >> > @@ -1707,7 +1707,7 @@ static GSList *migration_blockers;
> > >> > =20
> > >> >  int migrate_add_blocker(Error *reason, Error **errp)
> > >> >  {
> > >> > -    if (migrate_get_current()->only_migratable) {
> > >> > +    if (only_migratable) {
> > >> >          error_propagate_prepend(errp, error_copy(reason),
> > >> >                                  "disallowing migration blocker =
"
> > >> >                                  "(--only_migratable) for: ");
> > >> > @@ -3337,7 +3337,7 @@ void migration_global_dump(Monitor *mon)
> > >> >      monitor_printf(mon, "store-global-state: %s\n",
> > >> >                     ms->store_global_state ? "on" : "off");
> > >> >      monitor_printf(mon, "only-migratable: %s\n",
> > >> > -                   ms->only_migratable ? "on" : "off");
> > >> > +                   only_migratable ? "on" : "off");
> > >> >      monitor_printf(mon, "send-configuration: %s\n",
> > >> >                     ms->send_configuration ? "on" : "off");
> > >> >      monitor_printf(mon, "send-section-footer: %s\n",
> > >> > @@ -3352,7 +3352,6 @@ void migration_global_dump(Monitor *mon)
> > >> >  static Property migration_properties[] =3D {
> > >> >      DEFINE_PROP_BOOL("store-global-state", MigrationState,
> > >> >                       store_global_state, true),
> > >> > -    DEFINE_PROP_BOOL("only-migratable", MigrationState, only_mi=
gratable, false),
> > >>=20
> > >> So I'm generally OK at this patch, but I'm worried whether this
> > >> is API?
> >=20
> > Uh, forgot to discuss this in my commit message, sorry!
> >=20
> > > IIUC, old code can use either
> > >
> > >   -global migration.only-migratable=3Dtrue
> > >   -only-migratable
> > >
> > > After this patch only
> > >
> > >   -only-migratable
> > >
> > > is valid. So from that POV it is an API break.=20
> > >
> > > From libvirt's POV this is a non-issue as we never use either of th=
ese options.
> > > We did have a BZ filed to support it, but never did.
> > >
> > > To avoid the API break I guess there would been to be a special cas=
e early
> > > loop iterating over argv[] looking for '-global migration.only-migr=
atable=3Dtrue',
> > > making that set the static 'bool only_migratable', instead of letti=
ng it get
> > > handled by the object infra.
> >=20
> > Is this is worth the trouble?
>=20
> Probably not.
>=20
> > -global migration.only-migratable=3Don is entirely undocumented.  The
> > property appears in -device migration,help and device-list-properties=
,
> > but that's all.
> >=20
> > Why would any sane person risk using arcane & undocumented -global
> > migration.only-migratable=3Don instead of the obvious & documented
> > -only-migratable?
>=20
> Given the combination of no known users, current broken impl, and its
> existance not documented, I think there's a reasonable case for just
> removing it.

Yes, agreed - it should be noted though.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
