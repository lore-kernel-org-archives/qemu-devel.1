Received: from eggs.gnu.org ([2001:4830:134:3::10]:48952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZwYk-0001lA-WA
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZwYg-0000Dv-KJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:27:38 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZwYg-0000Cl-AR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:27:34 -0500
Received: by mail-wr0-x244.google.com with SMTP id z48so4864660wrz.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 02:27:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180111213250.16511-13-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-13-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 11:27:32 +0100
Message-ID: <CAJ+F1CKa+hpr9wr5LNXfW9xAwXp2LuwBpd1gc3=rO6a4AmxwpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 12/51] qapi-introspect: add preprocessor
 conditions to generated QLit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi

On Thu, Jan 11, 2018 at 10:32 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The generator will take (obj, condition) tuples to wrap generated QLit
> objects for 'obj' with #if/#endif conditions.
>
> This commit adds 'ifcond' condition to top-level QLit objects.
>
> See generated tests/test-qmp-introspect.c. Example diff after this patch:
>
> --- before      2018-01-08 11:55:24.757083654 +0100
> +++ tests/test-qmp-introspect.c 2018-01-08 13:08:44.477641629 +0100
> @@ -51,6 +51,8 @@
>          { "name", QLIT_QSTR("EVENT_F"), },
>          {}
>      })),
> +#if defined(TEST_IF_CMD)
> +#if defined(TEST_IF_STRUCT)
>      QLIT_QDICT(((QLitDictEntry[]) {
>          { "arg-type", QLIT_QSTR("5"), },
>          { "meta-type", QLIT_QSTR("command"), },
> @@ -58,12 +60,16 @@
>          { "ret-type", QLIT_QSTR("0"), },
>          {}
>      })),
> +#endif /* defined(TEST_IF_STRUCT) */
> +#endif /* defined(TEST_IF_CMD) */
>

My bad, this comment causes git am (and patchew) to fail to apply. FIxed.

The series is also available on https://github.com/elmarco/qemu/commits/qap=
i-if

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi-introspect.py | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index b1d08ec97b..7d3a5c37fd 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -17,6 +17,15 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFa=
lse):
>      def indent(level):
>          return level * 4 * ' '
>
> +    if isinstance(obj, tuple):
> +        ifobj, ifcond =3D obj
> +        ret =3D gen_if(ifcond)
> +        ret +=3D to_qlit(ifobj, level)
> +        endif =3D gen_endif(ifcond)
> +        if endif:
> +            ret +=3D '\n' + endif
> +        return ret
> +
>      ret =3D ''
>      if not suppress_first_indent:
>          ret +=3D indent(level)
> @@ -25,7 +34,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
>      elif isinstance(obj, str):
>          ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
>      elif isinstance(obj, list):
> -        elts =3D [to_qlit(elt, level + 1)
> +        elts =3D [to_qlit(elt, level + 1).strip('\n')
>                  for elt in obj]
>          elts.append(indent(level + 1) + "{}")
>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
> @@ -121,12 +130,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>              return '[' + self._use_type(typ.element_type) + ']'
>          return self._name(typ.name)
>
> -    def _gen_qlit(self, name, mtype, obj):
> +    def _gen_qlit(self, name, mtype, obj, ifcond):
>          if mtype not in ('command', 'event', 'builtin', 'array'):
>              name =3D self._name(name)
>          obj['name'] =3D name
>          obj['meta-type'] =3D mtype
> -        self._qlits.append(obj)
> +        self._qlits.append((obj, ifcond))
>
>      def _gen_member(self, member):
>          ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
> @@ -142,26 +151,27 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
>
>      def visit_builtin_type(self, name, info, json_type):
> -        self._gen_qlit(name, 'builtin', {'json-type': json_type})
> +        self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
>
>      def visit_enum_type(self, name, info, ifcond, values, prefix):
> -        self._gen_qlit(name, 'enum', {'values': values})
> +        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
>
>      def visit_array_type(self, name, info, ifcond, element_type):
>          element =3D self._use_type(element_type)
> -        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
> +        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
> +                       ifcond)
>
>      def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts):
>          obj =3D {'members': [self._gen_member(m) for m in members]}
>          if variants:
>              obj.update(self._gen_variants(variants.tag_member.name,
>                                            variants.variants))
> -        self._gen_qlit(name, 'object', obj)
> +        self._gen_qlit(name, 'object', obj, ifcond)
>
>      def visit_alternate_type(self, name, info, ifcond, variants):
>          self._gen_qlit(name, 'alternate',
>                         {'members': [{'type': self._use_type(m.type)}
> -                                    for m in variants.variants]})
> +                                    for m in variants.variants]}, ifcond=
)
>
>      def visit_command(self, name, info, ifcond, arg_type, ret_type,
>                        gen, success_response, boxed):
> @@ -169,11 +179,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          ret_type =3D ret_type or self._schema.the_empty_object_type
>          self._gen_qlit(name, 'command',
>                         {'arg-type': self._use_type(arg_type),
> -                        'ret-type': self._use_type(ret_type)})
> +                        'ret-type': self._use_type(ret_type)}, ifcond)
>
>      def visit_event(self, name, info, ifcond, arg_type, boxed):
>          arg_type =3D arg_type or self._schema.the_empty_object_type
> -        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
> +        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
> +                       ifcond)
>
>  # Debugging aid: unmask QAPI schema's type names
>  # We normally mask them, because they're not QMP wire ABI
> --
> 2.16.0.rc1.1.gef27df75a1
>
>



--=20
Marc-Andr=C3=A9 Lureau
