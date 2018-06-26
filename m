Received: from eggs.gnu.org ([2001:4830:134:3::10]:60195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fXoCJ-0007fc-2Y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fXoCH-000140-Lo
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:39:55 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fXoCH-000117-BJ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:39:53 -0400
Received: by mail-wm0-x244.google.com with SMTP id z137-v6so1917502wmc.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 06:39:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87a7rrywk7.fsf@dusky.pond.sub.org>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-6-marcandre.lureau@redhat.com>
	<87a7rrywk7.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Jun 2018 15:39:51 +0200
Message-ID: <CAJ+F1CKb8vgToF_VKyu2ARVQZP-XfHBoMm_cMd9YJRaziHWQNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/49] qapi: leave the ifcond attribute
 undefined until check()
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

On Tue, Jun 19, 2018 at 11:06 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> We commonly initialize attributes to None in .init(), then set their
>> real value in .check().  Accessing the attribute before .check()
>> yields None.  If we're lucky, the code that accesses the attribute
>> prematurely chokes on None.
>>
>> It won't for .ifcond, because None is a legitimate value.
>>
>> Leave the ifcond attribute undefined until check().
>
> Drawback: pylint complains.  We'll live.
>
>>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Shouldn't this be squashed into the previous patch?

I would rather keep it seperate, as it makes reviewing both a bit
easier to me. But feel free to squash on commit.

>
>> ---
>>  scripts/qapi/common.py | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index d8ab3d8f7f..eb07d641ab 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -1026,13 +1026,19 @@ class QAPISchemaEntity(object):
>>          # such place).
>>          self.info =3D info
>>          self.doc =3D doc
>> -        self.ifcond =3D listify_cond(ifcond)
>> +        self._ifcond =3D ifcond  # self.ifcond is set only after .check=
()
>>
>>      def c_name(self):
>>          return c_name(self.name)
>>
>>      def check(self, schema):
>> -        pass
>> +        if isinstance(self._ifcond, QAPISchemaType):
>> +            # inherit the condition from a type
>> +            typ =3D self._ifcond
>> +            typ.check(schema)
>> +            self.ifcond =3D typ.ifcond
>> +        else:
>> +            self.ifcond =3D listify_cond(self._ifcond)
>
> Whenever we add a .check(), we need to prove QAPISchema.check()'s
> recursion still terminates, and terminates the right way.
>
> Argument before this patch: we recurse only into types contained in
> types, e.g. an object type's base type, and we detect and report cycles
> as "Object %s contains itself", in QAPISchemaObjectType.check().
>
> The .check() added here recurses into a type.  If this creates a cycle,
> it'll be caught and reported as "contains itself".  We still need to
> show that the error message remains accurate.
>
> We .check() here to inherit .ifcond from a type.  As far as I can tell,
> we use this inheritance feature only to inherit an array's condition
> from its element type.  That's safe, because an array does contain its
> elements.
>
> This is hardly a rigorous proof.  Just enough to make me believe your
> code works.
>
> However, I suspect adding the inheritance feature at the entity level
> complicates the correctness argument without real need.  Can we restrict
> it to array elements?  Have QAPISchemaArrayType.check() resolve
> type-valued ._ifcond, and all the others choke on it?

There is also implicit object types.

>
>>
>>      def is_implicit(self):
>>          return not self.info
>> @@ -1169,6 +1175,7 @@ class QAPISchemaEnumType(QAPISchemaType):
>>          self.prefix =3D prefix
>>
>>      def check(self, schema):
>> +        QAPISchemaType.check(self, schema)
>>          seen =3D {}
>>          for v in self.values:
>>              v.check_clash(self.info, seen)
>> @@ -1201,8 +1208,10 @@ class QAPISchemaArrayType(QAPISchemaType):
>>          self.element_type =3D None
>>
>>      def check(self, schema):
>> +        QAPISchemaType.check(self, schema)
>>          self.element_type =3D schema.lookup_type(self._element_type_nam=
e)
>>          assert self.element_type
>> +        self.element_type.check(schema)
>>          self.ifcond =3D self.element_type.ifcond
>>
>>      def is_implicit(self):
>> @@ -1245,6 +1254,7 @@ class QAPISchemaObjectType(QAPISchemaType):
>>          self.members =3D None
>>
>>      def check(self, schema):
>> +        QAPISchemaType.check(self, schema)
>>          if self.members is False:               # check for cycles
>>              raise QAPISemError(self.info,
>>                                 "Object %s contains itself" % self.name)
>> @@ -1427,6 +1437,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
>>          self.variants =3D variants
>>
>>      def check(self, schema):
>> +        QAPISchemaType.check(self, schema)
>>          self.variants.tag_member.check(schema)
>>          # Not calling self.variants.check_clash(), because there's noth=
ing
>>          # to clash with
>> @@ -1470,6 +1481,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
>>          self.allow_oob =3D allow_oob
>>
>>      def check(self, schema):
>> +        QAPISchemaEntity.check(self, schema)
>>          if self._arg_type_name:
>>              self.arg_type =3D schema.lookup_type(self._arg_type_name)
>>              assert (isinstance(self.arg_type, QAPISchemaObjectType) or
>> @@ -1504,6 +1516,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
>>          self.boxed =3D boxed
>>
>>      def check(self, schema):
>> +        QAPISchemaEntity.check(self, schema)
>>          if self._arg_type_name:
>>              self.arg_type =3D schema.lookup_type(self._arg_type_name)
>>              assert (isinstance(self.arg_type, QAPISchemaObjectType) or
>> @@ -1633,7 +1646,7 @@ class QAPISchema(object):
>>              # But it's not tight: the disjunction need not imply it.  W=
e
>>              # may end up compiling useless wrapper types.
>>              # TODO kill simple unions or implement the disjunction
>> -            assert ifcond =3D=3D typ.ifcond
>> +            assert ifcond =3D=3D typ._ifcond
>
> pylint complains
>
>     W:1649,29: Access to a protected member _ifcond of a client class (pr=
otected-access)
>
> Layering violation.  Tolerable, I think.
>

yeah, alternative would be to add an assert_ifcond() method in type..?
I'll add a # pylint: disable=3Dprotected-access for now

>>              self._def_entity(QAPISchemaObjectType(name, info, doc, ifco=
nd,
>>                                                    None, members, None))
>> @@ -1679,7 +1692,7 @@ class QAPISchema(object):
>>              assert len(typ) =3D=3D 1
>>              typ =3D self._make_array_type(typ[0], info)
>>          typ =3D self._make_implicit_object_type(
>> -            typ, info, None, self.lookup_type(typ).ifcond,
>> +            typ, info, None, self.lookup_type(typ),
>>              'wrapper', [self._make_member('data', typ, info)])
>>          return QAPISchemaObjectTypeVariant(case, typ)
>
> Perhaps other attributes that become valid only at .check() time should
> receive the same treatment.  Not necessarily in this series, not
> necessarily by you.  A TODO comment wouldn't hurt, though.
>

It doesn't look obvious to me which should receive the same
treatement. I'll leave that to you to figure out :)


--=20
Marc-Andr=C3=A9 Lureau
