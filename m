Received: from eggs.gnu.org ([2001:4830:134:3::10]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih6e-0001rF-DB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih6Z-0004Z5-FR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:46:48 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih6Z-0004Yb-9H
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:46:43 -0500
Received: by mail-qt0-f196.google.com with SMTP id h4so11873024qtn.13
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:46:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-17-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-17-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:46:42 +0100
Message-ID: <CAMxuvaxfhL_qRq6+ShLvxDcskn272X3HST3kyEg47LZLNhpeHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 16/21] qapi/types qapi/visit: Make
 visitors use QAPIGen more
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
> The conversion is rather shallow so far: most of the output
> accumulation is not converted.  Take the next step: convert output
> accumulation in QAPISchemaGenTypeVisitor and
> QAPISchemaGenVisitVisitor.  Helper functions outside these classes are
> not converted.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi/types.py | 83 +++++++++++++++++++++++----------------------=
------
>  scripts/qapi/visit.py | 83 +++++++++++++++++++++++----------------------=
------
>  2 files changed, 74 insertions(+), 92 deletions(-)
>
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index b2095120e0..eeffcbf32c 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -168,35 +168,44 @@ void qapi_free_%(c_name)s(%(c_name)s *obj)
>
>
>  class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
> -    def __init__(self, opt_builtins):
> +    def __init__(self, opt_builtins, prefix):
>          self._opt_builtins =3D opt_builtins
> -        self.decl =3D None
> -        self.defn =3D None
> -        self._fwdecl =3D None
> -        self._btin =3D None
> +        self._prefix =3D prefix
> +        blurb =3D ' * Schema-defined QAPI types'
> +        self._genc =3D QAPIGenC(blurb, __doc__)
> +        self._genh =3D QAPIGenH(blurb, __doc__)
> +        self._genc.preamble(mcgen('''
> +#include "qemu/osdep.h"
> +#include "qapi/dealloc-visitor.h"
> +#include "%(prefix)sqapi-types.h"
> +#include "%(prefix)sqapi-visit.h"
> +''',
> +                                  prefix=3Dprefix))
> +        self._genh.preamble(mcgen('''
> +#include "qapi/util.h"
> +'''))
> +        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')
> +
> +    def write(self, output_dir):
> +        self._genc.write(output_dir, self._prefix + 'qapi-types.c')
> +        self._genh.write(output_dir, self._prefix + 'qapi-types.h')
>
>      def visit_begin(self, schema):
>          # gen_object() is recursive, ensure it doesn't visit the empty t=
ype
>          objects_seen.add(schema.the_empty_object_type.name)
> -        self.decl =3D ''
> -        self.defn =3D ''
> -        self._fwdecl =3D ''
> -        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')
>
>      def visit_end(self):
> -        self.decl =3D self._fwdecl + self.decl
> -        self._fwdecl =3D None
>          # To avoid header dependency hell, we always generate
>          # declarations for built-in types in our header files and
>          # simply guard them.  See also opt_builtins (command line
>          # option -b).
>          self._btin +=3D guardend('QAPI_TYPES_BUILTIN')
> -        self.decl =3D self._btin + self.decl
> +        self._genh.preamble(self._btin)
>          self._btin =3D None
>
>      def _gen_type_cleanup(self, name):
> -        self.decl +=3D gen_type_cleanup_decl(name)
> -        self.defn +=3D gen_type_cleanup(name)
> +        self._genh.body(gen_type_cleanup_decl(name))
> +        self._genc.body(gen_type_cleanup(name))
>
>      def visit_enum_type(self, name, info, values, prefix):
>          # Special case for our lone builtin enum type
> @@ -204,10 +213,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          if not info:
>              self._btin +=3D gen_enum(name, values, prefix)
>              if self._opt_builtins:
> -                self.defn +=3D gen_enum_lookup(name, values, prefix)
> +                self._genc.body(gen_enum_lookup(name, values, prefix))
>          else:
> -            self._fwdecl +=3D gen_enum(name, values, prefix)
> -            self.defn +=3D gen_enum_lookup(name, values, prefix)
> +            self._genh.preamble(gen_enum(name, values, prefix))
> +            self._genc.body(gen_enum_lookup(name, values, prefix))
>
>      def visit_array_type(self, name, info, element_type):
>          if isinstance(element_type, QAPISchemaBuiltinType):
> @@ -215,20 +224,20 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>              self._btin +=3D gen_array(name, element_type)
>              self._btin +=3D gen_type_cleanup_decl(name)
>              if self._opt_builtins:
> -                self.defn +=3D gen_type_cleanup(name)
> +                self._genc.body(gen_type_cleanup(name))
>          else:
> -            self._fwdecl +=3D gen_fwd_object_or_array(name)
> -            self.decl +=3D gen_array(name, element_type)
> +            self._genh.preamble(gen_fwd_object_or_array(name))
> +            self._genh.body(gen_array(name, element_type))
>              self._gen_type_cleanup(name)
>
>      def visit_object_type(self, name, info, base, members, variants):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
>              return
> -        self._fwdecl +=3D gen_fwd_object_or_array(name)
> -        self.decl +=3D gen_object(name, base, members, variants)
> +        self._genh.preamble(gen_fwd_object_or_array(name))
> +        self._genh.body(gen_object(name, base, members, variants))
>          if base and not base.is_implicit():
> -            self.decl +=3D gen_upcast(name, base)
> +            self._genh.body(gen_upcast(name, base))
>          # TODO Worth changing the visitor signature, so we could
>          # directly use rather than repeat type.is_implicit()?
>          if not name.startswith('q_'):
> @@ -236,31 +245,13 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>              self._gen_type_cleanup(name)
>
>      def visit_alternate_type(self, name, info, variants):
> -        self._fwdecl +=3D gen_fwd_object_or_array(name)
> -        self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
> +        self._genh.preamble(gen_fwd_object_or_array(name))
> +        self._genh.body(gen_object(name, None,
> +                                   [variants.tag_member], variants))
>          self._gen_type_cleanup(name)
>
>
>  def gen_types(schema, output_dir, prefix, opt_builtins):
> -    blurb =3D ' * Schema-defined QAPI types'
> -    genc =3D QAPIGenC(blurb, __doc__)
> -    genh =3D QAPIGenH(blurb, __doc__)
> -
> -    genc.body(mcgen('''
> -#include "qemu/osdep.h"
> -#include "qapi/dealloc-visitor.h"
> -#include "%(prefix)sqapi-types.h"
> -#include "%(prefix)sqapi-visit.h"
> -''',
> -                    prefix=3Dprefix))
> -
> -    genh.body(mcgen('''
> -#include "qapi/util.h"
> -'''))
> -
> -    vis =3D QAPISchemaGenTypeVisitor(opt_builtins)
> +    vis =3D QAPISchemaGenTypeVisitor(opt_builtins, prefix)
>      schema.visit(vis)
> -    genc.body(vis.defn)
> -    genh.body(vis.decl)
> -    genc.write(output_dir, prefix + 'qapi-types.c')
> -    genh.write(output_dir, prefix + 'qapi-types.h')
> +    vis.write(output_dir)
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 80c0b85f8c..ee1a849574 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -264,24 +264,38 @@ out:
>
>
>  class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
> -    def __init__(self, opt_builtins):
> +    def __init__(self, opt_builtins, prefix):
>          self._opt_builtins =3D opt_builtins
> -        self.decl =3D None
> -        self.defn =3D None
> -        self._btin =3D None
> -
> -    def visit_begin(self, schema):
> -        self.decl =3D ''
> -        self.defn =3D ''
> +        self._prefix =3D prefix
> +        blurb =3D ' * Schema-defined QAPI visitors'
> +        self._genc =3D QAPIGenC(blurb, __doc__)
> +        self._genh =3D QAPIGenH(blurb, __doc__)
> +        self._genc.preamble(mcgen('''
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "%(prefix)sqapi-visit.h"
> +''',
> +                                  prefix=3Dprefix))
> +        self._genh.preamble(mcgen('''
> +#include "qapi/visitor.h"
> +#include "qapi/qmp/qerror.h"
> +#include "%(prefix)sqapi-types.h"
> +''',
> +                                  prefix=3Dprefix))
>          self._btin =3D guardstart('QAPI_VISIT_BUILTIN')
>
> +    def write(self, output_dir):
> +        self._genc.write(output_dir, self._prefix + 'qapi-visit.c')
> +        self._genh.write(output_dir, self._prefix + 'qapi-visit.h')
> +
>      def visit_end(self):
>          # To avoid header dependency hell, we always generate
>          # declarations for built-in types in our header files and
>          # simply guard them.  See also opt_builtins (command line
>          # option -b).
>          self._btin +=3D guardend('QAPI_VISIT_BUILTIN')
> -        self.decl =3D self._btin + self.decl
> +        self._genh.preamble(self._btin)
>          self._btin =3D None
>
>      def visit_enum_type(self, name, info, values, prefix):
> @@ -290,10 +304,10 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          if not info:
>              self._btin +=3D gen_visit_decl(name, scalar=3DTrue)
>              if self._opt_builtins:
> -                self.defn +=3D gen_visit_enum(name)
> +                self._genc.body(gen_visit_enum(name))
>          else:
> -            self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
> -            self.defn +=3D gen_visit_enum(name)
> +            self._genh.body(gen_visit_decl(name, scalar=3DTrue))
> +            self._genc.body(gen_visit_enum(name))
>
>      def visit_array_type(self, name, info, element_type):
>          decl =3D gen_visit_decl(name)
> @@ -301,53 +315,30 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          if isinstance(element_type, QAPISchemaBuiltinType):
>              self._btin +=3D decl
>              if self._opt_builtins:
> -                self.defn +=3D defn
> +                self._genc.body(defn)
>          else:
> -            self.decl +=3D decl
> -            self.defn +=3D defn
> +            self._genh.body(decl)
> +            self._genc.body(defn)
>
>      def visit_object_type(self, name, info, base, members, variants):
>          # Nothing to do for the special empty builtin
>          if name =3D=3D 'q_empty':
>              return
> -        self.decl +=3D gen_visit_members_decl(name)
> -        self.defn +=3D gen_visit_object_members(name, base, members, var=
iants)
> +        self._genh.body(gen_visit_members_decl(name))
> +        self._genc.body(gen_visit_object_members(name, base, members, va=
riants))
>          # TODO Worth changing the visitor signature, so we could
>          # directly use rather than repeat type.is_implicit()?
>          if not name.startswith('q_'):
>              # only explicit types need an allocating visit
> -            self.decl +=3D gen_visit_decl(name)
> -            self.defn +=3D gen_visit_object(name, base, members, variant=
s)
> +            self._genh.body(gen_visit_decl(name))
> +            self._genc.body(gen_visit_object(name, base, members, varian=
ts))
>
>      def visit_alternate_type(self, name, info, variants):
> -        self.decl +=3D gen_visit_decl(name)
> -        self.defn +=3D gen_visit_alternate(name, variants)
> +        self._genh.body(gen_visit_decl(name))
> +        self._genc.body(gen_visit_alternate(name, variants))
>
>
>  def gen_visit(schema, output_dir, prefix, opt_builtins):
> -    blurb =3D ' * Schema-defined QAPI visitors'
> -    genc =3D QAPIGenC(blurb, __doc__)
> -    genh =3D QAPIGenH(blurb, __doc__)
> -
> -    genc.body(mcgen('''
> -#include "qemu/osdep.h"
> -#include "qemu-common.h"
> -#include "qapi/error.h"
> -#include "%(prefix)sqapi-visit.h"
> -''',
> -                    prefix=3Dprefix))
> -
> -    genh.body(mcgen('''
> -#include "qapi/visitor.h"
> -#include "qapi/qmp/qerror.h"
> -#include "%(prefix)sqapi-types.h"
> -
> -''',
> -                    prefix=3Dprefix))
> -
> -    vis =3D QAPISchemaGenVisitVisitor(opt_builtins)
> +    vis =3D QAPISchemaGenVisitVisitor(opt_builtins, prefix)
>      schema.visit(vis)
> -    genc.body(vis.defn)
> -    genh.body(vis.decl)
> -    genc.write(output_dir, prefix + 'qapi-visit.c')
> -    genh.write(output_dir, prefix + 'qapi-visit.h')
> +    vis.write(output_dir)
> --
> 2.13.6
>
