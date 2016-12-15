Received: from eggs.gnu.org ([2001:4830:134:3::10]:59729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cHSAQ-0001iY-6M
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cHSAM-0002lB-UG
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:17:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cHSAM-0002kY-LT
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:17:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481738323-9147-1-git-send-email-ehabkost@redhat.com>
Date: Thu, 15 Dec 2016 10:17:27 +0100
In-Reply-To: <1481738323-9147-1-git-send-email-ehabkost@redhat.com> (Eduardo
	Habkost's message of "Wed, 14 Dec 2016 15:58:43 -0200")
Message-ID: <87d1gt4km0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qom: Make all interface types abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Lin Ma <lma@suse.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> "qom-list-types abstract=3Dfalse" currently returns all interface
> types, as if they were not abstract. Fix this by making sure all
> interface types are abstract.
>
> All interface types have instance_size =3D=3D 0, so we can use
> it to set abstract=3Dtrue on type_initialize().
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Use old-fashioned if statement instead of "|=3D" on bool field
>   Suggested-by: Andreas F=C3=A4rber <afaerber@suse.de>
> * Keep "device/introspect" path prefix on unit test
>   * Suggested-by: Andreas F=C3=A4rber <afaerber@suse.de>
>
> Changes v2 -> v3:
> * Instead of making interfaces implicitly abstract,
>   set abstract=3Dtrue explicitly for all of them and replace
>   type_initialize() abstract=3Dtrue code with an assert().
>   Suggested-by: Markus Armbruster <armbru@redhat.com>
> * Try to make test code a bit more clear
> ---
>  hw/acpi/acpi_interface.c       |  1 +
>  hw/arm/boot.c                  |  1 +
>  hw/core/fw-path-provider.c     |  1 +
>  hw/core/hotplug.c              |  1 +
>  hw/core/nmi.c                  |  1 +
>  hw/core/stream.c               |  1 +
>  hw/intc/intc.c                 |  1 +
>  hw/ipmi/ipmi.c                 |  1 +
>  hw/isa/isa-bus.c               |  1 +
>  hw/ppc/pnv_xscom.c             |  1 +
>  hw/timer/m48t59.c              |  1 +
>  qom/object.c                   |  2 ++
>  qom/object_interfaces.c        |  1 +
>  tests/check-qom-interface.c    |  1 +
>  tests/device-introspect-test.c | 58 ++++++++++++++++++++++++++++++++++++=
+++---
>  15 files changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/hw/acpi/acpi_interface.c b/hw/acpi/acpi_interface.c
> index 6583917..49388a9 100644
> --- a/hw/acpi/acpi_interface.c
> +++ b/hw/acpi/acpi_interface.c
> @@ -16,6 +16,7 @@ static void register_types(void)
>      static const TypeInfo acpi_dev_if_info =3D {
>          .name          =3D TYPE_ACPI_DEVICE_IF,
>          .parent        =3D TYPE_INTERFACE,
> +        .abstract =3D true,
>          .class_size =3D sizeof(AcpiDeviceIfClass),
>      };
>=20=20
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index ff621e4..65c59b5 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -1031,6 +1031,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_i=
nfo *info)
>  static const TypeInfo arm_linux_boot_if_info =3D {
>      .name =3D TYPE_ARM_LINUX_BOOT_IF,
>      .parent =3D TYPE_INTERFACE,
> +    .abstract =3D true,
>      .class_size =3D sizeof(ARMLinuxBootIfClass),
>  };
>=20=20
> diff --git a/hw/core/fw-path-provider.c b/hw/core/fw-path-provider.c
> index 33b9983..96f3131 100644
> --- a/hw/core/fw-path-provider.c
> +++ b/hw/core/fw-path-provider.c
> @@ -42,6 +42,7 @@ char *fw_path_provider_try_get_dev_path(Object *o, BusS=
tate *bus,
>  static const TypeInfo fw_path_provider_info =3D {
>      .name          =3D TYPE_FW_PATH_PROVIDER,
>      .parent        =3D TYPE_INTERFACE,
> +    .abstract      =3D true,
>      .class_size    =3D sizeof(FWPathProviderClass),
>  };
>=20=20
> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
> index 17ac986..f74fba5 100644
> --- a/hw/core/hotplug.c
> +++ b/hw/core/hotplug.c
> @@ -60,6 +60,7 @@ void hotplug_handler_unplug(HotplugHandler *plug_handle=
r,
>  static const TypeInfo hotplug_handler_info =3D {
>      .name          =3D TYPE_HOTPLUG_HANDLER,
>      .parent        =3D TYPE_INTERFACE,
> +    .abstract      =3D true,
>      .class_size =3D sizeof(HotplugHandlerClass),
>  };
>=20=20
> diff --git a/hw/core/nmi.c b/hw/core/nmi.c
> index bfd0896..403edd3 100644
> --- a/hw/core/nmi.c
> +++ b/hw/core/nmi.c
> @@ -76,6 +76,7 @@ void nmi_monitor_handle(int cpu_index, Error **errp)
>  static const TypeInfo nmi_info =3D {
>      .name          =3D TYPE_NMI,
>      .parent        =3D TYPE_INTERFACE,
> +    .abstract      =3D true,
>      .class_size    =3D sizeof(NMIClass),
>  };
>=20=20
> diff --git a/hw/core/stream.c b/hw/core/stream.c
> index 4439ecd..db7f90b 100644
> --- a/hw/core/stream.c
> +++ b/hw/core/stream.c
> @@ -21,6 +21,7 @@ stream_can_push(StreamSlave *sink, StreamCanPushNotifyF=
n notify,
>  static const TypeInfo stream_slave_info =3D {
>      .name          =3D TYPE_STREAM_SLAVE,
>      .parent        =3D TYPE_INTERFACE,
> +    .abstract      =3D true,
>      .class_size =3D sizeof(StreamSlaveClass),
>  };
>=20=20
> diff --git a/hw/intc/intc.c b/hw/intc/intc.c
> index 2e1e29e..9373546 100644
> --- a/hw/intc/intc.c
> +++ b/hw/intc/intc.c
> @@ -29,6 +29,7 @@
>  static const TypeInfo intctrl_info =3D {
>      .name =3D TYPE_INTERRUPT_STATS_PROVIDER,
>      .parent =3D TYPE_INTERFACE,
> +    .abstract =3D true,
>      .class_size =3D sizeof(InterruptStatsProviderClass),
>  };
>=20=20
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index 5cf1caa..c255499 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -86,6 +86,7 @@ static void ipmi_interface_class_init(ObjectClass *clas=
s, void *data)
>  static TypeInfo ipmi_interface_type_info =3D {
>      .name =3D TYPE_IPMI_INTERFACE,
>      .parent =3D TYPE_INTERFACE,
> +    .abstract =3D true,
>      .class_size =3D sizeof(IPMIInterfaceClass),
>      .class_init =3D ipmi_interface_class_init,
>  };
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 9d07b11..a1cad86 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -41,6 +41,7 @@ static void isa_bus_class_init(ObjectClass *klass, void=
 *data)
>  static const TypeInfo isa_dma_info =3D {
>      .name =3D TYPE_ISADMA,
>      .parent =3D TYPE_INTERFACE,
> +    .abstract =3D true,
>      .class_size =3D sizeof(IsaDmaClass),
>  };
>=20=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 8da2718..642f104 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -192,6 +192,7 @@ void pnv_xscom_realize(PnvChip *chip, Error **errp)
>  static const TypeInfo pnv_xscom_interface_info =3D {
>      .name =3D TYPE_PNV_XSCOM_INTERFACE,
>      .parent =3D TYPE_INTERFACE,
> +    .abstract =3D true,
>      .class_size =3D sizeof(PnvXScomInterfaceClass),
>  };
>=20=20
> diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
> index e46ca88..42c5fc7 100644
> --- a/hw/timer/m48t59.c
> +++ b/hw/timer/m48t59.c
> @@ -884,6 +884,7 @@ static void m48txx_sysbus_concrete_class_init(ObjectC=
lass *klass, void *data)
>  static const TypeInfo nvram_info =3D {
>      .name =3D TYPE_NVRAM,
>      .parent =3D TYPE_INTERFACE,
> +    .abstract =3D true,
>      .class_size =3D sizeof(NvramClass),
>  };
>=20=20
> diff --git a/qom/object.c b/qom/object.c
> index 7a05e35..d93989a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -272,6 +272,8 @@ static void type_initialize(TypeImpl *ti)
>=20=20
>      ti->class_size =3D type_class_get_size(ti);
>      ti->instance_size =3D type_object_get_size(ti);
> +    /* types with zero instance_size can't be instantiated, must be abst=
ract */
> +    assert(ti->instance_size > 0 || ti->abstract);
>=20=20
>      ti->class =3D g_malloc0(ti->class_size);
>=20=20

Separate idea: should type_initialize_interface() check
!interface_type->instance_size?

> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index ded4d84..f6dc46c 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -217,6 +217,7 @@ static void register_types(void)
>      static const TypeInfo uc_interface_info =3D {
>          .name          =3D TYPE_USER_CREATABLE,
>          .parent        =3D TYPE_INTERFACE,
> +        .abstract      =3D true,
>          .class_size =3D sizeof(UserCreatableClass),
>      };
>=20=20
> diff --git a/tests/check-qom-interface.c b/tests/check-qom-interface.c
> index f87c9aa..560b7e2 100644
> --- a/tests/check-qom-interface.c
> +++ b/tests/check-qom-interface.c
> @@ -36,6 +36,7 @@ typedef struct TestIfClass {
>  static const TypeInfo test_if_info =3D {
>      .name          =3D TYPE_TEST_IF,
>      .parent        =3D TYPE_INTERFACE,
> +    .abstract      =3D true,
>      .class_size =3D sizeof(TestIfClass),
>  };
>=20=20

Just 13 .abstract =3D true; fairly harmless.

> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-tes=
t.c
> index 37debc1..4fa8d29 100644
> --- a/tests/device-introspect-test.c
> +++ b/tests/device-introspect-test.c
> @@ -20,18 +20,24 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qbool.h"
> +#include "qapi/qmp/qdict.h"
>  #include "libqtest.h"
>=20=20
>  const char common_args[] =3D "-nodefaults -machine none";
>=20=20
> -static QList *device_type_list(bool abstract)
> +static QList *qom_list_types(const char *implements, bool abstract)
>  {
>      QDict *resp;
>      QList *ret;
> +    QDict *args =3D qdict_new();
>=20=20
> +    qdict_put(args, "abstract", qbool_from_bool(abstract));
> +    if (implements) {
> +        qdict_put(args, "implements", qstring_from_str(implements));
> +    }
>      resp =3D qmp("{'execute': 'qom-list-types',"
> -               " 'arguments': {'implements': 'device', 'abstract': %i}}",
> -               abstract);
> +               " 'arguments': %p }", args);
>      g_assert(qdict_haskey(resp, "return"));
>      ret =3D qdict_get_qlist(resp, "return");
>      QINCREF(ret);
> @@ -39,6 +45,11 @@ static QList *device_type_list(bool abstract)
>      return ret;
>  }
>=20=20
> +static QList *device_type_list(bool abstract)
> +{
> +    return qom_list_types("device", abstract);
> +}
> +
>  static void test_one_device(const char *type)
>  {
>      QDict *resp;
> @@ -110,6 +121,46 @@ static void test_device_intro_concrete(void)
>      qtest_end();
>  }
>=20=20
> +static void test_abstract_interfaces(void)
> +{
> +    QList *all_types;
> +    QList *obj_types;
> +    QListEntry *ae;
> +
> +    qtest_start(common_args);
> +    /* qom-list-types implements=3Dinterface would return any type
> +     * that implements _any_ interface (not just interface types),
> +     * so use a trick to find the interface type names:
> +     * 1) list all non-abstract types
> +     * 2) list all non-abstract object types
> +     * 3) Look for items in (1) that are not in (2)
> +     */
> +    all_types =3D qom_list_types(NULL, false);

All concrete types.

> +    obj_types =3D qom_list_types("object", false);

All concrete subtypes of "object".

> +
> +    QLIST_FOREACH_ENTRY(all_types, ae) {

For @at in concrete types:

> +        QDict *at =3D qobject_to_qdict(qlist_entry_obj(ae));
> +        const char *aname =3D qdict_get_str(at, "name");
> +        QListEntry *oe;
> +        const char *found =3D NULL;
> +

Search the list of concrete subtypes of "object" for @at

> +        QLIST_FOREACH_ENTRY(obj_types, oe) {
> +            QDict *ot =3D qobject_to_qdict(qlist_entry_obj(oe));
> +            const char *oname =3D qdict_get_str(ot, "name");
> +            if (!strcmp(aname, oname)) {
> +                found =3D oname;
> +                break;
> +            }
> +        }
> +
> +        g_assert(found);

Assert @at is a concrete subtype of "object".

Taken together: assert that any concrete type is a subtype of "object".
Correct?

How's that related to interfaces?

> +    }
> +
> +    QDECREF(all_types);
> +    QDECREF(obj_types);
> +    qtest_end();
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -118,6 +169,7 @@ int main(int argc, char **argv)
>      qtest_add_func("device/introspect/none", test_device_intro_none);
>      qtest_add_func("device/introspect/abstract", test_device_intro_abstr=
act);
>      qtest_add_func("device/introspect/concrete", test_device_intro_concr=
ete);
> +    qtest_add_func("device/introspect/abstract-interfaces", test_abstrac=
t_interfaces);
>=20=20
>      return g_test_run();
>  }
