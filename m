Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHx2A-0006d7-An
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHx26-0000Fc-Fh
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:24:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHx24-0000F5-Dj
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:24:04 -0400
Date: Wed, 31 Oct 2018 17:23:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181031202351.GD30771@habkost.net>
References: <20181030150453.9344-1-marcandre.lureau@redhat.com>
	<20181030150453.9344-8-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181030150453.9344-8-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/10] qom/object: add set_globals flags
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

On Tue, Oct 30, 2018 at 07:04:50PM +0400, Marc-Andr=E9 Lureau wrote:
> Guard against calling object_property_set_globals() for all objects,
> check that the class flag set_globals is set before. No need to guard
> in object_property_set_globals() anymore.
>=20
> Only QDev & user-creatable objects have set_globals set at this point.
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Should we squash this into patch 06/10?

The object_property_set_globals() hunk could be squashed into
patch 05/10.

> ---
>  include/qom/object.h    | 1 +
>  hw/core/qdev.c          | 1 +
>  qom/globals.c           | 5 -----
>  qom/object.c            | 5 ++++-
>  qom/object_interfaces.c | 7 +++++++
>  5 files changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f0b0bf39cc..205099bc7e 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -400,6 +400,7 @@ struct ObjectClass
>      ObjectUnparent *unparent;
> =20
>      GHashTable *properties;
> +    bool set_globals;
>  };
> =20
>  /**
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 6a25fa027c..78ce9a3095 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1042,6 +1042,7 @@ static void device_class_init(ObjectClass *class,=
 void *data)
>       */
>      dc->hotpluggable =3D true;
>      dc->user_creatable =3D true;
> +    class->set_globals =3D true;
>  }
> =20
>  void device_class_set_parent_reset(DeviceClass *dc,
> diff --git a/qom/globals.c b/qom/globals.c
> index 8664baebe0..e94e6f2bf9 100644
> --- a/qom/globals.c
> +++ b/qom/globals.c
> @@ -18,11 +18,6 @@ void object_property_set_globals(Object *obj)
>      GList *l;
>      DeviceState *dev =3D (DeviceState *)object_dynamic_cast(obj, TYPE_=
DEVICE);
> =20
> -    if (!dev && !IS_USER_CREATABLE(obj)) {
> -        /* only TYPE_DEVICE and TYPE_USER_CREATABLE support globals */
> -        return;
> -    }
> -
>      for (l =3D global_props; l; l =3D l->next) {
>          GlobalProperty *prop =3D l->data;
>          Error *err =3D NULL;
> diff --git a/qom/object.c b/qom/object.c
> index 7300878125..c18e630159 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -259,6 +259,7 @@ static void type_initialize_interface(TypeImpl *ti,=
 TypeImpl *interface_type,
> =20
>      ti->class->interfaces =3D g_slist_append(ti->class->interfaces,
>                                             iface_impl->class);
> +    ti->class->set_globals |=3D iface_impl->class->set_globals;
>  }
> =20
>  static void object_property_free(gpointer data)
> @@ -391,7 +392,9 @@ static void object_initialize_with_type(void *data,=
 size_t size, TypeImpl *type)
>                                              NULL, object_property_free=
);
>      object_init_with_type(obj, type);
>      object_post_init_with_type(obj, type);
> -    object_property_set_globals(obj);
> +    if (object_get_class(obj)->set_globals) {
> +        object_property_set_globals(obj);
> +    }
>  }
> =20
>  void object_initialize(void *data, size_t size, const char *typename)
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index db85d1eb75..67886845e7 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -184,12 +184,19 @@ void user_creatable_cleanup(void)
>      object_unparent(object_get_objects_root());
>  }
> =20
> +static void user_creatable_class_init(ObjectClass *klass, void *data)
> +{
> +    klass->set_globals =3D true;
> +}
> +
> +
>  static void register_types(void)
>  {
>      static const TypeInfo uc_interface_info =3D {
>          .name          =3D TYPE_USER_CREATABLE,
>          .parent        =3D TYPE_INTERFACE,
>          .class_size =3D sizeof(UserCreatableClass),
> +        .class_init =3D user_creatable_class_init,
>      };
> =20
>      type_register_static(&uc_interface_info);
> --=20
> 2.19.0.271.gfe8321ec05
>=20
>=20

--=20
Eduardo
