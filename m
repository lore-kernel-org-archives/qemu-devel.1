Received: from eggs.gnu.org ([2001:4830:134:3::10]:43535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fTO8L-0001xS-Ax
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fTO8G-0002Lm-8h
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:01:33 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com
	([104.47.0.96]:50591
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fTO8F-0002LT-CK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:01:28 -0400
References: <1528905228-25694-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1528905228-25694-2-git-send-email-anton.nefedov@virtuozzo.com>
	<87sh5pomxj.fsf@dusky.pond.sub.org>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <d6d3f6ec-3d6b-99b7-8e09-8b3072355916@virtuozzo.com>
Date: Thu, 14 Jun 2018 12:01:21 +0300
MIME-Version: 1.0
In-Reply-To: <87sh5pomxj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qapi: allow empty branches in flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com



On 14/6/2018 10:19 AM, Markus Armbruster wrote:
> Anton Nefedov <anton.nefedov@virtuozzo.com> writes:
> 
>> It often happens that just a few discriminator values imply extra data in
>> a flat union. Existing checks did not make possible to leave other values
>> uncovered. Such cases had to be worked around by either stating a dummy
>> (empty) type or introducing another (subset) discriminator enumeration.
>>
>> Both options create redundant entities in qapi files for little profit.
>>
>> With this patch it is not necessary anymore to add designated union
>> fields for every possible value of a discriminator enumeration.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   docs/devel/qapi-code-gen.txt                        |  8 +++++---
>>   tests/qapi-schema/flat-union-incomplete-branch.json |  9 ---------
>>   tests/qapi-schema/qapi-schema-test.json             |  4 ++--
>>   scripts/qapi/common.py                              | 11 ++++-------
>>   scripts/qapi/types.py                               |  4 +++-
>>   scripts/qapi/visit.py                               | 17 +++++++++++++----
>>   tests/Makefile.include                              |  1 -
>>   tests/qapi-schema/flat-union-incomplete-branch.err  |  1 -
>>   tests/qapi-schema/flat-union-incomplete-branch.exit |  1 -
>>   tests/qapi-schema/flat-union-incomplete-branch.out  |  0
>>   tests/qapi-schema/qapi-schema-test.out              |  3 ++-
>>   11 files changed, 29 insertions(+), 30 deletions(-)
>>   delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.json
>>   delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.err
>>   delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.exit
>>   delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.out
>>
>> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
>> index 1366228..88a70e4 100644
>> --- a/docs/devel/qapi-code-gen.txt
>> +++ b/docs/devel/qapi-code-gen.txt
>> @@ -496,9 +496,11 @@ Resulting in these JSON objects:
>>   
>>   Notice that in a flat union, the discriminator name is controlled by
>>   the user, but because it must map to a base member with enum type, the
>> -code generator can ensure that branches exist for all values of the
>> -enum (although the order of the keys need not match the declaration of
>> -the enum).  In the resulting generated C data types, a flat union is
>> +code generator ensures that branches match the existing values of the
>> +enum. The order of the keys need not match the declaration of the enum.
>> +The keys need not cover all possible enum values. Omitted enum values
>> +are still valid branches that add no additional members to the data type.
>> +In the resulting generated C data types, a flat union is
>>   represented as a struct with the base members included directly, and
>>   then a union of structures for each branch of the struct.
>>   
>> diff --git a/tests/qapi-schema/flat-union-incomplete-branch.json b/tests/qapi-schema/flat-union-incomplete-branch.json
>> deleted file mode 100644
>> index 25a411b..0000000
>> --- a/tests/qapi-schema/flat-union-incomplete-branch.json
>> +++ /dev/null
>> @@ -1,9 +0,0 @@
>> -# we require all branches of the union to be covered
>> -{ 'enum': 'TestEnum',
>> -  'data': [ 'value1', 'value2' ] }
>> -{ 'struct': 'TestTypeA',
>> -  'data': { 'string': 'str' } }
>> -{ 'union': 'TestUnion',
>> -  'base': { 'type': 'TestEnum' },
>> -  'discriminator': 'type',
>> -  'data': { 'value1': 'TestTypeA' } }
>> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
>> index 46c7282..881b53b 100644
>> --- a/tests/qapi-schema/qapi-schema-test.json
>> +++ b/tests/qapi-schema/qapi-schema-test.json
>> @@ -39,7 +39,7 @@
>>               '*enum1': 'EnumOne' } }   # intentional forward reference
>>   
>>   { 'enum': 'EnumOne',
>> -  'data': [ 'value1', 'value2', 'value3' ] }
>> +  'data': [ 'value1', 'value2', 'value3', 'value4' ] }
>>   
>>   { 'struct': 'UserDefZero',
>>     'data': { 'integer': 'int' } }
>> @@ -76,7 +76,7 @@
>>     'discriminator': 'enum1',
>>     'data': { 'value1' : 'UserDefA',
>>               'value2' : 'UserDefB',
>> -            'value3' : 'UserDefB' } }
>> +            'value3' : 'UserDefB' } } # skip 'value4'
> 
> Perhaps
> 
>                 'value3' : 'UserDefB'
>                  # 'value4' defaults to empty
>               } }
> 
> would be clearer.
> 

Sure

>>   
>>   { 'struct': 'UserDefUnionBase',
>>     'base': 'UserDefZero',
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index 2462fc0..0f3d89b 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -779,13 +779,6 @@ def check_union(expr, info):
>>                                      "enum '%s'"
>>                                      % (key, enum_define['enum']))
>>   
>> -    # If discriminator is user-defined, ensure all values are covered
>> -    if enum_define:
>> -        for value in enum_define['data']:
>> -            if value not in members.keys():
>> -                raise QAPISemError(info, "Union '%s' data missing '%s' branch"
>> -                                   % (name, value))
>> -
>>   
>>   def check_alternate(expr, info):
>>       name = expr['alternate']
>> @@ -1644,6 +1637,10 @@ class QAPISchema(object):
>>           if tag_name:
>>               variants = [self._make_variant(key, value)
>>                           for (key, value) in data.items()]
>> +            # branches that are not explicitly covered get an empty type
>> +            variants += [self._make_variant(key, 'q_empty')
>> +                         for key in discriminator_find_enum_define(expr)['data']
> 
> Long line, flagged by pycodestyle --diff.
> 

Done.

>> +                         if key not in data.keys()]
>>               members = []
>>           else:
>>               variants = [self._make_simple_variant(key, value, info)
> 
> The way you desugar the union is simple enough, but it uses
> discriminator_find_enum_define() outside check_exprs(), which I'd rather
> avoid.  Not something you could be reasonably expected to know.
> 
> We could desugar in QAPISchemaObjectTypeVariants.check(), where we have
> self.tag_member.type.values.
> 
>     @@ -1346,10 +1346,17 @@ class QAPISchemaObjectTypeVariants(object):
>                  v.set_owner(name)
> 
>          def check(self, schema, seen):
>     -        if not self.tag_member:    # flat union
>     +        if not self.tag_member: # flat union
>                  self.tag_member = seen[c_name(self._tag_name)]
>                  assert self._tag_name == self.tag_member.name
>              assert isinstance(self.tag_member.type, QAPISchemaEnumType)
>     +        if self._tag_name:      # flat union
>     +            cases = set([v.name for v in self.variants])
>     +            for val in self.tag_member.type.values:
>     +                if val.name not in cases:
>     +                    v = QAPISchemaObjectTypeVariant(val.name, 'q_empty')
>     +                    v.set_owner(self.tag_member.owner)
>     +                    self.variants.append(v)
>              for v in self.variants:
>                  v.check(schema)
>                  # Union names must match enum values; alternate names are
> 
> Not so simple anymore.
> 
> Simpler: desugar in check_union(), i.e. replace your two hunks by just
> 
>     @@ -783,8 +783,7 @@ def check_union(expr, info):
>          if enum_define:
>              for value in enum_define['data']:
>                  if value not in members.keys():
>     -                raise QAPISemError(info, "Union '%s' data missing '%s' branch"
>     -                                   % (name, value))
>     +                members[value] = 'q_empty'
> 
> 
>      def check_alternate(expr, info):
> 
> What do you think?
> 

it didn't feel right aesthetically to normalize by modifying the parsed
expressions especially at check_exprs() stage. But maybe using
discriminator_find_enum_define() is more sloppy, I can't quite see

>> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
>> index 64d9c0f..1fb2b6d 100644
>> --- a/scripts/qapi/types.py
>> +++ b/scripts/qapi/types.py
>> @@ -124,7 +124,9 @@ def gen_variants(variants):
>>   ''',
>>                   c_name=c_name(variants.tag_member.name))
>>   
>> -    for var in variants.variants:
>> +    # filter out the empty types
>> +    for var in filter(lambda var: var.type.name != 'q_empty',
>> +                      variants.variants):
> 
> The comment's position suggests it tells what the loop does, but that's
> not the case.  Let's do it the old-fashioned obvious way instead:
> 
>         for var in variants.variants:
>             if var.type.name == 'q_empty':
>                 continue
> 

Done.

> Aside: we need to filter out q_empty, because we don't generate a C type
> for it.  Perhaps generating one would be simpler, but that's beyond the
> scope of this patch.
> 
>>           ret += mcgen('''
>>           %(c_type)s %(c_name)s;
>>   ''',
>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index 5d72d89..96bd32c 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -81,14 +81,23 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
>>                        c_name=c_name(variants.tag_member.name))
>>   
>>           for var in variants.variants:
>> -            ret += mcgen('''
>> +            case_str = c_enum_const(variants.tag_member.type.name,
>> +                                    var.name,
>> +                                    variants.tag_member.type.prefix)
>> +            if var.type.name == 'q_empty':
>> +                # valid variant and nothing to do
>> +                ret += mcgen('''
>> +    case %(case)s:
>> +        break;
>> +''',
>> +                             case=case_str)
>> +            else:
>> +                ret += mcgen('''
> 
> Aside: we need this, because we don't generate a visitor for q_empty.
> 
>>       case %(case)s:
>>           visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, &err);
>>           break;
>>   ''',
>> -                         case=c_enum_const(variants.tag_member.type.name,
>> -                                           var.name,
>> -                                           variants.tag_member.type.prefix),
>> +                         case=case_str,
>>                            c_type=var.type.c_name(), c_name=c_name(var.name))
> 
> Indentation's off, flagged by pycodestyle --diff.
> 

Done.

>>   
>>           ret += mcgen('''
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index bb08e37..afdd0db 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -496,7 +496,6 @@ qapi-schema += flat-union-base-any.json
>>   qapi-schema += flat-union-base-union.json
>>   qapi-schema += flat-union-clash-member.json
>>   qapi-schema += flat-union-empty.json
>> -qapi-schema += flat-union-incomplete-branch.json
>>   qapi-schema += flat-union-inline.json
>>   qapi-schema += flat-union-int-branch.json
>>   qapi-schema += flat-union-invalid-branch-key.json
>> diff --git a/tests/qapi-schema/flat-union-incomplete-branch.err b/tests/qapi-schema/flat-union-incomplete-branch.err
>> deleted file mode 100644
>> index e826bf0..0000000
>> --- a/tests/qapi-schema/flat-union-incomplete-branch.err
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -tests/qapi-schema/flat-union-incomplete-branch.json:6: Union 'TestUnion' data missing 'value2' branch
>> diff --git a/tests/qapi-schema/flat-union-incomplete-branch.exit b/tests/qapi-schema/flat-union-incomplete-branch.exit
>> deleted file mode 100644
>> index d00491f..0000000
>> --- a/tests/qapi-schema/flat-union-incomplete-branch.exit
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -1
>> diff --git a/tests/qapi-schema/flat-union-incomplete-branch.out b/tests/qapi-schema/flat-union-incomplete-branch.out
>> deleted file mode 100644
>> index e69de29..0000000
>> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
>> index 542a19c..0dbcdaf 100644
>> --- a/tests/qapi-schema/qapi-schema-test.out
>> +++ b/tests/qapi-schema/qapi-schema-test.out
>> @@ -23,7 +23,7 @@ object UserDefOne
>>       base UserDefZero
>>       member string: str optional=False
>>       member enum1: EnumOne optional=True
>> -enum EnumOne ['value1', 'value2', 'value3']
>> +enum EnumOne ['value1', 'value2', 'value3', 'value4']
>>   object UserDefZero
>>       member integer: int optional=False
>>   object UserDefTwoDictDict
>> @@ -52,6 +52,7 @@ object UserDefFlatUnion
>>       case value1: UserDefA
>>       case value2: UserDefB
>>       case value3: UserDefB
>> +    case value4: q_empty
>>   object UserDefUnionBase
>>       base UserDefZero
>>       member string: str optional=False
