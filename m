Received: from eggs.gnu.org ([2001:4830:134:3::10]:43905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eIIEO-0003de-Em
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eIIEN-0000RT-FU
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:57:40 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eIIEN-0000MT-9f
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 12:57:39 -0500
Received: by mail-wr0-x243.google.com with SMTP id z14so20996881wrb.8
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 09:57:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171124153656.30199-2-rkagan@virtuozzo.com>
References: <20171124153656.30199-1-rkagan@virtuozzo.com>
	<20171124153656.30199-2-rkagan@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 24 Nov 2017 18:57:36 +0100
Message-ID: <CAJ+F1CLbZPZjSA3PWMGZH179yaCYY3zRQW7LJOGnRj4tZ0YgVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev-properties: add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Fri, Nov 24, 2017 at 4:36 PM, Roman Kagan <rkagan@virtuozzo.com> wrote:
> UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
> property type becomes helpful.
>
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/hw/qdev-properties.h |  3 +++
>  hw/core/qdev-properties.c    | 52 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index e2321f1cc1..d4da7dd1f1 100644
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
> @@ -212,6 +213,8 @@ extern const PropertyInfo qdev_prop_link;
>      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAdd=
ress)
>  #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
> +#define DEFINE_PROP_UUID(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_uuid, QemuUUID)
>
>  #define DEFINE_PROP_END_OF_LIST()               \
>      {}
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 1dc80fcea2..49fea5a40a 100644
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
> @@ -883,6 +884,57 @@ const PropertyInfo qdev_prop_pci_host_devaddr =3D {
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
> +    if (!strcmp(str, "auto")) {
> +        qemu_uuid_generate(uuid);
> +    } else if (qemu_uuid_parse(str, uuid) < 0) {
> +        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
> +    }
> +    g_free(str);
> +}
> +
> +const PropertyInfo qdev_prop_uuid =3D {
> +    .name  =3D "str",
> +    .description =3D "UUID (aka GUID) or \"auto\" for random value",
> +    .get   =3D get_uuid,
> +    .set   =3D set_uuid,
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
