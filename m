Received: from eggs.gnu.org ([2001:4830:134:3::10]:40870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gDRW2-0005SL-4k
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gDRVu-0007XN-1d
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:56:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gDRVt-0007W0-Q9
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:56:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so3079153wmc.5
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 02:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-8-berrange@redhat.com>
In-Reply-To: <20181009130442.26296-8-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 19 Oct 2018 11:56:00 +0200
Message-ID: <CAP+75-Wkd8m+s-C_eA2uGQLreVh9MXqfuOeK4f8q48DjbBg92g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 07/11] authz: add QAuthZSimple object
 type for easy whitelist auth checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On 09/10/2018 15:04, Daniel P. Berrang=C3=A9 wrote:
> In many cases a single VM will just need to whilelist a single identity
> as the allowed user of network services. This is especially the case for
> TLS live migration (optionally with NBD storage) where we just need to
> whitelist the x509 certificate distinguished name of the source QEMU
> host.
>
> Via QMP this can be configured with:
>
>   {
>     "execute": "object-add",
>     "arguments": {
>       "qom-type": "authz-simple",
>       "id": "authz0",
>       "parameters": {
>         "identity": "fred"
>       }
>     }
>   }
>
> Or via the command line
>
>   -object authz-simple,id=3Dauthz0,identity=3Dfred
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  authz/Makefile.objs    |   1 +
>  authz/simple.c         | 122 +++++++++++++++++++++++++++++++++++++++++
>  authz/trace-events     |   3 +
>  include/authz/simple.h |  84 ++++++++++++++++++++++++++++
>  qemu-options.hx        |  21 +++++++
>  5 files changed, 231 insertions(+)
>  create mode 100644 authz/simple.c
>  create mode 100644 include/authz/simple.h
>
> diff --git a/authz/Makefile.objs b/authz/Makefile.objs
> index 12597c9528..2a75d53840 100644
> --- a/authz/Makefile.objs
> +++ b/authz/Makefile.objs
> @@ -1 +1,2 @@
>  authz-obj-y +=3D base.o
> +authz-obj-y +=3D simple.o
> diff --git a/authz/simple.c b/authz/simple.c
> new file mode 100644
> index 0000000000..1ed1605b14
> --- /dev/null
> +++ b/authz/simple.c
> @@ -0,0 +1,122 @@
> +/*
> + * QEMU simple authorization driver
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "authz/simple.h"
> +#include "authz/trace.h"
> +#include "qom/object_interfaces.h"
> +
> +static bool qauthz_simple_is_allowed(QAuthZ *authz,
> +                                     const char *identity,
> +                                     Error **errp)
> +{
> +    QAuthZSimple *sauthz =3D QAUTHZ_SIMPLE(authz);
> +
> +    trace_qauthz_simple_is_allowed(authz, sauthz->identity, identity);
> +    return g_str_equal(identity, sauthz->identity);
> +}
> +
> +static void
> +qauthz_simple_prop_set_identity(Object *obj,
> +                                const char *value,
> +                                Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZSimple *authz =3D QAUTHZ_SIMPLE(obj);
> +

Hmm don't this miss:

         g_free(authz->identity);

> +    authz->identity =3D g_strdup(value);
> +}
> +
> +
> +static char *
> +qauthz_simple_prop_get_identity(Object *obj,
> +                                Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZSimple *authz =3D QAUTHZ_SIMPLE(obj);
> +
> +    return g_strdup(authz->identity);
> +}
> +
> +
> +static void
> +qauthz_simple_complete(UserCreatable *uc, Error **errp)
> +{
> +}
> +
> +
> +static void
> +qauthz_simple_finalize(Object *obj)
> +{
> +    QAuthZSimple *sauthz =3D QAUTHZ_SIMPLE(obj);
> +
> +    g_free(sauthz->identity);
> +}
> +
> +
> +static void
> +qauthz_simple_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +    QAuthZClass *authz =3D QAUTHZ_CLASS(oc);
> +
> +    ucc->complete =3D qauthz_simple_complete;
> +    authz->is_allowed =3D qauthz_simple_is_allowed;
> +
> +    object_class_property_add_str(oc, "identity",
> +                                  qauthz_simple_prop_get_identity,
> +                                  qauthz_simple_prop_set_identity,
> +                                  NULL);
> +}
> +
> +
> +QAuthZSimple *qauthz_simple_new(const char *id,
> +                                const char *identity,
> +                                Error **errp)
> +{
> +    return QAUTHZ_SIMPLE(
> +        object_new_with_props(TYPE_QAUTHZ_SIMPLE,
> +                              object_get_objects_root(),
> +                              id, errp,
> +                              "identity", identity,
> +                              NULL));
> +}
> +
> +
> +static const TypeInfo qauthz_simple_info =3D {
> +    .parent =3D TYPE_QAUTHZ,
> +    .name =3D TYPE_QAUTHZ_SIMPLE,
> +    .instance_size =3D sizeof(QAuthZSimple),
> +    .instance_finalize =3D qauthz_simple_finalize,
> +    .class_size =3D sizeof(QAuthZSimpleClass),
> +    .class_init =3D qauthz_simple_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +
> +static void
> +qauthz_simple_register_types(void)
> +{
> +    type_register_static(&qauthz_simple_info);
> +}
> +
> +
> +type_init(qauthz_simple_register_types);
> diff --git a/authz/trace-events b/authz/trace-events
> index 481c90f511..1ef796c1e1 100644
> --- a/authz/trace-events
> +++ b/authz/trace-events
> @@ -2,3 +2,6 @@
>
>  # authz/base.c
>  qauthz_is_allowed(void *authz, const char *identity, bool allowed) "Auth=
Z %p check identity=3D%s allowed=3D%d"
> +
> +# auth/simple.c
> +qauthz_simple_is_allowed(void *authz, const char *wantidentity, const ch=
ar *gotidentity) "AuthZ simple %p check want identity=3D%s got identity=3D%=
s"
> diff --git a/include/authz/simple.h b/include/authz/simple.h
> new file mode 100644
> index 0000000000..4686e7676d
> --- /dev/null
> +++ b/include/authz/simple.h
> @@ -0,0 +1,84 @@
> +/*
> + * QEMU simple authorization driver
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#ifndef QAUTHZ_SIMPLE_H__
> +#define QAUTHZ_SIMPLE_H__
> +
> +#include "authz/base.h"
> +
> +#define TYPE_QAUTHZ_SIMPLE "authz-simple"
> +
> +#define QAUTHZ_SIMPLE_CLASS(klass)                        \
> +    OBJECT_CLASS_CHECK(QAuthZSimpleClass, (klass),        \
> +                       TYPE_QAUTHZ_SIMPLE)
> +#define QAUTHZ_SIMPLE_GET_CLASS(obj)              \
> +    OBJECT_GET_CLASS(QAuthZSimpleClass, (obj),    \
> +                      TYPE_QAUTHZ_SIMPLE)
> +#define QAUTHZ_SIMPLE(obj) \
> +    INTERFACE_CHECK(QAuthZSimple, (obj),          \
> +                    TYPE_QAUTHZ_SIMPLE)
> +
> +typedef struct QAuthZSimple QAuthZSimple;
> +typedef struct QAuthZSimpleClass QAuthZSimpleClass;
> +
> +
> +/**
> + * QAuthZSimple:
> + *
> + * This authorization driver provides a simple mechanism
> + * for granting access based on an exact matched username.
> + *
> + * To create an instance of this class via QMP:
> + *
> + *  {
> + *    "execute": "object-add",
> + *    "arguments": {
> + *      "qom-type": "authz-simple",
> + *      "id": "authz0",
> + *      "parameters": {
> + *        "identity": "fred"
> + *      }
> + *    }
> + *  }
> + *
> + * Or via the command line
> + *
> + *   -object authz-simple,id=3Dauthz0,identity=3Dfred
> + *
> + */
> +struct QAuthZSimple {
> +    QAuthZ parent_obj;
> +
> +    char *identity;
> +};
> +
> +
> +struct QAuthZSimpleClass {
> +    QAuthZClass parent_class;
> +};
> +
> +
> +QAuthZSimple *qauthz_simple_new(const char *id,
> +                                const char *identity,
> +                                Error **errp);
> +
> +
> +#endif /* QAUTHZ_SIMPLE_H__ */
> +
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f139459e80..ef38ff19e2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4377,6 +4377,27 @@ e.g to launch a SEV guest
>       .....
>
>  @end example
> +
> +
> +@item -object authz-simple,id=3D@var{id},identity=3D@var{string}
> +
> +Create an authorization object that will control access to network servi=
ces.
> +
> +The @option{identity} parameter is identifies the user and its format
> +depends on the network service that authorization object is associated
> +with. For authorizing based on TLS x509 certificates, the identity must
> +be the x509 distinguished name. Note that care must be taken to escape
> +any commas in the distinguished name.
> +
> +An example authorization object to validate a x509 distinguished name
> +would look like:
> +@example
> + # $QEMU \
> +     ...
> +     -object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com,=
,O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \
> +     ...

$ x86_64-softmmu/qemu-system-x86_64 -trace auth\* -object
authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com,,O=3DExample
Org,,L=3DLondon,,ST=3DLondon,,C=3DGB
qemu-system-x86_64: -object
authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com,,O=3DExample: Co=
uld
not open 'Org,,L=3DLondon,,ST=3DLondon,,C=3DGB': No such file or directory

$ x86_64-softmmu/qemu-system-x86_64 -trace auth\* -object
authz-simple,id=3Dauth0,identity=3D'CN=3Dlaptop.example.com,,O=3DExample
Org,,L=3DLondon,,ST=3DLondon,,C=3DGB'

> +@end example
> +
>  @end table
>
>  ETEXI
>
