Received: from eggs.gnu.org ([2001:4830:134:3::10]:43975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlNO-0007R9-JW
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGlNM-0008BW-Hl
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:12:54 -0400
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6027508c-717e-d3c2-6704-0c1b614fca89@redhat.com>
Date: Thu, 10 May 2018 08:12:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180509165530.29561-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/13] qapi: Add default-variant for flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/09/2018 11:55 AM, Max Reitz wrote:
> This patch allows specifying a discriminator that is an optional member
> of the base struct.  In such a case, a default value must be provided
> that is used when no value is given.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/introspect.json           |  8 ++++++
>   scripts/qapi/common.py         | 57 ++++++++++++++++++++++++++++++++++--------
>   scripts/qapi/doc.py            |  8 ++++--
>   scripts/qapi/introspect.py     | 10 +++++---
>   scripts/qapi/visit.py          | 33 ++++++++++++++++++++++--
>   tests/qapi-schema/test-qapi.py |  2 ++
>   6 files changed, 101 insertions(+), 17 deletions(-)

I've been threatening that we might need this for some time, so I'm glad 
to see it being implemented.  We'll see if the tests in 2 and 3 cover 
the code added here.

> 
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index c7f67b7d78..2d7b1e3745 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -168,6 +168,13 @@
>   # @tag: the name of the member serving as type tag.
>   #       An element of @members with this name must exist.
>   #
> +# @default-variant: if the @tag element of @members is optional, this
> +#                   is the default value for choosing a variant.  Its
> +#                   value must be a valid value for @tag.

Perhaps s/must/will/ as this struct is used for output (and therefore we 
always meet the condition, rather than the user having to do something 
correctly).

Nice that you remembered introspection.

> +#                   Present exactly when @tag is present and the
> +#                   associated element of @members is optional.
> +#                   (Since: 2.13)
> +#
>   # @variants: variant members, i.e. additional members that
>   #            depend on the type tag's value.  Present exactly when
>   #            @tag is present.  The variants are in no particular order,
> @@ -181,6 +188,7 @@
>   { 'struct': 'SchemaInfoObject',
>     'data': { 'members': [ 'SchemaInfoObjectMember' ],
>               '*tag': 'str',
> +            '*default-variant': 'str',
>               '*variants': [ 'SchemaInfoObjectVariant' ] } }
>   
>   ##
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index a032cec375..fbf0244f73 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -721,6 +721,7 @@ def check_union(expr, info):
>       name = expr['union']
>       base = expr.get('base')
>       discriminator = expr.get('discriminator')
> +    default_variant = expr.get('default-variant')
>       members = expr['data']
>   
>       # Two types of unions, determined by discriminator.
> @@ -745,16 +746,37 @@ def check_union(expr, info):
>           base_members = find_base_members(base)
>           assert base_members is not None
>   
> -        # The value of member 'discriminator' must name a non-optional
> -        # member of the base struct.
> +        # The value of member 'discriminator' must name a member of
> +        # the base struct.
>           check_name(info, "Discriminator of flat union '%s'" % name,
>                      discriminator)
> -        discriminator_type = base_members.get(discriminator)
> -        if not discriminator_type:
> -            raise QAPISemError(info,
> -                               "Discriminator '%s' is not a member of base "
> -                               "struct '%s'"
> -                               % (discriminator, base))
> +        if default_variant is None:
> +            discriminator_type = base_members.get(discriminator)
> +            if not discriminator_type:
> +                if base_members.get('*' + discriminator) is None:

Unrelated to your patch, but this reminds me - we already had a question 
on list about whether we should allow ANY member of the base struct, 
rather than the members directly declared in the struct.  (The use case 
was that if you have a grandparent struct, then an intermediate base 
struct, the code as written does not permit the discriminator to come 
from the grandparent struct, which is awkward - but if I also recall 
correctly, the question came up in relation to the query-cpus-fast 
command, where we ended up not refactoring things after all due to 
deprecation of query-cpus).

> +                    raise QAPISemError(info,
> +                                       "Discriminator '%s' is not a member of "
> +                                       "base struct '%s'"
> +                                       % (discriminator, base))
> +                else:
> +                    raise QAPISemError(info,
> +                                       "Default variant must be specified for "
> +                                       "optional discriminator '%s'"
> +                                       % discriminator)
> +        else:
> +            discriminator_type = base_members.get('*' + discriminator)
> +            if not discriminator_type:
> +                if base_members.get(discriminator) is None:
> +                    raise QAPISemError(info,
> +                                       "Discriminator '%s' is not a member of "
> +                                       "base struct '%s'"
> +                                       % (discriminator, base))
> +                else:
> +                    raise QAPISemError(info,
> +                                       "Must not specify a default variant for "
> +                                       "non-optional discriminator '%s'"
> +                                       % discriminator)
> +

Looks like you've got good error messages for all the cases of enforcing 
the rule that default-variant and optional member must be used together.

>           enum_define = enum_types.get(discriminator_type)
>           allow_metas = ['struct']
>           # Do not allow string discriminator
> @@ -763,6 +785,15 @@ def check_union(expr, info):
>                                  "Discriminator '%s' must be of enumeration "
>                                  "type" % discriminator)
>   
> +        if default_variant is not None:
> +            # Must be a value of the enumeration
> +            if default_variant not in enum_define['data']:
> +                raise QAPISemError(info,
> +                                   "Default variant '%s' of flat union '%s' is "
> +                                   "not part of '%s'"
> +                                   % (default_variant, name,
> +                                      discriminator_type))
> +
>       # Check every branch; don't allow an empty union
>       if len(members) == 0:
>           raise QAPISemError(info, "Union '%s' cannot have empty 'data'" % name)
> @@ -909,7 +940,7 @@ def check_exprs(exprs):
>           elif 'union' in expr:
>               meta = 'union'
>               check_keys(expr_elem, 'union', ['data'],
> -                       ['base', 'discriminator'])
> +                       ['base', 'discriminator', 'default-variant'])
>               union_types[expr[meta]] = expr
>           elif 'alternate' in expr:
>               meta = 'alternate'
> @@ -1335,12 +1366,14 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
>   
>   
>   class QAPISchemaObjectTypeVariants(object):
> -    def __init__(self, tag_name, tag_member, variants):
> +    def __init__(self, tag_name, tag_member, default_tag_value, variants):
>           # Flat unions pass tag_name but not tag_member.
>           # Simple unions and alternates pass tag_member but not tag_name.
>           # After check(), tag_member is always set, and tag_name remains
>           # a reliable witness of being used by a flat union.
>           assert bool(tag_member) != bool(tag_name)
> +        # default_tag_value is only passed for flat unions.
> +        assert bool(tag_name) or not bool(default_tag_value)

Looks correct.

>           assert (isinstance(tag_name, str) or
>                   isinstance(tag_member, QAPISchemaObjectTypeMember))
>           assert len(variants) > 0
> @@ -1348,6 +1381,7 @@ class QAPISchemaObjectTypeVariants(object):
>               assert isinstance(v, QAPISchemaObjectTypeVariant)
>           self._tag_name = tag_name
>           self.tag_member = tag_member
> +        self.default_tag_value = default_tag_value
>           self.variants = variants
>   
>       def set_owner(self, name):
> @@ -1637,6 +1671,7 @@ class QAPISchema(object):
>           data = expr['data']
>           base = expr.get('base')
>           tag_name = expr.get('discriminator')
> +        default_tag_value = expr.get('default-variant')
>           tag_member = None
>           if isinstance(base, dict):
>               base = (self._make_implicit_object_type(
> @@ -1656,6 +1691,7 @@ class QAPISchema(object):
>               QAPISchemaObjectType(name, info, doc, base, members,
>                                    QAPISchemaObjectTypeVariants(tag_name,
>                                                                 tag_member,
> +                                                              default_tag_value,
>                                                                 variants)))
>   
>       def _def_alternate_type(self, expr, info, doc):
> @@ -1668,6 +1704,7 @@ class QAPISchema(object):
>               QAPISchemaAlternateType(name, info, doc,
>                                       QAPISchemaObjectTypeVariants(None,
>                                                                    tag_member,
> +                                                                 None,
>                                                                    variants)))
>   
>       def _def_command(self, expr, info, doc):
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> index 9b312b2c51..91204dc4c6 100644
> --- a/scripts/qapi/doc.py
> +++ b/scripts/qapi/doc.py
> @@ -160,8 +160,12 @@ def texi_members(doc, what, base, variants, member_func):
>           items += '@item The members of @code{%s}\n' % base.doc_type()
>       if variants:
>           for v in variants.variants:
> -            when = ' when @code{%s} is @t{"%s"}' % (
> -                variants.tag_member.name, v.name)
> +            if v.name == variants.default_tag_value:
> +                when = ' when @code{%s} is @t{"%s"} or not given' % (
> +                    variants.tag_member.name, v.name)

Nice, you got the generated docs as well as introspection.

> +            else:
> +                when = ' when @code{%s} is @t{"%s"}' % (
> +                    variants.tag_member.name, v.name)
>               if v.type.is_implicit():
>                   assert not v.type.base and not v.type.variants
>                   for m in v.type.local_members:
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index f9e67e8227..2d1d4e320a 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -142,9 +142,12 @@ const QLitObject %(c_name)s = %(c_string)s;
>               ret['default'] = None
>           return ret
>   
> -    def _gen_variants(self, tag_name, variants):
> -        return {'tag': tag_name,
> -                'variants': [self._gen_variant(v) for v in variants]}
> +    def _gen_variants(self, tag_name, default_variant, variants):
> +        ret = {'tag': tag_name,
> +               'variants': [self._gen_variant(v) for v in variants]}
> +        if default_variant:
> +            ret['default-variant'] = default_variant
> +        return ret
>   
>       def _gen_variant(self, variant):
>           return {'case': variant.name, 'type': self._use_type(variant.type)}
> @@ -163,6 +166,7 @@ const QLitObject %(c_name)s = %(c_string)s;
>           obj = {'members': [self._gen_member(m) for m in members]}
>           if variants:
>               obj.update(self._gen_variants(variants.tag_member.name,
> +                                          variants.default_tag_value,
>                                             variants.variants))
>           self._gen_qlit(name, 'object', obj)
>   
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 5d72d8936c..ecffc46bd3 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -40,10 +40,20 @@ def gen_visit_object_members(name, base, members, variants):
>   void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
>   {
>       Error *err = NULL;
> -
>   ''',
>                   c_name=c_name(name))
>   
> +    if variants:
> +        ret += mcgen('''
> +    %(c_type)s %(c_name)s;
> +''',
> +                     c_type=variants.tag_member.type.c_name(),
> +                     c_name=c_name(variants.tag_member.name))
> +
> +    ret += mcgen('''
> +
> +''')
> +

Creating a temp variable makes it easier to handle the default...

>       if base:
>           ret += mcgen('''
>       visit_type_%(c_type)s_members(v, (%(c_type)s *)obj, &err);
> @@ -75,8 +85,27 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
>   ''')
>   
>       if variants:
> +        if variants.default_tag_value is None:
> +            ret += mcgen('''
> +    %(c_name)s = obj->%(c_name)s;
> +''',
> +                         c_name=c_name(variants.tag_member.name))
> +        else:
> +            ret += mcgen('''
> +    if (obj->has_%(c_name)s) {
> +        %(c_name)s = obj->%(c_name)s;
> +    } else {
> +        %(c_name)s = %(enum_const)s;
> +    }
> +''',
> +                         c_name=c_name(variants.tag_member.name),
> +                         enum_const=c_enum_const(
> +                             variants.tag_member.type.name,
> +                             variants.default_tag_value,
> +                             variants.tag_member.type.prefix))
> +
>           ret += mcgen('''
> -    switch (obj->%(c_name)s) {
> +    switch (%(c_name)s) {

...compared to the old code that just inlined the one thing that used to 
be assigned to what is now the temporary variable.

It might be possible to inline things so that the generated code reads 
either:

switch (obj->discriminator) {
switch (!obj->has_discriminator ? DEFAULT : obj->discriminator) {

but I don't think it's worth the effort; and the temporary variable is 
fine even though it makes the generated file bigger.

>   ''',
>                        c_name=c_name(variants.tag_member.name))
>   
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
> index c1a144ba29..f2a072b92e 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -56,6 +56,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>       def _print_variants(variants):
>           if variants:
>               print('    tag %s' % variants.tag_member.name)
> +            if variants.default_tag_value:
> +                print('    default variant: %s' % variants.default_tag_value)
>               for v in variants.variants:
>                   print('    case %s: %s' % (v.name, v.type.name))
>   
> 

Looks good!
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
