Received: from eggs.gnu.org ([2001:4830:134:3::10]:34795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcrLd-0003bT-Eo
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dcrLb-0004i1-PP
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:57:53 -0400
Date: Wed, 2 Aug 2017 13:57:04 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170802105704.m2jbxnivl32msbx6@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-5-el13635@mail.ntua.gr>
	<20170801154703.GD22017@stefanha-x1.localdomain>
	<20170801164933.c54ocjzr26sxaizy@postretch>
	<20170802103922.GE5531@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="swljhenuwpvekold"
Content-Disposition: inline
In-Reply-To: <20170802103922.GE5531@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--swljhenuwpvekold
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 11:39:22AM +0100, Stefan Hajnoczi wrote:
>On Tue, Aug 01, 2017 at 07:49:33PM +0300, Manos Pitsidianakis wrote:
>> On Tue, Aug 01, 2017 at 04:47:03PM +0100, Stefan Hajnoczi wrote:
>> > On Mon, Jul 31, 2017 at 12:54:40PM +0300, Manos Pitsidianakis wrote:
>> > > ThrottleGroup is converted to an object. This will allow the future
>> > > throttle block filter drive easy creation and configuration of throt=
tle
>> > > groups in QMP and cli.
>> > >
>> > > A new QAPI struct, ThrottleLimits, is introduced to provide a shared
>> > > struct for all throttle configuration needs in QMP.
>> > >
>> > > ThrottleGroups can be created via CLI as
>> > >     -object throttle-group,id=3Dfoo,x-iops-total=3D100,x-..
>> > > where x-* are individual limit properties. Since we can't add non-sc=
alar
>> > > properties in -object this interface must be used instead. However,
>> > > setting these properties must be disabled after initialization becau=
se
>> > > certain combinations of limits are forbidden and thus configuration
>> > > changes should be done in one transaction. The individual properties
>> > > will go away when support for non-scalar values in CLI is implemented
>> > > and thus are marked as experimental.
>> > >
>> > > ThrottleGroup also has a `limits` property that uses the ThrottleLim=
its
>> > > struct.  It can be used to create ThrottleGroups or set the
>> > > configuration in existing groups as follows:
>> > >
>> > > { "execute": "object-add",
>> > >   "arguments": {
>> > >     "qom-type": "throttle-group",
>> > >     "id": "foo",
>> > >     "props" : {
>> > >       "limits": {
>> > >           "iops-total": 100
>> > >       }
>> > >     }
>> > >   }
>> > > }
>> > > { "execute" : "qom-set",
>> > >     "arguments" : {
>> > >         "path" : "foo",
>> > >         "property" : "limits",
>> > >         "value" : {
>> > >             "iops-total" : 99
>> > >         }
>> > >     }
>> > > }
>> > >
>> > > This also means a group's configuration can be fetched with qom-get.
>> > >
>> > > ThrottleGroups can be anonymous which means they can't get accessed =
by
>> > > other users ie they will always be units instead of group (Because t=
hey
>> > > have one ThrottleGroupMember).
>> >
>> > blockdev.c automatically assigns -drive id=3D to the group name if
>> > throttling.group=3D wasn't given.  So who will use anonymous single-dr=
ive
>> > mode?
>>
>> Manual filter nodes. It's possible to not pass a group name value and the
>> resulting group will be anonymous. Are you suggesting to move this chang=
e to
>> the throttle filter patch?
>
>What is the use case?  Human users will stick to the legacy syntax
>because it's convenient.  Management tools will use the filter
>explicitly in the future, and it's easy for them to choose a name.
>
>Unless there is a need for this case I'd prefer to make the group name
>mandatory.  That way there are less code paths to worry about.

I think Kevin requested this though I don't really remember the use=20
case.
>
>> > > @@ -87,32 +99,30 @@ ThrottleState *throttle_group_incref(const char =
*name)
>> > >
>> > >      qemu_mutex_lock(&throttle_groups_lock);
>> > >
>> > > -    /* Look for an existing group with that name */
>> > > -    QTAILQ_FOREACH(iter, &throttle_groups, list) {
>> > > -        if (!strcmp(name, iter->name)) {
>> > > -            tg =3D iter;
>> > > -            break;
>> > > +    if (name) {
>> > > +        /* Look for an existing group with that name */
>> > > +        QTAILQ_FOREACH(iter, &throttle_groups, list) {
>> > > +            if (!g_strcmp0(name, iter->name)) {
>> > > +                tg =3D iter;
>> > > +                break;
>> > > +            }
>> > >          }
>> > >      }
>> > >
>> > >      /* Create a new one if not found */
>> > >      if (!tg) {
>> > > -        tg =3D g_new0(ThrottleGroup, 1);
>> > > +        /* new ThrottleGroup obj will have a refcnt =3D 1 */
>> > > +        tg =3D THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
>> > >          tg->name =3D g_strdup(name);
>> > > -        tg->clock_type =3D QEMU_CLOCK_REALTIME;
>> > > -
>> > > -        if (qtest_enabled()) {
>> > > -            /* For testing block IO throttling only */
>> > > -            tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
>> > > -        }
>> > > -        qemu_mutex_init(&tg->lock);
>> > > -        throttle_init(&tg->ts);
>> > > -        QLIST_INIT(&tg->head);
>> > > -
>> > > -        QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
>> > > +        throttle_group_obj_complete((UserCreatable *)tg, &error_abo=
rt);
>> > >      }
>> > >
>> > > -    tg->refcount++;
>> > > +    qemu_mutex_lock(&tg->lock);
>> > > +    if (!QLIST_EMPTY(&tg->head)) {
>> > > +        /* only ref if the group is not empty */
>> > > +        object_ref(OBJECT(tg));
>> > > +    }
>> > > +    qemu_mutex_unlock(&tg->lock);
>> >
>> > How do the refcounts work in various cases (legacy -drive
>> > throttling.group and -object throttle-group with 0, 1, or multiple
>> > drives)?
>> >
>> > It's not obvious to me that this code works in all cases.
>>
>> Object is created with object_new(): ref count is 1
>> Each time we call throttle_group_incref() to add a new member to the gro=
up,
>> we increase the ref count by 1. We skip the first time we do that because
>> there's already a reference. When all members are removed, object is
>> deleted.
>
>If the ThrottleGroup was created with -object throttle-group it
>shouldn't disappear when the last member is unregistered because the QOM
>tree has 1 reference to the ThrottleGroup at all times due to
>user_creatable_add_type():
>
>  object_property_add_child(object_get_objects_root(),
>                            id, obj, &local_err);
>
>Is it okay to simplify the patch to:
>
>  if (tg) {
>      object_ref(OBJECT(tg));
>  } else {
>      tg =3D THROTTLE_GROUP(object_new(TYPE_THROTTLE_GROUP));
>      ...
>  }
>
>That would be clearer - in both legs of the if statement we take a
>reference to the object.  The if (!QLIST_EMPTY(tg->head)) check confuses
>me.

Ok, so tree objects (cli or QMP created) must be manually deleted then. =20
Is this consistent with the management of other user creatable types?

>> > > +static void throttle_group_obj_init(Object *obj)
>> > > +{
>> > > +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> > > +
>> > > +    tg->clock_type =3D QEMU_CLOCK_REALTIME;
>> > > +    if (qtest_enabled()) {
>> > > +        /* For testing block IO throttling only */
>> > > +        tg->clock_type =3D QEMU_CLOCK_VIRTUAL;
>> > > +    }
>> > > +    tg->is_initialized =3D false;
>> > > +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
>> >
>> > Is the lock taken when the object-add QMP command or -object
>> > command-line argument are used?
>> >
>> > In any case, please do not assume that throttle_groups_lock is held for
>> > Object->init().  It should be possible to create new instances at any
>> > time.
>>
>> Hm, isn't the global lock held in both cases? And in the third case wher=
e we
>> create the object from throttle_group_incref() we hold the
>> throttle_groups_lock.
>
>At the moment I think throttle_groups_lock isn't strictly needed because
>incref/decref callers hold the QEMU global mutex anyway.
>
>But code accessing throttle_groups still has to be disciplined.  Since
>throttle_groups_lock exists, please use it consistently in all code
>paths.
>
>Alternatively you could remove the lock and document that
>throttle_groups is protected by the global mutex.  What we can't do is
>sometimes use throttle_groups_lock and sometimes not use it.

If we use throttle_groups_lock in throttle_group_obj_init() then we must=20
give it up in throttle_group_incref() and retake it in=20
throttle_group_obj_init(). Maybe indeed it's better to drop=20
throttle_groups_lock altogether, since the ThrottleGroup refcounting=20
always happens in a QMP or startup/cleanup context.
>
>> > > +static void throttle_group_set_limits(Object *obj, Visitor *v,
>> > > +                                      const char *name, void *opaqu=
e,
>> > > +                                      Error **errp)
>> > > +
>> > > +{
>> > > +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
>> > > +    ThrottleConfig cfg;
>> > > +    ThrottleLimits *arg =3D NULL;
>> > > +    Error *local_err =3D NULL;
>> > > +
>> > > +    arg =3D g_new0(ThrottleLimits, 1);
>> >
>> > Why does ThrottleLimits need to be allocated on the heap?
>>
>> It is passed to visit_type_ThrottleLimits which needs a double pointer. =
 The
>> alternative would be:
>>
>>    ThrottleLimits arg =3D { 0 }, *p =3D &arg;
>>    visit_type_ThrottleLimits(v, name, &p, &local_err);
>>
>> Which didn't seem very pretty at the time. Is it a problem?
>
>I was wondering because error code paths need to remember to free it.
>
>Looking more closely at qapi-visit.c I think it *must* be heap-allocated
>because qapi visit functions are allowed to fail and they free the
>object on failure.
>
>What you've done looks correct.



--swljhenuwpvekold
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmBsAAACgkQc2J8L2kN
9xCu7w//df1hSUGSiME4pk0pz9zq+bUyXEI/7Hm+6VYzJ20URoxSR4pf/iQcC98g
qhU/GgNBnM5OPIwY2XBzWKB39ufh6oLlFQFSeUaXRFrZW9Qiuf9rJ/eS5pZA4A8B
hpgQGFo8KouNWugn16xlZGbgMO1HS4eQjoTN3zSiFRa8HV+Fu4Jj0HLH8RjVad6x
0J1ijujEh/SziiIJMwZ4UCUbblXh8jSncBqYQSeBrT/Q6H3zAjmeP0MpY2dRS8+y
dnrKXncYxo2c6IT1gsyZAKMDzdYPwMxgphekq7Igk/8yfTzh+FgtVY/zUpBj5xdL
dXjlYGDJ2D0KBZewqgXMenAEFN/S1IhA/IfJHMePqw8tAK8IfOY33X96eylmnR+h
EXqBpKGSf/orb94dGIaqMAxaQok0UZcjzhgxAelSDtmVx5FBrSrLlTxE7DoabLHX
9HhqlogR9GMGXld+jJ4JRndygG/6dPidNMNK13XkbAW4Ad4tIo7nAKZi2ep+7AiF
9d3GrxENHJBusWjo834wsXhJ2+Y3Vo9IELNAW686dk5hyR4XY+8CVTzR00bpfTNc
CoEjarTOMOig4Q/0YhP3wEluZevEc3/2PFQwS/ZGH5gXRgG9bsEEYDk0GqYVXvkt
6HQb0VhZbws5BgFROo+m70cy3auSEVBDPiaM/wEOuMcWeEczv+U=
=ARzj
-----END PGP SIGNATURE-----

--swljhenuwpvekold--
