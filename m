Received: from eggs.gnu.org ([2001:4830:134:3::10]:38505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT2Na-0001TA-Rl
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT2NW-0003qj-3j
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:43:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT2NV-0003q1-RP
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:43:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170601124143.10915-1-marcandre.lureau@redhat.com>
	<20170601124143.10915-2-marcandre.lureau@redhat.com>
Date: Thu, 06 Jul 2017 10:43:08 +0200
In-Reply-To: <20170601124143.10915-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 1 Jun 2017 16:41:42 +0400")
Message-ID: <874luq6jmr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: add location comment for
 generated types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> This may help to find where the origin of the type was declared in the
> json (when greping isn't easy enough).
>
> Generates the following kind of C comment before types:
>
>   /* /home/elmarco/src/qemu/qapi/introspect.json:94 */
>   typedef struct SchemaInfo SchemaInfo;

Can we do relative file names?  I.e. just qapi/introspect.json.

Would such comments be useful for things other than typedefs?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py       | 12 +++++++++---
>  scripts/qapi-event.py |  2 +-
>  scripts/qapi-types.py | 18 +++++++++---------
>  3 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index d37a6157e0..7f9935eec0 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1852,15 +1852,21 @@ const char *const %(c_name)s_lookup[] =3D {
>      return ret
>=20=20
>=20=20
> -def gen_enum(name, values, prefix=3DNone):
> +def build_src_loc_comment(info):
> +    if info:
> +        return '\n/* %s:%d */' % (info['file'], info['line'])

Leading instead of trailing newline, hmm.  Let's see how it works out.

> +    else:
> +        return ''

Let's drop the else: line.

> +
> +def gen_enum(info, name, values, prefix=3DNone):

Make that name, info, values, ... for consistency with other functions
taking both name and info.  More of the same below.

>      # append automatically generated _MAX value
>      enum_values =3D values + ['_MAX']
>=20=20
>      ret =3D mcgen('''
> -
> +%(comment)s

Loses the blank line when not info.

>  typedef enum %(c_name)s {
>  ''',
> -                c_name=3Dc_name(name))
> +                c_name=3Dc_name(name), comment=3Dbuild_src_loc_comment(i=
nfo))
>=20=20
>      i =3D 0
>      for value in enum_values:
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index bcbef1035f..cf5e282011 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -159,7 +159,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self._event_names =3D []
>=20=20
>      def visit_end(self):
> -        self.decl +=3D gen_enum(event_enum_name, self._event_names)
> +        self.decl +=3D gen_enum(None, event_enum_name, self._event_names)
>          self.defn +=3D gen_enum_lookup(event_enum_name, self._event_name=
s)
>          self._event_names =3D None
>=20=20
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index b45e7b5634..9c8a3e277b 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -19,12 +19,12 @@ from qapi import *
>  objects_seen =3D set()
>=20=20
>=20=20
> -def gen_fwd_object_or_array(name):
> +def gen_fwd_object_or_array(info, name):
>      return mcgen('''
> -
> +%(comment)s

Likewise.

I think we should drop the newline from build_src_loc_comment()'s value,
and keep the blank line before its two uses.

>  typedef struct %(c_name)s %(c_name)s;
>  ''',
> -                 c_name=3Dc_name(name))
> +                 c_name=3Dc_name(name), comment=3Dbuild_src_loc_comment(=
info))
>=20=20
>=20=20
>  def gen_array(name, element_type):
> @@ -199,22 +199,22 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          # Special case for our lone builtin enum type
>          # TODO use something cleaner than existence of info
>          if not info:
> -            self._btin +=3D gen_enum(name, values, prefix)
> +            self._btin +=3D gen_enum(None, name, values, prefix)
>              if do_builtins:
>                  self.defn +=3D gen_enum_lookup(name, values, prefix)
>          else:
> -            self._fwdecl +=3D gen_enum(name, values, prefix)
> +            self._fwdecl +=3D gen_enum(info, name, values, prefix)
>              self.defn +=3D gen_enum_lookup(name, values, prefix)
>=20=20
>      def visit_array_type(self, name, info, element_type):
>          if isinstance(element_type, QAPISchemaBuiltinType):
> -            self._btin +=3D gen_fwd_object_or_array(name)
> +            self._btin +=3D gen_fwd_object_or_array(None, name)
>              self._btin +=3D gen_array(name, element_type)
>              self._btin +=3D gen_type_cleanup_decl(name)
>              if do_builtins:
>                  self.defn +=3D gen_type_cleanup(name)
>          else:
> -            self._fwdecl +=3D gen_fwd_object_or_array(name)
> +            self._fwdecl +=3D gen_fwd_object_or_array(info, name)
>              self.decl +=3D gen_array(name, element_type)
>              self._gen_type_cleanup(name)
>=20=20
> @@ -222,7 +222,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
>              return
> -        self._fwdecl +=3D gen_fwd_object_or_array(name)
> +        self._fwdecl +=3D gen_fwd_object_or_array(info, name)
>          self.decl +=3D gen_object(name, base, members, variants)
>          if base and not base.is_implicit():
>              self.decl +=3D gen_upcast(name, base)
> @@ -233,7 +233,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>              self._gen_type_cleanup(name)
>=20=20
>      def visit_alternate_type(self, name, info, variants):
> -        self._fwdecl +=3D gen_fwd_object_or_array(name)
> +        self._fwdecl +=3D gen_fwd_object_or_array(info, name)
>          self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
>          self._gen_type_cleanup(name)

No comment gets generated before built-in types such as QType and
anyList.  That's okay, but perhaps the commit message could be a bit
more precise.
