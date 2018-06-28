Received: from eggs.gnu.org ([2001:4830:134:3::10]:41400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYQPM-0004Tn-52
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 02:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYQPI-00021v-QI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 02:27:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYQPI-000213-K6
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 02:27:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-15-marcandre.lureau@redhat.com>
	<874lhwktjc.fsf@dusky.pond.sub.org>
	<CAJ+F1CJsd+PgLYd+rHRsZbtyBJP1cgnc45SzbyFqGOgKKOs3Jg@mail.gmail.com>
Date: Thu, 28 Jun 2018 08:27:49 +0200
In-Reply-To: <CAJ+F1CJsd+PgLYd+rHRsZbtyBJP1cgnc45SzbyFqGOgKKOs3Jg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 27 Jun 2018
	13:59:48 +0200")
Message-ID: <87lgaz5st6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Jun 21, 2018 at 6:12 PM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>> Types & visitors are coupled and must be handled together to avoid
>>> temporary build regression.
>>>
>>> Wrap generated types/visitor code with #if/#endif using the context
>>> helpers.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  scripts/qapi/types.py | 46 ++++++++++++++++++++++++++-----------------
>>>  scripts/qapi/visit.py | 33 ++++++++++++++++++-------------
>>>  2 files changed, 47 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
>>> index 3d9b0f9a07..ce4c91206c 100644
>>> --- a/scripts/qapi/types.py
>>> +++ b/scripts/qapi/types.py
>>> @@ -61,8 +61,10 @@ def gen_variants_objects(variants):
>>>          for v in variants.variants:
>>>              if isinstance(v.type, QAPISchemaObjectType):
>>>                  ret +=3D gen_variants_objects(v.type.variants)
>>> +                ret +=3D gen_if(v.type.ifcond)
>>>                  ret +=3D gen_object(v.type.name, v.type.base,
>>>                                    v.type.local_members, v.type.variant=
s)
>>> +                ret +=3D gen_endif(v.type.ifcond)
>>
>> Ignorant question out of curiosity, why is with ifcontext() not usable
>> here?
>>
>
> ifcontext() works on QAPIGen objects. We could make it work on strings
> too, but I don't think it's necessary.

I see.

>>>      return ret
>>>
>>>
>>> @@ -206,41 +208,49 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularC=
Visitor):
>>>          # gen_object() is recursive, ensure it doesn't visit the empty=
 type
>>>          objects_seen.add(schema.the_empty_object_type.name)
>>>
>>> -    def _gen_type_cleanup(self, name):
>>> -        self._genh.add(gen_type_cleanup_decl(name))
>>> -        self._genc.add(gen_type_cleanup(name))
>>> +    def _gen_type_cleanup(self, name, ifcond):
>>> +        with ifcontext(ifcond, self._genh, self._genc):
>>> +            self._genh.add(gen_type_cleanup_decl(name))
>>> +            self._genc.add(gen_type_cleanup(name))
>>>
>>>      def visit_enum_type(self, name, info, ifcond, values, prefix):
>>> -        self._genh.preamble_add(gen_enum(name, values, prefix))
>>> -        self._genc.add(gen_enum_lookup(name, values, prefix))
>>> +        with ifcontext(ifcond, self._genh, self._genc):
>>> +            self._genh.preamble_add(gen_enum(name, values, prefix))
>>> +            self._genc.add(gen_enum_lookup(name, values, prefix))
>>>
>>>      def visit_array_type(self, name, info, ifcond, element_type):
>>> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
>>> -        self._genh.add(gen_array(name, element_type))
>>> -        self._gen_type_cleanup(name)
>>> +        with ifcontext(ifcond, self._genh):
>>> +            self._genh.preamble_add(gen_fwd_object_or_array(name))
>>> +            self._genh.add(gen_array(name, element_type))
>>> +        self._gen_type_cleanup(name, ifcond)
>>>
>>>      def _gen_object(self, name, info, ifcond, base, members, variants):
>>> -        self._genh.add(gen_object(name, base, members, variants))
>>> -        if base and not base.is_implicit():
>>> -            self._genh.add(gen_upcast(name, base))
>>> -        # TODO Worth changing the visitor signature, so we could
>>> -        # directly use rather than repeat type.is_implicit()?
>>> +        with ifcontext(ifcond, self._genh):
>>> +            self._genh.add(gen_object(name, base, members, variants))
>>> +            if base and not base.is_implicit():
>>> +                self._genh.add(gen_upcast(name, base))
>>> +            # TODO Worth changing the visitor signature, so we could
>>> +            # directly use rather than repeat type.is_implicit()?
>>>          if not name.startswith('q_'):
>>>              # implicit types won't be directly allocated/freed
>>> -            self._gen_type_cleanup(name)
>>> +            self._gen_type_cleanup(name, ifcond)
>>> +
>>> +    def _gen_fwd_object_or_array(self, name, ifcond):
>>> +        with ifcontext(ifcond, self._genh):
>>> +            self._genh.preamble_add(gen_fwd_object_or_array(name))
>>>
>>>      def visit_object_type(self, name, info, ifcond, base, members, var=
iants):
>>>          # Nothing to do for the special empty builtin
>>>          if name =3D=3D 'q_empty':
>>>              return
>>> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
>>> +        self._gen_fwd_object_or_array(name, ifcond)
>>>          self._genh.add(gen_variants_objects(variants))
>>> -        self._gen_object(name, info, None, base, members, variants)
>>> +        self._gen_object(name, info, ifcond, base, members, variants)
>>>
>>>      def visit_alternate_type(self, name, info, ifcond, variants):
>>> -        self._genh.preamble_add(gen_fwd_object_or_array(name))
>>> +        self._gen_fwd_object_or_array(name, ifcond)
>>>          self._genh.add(gen_variants_objects(variants))
>>> -        self._gen_object(name, info, None, None,
>>> +        self._gen_object(name, info, ifcond, None,
>>>                           [variants.tag_member], variants)
>>>
>>>
>>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>>> index 9ea2e04f81..e4a62ce030 100644
>>> --- a/scripts/qapi/visit.py
>>> +++ b/scripts/qapi/visit.py
>>> @@ -302,29 +302,34 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModular=
CVisitor):
>>>                                        types=3Dtypes))
>>>
>>>      def visit_enum_type(self, name, info, ifcond, values, prefix):
>>> -        self._genh.add(gen_visit_decl(name, scalar=3DTrue))
>>> -        self._genc.add(gen_visit_enum(name))
>>> +        with ifcontext(ifcond, self._genh, self._genc):
>>> +            self._genh.add(gen_visit_decl(name, scalar=3DTrue))
>>> +            self._genc.add(gen_visit_enum(name))
>>>
>>>      def visit_array_type(self, name, info, ifcond, element_type):
>>> -        self._genh.add(gen_visit_decl(name))
>>> -        self._genc.add(gen_visit_list(name, element_type))
>>> +        with ifcontext(ifcond, self._genh, self._genc):
>>> +            self._genh.add(gen_visit_decl(name))
>>> +            self._genc.add(gen_visit_list(name, element_type))
>>>
>>>      def visit_object_type(self, name, info, ifcond, base, members, var=
iants):
>>>          # Nothing to do for the special empty builtin
>>>          if name =3D=3D 'q_empty':
>>>              return
>>> -        self._genh.add(gen_visit_members_decl(name))
>>> -        self._genc.add(gen_visit_object_members(name, base, members, v=
ariants))
>>> -        # TODO Worth changing the visitor signature, so we could
>>> -        # directly use rather than repeat type.is_implicit()?
>>> -        if not name.startswith('q_'):
>>> -            # only explicit types need an allocating visit
>>> -            self._genh.add(gen_visit_decl(name))
>>> -            self._genc.add(gen_visit_object(name, base, members, varia=
nts))
>>> +        with ifcontext(ifcond, self._genh, self._genc):
>>> +            self._genh.add(gen_visit_members_decl(name))
>>> +            self._genc.add(gen_visit_object_members(name, base,
>>> +                                                    members, variants))
>>> +            # TODO Worth changing the visitor signature, so we could
>>> +            # directly use rather than repeat type.is_implicit()?
>>> +            if not name.startswith('q_'):
>>> +                # only explicit types need an allocating visit
>>> +                self._genh.add(gen_visit_decl(name))
>>> +                self._genc.add(gen_visit_object(name, base, members, v=
ariants))
>>>
>>>      def visit_alternate_type(self, name, info, ifcond, variants):
>>> -        self._genh.add(gen_visit_decl(name))
>>> -        self._genc.add(gen_visit_alternate(name, variants))
>>> +        with ifcontext(ifcond, self._genh, self._genc):
>>> +            self._genh.add(gen_visit_decl(name))
>>> +            self._genc.add(gen_visit_alternate(name, variants))
>>>
>>>
>>>  def gen_visit(schema, output_dir, prefix, opt_builtins):
>>
>> The visit part is straightforward: wrap code generation in with
>> ifcontext().
>>
>> The type part is more involved.  First, it passes ifcond to a bunch of
>> helpers, which muddies the waters a bit.  Second, you can't just wrap
>> object types generation, because it's recursive.  You move the recursion
>> out of gen_object() (previous patch), so you can wrap that.  But you
>> still can't wrap its new home, gen_variants_objects().  Instead, you
>> bracket its call of gen_object() with gen_if() ... gen_endif().  Works,
>> but is there a more direct path to the same result?
>>
>> I append my attempt.  Its basic idea is to wrap code generation right
>> where it is.  Requires passing ifcond to gen_object().  The patch to
>> visit.py is identical.
>>
>> Less churn, and I it saves me reviewing the previous patch.  Opinions?
>
>
> Looks good to me. I think the churn was necessary before, when we used
> the function decorator. Now that we can scope the if/endif at the
> block level, we don't need it anymore.

Makes sense.

>> From d6f26abe5a81b10aaff5c75db3bfc60c05203f05 Mon Sep 17 00:00:00 2001
>> From: Markus Armbruster <armbru@redhat.com>
>> Date: Thu, 21 Jun 2018 18:03:41 +0200
>> Subject: [PATCH] qapi-types: add #if conditions to types & visitors
>>
>> Types & visitors are coupled and must be handled together to avoid
>> temporary build regression.
>>
>> Wrap generated types/visitor code with #if/#endif using the context
>> helpers.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> I'll take it with my signed-off, since it shares a lot of similarities
> with my patch.

Of course.  git-commit -avs comes from muscle memory :)
