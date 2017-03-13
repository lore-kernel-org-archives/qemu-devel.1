Received: from eggs.gnu.org ([2001:4830:134:3::10]:60929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJzR-0005CZ-SL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJzN-0006mn-UB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:01:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-2-marcandre.lureau@redhat.com>
Date: Mon, 13 Mar 2017 08:01:50 +0100
In-Reply-To: <20170311132256.22951-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 11 Mar 2017 17:22:36 +0400")
Message-ID: <87o9x5k6ch.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/21] qapi: add info comment for generated
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mdroth@linux.vnet.ibm.com, anderson@redhat.com, pbonzini@redhat.com, lersek@redhat.com

Re qemu-trivial: since I got another lengthy series touching
scripts/qapi* in the pipeline, I'd prefer to handle the conflicts in my
tree.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> This may help to find where the origin of the type was declared in the
> json (when greping isn't easy enough).

An example for the generated comment would be nice here.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: qemu-trivial@nongnu.org
> ---
>  scripts/qapi.py       | 11 +++++++++--
>  scripts/qapi-event.py |  4 +++-
>  scripts/qapi-types.py | 17 +++++++++--------
>  3 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 53a44779d0..9504ebd8c7 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1874,15 +1874,22 @@ const char *const %(c_name)s_lookup[] =3D {
>      return ret
>=20=20
>=20=20
> -def gen_enum(name, values, prefix=3DNone):
> +def gen_info_comment(info):

Well, aren't all comments "info comments"?  What distinguishes this one
is that it's about the location of the source.  Suggest to rename to
gen_loc_comment() or maybe gen_src_loc_comment().

Hmm, the gen_ prefix is awkward.  Generated C should go through cgen()
exactly once (see commit 1f9a7a1).  The common way to get this wrong is
passing a foo=3Dgen_foo() keyword argument to mcgen().  I'd like us to
adopt a naming convention where gen_ means "something that's been piped
through cgen(), and thus must not be passed to cgen() or mcgen()".
Requires renaming gen_params(), gen_marshal_proto() and
gen_event_send_proto().

> +    if info:
> +        return "/* %s:%d */" % (info['file'], info['line'])
> +    else:
> +        return ""

Please stick to the prevalent use of single vs. double quotes: use
single quotes unless double quotes let you avoid backslashes, except
always use double quotes for error messages.  See "[PATCH for-2.9 19/47]
qapi: Prefer single-quoted strings more consistently".

> +
> +def gen_enum(info, name, values, prefix=3DNone):
>      # append automatically generated _MAX value
>      enum_values =3D values + ['_MAX']
>=20=20
>      ret =3D mcgen('''
>=20=20
> +%(info)s
>  typedef enum %(c_name)s {
>  ''',
> -                c_name=3Dc_name(name))
> +                c_name=3Dc_name(name), info=3Dgen_info_comment(info))

Your chance to use identifier infocom ;-P

Seriously, I'd prefer comment to info.

>=20=20
>      i =3D 0
>      for value in enum_values:
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index f4eb7f85b1..ca90d6a5df 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -152,6 +152,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self.decl =3D None
>          self.defn =3D None
>          self._event_names =3D None
> +        self.info =3D None
>=20=20
>      def visit_begin(self, schema):
>          self.decl =3D ''
> @@ -159,7 +160,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self._event_names =3D []
>=20=20
>      def visit_end(self):
> -        self.decl +=3D gen_enum(event_enum_name, self._event_names)
> +        self.decl +=3D gen_enum(self.info, event_enum_name, self._event_=
names)
>          self.defn +=3D gen_enum_lookup(event_enum_name, self._event_name=
s)
>          self._event_names =3D None
>=20=20
> @@ -167,6 +168,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
>          self.defn +=3D gen_event_send(name, arg_type, boxed)
>          self._event_names.append(name)
> +        self.info =3D info
>=20=20
>=20=20

I'm afraid this doesn't make sense.

You set self.info in each visit_event(), then use it in visit_end().
visit_end() thus sees the info of whatever event was visited last.
Won't produce a sane location comment.  None of the others would,
either.  That's because the enumeration is defined implicitly by all the
events together.

Let's pass info=3DNone for this enum.

>  (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index dabc42e047..896749bf61 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -19,12 +19,13 @@ from qapi import *
>  objects_seen =3D set()
>=20=20
>=20=20
> -def gen_fwd_object_or_array(name):
> +def gen_fwd_object_or_array(info, name):
>      return mcgen('''
>=20=20
> +%(info)s
>  typedef struct %(c_name)s %(c_name)s;

If info=3DNone, gen_info_comment(info) is '', and we get an unwanted blank
line.

>  ''',
> -                 c_name=3Dc_name(name))
> +                 c_name=3Dc_name(name), info=3Dgen_info_comment(info))
>=20=20
>=20=20
>  def gen_array(name, element_type):
> @@ -199,22 +200,22 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          # Special case for our lone builtin enum type
>          # TODO use something cleaner than existence of info
>          if not info:
> -            self._btin +=3D gen_enum(name, values, prefix)
> +            self._btin +=3D gen_enum(info, name, values, prefix)

gen_enum(None, ...) feels slightly clearer to me.

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
> +            self._btin +=3D gen_fwd_object_or_array(info, name)
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

Note that @info points to an arbitrarily chosen user of the array type,
*not* to the definition of the element type.  The resulting source
location comment feels useless to me.  Suggest to pass None for arrays.

> @@ -222,7 +223,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
>              return
> -        self._fwdecl +=3D gen_fwd_object_or_array(name)
> +        self._fwdecl +=3D gen_fwd_object_or_array(info, name)
>          self.decl +=3D gen_object(name, base, members, variants)
>          if base and not base.is_implicit():
>              self.decl +=3D gen_upcast(name, base)
> @@ -233,7 +234,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>              self._gen_type_cleanup(name)
>=20=20
>      def visit_alternate_type(self, name, info, variants):
> -        self._fwdecl +=3D gen_fwd_object_or_array(name)
> +        self._fwdecl +=3D gen_fwd_object_or_array(info, name)
>          self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
>          self._gen_type_cleanup(name)
