Received: from eggs.gnu.org ([2001:4830:134:3::10]:54596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcr3s-0006iF-7I
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcr3q-0000gB-Ph
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:39:32 -0400
Date: Wed, 2 Aug 2017 11:39:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802103922.GE5531@stefanha-x1.localdomain>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-5-el13635@mail.ntua.gr>
	<20170801154703.GD22017@stefanha-x1.localdomain>
	<20170801164933.c54ocjzr26sxaizy@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <20170801164933.c54ocjzr26sxaizy@postretch>
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


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 07:49:33PM +0300, Manos Pitsidianakis wrote:
> On Tue, Aug 01, 2017 at 04:47:03PM +0100, Stefan Hajnoczi wrote:
> > On Mon, Jul 31, 2017 at 12:54:40PM +0300, Manos Pitsidianakis wrote:
> > > ThrottleGroup is converted to an object. This will allow the future
> > > throttle block filter drive easy creation and configuration of thrott=
le
> > > groups in QMP and cli.
> > >=20
> > > A new QAPI struct, ThrottleLimits, is introduced to provide a shared
> > > struct for all throttle configuration needs in QMP.
> > >=20
> > > ThrottleGroups can be created via CLI as
> > >     -object throttle-group,id=3Dfoo,x-iops-total=3D100,x-..
> > > where x-* are individual limit properties. Since we can't add non-sca=
lar
> > > properties in -object this interface must be used instead. However,
> > > setting these properties must be disabled after initialization because
> > > certain combinations of limits are forbidden and thus configuration
> > > changes should be done in one transaction. The individual properties
> > > will go away when support for non-scalar values in CLI is implemented
> > > and thus are marked as experimental.
> > >=20
> > > ThrottleGroup also has a `limits` property that uses the ThrottleLimi=
ts
> > > struct.  It can be used to create ThrottleGroups or set the
> > > configuration in existing groups as follows:
> > >=20
> > > { "execute": "object-add",
> > >   "arguments": {
> > >     "qom-type": "throttle-group",
> > >     "id": "foo",
> > >     "props" : {
> > >       "limits": {
> > >           "iops-total": 100
> > >       }
> > >     }
> > >   }
> > > }
> > > { "execute" : "qom-set",
> > >     "arguments" : {
> > >         "path" : "foo",
> > >         "property" : "limits",
> > >         "value" : {
> > >             "iops-total" : 99
> > >         }
> > >     }
> > > }
> > >=20
> > > This also means a group's configuration can be fetched with qom-get.
> > >=20
> > > ThrottleGroups can be anonymous which means they can't get accessed by
> > > other users ie they will always be units instead of group (Because th=
ey
> > > have one ThrottleGroupMember).
> >=20
> > blockdev.c automatically assigns -drive id=3D to the group name if
> > throttling.group=3D wasn't given.  So who will use anonymous single-dri=
ve
> > mode?
>=20
> Manual filter nodes. It's possible to not pass a group name value and the
> resulting group will be anonymous. Are you suggesting to move this change=
 to
> the throttle filter patch?

What is the use case?  Human users will stick to the legacy syntax
because it's convenient.  Management tools will use the filter
explicitly in the future, and it's easy for them to choose a name.

Unless there is a need for this case I'd prefer to make the group name
mandatory.  That way there are less code paths to worry about.

> > > @@ -87,32 +99,30 @@ ThrottleState *throttle_group_incref(const char *=
name)
> > >=20
> > >      qemu_mutex_lock(&throttle_groups_lock);
> > >=20
> > > -    /* Look for an existing group with that name */
> > > -    QTAILQ_FOREACH(iter, &throttle_groups, list) {
> > > -        if (!strcmp(name, iter->name)) {
> > > -            tg =3D iter;
> > > -            break;
> > > +    if (name) {
> > > +        /* Look for an existing group with that name */
> > > +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
> > > +            if (!g_strcmp0(name, iter->name)) {
> > > +                tg =3D iter;
> > > +                break;
> > > +            }
> > >          }
> > >      }
> > >=20
> > >      /* Create a new one if not found */
> > >      if (!tg) {
> > > -        tg =3D g_new0(ThrottleGroup, 1);
> > > +        /* new ThrottleGroup obj will have a refcnt =3D 1 */
> > > +        tg =3D THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
> > >          tg->name =3D g_strdup(name);
> > > -        tg->clock_type =3D QEMU_CLOCK_REALTIME;
> > > -
> > > -        if (qtest_enabled()) {
> > > -            /* For testing block IO throttling only */
> > > -            tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
> > > -        }
> > > -        qemu_mutex_init(&tg->lock);
> > > -        throttle_init(&tg->ts);
> > > -        QLIST_INIT(&tg->head);
> > > -
> > > -        QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
> > > +        throttle_group_obj_complete((UserCreatable *)tg, &error_abor=
t);
> > >      }
> > >=20
> > > -    tg->refcount++;
> > > +    qemu_mutex_lock(&tg->lock);
> > > +    if (!QLIST_EMPTY(&tg->head)) {
> > > +        /* only ref if the group is not empty */
> > > +        object_ref(OBJECT(tg));
> > > +    }
> > > +    qemu_mutex_unlock(&tg->lock);
> >=20
> > How do the refcounts work in various cases (legacy -drive
> > throttling.group and -object throttle-group with 0, 1, or multiple
> > drives)?
> >=20
> > It's not obvious to me that this code works in all cases.
>=20
> Object is created with object_new(): ref count is 1
> Each time we call throttle_group_incref() to add a new member to the grou=
p,
> we increase the ref count by 1. We skip the first time we do that because
> there's already a reference. When all members are removed, object is
> deleted.

If the ThrottleGroup was created with -object throttle-group it
shouldn't disappear when the last member is unregistered because the QOM
tree has 1 reference to the ThrottleGroup at all times due to
user_creatable_add_type():

  object_property_add_child(object_get_objects_root(),
                            id, obj, &local_err);

Is it okay to simplify the patch to:

  if (tg) {
      object_ref(OBJECT(tg));
  } else {
      tg =3D THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
      ...
  }

That would be clearer - in both legs of the if statement we take a
reference to the object.  The if (!QLIST_EMPTY(tg->head)) check confuses
me.

> > > +static void throttle_group_obj_init(Object *obj)
> > > +{
> > > +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> > > +
> > > +    tg->clock_type =3D QEMU_CLOCK_REALTIME;
> > > +    if (qtest_enabled()) {
> > > +        /* For testing block IO throttling only */
> > > +        tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
> > > +    }
> > > +    tg->is_initialized =3D false;
> > > +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
> >=20
> > Is the lock taken when the object-add QMP command or -object
> > command-line argument are used?
> >=20
> > In any case, please do not assume that throttle_groups_lock is held for
> > Object->init().  It should be possible to create new instances at any
> > time.
>=20
> Hm, isn't the global lock held in both cases? And in the third case where=
 we
> create the object from throttle_group_incref() we hold the
> throttle_groups_lock.

At the moment I think throttle_groups_lock isn't strictly needed because
incref/decref callers hold the QEMU global mutex anyway.

But code accessing throttle_groups still has to be disciplined.  Since
throttle_groups_lock exists, please use it consistently in all code
paths.

Alternatively you could remove the lock and document that
throttle_groups is protected by the global mutex.  What we can't do is
sometimes use throttle_groups_lock and sometimes not use it.

> > > +static void throttle_group_set_limits(Object *obj, Visitor *v,
> > > +                                      const char *name, void *opaque,
> > > +                                      Error **errp)
> > > +
> > > +{
> > > +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> > > +    ThrottleConfig cfg;
> > > +    ThrottleLimits *arg =3D NULL;
> > > +    Error *local_err =3D NULL;
> > > +
> > > +    arg =3D g_new0(ThrottleLimits, 1);
> >=20
> > Why does ThrottleLimits need to be allocated on the heap?
>=20
> It is passed to visit_type_ThrottleLimits which needs a double pointer.  =
The
> alternative would be:
>=20
>    ThrottleLimits arg =3D { 0 }, *p =3D &arg;
>    visit_type_ThrottleLimits(v, name, &p, &local_err);
>=20
> Which didn't seem very pretty at the time. Is it a problem?

I was wondering because error code paths need to remember to free it.

Looking more closely at qapi-visit.c I think it *must* be heap-allocated
because qapi visit functions are allowed to fail and they free the
object on failure.

What you've done looks correct.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgavaAAoJEJykq7OBq3PIz5cH/1tZLHaZy2y7rO+cYqRobUK3
8dH6LzB4n5oLsa3Y/aNiXnOMTw23HzyyHteVWVnslD/MIzKrs1oyf1fkgWifbSqb
uzk5ZohPKDu3jHsqmEe5HOChlTCyfgTEU+z2NVD+nQg89hFlafGPhhFznLltAHyX
EcG1LJQKK/GP1mikj2n1kvliHqHFXdIcZ4TGd39s+y4p7k3uQpPhTA5WkT16b0GT
U6Pl/g/LItFKsl4Oaj5Kyun0GZXHIldiKxYZUDhd1giz0BmyZ+MSSWykWtb+03GI
/P8V9wvm+MafeisXBXUxCY6u9bv6MIkmg51d2qe/lMxHv1sgOtGTAX3FKFrjPlw=
=NBmI
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
