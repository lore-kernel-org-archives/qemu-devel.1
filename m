Received: from eggs.gnu.org ([209.51.188.92]:50491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1guyBk-0002vn-Gt
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1guyBi-0003QT-Lz
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:31:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1guyBi-0003QF-GF
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 06:31:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id z39so14087411qtz.0
	for <qemu-devel@nongnu.org>; Sat, 16 Feb 2019 03:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20190215155709.15777-1-berrange@redhat.com>
	<20190215155709.15777-8-berrange@redhat.com>
In-Reply-To: <20190215155709.15777-8-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 16 Feb 2019 12:31:06 +0100
Message-ID: <CAMxuvaya2AgWckBA9yGCJxADOP+N5BaDGm6OqAyTZdgtxoh01g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 07/11] authz: add QAuthZSimple object
 type for easy whitelist auth checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Fri, Feb 15, 2019 at 4:58 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> In many cases a single VM will just need to whilelist a single identity

whitelist

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
>       "props": {
>         "identity": "fred"
>       }
>     }
>   }
>
> Or via the command line
>
>   -object authz-simple,id=3Dauthz0,identity=3Dfred
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  authz/Makefile.objs       |   1 +
>  authz/simple.c            | 115 ++++++++++++++++++++++++++++++++++++++
>  authz/trace-events        |   3 +
>  include/authz/simple.h    |  84 ++++++++++++++++++++++++++++
>  qemu-options.hx           |  24 ++++++++
>  tests/Makefile.include    |   3 +
>  tests/test-authz-simple.c |  50 +++++++++++++++++
>  7 files changed, 280 insertions(+)
>  create mode 100644 authz/simple.c
>  create mode 100644 include/authz/simple.h
>  create mode 100644 tests/test-authz-simple.c
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
> index 0000000000..8ab718803e
> --- /dev/null
> +++ b/authz/simple.c
> @@ -0,0 +1,115 @@
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
> +    QAuthZSimple *sauthz =3D QAUTHZ_SIMPLE(obj);
> +
> +    g_free(sauthz->identity);
> +    sauthz->identity =3D g_strdup(value);
> +}
> +
> +
> +static char *
> +qauthz_simple_prop_get_identity(Object *obj,
> +                                Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZSimple *sauthz =3D QAUTHZ_SIMPLE(obj);
> +
> +    return g_strdup(sauthz->identity);
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
> +    QAuthZClass *authz =3D QAUTHZ_CLASS(oc);
> +
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
> index 0000000000..ef13958269
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
> + *      "props": {
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
> index 77bd98e20b..a948cacc07 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4360,6 +4360,30 @@ e.g to launch a SEV guest
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
> +     -object 'authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com=
,,O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB' \
> +     ...
> +@end example
> +
> +Note the use of quotes due to the x509 distinguished name containing
> +whitespace, and escaping of ','.
> +
>  @end table
>
>  ETEXI
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3a6a8d4b17..df1cd255a9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -116,6 +116,7 @@ endif
>  check-unit-y +=3D tests/test-timed-average$(EXESUF)
>  check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-filemonitor$(EXESUF)
>  check-unit-y +=3D tests/test-util-sockets$(EXESUF)
> +check-unit-y +=3D tests/test-authz-simple$(EXESUF)
>  check-unit-y +=3D tests/test-io-task$(EXESUF)
>  check-unit-y +=3D tests/test-io-channel-socket$(EXESUF)
>  check-unit-y +=3D tests/test-io-channel-file$(EXESUF)
> @@ -536,6 +537,7 @@ test-qapi-obj-y =3D tests/test-qapi-visit.o tests/tes=
t-qapi-types.o \
>  benchmark-crypto-obj-y =3D $(crypto-obj-y) $(test-qom-obj-y)
>  test-crypto-obj-y =3D $(crypto-obj-y) $(test-qom-obj-y)
>  test-io-obj-y =3D $(io-obj-y) $(test-crypto-obj-y)
> +test-authz-obj-y =3D $(test-qom-obj-y) $(authz-obj-y)
>  test-block-obj-y =3D $(block-obj-y) $(test-io-obj-y) tests/iothread.o
>
>  tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
> @@ -662,6 +664,7 @@ tests/test-util-filemonitor$(EXESUF): tests/test-util=
-filemonitor.o \
>         $(test-util-obj-y)
>  tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
>         tests/socket-helpers.o $(test-util-obj-y)
> +tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz=
-obj-y)
>  tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
>          tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
> diff --git a/tests/test-authz-simple.c b/tests/test-authz-simple.c
> new file mode 100644
> index 0000000000..2cf14fb87e
> --- /dev/null
> +++ b/tests/test-authz-simple.c
> @@ -0,0 +1,50 @@
> +/*
> + * QEMU simple authorization object testing
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
> +#include "qapi/error.h"
> +
> +#include "authz/simple.h"
> +
> +
> +static void test_authz_simple(void)
> +{
> +    QAuthZSimple *authz =3D qauthz_simple_new("authz0",
> +                                            "cthulu",
> +                                            &error_abort);
> +
> +    g_assert(!qauthz_is_allowed(QAUTHZ(authz), "cthul", &error_abort));
> +    g_assert(qauthz_is_allowed(QAUTHZ(authz), "cthulu", &error_abort));
> +    g_assert(!qauthz_is_allowed(QAUTHZ(authz), "cthuluu", &error_abort))=
;
> +    g_assert(!qauthz_is_allowed(QAUTHZ(authz), "fred", &error_abort));
> +
> +    object_unparent(OBJECT(authz));
> +}
> +
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    g_test_add_func("/authz/simple", test_authz_simple);
> +
> +    return g_test_run();
> +}
> --
> 2.20.1
>
