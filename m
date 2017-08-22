Received: from eggs.gnu.org ([2001:4830:134:3::10]:52538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7Bu-0007wz-Bb
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7Br-0002zE-TN
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:17:50 -0400
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:36967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dk7Br-0002y2-NF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:17:47 -0400
Received: by mail-ua0-x230.google.com with SMTP id e28so10414714uah.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 04:17:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8760dn8ygv.fsf@dusky.pond.sub.org>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-6-marcandre.lureau@redhat.com>
	<8760dn8ygv.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Aug 2017 13:17:46 +0200
Message-ID: <CAJ+F1C+gkZ7MTftTiFSwyLNa23CSyg_q05x8h35F_MyYzTAH7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/26] visitor: pass size of strings array
 to enum visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

hi

On Wed, Aug 16, 2017 at 2:54 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> The size is known at compile time, this avoids having to compute to
>> check array boundaries.
>>
>> Additionally, the following conditional enum entry change will create
>> "hole" in the generated _lookup tables, that should be skipped.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/qapi/visitor.h             |  3 ++-
>>  scripts/qapi-visit.py              | 10 +++++-----
>>  include/hw/qdev-core.h             |  1 +
>>  include/qom/object.h               |  4 ++++
>>  qapi/qapi-visit-core.c             | 23 ++++++++++++-----------
>>  backends/hostmem.c                 |  1 +
>>  crypto/secret.c                    |  1 +
>>  crypto/tlscreds.c                  |  1 +
>>  hw/core/qdev-properties.c          | 11 +++++++++--
>>  net/filter.c                       |  1 +
>>  qom/object.c                       | 11 ++++++++---
>>  tests/check-qom-proplist.c         |  1 +
>>  tests/test-qobject-input-visitor.c |  2 +-
>>  13 files changed, 47 insertions(+), 23 deletions(-)
>
> No change to scripts/qapi-types.c.  The generated lookup tables continue
> to contain the NULL sentinel.  Possibly intentional, because it saves
> you the trouble of searching for uses of FOO_lookup[FOO__MAX].
>
>> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
>> index fe9faf469f..a2d9786c52 100644
>> --- a/include/qapi/visitor.h
>> +++ b/include/qapi/visitor.h
>> @@ -469,7 +469,8 @@ bool visit_optional(Visitor *v, const char *name, bo=
ol *present);
>>   * that visit_type_str() must have no unwelcome side effects.
>>   */
>>  void visit_type_enum(Visitor *v, const char *name, int *obj,
>> -                     const char *const strings[], Error **errp);
>> +                     const char *const strings[], int nstrings,
>> +                     Error **errp);
>>
>>  /*
>>   * Check if visitor is an input visitor.
>> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
>> index bd0b742236..60850a6cdd 100644
>> --- a/scripts/qapi-visit.py
>> +++ b/scripts/qapi-visit.py
>> @@ -147,17 +147,17 @@ out:
>>                   c_name=3Dc_name(name), c_elt_type=3Delement_type.c_nam=
e())
>>
>>
>> -def gen_visit_enum(name):
>> +def gen_visit_enum(name, prefix):
>>      return mcgen('''
>>
>>  void visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s *ob=
j, Error **errp)
>>  {
>>      int value =3D *obj;
>> -    visit_type_enum(v, name, &value, %(c_name)s_lookup, errp);
>> +    visit_type_enum(v, name, &value, %(c_name)s_lookup, %(c_max)s, errp=
);
>>      *obj =3D value;
>>  }
>>  ''',
>> -                 c_name=3Dc_name(name))
>> +                 c_name=3Dc_name(name), c_max=3Dc_enum_const(name, '_MA=
X', prefix))
>>
>>
>>  def gen_visit_alternate(name, variants):
>> @@ -288,10 +288,10 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor)=
:
>>          if not info:
>>              self._btin +=3D gen_visit_decl(name, scalar=3DTrue)
>>              if do_builtins:
>> -                self.defn +=3D gen_visit_enum(name)
>> +                self.defn +=3D gen_visit_enum(name, prefix)
>>          else:
>>              self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
>> -            self.defn +=3D gen_visit_enum(name)
>> +            self.defn +=3D gen_visit_enum(name, prefix)
>>
>>      def visit_array_type(self, name, info, element_type):
>>          decl =3D gen_visit_decl(name)
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index ae317286a4..f86a0e1a75 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -250,6 +250,7 @@ struct PropertyInfo {
>>      const char *name;
>>      const char *description;
>>      const char * const *enum_table;
>> +    int enum_table_size;
>>      int (*print)(DeviceState *dev, Property *prop, char *dest, size_t l=
en);
>>      void (*set_default_value)(Object *obj, const Property *prop);
>>      void (*create)(Object *obj, Property *prop, Error **errp);
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 1b828994fa..53d807e1e6 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -1406,6 +1406,8 @@ void object_class_property_add_bool(ObjectClass *k=
lass, const char *name,
>>   * @obj: the object to add a property to
>>   * @name: the name of the property
>>   * @typename: the name of the enum data type
>> + * @strings: an array of strings for the enum
>
> Fixes a preexisting doc buglet.
>
>> + * @nstrings: the size of @strings
>>   * @get: the getter or %NULL if the property is write-only.
>>   * @set: the setter or %NULL if the property is read-only
>>   * @errp: if an error occurs, a pointer to an area to store the error
>> @@ -1416,6 +1418,7 @@ void object_class_property_add_bool(ObjectClass *k=
lass, const char *name,
>>  void object_property_add_enum(Object *obj, const char *name,
>>                                const char *typename,
>>                                const char * const *strings,
>> +                              int nstrings,
>>                                int (*get)(Object *, Error **),
>>                                void (*set)(Object *, int, Error **),
>>                                Error **errp);
>> @@ -1423,6 +1426,7 @@ void object_property_add_enum(Object *obj, const c=
har *name,
>>  void object_class_property_add_enum(ObjectClass *klass, const char *nam=
e,
>>                                      const char *typename,
>>                                      const char * const *strings,
>> +                                    int nstrings,
>>                                      int (*get)(Object *, Error **),
>>                                      void (*set)(Object *, int, Error **=
),
>>                                      Error **errp);
>> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
>> index ed6d2af462..dc0b9f2cee 100644
>> --- a/qapi/qapi-visit-core.c
>> +++ b/qapi/qapi-visit-core.c
>> @@ -333,14 +333,13 @@ void visit_type_null(Visitor *v, const char *name,=
 QNull **obj,
>>  }
>>
>>  static void output_type_enum(Visitor *v, const char *name, int *obj,
>> -                             const char *const strings[], Error **errp)
>> +                             const char *const strings[],
>> +                             int nstrings, Error **errp)
>>  {
>> -    int i =3D 0;
>>      int value =3D *obj;
>>      char *enum_str;
>>
>> -    while (strings[i++] !=3D NULL);
>
> This is the computation we save.
>
>> -    if (value < 0 || value >=3D i - 1) {
>> +    if (value < 0 || value >=3D nstrings) {
>>          error_setg(errp, QERR_INVALID_PARAMETER, name ? name : "null");
>>          return;
>>      }
>> @@ -350,7 +349,8 @@ static void output_type_enum(Visitor *v, const char =
*name, int *obj,
>>  }
>>
>>  static void input_type_enum(Visitor *v, const char *name, int *obj,
>> -                            const char *const strings[], Error **errp)
>> +                            const char *const strings[],
>> +                            int nstrings, Error **errp)
>>  {
>>      Error *local_err =3D NULL;
>>      int64_t value =3D 0;
>> @@ -362,14 +362,14 @@ static void input_type_enum(Visitor *v, const char=
 *name, int *obj,
>>          return;
>>      }
>>
>> -    while (strings[value] !=3D NULL) {
>
> This is the predicate that becomes invalid when we put holes into
> strings[].
>
>> -        if (strcmp(strings[value], enum_str) =3D=3D 0) {
>> +    while (value < nstrings) {
>> +        if (strings[value] && strcmp(strings[value], enum_str) =3D=3D 0=
) {
>
> I'd prefer !strcmp().
>
>>              break;
>>          }
>>          value++;
>>      }
>>
>> -    if (strings[value] =3D=3D NULL) {
>> +    if (value >=3D nstrings || strings[value] =3D=3D NULL) {
>
> Make that
>
>        if (value =3D=3D nstrings) {
>
> to match the loop above.
>
>>          error_setg(errp, QERR_INVALID_PARAMETER, enum_str);
>>          g_free(enum_str);
>>          return;
>> @@ -380,16 +380,17 @@ static void input_type_enum(Visitor *v, const char=
 *name, int *obj,
>>  }
>>
>>  void visit_type_enum(Visitor *v, const char *name, int *obj,
>> -                     const char *const strings[], Error **errp)
>> +                     const char *const strings[], int nstrings,
>> +                     Error **errp)
>>  {
>>      assert(obj && strings);
>>      trace_visit_type_enum(v, name, obj);
>>      switch (v->type) {
>>      case VISITOR_INPUT:
>> -        input_type_enum(v, name, obj, strings, errp);
>> +        input_type_enum(v, name, obj, strings, nstrings, errp);
>>          break;
>>      case VISITOR_OUTPUT:
>> -        output_type_enum(v, name, obj, strings, errp);
>> +        output_type_enum(v, name, obj, strings, nstrings, errp);
>>          break;
>>      case VISITOR_CLONE:
>>          /* nothing further to do, scalar value was already copied by
>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>> index 4606b73849..fc475a5387 100644
>> --- a/backends/hostmem.c
>> +++ b/backends/hostmem.c
>> @@ -396,6 +396,7 @@ host_memory_backend_class_init(ObjectClass *oc, void=
 *data)
>>          NULL, NULL, &error_abort);
>>      object_class_property_add_enum(oc, "policy", "HostMemPolicy",
>>          HostMemPolicy_lookup,
>> +        HOST_MEM_POLICY__MAX,
>>          host_memory_backend_get_policy,
>>          host_memory_backend_set_policy, &error_abort);
>>      object_class_property_add_str(oc, "id", get_id, set_id, &error_abor=
t);
>> diff --git a/crypto/secret.c b/crypto/secret.c
>> index 285ab7a63c..b5382cb7e3 100644
>> --- a/crypto/secret.c
>> +++ b/crypto/secret.c
>> @@ -379,6 +379,7 @@ qcrypto_secret_class_init(ObjectClass *oc, void *dat=
a)
>>      object_class_property_add_enum(oc, "format",
>>                                     "QCryptoSecretFormat",
>>                                     QCryptoSecretFormat_lookup,
>> +                                   QCRYPTO_SECRET_FORMAT__MAX,
>>                                     qcrypto_secret_prop_get_format,
>>                                     qcrypto_secret_prop_set_format,
>>                                     NULL);
>> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
>> index a8965531b6..8c060127ea 100644
>> --- a/crypto/tlscreds.c
>> +++ b/crypto/tlscreds.c
>> @@ -234,6 +234,7 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, void *=
data)
>>      object_class_property_add_enum(oc, "endpoint",
>>                                     "QCryptoTLSCredsEndpoint",
>>                                     QCryptoTLSCredsEndpoint_lookup,
>> +                                   QCRYPTO_TLS_CREDS_ENDPOINT__MAX,
>>                                     qcrypto_tls_creds_prop_get_endpoint,
>>                                     qcrypto_tls_creds_prop_set_endpoint,
>>                                     NULL);
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 078fc5d239..696fed5b5b 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -52,7 +52,8 @@ static void get_enum(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,
>>      Property *prop =3D opaque;
>>      int *ptr =3D qdev_get_prop_ptr(dev, prop);
>>
>> -    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
>> +    visit_type_enum(v, prop->name, ptr, prop->info->enum_table,
>> +                    prop->info->enum_table_size, errp);
>>  }
>>
>>  static void set_enum(Object *obj, Visitor *v, const char *name, void *o=
paque,
>> @@ -67,7 +68,8 @@ static void set_enum(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,
>>          return;
>>      }
>>
>> -    visit_type_enum(v, prop->name, ptr, prop->info->enum_table, errp);
>> +    visit_type_enum(v, prop->name, ptr, prop->info->enum_table,
>> +                    prop->info->enum_table_size, errp);
>>  }
>>
>>  static void set_default_value_enum(Object *obj, const Property *prop)
>> @@ -586,6 +588,7 @@ const PropertyInfo qdev_prop_on_off_auto =3D {
>>      .name =3D "OnOffAuto",
>>      .description =3D "on/off/auto",
>>      .enum_table =3D OnOffAuto_lookup,
>> +    .enum_table_size =3D ON_OFF_AUTO__MAX,
>>      .get =3D get_enum,
>>      .set =3D set_enum,
>>      .set_default_value =3D set_default_value_enum,
>> @@ -598,6 +601,7 @@ QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) !=3D sizeof=
(int));
>>  const PropertyInfo qdev_prop_losttickpolicy =3D {
>>      .name  =3D "LostTickPolicy",
>>      .enum_table  =3D LostTickPolicy_lookup,
>> +    .enum_table_size =3D LOST_TICK_POLICY__MAX,
>>      .get   =3D get_enum,
>>      .set   =3D set_enum,
>>      .set_default_value =3D set_default_value_enum,
>> @@ -612,6 +616,7 @@ const PropertyInfo qdev_prop_blockdev_on_error =3D {
>>      .description =3D "Error handling policy, "
>>                     "report/ignore/enospc/stop/auto",
>>      .enum_table =3D BlockdevOnError_lookup,
>> +    .enum_table_size =3D BLOCKDEV_ON_ERROR__MAX,
>>      .get =3D get_enum,
>>      .set =3D set_enum,
>>      .set_default_value =3D set_default_value_enum,
>> @@ -626,6 +631,7 @@ const PropertyInfo qdev_prop_bios_chs_trans =3D {
>>      .description =3D "Logical CHS translation algorithm, "
>>                     "auto/none/lba/large/rechs",
>>      .enum_table =3D BiosAtaTranslation_lookup,
>> +    .enum_table_size =3D BIOS_ATA_TRANSLATION__MAX,
>>      .get =3D get_enum,
>>      .set =3D set_enum,
>>      .set_default_value =3D set_default_value_enum,
>> @@ -638,6 +644,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
>>      .description =3D "FDC drive type, "
>>                     "144/288/120/none/auto",
>>      .enum_table =3D FloppyDriveType_lookup,
>> +    .enum_table_size =3D FLOPPY_DRIVE_TYPE__MAX,
>>      .get =3D get_enum,
>>      .set =3D set_enum,
>>      .set_default_value =3D set_default_value_enum,
>> diff --git a/net/filter.c b/net/filter.c
>> index 1dfd2caa23..cf62851344 100644
>> --- a/net/filter.c
>> +++ b/net/filter.c
>> @@ -180,6 +180,7 @@ static void netfilter_init(Object *obj)
>>                              NULL);
>>      object_property_add_enum(obj, "queue", "NetFilterDirection",
>>                               NetFilterDirection_lookup,
>> +                             NET_FILTER_DIRECTION__MAX,
>>                               netfilter_get_direction, netfilter_set_dir=
ection,
>>                               NULL);
>>      object_property_add_str(obj, "status",
>> diff --git a/qom/object.c b/qom/object.c
>> index fe6e744b4d..425bae3a2a 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -1247,6 +1247,7 @@ uint64_t object_property_get_uint(Object *obj, con=
st char *name,
>>
>>  typedef struct EnumProperty {
>>      const char * const *strings;
>> +    int nstrings;
>>      int (*get)(Object *, Error **);
>>      void (*set)(Object *, int, Error **);
>>  } EnumProperty;
>> @@ -1284,7 +1285,7 @@ int object_property_get_enum(Object *obj, const ch=
ar *name,
>>      visit_complete(v, &str);
>>      visit_free(v);
>>      v =3D string_input_visitor_new(str);
>> -    visit_type_enum(v, name, &ret, enumprop->strings, errp);
>> +    visit_type_enum(v, name, &ret, enumprop->strings, enumprop->nstring=
s, errp);
>
> Long line.
>
>>
>>      g_free(str);
>>      visit_free(v);
>> @@ -1950,7 +1951,7 @@ static void property_get_enum(Object *obj, Visitor=
 *v, const char *name,
>>          return;
>>      }
>>
>> -    visit_type_enum(v, name, &value, prop->strings, errp);
>> +    visit_type_enum(v, name, &value, prop->strings, prop->nstrings, err=
p);
>>  }
>>
>>  static void property_set_enum(Object *obj, Visitor *v, const char *name=
,
>> @@ -1960,7 +1961,7 @@ static void property_set_enum(Object *obj, Visitor=
 *v, const char *name,
>>      int value;
>>      Error *err =3D NULL;
>>
>> -    visit_type_enum(v, name, &value, prop->strings, &err);
>> +    visit_type_enum(v, name, &value, prop->strings, prop->nstrings, &er=
r);
>>      if (err) {
>>          error_propagate(errp, err);
>>          return;
>> @@ -1978,6 +1979,7 @@ static void property_release_enum(Object *obj, con=
st char *name,
>>  void object_property_add_enum(Object *obj, const char *name,
>>                                const char *typename,
>>                                const char * const *strings,
>> +                              int nstrings,
>>                                int (*get)(Object *, Error **),
>>                                void (*set)(Object *, int, Error **),
>>                                Error **errp)
>> @@ -1986,6 +1988,7 @@ void object_property_add_enum(Object *obj, const c=
har *name,
>>      EnumProperty *prop =3D g_malloc(sizeof(*prop));
>>
>>      prop->strings =3D strings;
>> +    prop->nstrings =3D nstrings;
>>      prop->get =3D get;
>>      prop->set =3D set;
>>
>> @@ -2003,6 +2006,7 @@ void object_property_add_enum(Object *obj, const c=
har *name,
>>  void object_class_property_add_enum(ObjectClass *klass, const char *nam=
e,
>>                                      const char *typename,
>>                                      const char * const *strings,
>> +                                    int nstrings,
>>                                      int (*get)(Object *, Error **),
>>                                      void (*set)(Object *, int, Error **=
),
>>                                      Error **errp)
>> @@ -2011,6 +2015,7 @@ void object_class_property_add_enum(ObjectClass *k=
lass, const char *name,
>>      EnumProperty *prop =3D g_malloc(sizeof(*prop));
>>
>>      prop->strings =3D strings;
>> +    prop->nstrings =3D nstrings;
>>      prop->get =3D get;
>>      prop->set =3D set;
>>
>> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
>> index 432b66585f..1179030248 100644
>> --- a/tests/check-qom-proplist.c
>> +++ b/tests/check-qom-proplist.c
>> @@ -143,6 +143,7 @@ static void dummy_class_init(ObjectClass *cls, void =
*data)
>>      object_class_property_add_enum(cls, "av",
>>                                     "DummyAnimal",
>>                                     dummy_animal_map,
>> +                                   DUMMY_LAST,
>>                                     dummy_get_av,
>>                                     dummy_set_av,
>>                                     NULL);
>> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inp=
ut-visitor.c
>> index 1969733971..4da5d02c35 100644
>> --- a/tests/test-qobject-input-visitor.c
>> +++ b/tests/test-qobject-input-visitor.c
>> @@ -1110,7 +1110,7 @@ static void test_visitor_in_fail_struct_missing(Te=
stInputVisitorData *data,
>>      error_free_or_abort(&err);
>>      visit_optional(v, "optional", &present);
>>      g_assert(!present);
>> -    visit_type_enum(v, "enum", &en, EnumOne_lookup, &err);
>> +    visit_type_enum(v, "enum", &en, EnumOne_lookup, ENUM_ONE__MAX, &err=
);
>>      error_free_or_abort(&err);
>>      visit_type_int(v, "i64", &i64, &err);
>>      error_free_or_abort(&err);
>
> Missing: a review of FOO_lookup[] uses outside these two, to make sure
> none of them fall into holes like input_type_enum() would.  From the top
> of my head: qapi_enum_parse().  A quick grep for loops counting up to
> FOO__MAX additionally finds get_event_by_name() in blkdebug.c,
> parse_read_pattern() in quorum.c, hmp_migrate_set_capability() in hmp.c,
> and then I stopped looking.  Most (or all?) of them should use
> qapi_enum_parse().
>
> There's one patch hunk to make input_type_enum() cope with holes, one
> patch hunk to opportunistically simplify output_type_enum(), and all the
> others are for plumbing the table size to these two.  That's a lot of
> plumbing.  Can't say I like it.
>
> Alternatives:
>
> (1) Use a value other than NULL for holes, say ""
>
> (2) Use a value other than NULL for the sentinel, say ""
>
> (3) Store the length in the lookup table, i.e. change it from
>     const char *const[] to struct { int n, const char *const s[] }.
>
> The least work is probably (1).  Slightly ugly.
>
> If you do (3), please consider getting rid of the sentinel.
>

I have done (3)

--=20
Marc-Andr=C3=A9 Lureau
