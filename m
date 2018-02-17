Received: from eggs.gnu.org ([2001:4830:134:3::10]:34499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHi-0002Ts-1S
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHe-0003fy-3m
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHd-0003fA-Pp
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:30 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJd9SH091406
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:28 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g80gr3y0g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:28 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:27 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-7-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-7-armbru@redhat.com>
Date: Fri, 16 Feb 2018 19:22:54 -0600
Message-Id: <151883057485.12376.11145524795406752141@sif>
Subject: Re: [Qemu-devel] [PATCH v2 06/29] qapi: Reduce use of global
 variables in generators some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:35:44)
> In preparation of the next commit, which will turn the generators into
> modules.  These global variables will become local to main() then.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  scripts/qapi-commands.py   |  9 +++++----
>  scripts/qapi-event.py      | 15 +++++++--------
>  scripts/qapi-introspect.py |  7 ++++---
>  scripts/qapi-types.py      | 17 +++++++++--------
>  scripts/qapi-visit.py      | 17 +++++++++--------
>  5 files changed, 34 insertions(+), 31 deletions(-)
> =

> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index 8d38ade076..e97e16e828 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -207,7 +207,7 @@ def gen_register_command(name, success_response):
>      return ret
> =

> =

> -def gen_registry(registry):
> +def gen_registry(registry, prefix):
>      ret =3D mcgen('''
> =

>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
> @@ -224,7 +224,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s)
> =

> =

>  class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
> -    def __init__(self):
> +    def __init__(self, prefix):
> +        self._prefix =3D prefix
>          self.decl =3D None
>          self.defn =3D None
>          self._regy =3D None
> @@ -237,7 +238,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self._visited_ret_types =3D set()
> =

>      def visit_end(self):
> -        self.defn +=3D gen_registry(self._regy)
> +        self.defn +=3D gen_registry(self._regy, self._prefix)
>          self._regy =3D None
>          self._visited_ret_types =3D None
> =

> @@ -289,7 +290,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
>                 prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DFals=
e)))
> =

>  schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenCommandVisitor()
> +vis =3D QAPISchemaGenCommandVisitor(prefix)
>  schema.visit(vis)
>  genc.add(vis.defn)
>  genh.add(vis.decl)
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index bd7a9be3dc..3f98e2491a 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -58,7 +58,7 @@ def gen_param_var(typ):
>      return ret
> =

> =

> -def gen_event_send(name, arg_type, boxed):
> +def gen_event_send(name, arg_type, boxed, event_enum_name):
>      # FIXME: Our declaration of local variables (and of 'errp' in the
>      # parameter list) can collide with exploded members of the event's
>      # data type passed in as parameters.  If this collision ever hits in
> @@ -149,7 +149,8 @@ out:
> =

> =

>  class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
> -    def __init__(self):
> +    def __init__(self, prefix):
> +        self._enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
>          self.decl =3D None
>          self.defn =3D None
>          self._event_names =3D None
> @@ -160,13 +161,13 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self._event_names =3D []
> =

>      def visit_end(self):
> -        self.decl +=3D gen_enum(event_enum_name, self._event_names)
> -        self.defn +=3D gen_enum_lookup(event_enum_name, self._event_name=
s)
> +        self.decl +=3D gen_enum(self._enum_name, self._event_names)
> +        self.defn +=3D gen_enum_lookup(self._enum_name, self._event_name=
s)
>          self._event_names =3D None
> =

>      def visit_event(self, name, info, arg_type, boxed):
>          self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
> -        self.defn +=3D gen_event_send(name, arg_type, boxed)
> +        self.defn +=3D gen_event_send(name, arg_type, boxed, self._enum_=
name)
>          self._event_names.append(name)
> =

> =

> @@ -199,10 +200,8 @@ genh.add(mcgen('''
>  ''',
>                 prefix=3Dprefix))
> =

> -event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
> -
>  schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenEventVisitor()
> +vis =3D QAPISchemaGenEventVisitor(prefix)
>  schema.visit(vis)
>  genc.add(vis.defn)
>  genh.add(vis.decl)
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 3d65690fe3..2418b80a82 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -41,7 +41,8 @@ def to_c_string(string):
> =

> =

>  class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
> -    def __init__(self, unmask):
> +    def __init__(self, prefix, unmask):
> +        self._prefix =3D prefix
>          self._unmask =3D unmask
>          self.defn =3D None
>          self.decl =3D None
> @@ -65,7 +66,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor):
>          # generate C
>          # TODO can generate awfully long lines
>          jsons.extend(self._jsons)
> -        name =3D c_name(prefix, protect=3DFalse) + 'qmp_schema_json'
> +        name =3D c_name(self._prefix, protect=3DFalse) + 'qmp_schema_jso=
n'
>          self.decl =3D mcgen('''
>  extern const char %(c_name)s[];
>  ''',
> @@ -192,7 +193,7 @@ genc.add(mcgen('''
>                 prefix=3Dprefix))
> =

>  schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
> +vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
>  schema.visit(vis)
>  genc.add(vis.defn)
>  genh.add(vis.decl)
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index c0ac879beb..5ff2bfcf41 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -168,7 +168,8 @@ void qapi_free_%(c_name)s(%(c_name)s *obj)
> =

> =

>  class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
> -    def __init__(self):
> +    def __init__(self, opt_builtins):
> +        self._opt_builtins =3D opt_builtins
>          self.decl =3D None
>          self.defn =3D None
>          self._fwdecl =3D None
> @@ -187,7 +188,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          self._fwdecl =3D None
>          # To avoid header dependency hell, we always generate
>          # declarations for built-in types in our header files and
> -        # simply guard them.  See also do_builtins (command line
> +        # simply guard them.  See also opt_builtins (command line
>          # option -b).
>          self._btin +=3D guardend('QAPI_TYPES_BUILTIN')
>          self.decl =3D self._btin + self.decl
> @@ -202,7 +203,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          # TODO use something cleaner than existence of info
>          if not info:
>              self._btin +=3D gen_enum(name, values, prefix)
> -            if do_builtins:
> +            if self._opt_builtins:
>                  self.defn +=3D gen_enum_lookup(name, values, prefix)
>          else:
>              self._fwdecl +=3D gen_enum(name, values, prefix)
> @@ -213,7 +214,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>              self._btin +=3D gen_fwd_object_or_array(name)
>              self._btin +=3D gen_array(name, element_type)
>              self._btin +=3D gen_type_cleanup_decl(name)
> -            if do_builtins:
> +            if self._opt_builtins:
>                  self.defn +=3D gen_type_cleanup(name)
>          else:
>              self._fwdecl +=3D gen_fwd_object_or_array(name)
> @@ -241,16 +242,16 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
> =

>  # If you link code generated from multiple schemata, you want only one
>  # instance of the code for built-in types.  Generate it only when
> -# do_builtins, enabled by command line option -b.  See also
> +# opt_builtins, enabled by command line option -b.  See also
>  # QAPISchemaGenTypeVisitor.visit_end().
> -do_builtins =3D False
> +opt_builtins =3D False
> =

>  (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
>      parse_command_line('b', ['builtins'])
> =

>  for o, a in opts:
>      if o in ('-b', '--builtins'):
> -        do_builtins =3D True
> +        opt_builtins =3D True
> =

>  blurb =3D '''
>   * Schema-defined QAPI types
> @@ -272,7 +273,7 @@ genh.add(mcgen('''
>  '''))
> =

>  schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenTypeVisitor()
> +vis =3D QAPISchemaGenTypeVisitor(opt_builtins)
>  schema.visit(vis)
>  genc.add(vis.defn)
>  genh.add(vis.decl)
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 888c686303..0a1eff7736 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -264,7 +264,8 @@ out:
> =

> =

>  class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
> -    def __init__(self):
> +    def __init__(self, opt_builtins):
> +        self._opt_builtins =3D opt_builtins
>          self.decl =3D None
>          self.defn =3D None
>          self._btin =3D None
> @@ -277,7 +278,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>      def visit_end(self):
>          # To avoid header dependency hell, we always generate
>          # declarations for built-in types in our header files and
> -        # simply guard them.  See also do_builtins (command line
> +        # simply guard them.  See also opt_builtins (command line
>          # option -b).
>          self._btin +=3D guardend('QAPI_VISIT_BUILTIN')
>          self.decl =3D self._btin + self.decl
> @@ -288,7 +289,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          # TODO use something cleaner than existence of info
>          if not info:
>              self._btin +=3D gen_visit_decl(name, scalar=3DTrue)
> -            if do_builtins:
> +            if self._opt_builtins:
>                  self.defn +=3D gen_visit_enum(name)
>          else:
>              self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
> @@ -299,7 +300,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          defn =3D gen_visit_list(name, element_type)
>          if isinstance(element_type, QAPISchemaBuiltinType):
>              self._btin +=3D decl
> -            if do_builtins:
> +            if self._opt_builtins:
>                  self.defn +=3D defn
>          else:
>              self.decl +=3D decl
> @@ -324,16 +325,16 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
> =

>  # If you link code generated from multiple schemata, you want only one
>  # instance of the code for built-in types.  Generate it only when
> -# do_builtins, enabled by command line option -b.  See also
> +# opt_builtins, enabled by command line option -b.  See also
>  # QAPISchemaGenVisitVisitor.visit_end().
> -do_builtins =3D False
> +opt_builtins =3D False
> =

>  (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
>      parse_command_line('b', ['builtins'])
> =

>  for o, a in opts:
>      if o in ('-b', '--builtins'):
> -        do_builtins =3D True
> +        opt_builtins =3D True
> =

>  blurb =3D '''
>   * Schema-defined QAPI visitors
> @@ -359,7 +360,7 @@ genh.add(mcgen('''
>                 prefix=3Dprefix))
> =

>  schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenVisitVisitor()
> +vis =3D QAPISchemaGenVisitVisitor(opt_builtins)
>  schema.visit(vis)
>  genc.add(vis.defn)
>  genh.add(vis.decl)
> -- =

> 2.13.6
>=20
