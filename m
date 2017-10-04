Received: from eggs.gnu.org ([2001:4830:134:3::10]:60644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhU0-00039k-9C
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhTy-000207-EM
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:04:56 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:53692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhTy-0001zu-7z
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:04:54 -0400
Received: by mail-oi0-x233.google.com with SMTP id j126so18924398oia.10
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 04:04:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-11-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-11-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 13:04:51 +0200
Message-ID: <CAJ+F1C+=qrk4H-aNHw8Q_G1On3WxU3SN=bYGYK9BShLeo=9wMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 10/32] qapi: Don't run generators twice
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
> The generators always generate both .c and .h, but they can route one
> of them to the bit bucket.  We run them twice, once to generate .c,
> and once to generate .h.  Probably because the naive make rule
>
>     FOO.c FOO.h: qapi-schema.json
>         RECIPE
>
> runs RECIPE twice, once to generate FOO.c and once to generate FOO.h.
>
> Employ the usual make trick to generate multiple files in one rule:
>
>     .INTERMEDIATE: FOO-gen
>     FOO.c FOO.h: FOO-gen ;
>     FOO-gen: qapi-schema.json
>         RECIPE
>
> When make needs FOO.c or FOO.h, it runs RECIPE once to generate
> intermediate target FOO-gen, then considers both FOO.c and FOO.h
> updated.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

As explained in the following stackoverflow answer:
https://stackoverflow.com/a/10609434/1277510

Nice
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  Makefile               | 58 +++++++++++++++++++++++++++++++++-----------=
------
>  Makefile.objs          |  2 +-
>  tests/Makefile.include | 36 +++++++++++++++++++++----------
>  3 files changed, 64 insertions(+), 32 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index cee6e28659..784b601247 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -384,24 +384,33 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC=
_PATH)/scripts/hxtool
>  qemu-ga$(EXESUF): LIBS =3D $(LIBS_QGA)
>  qemu-ga$(EXESUF): QEMU_CFLAGS +=3D -I qga/qapi-generated
>
> -gen-out-type =3D $(subst .,-,$(suffix $@))
> -
>  qapi-py =3D $(SRC_PATH)/scripts/qapi.py $(SRC_PATH)/scripts/ordereddict.=
py
>
> +.INTERMEDIATE: qga/qapi-generated/qga-qapi-types-gen
>  qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
:\
> +qga/qapi-generated/qga-qapi-types-gen ;
> +qga/qapi-generated/qga-qapi-types-gen: \
>  $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-types.py $(qap=
i-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py =
\
> -               $(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
> +               -o $(dir $@) -p "qga-" $<, \
>                 "GEN","$@")
> +
> +.INTERMEDIATE: qga/qapi-generated/qga-qapi-visit-gen
>  qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h =
:\
> +qga/qapi-generated/qga-qapi-visit-gen ;
> +qga/qapi-generated/qga-qapi-visit-gen: \
>  $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-visit.py $(qap=
i-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py =
\
> -               $(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
> +               -o $(dir $@) -p "qga-" $<, \
>                 "GEN","$@")
> +
> +.INTERMEDIATE: qga/qapi-generated/qga-qapi-commands-gen
>  qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-marshal=
.c :\
> +qga/qapi-generated/qga-qapi-commands-gen ;
> +qga/qapi-generated/qga-qapi-commands-gen: \
>  $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/qapi-commands.py $(=
qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.=
py \
> -               $(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
> +               -o $(dir $@) -p "qga-" $<, \
>                 "GEN","$@")
>
>  qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
> @@ -419,30 +428,39 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC=
_PATH)/qapi/common.json \
>                 $(SRC_PATH)/qapi/transaction.json \
>                 $(SRC_PATH)/qapi/ui.json
>
> -qapi-types.c qapi-types.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
> +.INTERMEDIATE: qapi-types-gen
> +qapi-types.c qapi-types.h: qapi-types-gen ;
> +qapi-types-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi=
-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py =
\
> -               $(gen-out-type) -o "." -b $<, \
> +               -b $<, \
>                 "GEN","$@")
> -qapi-visit.c qapi-visit.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
> +
> +.INTERMEDIATE: qapi-visit-gen
> +qapi-visit.c qapi-visit.h: qapi-visit-gen ;
> +qapi-visit-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi=
-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py =
\
> -               $(gen-out-type) -o "." -b $<, \
> +               -b $<, \
>                 "GEN","$@")
> -qapi-event.c qapi-event.h :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
> +
> +.INTERMEDIATE: qapi-event-gen
> +qapi-event.c qapi-event.h: qapi-event-gen
> +qapi-event-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi=
-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py =
\
> -               $(gen-out-type) -o "." $<, \
> +               $<, \
>                 "GEN","$@")
> -qmp-commands.h qmp-marshal.c :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
> +
> +.INTERMEDIATE: qapi-commands-gen
> +qmp-commands.h qmp-marshal.c: qapi-commands-gen
> +qapi-commands-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py =
$(qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.=
py \
> -               $(gen-out-type) -o "." $<, \
> +               $<, \
>                 "GEN","$@")
> -qmp-introspect.h qmp-introspect.c :\
> -$(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
> +
> +.INTERMEDIATE: qapi-introspect-gen
> +qmp-introspect.h qmp-introspect.c: qapi-introspect-gen
> +qapi-introspect-gen: $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect=
.py $(qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspec=
t.py \
> -               $(gen-out-type) -o "." $<, \
> +               $<, \
>                 "GEN","$@")
>
>  QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
> diff --git a/Makefile.objs b/Makefile.objs
> index bdfa3b6177..cc4f94d77a 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -2,7 +2,7 @@
>  # Common libraries for tools and emulators
>  stub-obj-y =3D stubs/ crypto/
>  util-obj-y =3D util/ qobject/ qapi/
> -util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
> +util-obj-y +=3D qapi-types.o qapi-visit.o qapi-event.o
>
>  chardev-obj-y =3D chardev/
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index de4a713c25..5d53c58506 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -626,30 +626,44 @@ tests/test-logging$(EXESUF): tests/test-logging.o $=
(test-util-obj-y)
>  tests/test-replication$(EXESUF): tests/test-replication.o $(test-util-ob=
j-y) \
>         $(test-block-obj-y)
>
> -tests/test-qapi-types.c tests/test-qapi-types.h :\
> +.INTERMEDIATE: tests/test-qapi-types-gen
> +tests/test-qapi-types.c tests/test-qapi-types.h: tests/test-qapi-types-g=
en ;
> +tests/test-qapi-types-gen: \
>  $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-types.py $(qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py =
\
> -               $(gen-out-type) -o tests -p "test-" $<, \
> +               -o tests -p "test-" $<, \
>                 "GEN","$@")
> -tests/test-qapi-visit.c tests/test-qapi-visit.h :\
> +
> +.INTERMEDIATE: tests/test-qapi-visit-gen
> +tests/test-qapi-visit.c tests/test-qapi-visit.h: tests/test-qapi-visit-g=
en ;
> +tests/test-qapi-visit-gen: \
>  $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-visit.py $(qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py =
\
> -               $(gen-out-type) -o tests -p "test-" $<, \
> +               -o tests -p "test-" $<, \
>                 "GEN","$@")
> -tests/test-qmp-commands.h tests/test-qmp-marshal.c :\
> +
> +.INTERMEDIATE: tests/test-qapi-commands-gen
> +tests/test-qmp-commands.h tests/test-qmp-marshal.c: tests/test-qapi-comm=
ands-gen ;
> +tests/test-qapi-commands-gen: \
>  $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-commands.py $(qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.=
py \
> -               $(gen-out-type) -o tests -p "test-" $<, \
> +               -o tests -p "test-" $<, \
>                 "GEN","$@")
> -tests/test-qapi-event.c tests/test-qapi-event.h :\
> +
> +.INTERMEDIATE: tests/test-qapi-event-gen
> +tests/test-qapi-event.c tests/test-qapi-event.h: tests/test-qapi-event-g=
en ;
> +tests/test-qapi-event-gen: \
>  $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-event.py $(qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py =
\
> -               $(gen-out-type) -o tests -p "test-" $<, \
> +               -o tests -p "test-" $<, \
>                 "GEN","$@")
> -tests/test-qmp-introspect.c tests/test-qmp-introspect.h :\
> +
> +.INTERMEDIATE: tests/test-qapi-introspect-gen
> +tests/test-qmp-introspect.c tests/test-qmp-introspect.h: tests/test-qapi=
-introspect-gen ;
> +tests/test-qapi-introspect-gen: \
>  $(SRC_PATH)/tests/qapi-schema/qapi-schema-test.json $(SRC_PATH)/scripts/=
qapi-introspect.py $(qapi-py)
>         $(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspec=
t.py \
> -               $(gen-out-type) -o tests -p "test-" $<, \
> +               -o tests -p "test-" $<, \
>                 "GEN","$@")
>
>  tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(SRC_PATH)/scripts/qapi2texi.py $(qapi-py)
> @@ -660,7 +674,7 @@ tests/test-string-input-visitor$(EXESUF): tests/test-=
string-input-visitor.o $(te
>  tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-qapi-obj-y)
>  tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-vi=
sitor.o $(test-qapi-obj-y)
>  tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qap=
i-obj-y)
> -tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visi=
tor.o $(test-qapi-obj-y)
> +tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visi=
tor.o $(test-qapi-obj-y) qmp-introspect.o
>  tests/test-qmp-commands$(EXESUF): tests/test-qmp-commands.o tests/test-q=
mp-marshal.o $(test-qapi-obj-y)
>  tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serializat=
ion.o $(test-qapi-obj-y)
>  tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-=
obj-y)
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
