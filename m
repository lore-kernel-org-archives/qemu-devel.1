Received: from eggs.gnu.org ([2001:4830:134:3::10]:52370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7BW-0007cM-6u
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7BS-0002bU-Um
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:17:26 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:35988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dk7BS-0002bL-OG
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:17:22 -0400
Received: by mail-ua0-x241.google.com with SMTP id l47so346392uai.3
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 04:17:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87shgrbyou.fsf@dusky.pond.sub.org>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-5-marcandre.lureau@redhat.com>
	<87shgrbyou.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Aug 2017 13:17:21 +0200
Message-ID: <CAJ+F1CKr-jh9XjcAF-vmU3nsjuRKG-b-3MUUKrs9HzSqg70N6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/26] qapi: generate a literal qobject for
 introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Wed, Aug 16, 2017 at 12:21 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Replace the generated json string with a literal qobject. The later is
>> easier to deal with, at run time, as well as compile time:
>
> at run time as well as compile time
>
>>                                                            #if blocks
>> can be more easily added than in a json string.
>
> Future tense, e.g. "adding #if conditionals will be easier".

ok

>
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi-introspect.py         | 83 +++++++++++++++++++++----------=
-------
>>  monitor.c                          |  2 +-
>>  tests/test-qobject-input-visitor.c | 10 +++--
>>  docs/devel/qapi-code-gen.txt       | 29 ++++++++-----
>>  4 files changed, 72 insertions(+), 52 deletions(-)
>>
>> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
>> index 032bcea491..fc72cdb66d 100644
>> --- a/scripts/qapi-introspect.py
>> +++ b/scripts/qapi-introspect.py
>> @@ -12,72 +12,74 @@
>>  from qapi import *
>>
>>
>> -# Caveman's json.dumps() replacement (we're stuck at Python 2.4)
>> -# TODO try to use json.dumps() once we get unstuck
>> -def to_json(obj, level=3D0):
>> +def to_qlit(obj, level=3D0, first_indent=3DTrue):
>
> Suggest suppress_indent=3DFalse.  I prefer defaulting to False.

It's not about suppressing whole indent, just the first.

I suggest you rewrite the code in a follow-up patch if you have an
idea how to do it.

I'd like this apporach in general for the whole series, since it is
long and tedious to deal with that many patches, and not always easy
to understand what you want.  If something works, it will be easier to
get it done and improve the code as follow-up. This approach worked
better when we ended qapi-doc for ex, and you followed up soon after
with 50 more patches ;).

>
>> +    def indent(level):
>> +        return level * 4 * ' '
>
> Blank line before and after nested function definition, please.

ok

>
>> +    ret =3D ''
>> +    if first_indent:
>> +        ret +=3D indent(level)
>>      if obj is None:
>> -        ret =3D 'null'
>> +        ret +=3D 'QLIT_QNULL'
>>      elif isinstance(obj, str):
>> -        ret =3D '"' + obj.replace('"', r'\"') + '"'
>> +        ret +=3D 'QLIT_QSTR(' + '"' + obj.replace('"', r'\"') + '"' + '=
)'
>
> Why not
>
>            ret +=3D 'QLIT_QSTR("' + obj.replace('"', r'\"') + '")'
>
> Hmm, make that
>
>            ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
>
> because it makes the meaning more obvious, and it's also more robust: it
> doubles backslashes.

I can't find to_c_string(), I added one

>
>>      elif isinstance(obj, list):
>> -        elts =3D [to_json(elt, level + 1)
>> +        elts =3D [to_qlit(elt, level + 1)
>>                  for elt in obj]
>> -        ret =3D '[' + ', '.join(elts) + ']'
>> +        elts.append(indent(level + 1) + "{ }")
>
> I'd prefer "{}".  More of the same below.

ok

>
>> +        ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
>> +        ret +=3D ',\n'.join(elts) + '\n'
>> +        ret +=3D indent(level) + '}))'
>
> The extra pair of parenthesis in QLIT_QLIST(( ... )) is slightly ugly.
> Not this patch's fault.  Same for QLIT_QDICT(( ... )) below.
>
>>      elif isinstance(obj, dict):
>> -        elts =3D ['"%s": %s' % (key.replace('"', r'\"'),
>> -                              to_json(obj[key], level + 1))
>> -                for key in sorted(obj.keys())]
>> -        ret =3D '{' + ', '.join(elts) + '}'
>> +        elts =3D [ indent(level + 1) + '{ "%s", %s }' %
>> +                 (key.replace('"', r'\"'), to_qlit(obj[key], level + 1,=
 False))
>
> $ pep8 scripts/qapi-introspect.py
> scripts/qapi-introspect.py:33:17: E201 whitespace after '['
>
> Also, break lines at operators with the least precedence, not in the
> middle of sub-expressions.
>
> However
>
>            elts =3D [indent(level + 1)
>                    + ('{ "%s", %s }'
>                       % (to_c_string(key),
>                          to_qlit(obj[key], level + 1, suppress_indent=3DT=
rue)))
>                    for key in sorted(obj.keys())]
>
> is still illegible.  I'm afraid this is simply too complex for a list
> comprehension.  Try rewriting as a loop.
>

ok

> Another option would be separating off indentation: generate the C
> initializer unindented, then feed it to a stupid indenter that counts
> parentheses (round, square and curly).

hmm

>
>> +                 for key in sorted(obj.keys())]
>> +        elts.append(indent(level + 1) + '{ }')
>> +        ret +=3D 'QLIT_QDICT(((QLitDictEntry[]) {\n'
>> +        ret +=3D ',\n'.join(elts) + '\n'
>> +        ret +=3D indent(level) + '}))'
>>      else:
>>          assert False                # not implemented
>> -    if level =3D=3D 1:
>> -        ret =3D '\n' + ret
>>      return ret
>>
>>
>> -def to_c_string(string):
>> -    return '"' + string.replace('\\', r'\\').replace('"', r'\"') + '"'
>> -
>> -
>>  class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
>>      def __init__(self, unmask):
>>          self._unmask =3D unmask
>>          self.defn =3D None
>>          self.decl =3D None
>>          self._schema =3D None
>> -        self._jsons =3D None
>> +        self._qlits =3D None
>>          self._used_types =3D None
>>          self._name_map =3D None
>>
>>      def visit_begin(self, schema):
>>          self._schema =3D schema
>> -        self._jsons =3D []
>> +        self._qlits =3D []
>>          self._used_types =3D []
>>          self._name_map =3D {}
>>
>>      def visit_end(self):
>>          # visit the types that are actually used
>> -        jsons =3D self._jsons
>> -        self._jsons =3D []
>> +        qlits =3D self._qlits
>> +        self._qlits =3D []
>>          for typ in self._used_types:
>>              typ.visit(self)
>>          # generate C
>>          # TODO can generate awfully long lines
>> -        jsons.extend(self._jsons)
>> -        name =3D c_name(prefix, protect=3DFalse) + 'qmp_schema_json'
>> +        qlits.extend(self._qlits)
>> +        name =3D c_name(prefix, protect=3DFalse) + 'qmp_schema_qlit'
>>          self.decl =3D mcgen('''
>> -extern const char %(c_name)s[];
>> +extern const QLitObject %(c_name)s;
>>  ''',
>>                            c_name=3Dc_name(name))
>> -        lines =3D to_json(jsons).split('\n')
>> -        c_string =3D '\n    '.join([to_c_string(line) for line in lines=
])
>> +        c_string =3D to_qlit(qlits)
>
> The value is simple, and it's used just once.  Let's eliminate the
> variable.
>
>>          self.defn =3D mcgen('''
>> -const char %(c_name)s[] =3D %(c_string)s;
>> +const QLitObject %(c_name)s =3D %(c_string)s;
>>  ''',
>>                            c_name=3Dc_name(name),
>>                            c_string=3Dc_string)
>>          self._schema =3D None
>> -        self._jsons =3D None
>> +        self._qlits =3D None
>>          self._used_types =3D None
>>          self._name_map =3D None
>>
>> @@ -111,12 +113,12 @@ const char %(c_name)s[] =3D %(c_string)s;
>>              return '[' + self._use_type(typ.element_type) + ']'
>>          return self._name(typ.name)
>>
>> -    def _gen_json(self, name, mtype, obj):
>> +    def _gen_qlit(self, name, mtype, obj):
>>          if mtype not in ('command', 'event', 'builtin', 'array'):
>>              name =3D self._name(name)
>>          obj['name'] =3D name
>>          obj['meta-type'] =3D mtype
>> -        self._jsons.append(obj)
>> +        self._qlits.append(obj)
>>
>>      def _gen_member(self, member):
>>          ret =3D {'name': member.name, 'type': self._use_type(member.typ=
e)}
>> @@ -132,24 +134,24 @@ const char %(c_name)s[] =3D %(c_string)s;
>>          return {'case': variant.name, 'type': self._use_type(variant.ty=
pe)}
>>
>>      def visit_builtin_type(self, name, info, json_type):
>> -        self._gen_json(name, 'builtin', {'json-type': json_type})
>> +        self._gen_qlit(name, 'builtin', {'json-type': json_type})
>>
>>      def visit_enum_type(self, name, info, values, prefix):
>> -        self._gen_json(name, 'enum', {'values': values})
>> +        self._gen_qlit(name, 'enum', {'values': values})
>>
>>      def visit_array_type(self, name, info, element_type):
>>          element =3D self._use_type(element_type)
>> -        self._gen_json('[' + element + ']', 'array', {'element-type': e=
lement})
>> +        self._gen_qlit('[' + element + ']', 'array', {'element-type': e=
lement})
>>
>>      def visit_object_type_flat(self, name, info, members, variants):
>>          obj =3D {'members': [self._gen_member(m) for m in members]}
>>          if variants:
>>              obj.update(self._gen_variants(variants.tag_member.name,
>>                                            variants.variants))
>> -        self._gen_json(name, 'object', obj)
>> +        self._gen_qlit(name, 'object', obj)
>>
>>      def visit_alternate_type(self, name, info, variants):
>> -        self._gen_json(name, 'alternate',
>> +        self._gen_qlit(name, 'alternate',
>>                         {'members': [{'type': self._use_type(m.type)}
>>                                      for m in variants.variants]})
>>
>> @@ -157,13 +159,13 @@ const char %(c_name)s[] =3D %(c_string)s;
>>                        gen, success_response, boxed):
>>          arg_type =3D arg_type or self._schema.the_empty_object_type
>>          ret_type =3D ret_type or self._schema.the_empty_object_type
>> -        self._gen_json(name, 'command',
>> +        self._gen_qlit(name, 'command',
>>                         {'arg-type': self._use_type(arg_type),
>>                          'ret-type': self._use_type(ret_type)})
>>
>>      def visit_event(self, name, info, arg_type, boxed):
>>          arg_type =3D arg_type or self._schema.the_empty_object_type
>> -        self._gen_json(name, 'event', {'arg-type': self._use_type(arg_t=
ype)})
>> +        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_t=
ype)})
>>
>>  # Debugging aid: unmask QAPI schema's type names
>>  # We normally mask them, because they're not QMP wire ABI
>> @@ -205,11 +207,18 @@ h_comment =3D '''
>>
>>  fdef.write(mcgen('''
>>  #include "qemu/osdep.h"
>> +#include "qapi/qmp/qlit.h"
>>  #include "%(prefix)sqmp-introspect.h"
>>
>>  ''',
>>                   prefix=3Dprefix))
>>
>> +fdecl.write(mcgen('''
>> +#include "qemu/osdep.h"
>> +#include "qapi/qmp/qlit.h"
>> +
>> +'''))
>> +
>>  schema =3D QAPISchema(input_file)
>>  gen =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
>>  schema.visit(gen)
>> diff --git a/monitor.c b/monitor.c
>> index 6d040e620f..a1773d5bc7 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -953,7 +953,7 @@ EventInfoList *qmp_query_events(Error **errp)
>>  static void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
>>                                   Error **errp)
>>  {
>> -    *ret_data =3D qobject_from_json(qmp_schema_json, &error_abort);
>> +    *ret_data =3D qobject_from_qlit(&qmp_schema_qlit);
>>  }
>>
>>  /*
>> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inp=
ut-visitor.c
>> index bcf02617dc..1969733971 100644
>> --- a/tests/test-qobject-input-visitor.c
>> +++ b/tests/test-qobject-input-visitor.c
>> @@ -1247,24 +1247,26 @@ static void test_visitor_in_fail_alternate(TestI=
nputVisitorData *data,
>>  }
>>
>>  static void do_test_visitor_in_qmp_introspect(TestInputVisitorData *dat=
a,
>> -                                              const char *schema_json)
>> +                                              const QLitObject *qlit)
>>  {
>>      SchemaInfoList *schema =3D NULL;
>> +    QObject *obj =3D qobject_from_qlit(qlit);
>>      Visitor *v;
>>
>> -    v =3D visitor_input_test_init_raw(data, schema_json);
>> +    v =3D qobject_input_visitor_new(obj);
>>
>>      visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
>>      g_assert(schema);
>>
>>      qapi_free_SchemaInfoList(schema);
>> +    qobject_decref(obj);
>>  }
>>
>>  static void test_visitor_in_qmp_introspect(TestInputVisitorData *data,
>>                                             const void *unused)
>>  {
>> -    do_test_visitor_in_qmp_introspect(data, test_qmp_schema_json);
>> -    do_test_visitor_in_qmp_introspect(data, qmp_schema_json);
>> +    do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
>> +    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
>>  }
>>
>
> These tests are only marginally useful now.  Before, they ensured that a
> qapi-introspect.py generating invalid JSON fails at "make check" compile
> time.  Such bugs should now fail when we compile the generated
> qapi-introspect.c.
>
>>  int main(int argc, char **argv)
>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
>> index 9903ac4c19..885c61b52f 100644
>> --- a/docs/devel/qapi-code-gen.txt
>> +++ b/docs/devel/qapi-code-gen.txt
>> @@ -1295,18 +1295,27 @@ Example:
>>      #ifndef EXAMPLE_QMP_INTROSPECT_H
>>      #define EXAMPLE_QMP_INTROSPECT_H
>>
>> -    extern const char example_qmp_schema_json[];
>> +    extern const QLitObject qmp_schema_qlit;
>>
>>      #endif
>>      $ cat qapi-generated/example-qmp-introspect.c
>>  [Uninteresting stuff omitted...]
>>
>> -    const char example_qmp_schema_json[] =3D "["
>> -        "{\"arg-type\": \"0\", \"meta-type\": \"event\", \"name\": \"MY=
_EVENT\"}, "
>> -        "{\"arg-type\": \"1\", \"meta-type\": \"command\", \"name\": \"=
my-command\", \"ret-type\": \"2\"}, "
>> -        "{\"members\": [], \"meta-type\": \"object\", \"name\": \"0\"},=
 "
>> -        "{\"members\": [{\"name\": \"arg1\", \"type\": \"[2]\"}], \"met=
a-type\": \"object\", \"name\": \"1\"}, "
>> -        "{\"members\": [{\"name\": \"integer\", \"type\": \"int\"}, {\"=
default\": null, \"name\": \"string\", \"type\": \"str\"}], \"meta-type\": =
\"object\", \"name\": \"2\"}, "
>> -        "{\"element-type\": \"2\", \"meta-type\": \"array\", \"name\": =
\"[2]\"}, "
>> -        "{\"json-type\": \"int\", \"meta-type\": \"builtin\", \"name\":=
 \"int\"}, "
>> -        "{\"json-type\": \"string\", \"meta-type\": \"builtin\", \"name=
\": \"str\"}]";
>> +    const QLitObject example_qmp_schema_qlit =3D QLIT_QLIST(((QLitObjec=
t[]) {
>> +        QLIT_QDICT(((QLitDictEntry[]) {
>> +            { "arg-type", QLIT_QSTR("0") },
>> +            { "meta-type", QLIT_QSTR("event") },
>> +            { "name", QLIT_QSTR("Event") },
>> +            { }
>> +        })),
>> +        QLIT_QDICT(((QLitDictEntry[]) {
>> +            { "members", QLIT_QLIST(((QLitObject[]) {
>> +                { }
>> +            })) },
>> +            { "meta-type", QLIT_QSTR("object") },
>> +            { "name", QLIT_QSTR("0") },
>> +            { }
>> +        })),
>> +        ....
>
> Ellipsis is three dots, not four :)
>
> Output is no longer complete (less file boilerplate).  Not an issue now,
> but it might become one when we make the examples testable.  We can
> restore the deleted output then.
>

ok



--=20
Marc-Andr=C3=A9 Lureau
