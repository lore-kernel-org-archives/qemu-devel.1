Received: from eggs.gnu.org ([2001:4830:134:3::10]:43873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkIX-0002ez-Rw
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkIW-0008Cp-Oy
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:22:05 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:43632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZkIW-0008CL-Ei
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:22:04 -0500
Received: by mail-wr0-x232.google.com with SMTP id s13so3519894wra.10
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:22:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87h8t2o7i3.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-16-marcandre.lureau@redhat.com>
	<87h8t2o7i3.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2018 22:22:02 +0100
Message-ID: <CAJ+F1CKvQv_eQ4YmCnHi-SMKHOD+FU50xwNNWmd9XEWzAdPA0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/50] qapi-types: refactor variants
 handling
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

Hi

On Thu, Dec 7, 2017 at 4:57 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Generate variants objects outside gen_object(). This will allow to
>> easily wrap gen_object() with ifcond_decorator in the following patch.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  scripts/qapi-types.py | 37 +++++++++++++++++++++++--------------
>>  1 file changed, 23 insertions(+), 14 deletions(-)
>>
>> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
>> index 915786c463..2b3588267b 100644
>> --- a/scripts/qapi-types.py
>> +++ b/scripts/qapi-types.py
>> @@ -53,23 +53,27 @@ def gen_struct_members(members):
>>      return ret
>>
>>
>> -def gen_object(name, base, members, variants):
>> -    if name in objects_seen:
>> -        return ''
>> -    objects_seen.add(name)
>> -
>> +def gen_variants_objects(variants):
>>      ret =3D ''
>>      if variants:
>>          for v in variants.variants:
>>              if isinstance(v.type, QAPISchemaObjectType):
>> +                ret +=3D gen_variants_objects(v.type.variants)
>>                  ret +=3D gen_object(v.type.name, v.type.base,
>>                                    v.type.local_members, v.type.variants=
)
>> +    return ret
>>
>> -    ret +=3D mcgen('''
>> +
>> +def gen_object(name, base, members, variants):
>> +    if name in objects_seen:
>> +        return ''
>> +    objects_seen.add(name)
>> +
>> +    ret =3D mcgen('''
>>
>>  struct %(c_name)s {
>>  ''',
>> -                 c_name=3Dc_name(name))
>> +                c_name=3Dc_name(name))
>>
>>      if base:
>>          if not base.is_implicit():
>> @@ -218,11 +222,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>>              self.decl +=3D gen_array(name, element_type)
>>              self._gen_type_cleanup(name)
>>
>> -    def visit_object_type(self, name, info, ifcond, base, members, vari=
ants):
>> -        # Nothing to do for the special empty builtin
>> -        if name =3D=3D 'q_empty':
>> -            return
>> -        self._fwdecl +=3D gen_fwd_object_or_array(name)
>> +    def _gen_object(self, name, info, ifcond, base, members, variants):
>>          self.decl +=3D gen_object(name, base, members, variants)
>>          if base and not base.is_implicit():
>>              self.decl +=3D gen_upcast(name, base)
>> @@ -232,10 +232,19 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>>              # implicit types won't be directly allocated/freed
>>              self._gen_type_cleanup(name)
>>
>> +    def visit_object_type(self, name, info, ifcond, base, members, vari=
ants):
>> +        # Nothing to do for the special empty builtin
>> +        if name =3D=3D 'q_empty':
>> +            return
>> +        self._fwdecl +=3D gen_fwd_object_or_array(name)
>> +        self.decl +=3D gen_variants_objects(variants)
>> +        self._gen_object(name, info, None, base, members, variants)
>> +
>>      def visit_alternate_type(self, name, info, ifcond, variants):
>>          self._fwdecl +=3D gen_fwd_object_or_array(name)
>> -        self.decl +=3D gen_object(name, None, [variants.tag_member], va=
riants)
>> -        self._gen_type_cleanup(name)
>> +        self.decl +=3D gen_variants_objects(variants)
>> +        self._gen_object(name, info, None, None,
>> +                         [variants.tag_member], variants)
>
> Where did self._gen_type_cleanup(name) go?  Hmm, I guess it's now in
> _gen_object().  Confusing.

This factors out common code that must be wrap by the same ifcond, in
the following patch.

>>
>>  # If you link code generated from multiple schemata, you want only one
>>  # instance of the code for built-in types.  Generate it only when
>
> If I read this patch correctly, you move code from the beginning of
> gen_object() to new gen_variants_objects(), then arrange to have
> gen_variants_objects() called right before gen_object().  Correct?
>
> In old gen_object(), the code is guarded by
>
>        if name in objects_seen:
>            return ''
>        objects_seen.add(name)
>
> In new gen_variants_objects(), it isn't.  Why?

gen_variants_objects() calls gen_object() for each variants, so it
remains guarded.



--=20
Marc-Andr=C3=A9 Lureau
