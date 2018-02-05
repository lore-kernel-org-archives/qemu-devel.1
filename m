Received: from eggs.gnu.org ([2001:4830:134:3::10]:52799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih6r-000222-3v
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih6m-0004jY-Ck
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:47:01 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih6m-0004j1-6I
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:46:56 -0500
Received: by mail-qk0-f176.google.com with SMTP id c128so1450294qkb.4
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:46:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-18-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-18-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:46:55 +0100
Message-ID: <CAMxuvaxBAcULLchvRBmLGqS6b-PjVfVRfRNqok7HruVi7+PSOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 17/21] qapi/types qapi/visit: Generate
 built-in stuff into separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>, mdroth@linux.vnet.ibm.com

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Linking code from multiple separate QAPI schemata into the same
> program is possible, but involves some weirdness around built-in
> types:
>
> * We generate code for built-in types into .c only with option
>   --builtins.  The user is responsible to generate code for exactly
>   one QAPI schema per program with --builtins.
>
> * We generate code for them it into .h regardless of --builtins,
>   guarded by #ifndef QAPI_VISIT_BUILTIN.  Because the code for
>   built-in types is exactly the same in all of them, including any
>   combination of these headers works.
>
> Replace this contraption by something more conventional: generate code
> for built-in types into their very own files: qapi-builtin-types.c,
> qapi-builtin-visit.c, qapi-builtin-types.h, qapi-builtin-visit.h, but
> only with --builtins.  Obey --output-dir, but ignore --prefix for
> them.
>
> Make qapi-types.h include qapi-builtin-types.h.  With multiple
> schemata you now have multiple qapi-types.[ch], but only one
> qapi-builtin-types.[ch].  Same for qapi-visit.[ch] and
> qapi-builtin-visit.[ch].
>
> Bonus: if all you need is built-in stuff, you can include a much
> smaller header.  To be exploited shortly.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  Makefile               | 13 +++++---
>  Makefile.objs          |  1 +
>  scripts/qapi/common.py | 18 +++++------
>  scripts/qapi/types.py  | 82 ++++++++++++++++++++++++++------------------=
----
>  scripts/qapi/visit.py  | 84 ++++++++++++++++++++++++++++----------------=
------
>  5 files changed, 111 insertions(+), 87 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index e02f0c13ef..f9b7900330 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -88,10 +88,13 @@ endif
>  include $(SRC_PATH)/rules.mak
>
>  GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
> -GENERATED_FILES +=3D qmp-commands.h qapi-types.h qapi-visit.h qapi-event=
.h
> -GENERATED_FILES +=3D qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.=
c
> -GENERATED_FILES +=3D qmp-introspect.h
> -GENERATED_FILES +=3D qmp-introspect.c
> +GENERATED_FILES +=3D qmp-commands.h qmp-marshal.c
> +GENERATED_FILES +=3D qapi-builtin-types.h qapi-builtin-types.c
> +GENERATED_FILES +=3D qapi-types.h qapi-types.c
> +GENERATED_FILES +=3D qapi-builtin-visit.h qapi-builtin-visit.c
> +GENERATED_FILES +=3D qapi-visit.h qapi-visit.c
> +GENERATED_FILES +=3D qapi-event.h qapi-event.c
> +GENERATED_FILES +=3D qmp-introspect.c qmp-introspect.h
>  GENERATED_FILES +=3D qapi.texi
>
>  GENERATED_FILES +=3D trace/generated-tcg-tracers.h
> @@ -514,7 +517,9 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
>                 $(SRC_PATH)/qapi/transaction.json \
>                 $(SRC_PATH)/qapi/ui.json
>
> +qapi-builtin-types.c qapi-builtin-types.h \
>  qapi-types.c qapi-types.h \
> +qapi-builtin-visit.c qapi-builtin-visit.h \
>  qapi-visit.c qapi-visit.h \
>  qmp-commands.h qmp-marshal.c \
>  qapi-event.c qapi-event.h \
> diff --git a/Makefile.objs b/Makefile.objs
> index 323ef12384..f16cca06e7 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -2,6 +2,7 @@
>  # Common libraries for tools and emulators
>  stub-obj-y =3D stubs/ crypto/
>  util-obj-y =3D util/ qobject/ qapi/
> +util-obj-y +=3D qapi-builtin-types.o qapi-builtin-visit.o
>  util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
>
>  chardev-obj-y =3D chardev/
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index f4e9ebbb53..7ffffc78d9 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1527,11 +1527,10 @@ class QAPISchema(object):
>
>      def _def_builtin_type(self, name, json_type, c_type):
>          self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
> -        # TODO As long as we have QAPI_TYPES_BUILTIN to share multiple
> -        # qapi-types.h from a single .c, all arrays of builtins must be
> -        # declared in the first file whether or not they are used.  Nice=
r
> -        # would be to use lazy instantiation, while figuring out how to
> -        # avoid compilation issues with multiple qapi-types.h.
> +        # Instantiating only the arrays that are actually used would
> +        # be nice, but we can't as long as their generated code
> +        # (qapi-builtin-types.[ch]) may be shared by some other
> +        # schema.
>          self._make_array_type(name, None)
>
>      def _def_predefineds(self):
> @@ -1985,14 +1984,15 @@ class QAPIGen(object):
>          return ''
>
>      def write(self, output_dir, fname):
> -        if output_dir:
> +        pathname =3D os.path.join(output_dir, fname)
> +        dir =3D os.path.dirname(pathname)
> +        if dir:
>              try:
> -                os.makedirs(output_dir)
> +                os.makedirs(dir)
>              except os.error as e:
>                  if e.errno !=3D errno.EEXIST:
>                      raise
> -        fd =3D os.open(os.path.join(output_dir, fname),
> -                     os.O_RDWR | os.O_CREAT, 0666)
> +        fd =3D os.open(pathname, os.O_RDWR | os.O_CREAT, 0666)
>          f =3D os.fdopen(fd, 'r+')
>          text =3D (self.top(fname) + self._preamble + self._body
>                  + self.bottom(fname))
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index eeffcbf32c..f84ed17960 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -171,64 +171,72 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>      def __init__(self, opt_builtins, prefix):
>          self._opt_builtins =3D opt_builtins
>          self._prefix =3D prefix
> -        blurb =3D ' * Schema-defined QAPI types'
> -        self._genc =3D QAPIGenC(blurb, __doc__)
> -        self._genh =3D QAPIGenH(blurb, __doc__)
> +        self._module =3D {}
> +        self._add_module(None, ' * Built-in QAPI types')
>          self._genc.preamble(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qapi/dealloc-visitor.h"
> -#include "%(prefix)sqapi-types.h"
> -#include "%(prefix)sqapi-visit.h"
> -''',
> -                                  prefix=3Dprefix))
> +#include "qapi-builtin-types.h"
> +#include "qapi-builtin-visit.h"
> +'''))
>          self._genh.preamble(mcgen('''
>  #include "qapi/util.h"
>  '''))
> -        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')
> +
> +    def _module_basename(self, name):
> +        if name is None:
> +            return 'qapi-builtin-types'
> +        return self._prefix + 'qapi-types'
> +
> +    def _add_module(self, name, blurb):
> +        genc =3D QAPIGenC(blurb, __doc__)
> +        genh =3D QAPIGenH(blurb, __doc__)
> +        self._module[name] =3D (genc, genh)
> +        self._set_module(name)
> +
> +    def _set_module(self, name):
> +        self._genc, self._genh =3D self._module[name]
>
>      def write(self, output_dir):
> -        self._genc.write(output_dir, self._prefix + 'qapi-types.c')
> -        self._genh.write(output_dir, self._prefix + 'qapi-types.h')
> +        for name in self._module:
> +            if name is None and not self._opt_builtins:
> +                continue
> +            basename =3D self._module_basename(name)
> +            (genc, genh) =3D self._module[name]
> +            genc.write(output_dir, basename + '.c')
> +            genh.write(output_dir, basename + '.h')
>
>      def visit_begin(self, schema):
>          # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
>          objects_seen.add(schema.the_empty_object_type.name)
>
> -    def visit_end(self):
> -        # To avoid header dependency hell, we always generate
> -        # declarations for built-in types in our header files and
> -        # simply guard them.  See also opt_builtins (command line
> -        # option -b).
> -        self._btin +=3D guardend('QAPI_TYPES_BUILTIN')
> -        self._genh.preamble(self._btin)
> -        self._btin =3D None
> +    def visit_module(self, name):
> +        if len(self._module) !=3D 1:
> +            return
> +        self._add_module(name, ' * Schema-defined QAPI types')
> +        self._genc.preamble(mcgen('''
> +#include "qemu/osdep.h"
> +#include "qapi/dealloc-visitor.h"
> +#include "%(prefix)sqapi-types.h"
> +#include "%(prefix)sqapi-visit.h"
> +''',
> +                                  prefix=3Dself._prefix))
> +        self._genh.preamble(mcgen('''
> +#include "qapi-builtin-types.h"
> +'''))
>
>      def _gen_type_cleanup(self, name):
>          self._genh.body(gen_type_cleanup_decl(name))
>          self._genc.body(gen_type_cleanup(name))
>
>      def visit_enum_type(self, name, info, values, prefix):
> -        # Special case for our lone builtin enum type
> -        # TODO use something cleaner than existence of info
> -        if not info:
> -            self._btin +=3D gen_enum(name, values, prefix)
> -            if self._opt_builtins:
> -                self._genc.body(gen_enum_lookup(name, values, prefix))
> -        else:
> -            self._genh.preamble(gen_enum(name, values, prefix))
> -            self._genc.body(gen_enum_lookup(name, values, prefix))
> +        self._genh.preamble(gen_enum(name, values, prefix))
> +        self._genc.body(gen_enum_lookup(name, values, prefix))
>
>      def visit_array_type(self, name, info, element_type):
> -        if isinstance(element_type, QAPISchemaBuiltinType):
> -            self._btin +=3D gen_fwd_object_or_array(name)
> -            self._btin +=3D gen_array(name, element_type)
> -            self._btin +=3D gen_type_cleanup_decl(name)
> -            if self._opt_builtins:
> -                self._genc.body(gen_type_cleanup(name))
> -        else:
> -            self._genh.preamble(gen_fwd_object_or_array(name))
> -            self._genh.body(gen_array(name, element_type))
> -            self._gen_type_cleanup(name)
> +        self._genh.preamble(gen_fwd_object_or_array(name))
> +        self._genh.body(gen_array(name, element_type))
> +        self._gen_type_cleanup(name)
>
>      def visit_object_type(self, name, info, base, members, variants):
>          # Nothing to do for the special empty builtin
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index ee1a849574..f23e71bb9a 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -267,58 +267,68 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>      def __init__(self, opt_builtins, prefix):
>          self._opt_builtins =3D opt_builtins
>          self._prefix =3D prefix
> -        blurb =3D ' * Schema-defined QAPI visitors'
> -        self._genc =3D QAPIGenC(blurb, __doc__)
> -        self._genh =3D QAPIGenH(blurb, __doc__)
> +        self._module =3D {}
> +        self._add_module(None, ' * Built-in QAPI visitors')
>          self._genc.preamble(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qapi/error.h"
> -#include "%(prefix)sqapi-visit.h"
> -''',
> -                                  prefix=3Dprefix))
> +#include "qapi-builtin-visit.h"
> +'''))
>          self._genh.preamble(mcgen('''
>  #include "qapi/visitor.h"
>  #include "qapi/qmp/qerror.h"
> -#include "%(prefix)sqapi-types.h"
> +#include "qapi-builtin-types.h"
>  ''',
> -                                  prefix=3Dprefix))
> -        self._btin =3D guardstart('QAPI_VISIT_BUILTIN')
> +                              prefix=3Dprefix))
> +
> +    def _module_basename(self, name):
> +        if name is None:
> +            return 'qapi-builtin-visit'
> +        return self._prefix + 'qapi-visit'
> +
> +    def _add_module(self, name, blurb):
> +        genc =3D QAPIGenC(blurb, __doc__)
> +        genh =3D QAPIGenH(blurb, __doc__)
> +        self._module[name] =3D (genc, genh)
> +        self._set_module(name)
> +
> +    def _set_module(self, name):
> +        self._genc, self._genh =3D self._module[name]
>
>      def write(self, output_dir):
> -        self._genc.write(output_dir, self._prefix + 'qapi-visit.c')
> -        self._genh.write(output_dir, self._prefix + 'qapi-visit.h')
> +        for name in self._module:
> +            if name is None and not self._opt_builtins:
> +                continue
> +            basename =3D self._module_basename(name)
> +            (genc, genh) =3D self._module[name]
> +            genc.write(output_dir, basename + '.c')
> +            genh.write(output_dir, basename + '.h')
>
> -    def visit_end(self):
> -        # To avoid header dependency hell, we always generate
> -        # declarations for built-in types in our header files and
> -        # simply guard them.  See also opt_builtins (command line
> -        # option -b).
> -        self._btin +=3D guardend('QAPI_VISIT_BUILTIN')
> -        self._genh.preamble(self._btin)
> -        self._btin =3D None
> +    def visit_module(self, name):
> +        if len(self._module) !=3D 1:
> +            return
> +        self._add_module(name, ' * Schema-defined QAPI visitors')
> +        self._genc.preamble(mcgen('''
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "%(prefix)sqapi-visit.h"
> +''',
> +                                  prefix=3Dself._prefix))
> +        self._genh.preamble(mcgen('''
> +#include "qapi-builtin-visit.h"
> +#include "%(prefix)sqapi-types.h"
> +''',
> +                                  prefix=3Dself._prefix))
>
>      def visit_enum_type(self, name, info, values, prefix):
> -        # Special case for our lone builtin enum type
> -        # TODO use something cleaner than existence of info
> -        if not info:
> -            self._btin +=3D gen_visit_decl(name, scalar=3DTrue)
> -            if self._opt_builtins:
> -                self._genc.body(gen_visit_enum(name))
> -        else:
> -            self._genh.body(gen_visit_decl(name, scalar=3DTrue))
> -            self._genc.body(gen_visit_enum(name))
> +        self._genh.body(gen_visit_decl(name, scalar=3DTrue))
> +        self._genc.body(gen_visit_enum(name))
>
>      def visit_array_type(self, name, info, element_type):
> -        decl =3D gen_visit_decl(name)
> -        defn =3D gen_visit_list(name, element_type)
> -        if isinstance(element_type, QAPISchemaBuiltinType):
> -            self._btin +=3D decl
> -            if self._opt_builtins:
> -                self._genc.body(defn)
> -        else:
> -            self._genh.body(decl)
> -            self._genc.body(defn)
> +        self._genh.body(gen_visit_decl(name))
> +        self._genc.body(gen_visit_list(name, element_type))
>
>      def visit_object_type(self, name, info, base, members, variants):
>          # Nothing to do for the special empty builtin
> --
> 2.13.6
>
