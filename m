Received: from eggs.gnu.org ([2001:4830:134:3::10]:58937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cH9Ey-00047U-44
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cH9Es-0003nK-11
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cH9Er-0003mN-Oo
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:04:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481567461-2341-1-git-send-email-ehabkost@redhat.com>
Date: Wed, 14 Dec 2016 14:04:50 +0100
In-Reply-To: <1481567461-2341-1-git-send-email-ehabkost@redhat.com> (Eduardo
	Habkost's message of "Mon, 12 Dec 2016 16:31:01 -0200")
Message-ID: <87zijyfyq5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] qom: Make all interface types
 abstract
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
> ---
>  qom/object.c                   |  6 +++++
>  tests/device-introspect-test.c | 60 ++++++++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 63 insertions(+), 3 deletions(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 7a05e35..760fafb 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -272,6 +272,12 @@ static void type_initialize(TypeImpl *ti)
>=20=20
>      ti->class_size =3D type_class_get_size(ti);
>      ti->instance_size =3D type_object_get_size(ti);
> +    /* Any type with zero instance_size is implicitly abstract.
> +     * This means interface types are all abstract.
> +     */
> +    if (ti->instance_size =3D=3D 0) {
> +        ti->abstract =3D true;
> +    }
>=20=20
>      ti->class =3D g_malloc0(ti->class_size);
>=20=20

Letting zero instance_size imply abstract works (I guess), but is it
wise to imply?  Is requiring explicit .abstract =3D true really too much
trouble?

Consider:

    static const TypeInfo uc_interface_info =3D {
        .name          =3D TYPE_USER_CREATABLE,
        .parent        =3D TYPE_INTERFACE,
        .class_size =3D sizeof(UserCreatableClass),
    };

Is this abstract?  Yes, because there's no .instance_size =3D ...,
therefore .instance_size remains zero, and .abstract defaults to true.

    static const TypeInfo memory_region_info =3D {
        .parent             =3D TYPE_OBJECT,
        .name               =3D TYPE_MEMORY_REGION,
        .instance_size      =3D sizeof(MemoryRegion),
        .instance_init      =3D memory_region_initfn,
        .instance_finalize  =3D memory_region_finalize,
    };

Is this abstract?  No, because with .instance_size =3D
sizeof(MemoryRegion), which known to be non-zero, .abstract defaults to
false.

Is such a complex default a good idea?

   static const TypeInfo rng_backend_info =3D {
       .name =3D TYPE_RNG_BACKEND,
       .parent =3D TYPE_OBJECT,
       .instance_size =3D sizeof(RngBackend),
       .instance_init =3D rng_backend_init,
       .instance_finalize =3D rng_backend_finalize,
       .class_size =3D sizeof(RngBackendClass),
       .class_init =3D rng_backend_class_init,
       .abstract =3D true,
       .interfaces =3D (InterfaceInfo[]) {
           { TYPE_USER_CREATABLE },
           { }
       }
   };

Is this abstract?  Yes, because with .abstract =3D true, the default
doesn't matter.

How do you find all abstract TypeInfo in the source?  The uninitiated
might grep for .abstract =3D true, and be misled.  The initiated will be
annoyed instead, because grepping for *absence* of .instance_size =3D is
bothersome.

I suspect life could be easier going forward if we instead required
.abstract =3D true for interfaces, and enforced it with
assert(ti->instance_size || ti->abstract) here.

> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-tes=
t.c
> index 37debc1..c5637cc 100644
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
> @@ -110,6 +121,48 @@ static void test_device_intro_concrete(void)
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
> +     * - list all object types
> +     * - list all types, and look for items that are not
> +     *   on the first list
> +     */
> +    all_types =3D qom_list_types(NULL, false);
> +    obj_types =3D qom_list_types("object", false);
> +
> +    QLIST_FOREACH_ENTRY(all_types, ae) {
> +        QDict *at =3D qobject_to_qdict(qlist_entry_obj(ae));
> +        const char *aname =3D qdict_get_str(at, "name");
> +        QListEntry *oe;
> +        const char *found =3D NULL;
> +
> +        QLIST_FOREACH_ENTRY(obj_types, oe) {
> +            QDict *ot =3D qobject_to_qdict(qlist_entry_obj(oe));
> +            const char *oname =3D qdict_get_str(ot, "name");
> +            if (!strcmp(aname, oname)) {
> +                found =3D oname;
> +                break;
> +            }
> +        }
> +
> +        /* Using g_assert_cmpstr() will give more useful failure
> +         * messages than g_assert(found) */

Sure this comment is worth having?

> +        g_assert_cmpstr(aname, =3D=3D, found);

I'm having a mental block...  what exactly is this loop nest testing?

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
> @@ -118,6 +171,7 @@ int main(int argc, char **argv)
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
