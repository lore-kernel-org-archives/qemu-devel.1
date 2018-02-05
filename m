Received: from eggs.gnu.org ([2001:4830:134:3::10]:52201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih4n-00007n-4L
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih4i-0002ZP-TX
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:53 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih4i-0002YM-NE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:48 -0500
Received: by mail-qk0-f196.google.com with SMTP id m130so7589618qke.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:44:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-4-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-4-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:44:47 +0100
Message-ID: <CAMxuvaxLJ2TRXBeFRjF=-RP6dMcfXY1F-Hf+2YvMm9Jpoh+D4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 03/21] qapi: New classes QAPIGenC,
 QAPIGenH, QAPIGenDoc
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

Hi

On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> These classes encapsulate accumulating and writing output.
>
> Convert C code generation to QAPIGenC and QAPIGenH.  The conversion is
> rather shallow: most of the output accumulation is not converted.
> Left for later.
>
> The indentation machinery uses a single global variable indent_level,
> even though we generally interleave creation of a .c and its .h.  It
> should become instance variable of QAPIGenC.  Also left for later.
>
> Documentation generation isn't converted, and QAPIGenDoc isn't used.
> This will change shortly.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi-commands.py   | 27 ++++++-------
>  scripts/qapi-event.py      | 26 +++++++------
>  scripts/qapi-introspect.py | 22 ++++++-----
>  scripts/qapi-types.py      | 26 +++++++------
>  scripts/qapi-visit.py      | 26 +++++++------
>  scripts/qapi.py            | 96 ++++++++++++++++++++++++++--------------=
------
>  6 files changed, 122 insertions(+), 101 deletions(-)
>
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index a861ac52e7..4be7dbc482 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -260,12 +260,10 @@ blurb =3D '''
>   * Schema-defined QAPI/QMP commands
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> -                            'qmp-marshal.c', 'qmp-commands.h',
> -                            blurb, __doc__)
> -
> -fdef.write(mcgen('''
> +genc =3D QAPIGenC(blurb, __doc__)
> +genh =3D QAPIGenH(blurb, __doc__)
>
> +genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/module.h"
> @@ -279,21 +277,24 @@ fdef.write(mcgen('''
>  #include "%(prefix)sqmp-commands.h"
>
>  ''',
> -                 prefix=3Dprefix))
> +                prefix=3Dprefix))
>
> -fdecl.write(mcgen('''
> +genh.body(mcgen('''
>  #include "%(prefix)sqapi-types.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/dispatch.h"
>
>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>  ''',
> -                  prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DF=
alse)))
> +                prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DFal=
se)))
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenCommandVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenCommandVisitor()
> +schema.visit(vis)
> +genc.body(vis.defn)
> +genh.body(vis.decl)
>
> -close_output(fdef, fdecl)
> +if do_c:
> +    genc.write(output_dir, prefix + 'qmp-marshal.c')
> +if do_h:
> +    genh.write(output_dir, prefix + 'qmp-commands.h')
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index b1d611c5ea..da3de17c76 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -176,11 +176,10 @@ blurb =3D '''
>   * Schema-defined QAPI/QMP events
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> -                            'qapi-event.c', 'qapi-event.h',
> -                            blurb, __doc__)
> +genc =3D QAPIGenC(blurb, __doc__)
> +genh =3D QAPIGenH(blurb, __doc__)
>
> -fdef.write(mcgen('''
> +genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "%(prefix)sqapi-event.h"
> @@ -190,22 +189,25 @@ fdef.write(mcgen('''
>  #include "qapi/qmp-event.h"
>
>  ''',
> -                 prefix=3Dprefix))
> +                prefix=3Dprefix))
>
> -fdecl.write(mcgen('''
> +genh.body(mcgen('''
>  #include "qapi/util.h"
>  #include "qapi/qmp/qdict.h"
>  #include "%(prefix)sqapi-types.h"
>
>  ''',
> -                  prefix=3Dprefix))
> +                prefix=3Dprefix))
>
>  event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenEventVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenEventVisitor()
> +schema.visit(vis)
> +genc.body(vis.defn)
> +genh.body(vis.decl)
>
> -close_output(fdef, fdecl)
> +if do_c:
> +    genc.write(output_dir, prefix + 'qapi-event.c')
> +if do_h:
> +    genh.write(output_dir, prefix + 'qapi-event.h')
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index bd9253a172..c654f8fa94 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -181,21 +181,23 @@ blurb =3D '''
>   * QAPI/QMP schema introspection
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> -                            'qmp-introspect.c', 'qmp-introspect.h',
> -                            blurb, __doc__)
> +genc =3D QAPIGenC(blurb, __doc__)
> +genh =3D QAPIGenH(blurb, __doc__)
>
> -fdef.write(mcgen('''
> +genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "%(prefix)sqmp-introspect.h"
>
>  ''',
> -                 prefix=3Dprefix))
> +                prefix=3Dprefix))
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
> +schema.visit(vis)
> +genc.body(vis.defn)
> +genh.body(vis.decl)
>
> -close_output(fdef, fdecl)
> +if do_c:
> +    genc.write(output_dir, prefix + 'qmp-introspect.c')
> +if do_h:
> +    genh.write(output_dir, prefix + 'qmp-introspect.h')
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index 1103dbda2d..97406b3368 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -180,7 +180,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          self.decl =3D ''
>          self.defn =3D ''
>          self._fwdecl =3D ''
> -        self._btin =3D guardstart('QAPI_TYPES_BUILTIN')
> +        self._btin =3D '\n' + guardstart('QAPI_TYPES_BUILTIN')
>
>      def visit_end(self):
>          self.decl =3D self._fwdecl + self.decl
> @@ -256,26 +256,28 @@ blurb =3D '''
>   * Schema-defined QAPI types
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> -                            'qapi-types.c', 'qapi-types.h',
> -                            blurb, __doc__)
> +genc =3D QAPIGenC(blurb, __doc__)
> +genh =3D QAPIGenH(blurb, __doc__)
>
> -fdef.write(mcgen('''
> +genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qapi/dealloc-visitor.h"
>  #include "%(prefix)sqapi-types.h"
>  #include "%(prefix)sqapi-visit.h"
>  ''',
> -                 prefix=3Dprefix))
> +                prefix=3Dprefix))
>
> -fdecl.write(mcgen('''
> +genh.body(mcgen('''
>  #include "qapi/util.h"
>  '''))
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenTypeVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenTypeVisitor()
> +schema.visit(vis)
> +genc.body(vis.defn)
> +genh.body(vis.decl)
>
> -close_output(fdef, fdecl)
> +if do_c:
> +    genc.write(output_dir, prefix + 'qapi-types.c')
> +if do_h:
> +    genh.write(output_dir, prefix + 'qapi-types.h')
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 5231f89c36..d1b25daf0d 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -339,30 +339,32 @@ blurb =3D '''
>   * Schema-defined QAPI visitors
>  '''
>
> -(fdef, fdecl) =3D open_output(output_dir, do_c, do_h, prefix,
> -                            'qapi-visit.c', 'qapi-visit.h',
> -                            blurb, __doc__)
> +genc =3D QAPIGenC(blurb, __doc__)
> +genh =3D QAPIGenH(blurb, __doc__)
>
> -fdef.write(mcgen('''
> +genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qapi/error.h"
>  #include "%(prefix)sqapi-visit.h"
>  ''',
> -                 prefix=3Dprefix))
> +                prefix=3Dprefix))
>
> -fdecl.write(mcgen('''
> +genh.body(mcgen('''
>  #include "qapi/visitor.h"
>  #include "qapi/qmp/qerror.h"
>  #include "%(prefix)sqapi-types.h"
>
>  ''',
> -                  prefix=3Dprefix))
> +                prefix=3Dprefix))
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenVisitVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenVisitVisitor()
> +schema.visit(vis)
> +genc.body(vis.defn)
> +genh.body(vis.decl)
>
> -close_output(fdef, fdecl)
> +if do_c:
> +    genc.write(output_dir, prefix + 'qapi-visit.c')
> +if do_h:
> +    genh.write(output_dir, prefix + 'qapi-visit.h')
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index d0816f7479..d73ef618e2 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -2,7 +2,7 @@
>  # QAPI helper library
>  #
>  # Copyright IBM, Corp. 2011
> -# Copyright (c) 2013-2016 Red Hat Inc.
> +# Copyright (c) 2013-2018 Red Hat Inc.
>  #
>  # Authors:
>  #  Anthony Liguori <aliguori@us.ibm.com>
> @@ -1820,7 +1820,6 @@ def guardname(filename):
>
>  def guardstart(name):
>      return mcgen('''
> -
>  #ifndef %(name)s
>  #define %(name)s
>
> @@ -1832,7 +1831,6 @@ def guardend(name):
>      return mcgen('''
>
>  #endif /* %(name)s */
> -
>  ''',
>                   name=3Dguardname(name))
>
> @@ -1970,17 +1968,53 @@ def parse_command_line(extra_options=3D'', extra_=
long_options=3D[]):
>
>      return (fname, output_dir, do_c, do_h, prefix, extra_opts)
>
> +
>  #
> -# Generate output files with boilerplate
> +# Accumulate and write output
>  #
>
> +class QAPIGen(object):
> +
> +    def __init__(self):
> +        self._preamble =3D ''
> +        self._body =3D ''
> +
> +    def preamble(self, text):
> +        self._preamble +=3D text
> +
> +    def body(self, text):
> +        self._body +=3D text
> +
> +    def top(self, fname):
> +        return ''
> +
> +    def bottom(self, fname):
> +        return ''
> +

Some methods appends, other return. That's a bit confusing. Why not
name them accordingly? add_preamble, add_body, get_top...?

> +    def write(self, output_dir, fname):
> +        if output_dir:
> +            try:
> +                os.makedirs(output_dir)
> +            except os.error as e:
> +                if e.errno !=3D errno.EEXIST:
> +                    raise
> +        f =3D open(os.path.join(output_dir, fname), 'w')
> +        f.write(self.top(fname) + self._preamble + self._body
> +                + self.bottom(fname))
> +        f.close()
> +
> +
> +class QAPIGenC(QAPIGen):
> +
> +    def __init__(self, blurb, pydoc):
> +        QAPIGen.__init__(self)
> +        self._blurb =3D blurb.strip('\n')
> +        self._copyright =3D '\n * '.join(re.findall(r'^Copyright .*', py=
doc,
> +                                                  re.MULTILINE))
>
> -def open_output(output_dir, do_c, do_h, prefix, c_file, h_file, blurb, d=
oc):
> -    guard =3D guardname(prefix + h_file)
> -    c_file =3D output_dir + prefix + c_file
> -    h_file =3D output_dir + prefix + h_file
> -    copyright =3D '\n * '.join(re.findall(r'^Copyright .*', doc, re.MULT=
ILINE))
> -    comment =3D mcgen('''/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
> +    def top(self, fname):
> +        return mcgen('''
> +/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
>
>  /*
>  %(blurb)s
> @@ -1992,41 +2026,19 @@ def open_output(output_dir, do_c, do_h, prefix, c=
_file, h_file, blurb, doc):
>   */
>
>  ''',
> -                    blurb=3Dblurb.strip('\n'), copyright=3Dcopyright)
> +                     blurb=3Dself._blurb, copyright=3Dself._copyright)
>
> -    if output_dir:
> -        try:
> -            os.makedirs(output_dir)
> -        except os.error as e:
> -            if e.errno !=3D errno.EEXIST:
> -                raise
>
> -    def maybe_open(really, name, opt):
> -        if really:
> -            return open(name, opt)
> -        else:
> -            import StringIO
> -            return StringIO.StringIO()
> +class QAPIGenH(QAPIGenC):
>
> -    fdef =3D maybe_open(do_c, c_file, 'w')
> -    fdecl =3D maybe_open(do_h, h_file, 'w')
> +    def top(self, fname):
> +        return QAPIGenC.top(self, fname) + guardstart(fname)
>
> -    fdef.write(comment)
> -    fdecl.write(comment)
> -    fdecl.write(mcgen('''
> -#ifndef %(guard)s
> -#define %(guard)s
> +    def bottom(self, fname):
> +        return guardend(fname)
>
> -''',
> -                      guard=3Dguard))
>
> -    return (fdef, fdecl)
> -
> -
> -def close_output(fdef, fdecl):
> -    fdecl.write(mcgen('''
> -
> -#endif
> -'''))
> -    fdecl.close()
> -    fdef.close()
> +class QAPIGenDoc(QAPIGen):
> +    def top(self, fname):
> +        return (QAPIGen.top(self, fname)
> +                + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
> --
> 2.13.6
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
