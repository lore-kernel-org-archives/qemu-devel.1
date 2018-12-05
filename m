Received: from eggs.gnu.org ([2001:4830:134:3::10]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUakR-0006Wq-IV
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUajw-0007jv-SW
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:13:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUajw-0007dQ-LC
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:13:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id a18so13764932wmj.1
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 09:13:35 -0800 (PST)
References: <20181130140615.19937-1-berrange@redhat.com>
	<20181130140615.19937-8-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d878987-844a-7f95-e44a-84e8044146c7@redhat.com>
Date: Wed, 5 Dec 2018 18:13:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181130140615.19937-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 07/11] authz: add QAuthZSimple object
 type for easy whitelist auth checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Hi Daniel,

On 11/30/18 3:06 PM, Daniel P. Berrangé wrote:
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

This example should be "parameters" -> "props"

>         "identity": "fred"
>       }
>     }
>   }
> 
> Or via the command line
> 
>   -object authz-simple,id=authz0,identity=fred
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
>  authz-obj-y += base.o
> +authz-obj-y += simple.o
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
> +    QAuthZSimple *sauthz = QAUTHZ_SIMPLE(authz);
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
> +    QAuthZSimple *sauthz = QAUTHZ_SIMPLE(obj);
> +
> +    g_free(sauthz->identity);
> +    sauthz->identity = g_strdup(value);
> +}
> +
> +
> +static char *
> +qauthz_simple_prop_get_identity(Object *obj,
> +                                Error **errp G_GNUC_UNUSED)
> +{
> +    QAuthZSimple *sauthz = QAUTHZ_SIMPLE(obj);
> +
> +    return g_strdup(sauthz->identity);
> +}
> +
> +
> +static void
> +qauthz_simple_finalize(Object *obj)
> +{
> +    QAuthZSimple *sauthz = QAUTHZ_SIMPLE(obj);
> +
> +    g_free(sauthz->identity);
> +}
> +
> +
> +static void
> +qauthz_simple_class_init(ObjectClass *oc, void *data)
> +{
> +    QAuthZClass *authz = QAUTHZ_CLASS(oc);
> +
> +    authz->is_allowed = qauthz_simple_is_allowed;
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
> +static const TypeInfo qauthz_simple_info = {
> +    .parent = TYPE_QAUTHZ,
> +    .name = TYPE_QAUTHZ_SIMPLE,
> +    .instance_size = sizeof(QAuthZSimple),
> +    .instance_finalize = qauthz_simple_finalize,
> +    .class_size = sizeof(QAuthZSimpleClass),
> +    .class_init = qauthz_simple_class_init,
> +    .interfaces = (InterfaceInfo[]) {
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
>  qauthz_is_allowed(void *authz, const char *identity, bool allowed) "AuthZ %p check identity=%s allowed=%d"
> +
> +# auth/simple.c
> +qauthz_simple_is_allowed(void *authz, const char *wantidentity, const char *gotidentity) "AuthZ simple %p check want identity=%s got identity=%s"
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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

Ditto.

> + *        "identity": "fred"
> + *      }
> + *    }
> + *  }
> + *
> + * Or via the command line
> + *
> + *   -object authz-simple,id=authz0,identity=fred
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
> index 269eda7a5d..7732881e7a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4403,6 +4403,30 @@ e.g to launch a SEV guest
>       .....
>  
>  @end example
> +
> +
> +@item -object authz-simple,id=@var{id},identity=@var{string}
> +
> +Create an authorization object that will control access to network services.
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
> +     -object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,O=Example Org,,L=London,,ST=London,,C=GB' \
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
> index e339287021..6dda623607 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -112,6 +112,7 @@ endif
>  check-unit-y += tests/test-timed-average$(EXESUF)
>  check-unit-$(CONFIG_INOTIFY1) += tests/test-util-filemonitor$(EXESUF)
>  check-unit-y += tests/test-util-sockets$(EXESUF)
> +check-unit-y += tests/test-authz-simple$(EXESUF)
>  check-unit-y += tests/test-io-task$(EXESUF)
>  check-unit-y += tests/test-io-channel-socket$(EXESUF)
>  check-unit-y += tests/test-io-channel-file$(EXESUF)
> @@ -516,6 +517,7 @@ test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
>  benchmark-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
>  test-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
>  test-io-obj-y = $(io-obj-y) $(test-crypto-obj-y)
> +test-authz-obj-y = $(test-qom-obj-y) $(authz-obj-y)
>  test-block-obj-y = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
>  
>  tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
> @@ -641,6 +643,7 @@ tests/test-util-filemonitor$(EXESUF): tests/test-util-filemonitor.o \
>  	$(test-util-obj-y)
>  tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
>  	tests/socket-helpers.o $(test-util-obj-y)
> +tests/test-authz-simple$(EXESUF): tests/test-authz-simple.o $(test-authz-obj-y)
>  tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
>  tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
>          tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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
> +    QAuthZSimple *authz = qauthz_simple_new("authz0",
> +                                            "cthulu",
> +                                            &error_abort);
> +
> +    g_assert(!qauthz_is_allowed(QAUTHZ(authz), "cthul", &error_abort));
> +    g_assert(qauthz_is_allowed(QAUTHZ(authz), "cthulu", &error_abort));
> +    g_assert(!qauthz_is_allowed(QAUTHZ(authz), "cthuluu", &error_abort));
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
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
