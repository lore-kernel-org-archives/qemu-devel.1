Received: from eggs.gnu.org ([2001:4830:134:3::10]:54795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eJGli-0007mz-T3
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eJGlf-0003NF-0j
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:36:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eJGle-0003Mq-Ng
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:36:02 -0500
Date: Mon, 27 Nov 2017 10:35:47 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171127103547.GE32413@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171124153656.30199-1-rkagan@virtuozzo.com>
	<20171124153656.30199-2-rkagan@virtuozzo.com>
	<1f37e2f7-e83e-8605-4e86-b296abcc826d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f37e2f7-e83e-8605-4e86-b296abcc826d@gmail.com>
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
To: minyard@acm.org
Cc: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Fri, Nov 24, 2017 at 08:36:53PM -0600, Corey Minyard wrote:
> On 11/24/2017 09:36 AM, Roman Kagan wrote:
> > UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
> > property type becomes helpful.
> >=20
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > ---
> >   include/hw/qdev-properties.h |  3 +++
> >   hw/core/qdev-properties.c    | 52 +++++++++++++++++++++++++++++++++=
+++++++++++
> >   2 files changed, 55 insertions(+)
> >=20
> > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-propertie=
s.h
> > index e2321f1cc1..d4da7dd1f1 100644
> > --- a/include/hw/qdev-properties.h
> > +++ b/include/hw/qdev-properties.h
> > @@ -30,6 +30,7 @@ extern const PropertyInfo qdev_prop_vlan;
> >   extern const PropertyInfo qdev_prop_pci_devfn;
> >   extern const PropertyInfo qdev_prop_blocksize;
> >   extern const PropertyInfo qdev_prop_pci_host_devaddr;
> > +extern const PropertyInfo qdev_prop_uuid;
> >   extern const PropertyInfo qdev_prop_arraylen;
> >   extern const PropertyInfo qdev_prop_link;
> > @@ -212,6 +213,8 @@ extern const PropertyInfo qdev_prop_link;
> >       DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDevi=
ceAddress)
> >   #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
> >       DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
> > +#define DEFINE_PROP_UUID(_n, _s, _f) \
> > +    DEFINE_PROP(_n, _s, _f, qdev_prop_uuid, QemuUUID)
> >   #define DEFINE_PROP_END_OF_LIST()               \
> >       {}
> > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > index 1dc80fcea2..49fea5a40a 100644
> > --- a/hw/core/qdev-properties.c
> > +++ b/hw/core/qdev-properties.c
> > @@ -10,6 +10,7 @@
> >   #include "net/hub.h"
> >   #include "qapi/visitor.h"
> >   #include "chardev/char.h"
> > +#include "qemu/uuid.h"
> >   void qdev_prop_set_after_realize(DeviceState *dev, const char *name=
,
> >                                     Error **errp)
> > @@ -883,6 +884,57 @@ const PropertyInfo qdev_prop_pci_host_devaddr =3D=
 {
> >       .set =3D set_pci_host_devaddr,
> >   };
> > +/* --- UUID --- */
> > +
> > +static void get_uuid(Object *obj, Visitor *v, const char *name, void=
 *opaque,
> > +                     Error **errp)
> > +{
> > +    DeviceState *dev =3D DEVICE(obj);
> > +    Property *prop =3D opaque;
> > +    QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
> > +    char buffer[UUID_FMT_LEN + 1];
> > +    char *p =3D buffer;
> > +
> > +    qemu_uuid_unparse(uuid, buffer);
> > +
> > +    visit_type_str(v, name, &p, errp);
> > +}
> > +
> > +static void set_uuid(Object *obj, Visitor *v, const char *name, void=
 *opaque,
> > +                    Error **errp)
> > +{
> > +    DeviceState *dev =3D DEVICE(obj);
> > +    Property *prop =3D opaque;
> > +    QemuUUID *uuid =3D qdev_get_prop_ptr(dev, prop);
> > +    Error *local_err =3D NULL;
> > +    char *str;
> > +
> > +    if (dev->realized) {
> > +        qdev_prop_set_after_realize(dev, name, errp);
> > +        return;
> > +    }
> > +
> > +    visit_type_str(v, name, &str, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    if (!strcmp(str, "auto")) {
> > +        qemu_uuid_generate(uuid);
> > +    } else if (qemu_uuid_parse(str, uuid) < 0) {
> > +        error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str)=
;
> > +    }
> > +    g_free(str);
> > +}
> > +
> > +const PropertyInfo qdev_prop_uuid =3D {
> > +    .name  =3D "str",
> > +    .description =3D "UUID (aka GUID) or \"auto\" for random value",
> > +    .get   =3D get_uuid,
> > +    .set   =3D set_uuid,
>=20
> There is a UUID value you can use as a default in=C2=A0 vl.c, named qem=
u_uuid.
> Just in case you want to set a default value here.

I don't think that would be a good idea. If this UUID property is used in
a device type and the default were used, then every instance of the devic=
e
would use the same UUID, at which point it is a non-unique ID. Much bette=
r
to ue a random UUID, unless you know there is guaranteed to only ever be
one instance of the device type.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
