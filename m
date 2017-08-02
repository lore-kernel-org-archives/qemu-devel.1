Received: from eggs.gnu.org ([2001:4830:134:3::10]:35659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcusU-0006tV-MG
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcusT-0008H5-30
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:44:02 -0400
Date: Wed, 2 Aug 2017 15:43:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802144352.GD10101@stefanha-x1.localdomain>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-5-el13635@mail.ntua.gr>
	<20170801154703.GD22017@stefanha-x1.localdomain>
	<20170801164933.c54ocjzr26sxaizy@postretch>
	<20170802103922.GE5531@stefanha-x1.localdomain>
	<20170802105704.m2jbxnivl32msbx6@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <20170802105704.m2jbxnivl32msbx6@postretch>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 01:57:04PM +0300, Manos Pitsidianakis wrote:
> On Wed, Aug 02, 2017 at 11:39:22AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Aug 01, 2017 at 07:49:33PM +0300, Manos Pitsidianakis wrote:
> > > On Tue, Aug 01, 2017 at 04:47:03PM +0100, Stefan Hajnoczi wrote:
> > > > On Mon, Jul 31, 2017 at 12:54:40PM +0300, Manos Pitsidianakis wrote:
> > > > > ThrottleGroup is converted to an object. This will allow the futu=
re
> > > > > throttle block filter drive easy creation and configuration of th=
rottle
> > > > > groups in QMP and cli.
> > > > >
> > > > > A new QAPI struct, ThrottleLimits, is introduced to provide a sha=
red
> > > > > struct for all throttle configuration needs in QMP.
> > > > >
> > > > > ThrottleGroups can be created via CLI as
> > > > >     -object throttle-group,id=3Dfoo,x-iops-total=3D100,x-..
> > > > > where x-* are individual limit properties. Since we can't add non=
-scalar
> > > > > properties in -object this interface must be used instead. Howeve=
r,
> > > > > setting these properties must be disabled after initialization be=
cause
> > > > > certain combinations of limits are forbidden and thus configurati=
on
> > > > > changes should be done in one transaction. The individual propert=
ies
> > > > > will go away when support for non-scalar values in CLI is impleme=
nted
> > > > > and thus are marked as experimental.
> > > > >
> > > > > ThrottleGroup also has a `limits` property that uses the Throttle=
Limits
> > > > > struct.  It can be used to create ThrottleGroups or set the
> > > > > configuration in existing groups as follows:
> > > > >
> > > > > { "execute": "object-add",
> > > > >   "arguments": {
> > > > >     "qom-type": "throttle-group",
> > > > >     "id": "foo",
> > > > >     "props" : {
> > > > >       "limits": {
> > > > >           "iops-total": 100
> > > > >       }
> > > > >     }
> > > > >   }
> > > > > }
> > > > > { "execute" : "qom-set",
> > > > >     "arguments" : {
> > > > >         "path" : "foo",
> > > > >         "property" : "limits",
> > > > >         "value" : {
> > > > >             "iops-total" : 99
> > > > >         }
> > > > >     }
> > > > > }
> > > > >
> > > > > This also means a group's configuration can be fetched with qom-g=
et.
> > > > >
> > > > > ThrottleGroups can be anonymous which means they can't get access=
ed by
> > > > > other users ie they will always be units instead of group (Becaus=
e they
> > > > > have one ThrottleGroupMember).
> > > >
> > > > blockdev.c automatically assigns -drive id=3D to the group name if
> > > > throttling.group=3D wasn't given.  So who will use anonymous single=
-drive
> > > > mode?
> > >=20
> > > Manual filter nodes. It's possible to not pass a group name value and=
 the
> > > resulting group will be anonymous. Are you suggesting to move this ch=
ange to
> > > the throttle filter patch?
> >=20
> > What is the use case?  Human users will stick to the legacy syntax
> > because it's convenient.  Management tools will use the filter
> > explicitly in the future, and it's easy for them to choose a name.
> >=20
> > Unless there is a need for this case I'd prefer to make the group name
> > mandatory.  That way there are less code paths to worry about.
>=20
> I think Kevin requested this though I don't really remember the use case.

Kevin: Do you still want this?

> >=20
> > > > > @@ -87,32 +99,30 @@ ThrottleState *throttle_group_incref(const ch=
ar *name)
> > > > >
> > > > >      qemu_mutex_lock(&throttle_groups_lock);
> > > > >
> > > > > -    /* Look for an existing group with that name */
> > > > > -    QTAILQ_FOREACH(iter, &throttle_groups, list) {
> > > > > -        if (!strcmp(name, iter->name)) {
> > > > > -            tg =3D iter;
> > > > > -            break;
> > > > > +    if (name) {
> > > > > +        /* Look for an existing group with that name */
> > > > > +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
> > > > > +            if (!g_strcmp0(name, iter->name)) {
> > > > > +                tg =3D iter;
> > > > > +                break;
> > > > > +            }
> > > > >          }
> > > > >      }
> > > > >
> > > > >      /* Create a new one if not found */
> > > > >      if (!tg) {
> > > > > -        tg =3D g_new0(ThrottleGroup, 1);
> > > > > +        /* new ThrottleGroup obj will have a refcnt =3D 1 */
> > > > > +        tg =3D THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
> > > > >          tg->name =3D g_strdup(name);
> > > > > -        tg->clock_type =3D QEMU_CLOCK_REALTIME;
> > > > > -
> > > > > -        if (qtest_enabled()) {
> > > > > -            /* For testing block IO throttling only */
> > > > > -            tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
> > > > > -        }
> > > > > -        qemu_mutex_init(&tg->lock);
> > > > > -        throttle_init(&tg->ts);
> > > > > -        QLIST_INIT(&tg->head);
> > > > > -
> > > > > -        QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
> > > > > +        throttle_group_obj_complete((UserCreatable *)tg, &error_=
abort);
> > > > >      }
> > > > >
> > > > > -    tg->refcount++;
> > > > > +    qemu_mutex_lock(&tg->lock);
> > > > > +    if (!QLIST_EMPTY(&tg->head)) {
> > > > > +        /* only ref if the group is not empty */
> > > > > +        object_ref(OBJECT(tg));
> > > > > +    }
> > > > > +    qemu_mutex_unlock(&tg->lock);
> > > >
> > > > How do the refcounts work in various cases (legacy -drive
> > > > throttling.group and -object throttle-group with 0, 1, or multiple
> > > > drives)?
> > > >
> > > > It's not obvious to me that this code works in all cases.
> > >=20
> > > Object is created with object_new(): ref count is 1
> > > Each time we call throttle_group_incref() to add a new member to the =
group,
> > > we increase the ref count by 1. We skip the first time we do that bec=
ause
> > > there's already a reference. When all members are removed, object is
> > > deleted.
> >=20
> > If the ThrottleGroup was created with -object throttle-group it
> > shouldn't disappear when the last member is unregistered because the QOM
> > tree has 1 reference to the ThrottleGroup at all times due to
> > user_creatable_add_type():
> >=20
> >  object_property_add_child(object_get_objects_root(),
> >                            id, obj, &local_err);
> >=20
> > Is it okay to simplify the patch to:
> >=20
> >  if (tg) {
> >      object_ref(OBJECT(tg));
> >  } else {
> >      tg =3D THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
> >      ...
> >  }
> >=20
> > That would be clearer - in both legs of the if statement we take a
> > reference to the object.  The if (!QLIST_EMPTY(tg->head)) check confuses
> > me.
>=20
> Ok, so tree objects (cli or QMP created) must be manually deleted then.  =
Is
> this consistent with the management of other user creatable types?

Yes, the object-del command must be used to delete user created objects.

> > > > > +static void throttle_group_obj_init(Object *obj)
> > > > > +{
> > > > > +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> > > > > +
> > > > > +    tg->clock_type =3D QEMU_CLOCK_REALTIME;
> > > > > +    if (qtest_enabled()) {
> > > > > +        /* For testing block IO throttling only */
> > > > > +        tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
> > > > > +    }
> > > > > +    tg->is_initialized =3D false;
> > > > > +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
> > > >
> > > > Is the lock taken when the object-add QMP command or -object
> > > > command-line argument are used?
> > > >
> > > > In any case, please do not assume that throttle_groups_lock is held=
 for
> > > > Object->init().  It should be possible to create new instances at a=
ny
> > > > time.
> > >=20
> > > Hm, isn't the global lock held in both cases? And in the third case w=
here we
> > > create the object from throttle_group_incref() we hold the
> > > throttle_groups_lock.
> >=20
> > At the moment I think throttle_groups_lock isn't strictly needed because
> > incref/decref callers hold the QEMU global mutex anyway.
> >=20
> > But code accessing throttle_groups still has to be disciplined.  Since
> > throttle_groups_lock exists, please use it consistently in all code
> > paths.
> >=20
> > Alternatively you could remove the lock and document that
> > throttle_groups is protected by the global mutex.  What we can't do is
> > sometimes use throttle_groups_lock and sometimes not use it.
>=20
> If we use throttle_groups_lock in throttle_group_obj_init() then we must
> give it up in throttle_group_incref() and retake it in
> throttle_group_obj_init(). Maybe indeed it's better to drop
> throttle_groups_lock altogether, since the ThrottleGroup refcounting alwa=
ys
> happens in a QMP or startup/cleanup context.

We can use just the QEMU global mutex.  Please mark up the doc comments
of the functions that must be called under the global mutex so this
assumption is clear.

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgeUoAAoJEJykq7OBq3PIjtEH/AnFsXnqeOdSZEEF8Z5Jx9Vz
mlnI4TacX7BMsw3yXW85iUvOPjNkxgI/UF5RTzNy6juN8OLXaYg0qFNSp84BpvWI
U9BI4T7/nR7TSMgOJtOYXhRpGuqTH5WU1nvMV+Bwah+rt3rvkhzIb7vysDbE7k+z
1uxnk+F15knez+FS5733TGV6sYG6l7O45Gsf+RDEE7ItE091wcH9+vsMJpjIGBPh
htnoMwng/wvoZm3lvEujcvvhRH7hIH3uykjQyZg7GUtYBZaiWVWjc8vYHG21Y5gS
0REdcNqh3pJ14QujXJN14ac59fPIEYyCMtRYoZbVy6GCDZJy77giRnIIGcz0/nU=
=ErRS
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
