Received: from eggs.gnu.org ([2001:4830:134:3::10]:35259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fY973-0008F3-BM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fY971-0005NG-6t
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:59:53 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fY970-0005Lk-LY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:59:51 -0400
Received: by mail-wm0-x244.google.com with SMTP id z137-v6so5220534wmc.0
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 04:59:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874lhwktjc.fsf@dusky.pond.sub.org>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-15-marcandre.lureau@redhat.com>
	<874lhwktjc.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 Jun 2018 13:59:48 +0200
Message-ID: <CAJ+F1CJsd+PgLYd+rHRsZbtyBJP1cgnc45SzbyFqGOgKKOs3Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/49] qapi-types: add #if conditions to
 types & visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Jun 21, 2018 at 6:12 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Types & visitors are coupled and must be handled together to avoid
>> temporary build regression.
>>
>> Wrap generated types/visitor code with #if/#endif using the context
>> helpers.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi/types.py | 46 ++++++++++++++++++++++++++-----------------
>>  scripts/qapi/visit.py | 33 ++++++++++++++++++-------------
>>  2 files changed, 47 insertions(+), 32 deletions(-)
>>
>> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
>> index 3d9b0f9a07..ce4c91206c 100644
>> --- a/scripts/qapi/types.py
>> +++ b/scripts/qapi/types.py
>> @@ -61,8 +61,10 @@ def gen_variants_objects(variants):
>>          for v in variants.variants:
>>              if isinstance(v.type, QAPISchemaObjectType):
>>                  ret +=3D gen_variants_objects(v.type.variants)
>> +                ret +=3D gen_if(v.type.ifcond)
>>                  ret +=3D gen_object(v.type.name, v.type.base,
>>                                    v.type.local_members, v.type.variants=
)
>> +                ret +=3D gen_endif(v.type.ifcond)
>
> Ignorant question out of curiosity, why is with ifcontext() not usable
> here?
>

ifcontext() works on QAPIGen objects. We could make it work on strings
too, but I don't think it's necessary.

>>      return ret
>>
>>
>> @@ -206,41 +208,49 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCV=
isitor):
>>          # gen_object() is recursive, ensure it doesn't visit the empty =
type
>>          objects_seen.add(schema.the_empty_object_type.name)
>>
>> -    def _gen_type_cleanup(self, name):
>> -        self._genh.add(gen_type_cleanup_decl(name))
>> -        self._genc.add(gen_type_cleanup(name))
>> +    def _gen_type_cleanup(self, name, ifcond):
>> +        with ifcontext(ifcond, self._genh, self._genc):
>> +            self._genh.add(gen_type_cleanup_decl(name))
>> +            self._genc.add(gen_type_cleanup(name))
>>
>>      def visit_enum_type(self, name, info, ifcond, values, prefix):
>> -        self._genh.preamble_add(gen_enum(name, values, prefix))
>> -        self._genc.add(gen_enum_lookup(name, values, prefix))
>> +        with ifcontext(ifcond, self._genh, self._genc):
>> +            self._genh.preamble_add(gen_enum(name, values, prefix))
>> +            self._genc.add(gen_enum_lookup(name, values, prefix))
>>
>>      def visit_array_type(self, name, info, ifcond, element_type):
>> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
>> -        self._genh.add(gen_array(name, element_type))
>> -        self._gen_type_cleanup(name)
>> +        with ifcontext(ifcond, self._genh):
>> +            self._genh.preamble_add(gen_fwd_object_or_array(name))
>> +            self._genh.add(gen_array(name, element_type))
>> +        self._gen_type_cleanup(name, ifcond)
>>
>>      def _gen_object(self, name, info, ifcond, base, members, variants):
>> -        self._genh.add(gen_object(name, base, members, variants))
>> -        if base and not base.is_implicit():
>> -            self._genh.add(gen_upcast(name, base))
>> -        # TODO Worth changing the visitor signature, so we could
>> -        # directly use rather than repeat type.is_implicit()?
>> +        with ifcontext(ifcond, self._genh):
>> +            self._genh.add(gen_object(name, base, members, variants))
>> +            if base and not base.is_implicit():
>> +                self._genh.add(gen_upcast(name, base))
>> +            # TODO Worth changing the visitor signature, so we could
>> +            # directly use rather than repeat type.is_implicit()?
>>          if not name.startswith('q_'):
>>              # implicit types won't be directly allocated/freed
>> -            self._gen_type_cleanup(name)
>> +            self._gen_type_cleanup(name, ifcond)
>> +
>> +    def _gen_fwd_object_or_array(self, name, ifcond):
>> +        with ifcontext(ifcond, self._genh):
>> +            self._genh.preamble_add(gen_fwd_object_or_array(name))
>>
>>      def visit_object_type(self, name, info, ifcond, base, members, vari=
ants):
>>          # Nothing to do for the special empty builtin
>>          if name =3D=3D 'q_empty':
>>              return
>> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
>> +        self._gen_fwd_object_or_array(name, ifcond)
>>          self._genh.add(gen_variants_objects(variants))
>> -        self._gen_object(name, info, None, base, members, variants)
>> +        self._gen_object(name, info, ifcond, base, members, variants)
>>
>>      def visit_alternate_type(self, name, info, ifcond, variants):
>> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
>> +        self._gen_fwd_object_or_array(name, ifcond)
>>          self._genh.add(gen_variants_objects(variants))
>> -        self._gen_object(name, info, None, None,
>> +        self._gen_object(name, info, ifcond, None,
>>                           [variants.tag_member], variants)
>>
>>
>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index 9ea2e04f81..e4a62ce030 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -302,29 +302,34 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularC=
Visitor):
>>                                        types=3Dtypes))
>>
>>      def visit_enum_type(self, name, info, ifcond, values, prefix):
>> -        self._genh.add(gen_visit_decl(name, scalar=3DTrue))
>> -        self._genc.add(gen_visit_enum(name))
>> +        with ifcontext(ifcond, self._genh, self._genc):
>> +            self._genh.add(gen_visit_decl(name, scalar=3DTrue))
>> +            self._genc.add(gen_visit_enum(name))
>>
>>      def visit_array_type(self, name, info, ifcond, element_type):
>> -        self._genh.add(gen_visit_decl(name))
>> -        self._genc.add(gen_visit_list(name, element_type))
>> +        with ifcontext(ifcond, self._genh, self._genc):
>> +            self._genh.add(gen_visit_decl(name))
>> +            self._genc.add(gen_visit_list(name, element_type))
>>
>>      def visit_object_type(self, name, info, ifcond, base, members, vari=
ants):
>>          # Nothing to do for the special empty builtin
>>          if name =3D=3D 'q_empty':
>>              return
>> -        self._genh.add(gen_visit_members_decl(name))
>> -        self._genc.add(gen_visit_object_members(name, base, members, va=
riants))
>> -        # TODO Worth changing the visitor signature, so we could
>> -        # directly use rather than repeat type.is_implicit()?
>> -        if not name.startswith('q_'):
>> -            # only explicit types need an allocating visit
>> -            self._genh.add(gen_visit_decl(name))
>> -            self._genc.add(gen_visit_object(name, base, members, varian=
ts))
>> +        with ifcontext(ifcond, self._genh, self._genc):
>> +            self._genh.add(gen_visit_members_decl(name))
>> +            self._genc.add(gen_visit_object_members(name, base,
>> +                                                    members, variants))
>> +            # TODO Worth changing the visitor signature, so we could
>> +            # directly use rather than repeat type.is_implicit()?
>> +            if not name.startswith('q_'):
>> +                # only explicit types need an allocating visit
>> +                self._genh.add(gen_visit_decl(name))
>> +                self._genc.add(gen_visit_object(name, base, members, va=
riants))
>>
>>      def visit_alternate_type(self, name, info, ifcond, variants):
>> -        self._genh.add(gen_visit_decl(name))
>> -        self._genc.add(gen_visit_alternate(name, variants))
>> +        with ifcontext(ifcond, self._genh, self._genc):
>> +            self._genh.add(gen_visit_decl(name))
>> +            self._genc.add(gen_visit_alternate(name, variants))
>>
>>
>>  def gen_visit(schema, output_dir, prefix, opt_builtins):
>
> The visit part is straightforward: wrap code generation in with
> ifcontext().
>
> The type part is more involved.  First, it passes ifcond to a bunch of
> helpers, which muddies the waters a bit.  Second, you can't just wrap
> object types generation, because it's recursive.  You move the recursion
> out of gen_object() (previous patch), so you can wrap that.  But you
> still can't wrap its new home, gen_variants_objects().  Instead, you
> bracket its call of gen_object() with gen_if() ... gen_endif().  Works,
> but is there a more direct path to the same result?
>
> I append my attempt.  Its basic idea is to wrap code generation right
> where it is.  Requires passing ifcond to gen_object().  The patch to
> visit.py is identical.
>
> Less churn, and I it saves me reviewing the previous patch.  Opinions?


Looks good to me. I think the churn was necessary before, when we used
the function decorator. Now that we can scope the if/endif at the
block level, we don't need it anymore.

>
>
> From d6f26abe5a81b10aaff5c75db3bfc60c05203f05 Mon Sep 17 00:00:00 2001
> From: Markus Armbruster <armbru@redhat.com>
> Date: Thu, 21 Jun 2018 18:03:41 +0200
> Subject: [PATCH] qapi-types: add #if conditions to types & visitors
>
> Types & visitors are coupled and must be handled together to avoid
> temporary build regression.
>
> Wrap generated types/visitor code with #if/#endif using the context
> helpers.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I'll take it with my signed-off, since it shares a lot of similarities
with my patch.

thanks!

> ---
>  scripts/qapi/types.py | 48 ++++++++++++++++++++++++++-----------------
>  scripts/qapi/visit.py | 33 ++++++++++++++++-------------
>  2 files changed, 48 insertions(+), 33 deletions(-)
>
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index 298a80db62..e43138bfd7 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -55,7 +55,7 @@ def gen_struct_members(members):
>      return ret
>
>
> -def gen_object(name, base, members, variants):
> +def gen_object(name, ifcond, base, members, variants):
>      if name in objects_seen:
>          return ''
>      objects_seen.add(name)
> @@ -64,11 +64,14 @@ def gen_object(name, base, members, variants):
>      if variants:
>          for v in variants.variants:
>              if isinstance(v.type, QAPISchemaObjectType):
> -                ret +=3D gen_object(v.type.name, v.type.base,
> +                ret +=3D gen_object(v.type.name, v.type.ifcond, v.type.b=
ase,
>                                    v.type.local_members, v.type.variants)
>
>      ret +=3D mcgen('''
>
> +''')
> +    ret +=3D gen_if(ifcond)
> +    ret +=3D mcgen('''
>  struct %(c_name)s {
>  ''',
>                   c_name=3Dc_name(name))
> @@ -101,6 +104,7 @@ struct %(c_name)s {
>      ret +=3D mcgen('''
>  };
>  ''')
> +    ret +=3D gen_endif(ifcond)
>
>      return ret
>
> @@ -207,33 +211,39 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVi=
sitor):
>          self._genc.add(gen_type_cleanup(name))
>
>      def visit_enum_type(self, name, info, ifcond, values, prefix):
> -        self._genh.preamble_add(gen_enum(name, values, prefix))
> -        self._genc.add(gen_enum_lookup(name, values, prefix))
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            self._genh.preamble_add(gen_enum(name, values, prefix))
> +            self._genc.add(gen_enum_lookup(name, values, prefix))
>
>      def visit_array_type(self, name, info, ifcond, element_type):
> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
> -        self._genh.add(gen_array(name, element_type))
> -        self._gen_type_cleanup(name)
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            self._genh.preamble_add(gen_fwd_object_or_array(name))
> +            self._genh.add(gen_array(name, element_type))
> +            self._gen_type_cleanup(name)
>
>      def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
>              return
> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
> -        self._genh.add(gen_object(name, base, members, variants))
> -        if base and not base.is_implicit():
> -            self._genh.add(gen_upcast(name, base))
> -        # TODO Worth changing the visitor signature, so we could
> -        # directly use rather than repeat type.is_implicit()?
> -        if not name.startswith('q_'):
> -            # implicit types won't be directly allocated/freed
> -            self._gen_type_cleanup(name)
> +        with ifcontext(ifcond, self._genh):
> +            self._genh.preamble_add(gen_fwd_object_or_array(name))
> +        self._genh.add(gen_object(name, ifcond, base, members, variants)=
)
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            if base and not base.is_implicit():
> +                self._genh.add(gen_upcast(name, base))
> +            # TODO Worth changing the visitor signature, so we could
> +            # directly use rather than repeat type.is_implicit()?
> +            if not name.startswith('q_'):
> +                # implicit types won't be directly allocated/freed
> +                self._gen_type_cleanup(name)
>
>      def visit_alternate_type(self, name, info, ifcond, variants):
> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
> -        self._genh.add(gen_object(name, None,
> +        with ifcontext(ifcond, self._genh):
> +            self._genh.preamble_add(gen_fwd_object_or_array(name))
> +        self._genh.add(gen_object(name, ifcond, None,
>                                    [variants.tag_member], variants))
> -        self._gen_type_cleanup(name)
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            self._gen_type_cleanup(name)
>
>
>  def gen_types(schema, output_dir, prefix, opt_builtins):
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 9ea2e04f81..e4a62ce030 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -302,29 +302,34 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCV=
isitor):
>                                        types=3Dtypes))
>
>      def visit_enum_type(self, name, info, ifcond, values, prefix):
> -        self._genh.add(gen_visit_decl(name, scalar=3DTrue))
> -        self._genc.add(gen_visit_enum(name))
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            self._genh.add(gen_visit_decl(name, scalar=3DTrue))
> +            self._genc.add(gen_visit_enum(name))
>
>      def visit_array_type(self, name, info, ifcond, element_type):
> -        self._genh.add(gen_visit_decl(name))
> -        self._genc.add(gen_visit_list(name, element_type))
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            self._genh.add(gen_visit_decl(name))
> +            self._genc.add(gen_visit_list(name, element_type))
>
>      def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
>              return
> -        self._genh.add(gen_visit_members_decl(name))
> -        self._genc.add(gen_visit_object_members(name, base, members, var=
iants))
> -        # TODO Worth changing the visitor signature, so we could
> -        # directly use rather than repeat type.is_implicit()?
> -        if not name.startswith('q_'):
> -            # only explicit types need an allocating visit
> -            self._genh.add(gen_visit_decl(name))
> -            self._genc.add(gen_visit_object(name, base, members, variant=
s))
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            self._genh.add(gen_visit_members_decl(name))
> +            self._genc.add(gen_visit_object_members(name, base,
> +                                                    members, variants))
> +            # TODO Worth changing the visitor signature, so we could
> +            # directly use rather than repeat type.is_implicit()?
> +            if not name.startswith('q_'):
> +                # only explicit types need an allocating visit
> +                self._genh.add(gen_visit_decl(name))
> +                self._genc.add(gen_visit_object(name, base, members, var=
iants))
>
>      def visit_alternate_type(self, name, info, ifcond, variants):
> -        self._genh.add(gen_visit_decl(name))
> -        self._genc.add(gen_visit_alternate(name, variants))
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            self._genh.add(gen_visit_decl(name))
> +            self._genc.add(gen_visit_alternate(name, variants))
>
>
>  def gen_visit(schema, output_dir, prefix, opt_builtins):
> --
> 2.17.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
