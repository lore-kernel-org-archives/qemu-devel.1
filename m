Received: from eggs.gnu.org ([2001:4830:134:3::10]:54811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWguW-0000eK-Pp
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWguV-0002JZ-DV
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:13:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gWguV-0002J7-4w
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:13:11 -0500
Received: by mail-wm1-x342.google.com with SMTP id a18so2026104wmj.1
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 04:13:11 -0800 (PST)
MIME-Version: 1.0
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-13-marcandre.lureau@redhat.com>
	<20181210180503.2cd631cf@Igors-MacBook-Pro.local>
In-Reply-To: <20181210180503.2cd631cf@Igors-MacBook-Pro.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 11 Dec 2018 16:12:58 +0400
Message-ID: <CAJ+F1CLFXvBmo2smT5uCdXSj43tC5U7LDxQ9t--OBMAJGOTVAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 12/19] qdev-props: convert
 global_props to GPtrArray
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Mon, Dec 10, 2018 at 9:07 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Tue,  4 Dec 2018 18:20:16 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > A step towards being able to call a common function,
> > object_apply_global_props().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/core/qdev-properties.c | 29 ++++++++++++++++++++---------
> >  1 file changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index 43c30a57f4..3467e0485c 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -1173,22 +1173,32 @@ void qdev_prop_set_ptr(DeviceState *dev, const =
char *name, void *value)
> >      *ptr =3D value;
> >  }
> >
> > -static GList *global_props;
> > +static GPtrArray *global_props(void)
> > +{
> > +    static GPtrArray *gp;
> > +
> > +    if (!gp) {
> > +        gp =3D g_ptr_array_new();
> one more leak?

We leak the global_props list before and using a list is going to use
more memory than using a GPtrArray.

If you worry about the global leaks, we can adress it with
destructors. I don't think that matters here.

>
> > +    }
> > +
> > +    return gp;
> > +}
> >
> >  void qdev_prop_register_global(GlobalProperty *prop)
> >  {
> > -    global_props =3D g_list_append(global_props, prop);
> > +    g_ptr_array_add(global_props(), prop);
> >  }
> >
> >  int qdev_prop_check_globals(void)
> >  {
> > -    GList *l;
> > -    int ret =3D 0;
> > +    int i, ret =3D 0;
> >
> > -    for (l =3D global_props; l; l =3D l->next) {
> > -        GlobalProperty *prop =3D l->data;
> > +    for (i =3D 0; i < global_props()->len; i++) {
> > +        GlobalProperty *prop;
> >          ObjectClass *oc;
> >          DeviceClass *dc;
> > +
> > +        prop =3D g_ptr_array_index(global_props(), i);
> >          if (prop->used) {
> >              continue;
> >          }
> > @@ -1213,12 +1223,13 @@ int qdev_prop_check_globals(void)
> >
> >  void qdev_prop_set_globals(DeviceState *dev)
> >  {
> > -    GList *l;
> > +    int i;
> >
> > -    for (l =3D global_props; l; l =3D l->next) {
> > -        GlobalProperty *prop =3D l->data;
> > +    for (i =3D 0; i < global_props()->len; i++) {
> > +        GlobalProperty *prop;
> >          Error *err =3D NULL;
> >
> > +        prop =3D g_ptr_array_index(global_props(), i);
> >          if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL=
) {
> >              continue;
> >          }
>
>


--=20
Marc-Andr=C3=A9 Lureau
