Received: from eggs.gnu.org ([2001:4830:134:3::10]:49962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziPm-0005Xn-Es
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziPl-0000kM-7e
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:04:38 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:55092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dziPl-0000jz-0i
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:04:37 -0400
Received: by mail-oi0-x243.google.com with SMTP id u130so19151015oib.11
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 05:04:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-18-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-18-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 14:04:34 +0200
Message-ID: <CAJ+F1C+ZEw4P9VXD0+jioPEWtDWm-oQhRAmwoKamX-BmSZ4Ppg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 17/32] qapi: Fix simple union lowering
 with multiple schemas
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

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> If more than one schema uses the same built-in type T for a simple
> union member, they all generate the same q_obj_T_wrapper into their
> qapi-types.h.  They clash when you include more than one schema's
> qapi-types.h.
>
> Fix by generating them into builtin-qapi-types.h instead.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi-types.py                   | 12 ++++++++----
>  scripts/qapi.py                         |  2 ++
>  tests/qapi-schema/builtins.out          | 30 +++++++++++++++++++++++++++=
+++
>  tests/qapi-schema/qapi-schema-test.json |  3 +--
>  tests/qapi-schema/qapi-schema-test.out  |  5 ++---
>  5 files changed, 43 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index 18fd2a98c0..c058540e4d 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -53,7 +53,10 @@ def gen_struct_members(members):
>      return ret
>
>
> -def gen_object(name, base, members, variants):
> +def gen_object(name, info, base, members, variants):
> +    # TODO use something cleaner than existence of info
> +    if not info and args.schema:
> +        return ''               # suppress built-in
>      if name in objects_seen:
>          return ''
>      objects_seen.add(name)
> @@ -62,7 +65,7 @@ def gen_object(name, base, members, variants):
>      if variants:
>          for v in variants.variants:
>              if isinstance(v.type, QAPISchemaObjectType):
> -                ret +=3D gen_object(v.type.name, v.type.base,
> +                ret +=3D gen_object(v.type.name, v.type.info, v.type.bas=
e,
>                                    v.type.local_members, v.type.variants)
>
>      ret +=3D mcgen('''
> @@ -200,7 +203,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          if name =3D=3D 'q_empty':
>              return
>          self._fwdecl +=3D gen_fwd_object_or_array(name)
> -        self.decl +=3D gen_object(name, base, members, variants)
> +        self.decl +=3D gen_object(name, info, base, members, variants)
>          if base and not base.is_implicit():
>              self.decl +=3D gen_upcast(name, base)
>          # TODO Worth changing the visitor signature, so we could
> @@ -211,7 +214,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>
>      def visit_alternate_type(self, name, info, variants):
>          self._fwdecl +=3D gen_fwd_object_or_array(name)
> -        self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
> +        self.decl +=3D gen_object(name, info, None,
> +                                [variants.tag_member], variants)
>          self._gen_type_cleanup(name)
>
>  argparser =3D common_argument_parser(builtins=3DTrue)
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 4871eb7740..477402b7f8 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1499,6 +1499,8 @@ class QAPISchema(object):
>          # would be to use lazy instantiation, while figuring out how to
>          # avoid compilation issues with multiple qapi-types.h.
>          self._make_array_type(name, None)
> +        # TODO same for wrapper types
> +        self._make_implicit_wrapper_type(name, None)
>
>      def _def_predefineds(self):
>          for t in [('str',    'string',  'char' + pointer_suffix),
> diff --git a/tests/qapi-schema/builtins.out b/tests/qapi-schema/builtins.=
out
> index 40b886ddae..d289bfe919 100644
> --- a/tests/qapi-schema/builtins.out
> +++ b/tests/qapi-schema/builtins.out
> @@ -1,3 +1,33 @@
>  enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
>      prefix QTYPE
>  object q_empty
> +object q_obj_any-wrapper
> +    member data: any optional=3DFalse
> +object q_obj_bool-wrapper
> +    member data: bool optional=3DFalse
> +object q_obj_int-wrapper
> +    member data: int optional=3DFalse
> +object q_obj_int16-wrapper
> +    member data: int16 optional=3DFalse
> +object q_obj_int32-wrapper
> +    member data: int32 optional=3DFalse
> +object q_obj_int64-wrapper
> +    member data: int64 optional=3DFalse
> +object q_obj_int8-wrapper
> +    member data: int8 optional=3DFalse
> +object q_obj_null-wrapper
> +    member data: null optional=3DFalse
> +object q_obj_number-wrapper
> +    member data: number optional=3DFalse
> +object q_obj_size-wrapper
> +    member data: size optional=3DFalse
> +object q_obj_str-wrapper
> +    member data: str optional=3DFalse
> +object q_obj_uint16-wrapper
> +    member data: uint16 optional=3DFalse
> +object q_obj_uint32-wrapper
> +    member data: uint32 optional=3DFalse
> +object q_obj_uint64-wrapper
> +    member data: uint64 optional=3DFalse
> +object q_obj_uint8-wrapper
> +    member data: uint8 optional=3DFalse
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
> index c091626635..ac8aefc924 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -84,8 +84,7 @@
>
>  { 'union': 'UserDefSimpleUnion',
>    'data': { 'value1': 'UserDefA',
> -# FIXME generated q_obj_int_wrapper clashes with qapi-schema.json's
> -#           'value2': 'int',
> +            'value2': 'int',
>              'value3': 'UserDefB' } }
>
>  # this variant of UserDefFlatUnion defaults to a union that uses members=
 with
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
> index 97bb02f2fd..fff25e26d0 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -112,8 +112,9 @@ object UserDefSimpleUnion
>      member type: UserDefSimpleUnionKind optional=3DFalse
>      tag type
>      case value1: q_obj_UserDefA-wrapper
> +    case value2: q_obj_int-wrapper
>      case value3: q_obj_UserDefB-wrapper
> -enum UserDefSimpleUnionKind ['value1', 'value3']
> +enum UserDefSimpleUnionKind ['value1', 'value2', 'value3']
>  object UserDefTwo
>      member string0: str optional=3DFalse
>      member dict1: UserDefTwoDict optional=3DFalse
> @@ -211,8 +212,6 @@ object q_obj_numberList-wrapper
>      member data: numberList optional=3DFalse
>  object q_obj_sizeList-wrapper
>      member data: sizeList optional=3DFalse
> -object q_obj_str-wrapper
> -    member data: str optional=3DFalse
>  object q_obj_strList-wrapper
>      member data: strList optional=3DFalse
>  object q_obj_uint16List-wrapper
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
