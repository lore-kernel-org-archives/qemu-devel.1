Received: from eggs.gnu.org ([209.51.188.92]:42955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAvM8-00086q-Pc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAvM7-0002NC-93
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:44:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hAvM6-0002Mi-Uu
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 07:43:59 -0400
Date: Mon, 1 Apr 2019 12:43:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190401114350.GI3524@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190401090827.20793-1-armbru@redhat.com>
	<20190401090827.20793-3-armbru@redhat.com>
	<20190401092748.GB2606@work-vm> <20190401095139.GD3524@redhat.com>
	<87d0m60xng.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d0m60xng.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kwolf@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, anthony.perard@citrix.com, imammedo@redhat.com

On Mon, Apr 01, 2019 at 01:31:47PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Mon, Apr 01, 2019 at 10:27:49AM +0100, Dr. David Alan Gilbert wrot=
e:
> >> * Markus Armbruster (armbru@redhat.com) wrote:
> >> > This reverts commit 3df663e575f1876d7f3bc684f80e72fca0703d39.
> >> > This reverts commit b605c47b57b58e61a901a50a0762dccf43d94783.
> >> >=20
> >> > Command line option --only-migratable is for disallowing any
> >> > configuration that can block migration.
> >> >=20
> >> > Initially, --only-migratable set global variable @only_migratable.
> >> >=20
> >> > Commit 3df663e575 "migration: move only_migratable to MigrationSta=
te"
> >> > replaced it by MigrationState member @only_migratable.  That was a
> >> > mistake.
> >> >=20
> >> > First, it doesn't make sense on the design level.  MigrationState
> >> > captures the state of an individual migration, but --only-migratab=
le
> >> > isn't a property of an individual migration, it's a restriction on
> >> > QEMU configuration.  With fault tolerance, we could have several
> >> > migrations at once.  --only-migratable would certainly protect all=
 of
> >> > them.  Storing it in MigrationState feels inappropriate.
> >> >=20
> >> > Second, it contributes to a dependency cycle that manifests itself=
 as
> >> > a bug now.
> >> >=20
> >> > Putting @only_migratable into MigrationState means its available o=
nly
> >> > after migration_object_init().
> >> >=20
> >> > We can't set it before migration_object_init(), so we delay settin=
g it
> >> > with a global property (this is fixup commit b605c47b57 "migration=
:
> >> > fix handling for --only-migratable").
> >> >=20
> >> > We can't get it before migration_object_init(), so anything that u=
ses
> >> > it can only run afterwards.
> >> >=20
> >> > Since migrate_add_blocker() needs to obey --only-migratable, any c=
ode
> >> > adding migration blockers can run only afterwards.  This contribut=
es
> >> > to the following dependency cycle:
> >> >=20
> >> > * configure_blockdev() must run before machine_set_property()
> >> >   so machine properties can refer to block backends
> >> >=20
> >> > * machine_set_property() before configure_accelerator()
> >> >   so machine properties like kvm-irqchip get applied
> >> >=20
> >> > * configure_accelerator() before migration_object_init()
> >> >   so that Xen's accelerator compat properties get applied.
> >> >=20
> >> > * migration_object_init() before configure_blockdev()
> >> >   so configure_blockdev() can add migration blockers
> >> >=20
> >> > The cycle was closed when recent commit cda4aa9a5a0 "Create block
> >> > backends before setting machine properties" added the first
> >> > dependency, and satisfied it by violating the last one.  Broke blo=
ck
> >> > backends that add migration blockers.
> >> >=20
> >> > Moving @only_migratable into MigrationState was a mistake.  Revert=
 it.
> >> >=20
> >> > This doesn't quite break the "migration_object_init() before
> >> > configure_blockdev() dependency, since migrate_add_blocker() still=
 has
> >> > another dependency on migration_object_init().  To be addressed th=
e
> >> > next commit
> >> >=20
> >> > Conflicts:
> >> > 	include/migration/misc.h
> >> > 	migration/migration.c
> >> > 	migration/migration.h
> >> > 	vl.c
> >> >=20
> >> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> > ---
> >> >  include/sysemu/sysemu.h | 1 +
> >> >  migration/migration.c   | 5 ++---
> >> >  migration/migration.h   | 3 ---
> >> >  migration/savevm.c      | 2 +-
> >> >  vl.c                    | 9 ++-------
> >> >  5 files changed, 6 insertions(+), 14 deletions(-)
> >> >=20
> >> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> >> > index 6065d9e420..5f133cae83 100644
> >> > --- a/include/sysemu/sysemu.h
> >> > +++ b/include/sysemu/sysemu.h
> >> > @@ -14,6 +14,7 @@
> >> >  /* vl.c */
> >> > =20
> >> >  extern const char *bios_name;
> >> > +extern int only_migratable;
> >> >  extern const char *qemu_name;
> >> >  extern QemuUUID qemu_uuid;
> >> >  extern bool qemu_uuid_set;
> >> > diff --git a/migration/migration.c b/migration/migration.c
> >> > index 69f75124c9..f6076e5295 100644
> >> > --- a/migration/migration.c
> >> > +++ b/migration/migration.c
> >> > @@ -1707,7 +1707,7 @@ static GSList *migration_blockers;
> >> > =20
> >> >  int migrate_add_blocker(Error *reason, Error **errp)
> >> >  {
> >> > -    if (migrate_get_current()->only_migratable) {
> >> > +    if (only_migratable) {
> >> >          error_propagate_prepend(errp, error_copy(reason),
> >> >                                  "disallowing migration blocker "
> >> >                                  "(--only_migratable) for: ");
> >> > @@ -3337,7 +3337,7 @@ void migration_global_dump(Monitor *mon)
> >> >      monitor_printf(mon, "store-global-state: %s\n",
> >> >                     ms->store_global_state ? "on" : "off");
> >> >      monitor_printf(mon, "only-migratable: %s\n",
> >> > -                   ms->only_migratable ? "on" : "off");
> >> > +                   only_migratable ? "on" : "off");
> >> >      monitor_printf(mon, "send-configuration: %s\n",
> >> >                     ms->send_configuration ? "on" : "off");
> >> >      monitor_printf(mon, "send-section-footer: %s\n",
> >> > @@ -3352,7 +3352,6 @@ void migration_global_dump(Monitor *mon)
> >> >  static Property migration_properties[] =3D {
> >> >      DEFINE_PROP_BOOL("store-global-state", MigrationState,
> >> >                       store_global_state, true),
> >> > -    DEFINE_PROP_BOOL("only-migratable", MigrationState, only_migr=
atable, false),
> >>=20
> >> So I'm generally OK at this patch, but I'm worried whether this
> >> is API?
>=20
> Uh, forgot to discuss this in my commit message, sorry!
>=20
> > IIUC, old code can use either
> >
> >   -global migration.only-migratable=3Dtrue
> >   -only-migratable
> >
> > After this patch only
> >
> >   -only-migratable
> >
> > is valid. So from that POV it is an API break.=20
> >
> > From libvirt's POV this is a non-issue as we never use either of thes=
e options.
> > We did have a BZ filed to support it, but never did.
> >
> > To avoid the API break I guess there would been to be a special case =
early
> > loop iterating over argv[] looking for '-global migration.only-migrat=
able=3Dtrue',
> > making that set the static 'bool only_migratable', instead of letting=
 it get
> > handled by the object infra.
>=20
> Is this is worth the trouble?

Probably not.

> -global migration.only-migratable=3Don is entirely undocumented.  The
> property appears in -device migration,help and device-list-properties,
> but that's all.
>=20
> Why would any sane person risk using arcane & undocumented -global
> migration.only-migratable=3Don instead of the obvious & documented
> -only-migratable?

Given the combination of no known users, current broken impl, and its
existance not documented, I think there's a reasonable case for just
removing it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
