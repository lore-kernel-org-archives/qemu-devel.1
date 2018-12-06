Received: from eggs.gnu.org ([2001:4830:134:3::10]:40253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUxgJ-0004hK-PK
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUxg7-0001ky-HS
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUxg5-0008No-EK
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:43:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD7163003BDB
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 17:42:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-22-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 18:42:25 +0100
In-Reply-To: <20180706105753.26700-22-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:47 +0200")
Message-ID: <87bm5y8sce.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 21/27] qapi: add #if conditions to
 generated code members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Wrap generated enum/struct members and code with #if/#endif, using the

enum and struct members

> .ifcond members added in the previous patches.
>
> Some types generate both enum and struct members for example, so a
> step-by-step is unnecessarily complicated to deal with (it would
> easily generate invalid intermediary code).

Can you give an example of a schema definition that would lead to
complications?

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py     |  4 ++++
>  scripts/qapi/introspect.py | 13 +++++++++----
>  scripts/qapi/types.py      |  4 ++++
>  scripts/qapi/visit.py      |  6 ++++++
>  4 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index b3b64a60bf..a66c035b91 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -2098,11 +2098,13 @@ const QEnumLookup %(c_name)s_lookup =3D {
>  ''',
>                  c_name=3Dc_name(name))
>      for m in members:
> +        ret +=3D gen_if(m.ifcond)
>          index =3D c_enum_const(name, m.name, prefix)
>          ret +=3D mcgen('''
>          [%(index)s] =3D "%(name)s",
>  ''',
>                       index=3Dindex, name=3Dm.name)
> +        ret +=3D gen_endif(m.ifcond)
>=20=20
>      ret +=3D mcgen('''
>      },
> @@ -2124,10 +2126,12 @@ typedef enum %(c_name)s {
>                  c_name=3Dc_name(name))
>=20=20
>      for m in enum_members:
> +        ret +=3D gen_if(m.ifcond)
>          ret +=3D mcgen('''
>      %(c_enum)s,
>  ''',
>                       c_enum=3Dc_enum_const(name, m.name, prefix))
> +        ret +=3D gen_endif(m.ifcond)
>=20=20
>      ret +=3D mcgen('''
>  } %(c_name)s;
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index 3f1ca99f6d..bf5db51f4a 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -148,6 +148,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
>          if member.optional:
>              ret['default'] =3D None
> +        if member.ifcond:
> +            ret =3D (ret, member.ifcond)
>          return ret
>=20=20
>      def _gen_variants(self, tag_name, variants):
> @@ -155,14 +157,16 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>                  'variants': [self._gen_variant(v) for v in variants]}
>=20=20
>      def _gen_variant(self, variant):
> -        return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
> +        return ({'case': variant.name, 'type': self._use_type(variant.ty=
pe)},
> +                variant.ifcond)

Looks different in your rebased version at
https://github.com/elmarco/qemu.git branch qapi-if.  I'm only skimming
this version.

Note to self: always creates the tuple form, even when there's no
if-condition.  Differs from _gen_qlit(), which creates a tuple only when
there's a if-condition.  Not wrong, just a bit inconsistent.

>=20=20
>      def visit_builtin_type(self, name, info, json_type):
>          self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
>=20=20
>      def visit_enum_type(self, name, info, ifcond, members, prefix):
>          self._gen_qlit(name, 'enum',
> -                       {'values': [m.name for m in members]}, ifcond)
> +                       {'values': [(m.name, m.ifcond) for m in members]},
> +                       ifcond)

Likewise.

>=20=20
>      def visit_array_type(self, name, info, ifcond, element_type):
>          element =3D self._use_type(element_type)
> @@ -178,8 +182,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>=20=20
>      def visit_alternate_type(self, name, info, ifcond, variants):
>          self._gen_qlit(name, 'alternate',
> -                       {'members': [{'type': self._use_type(m.type)}
> -                                    for m in variants.variants]}, ifcond)
> +                       {'members': [
> +                           ({'type': self._use_type(m.type)}, m.ifcond)
> +                           for m in variants.variants]}, ifcond)

Likewise.

>=20=20
>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
>                        success_response, boxed, allow_oob, allow_preconfi=
g):
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index 2d4a70f810..7d9eef6320 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -43,6 +43,7 @@ struct %(c_name)s {
>  def gen_struct_members(members):
>      ret =3D ''
>      for memb in members:
> +        ret +=3D gen_if(memb.ifcond)
>          if memb.optional:
>              ret +=3D mcgen('''
>      bool has_%(c_name)s;
> @@ -52,6 +53,7 @@ def gen_struct_members(members):
>      %(c_type)s %(c_name)s;
>  ''',
>                       c_type=3Dmemb.type.c_type(), c_name=3Dc_name(memb.n=
ame))
> +        ret +=3D gen_endif(memb.ifcond)
>      return ret
>=20=20
>=20=20
> @@ -131,11 +133,13 @@ def gen_variants(variants):
>      for var in variants.variants:
>          if var.type.name =3D=3D 'q_empty':
>              continue
> +        ret +=3D gen_if(var.ifcond)
>          ret +=3D mcgen('''
>          %(c_type)s %(c_name)s;
>  ''',
>                       c_type=3Dvar.type.c_unboxed_type(),
>                       c_name=3Dc_name(var.name))
> +        ret +=3D gen_endif(var.ifcond)
>=20=20
>      ret +=3D mcgen('''
>      } u;
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 24f85a2e85..82eab72b21 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -54,6 +54,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
>                       c_type=3Dbase.c_name())
>=20=20
>      for memb in members:
> +        ret +=3D gen_if(memb.ifcond)
>          if memb.optional:
>              ret +=3D mcgen('''
>      if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
> @@ -73,6 +74,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
>              ret +=3D mcgen('''
>      }
>  ''')
> +        ret +=3D gen_endif(memb.ifcond)
>=20=20
>      if variants:
>          ret +=3D mcgen('''
> @@ -84,6 +86,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
>              case_str =3D c_enum_const(variants.tag_member.type.name,
>                                      var.name,
>                                      variants.tag_member.type.prefix)
> +            ret +=3D gen_if(var.ifcond)
>              if var.type.name =3D=3D 'q_empty':
>                  # valid variant and nothing to do
>                  ret +=3D mcgen('''
> @@ -100,6 +103,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_na=
me)s *obj, Error **errp)
>                               case=3Dcase_str,
>                               c_type=3Dvar.type.c_name(), c_name=3Dc_name=
(var.name))
>=20=20
> +            ret +=3D gen_endif(var.ifcond)
>          ret +=3D mcgen('''
>      default:
>          abort();
> @@ -190,6 +194,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
>                  c_name=3Dc_name(name))
>=20=20
>      for var in variants.variants:
> +        ret +=3D gen_if(var.ifcond)
>          ret +=3D mcgen('''
>      case %(case)s:
>  ''',
> @@ -217,6 +222,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
>          ret +=3D mcgen('''
>          break;
>  ''')
> +        ret +=3D gen_endif(var.ifcond)
>=20=20
>      ret +=3D mcgen('''
>      case QTYPE_NONE:
