Received: from eggs.gnu.org ([2001:4830:134:3::10]:58381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1cGRDW-0003ut-Jm
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1cGRDT-0003OA-Pa
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:04:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:54944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1cGRDT-0003Lw-Ae
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 09:04:31 -0500
References: <1481306777-5441-1-git-send-email-ehabkost@redhat.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <6b1269fd-762f-9971-7114-868cd425de3d@suse.de>
Date: Mon, 12 Dec 2016 15:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <1481306777-5441-1-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9] qom: Make all interface types
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
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Lin Ma <lma@suse.com>, qemu-devel@nongnu.org

Am 09.12.2016 um 19:06 schrieb Eduardo Habkost:
> "qom-list-types abstract=3Dfalse" currently returns all interface
> types, as if they were not abstract. Fix this by making sure all
> interface types are abstract.
>=20
> All interface types have instance_size =3D=3D 0, so we can use
> it to set abstract=3Dtrue on
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qom/object.c                   |  4 +++
>  tests/device-introspect-test.c | 61 ++++++++++++++++++++++++++++++++++=
+++++---
>  2 files changed, 62 insertions(+), 3 deletions(-)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index 7a05e35..3870c1b 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -272,6 +272,10 @@ static void type_initialize(TypeImpl *ti)
> =20
>      ti->class_size =3D type_class_get_size(ti);
>      ti->instance_size =3D type_object_get_size(ti);
> +    /* Any type with zero instance_size is implicitly abstract.
> +     * This means interface types are all abstract.
> +     */
> +    ti->abstract |=3D ti->instance_size =3D=3D 0;

IIRC this is a bool field, so I would prefer to avoid |=3D by using an
old-fashioned if statement.

The ->abstract =3D false for interfaces itself makes sense to me, but I'd
appreciate confirmation from Paolo or some other interface expert.

> =20
>      ti->class =3D g_malloc0(ti->class_size);
> =20
> diff --git a/tests/device-introspect-test.c b/tests/device-introspect-t=
est.c
> index 37debc1..d1b0ea6 100644
> --- a/tests/device-introspect-test.c
> +++ b/tests/device-introspect-test.c
> @@ -20,18 +20,24 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qbool.h"
> +#include "qapi/qmp/qdict.h"
>  #include "libqtest.h"
> =20
>  const char common_args[] =3D "-nodefaults -machine none";
> =20
> -static QList *device_type_list(bool abstract)
> +static QList *qom_list_types(const char *implements, bool abstract)
>  {
>      QDict *resp;
>      QList *ret;
> +    QDict *args =3D qdict_new();
> =20
> +    qdict_put(args, "abstract", qbool_from_bool(abstract));
> +    if (implements) {
> +        qdict_put(args, "implements", qstring_from_str(implements));
> +    }
>      resp =3D qmp("{'execute': 'qom-list-types',"
> -               " 'arguments': {'implements': 'device', 'abstract': %i}=
}",
> -               abstract);
> +               " 'arguments': %p }", args);
>      g_assert(qdict_haskey(resp, "return"));
>      ret =3D qdict_get_qlist(resp, "return");
>      QINCREF(ret);
> @@ -39,6 +45,11 @@ static QList *device_type_list(bool abstract)
>      return ret;
>  }
> =20
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
> =20
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
> +        g_assert_cmpstr(aname, =3D=3D, found);
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
> @@ -119,5 +172,7 @@ int main(int argc, char **argv)
>      qtest_add_func("device/introspect/abstract", test_device_intro_abs=
tract);
>      qtest_add_func("device/introspect/concrete", test_device_intro_con=
crete);
> =20
> +    qtest_add_func("qom/introspect/abstract-interfaces", test_abstract=
_interfaces);

I see why you combine the two for reuse, but this path looks odd, it's
supposed to indicate which testsuite the test comes from.
"device/introspect/abstract-qom-interfaces" maybe?

> +
>      return g_test_run();
>  }

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
