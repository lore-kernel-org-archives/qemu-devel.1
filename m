Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSiFb-00006F-MB
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gSi4y-0004EH-3t
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:39:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gSi4x-0004E0-Rw
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 07:39:32 -0500
Date: Fri, 30 Nov 2018 13:39:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181130133926.77ba2051@redhat.com>
In-Reply-To: <20181127092801.21777-26-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-26-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 25/28] machine: add compat-props
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Tue, 27 Nov 2018 13:27:58 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Let's make compatiblity properties an interface, so that objects other
> than QDev can benefit from having machine compatiblity properties.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/boards.h    |  2 ++
>  hw/core/compat-props.c | 55 ++++++++++++++++++++++++++++++++++++++++++
>  hw/core/qdev.c         | 24 +++---------------
>  MAINTAINERS            |  1 +
>  hw/core/Makefile.objs  |  1 +
>  tests/Makefile.include |  1 +
>  6 files changed, 64 insertions(+), 20 deletions(-)
>  create mode 100644 hw/core/compat-props.c
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index f743d9d4a4..77d1fc1bef 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -9,6 +9,8 @@
>  #include "qom/object.h"
>  #include "qom/cpu.h"
> =20
> +#define TYPE_COMPAT_PROPS "compat-props"
> +
>  /**
>   * memory_region_allocate_system_memory - Allocate a board's main memory
>   * @mr: the #MemoryRegion to be initialized
> diff --git a/hw/core/compat-props.c b/hw/core/compat-props.c
> new file mode 100644
> index 0000000000..538378e71f
> --- /dev/null
> +++ b/hw/core/compat-props.c
> @@ -0,0 +1,55 @@
> +/*
> + * QEMU Machine compat properties
> + *
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/boards.h"
> +#include "qapi/error.h"
> +
> +typedef struct CompatProps CompatProps;
> +
> +typedef struct CompatPropsClass {
> +    InterfaceClass parent_class;
> +} CompatPropsClass;
> +
> +static const GPtrArray *ac_compat_props;
> +static const GPtrArray *mc_compat_props;
> +
> +void accel_register_compat_props(const GPtrArray *props)
> +{
> +    ac_compat_props =3D props;
> +}
> +
> +void machine_register_compat_props(const GPtrArray *props)
> +{
> +    mc_compat_props =3D props;
> +}
> +
> +static void compat_props_post_init(Object *obj)
> +{
> +    if (ac_compat_props) {
> +        object_apply_global_props(obj, ac_compat_props, &error_abort);
> +    }
> +    if (mc_compat_props) {
> +        object_apply_global_props(obj, mc_compat_props, &error_abort);
> +    }
> +}
> +
> +static void compat_props_register_types(void)
> +{
> +    static const TypeInfo cp_interface_info =3D {
> +        .name          =3D TYPE_COMPAT_PROPS,
> +        .parent        =3D TYPE_INTERFACE,
> +        .class_size =3D sizeof(CompatPropsClass),
> +        .instance_post_init =3D compat_props_post_init,
you went here for implict way to set compat props compared to v3
could elaborate in what order .instance_post_init() hooks
will be called in this case for a Device?
(I mean compat_props_post_init vs device_post_init)

> +    };
> +
> +    type_register_static(&cp_interface_info);
> +}
> +
> +type_init(compat_props_register_types)
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 3b31b2c025..b0ee05f837 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -970,28 +970,8 @@ static void device_initfn(Object *obj)
>      QLIST_INIT(&dev->gpios);
>  }
> =20
> -static const GPtrArray *ac_compat_props;
> -static const GPtrArray *mc_compat_props;
> -
> -void accel_register_compat_props(const GPtrArray *props)
> -{
> -    ac_compat_props =3D props;
> -}
> -
> -void machine_register_compat_props(const GPtrArray *props)
> -{
> -    mc_compat_props =3D props;
> -}
> -
>  static void device_post_init(Object *obj)
>  {
> -    if (ac_compat_props) {
> -        object_apply_global_props(obj, ac_compat_props, &error_abort);
> -    }
> -    if (mc_compat_props) {
> -        object_apply_global_props(obj, mc_compat_props, &error_abort);
> -    }
> -
>      qdev_prop_set_globals(DEVICE(obj));
>  }
> =20
> @@ -1124,6 +1104,10 @@ static const TypeInfo device_type_info =3D {
>      .class_init =3D device_class_init,
>      .abstract =3D true,
>      .class_size =3D sizeof(DeviceClass),
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_COMPAT_PROPS },
> +        { }
> +    }
>  };
> =20
>  static void qdev_register_types(void)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9410bbb7cf..adff09627f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1145,6 +1145,7 @@ Machine core
>  M: Eduardo Habkost <ehabkost@redhat.com>
>  M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>  S: Supported
> +F: hw/core/compat-props.c
>  F: hw/core/machine.c
>  F: hw/core/null-machine.c
>  F: include/hw/boards.h
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index a799c83815..f15b3c970a 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -1,5 +1,6 @@
>  # core qdev-related obj files, also used by *-user:
>  common-obj-y +=3D qdev.o qdev-properties.o
> +common-obj-y +=3D compat-props.o
>  common-obj-y +=3D bus.o reset.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fb0b449c02..fc74358c0a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -567,6 +567,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qde=
v-global-props.o \
>  	hw/core/irq.o \
>  	hw/core/fw-path-provider.o \
>  	hw/core/reset.o \
> +	hw/core/compat-props.o \
>  	$(test-qapi-obj-y)
>  tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
>  	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
