Received: from eggs.gnu.org ([2001:4830:134:3::10]:58919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkUTX-0000DG-Cx
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkUTU-0003Oa-OJ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:09:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-13-marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 14:09:07 +0200
In-Reply-To: <20170822132255.23945-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:13 +0200")
Message-ID: <87lgmazdss.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/54] qapi: change enum lookup structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:Sheepdog" <sheepdog@lists.wpkg.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, "Denis
	V. Lunev" <den@openvz.org>, Josh Durgin <jdurgin@redhat.com>, Alberto Garcia <berto@igalia.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Jason Wang <jasowang@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Store the length in the lookup table, i.e. change it from
> const char *const[] to struct { int n, const char *const s[] }.
>
> The following conditional enum entry change will create "hole"
> elements in the generated lookup array, that should be skipped.

The commit message could use some love.  I know what the "conditional
enum entry change" will be about, but most other's won't, and even I may
not remember it in a few months.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  66 files changed, 241 insertions(+), 248 deletions(-)

Lot's of churn because we need to take the address of FOO_lookup now.
Macros in PATCH 06 could perhaps limit the churn to that patch.  I'll
play with it.

> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index 0f3b8cb459..62a51a54cb 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -469,7 +469,7 @@ bool visit_optional(Visitor *v, const char *name, boo=
l *present);
>   * that visit_type_str() must have no unwelcome side effects.
>   */
>  void visit_type_enum(Visitor *v, const char *name, int *obj,
> -                     const char *const strings[], Error **errp);
> +                     const QEnumLookup *lookup, Error **errp);
>=20=20
>  /*
>   * Check if visitor is an input visitor.
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index a3ac799535..314d7e0365 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1851,7 +1851,7 @@ def guardend(name):
>  def gen_enum_lookup(name, values, prefix=3DNone):
>      ret =3D mcgen('''
>=20=20
> -const char *const %(c_name)s_lookup[] =3D {
> +static const char *const %(c_name)s_array[] =3D {
>  ''',
>                  c_name=3Dc_name(name))
>      for value in values:
> @@ -1865,8 +1865,13 @@ const char *const %(c_name)s_lookup[] =3D {
>      ret +=3D mcgen('''
>      [%(max_index)s] =3D NULL,
>  };
> +
> +const QEnumLookup %(c_name)s_lookup =3D {
> +    .array =3D %(c_name)s_array,
> +    .size =3D %(max_index)s
> +};
>  ''',
> -                 max_index=3Dmax_index)
> +                 max_index=3Dmax_index, c_name=3Dc_name(name))
>      return ret
>=20=20
>=20=20

This generates

    static const char *const ACPISlotType_array[] =3D {
        [ACPI_SLOT_TYPE_DIMM] =3D "DIMM",
        [ACPI_SLOT_TYPE_CPU] =3D "CPU",
        [ACPI_SLOT_TYPE__MAX] =3D NULL,
    };

    const QEnumLookup ACPISlotType_lookup =3D {
        .array =3D ACPISlotType_array,
        .size =3D ACPI_SLOT_TYPE__MAX
    };

Old-fashioned.  We can avoid the extra variable easily:

    const QEnumLookup ACPISlotType_lookup =3D {
        .array =3D (const char *const[]) {
            [ACPI_SLOT_TYPE_DIMM] =3D "DIMM",
            [ACPI_SLOT_TYPE_CPU] =3D "CPU",
            [ACPI_SLOT_TYPE__MAX] =3D NULL,
        },
        .size =3D ACPI_SLOT_TYPE__MAX
    };

Could be done in a followup.  Extra churn.  Up to you.

> @@ -1896,7 +1901,7 @@ typedef enum %(c_name)s {
>=20=20
>      ret +=3D mcgen('''
>=20=20
> -extern const char *const %(c_name)s_lookup[];
> +extern const QEnumLookup %(c_name)s_lookup;
>  ''',
>                   c_name=3Dc_name(name))
>      return ret
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index b45e7b5634..dc05268917 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -179,6 +179,12 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          self.defn =3D ''
>          self._fwdecl =3D ''
>          self._btin =3D guardstart('QAPI_TYPES_BUILTIN')
> +        self._btin +=3D '''
> +typedef struct QEnumLookup {
> +    const char *const *array;
> +    int size;
> +} QEnumLookup;
> +'''
>=20=20
>      def visit_end(self):
>          self.decl =3D self._fwdecl + self.decl
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index bd0b742236..7e1cfc13f0 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -153,7 +153,7 @@ def gen_visit_enum(name):
>  void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *obj=
, Error **errp)
>  {
>      int value =3D *obj;
> -    visit_type_enum(v, name, &value, %(c_name)s_lookup, errp);
> +    visit_type_enum(v, name, &value, &%(c_name)s_lookup, errp);
>      *obj =3D value;
>  }
>  ''',
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index ae317286a4..089146197f 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -249,7 +249,7 @@ struct Property {
>  struct PropertyInfo {
>      const char *name;
>      const char *description;
> -    const char * const *enum_table;
> +    const QEnumLookup *enum_table;
>      int (*print)(DeviceState *dev, Property *prop, char *dest, size_t le=
n);
>      void (*set_default_value)(Object *obj, const Property *prop);
>      void (*create)(Object *obj, Property *prop, Error **errp);
> diff --git a/include/qapi/util.h b/include/qapi/util.h
> index 60733b6a80..613f82bdcd 100644
> --- a/include/qapi/util.h
> +++ b/include/qapi/util.h
> @@ -11,10 +11,10 @@
>  #ifndef QAPI_UTIL_H
>  #define QAPI_UTIL_H
>=20=20
> -const char *qapi_enum_lookup(const char * const lookup[], int val);
> +const char *qapi_enum_lookup(const QEnumLookup *lookup, int val);
>=20=20
> -int qapi_enum_parse(const char * const lookup[], const char *buf,
> -                    int max, int def, Error **errp);
> +int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
> +                    int def, Error **errp);
>=20=20
>  int parse_qapi_name(const char *name, bool complete);
>=20=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 1b828994fa..f3e5cff37a 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1415,14 +1415,14 @@ void object_class_property_add_bool(ObjectClass *=
klass, const char *name,
>   */
>  void object_property_add_enum(Object *obj, const char *name,
>                                const char *typename,
> -                              const char * const *strings,
> +                              const QEnumLookup *lookup,
>                                int (*get)(Object *, Error **),
>                                void (*set)(Object *, int, Error **),
>                                Error **errp);
>=20=20
>  void object_class_property_add_enum(ObjectClass *klass, const char *name,
>                                      const char *typename,
> -                                    const char * const *strings,
> +                                    const QEnumLookup *lookup,
>                                      int (*get)(Object *, Error **),
>                                      void (*set)(Object *, int, Error **),
>                                      Error **errp);
> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
> index ed6d2af462..8876ecf0cd 100644
> --- a/qapi/qapi-visit-core.c
> +++ b/qapi/qapi-visit-core.c
> @@ -333,24 +333,22 @@ void visit_type_null(Visitor *v, const char *name, =
QNull **obj,
>  }
>=20=20
>  static void output_type_enum(Visitor *v, const char *name, int *obj,
> -                             const char *const strings[], Error **errp)
> +                             const QEnumLookup *lookup, Error **errp)
>  {
> -    int i =3D 0;
>      int value =3D *obj;
>      char *enum_str;
>=20=20
> -    while (strings[i++] !=3D NULL);
> -    if (value < 0 || value >=3D i - 1) {
> +    if (value < 0 || value > lookup->size || !lookup->array[value]) {

!lookup->array[value] feels premature.  Hole support should be done in a
later patch, possibly a separate one.

>          error_setg(errp, QERR_INVALID_PARAMETER, name ? name : "null");
>          return;
>      }
>=20=20
> -    enum_str =3D (char *)strings[value];
> +    enum_str =3D (char *)lookup->array[value];

Why not qapi_enum_lookup()?  In PATCH 06?

>      visit_type_str(v, name, &enum_str, errp);
>  }
>=20=20
>  static void input_type_enum(Visitor *v, const char *name, int *obj,
> -                            const char *const strings[], Error **errp)
> +                            const QEnumLookup *lookup, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      int64_t value =3D 0;
> @@ -362,14 +360,14 @@ static void input_type_enum(Visitor *v, const char =
*name, int *obj,
>          return;
>      }
>=20=20
> -    while (strings[value] !=3D NULL) {
> -        if (strcmp(strings[value], enum_str) =3D=3D 0) {
> +    while (value < lookup->size) {
> +        if (!g_strcmp0(lookup->array[value], enum_str)) {
>              break;
>          }
>          value++;
>      }
>=20=20
> -    if (strings[value] =3D=3D NULL) {
> +    if (value =3D=3D lookup->size) {
>          error_setg(errp, QERR_INVALID_PARAMETER, enum_str);
>          g_free(enum_str);
>          return;

Can we use qapi_enum_parse() here?  In a preparatory patch like PATCH
07-11?

> @@ -380,16 +378,16 @@ static void input_type_enum(Visitor *v, const char =
*name, int *obj,
>  }
>=20=20
>  void visit_type_enum(Visitor *v, const char *name, int *obj,
> -                     const char *const strings[], Error **errp)
> +                     const QEnumLookup *lookup, Error **errp)
>  {
> -    assert(obj && strings);
> +    assert(obj && lookup);
>      trace_visit_type_enum(v, name, obj);
>      switch (v->type) {
>      case VISITOR_INPUT:
> -        input_type_enum(v, name, obj, strings, errp);
> +        input_type_enum(v, name, obj, lookup, errp);
>          break;
>      case VISITOR_OUTPUT:
> -        output_type_enum(v, name, obj, strings, errp);
> +        output_type_enum(v, name, obj, lookup, errp);
>          break;
>      case VISITOR_CLONE:
>          /* nothing further to do, scalar value was already copied by
[Skipping churn I hope to reduce...]
> diff --git a/block/parallels.c b/block/parallels.c
> index e1e06d23cc..f870bbac3e 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -69,12 +69,16 @@ typedef enum ParallelsPreallocMode {
>      PRL_PREALLOC_MODE__MAX =3D 2,
>  } ParallelsPreallocMode;
>=20=20
> -static const char *prealloc_mode_lookup[] =3D {
> +static const char *prealloc_mode_array[] =3D {
>      "falloc",
>      "truncate",
>      NULL,
>  };
>=20=20
> +static QEnumLookup prealloc_mode_lookup =3D {
> +    .array =3D prealloc_mode_array,
> +    .size =3D G_N_ELEMENTS(prealloc_mode_array),
> +};
>=20=20
>  typedef struct BDRVParallelsState {
>      /** Locking is conservative, the lock protects

My comment on scripts/qapi.py applies.

> @@ -696,8 +700,8 @@ static int parallels_open(BlockDriverState *bs, QDict=
 *options, int flags,
>          qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
>      s->prealloc_size =3D MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_=
BITS);
>      buf =3D qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
> -    s->prealloc_mode =3D qapi_enum_parse(prealloc_mode_lookup, buf,
> -            PRL_PREALLOC_MODE__MAX, PRL_PREALLOC_MODE_FALLOCATE, &local_=
err);
> +    s->prealloc_mode =3D qapi_enum_parse(&prealloc_mode_lookup, buf,
> +                                       PRL_PREALLOC_MODE_FALLOCATE, &loc=
al_err);
>      g_free(buf);
>      if (local_err !=3D NULL) {
>          goto fail_options;
[Skipping more churn...]
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index b78a6345f3..a3c96d768b 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -258,47 +258,39 @@ qcrypto_block_luks_cipher_alg_lookup(QCryptoCipherA=
lgorithm alg,
>      }
>=20=20
>      error_setg(errp, "Algorithm '%s' not supported",
> -               qapi_enum_lookup(QCryptoCipherAlgorithm_lookup, alg));
> +               qapi_enum_lookup(&QCryptoCipherAlgorithm_lookup, alg));
>      return NULL;
>  }
>=20=20
> -/* XXX replace with qapi_enum_parse() in future, when we can
> +/* XXX replace with qapi_enum_parse(&) in future, when we can

Whoops!

>   * make that function emit a more friendly error message */
>  static int qcrypto_block_luks_name_lookup(const char *name,
> -                                          const char *const *map,
> -                                          size_t maplen,
> +                                          const QEnumLookup *lookup,
>                                            const char *type,
>                                            Error **errp)
>  {
> -    size_t i;
> -    for (i =3D 0; i < maplen; i++) {
> -        if (g_str_equal(map[i], name)) {
> -            return i;
> -        }
> +    int i =3D qapi_enum_parse(lookup, name, -1, NULL);
> +    if (i < 0) {
> +        error_setg(errp, "%s %s not supported", type, name);
>      }
> -
> -    error_setg(errp, "%s %s not supported", type, name);
> -    return 0;
> +    return i;
>  }

Here, you do use qapi_enum_parse().  Good, but let's do it in a
separate, preparatory patch like PATCH 07-11.

[Skipping more churn...]
> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> index 7677caa51e..363214efb1 100644
> --- a/qapi/qapi-util.c
> +++ b/qapi/qapi-util.c
> @@ -15,8 +15,8 @@
>  #include "qemu-common.h"
>  #include "qapi/util.h"
>=20=20
> -int qapi_enum_parse(const char * const lookup[], const char *buf,
> -                    int max, int def, Error **errp)
> +int qapi_enum_parse(const QEnumLookup *lookup, const char *buf,
> +                    int def, Error **errp)
>  {
>      int i;
>=20=20
> @@ -24,8 +24,8 @@ int qapi_enum_parse(const char * const lookup[], const =
char *buf,
>          return def;
>      }
>=20=20
> -    for (i =3D 0; i < max; i++) {
> -        if (!strcmp(buf, lookup[i])) {
> +    for (i =3D 0; i < lookup->size; i++) {
> +        if (!g_strcmp0(buf, lookup->array[i])) {
>              return i;
>          }
>      }

Why switch from strcmp() to g_strcmp0()?

If it's to support holes: hole support should be done in a later patch,
possibly a separate one.

> @@ -34,11 +34,12 @@ int qapi_enum_parse(const char * const lookup[], cons=
t char *buf,
>      return def;
>  }
>=20=20
> -const char *qapi_enum_lookup(const char * const lookup[], int val)
> +const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
>  {
>      assert(val >=3D 0);
> +    assert(val < lookup->size);

The additional bounds check is a nice extra.  But let's fuse the
assertions.

The patch that introduces hole support should additionally assert
lookup->array[val].

>=20=20
> -    return lookup[val];
> +    return lookup->array[val];
>  }
>=20=20
>  /*
[Skipping more churn...]
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index c51e6e734d..0ba8b55ce1 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -53,6 +53,11 @@ static const char *const dummy_animal_map[DUMMY_LAST +=
 1] =3D {
>      [DUMMY_LAST] =3D NULL,
>  };
>=20=20
> +const QEnumLookup dummy_animal_lookup =3D {
> +    .array =3D dummy_animal_map,
> +    .size =3D DUMMY_LAST
> +};
> +
>  struct DummyObject {
>      Object parent_obj;
>=20=20

My comment on scripts/qapi.py applies.

> @@ -142,7 +147,7 @@ static void dummy_class_init(ObjectClass *cls, void *=
data)
>                                    NULL);
>      object_class_property_add_enum(cls, "av",
>                                     "DummyAnimal",
> -                                   dummy_animal_map,
> +                                   &dummy_animal_lookup,
>                                     dummy_get_av,
>                                     dummy_set_av,
>                                     NULL);
[Skipping more churn...]
> index bdd00f6bd8..be7d7ea654 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -382,10 +382,10 @@ static void test_visitor_in_enum(TestInputVisitorDa=
ta *data,
>      Visitor *v;
>      EnumOne i;
>=20=20
> -    for (i =3D 0; EnumOne_lookup[i]; i++) {
> +    for (i =3D 0; i < EnumOne_lookup.size; i++) {
>          EnumOne res =3D -1;
>=20=20
> -        v =3D visitor_input_test_init(data, "%s", EnumOne_lookup[i]);
> +        v =3D visitor_input_test_init(data, "%s", EnumOne_lookup.array[i=
]);
>=20=20
>          visit_type_EnumOne(v, NULL, &res, &error_abort);
>          g_assert_cmpint(i, =3D=3D, res);
> @@ -699,7 +699,7 @@ static void test_native_list_integer_helper(TestInput=
VisitorData *data,
>          }
>      }
>      g_string_append_printf(gstr_union,  "{ 'type': '%s', 'data': [ %s ] =
}",
> -                           UserDefNativeListUnionKind_lookup[kind],
> +                           UserDefNativeListUnionKind_lookup.array[kind],

PATCH 06 should have changed this to qapi_enum_lookup(), as noted in my
review there.

>                             gstr_list->str);
>      v =3D visitor_input_test_init_raw(data,  gstr_union->str);
>=20=20
> @@ -1110,7 +1110,7 @@ static void test_visitor_in_fail_struct_missing(Tes=
tInputVisitorData *data,
>      error_free_or_abort(&err);
>      visit_optional(v, "optional", &present);
>      g_assert(!present);
> -    visit_type_enum(v, "enum", &en, EnumOne_lookup, &err);
> +    visit_type_enum(v, "enum", &en, &EnumOne_lookup, &err);
>      error_free_or_abort(&err);
>      visit_type_int(v, "i64", &i64, &err);
>      error_free_or_abort(&err);
> diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
> index bb2d66b666..55a8c932e0 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -135,7 +135,7 @@ static void test_visitor_out_enum(TestOutputVisitorDa=
ta *data,
>          qstr =3D qobject_to_qstring(visitor_get(data));
>          g_assert(qstr);
>          g_assert_cmpstr(qstring_get_str(qstr), =3D=3D,
> -                        qapi_enum_lookup(EnumOne_lookup, i));
> +                        qapi_enum_lookup(&EnumOne_lookup, i));
>          visitor_reset(data);
>      }
>  }
> diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-=
visitor.c
> index 79313a7f7a..5828359830 100644
> --- a/tests/test-string-input-visitor.c
> +++ b/tests/test-string-input-visitor.c
> @@ -279,10 +279,10 @@ static void test_visitor_in_enum(TestInputVisitorDa=
ta *data,
>      Visitor *v;
>      EnumOne i;
>=20=20
> -    for (i =3D 0; EnumOne_lookup[i]; i++) {
> +    for (i =3D 0; i < EnumOne_lookup.size; i++) {
>          EnumOne res =3D -1;
>=20=20
> -        v =3D visitor_input_test_init(data, EnumOne_lookup[i]);
> +        v =3D visitor_input_test_init(data, EnumOne_lookup.array[i]);
>=20=20
>          visit_type_EnumOne(v, NULL, &res, &err);

Likewise.

>          g_assert(!err);
> diff --git a/tests/test-string-output-visitor.c b/tests/test-string-outpu=
t-visitor.c
> index 0b2087d312..a5d26ac0ca 100644
> --- a/tests/test-string-output-visitor.c
> +++ b/tests/test-string-output-visitor.c
> @@ -196,12 +196,12 @@ static void test_visitor_out_enum(TestOutputVisitor=
Data *data,
>          str =3D visitor_get(data);
>          if (data->human) {
>              char *str_human =3D
> -                g_strdup_printf("\"%s\"", qapi_enum_lookup(EnumOne_looku=
p, i));
> +                g_strdup_printf("\"%s\"", qapi_enum_lookup(&EnumOne_look=
up, i));
>=20=20
>              g_assert_cmpstr(str, =3D=3D, str_human);
>              g_free(str_human);
>          } else {
> -            g_assert_cmpstr(str, =3D=3D, qapi_enum_lookup(EnumOne_lookup=
, i));
> +            g_assert_cmpstr(str, =3D=3D, qapi_enum_lookup(&EnumOne_looku=
p, i));
>          }
>          visitor_reset(data);
>      }
> diff --git a/tpm.c b/tpm.c
> index f175661bfe..3ddd889906 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -63,7 +63,7 @@ static bool tpm_model_is_registered(enum TpmModel model)
>=20=20
>  const TPMDriverOps *tpm_get_backend_driver(const char *type)
>  {
> -    int i =3D qapi_enum_parse(TpmType_lookup, type, TPM_TYPE__MAX, -1, N=
ULL);
> +    int i =3D qapi_enum_parse(&TpmType_lookup, type, -1, NULL);
>=20=20
>      return i >=3D 0 ? be_drivers[i] : NULL;
>  }
> @@ -92,7 +92,7 @@ static void tpm_display_backend_drivers(void)
>              continue;
>          }
>          fprintf(stderr, "%12s   %s\n",
> -                qapi_enum_lookup(TpmType_lookup, i),
> +                qapi_enum_lookup(&TpmType_lookup, i),
>                  be_drivers[i]->desc());
>      }
>      fprintf(stderr, "\n");
> diff --git a/ui/input-legacy.c b/ui/input-legacy.c
> index 7159747404..c597bdc711 100644
> --- a/ui/input-legacy.c
> +++ b/ui/input-legacy.c
> @@ -61,9 +61,9 @@ int index_from_key(const char *key, size_t key_length)
>  {
>      int i;
>=20=20
> -    for (i =3D 0; QKeyCode_lookup[i] !=3D NULL; i++) {
> -        if (!strncmp(key, QKeyCode_lookup[i], key_length) &&
> -            !QKeyCode_lookup[i][key_length]) {
> +    for (i =3D 0; QKeyCode_lookup.array[i] !=3D NULL; i++) {
> +        if (!strncmp(key, QKeyCode_lookup.array[i], key_length) &&
> +            !QKeyCode_lookup.array[i][key_length]) {
>              break;
>          }
>      }

This is almost qapi_enum_parse(), but not quite: the key isn't
zero-terminated.  Pity, because it looks like the last user that dots
into QEnumLookup.  If we get rid of it, we can make it opaque.  I'd do
it right away, but if you prefer to leave it for later, I can accept
that.

[Skipping more churn...]

I may well have missed issues in the stuff I skipped here.  Hopefully, I
can reduce the churn and make this patch reviewable in full.
