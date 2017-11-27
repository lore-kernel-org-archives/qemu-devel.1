Received: from eggs.gnu.org ([2001:4830:134:3::10]:43772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eJMf4-0006m8-QO
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eJMf3-0006i6-Of
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:53:38 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eJMf3-0006hT-Eg
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:53:37 -0500
Received: by mail-wm0-x231.google.com with SMTP id y82so28839656wmg.1
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 08:53:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171127130518.26703-2-rkagan@virtuozzo.com>
References: <20171127130518.26703-1-rkagan@virtuozzo.com>
	<20171127130518.26703-2-rkagan@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Nov 2017 17:53:35 +0100
Message-ID: <CAJ+F1CLV4yMqhOFq1NybS+rwvAqNXfO-YJrg9F7vwK-c0q=N4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qdev-properties: add UUID property
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, Markus Armbruster <armbru@redhat.com>, minyard@acm.org, "Denis V. Lunev" <den@openvz.org>

On Mon, Nov 27, 2017 at 2:05 PM, Roman Kagan <rkagan@virtuozzo.com> wrote:
> UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
> property type becomes helpful.
>
> The property accepts a string-formatted UUID or a special keyword "auto"
> meaning a randomly generated UUID; the latter is also the default when
> the property is not given a value explicitly.
>
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> v1 -> v2:
>  - make the property default to autogeneration if not specified
>    explicitly
>
>  include/hw/qdev-properties.h |  9 +++++++
>  hw/core/qdev-properties.c    | 61 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index e2321f1cc1..efb22ba80c 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -30,6 +30,7 @@ extern const PropertyInfo qdev_prop_vlan;
>  extern const PropertyInfo qdev_prop_pci_devfn;
>  extern const PropertyInfo qdev_prop_blocksize;
>  extern const PropertyInfo qdev_prop_pci_host_devaddr;
> +extern const PropertyInfo qdev_prop_uuid;
>  extern const PropertyInfo qdev_prop_arraylen;
>  extern const PropertyInfo qdev_prop_link;
>
> @@ -213,6 +214,14 @@ extern const PropertyInfo qdev_prop_link;
>  #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
>
> +#define DEFINE_PROP_UUID(_name, _state, _field) {                  \
> +        .name      =3D (_name),                                      \
> +        .info      =3D &qdev_prop_uuid,                              \
> +        .offset    =3D offsetof(_state, _field)                      \
> +            + type_check(QemuUUID, typeof_field(_state, _field)),  \
> +        .set_default =3D true,                                       \
> +        }
> +
>  #define DEFINE_PROP_END_OF_LIST()               \
>      {}
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 1dc80fcea2..24c17800e3 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -10,6 +10,7 @@
>  #include "net/hub.h"
>  #include "qapi/visitor.h"
>  #include "chardev/char.h"
> +#include "qemu/uuid.h"
>
>  void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>                                    Error **errp)
> @@ -883,6 +884,66 @@ const PropertyInfo qdev_prop_pci_host_devaddr =3D {
>      .set =3D set_pci_host_devaddr,
>  };
>
> +/* --- UUID --- */
> +
> +static void get_uuid(Object *obj, Visitor *v, const char *name, void *op=
aque,
> +                     Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
> +    char buffer[UUID_FMT_LEN + 1];
> +    char *p =3D buffer;
> +
> +    qemu_uuid_unparse(uuid, buffer);
> +
> +    visit_type_str(v, name, &p, errp);
> +}
> +
> +#define UUID_VALUE_AUTO        "auto"
> +
> +static void set_uuid(Object *obj, Visitor *v, const char *name, void *op=
aque,
> +                    Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
> +    Error *local_err =3D NULL;
> +    char *str;
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_str(v, name, &str, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (!strcmp(str, UUID_VALUE_AUTO)) {
> +        qemu_uuid_generate(uuid);
> +    } else if (qemu_uuid_parse(str, uuid) < 0) {
> +        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
> +    }
> +    g_free(str);
> +}
> +
> +static void set_default_uuid_auto(Object *obj, const Property *prop)
> +{
> +    object_property_set_str(obj, UUID_VALUE_AUTO, prop->name, &error_abo=
rt);
> +}
> +
> +const PropertyInfo qdev_prop_uuid =3D {
> +    .name  =3D "str",
> +    .description =3D "UUID (aka GUID) or \"" UUID_VALUE_AUTO
> +        "\" for random value (default)",
> +    .get   =3D get_uuid,
> +    .set   =3D set_uuid,
> +    .set_default_value =3D set_default_uuid_auto,
> +};
> +
>  /* --- support for array properties --- */
>
>  /* Used as an opaque for the object properties we add for each
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
