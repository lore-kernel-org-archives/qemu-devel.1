Received: from eggs.gnu.org ([2001:4830:134:3::10]:54319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gHSxB-0008Ne-0u
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gHSx6-0002Eg-0V
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:17:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gHSx5-0002Du-Rg
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:16:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id g10-v6so13095014qtq.6
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
	<20180912125531.32131-6-marcandre.lureau@redhat.com>
	<20181029141148.170dad3f@redhat.com>
In-Reply-To: <20181029141148.170dad3f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Oct 2018 16:16:43 +0400
Message-ID: <CAMxuvaw+2L+ctBtZvGv6=q8X5jBXx1bdX42yqv9t82SnFC3D=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, mark.cave-ayland@ilande.co.uk, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Bonzini,
	Paolo" <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, atar4qemu@gmail.com, Richard Henderson <rth@twiddle.net>

Hi

On Mon, Oct 29, 2018 at 5:11 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 12 Sep 2018 16:55:27 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > Handle calls of object_property_set_globals() with any object type,
> > but only apply globals to TYPE_DEVICE & TYPE_USER_CREATABLE.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qom/globals.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/qom/globals.c b/qom/globals.c
> > index 587f4a1b5c..8664baebe0 100644
> > --- a/qom/globals.c
> > +++ b/qom/globals.c
> > @@ -15,22 +15,28 @@ void object_property_register_global(GlobalProperty=
 *prop)
> >
> >  void object_property_set_globals(Object *obj)
> >  {
> > -    DeviceState *dev =3D DEVICE(obj);
> >      GList *l;
> > +    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(obj, TYPE_=
DEVICE);
> > +
> > +    if (!dev && !IS_USER_CREATABLE(obj)) {
> > +        /* only TYPE_DEVICE and TYPE_USER_CREATABLE support globals */
> > +        return;
> > +    }
> more dynamic casts but now imposed on every create object :(
>
> Maybe we should add ObjectClass::check/set_globals hook?
> It would be cheap to check and only objects we intend to work with
> it would be affected. On top of that hooks could be different so
> that device/user_creatable specifics won't be in generic code
> (like it's implemented here).

I don't think adding a few casts during object creation will impact
negatively in a measurable way.

However I'll add an additional patch to the series to implement what I
think you suggested.

thanks
>
> >
> >      for (l =3D global_props; l; l =3D l->next) {
> >          GlobalProperty *prop =3D l->data;
> >          Error *err =3D NULL;
> >
> > -        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL=
) {
> > +        if (object_dynamic_cast(obj, prop->driver) =3D=3D NULL) {
> >              continue;
> >          }
> >          prop->used =3D true;
> > -        object_property_parse(OBJECT(dev), prop->value, prop->property=
, &err);
> > +        object_property_parse(obj, prop->value, prop->property, &err);
> >          if (err !=3D NULL) {
> >              error_prepend(&err, "can't apply global %s.%s=3D%s: ",
> >                            prop->driver, prop->property, prop->value);
> > -            if (!dev->hotplugged && prop->errp) {
> > +
> > +            if (dev && !dev->hotplugged && prop->errp) {
> >                  error_propagate(prop->errp, err);
> >              } else {
> >                  assert(prop->user_provided);
> > @@ -56,15 +62,15 @@ int object_property_check_globals(void)
> >              continue;
> >          }
> >          oc =3D object_class_by_name(prop->driver);
> > -        oc =3D object_class_dynamic_cast(oc, TYPE_DEVICE);
> > -        if (!oc) {
> > +        dc =3D (DeviceClass *)object_class_dynamic_cast(oc, TYPE_DEVIC=
E);
> > +        if (!IS_USER_CREATABLE_CLASS(oc) && !dc) {
> >              warn_report("global %s.%s has invalid class name",
> >                          prop->driver, prop->property);
> >              ret =3D 1;
> >              continue;
> >          }
> > -        dc =3D DEVICE_CLASS(oc);
> > -        if (!dc->hotpluggable && !prop->used) {
> > +
> > +        if (dc && !dc->hotpluggable) {
> >              warn_report("global %s.%s=3D%s not used",
> >                          prop->driver, prop->property, prop->value);
> >              ret =3D 1;
>
