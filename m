Received: from eggs.gnu.org ([2001:4830:134:3::10]:41513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKWFK-0006SS-Cm
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gKWFE-00021m-VD
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:24:20 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gKWF7-0001u5-V6
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:24:11 -0500
Received: by mail-wm1-x343.google.com with SMTP id t15-v6so9345682wmt.0
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 14:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-7-berrange@redhat.com>
In-Reply-To: <20181019133835.16494-7-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Nov 2018 02:23:55 +0400
Message-ID: <CAJ+F1CJ+oc-cmXjNmruzcGo_XH1AXeTTWu006PxCJs4E9dYSTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 06/11] authz: add QAuthZ object as an
 authorization base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, philmd@redhat.com

On Fri, Oct 19, 2018 at 5:46 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> From: "Daniel P. Berrange" <berrange@redhat.com>
>
> The current qemu_acl module provides a simple access control list
> facility inside QEMU, which is used via a set of monitor commands
> acl_show, acl_policy, acl_add, acl_remove & acl_reset.
>
> Note there is no ability to create ACLs - the network services (eg VNC
> server) were expected to create ACLs that they want to check.
>
> There is also no way to define ACLs on the command line, nor potentially
> integrate with external authorization systems like polkit, pam, ldap
> lookup, etc.
>
> The QAuthZ object defines a minimal abstract QOM class that can be
> subclassed for creating different authorization providers.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  Makefile             |  10 ++--
>  Makefile.objs        |   6 +++
>  Makefile.target      |   2 +
>  include/authz/base.h | 112 +++++++++++++++++++++++++++++++++++++++++++
>  authz/base.c         |  82 +++++++++++++++++++++++++++++++
>  MAINTAINERS          |   7 +++
>  authz/Makefile.objs  |   1 +
>  authz/trace-events   |   4 ++
>  8 files changed, 220 insertions(+), 4 deletions(-)
>  create mode 100644 include/authz/base.h
>  create mode 100644 authz/base.c
>  create mode 100644 authz/Makefile.objs
>  create mode 100644 authz/trace-events
>
> diff --git a/Makefile b/Makefile
> index f2947186a4..4b20ee2b19 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -412,6 +412,7 @@ endif
>
>  dummy :=3D $(call unnest-vars,, \
>                  stub-obj-y \
> +                authz-obj-y \
>                  chardev-obj-y \
>                  util-obj-y \
>                  qga-obj-y \
> @@ -474,6 +475,7 @@ qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_P=
ATH)/scripts/hxtool
>  SUBDIR_RULES=3D$(patsubst %,subdir-%, $(TARGET_DIRS))
>  SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_RULES))
>
> +$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
> @@ -536,9 +538,9 @@ COMMON_LDADDS =3D libqemuutil.a
>
>  qemu-img.o: qemu-img-cmds.h
>
> -qemu-img$(EXESUF): qemu-img.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y)=
 $(qom-obj-y) $(COMMON_LDADDS)
> -qemu-nbd$(EXESUF): qemu-nbd.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y)=
 $(qom-obj-y) $(COMMON_LDADDS)
> -qemu-io$(EXESUF): qemu-io.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $=
(qom-obj-y) $(COMMON_LDADDS)
> +qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> +qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> +qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>
>  qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
>
> @@ -549,7 +551,7 @@ qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-gener=
ate.o $(COMMON_LDADDS)
>  fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p=
-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
>  fsdev/virtfs-proxy-helper$(EXESUF): LIBS +=3D -lcap
>
> -scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(crypt=
o-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> +scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(authz=
-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>  ifdef CONFIG_MPATH
>  scsi/qemu-pr-helper$(EXESUF): LIBS +=3D -ludev -lmultipath -lmpathpersis=
t
>  endif
> diff --git a/Makefile.objs b/Makefile.objs
> index 1e1ff387d7..ecb1071c4f 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -62,6 +62,11 @@ util-obj-y +=3D qapi/qapi-introspect.o
>
>  chardev-obj-y =3D chardev/
>
> +#######################################################################
> +# authz-obj-y is code used by both qemu system emulation and qemu-img
> +
> +authz-obj-y =3D authz/
> +
>  #######################################################################
>  # block-obj-y is code used by both qemu system emulation and qemu-img
>
> @@ -200,6 +205,7 @@ trace-events-subdirs =3D
>  trace-events-subdirs +=3D accel/kvm
>  trace-events-subdirs +=3D accel/tcg
>  trace-events-subdirs +=3D audio
> +trace-events-subdirs +=3D authz
>  trace-events-subdirs +=3D block
>  trace-events-subdirs +=3D chardev
>  trace-events-subdirs +=3D crypto
> diff --git a/Makefile.target b/Makefile.target
> index 4d56298bbf..c08461726d 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -172,6 +172,7 @@ include $(SRC_PATH)/Makefile.objs
>  dummy :=3D $(call unnest-vars,,target-obj-y)
>  target-obj-y-save :=3D $(target-obj-y)
>  dummy :=3D $(call unnest-vars,.., \
> +               authz-obj-y \
>                 block-obj-y \
>                 block-obj-m \
>                 chardev-obj-y \
> @@ -185,6 +186,7 @@ target-obj-y :=3D $(target-obj-y-save)
>  all-obj-y +=3D $(common-obj-y)
>  all-obj-y +=3D $(target-obj-y)
>  all-obj-y +=3D $(qom-obj-y)
> +all-obj-$(CONFIG_SOFTMMU) +=3D $(authz-obj-y)
>  all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
>  all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
>  all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
> diff --git a/include/authz/base.h b/include/authz/base.h
> new file mode 100644
> index 0000000000..77dcd54c4c
> --- /dev/null
> +++ b/include/authz/base.h
> @@ -0,0 +1,112 @@
> +/*
> + * QEMU authorization framework base class
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
> +#ifndef QAUTHZ_BASE_H__
> +#define QAUTHZ_BASE_H__
> +
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "qom/object.h"
> +
> +
> +#define TYPE_QAUTHZ "authz"
> +
> +#define QAUTHZ_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(QAuthZClass, (klass), \
> +                        TYPE_QAUTHZ)
> +#define QAUTHZ_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(QAuthZClass, (obj), \
> +                      TYPE_QAUTHZ)
> +#define QAUTHZ(obj) \
> +     INTERFACE_CHECK(QAuthZ, (obj), \
> +                     TYPE_QAUTHZ)
> +
> +typedef struct QAuthZ QAuthZ;
> +typedef struct QAuthZClass QAuthZClass;
> +
> +/**
> + * QAuthZ:
> + *
> + * The QAuthZ class defines an API contract to be used
> + * for providing an authorization driver for services
> + * with user identities.
> + */
> +
> +struct QAuthZ {
> +    Object parent_obj;
> +};
> +
> +
> +struct QAuthZClass {
> +    ObjectClass parent_class;
> +
> +    bool (*is_allowed)(QAuthZ *authz,
> +                       const char *identity,
> +                       Error **errp);
> +};
> +
> +
> +/**
> + * qauthz_is_allowed:
> + * @authz: the authorization object
> + * @identity: the user identity to authorize
> + * @errp: pointer to a NULL initialized error object
> + *
> + * Check if a user @identity is authorized. If an error
> + * occurs this method will return false to indicate
> + * denial, as well as setting @errp to contain the details.
> + * Callers are recommended to treat the denial and error
> + * scenarios identically. Specifically the error info in
> + * @errp should never be fed back to the user being
> + * authorized, it is merely for benefit of administrator
> + * debugging.
> + *
> + * Returns: true if @identity is authorized, false if denied or if
> + * an error occurred.
> + */
> +bool qauthz_is_allowed(QAuthZ *authz,
> +                       const char *identity,
> +                       Error **errp);
> +
> +
> +/**
> + * qauthz_is_allowed_by_id:
> + * @authzid: ID of the authorization object
> + * @identity: the user identity to authorize
> + * @errp: pointer to a NULL initialized error object
> + *
> + * Check if a user @identity is authorized. If an error
> + * occurs this method will return false to indicate
> + * denial, as well as setting @errp to contain the details.
> + * Callers are recommended to treat the denial and error
> + * scenarios identically. Specifically the error info in
> + * @errp should never be fed back to the user being
> + * authorized, it is merely for benefit of administrator
> + * debugging.
> + *
> + * Returns: true if @identity is authorized, false if denied or if
> + * an error occurred.
> + */
> +bool qauthz_is_allowed_by_id(const char *authzid,
> +                             const char *identity,
> +                             Error **errp);
> +
> +#endif /* QAUTHZ_BASE_H__ */
> +
> diff --git a/authz/base.c b/authz/base.c
> new file mode 100644
> index 0000000000..110dfa4195
> --- /dev/null
> +++ b/authz/base.c
> @@ -0,0 +1,82 @@
> +/*
> + * QEMU authorization framework base class
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
> +#include "authz/base.h"
> +#include "authz/trace.h"
> +
> +bool qauthz_is_allowed(QAuthZ *authz,
> +                       const char *identity,
> +                       Error **errp)
> +{
> +    QAuthZClass *cls =3D QAUTHZ_GET_CLASS(authz);
> +    bool allowed;
> +
> +    allowed =3D cls->is_allowed(authz, identity, errp);
> +    trace_qauthz_is_allowed(authz, identity, allowed);
> +
> +    return allowed;
> +}
> +
> +
> +bool qauthz_is_allowed_by_id(const char *authzid,
> +                             const char *identity,
> +                             Error **errp)
> +{
> +    QAuthZ *authz;
> +    Object *obj;
> +    Object *container;
> +
> +    container =3D object_get_objects_root();
> +    obj =3D object_resolve_path_component(container,
> +                                        authzid);
> +    if (!obj) {
> +        error_setg(errp, "Cannot find QAuthZ object ID %s",
> +                   authzid);
> +        return false;
> +    }
> +
> +    if (!object_dynamic_cast(obj, TYPE_QAUTHZ)) {
> +        error_setg(errp, "Object '%s' is not a QAuthZ subclass",
> +                   authzid);
> +        return false;
> +    }
> +
> +    authz =3D QAUTHZ(obj);
> +
> +    return qauthz_is_allowed(authz, identity, errp);
> +}
> +
> +
> +static const TypeInfo authz_info =3D {
> +    .parent =3D TYPE_OBJECT,
> +    .name =3D TYPE_QAUTHZ,
> +    .instance_size =3D sizeof(QAuthZ),
> +    .class_size =3D sizeof(QAuthZClass),
> +    .abstract =3D true,
> +};
> +
> +static void qauthz_register_types(void)
> +{
> +    type_register_static(&authz_info);
> +}
> +
> +type_init(qauthz_register_types)
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29bbcf8c25..9624734923 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1857,6 +1857,13 @@ F: io/
>  F: include/io/
>  F: tests/test-io-*
>
> +User authorization
> +M: Daniel P. Berrange <berrange@redhat.com>
> +S: Maintained
> +F: authz/
> +F: include/authz/
> +F: tests/test-authz-*
> +
>  Sockets
>  M: Daniel P. Berrange <berrange@redhat.com>
>  M: Gerd Hoffmann <kraxel@redhat.com>
> diff --git a/authz/Makefile.objs b/authz/Makefile.objs
> new file mode 100644
> index 0000000000..12597c9528
> --- /dev/null
> +++ b/authz/Makefile.objs
> @@ -0,0 +1 @@
> +authz-obj-y +=3D base.o
> diff --git a/authz/trace-events b/authz/trace-events
> new file mode 100644
> index 0000000000..481c90f511
> --- /dev/null
> +++ b/authz/trace-events
> @@ -0,0 +1,4 @@
> +# See docs/devel/tracing.txt for syntax documentation.
> +
> +# authz/base.c
> +qauthz_is_allowed(void *authz, const char *identity, bool allowed) "Auth=
Z %p check identity=3D%s allowed=3D%d"
> --
> 2.17.2
>
>


--
Marc-Andr=C3=A9 Lureau
