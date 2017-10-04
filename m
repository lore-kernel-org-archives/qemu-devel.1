Received: from eggs.gnu.org ([2001:4830:134:3::10]:35150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhbu-0008Sk-R4
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhbs-0001BB-SS
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:13:06 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:52387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhbs-0001AZ-Lp
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:13:04 -0400
Received: by mail-oi0-x241.google.com with SMTP id p126so18956096oih.9
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 04:13:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-13-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-13-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 13:13:01 +0200
Message-ID: <CAJ+F1CKC7WinXDZX+F5MWsNrMmE5Fvx5NCyNisUMJp++K7Kfkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 12/32] qapi: Use argparse to parse
 command line arguments
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
> Less code than with getopt, and we get --help for free.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi-commands.py       | 13 +++++-----
>  scripts/qapi-event.py          | 12 ++++-----
>  scripts/qapi-introspect.py     | 22 +++++++---------
>  scripts/qapi-types.py          | 22 ++++++----------
>  scripts/qapi-visit.py          | 24 +++++++----------
>  scripts/qapi.py                | 58 +++++++++++++++---------------------=
------
>  scripts/qapi2texi.py           | 11 +++++---
>  tests/qapi-schema/test-qapi.py | 10 +++++---
>  8 files changed, 74 insertions(+), 98 deletions(-)
>
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index 56a1009564..76cc9cc8a4 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -214,7 +214,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s)
>      QTAILQ_INIT(cmds);
>
>  ''',
> -                c_prefix=3Dc_name(prefix, protect=3DFalse))
> +                c_prefix=3Dc_name(args.prefix, protect=3DFalse))
>      ret +=3D registry
>      ret +=3D mcgen('''
>  }
> @@ -253,7 +253,7 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor):
>          self._regy +=3D gen_register_command(name, success_response)
>
>
> -(input_file, output_dir, prefix, opts) =3D parse_command_line()
> +args =3D common_argument_parser().parse_args()
>
>  c_comment =3D '''
>  /*
> @@ -284,7 +284,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, prefix,
> +(fdef, fdecl) =3D open_output(args.output_dir, args.prefix,
>                              'qmp-marshal.c', 'qmp-commands.h',
>                              c_comment, h_comment)
>
> @@ -302,7 +302,7 @@ fdef.write(mcgen('''
>  #include "%(prefix)sqmp-commands.h"
>
>  ''',
> -                 prefix=3Dprefix))
> +                 prefix=3Dargs.prefix))
>
>  fdecl.write(mcgen('''
>  #include "%(prefix)sqapi-types.h"
> @@ -312,9 +312,10 @@ fdecl.write(mcgen('''
>
>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>  ''',
> -                  prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DF=
alse)))
> +                  prefix=3Dargs.prefix,
> +                  c_prefix=3Dc_name(args.prefix, protect=3DFalse)))
>
> -schema =3D QAPISchema(input_file)
> +schema =3D QAPISchema(args.schema)
>  gen =3D QAPISchemaGenCommandVisitor()
>  schema.visit(gen)
>  fdef.write(gen.defn)
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index 0a308e6b69..1c61751bc0 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -169,7 +169,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self._event_names.append(name)
>
>
> -(input_file, output_dir, prefix, dummy) =3D parse_command_line()
> +args =3D common_argument_parser().parse_args()
>
>  c_comment =3D '''
>  /*
> @@ -200,7 +200,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, prefix,
> +(fdef, fdecl) =3D open_output(args.output_dir, args.prefix,
>                              'qapi-event.c', 'qapi-event.h',
>                              c_comment, h_comment)
>
> @@ -213,7 +213,7 @@ fdef.write(mcgen('''
>  #include "qapi/qmp-event.h"
>
>  ''',
> -                 prefix=3Dprefix))
> +                 prefix=3Dargs.prefix))
>
>  fdecl.write(mcgen('''
>  #include "qapi/error.h"
> @@ -222,11 +222,11 @@ fdecl.write(mcgen('''
>  #include "%(prefix)sqapi-types.h"
>
>  ''',
> -                  prefix=3Dprefix))
> +                  prefix=3Dargs.prefix))
>
> -event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
> +event_enum_name =3D c_name(args.prefix + 'QAPIEvent', protect=3DFalse)
>
> -schema =3D QAPISchema(input_file)
> +schema =3D QAPISchema(args.schema)
>  gen =3D QAPISchemaGenEventVisitor()
>  schema.visit(gen)
>  fdef.write(gen.defn)
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index c2e46182c8..ad87fc57e3 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -64,7 +64,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaVisitor)=
:
>          # generate C
>          # TODO can generate awfully long lines
>          jsons.extend(self._jsons)
> -        name =3D c_name(prefix, protect=3DFalse) + 'qmp_schema_json'
> +        name =3D c_name(args.prefix, protect=3DFalse) + 'qmp_schema_json=
'
>          self.decl =3D mcgen('''
>  extern const char %(c_name)s[];
>  ''',
> @@ -165,16 +165,12 @@ const char %(c_name)s[] =3D %(c_string)s;
>          arg_type =3D arg_type or self._schema.the_empty_object_type
>          self._gen_json(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
>
> +parser =3D common_argument_parser()
>  # Debugging aid: unmask QAPI schema's type names
>  # We normally mask them, because they're not QMP wire ABI
> -opt_unmask =3D False
> -
> -(input_file, output_dir, prefix, opts) =3D \
> -    parse_command_line('u', ['unmask-non-abi-names'])
> -
> -for o, a in opts:
> -    if o in ('-u', '--unmask-non-abi-names'):
> -        opt_unmask =3D True
> +parser.add_argument('-u', '--unmask-non-abi-names', action=3D'store_true=
',
> +                    help=3D'unmask non-ABI names')
> +args =3D parser.parse_args()
>
>  c_comment =3D '''
>  /*
> @@ -199,7 +195,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, prefix,
> +(fdef, fdecl) =3D open_output(args.output_dir, args.prefix,
>                              'qmp-introspect.c', 'qmp-introspect.h',
>                              c_comment, h_comment)
>
> @@ -208,10 +204,10 @@ fdef.write(mcgen('''
>  #include "%(prefix)sqmp-introspect.h"
>
>  ''',
> -                 prefix=3Dprefix))
> +                 prefix=3Dargs.prefix))
>
> -schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
> +schema =3D QAPISchema(args.schema)
> +gen =3D QAPISchemaGenIntrospectVisitor(args.unmask_non_abi_names)
>  schema.visit(gen)
>  fdef.write(gen.defn)
>  fdecl.write(gen.decl)
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index dc7dd08512..ed05d828bf 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -185,7 +185,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          self._fwdecl =3D None
>          # To avoid header dependency hell, we always generate
>          # declarations for built-in types in our header files and
> -        # simply guard them.  See also do_builtins (command line
> +        # simply guard them.  See also args.builtins (command line
>          # option -b).
>          self._btin +=3D guardend('QAPI_TYPES_BUILTIN')
>          self.decl =3D self._btin + self.decl
> @@ -200,7 +200,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          # TODO use something cleaner than existence of info
>          if not info:
>              self._btin +=3D gen_enum(name, values, prefix)
> -            if do_builtins:
> +            if args.builtins:
>                  self.defn +=3D gen_enum_lookup(name, values, prefix)
>          else:
>              self._fwdecl +=3D gen_enum(name, values, prefix)
> @@ -211,7 +211,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>              self._btin +=3D gen_fwd_object_or_array(name)
>              self._btin +=3D gen_array(name, element_type)
>              self._btin +=3D gen_type_cleanup_decl(name)
> -            if do_builtins:
> +            if args.builtins:
>                  self.defn +=3D gen_type_cleanup(name)
>          else:
>              self._fwdecl +=3D gen_fwd_object_or_array(name)
> @@ -239,16 +239,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>
>  # If you link code generated from multiple schemata, you want only one
>  # instance of the code for built-in types.  Generate it only when
> -# do_builtins, enabled by command line option -b.  See also
> +# args.builtins, enabled by command line option -b.  See also
>  # QAPISchemaGenTypeVisitor.visit_end().
> -do_builtins =3D False
>
> -(input_file, output_dir, prefix, opts) =3D \
> -    parse_command_line('b', ['builtins'])
> -
> -for o, a in opts:
> -    if o in ('-b', '--builtins'):
> -        do_builtins =3D True
> +args =3D common_argument_parser(builtins=3DTrue).parse_args()
>
>  c_comment =3D '''
>  /*
> @@ -280,7 +274,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, prefix,
> +(fdef, fdecl) =3D open_output(args.output_dir, args.prefix,
>                              'qapi-types.c', 'qapi-types.h',
>                              c_comment, h_comment)
>
> @@ -290,13 +284,13 @@ fdef.write(mcgen('''
>  #include "%(prefix)sqapi-types.h"
>  #include "%(prefix)sqapi-visit.h"
>  ''',
> -                 prefix=3Dprefix))
> +                 prefix=3Dargs.prefix))
>
>  fdecl.write(mcgen('''
>  #include "qapi/util.h"
>  '''))
>
> -schema =3D QAPISchema(input_file)
> +schema =3D QAPISchema(args.schema)
>  gen =3D QAPISchemaGenTypeVisitor()
>  schema.visit(gen)
>  fdef.write(gen.defn)
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 9757911d2d..010d68434f 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -276,7 +276,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>      def visit_end(self):
>          # To avoid header dependency hell, we always generate
>          # declarations for built-in types in our header files and
> -        # simply guard them.  See also do_builtins (command line
> +        # simply guard them.  See also args.builtins (command line
>          # option -b).
>          self._btin +=3D guardend('QAPI_VISIT_BUILTIN')
>          self.decl =3D self._btin + self.decl
> @@ -287,7 +287,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          # TODO use something cleaner than existence of info
>          if not info:
>              self._btin +=3D gen_visit_decl(name, scalar=3DTrue)
> -            if do_builtins:
> +            if args.builtins:
>                  self.defn +=3D gen_visit_enum(name)
>          else:
>              self.decl +=3D gen_visit_decl(name, scalar=3DTrue)
> @@ -298,7 +298,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          defn =3D gen_visit_list(name, element_type)
>          if isinstance(element_type, QAPISchemaBuiltinType):
>              self._btin +=3D decl
> -            if do_builtins:
> +            if args.builtins:
>                  self.defn +=3D defn
>          else:
>              self.decl +=3D decl
> @@ -323,16 +323,10 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>
>  # If you link code generated from multiple schemata, you want only one
>  # instance of the code for built-in types.  Generate it only when
> -# do_builtins, enabled by command line option -b.  See also
> +# args.builtins, enabled by command line option -b.  See also
>  # QAPISchemaGenVisitVisitor.visit_end().
> -do_builtins =3D False
>
> -(input_file, output_dir, prefix, opts) =3D \
> -    parse_command_line('b', ['builtins'])
> -
> -for o, a in opts:
> -    if o in ('-b', '--builtins'):
> -        do_builtins =3D True
> +args =3D common_argument_parser(builtins=3DTrue).parse_args()
>
>  c_comment =3D '''
>  /*
> @@ -363,7 +357,7 @@ h_comment =3D '''
>   */
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, prefix,
> +(fdef, fdecl) =3D open_output(args.output_dir, args.prefix,
>                              'qapi-visit.c', 'qapi-visit.h',
>                              c_comment, h_comment)
>
> @@ -373,7 +367,7 @@ fdef.write(mcgen('''
>  #include "qapi/error.h"
>  #include "%(prefix)sqapi-visit.h"
>  ''',
> -                 prefix=3Dprefix))
> +                 prefix=3Dargs.prefix))
>
>  fdecl.write(mcgen('''
>  #include "qapi/visitor.h"
> @@ -381,9 +375,9 @@ fdecl.write(mcgen('''
>  #include "%(prefix)sqapi-types.h"
>
>  ''',
> -                  prefix=3Dprefix))
> +                  prefix=3Dargs.prefix))
>
> -schema =3D QAPISchema(input_file)
> +schema =3D QAPISchema(args.schema)
>  gen =3D QAPISchemaGenVisitVisitor()
>  schema.visit(gen)
>  fdef.write(gen.defn)
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 5434987108..25f6c81b08 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -11,8 +11,8 @@
>  # This work is licensed under the terms of the GNU GPL, version 2.
>  # See the COPYING file in the top-level directory.
>
> +import argparse
>  import errno
> -import getopt
>  import os
>  import re
>  import string
> @@ -1917,43 +1917,27 @@ def build_params(arg_type, boxed, extra):
>  # Common command line parsing
>  #
>
> +def common_argument_parser(builtins=3DFalse):
>
> -def parse_command_line(extra_options=3D'', extra_long_options=3D[]):
> +    def prefix(string):
> +        match =3D re.match(r'([a-z_.-][a-z0-9_.-]*)?', string, re.I)
> +        if match.end() !=3D len(string):
> +            raise argparse.ArgumentTypeError("funny character '%s'"
> +                                             % string[match.end()])
> +        return string
>
> -    try:
> -        opts, args =3D getopt.gnu_getopt(sys.argv[1:],
> -                                       'chp:o:' + extra_options,
> -                                       ['source', 'header', 'prefix=3D',
> -                                        'output-dir=3D'] + extra_long_op=
tions)
> -    except getopt.GetoptError as err:
> -        print >>sys.stderr, "%s: %s" % (sys.argv[0], str(err))
> -        sys.exit(1)
> +    parser =3D argparse.ArgumentParser(conflict_handler=3D'resolve')
> +    if builtins:
> +        parser.add_argument('-b', '--builtins', action=3D'store_true',
> +                            help=3D'generate builtins')
> +    parser.add_argument('-o', '--output-dir', default=3D'',
> +                        help=3D'output directory')
> +    parser.add_argument('-p', '--prefix', default=3D'', type=3Dprefix,
> +                        help=3D'prefix to add to output files')
> +    parser.add_argument('schema',
> +                        help=3D'QAPI schema source file')
> +    return parser
>
> -    output_dir =3D ''
> -    prefix =3D ''
> -    extra_opts =3D []
> -
> -    for oa in opts:
> -        o, a =3D oa
> -        if o in ('-p', '--prefix'):
> -            match =3D re.match(r'([A-Za-z_.-][A-Za-z0-9_.-]*)?', a)
> -            if match.end() !=3D len(a):
> -                print >>sys.stderr, \
> -                    "%s: 'funny character '%s' in argument of --prefix" =
\
> -                    % (sys.argv[0], a[match.end()])
> -                sys.exit(1)
> -            prefix =3D a
> -        elif o in ('-o', '--output-dir'):
> -            output_dir =3D a + '/'
> -        else:
> -            extra_opts.append(oa)
> -
> -    if len(args) !=3D 1:
> -        print >>sys.stderr, "%s: need exactly one argument" % sys.argv[0=
]
> -        sys.exit(1)
> -    fname =3D args[0]
> -
> -    return (fname, output_dir, prefix, extra_opts)
>
>  #
>  # Generate output files with boilerplate
> @@ -1963,8 +1947,8 @@ def parse_command_line(extra_options=3D'', extra_lo=
ng_options=3D[]):
>  def open_output(output_dir, prefix, c_file, h_file,
>                  c_comment, h_comment):
>      guard =3D guardname(prefix + h_file)
> -    c_file =3D output_dir + prefix + c_file
> -    h_file =3D output_dir + prefix + h_file
> +    c_file =3D os.path.join(output_dir, prefix + c_file)
> +    h_file =3D os.path.join(output_dir, prefix + h_file)
>
>      if output_dir:
>          try:
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index bfd1c676e1..fd90d8953e 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -4,6 +4,8 @@
>  # This work is licensed under the terms of the GNU LGPL, version 2+.
>  # See the COPYING file in the top-level directory.
>  """This script produces the documentation of a qapi schema in texinfo fo=
rmat"""
> +
> +import argparse
>  import re
>  import sys
>
> @@ -279,11 +281,12 @@ def texi_schema(schema):
>
>  def main(argv):
>      """Takes schema argument, prints result to stdout"""
> -    if len(argv) !=3D 2:
> -        print >>sys.stderr, "%s: need exactly 1 argument: SCHEMA" % argv=
[0]
> -        sys.exit(1)
> +    parser =3D argparse.ArgumentParser()
> +    parser.add_argument('schema',
> +                        help=3D'QAPI schema source file')
> +    args =3D parser.parse_args()
>
> -    schema =3D qapi.QAPISchema(argv[1])
> +    schema =3D qapi.QAPISchema(args.schema)
>      if not qapi.doc_required:
>          print >>sys.stderr, ("%s: need pragma 'doc-required' "
>                               "to generate documentation" % argv[0])
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index fe0ca08d78..a7e21d016f 100644
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -12,8 +12,7 @@
>
>  from qapi import *
>  from pprint import pprint
> -import os
> -import sys
> +import argparse
>
>
>  class QAPISchemaTestVisitor(QAPISchemaVisitor):
> @@ -53,7 +52,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>              for v in variants.variants:
>                  print '    case %s: %s' % (v.name, v.type.name)
>
> -schema =3D QAPISchema(sys.argv[1])
> +parser =3D argparse.ArgumentParser()
> +parser.add_argument('schema',
> +                    help=3D'QAPI schema source file')
> +args =3D parser.parse_args()
> +
> +schema =3D QAPISchema(args.schema)
>  schema.visit(QAPISchemaTestVisitor())
>
>  for doc in schema.docs:
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
