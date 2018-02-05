Received: from eggs.gnu.org ([2001:4830:134:3::10]:55292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eihI9-0003JA-D3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eihI5-0002gG-FQ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:58:41 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eihI5-0002fp-8q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:58:37 -0500
Received: by mail-qk0-f193.google.com with SMTP id m130so7645570qke.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:58:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-20-armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-20-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Mon, 5 Feb 2018 14:58:36 +0100
Message-ID: <CAMxuvazpETypS1XrNqjWpEkt+iQSko4GXjh2vj9dJJVaw4G=Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 19/21] qapi/types: Generate separate .h,
 .c for each module
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
> Our qapi-schema.json is composed of modules connected by include
> directives, but the generated code is monolithic all the same: one
> qapi-types.h with all the types, one qapi-visit.h with all the
> visitors, and so forth.  These monolithic headers get included all
> over the place.  In my "build everything" tree, adding a QAPI type
> recompiles about 4500 out of 4800 objects.
>
> Nobody would write such monolithic headers by hand.  It stands to
> reason that one shouldn't generate them, either.
>
> Split up generated qapi-types.h to mirror the schema's modular
> structure: one header per module.  Name the main module's header
> qapi-types.h, and sub-module D/B.json's header D/qapi-types-B.h.
>
> Mirror the schema's includes in the headers, so that qapi-types.h gets
> you everything exactly as before.  If you need less, you can include
> one or more of the sub-module headers.  To be exploited shortly.
>
> Split up qapi-types.c similarly.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Most of the necessary split work is done in previous patch, this enables it=
:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  Makefile              | 30 ++++++++++++++++++++++++++++++
>  Makefile.objs         | 18 +++++++++++++++++-
>  scripts/qapi/types.py | 18 ++++++++++++++++--
>  3 files changed, 63 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f9b7900330..f1b68dca9b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -91,6 +91,21 @@ GENERATED_FILES =3D qemu-version.h config-host.h qemu-=
options.def
>  GENERATED_FILES +=3D qmp-commands.h qmp-marshal.c
>  GENERATED_FILES +=3D qapi-builtin-types.h qapi-builtin-types.c
>  GENERATED_FILES +=3D qapi-types.h qapi-types.c
> +GENERATED_FILES +=3D qapi/qapi-types-block-core.h qapi/qapi-types-block-=
core.c
> +GENERATED_FILES +=3D qapi/qapi-types-block.h qapi/qapi-types-block.c
> +GENERATED_FILES +=3D qapi/qapi-types-char.h qapi/qapi-types-char.c
> +GENERATED_FILES +=3D qapi/qapi-types-common.h qapi/qapi-types-common.c
> +GENERATED_FILES +=3D qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
> +GENERATED_FILES +=3D qapi/qapi-types-introspect.h qapi/qapi-types-intros=
pect.c
> +GENERATED_FILES +=3D qapi/qapi-types-migration.h qapi/qapi-types-migrati=
on.c
> +GENERATED_FILES +=3D qapi/qapi-types-net.h qapi/qapi-types-net.c
> +GENERATED_FILES +=3D qapi/qapi-types-rocker.h qapi/qapi-types-rocker.c
> +GENERATED_FILES +=3D qapi/qapi-types-run-state.h qapi/qapi-types-run-sta=
te.c
> +GENERATED_FILES +=3D qapi/qapi-types-sockets.h qapi/qapi-types-sockets.c
> +GENERATED_FILES +=3D qapi/qapi-types-tpm.h qapi/qapi-types-tpm.c
> +GENERATED_FILES +=3D qapi/qapi-types-trace.h qapi/qapi-types-trace.c
> +GENERATED_FILES +=3D qapi/qapi-types-transaction.h qapi/qapi-types-trans=
action.c
> +GENERATED_FILES +=3D qapi/qapi-types-ui.h qapi/qapi-types-ui.c
>  GENERATED_FILES +=3D qapi-builtin-visit.h qapi-builtin-visit.c
>  GENERATED_FILES +=3D qapi-visit.h qapi-visit.c
>  GENERATED_FILES +=3D qapi-event.h qapi-event.c
> @@ -519,6 +534,21 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_=
PATH)/qapi/common.json \
>
>  qapi-builtin-types.c qapi-builtin-types.h \
>  qapi-types.c qapi-types.h \
> +qapi/qapi-types-block-core.c qapi/qapi-types-block-core.h \
> +qapi/qapi-types-block.c qapi/qapi-types-block.h \
> +qapi/qapi-types-char.c qapi/qapi-types-char.h \
> +qapi/qapi-types-common.c qapi/qapi-types-common.h \
> +qapi/qapi-types-crypto.c qapi/qapi-types-crypto.h \
> +qapi/qapi-types-introspect.c qapi/qapi-types-introspect.h \
> +qapi/qapi-types-migration.c qapi/qapi-types-migration.h \
> +qapi/qapi-types-net.c qapi/qapi-types-net.h \
> +qapi/qapi-types-rocker.c qapi/qapi-types-rocker.h \
> +qapi/qapi-types-run-state.c qapi/qapi-types-run-state.h \
> +qapi/qapi-types-sockets.c qapi/qapi-types-sockets.h \
> +qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
> +qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
> +qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
> +qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
>  qapi-builtin-visit.c qapi-builtin-visit.h \
>  qapi-visit.c qapi-visit.h \
>  qmp-commands.h qmp-marshal.c \
> diff --git a/Makefile.objs b/Makefile.objs
> index f16cca06e7..e7411a2658 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -3,7 +3,23 @@
>  stub-obj-y =3D stubs/ crypto/
>  util-obj-y =3D util/ qobject/ qapi/
>  util-obj-y +=3D qapi-builtin-types.o qapi-builtin-visit.o
> -util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
> +util-obj-y +=3D qapi-types.o
> +util-obj-y +=3D qapi/qapi-types-block-core.o
> +util-obj-y +=3D qapi/qapi-types-block.o
> +util-obj-y +=3D qapi/qapi-types-char.o
> +util-obj-y +=3D qapi/qapi-types-common.o
> +util-obj-y +=3D qapi/qapi-types-crypto.o
> +util-obj-y +=3D qapi/qapi-types-introspect.o
> +util-obj-y +=3D qapi/qapi-types-migration.o
> +util-obj-y +=3D qapi/qapi-types-net.o
> +util-obj-y +=3D qapi/qapi-types-rocker.o
> +util-obj-y +=3D qapi/qapi-types-run-state.o
> +util-obj-y +=3D qapi/qapi-types-sockets.o
> +util-obj-y +=3D qapi/qapi-types-tpm.o
> +util-obj-y +=3D qapi/qapi-types-trace.o
> +util-obj-y +=3D qapi/qapi-types-transaction.o
> +util-obj-y +=3D qapi/qapi-types-ui.o
> +util-obj-y +=3D qmp-introspect.o qapi-visit.o qapi-event.o
>
>  chardev-obj-y =3D chardev/
>
> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
> index f84ed17960..7bd8e1a978 100644
> --- a/scripts/qapi/types.py
> +++ b/scripts/qapi/types.py
> @@ -172,6 +172,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          self._opt_builtins =3D opt_builtins
>          self._prefix =3D prefix
>          self._module =3D {}
> +        self._main_module =3D None
>          self._add_module(None, ' * Built-in QAPI types')
>          self._genc.preamble(mcgen('''
>  #include "qemu/osdep.h"
> @@ -186,7 +187,11 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>      def _module_basename(self, name):
>          if name is None:
>              return 'qapi-builtin-types'
> -        return self._prefix + 'qapi-types'
> +        basename =3D os.path.join(os.path.dirname(name),
> +                                self._prefix + 'qapi-types')
> +        if name =3D=3D self._main_module:
> +            return basename
> +        return basename + '-' + os.path.splitext(os.path.basename(name))=
[0]
>
>      def _add_module(self, name, blurb):
>          genc =3D QAPIGenC(blurb, __doc__)
> @@ -211,7 +216,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>          objects_seen.add(schema.the_empty_object_type.name)
>
>      def visit_module(self, name):
> -        if len(self._module) !=3D 1:
> +        if self._main_module is None:
> +            self._main_module =3D name
> +        if name in self._module:
> +            self._set_module(name)
>              return
>          self._add_module(name, ' * Schema-defined QAPI types')
>          self._genc.preamble(mcgen('''
> @@ -225,6 +233,12 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
>  #include "qapi-builtin-types.h"
>  '''))
>
> +    def visit_include(self, name, info):
> +        self._genh.preamble(mcgen('''
> +#include "%(basename)s.h"
> +''',
> +                                  basename=3Dself._module_basename(name)=
))
> +
>      def _gen_type_cleanup(self, name):
>          self._genh.body(gen_type_cleanup_decl(name))
>          self._genc.body(gen_type_cleanup(name))
> --
> 2.13.6
>
