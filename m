Received: from eggs.gnu.org ([2001:4830:134:3::10]:41564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faK7t-0004Dy-Kp
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faK7q-0001ZV-Dc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:09:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faK7q-0001ZM-7s
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:09:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
	<20180627163551.31610-10-marcandre.lureau@redhat.com>
Date: Tue, 03 Jul 2018 14:09:39 +0200
In-Reply-To: <20180627163551.31610-10-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 27 Jun 2018
	18:35:45 +0200")
Message-ID: <87efgkbjwc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 09/15] qapi-introspect: add preprocessor
 conditions to generated QLit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> The generator will take (obj, condition) tuples to wrap generated QLit
> objects for 'obj' with #if/#endif conditions.
>
> This commit adds 'ifcond' condition to top-level QLit objects.
>
> See generated tests/test-qmp-introspect.c. Example diff after this patch:
>
>     --- before	2018-01-08 11:55:24.757083654 +0100
>     +++ tests/test-qmp-introspect.c	2018-01-08 13:08:44.477641629 +0100
>     @@ -51,6 +51,8 @@
>              { "name", QLIT_QSTR("EVENT_F"), },
>              {}
>          })),
>     +#if defined(TEST_IF_CMD)
>     +#if defined(TEST_IF_STRUCT)
>          QLIT_QDICT(((QLitDictEntry[]) {
>              { "arg-type", QLIT_QSTR("5"), },
>              { "meta-type", QLIT_QSTR("command"), },
>     @@ -58,12 +60,16 @@
>              { "ret-type", QLIT_QSTR("0"), },
>              {}
>          })),
>     +#endif /* defined(TEST_IF_STRUCT) */
>     +#endif /* defined(TEST_IF_CMD) */
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/introspect.py | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index bd7e1219be..71d4a779ce 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -18,6 +18,15 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFa=
lse):
>      def indent(level):
>          return level * 4 * ' '
>=20=20
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

@obj represents a JSON object.  It consists of dictionaries, lists,
strings, booleans and None.  Numbers aren't implemented.  Your patch
splices in tuples to represent conditionals at any level.

So far, tuples occur only as elements of the outermost list (see
._gen_qlit() below), but to_qlit() supports them anywhere.  I figure
that will be needed later.  Can you point me to such a later use?

I'm asking because if there is one, the whole thing is a bit of a hack,
but at least it's a simple hack.  If not, then I'd like to look for a
solution that feels less hackish, possibly in a follow-up patch.

> @@ -26,7 +35,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
>      elif isinstance(obj, str):
>          ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
>      elif isinstance(obj, list):
> -        elts =3D [to_qlit(elt, level + 1)
> +        elts =3D [to_qlit(elt, level + 1).strip('\n')
>                  for elt in obj]
>          elts.append(indent(level + 1) + "{}")
>          ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'

The .strip('\n') looks odd.  Reminds me of the asymmetry I noted in
PATCH 08: you take care to adjust vertical space around #if there, but
not around #endif.  Let's not worry about it now.

> @@ -128,12 +137,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>              return '[' + self._use_type(typ.element_type) + ']'
>          return self._name(typ.name)
>=20=20
> -    def _gen_qlit(self, name, mtype, obj):
> +    def _gen_qlit(self, name, mtype, obj, ifcond):
>          if mtype not in ('command', 'event', 'builtin', 'array'):
>              name =3D self._name(name)
>          obj['name'] =3D name
>          obj['meta-type'] =3D mtype
> -        self._qlits.append(obj)
> +        self._qlits.append((obj, ifcond))

This is where we produce ._qlits.  It's also the only place where we
create tuples.  Thus, all elements of ._qlits are tuples, and no tuples
occur at deeper levels.

>=20=20
>      def _gen_member(self, member):
>          ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
> @@ -149,26 +158,27 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>          return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
>=20=20
>      def visit_builtin_type(self, name, info, json_type):
> -        self._gen_qlit(name, 'builtin', {'json-type': json_type})
> +        self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
>=20=20
>      def visit_enum_type(self, name, info, ifcond, values, prefix):
> -        self._gen_qlit(name, 'enum', {'values': values})
> +        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
>=20=20
>      def visit_array_type(self, name, info, ifcond, element_type):
>          element =3D self._use_type(element_type)
> -        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
> +        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
> +                       ifcond)
>=20=20
>      def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts):
>          obj =3D {'members': [self._gen_member(m) for m in members]}
>          if variants:
>              obj.update(self._gen_variants(variants.tag_member.name,
>                                            variants.variants))
> -        self._gen_qlit(name, 'object', obj)
> +        self._gen_qlit(name, 'object', obj, ifcond)
>=20=20
>      def visit_alternate_type(self, name, info, ifcond, variants):
>          self._gen_qlit(name, 'alternate',
>                         {'members': [{'type': self._use_type(m.type)}
> -                                    for m in variants.variants]})
> +                                    for m in variants.variants]}, ifcond)
>=20=20
>      def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
>                        success_response, boxed, allow_oob, allow_preconfi=
g):
> @@ -178,11 +188,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>                         {'arg-type': self._use_type(arg_type),
>                          'ret-type': self._use_type(ret_type),
>                          'allow-oob': allow_oob,
> -                        'allow-preconfig': allow_preconfig})
> +                        'allow-preconfig': allow_preconfig}, ifcond)
>=20=20
>      def visit_event(self, name, info, ifcond, arg_type, boxed):
>          arg_type =3D arg_type or self._schema.the_empty_object_type
> -        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
> +        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
> +                       ifcond)
>=20=20
>=20=20
>  def gen_introspect(schema, output_dir, prefix, opt_unmask):

I still prefer the approach I explored in

    [PATCH RFC 09/14] qapi: Pass ifcond to visitors
    [PATCH RFC 13/14] qapi-introspect: Add #if conditions to introspection =
value

because it separates the concerns.  I'd love to complete my exploration
so we can compare apples to apples, but I'm willing to take this to help
things move forward.

I'd like to get an answer to the question I asked in my first paragraph
before I give my R-by, though.
