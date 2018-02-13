Received: from eggs.gnu.org ([2001:4830:134:3::10]:47542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elcSG-0004cK-7f
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elcS7-0001YA-1A
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:25:09 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1elcS6-0001Xs-R5
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:25:02 -0500
Received: by mail-qk0-f196.google.com with SMTP id b130so5750152qkg.9
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:25:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-19-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-19-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 16:25:01 +0100
Message-ID: <CAMxuvayUp0k6bxAPWmHf3ZKiRgBEtqKyUT-R8nHj0c9deGTPVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 18/29] qapi: Rename generated
 qmp-marshal.c to qmp-commands.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>

On Sun, Feb 11, 2018 at 10:35 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> All generated .c are named like their .h, except for qmp-marshal.c and
> qmp-commands.h.  To add to the confusion, tests-qmp-commands.c falsely
> matches generated test-qmp-commands.h.
>
> Get rid of this unnecessary complication.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

that makes more sense,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  .gitignore                                     |  3 +--
>  Makefile                                       |  6 +++---
>  Makefile.objs                                  |  2 +-
>  docs/devel/qapi-code-gen.txt                   |  6 +++---
>  qga/Makefile.objs                              |  2 +-
>  scripts/qapi/commands.py                       |  2 +-
>  tests/.gitignore                               |  5 ++---
>  tests/Makefile.include                         | 10 +++++-----
>  tests/{test-qmp-commands.c =3D> test-qmp-cmds.c} |  0
>  9 files changed, 17 insertions(+), 19 deletions(-)
>  rename tests/{test-qmp-commands.c =3D> test-qmp-cmds.c} (100%)
>
> diff --git a/.gitignore b/.gitignore
> index 2f9a92f6cc..7d783e6e66 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -33,9 +33,8 @@
>  /qapi-visit.[ch]
>  /qapi-event.[ch]
>  /qapi-doc.texi
> -/qmp-commands.h
> +/qmp-commands.[ch]
>  /qmp-introspect.[ch]
> -/qmp-marshal.c
>  /qemu-doc.html
>  /qemu-doc.info
>  /qemu-doc.txt
> diff --git a/Makefile b/Makefile
> index bd781c6aad..164a38578e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -91,7 +91,7 @@ include $(SRC_PATH)/rules.mak
>
>  GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
>  GENERATED_FILES +=3D qmp-commands.h qapi-types.h qapi-visit.h qapi-event=
.h
> -GENERATED_FILES +=3D qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.=
c
> +GENERATED_FILES +=3D qmp-commands.c qapi-types.c qapi-visit.c qapi-event=
.c
>  GENERATED_FILES +=3D qmp-introspect.h
>  GENERATED_FILES +=3D qmp-introspect.c
>  GENERATED_FILES +=3D qapi-doc.texi
> @@ -496,7 +496,7 @@ $(SRC_PATH)/scripts/qapi-gen.py
>
>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
\
>  qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h =
\
> -qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal=
.c \
> +qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-command=
s.c \
>  qga/qapi-generated/qga-qapi-doc.texi: \
>  qga/qapi-generated/qapi-gen-timestamp ;
>  qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json =
$(qapi-py)
> @@ -522,7 +522,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
>
>  qapi-types.c qapi-types.h \
>  qapi-visit.c qapi-visit.h \
> -qmp-commands.h qmp-marshal.c \
> +qmp-commands.h qmp-commands.c \
>  qapi-event.c qapi-event.h \
>  qmp-introspect.h qmp-introspect.c \
>  qapi-doc.texi: \
> diff --git a/Makefile.objs b/Makefile.objs
> index 2efba6d768..d255aaf194 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -78,7 +78,7 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
>  ######################################################################
>  # qapi
>
> -common-obj-y +=3D qmp-marshal.o
> +common-obj-y +=3D qmp-commands.o
>  common-obj-y +=3D qmp-introspect.o
>  common-obj-y +=3D qmp.o hmp.o
>  endif
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 1a1cbaea7b..ba1dc73298 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1147,8 +1147,8 @@ declares qmp_COMMAND() that the user must implement=
.
>
>  The following files are generated:
>
> -$(prefix)qmp-marshal.c: Command marshal/dispatch functions for each
> -                        QMP command defined in the schema
> +$(prefix)qmp-commands.c: Command marshal/dispatch functions for each
> +                         QMP command defined in the schema
>
>  $(prefix)qmp-commands.h: Function prototypes for the QMP commands
>                           specified in the schema
> @@ -1170,7 +1170,7 @@ Example:
>      void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp=
);
>
>      #endif
> -    $ cat qapi-generated/example-qmp-marshal.c
> +    $ cat qapi-generated/example-qmp-commands.c
>  [Uninteresting stuff omitted...]
>
>      static void qmp_marshal_output_UserDefOne(UserDefOne *ret_in, QObjec=
t **ret_out, Error **errp)
> diff --git a/qga/Makefile.objs b/qga/Makefile.objs
> index 1c5986c0bb..6151378ae4 100644
> --- a/qga/Makefile.objs
> +++ b/qga/Makefile.objs
> @@ -3,6 +3,6 @@ qga-obj-$(CONFIG_POSIX) +=3D commands-posix.o channel-pos=
ix.o
>  qga-obj-$(CONFIG_WIN32) +=3D commands-win32.o channel-win32.o service-wi=
n32.o
>  qga-obj-$(CONFIG_WIN32) +=3D vss-win32.o
>  qga-obj-y +=3D qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-v=
isit.o
> -qga-obj-y +=3D qapi-generated/qga-qmp-marshal.o
> +qga-obj-y +=3D qapi-generated/qga-qmp-commands.o
>
>  qga-vss-dll-obj-$(CONFIG_QGA_VSS) +=3D vss-win32/
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index a744611d58..05fe33a03b 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -289,5 +289,5 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
>      schema.visit(vis)
>      genc.add(vis.defn)
>      genh.add(vis.decl)
> -    genc.write(output_dir, prefix + 'qmp-marshal.c')
> +    genc.write(output_dir, prefix + 'qmp-commands.c')
>      genh.write(output_dir, prefix + 'qmp-commands.h')
> diff --git a/tests/.gitignore b/tests/.gitignore
> index e5c744b7ed..2629cfc2f9 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -70,13 +70,12 @@ test-qdist
>  test-qga
>  test-qht
>  test-qht-par
> -test-qmp-commands
> -test-qmp-commands.h
> +test-qmp-cmds
> +test-qmp-commands.[ch]
>  test-qmp-event
>  test-qobject-input-strict
>  test-qobject-input-visitor
>  test-qmp-introspect.[ch]
> -test-qmp-marshal.c
>  test-qobject-output-visitor
>  test-rcu-list
>  test-replication
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b406531b34..9a21ed7ee9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -61,8 +61,8 @@ check-unit-y +=3D tests/test-clone-visitor$(EXESUF)
>  gcov-files-test-clone-visitor-y =3D qapi/qapi-clone-visitor.c
>  check-unit-y +=3D tests/test-qobject-input-visitor$(EXESUF)
>  gcov-files-test-qobject-input-visitor-y =3D qapi/qobject-input-visitor.c
> -check-unit-y +=3D tests/test-qmp-commands$(EXESUF)
> -gcov-files-test-qmp-commands-y =3D qapi/qmp-dispatch.c
> +check-unit-y +=3D tests/test-qmp-cmds$(EXESUF)
> +gcov-files-test-qmp-cmds-y =3D qapi/qmp-dispatch.c
>  check-unit-y +=3D tests/test-string-input-visitor$(EXESUF)
>  gcov-files-test-string-input-visitor-y =3D qapi/string-input-visitor.c
>  check-unit-y +=3D tests/test-string-output-visitor$(EXESUF)
> @@ -576,7 +576,7 @@ test-obj-y =3D tests/check-qnum.o tests/check-qstring=
.o tests/check-qdict.o \
>         tests/test-string-input-visitor.o tests/test-qobject-output-visit=
or.o \
>         tests/test-clone-visitor.o \
>         tests/test-qobject-input-visitor.o \
> -       tests/test-qmp-commands.o tests/test-visitor-serialization.o \
> +       tests/test-qmp-cmds.o tests/test-visitor-serialization.o \
>         tests/test-x86-cpuid.o tests/test-mul64.o tests/test-int128.o \
>         tests/test-opts-visitor.o tests/test-qmp-event.o \
>         tests/rcutorture.o tests/test-rcu-list.o \
> @@ -656,7 +656,7 @@ tests/test-replication$(EXESUF): tests/test-replicati=
on.o $(test-util-obj-y) \
>
>  tests/test-qapi-types.c tests/test-qapi-types.h \
>  tests/test-qapi-visit.c tests/test-qapi-visit.h \
> -tests/test-qmp-commands.h tests/test-qmp-marshal.c \
> +tests/test-qmp-commands.h tests/test-qmp-commands.c \
>  tests/test-qapi-event.c tests/test-qapi-event.h \
>  tests/test-qmp-introspect.c tests/test-qmp-introspect.h: \
>  tests/test-qapi-gen-timestamp ;
> @@ -679,7 +679,7 @@ tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o=
 $(test-qapi-obj-y)
>  tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-vi=
sitor.o $(test-qapi-obj-y)
>  tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qap=
i-obj-y)
>  tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visi=
tor.o $(test-qapi-obj-y)
> -tests/test-qmp-commands$(EXESUF): tests/test-qmp-commands.o tests/test-q=
mp-marshal.o $(test-qapi-obj-y)
> +tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qmp-comma=
nds.o $(test-qapi-obj-y)
>  tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serializat=
ion.o $(test-qapi-obj-y)
>  tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-=
obj-y)
>
> diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-cmds.c
> similarity index 100%
> rename from tests/test-qmp-commands.c
> rename to tests/test-qmp-cmds.c
> --
> 2.13.6
>
