Received: from eggs.gnu.org ([2001:4830:134:3::10]:60674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHwrU-0007XF-1A
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHwrP-0001eO-Qf
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHwrP-0001du-GK
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:13:03 -0400
Date: Wed, 31 Oct 2018 17:12:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181031201256.GA30771@habkost.net>
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
	<20181030150453.9344-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181030150453.9344-6-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/10] qom/globals: generalize
 object_property_set_globals()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 30, 2018 at 07:04:48PM +0400, Marc-Andr=E9 Lureau wrote:
> Handle calls of object_property_set_globals() with any object type,
> but only apply globals to TYPE_DEVICE & TYPE_USER_CREATABLE.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/globals.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/qom/globals.c b/qom/globals.c
> index 587f4a1b5c..8664baebe0 100644
> --- a/qom/globals.c
> +++ b/qom/globals.c
> @@ -15,22 +15,28 @@ void object_property_register_global(GlobalProperty=
 *prop)
> =20
>  void object_property_set_globals(Object *obj)
>  {
> -    DeviceState *dev =3D DEVICE(obj);
>      GList *l;
> +    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(obj, TYPE_=
DEVICE);
> +
> +    if (!dev && !IS_USER_CREATABLE(obj)) {
> +        /* only TYPE_DEVICE and TYPE_USER_CREATABLE support globals */
> +        return;
> +    }

This is core QOM code, ideally type-specific code doesn't belong
here.

This also duplicates the purpose of the ObjectClass::set_globals
flag you have added on another patch, doesn't it?  I suggest just
dropping this hunk, and letting callers decide if it's
appropriate to call object_property_set_globals() or not.

> =20
>      for (l =3D global_props; l; l =3D l->next) {
>          GlobalProperty *prop =3D l->data;
>          Error *err =3D NULL;
> =20
> -        if (object_dynamic_cast(OBJECT(dev), prop->driver) =3D=3D NULL=
) {
> +        if (object_dynamic_cast(obj, prop->driver) =3D=3D NULL) {
>              continue;
>          }
>          prop->used =3D true;
> -        object_property_parse(OBJECT(dev), prop->value, prop->property=
, &err);
> +        object_property_parse(obj, prop->value, prop->property, &err);
>          if (err !=3D NULL) {
>              error_prepend(&err, "can't apply global %s.%s=3D%s: ",
>                            prop->driver, prop->property, prop->value);
> -            if (!dev->hotplugged && prop->errp) {
> +
> +            if (dev && !dev->hotplugged && prop->errp) {

Hmm, more type-specific code.  Can't we get rid of the
dev->hotplugged check here?

Maybe changing the function signature to:
  void object_property_set_globals(Object *obj, bool propagate_errors);
and let the caller decide?

Or we could try to find a way to get rid of prop->errp.  I never
really liked that hack, anyway.

Anyway, I won't mind keeping this code as-is if the solution is
too complex.


>                  error_propagate(prop->errp, err);
>              } else {
>                  assert(prop->user_provided);
> @@ -56,15 +62,15 @@ int object_property_check_globals(void)
>              continue;
>          }
>          oc =3D object_class_by_name(prop->driver);
> -        oc =3D object_class_dynamic_cast(oc, TYPE_DEVICE);
> -        if (!oc) {
> +        dc =3D (DeviceClass *)object_class_dynamic_cast(oc, TYPE_DEVIC=
E);
> +        if (!IS_USER_CREATABLE_CLASS(oc) && !dc) {

This could use the ObjectClass::set_globals flag you have added.

>              warn_report("global %s.%s has invalid class name",
>                          prop->driver, prop->property);
>              ret =3D 1;
>              continue;
>          }
> -        dc =3D DEVICE_CLASS(oc);
> -        if (!dc->hotpluggable && !prop->used) {
> +
> +        if (dc && !dc->hotpluggable) {

I wonder how we could get rid of this type-specific check.  Maybe
a ObjectClass::only_init_time_globals flag, automatically
initialized by TYPE_DEVICE based on DeviceClass::hotpluggable?

In this case, I'm not sure it would be worth the extra
complexity.  The type-specific code is just for a warning,
anyway, so it's not a big deal.


>              warn_report("global %s.%s=3D%s not used",
>                          prop->driver, prop->property, prop->value);
>              ret =3D 1;
> --=20
> 2.19.0.271.gfe8321ec05
>=20
>=20

--=20
Eduardo
