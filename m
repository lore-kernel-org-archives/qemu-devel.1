Received: from eggs.gnu.org ([2001:4830:134:3::10]:52255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih4v-0000Hc-Uf
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eih4q-0002ll-BY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:02 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:42851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eih4q-0002lW-5H
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:56 -0500
Received: by mail-qk0-f172.google.com with SMTP id f68so12278899qke.9
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:44:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-6-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-6-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:44:54 +0100
Message-ID: <CAMxuvaxt0FYPjz6CeJ-VQoqtqDGULDzmMzyKSJ9uW0wbxj7JSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 05/21] qapi: Turn generators into
 modules
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
> The next commit will introduce a common driver program for all
> generators.  The generators need to be modules for that.  qapi2texi.py
> already is.  Make the other generators follow suit.
>
> The changes are actually trivial.  Obvious in the diffs once you view
> them with whitespace changes ignored.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi-commands.py   | 43 ++++++++++++++++++--------------
>  scripts/qapi-event.py      | 43 ++++++++++++++++++--------------
>  scripts/qapi-introspect.py | 54 ++++++++++++++++++++++------------------
>  scripts/qapi-types.py      | 56 ++++++++++++++++++++++------------------=
-
>  scripts/qapi-visit.py      | 62 +++++++++++++++++++++++++---------------=
------
>  5 files changed, 143 insertions(+), 115 deletions(-)
>
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index d229537659..331b58670e 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -255,16 +255,17 @@ class QAPISchemaGenCommandVisitor(QAPISchemaVisitor=
):
>          self._regy +=3D gen_register_command(name, success_response)
>
>
> -(input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command_lin=
e()
> +def main(argv):
> +    (input_file, output_dir, do_c, do_h, prefix, opts) =3D parse_command=
_line()
>
> -blurb =3D '''
> +    blurb =3D '''
>   * Schema-defined QAPI/QMP commands
>  '''
>
> -genc =3D QAPIGenC(blurb, __doc__)
> -genh =3D QAPIGenH(blurb, __doc__)
> +    genc =3D QAPIGenC(blurb, __doc__)
> +    genh =3D QAPIGenH(blurb, __doc__)
>
> -genc.body(mcgen('''
> +    genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qemu/module.h"
> @@ -278,24 +279,28 @@ genc.body(mcgen('''
>  #include "%(prefix)sqmp-commands.h"
>
>  ''',
> -                prefix=3Dprefix))
> +                    prefix=3Dprefix))
>
> -genh.body(mcgen('''
> +    genh.body(mcgen('''
>  #include "%(prefix)sqapi-types.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/dispatch.h"
>
>  void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
>  ''',
> -                prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DFal=
se)))
> -
> -schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenCommandVisitor(prefix)
> -schema.visit(vis)
> -genc.body(vis.defn)
> -genh.body(vis.decl)
> -
> -if do_c:
> -    genc.write(output_dir, prefix + 'qmp-marshal.c')
> -if do_h:
> -    genh.write(output_dir, prefix + 'qmp-commands.h')
> +                    prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=
=3DFalse)))
> +
> +    schema =3D QAPISchema(input_file)
> +    vis =3D QAPISchemaGenCommandVisitor(prefix)
> +    schema.visit(vis)
> +    genc.body(vis.defn)
> +    genh.body(vis.decl)
> +
> +    if do_c:
> +        genc.write(output_dir, prefix + 'qmp-marshal.c')
> +    if do_h:
> +        genh.write(output_dir, prefix + 'qmp-commands.h')
> +
> +
> +if __name__ =3D=3D '__main__':
> +    main(sys.argv)
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index 1af21b580a..5b33c694d4 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -171,16 +171,17 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
>          self._event_names.append(name)
>
>
> -(input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()
> +def main(argv):
> +    (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_comman=
d_line()
>
> -blurb =3D '''
> +    blurb =3D '''
>   * Schema-defined QAPI/QMP events
>  '''
>
> -genc =3D QAPIGenC(blurb, __doc__)
> -genh =3D QAPIGenH(blurb, __doc__)
> +    genc =3D QAPIGenC(blurb, __doc__)
> +    genh =3D QAPIGenH(blurb, __doc__)
>
> -genc.body(mcgen('''
> +    genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "%(prefix)sqapi-event.h"
> @@ -190,23 +191,27 @@ genc.body(mcgen('''
>  #include "qapi/qmp-event.h"
>
>  ''',
> -                prefix=3Dprefix))
> +                    prefix=3Dprefix))
>
> -genh.body(mcgen('''
> +    genh.body(mcgen('''
>  #include "qapi/util.h"
>  #include "qapi/qmp/qdict.h"
>  #include "%(prefix)sqapi-types.h"
>
>  ''',
> -                prefix=3Dprefix))
> -
> -schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenEventVisitor(prefix)
> -schema.visit(vis)
> -genc.body(vis.defn)
> -genh.body(vis.decl)
> -
> -if do_c:
> -    genc.write(output_dir, prefix + 'qapi-event.c')
> -if do_h:
> -    genh.write(output_dir, prefix + 'qapi-event.h')
> +                    prefix=3Dprefix))
> +
> +    schema =3D QAPISchema(input_file)
> +    vis =3D QAPISchemaGenEventVisitor(prefix)
> +    schema.visit(vis)
> +    genc.body(vis.defn)
> +    genh.body(vis.decl)
> +
> +    if do_c:
> +        genc.write(output_dir, prefix + 'qapi-event.c')
> +    if do_h:
> +        genh.write(output_dir, prefix + 'qapi-event.h')
> +
> +
> +if __name__ =3D=3D '__main__':
> +    main(sys.argv)
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index 8d4e3c1c3a..09e7d1f140 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -167,38 +167,44 @@ const char %(c_name)s[] =3D %(c_string)s;
>          arg_type =3D arg_type or self._schema.the_empty_object_type
>          self._gen_json(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
>
> -# Debugging aid: unmask QAPI schema's type names
> -# We normally mask them, because they're not QMP wire ABI
> -opt_unmask =3D False
>
> -(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> -    parse_command_line('u', ['unmask-non-abi-names'])
> +def main(argv):
> +    # Debugging aid: unmask QAPI schema's type names
> +    # We normally mask them, because they're not QMP wire ABI
> +    opt_unmask =3D False
>
> -for o, a in opts:
> -    if o in ('-u', '--unmask-non-abi-names'):
> -        opt_unmask =3D True
> +    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> +        parse_command_line('u', ['unmask-non-abi-names'])
>
> -blurb =3D '''
> +    for o, a in opts:
> +        if o in ('-u', '--unmask-non-abi-names'):
> +            opt_unmask =3D True
> +
> +    blurb =3D '''
>   * QAPI/QMP schema introspection
>  '''
>
> -genc =3D QAPIGenC(blurb, __doc__)
> -genh =3D QAPIGenH(blurb, __doc__)
> +    genc =3D QAPIGenC(blurb, __doc__)
> +    genh =3D QAPIGenH(blurb, __doc__)
>
> -genc.body(mcgen('''
> +    genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "%(prefix)sqmp-introspect.h"
>
>  ''',
> -                prefix=3Dprefix))
> -
> -schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
> -schema.visit(vis)
> -genc.body(vis.defn)
> -genh.body(vis.decl)
> -
> -if do_c:
> -    genc.write(output_dir, prefix + 'qmp-introspect.c')
> -if do_h:
> -    genh.write(output_dir, prefix + 'qmp-introspect.h')
> +                    prefix=3Dprefix))
> +
> +    schema =3D QAPISchema(input_file)
> +    vis =3D QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
> +    schema.visit(vis)
> +    genc.body(vis.defn)
> +    genh.body(vis.decl)
> +
> +    if do_c:
> +        genc.write(output_dir, prefix + 'qmp-introspect.c')
> +    if do_h:
> +        genh.write(output_dir, prefix + 'qmp-introspect.h')
> +
> +
> +if __name__ =3D=3D '__main__':
> +    main(sys.argv)
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index 2d711b137b..f2ddde94b1 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -240,45 +240,51 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          self.decl +=3D gen_object(name, None, [variants.tag_member], var=
iants)
>          self._gen_type_cleanup(name)
>
> -# If you link code generated from multiple schemata, you want only one
> -# instance of the code for built-in types.  Generate it only when
> -# opt_builtins, enabled by command line option -b.  See also
> -# QAPISchemaGenTypeVisitor.visit_end().
> -opt_builtins =3D False
>
> -(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> -    parse_command_line('b', ['builtins'])
> +def main(argv):
> +    # If you link code generated from multiple schemata, you want only o=
ne
> +    # instance of the code for built-in types.  Generate it only when
> +    # opt_builtins, enabled by command line option -b.  See also
> +    # QAPISchemaGenTypeVisitor.visit_end().
> +    opt_builtins =3D False
>
> -for o, a in opts:
> -    if o in ('-b', '--builtins'):
> -        opt_builtins =3D True
> +    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> +        parse_command_line('b', ['builtins'])
>
> -blurb =3D '''
> +    for o, a in opts:
> +        if o in ('-b', '--builtins'):
> +            opt_builtins =3D True
> +
> +    blurb =3D '''
>   * Schema-defined QAPI types
>  '''
>
> -genc =3D QAPIGenC(blurb, __doc__)
> -genh =3D QAPIGenH(blurb, __doc__)
> +    genc =3D QAPIGenC(blurb, __doc__)
> +    genh =3D QAPIGenH(blurb, __doc__)
>
> -genc.body(mcgen('''
> +    genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qapi/dealloc-visitor.h"
>  #include "%(prefix)sqapi-types.h"
>  #include "%(prefix)sqapi-visit.h"
>  ''',
> -                prefix=3Dprefix))
> +                    prefix=3Dprefix))
>
> -genh.body(mcgen('''
> +    genh.body(mcgen('''
>  #include "qapi/util.h"
>  '''))
>
> -schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenTypeVisitor(opt_builtins)
> -schema.visit(vis)
> -genc.body(vis.defn)
> -genh.body(vis.decl)
> +    schema =3D QAPISchema(input_file)
> +    vis =3D QAPISchemaGenTypeVisitor(opt_builtins)
> +    schema.visit(vis)
> +    genc.body(vis.defn)
> +    genh.body(vis.decl)
>
> -if do_c:
> -    genc.write(output_dir, prefix + 'qapi-types.c')
> -if do_h:
> -    genh.write(output_dir, prefix + 'qapi-types.h')
> +    if do_c:
> +        genc.write(output_dir, prefix + 'qapi-types.c')
> +    if do_h:
> +        genh.write(output_dir, prefix + 'qapi-types.h')
> +
> +
> +if __name__ =3D=3D '__main__':
> +    main(sys.argv)
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 79dc6cae48..473fa72574 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -323,49 +323,55 @@ class QAPISchemaGenVisitVisitor(QAPISchemaVisitor):
>          self.decl +=3D gen_visit_decl(name)
>          self.defn +=3D gen_visit_alternate(name, variants)
>
> -# If you link code generated from multiple schemata, you want only one
> -# instance of the code for built-in types.  Generate it only when
> -# opt_builtins, enabled by command line option -b.  See also
> -# QAPISchemaGenVisitVisitor.visit_end().
> -opt_builtins =3D False
>
> -(input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> -    parse_command_line('b', ['builtins'])
> +def main(argv):
> +    # If you link code generated from multiple schemata, you want only o=
ne
> +    # instance of the code for built-in types.  Generate it only when
> +    # opt_builtins, enabled by command line option -b.  See also
> +    # QAPISchemaGenVisitVisitor.visit_end().
> +    opt_builtins =3D False
>
> -for o, a in opts:
> -    if o in ('-b', '--builtins'):
> -        opt_builtins =3D True
> +    (input_file, output_dir, do_c, do_h, prefix, opts) =3D \
> +        parse_command_line('b', ['builtins'])
>
> -blurb =3D '''
> +    for o, a in opts:
> +        if o in ('-b', '--builtins'):
> +            opt_builtins =3D True
> +
> +    blurb =3D '''
>   * Schema-defined QAPI visitors
>  '''
>
> -genc =3D QAPIGenC(blurb, __doc__)
> -genh =3D QAPIGenH(blurb, __doc__)
> +    genc =3D QAPIGenC(blurb, __doc__)
> +    genh =3D QAPIGenH(blurb, __doc__)
>
> -genc.body(mcgen('''
> +    genc.body(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qapi/error.h"
>  #include "%(prefix)sqapi-visit.h"
>  ''',
> -                prefix=3Dprefix))
> +                    prefix=3Dprefix))
>
> -genh.body(mcgen('''
> +    genh.body(mcgen('''
>  #include "qapi/visitor.h"
>  #include "qapi/qmp/qerror.h"
>  #include "%(prefix)sqapi-types.h"
>
>  ''',
> -                prefix=3Dprefix))
> -
> -schema =3D QAPISchema(input_file)
> -vis =3D QAPISchemaGenVisitVisitor(opt_builtins)
> -schema.visit(vis)
> -genc.body(vis.defn)
> -genh.body(vis.decl)
> -
> -if do_c:
> -    genc.write(output_dir, prefix + 'qapi-visit.c')
> -if do_h:
> -    genh.write(output_dir, prefix + 'qapi-visit.h')
> +                    prefix=3Dprefix))
> +
> +    schema =3D QAPISchema(input_file)
> +    vis =3D QAPISchemaGenVisitVisitor(opt_builtins)
> +    schema.visit(vis)
> +    genc.body(vis.defn)
> +    genh.body(vis.decl)
> +
> +    if do_c:
> +        genc.write(output_dir, prefix + 'qapi-visit.c')
> +    if do_h:
> +        genh.write(output_dir, prefix + 'qapi-visit.h')
> +
> +
> +if __name__ =3D=3D '__main__':
> +    main(sys.argv)
> --
> 2.13.6
>
