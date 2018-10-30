Received: from eggs.gnu.org ([2001:4830:134:3::10]:36474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gHUfE-0008JR-44
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gHUf8-0000R4-Df
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:06:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gHUf8-0000Pu-5H
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:06:30 -0400
Date: Tue, 30 Oct 2018 15:05:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181030150558.059f3482@redhat.com>
In-Reply-To: <CAMxuvaw+2L+ctBtZvGv6=q8X5jBXx1bdX42yqv9t82SnFC3D=Q@mail.gmail.com>
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
	<20180912125531.32131-6-marcandre.lureau@redhat.com>
	<20181029141148.170dad3f@redhat.com>
	<CAMxuvaw+2L+ctBtZvGv6=q8X5jBXx1bdX42yqv9t82SnFC3D=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] qom/globals: generalize
 object_property_set_globals()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, mark.cave-ayland@ilande.co.uk, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, atar4qemu@gmail.com, Richard Henderson <rth@twiddle.net>

On Tue, 30 Oct 2018 16:16:43 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Hi
>=20
> On Mon, Oct 29, 2018 at 5:11 PM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Wed, 12 Sep 2018 16:55:27 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> > > Handle calls of object_property_set_globals() with any object type,
> > > but only apply globals to TYPE_DEVICE & TYPE_USER_CREATABLE.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  qom/globals.c | 22 ++++++++++++++--------
> > >  1 file changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/qom/globals.c b/qom/globals.c
> > > index 587f4a1b5c..8664baebe0 100644
> > > --- a/qom/globals.c
> > > +++ b/qom/globals.c
> > > @@ -15,22 +15,28 @@ void object_property_register_global(GlobalProper=
ty *prop)
> > >
> > >  void object_property_set_globals(Object *obj)
> > >  {
> > > -    DeviceState *dev =3D DEVICE(obj);
> > >      GList *l;
> > > +    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(obj, TYP=
E_DEVICE);
> > > +
> > > +    if (!dev && !IS_USER_CREATABLE(obj)) {
> > > +        /* only TYPE_DEVICE and TYPE_USER_CREATABLE support globals =
*/
> > > +        return;
> > > +    } =20
> > more dynamic casts but now imposed on every create object :(
> >
> > Maybe we should add ObjectClass::check/set_globals hook?
> > It would be cheap to check and only objects we intend to work with
> > it would be affected. On top of that hooks could be different so
> > that device/user_creatable specifics won't be in generic code
> > (like it's implemented here). =20
>=20
> I don't think adding a few casts during object creation will impact
> negatively in a measurable way.
When it's applied to every object created as opposed to -object CLI option,
it will add up. For example 512 x 2 (cpus + apic) ~ 1000 x cast_cost,
for pc-dimm 255 x 3 (backend + memory_region + pc-dimm) ~ 800 x cast_cost,
We can have more backends of other types, basically everything QOM will
incur tiny extra cost.
I'm just thinking about worst case scenario.


> However I'll add an additional patch to the series to implement what I
> think you suggested.
thanks,
for this patch also important to keep Device vs UserCreatable
parts separate instead of dumping evrything into one pit.

>=20
> thanks
> > =20
> > >
> > >      for (l =3D global_props; l; l =3D l->next) {
> > >          GlobalProperty *prop =3D l->data;
> > >          Error *err =3D NULL;
> > >
> > > -        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NU=
LL) {
> > > +        if (object_dynamic_cast(obj, prop->driver) =3D=3D NULL) {
> > >              continue;
> > >          }
> > >          prop->used =3D true;
> > > -        object_property_parse(OBJECT(dev), prop->value, prop->proper=
ty, &err);
> > > +        object_property_parse(obj, prop->value, prop->property, &err=
);
> > >          if (err !=3D NULL) {
> > >              error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> > >                            prop->driver, prop->property, prop->value);
> > > -            if (!dev->hotplugged && prop->errp) {
> > > +
> > > +            if (dev && !dev->hotplugged && prop->errp) {
> > >                  error_propagate(prop->errp, err);
> > >              } else {
> > >                  assert(prop->user_provided);
> > > @@ -56,15 +62,15 @@ int object_property_check_globals(void)
> > >              continue;
> > >          }
> > >          oc =3D object_class_by_name(prop->driver);
> > > -        oc =3D object_class_dynamic_cast(oc, TYPE_DEVICE);
> > > -        if (!oc) {
> > > +        dc =3D (DeviceClass *)object_class_dynamic_cast(oc, TYPE_DEV=
ICE);
> > > +        if (!IS_USER_CREATABLE_CLASS(oc) && !dc) {
> > >              warn_report("global %s.%s has invalid class name",
> > >                          prop->driver, prop->property);
> > >              ret =3D 1;
> > >              continue;
> > >          }
> > > -        dc =3D DEVICE_CLASS(oc);
> > > -        if (!dc->hotpluggable && !prop->used) {
> > > +
> > > +        if (dc && !dc->hotpluggable) {
> > >              warn_report("global %s.%s=3D%s not used",
> > >                          prop->driver, prop->property, prop->value);
> > >              ret =3D 1; =20
> > =20
