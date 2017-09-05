Received: from eggs.gnu.org ([2001:4830:134:3::10]:47291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpGeE-0001qS-At
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpGe9-00035S-Ga
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:24:22 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dpGe9-000353-Ac
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:24:17 -0400
Received: by mail-oi0-x244.google.com with SMTP id d10so1271511oih.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 09:24:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgltp6j3.fsf@dusky.pond.sub.org>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-23-marcandre.lureau@redhat.com>
	<87lgltp6j3.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 5 Sep 2017 18:24:15 +0200
Message-ID: <CAJ+F1CKhM_ftM2g-swHcq2dq3LH6oeBQrJbsk13Mdbo119FeKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 22/54] qapi-introspect: add preprocessor
 conditions to generated QLit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Sep 5, 2017 at 4:24 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Add 'ifcond' condition to QLit objects.
>>
>> to_qlit() handles the (obj, ifcond) tuples.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi-introspect.py | 20 +++++++++++---------
>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
>> index 9ef6f271d4..5e736a06df 100644
>> --- a/scripts/qapi-introspect.py
>> +++ b/scripts/qapi-introspect.py
>> @@ -125,12 +125,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>>              return '[' + self._use_type(typ.element_type) + ']'
>>          return self._name(typ.name)
>>
>> -    def _gen_qlit(self, name, mtype, obj):
>> +    def _gen_qlit(self, name, mtype, obj, ifcond):
>>          if mtype not in ('command', 'event', 'builtin', 'array'):
>>              name =3D self._name(name)
>>          obj['name'] =3D name
>>          obj['meta-type'] =3D mtype
>> -        self._qlits.append(obj)
>> +        self._qlits.append((obj, ifcond))
>
> If I read this correctly, all elements of self._qlits become pairs, even
> the unconditional ones.  They all go through to_qlit()'s tuple case.
> Works, because gen_if(None) and gen_endif(None) do nothing.
>
> Would
>
>            if ifcond:
>                obj =3D (obj, ifcond)
>            self.qlits.append(obj)
>
> be clearer?  It could be a bit more efficient, but I doubt that matters.

I prefer the tuple case only version, but up to you if you want me to chang=
e it.

>
>>
>>      def _gen_member(self, member):
>>          ret =3D {'name': member.name, 'type': self._use_type(member.typ=
e)}
>> @@ -146,26 +146,27 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>>          return {'case': variant.name, 'type': self._use_type(variant.ty=
pe)}
>>
>>      def visit_builtin_type(self, name, info, json_type):
>> -        self._gen_qlit(name, 'builtin', {'json-type': json_type})
>> +        self._gen_qlit(name, 'builtin', {'json-type': json_type}, None)
>>
>>      def visit_enum_type(self, name, info, values, prefix, ifcond):
>> -        self._gen_qlit(name, 'enum', {'values': values})
>> +        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
>>
>>      def visit_array_type(self, name, info, element_type, ifcond):
>>          element =3D self._use_type(element_type)
>> -        self._gen_qlit('[' + element + ']', 'array', {'element-type': e=
lement})
>> +        self._gen_qlit('[' + element + ']', 'array', {'element-type': e=
lement},
>> +                       ifcond)
>>
>>      def visit_object_type_flat(self, name, info, members, variants, ifc=
ond):
>>          obj =3D {'members': [self._gen_member(m) for m in members]}
>>          if variants:
>>              obj.update(self._gen_variants(variants.tag_member.name,
>>                                            variants.variants))
>> -        self._gen_qlit(name, 'object', obj)
>> +        self._gen_qlit(name, 'object', obj, ifcond)
>>
>>      def visit_alternate_type(self, name, info, variants, ifcond):
>>          self._gen_qlit(name, 'alternate',
>>                         {'members': [{'type': self._use_type(m.type)}
>> -                                    for m in variants.variants]})
>> +                                    for m in variants.variants]}, ifcon=
d)
>>
>>      def visit_command(self, name, info, arg_type, ret_type,
>>                        gen, success_response, boxed, ifcond):
>> @@ -173,11 +174,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>>          ret_type =3D ret_type or self._schema.the_empty_object_type
>>          self._gen_qlit(name, 'command',
>>                         {'arg-type': self._use_type(arg_type),
>> -                        'ret-type': self._use_type(ret_type)})
>> +                        'ret-type': self._use_type(ret_type)}, ifcond)
>>
>>      def visit_event(self, name, info, arg_type, boxed, ifcond):
>>          arg_type =3D arg_type or self._schema.the_empty_object_type
>> -        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_t=
ype)})
>> +        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_t=
ype)},
>> +                       ifcond)
>>
>>  # Debugging aid: unmask QAPI schema's type names
>>  # We normally mask them, because they're not QMP wire ABI
>



--=20
Marc-Andr=C3=A9 Lureau
