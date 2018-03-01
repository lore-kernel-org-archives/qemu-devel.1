Received: from eggs.gnu.org ([2001:4830:134:3::10]:41065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7l-0001fL-S2
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7h-0000L3-7R
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU7g-0000KN-Qh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:13 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:43 -0600
Message-Id: <20180301194245.29854-29-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/30] qapi: Move qapi-schema.json to qapi/,
 rename generated files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Move qapi-schema.json to qapi/, so it's next to its modules, and all
files get generated to qapi/, not just the ones generated for modules.

Consistently name the generated files qapi-MODULE.EXT:
qmp-commands.[ch] become qapi-commands.[ch], qapi-event.[ch] become
qapi-events.[ch], and qmp-introspect.[ch] become qapi-introspect.[ch].
This gets rid of the temporary hacks in scripts/qapi/commands.py and
scripts/qapi/events.py.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-28-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
[eblake: Fix trailing dot in tpm.c]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/devel/qapi-code-gen.txt              | 30 +++++++++++-----------
 docs/devel/writing-qmp-commands.txt       |  2 +-
 docs/interop/qmp-intro.txt                |  2 +-
 Makefile                                  | 42 +++++++++++++++----------=
------
 Makefile.objs                             | 21 ++++++++--------
 qapi/misc.json                            |  4 +--
 qapi-schema.json =3D> qapi/qapi-schema.json | 32 +++++++++++------------
 include/qapi/visitor.h                    |  2 +-
 scripts/qapi/commands.py                  |  7 ------
 scripts/qapi/events.py                    |  9 +------
 scripts/qapi/introspect.py                |  4 +--
 scripts/qapi/types.py                     |  6 ++---
 scripts/qapi/visit.py                     |  6 ++---
 include/qapi/qmp/qobject.h                |  2 +-
 include/qom/object.h                      |  2 +-
 backends/hostmem.c                        |  2 +-
 hmp.c                                     |  2 +-
 monitor.c                                 |  6 ++---
 net/filter-buffer.c                       |  2 +-
 qga/commands-posix.c                      |  2 +-
 qga/commands-win32.c                      |  2 +-
 qga/commands.c                            |  2 +-
 qga/main.c                                |  2 +-
 qom/object.c                              |  2 +-
 tests/test-qmp-cmds.c                     |  2 +-
 tests/test-qmp-event.c                    |  2 +-
 tests/test-qobject-input-visitor.c        |  6 ++---
 tpm.c                                     |  3 +--
 ui/vnc.c                                  |  2 +-
 .gitignore                                | 16 ++++++------
 qga/Makefile.objs                         |  2 +-
 tests/.gitignore                          |  6 ++---
 tests/Makefile.include                    | 14 +++++------
 ui/cocoa.m                                |  2 +-
 34 files changed, 117 insertions(+), 131 deletions(-)
 rename qapi-schema.json =3D> qapi/qapi-schema.json (85%)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c86792add2e..25b7180a189 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -647,7 +647,7 @@ name an event 'MAX', since the generator also produce=
s a C enumeration
 of all event names with a generated _MAX value at the end.  When
 'data' is also specified, additional info will be included in the
 event, with similar semantics to a 'struct' expression.  Finally there
-will be C API generated in qapi-event.h; when called by QEMU code, a
+will be C API generated in qapi-events.h; when called by QEMU code, a
 message with timestamp will be emitted on the wire.

 An example event is:
@@ -1147,15 +1147,15 @@ declares qmp_COMMAND() that the user must impleme=
nt.

 The following files are generated:

-$(prefix)qmp-commands.c: Command marshal/dispatch functions for each
-                         QMP command defined in the schema
+$(prefix)qapi-commands.c: Command marshal/dispatch functions for each
+                          QMP command defined in the schema

-$(prefix)qmp-commands.h: Function prototypes for the QMP commands
-                         specified in the schema
+$(prefix)qapi-commands.h: Function prototypes for the QMP commands
+                          specified in the schema

 Example:

-    $ cat qapi-generated/example-qmp-commands.h
+    $ cat qapi-generated/example-qapi-commands.h
 [Uninteresting stuff omitted...]

     #ifndef EXAMPLE_QMP_COMMANDS_H
@@ -1170,7 +1170,7 @@ Example:
     void qmp_marshal_my_command(QDict *args, QObject **ret, Error **errp=
);

     #endif
-    $ cat qapi-generated/example-qmp-commands.c
+    $ cat qapi-generated/example-qapi-commands.c
 [Uninteresting stuff omitted...]

     static void qmp_marshal_output_UserDefOne(UserDefOne *ret_in, QObjec=
t **ret_out, Error **errp)
@@ -1243,14 +1243,14 @@ qapi_event_send_EVENT().

 The following files are created:

-$(prefix)qapi-event.h - Function prototypes for each event type, plus an
+$(prefix)qapi-events.h - Function prototypes for each event type, plus a=
n
                         enumeration of all event names

-$(prefix)qapi-event.c - Implementation of functions to send an event
+$(prefix)qapi-events.c - Implementation of functions to send an event

 Example:

-    $ cat qapi-generated/example-qapi-event.h
+    $ cat qapi-generated/example-qapi-events.h
 [Uninteresting stuff omitted...]

     #ifndef EXAMPLE_QAPI_EVENT_H
@@ -1273,7 +1273,7 @@ Example:
     extern const char *const example_QAPIEvent_lookup[];

     #endif
-    $ cat qapi-generated/example-qapi-event.c
+    $ cat qapi-generated/example-qapi-events.c
 [Uninteresting stuff omitted...]

     void qapi_event_send_my_event(Error **errp)
@@ -1306,14 +1306,14 @@ Example:

 The following files are created:

-$(prefix)qmp-introspect.c - Defines a string holding a JSON
+$(prefix)qapi-introspect.c - Defines a string holding a JSON
                             description of the schema

-$(prefix)qmp-introspect.h - Declares the above string
+$(prefix)qapi-introspect.h - Declares the above string

 Example:

-    $ cat qapi-generated/example-qmp-introspect.h
+    $ cat qapi-generated/example-qapi-introspect.h
 [Uninteresting stuff omitted...]

     #ifndef EXAMPLE_QMP_INTROSPECT_H
@@ -1322,7 +1322,7 @@ Example:
     extern const char example_qmp_schema_json[];

     #endif
-    $ cat qapi-generated/example-qmp-introspect.c
+    $ cat qapi-generated/example-qapi-introspect.c
 [Uninteresting stuff omitted...]

     const char example_qmp_schema_json[] =3D "["
diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp=
-commands.txt
index 50385eff27c..9dfc62bf5a3 100644
--- a/docs/devel/writing-qmp-commands.txt
+++ b/docs/devel/writing-qmp-commands.txt
@@ -419,7 +419,7 @@ There are a number of things to be noticed:
    allocated by the implementation. This is so because the QAPI also gen=
erates
    a function to free its types and it cannot distinguish between dynami=
cally
    or statically allocated strings
-6. You have to include "qapi/qmp-commands-misc.h" in qemu-timer.c
+6. You have to include "qapi/qapi-commands-misc.h" in qemu-timer.c

 Time to test the new command. Build qemu, run it as described in the "Te=
sting"
 section and try this:
diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
index 430fe1b7472..900d69d6128 100644
--- a/docs/interop/qmp-intro.txt
+++ b/docs/interop/qmp-intro.txt
@@ -79,7 +79,7 @@ Escape character is '^]'.
 }

 Please refer to docs/interop/qemu-qmp-ref.* for a complete command
-reference, generated from qapi-schema.json.
+reference, generated from qapi/qapi-schema.json.

 QMP wiki page
 -------------
diff --git a/Makefile b/Makefile
index 26ed98e0300..a470168d985 100644
--- a/Makefile
+++ b/Makefile
@@ -90,8 +90,8 @@ endif
 include $(SRC_PATH)/rules.mak

 GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
-GENERATED_FILES +=3D qapi-builtin-types.h qapi-builtin-types.c
-GENERATED_FILES +=3D qapi-types.h qapi-types.c
+GENERATED_FILES +=3D qapi/qapi-builtin-types.h qapi/qapi-builtin-types.c
+GENERATED_FILES +=3D qapi/qapi-types.h qapi/qapi-types.c
 GENERATED_FILES +=3D qapi/qapi-types-block-core.h qapi/qapi-types-block-=
core.c
 GENERATED_FILES +=3D qapi/qapi-types-block.h qapi/qapi-types-block.c
 GENERATED_FILES +=3D qapi/qapi-types-char.h qapi/qapi-types-char.c
@@ -108,8 +108,8 @@ GENERATED_FILES +=3D qapi/qapi-types-tpm.h qapi/qapi-=
types-tpm.c
 GENERATED_FILES +=3D qapi/qapi-types-trace.h qapi/qapi-types-trace.c
 GENERATED_FILES +=3D qapi/qapi-types-transaction.h qapi/qapi-types-trans=
action.c
 GENERATED_FILES +=3D qapi/qapi-types-ui.h qapi/qapi-types-ui.c
-GENERATED_FILES +=3D qapi-builtin-visit.h qapi-builtin-visit.c
-GENERATED_FILES +=3D qapi-visit.h qapi-visit.c
+GENERATED_FILES +=3D qapi/qapi-builtin-visit.h qapi/qapi-builtin-visit.c
+GENERATED_FILES +=3D qapi/qapi-visit.h qapi/qapi-visit.c
 GENERATED_FILES +=3D qapi/qapi-visit-block-core.h qapi/qapi-visit-block-=
core.c
 GENERATED_FILES +=3D qapi/qapi-visit-block.h qapi/qapi-visit-block.c
 GENERATED_FILES +=3D qapi/qapi-visit-char.h qapi/qapi-visit-char.c
@@ -126,7 +126,7 @@ GENERATED_FILES +=3D qapi/qapi-visit-tpm.h qapi/qapi-=
visit-tpm.c
 GENERATED_FILES +=3D qapi/qapi-visit-trace.h qapi/qapi-visit-trace.c
 GENERATED_FILES +=3D qapi/qapi-visit-transaction.h qapi/qapi-visit-trans=
action.c
 GENERATED_FILES +=3D qapi/qapi-visit-ui.h qapi/qapi-visit-ui.c
-GENERATED_FILES +=3D qmp-commands.h qmp-commands.c
+GENERATED_FILES +=3D qapi/qapi-commands.h qapi/qapi-commands.c
 GENERATED_FILES +=3D qapi/qapi-commands-block-core.h qapi/qapi-commands-=
block-core.c
 GENERATED_FILES +=3D qapi/qapi-commands-block.h qapi/qapi-commands-block=
.c
 GENERATED_FILES +=3D qapi/qapi-commands-char.h qapi/qapi-commands-char.c
@@ -143,7 +143,7 @@ GENERATED_FILES +=3D qapi/qapi-commands-tpm.h qapi/qa=
pi-commands-tpm.c
 GENERATED_FILES +=3D qapi/qapi-commands-trace.h qapi/qapi-commands-trace=
.c
 GENERATED_FILES +=3D qapi/qapi-commands-transaction.h qapi/qapi-commands=
-transaction.c
 GENERATED_FILES +=3D qapi/qapi-commands-ui.h qapi/qapi-commands-ui.c
-GENERATED_FILES +=3D qapi-event.h qapi-event.c
+GENERATED_FILES +=3D qapi/qapi-events.h qapi/qapi-events.c
 GENERATED_FILES +=3D qapi/qapi-events-block-core.h qapi/qapi-events-bloc=
k-core.c
 GENERATED_FILES +=3D qapi/qapi-events-block.h qapi/qapi-events-block.c
 GENERATED_FILES +=3D qapi/qapi-events-char.h qapi/qapi-events-char.c
@@ -160,8 +160,8 @@ GENERATED_FILES +=3D qapi/qapi-events-tpm.h qapi/qapi=
-events-tpm.c
 GENERATED_FILES +=3D qapi/qapi-events-trace.h qapi/qapi-events-trace.c
 GENERATED_FILES +=3D qapi/qapi-events-transaction.h qapi/qapi-events-tra=
nsaction.c
 GENERATED_FILES +=3D qapi/qapi-events-ui.h qapi/qapi-events-ui.c
-GENERATED_FILES +=3D qmp-introspect.c qmp-introspect.h
-GENERATED_FILES +=3D qapi-doc.texi
+GENERATED_FILES +=3D qapi/qapi-introspect.c qapi/qapi-introspect.h
+GENERATED_FILES +=3D qapi/qapi-doc.texi

 GENERATED_FILES +=3D trace/generated-tcg-tracers.h

@@ -562,7 +562,7 @@ $(SRC_PATH)/scripts/qapi-gen.py

 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h =
\
 qga/qapi-generated/qga-qapi-visit.c qga/qapi-generated/qga-qapi-visit.h =
\
-qga/qapi-generated/qga-qmp-commands.h qga/qapi-generated/qga-qmp-command=
s.c \
+qga/qapi-generated/qga-qapi-commands.h qga/qapi-generated/qga-qapi-comma=
nds.c \
 qga/qapi-generated/qga-qapi-doc.texi: \
 qga/qapi-generated/qapi-gen-timestamp ;
 qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qga/qapi-schema.json =
$(qapi-py)
@@ -571,7 +571,7 @@ qga/qapi-generated/qapi-gen-timestamp: $(SRC_PATH)/qg=
a/qapi-schema.json $(qapi-p
 		"GEN","$(@:%-timestamp=3D%)")
 	@>$@

-qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
+qapi-modules =3D $(SRC_PATH)/qapi/qapi-schema.json $(SRC_PATH)/qapi/comm=
on.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
@@ -587,8 +587,8 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json

-qapi-builtin-types.c qapi-builtin-types.h \
-qapi-types.c qapi-types.h \
+qapi/qapi-builtin-types.c qapi/qapi-builtin-types.h \
+qapi/qapi-types.c qapi/qapi-types.h \
 qapi/qapi-types-block-core.c qapi/qapi-types-block-core.h \
 qapi/qapi-types-block.c qapi/qapi-types-block.h \
 qapi/qapi-types-char.c qapi/qapi-types-char.h \
@@ -605,8 +605,8 @@ qapi/qapi-types-tpm.c qapi/qapi-types-tpm.h \
 qapi/qapi-types-trace.c qapi/qapi-types-trace.h \
 qapi/qapi-types-transaction.c qapi/qapi-types-transaction.h \
 qapi/qapi-types-ui.c qapi/qapi-types-ui.h \
-qapi-builtin-visit.c qapi-builtin-visit.h \
-qapi-visit.c qapi-visit.h \
+qapi/qapi-builtin-visit.c qapi/qapi-builtin-visit.h \
+qapi/qapi-visit.c qapi/qapi-visit.h \
 qapi/qapi-visit-block-core.c qapi/qapi-visit-block-core.h \
 qapi/qapi-visit-block.c qapi/qapi-visit-block.h \
 qapi/qapi-visit-char.c qapi/qapi-visit-char.h \
@@ -623,7 +623,7 @@ qapi/qapi-visit-tpm.c qapi/qapi-visit-tpm.h \
 qapi/qapi-visit-trace.c qapi/qapi-visit-trace.h \
 qapi/qapi-visit-transaction.c qapi/qapi-visit-transaction.h \
 qapi/qapi-visit-ui.c qapi/qapi-visit-ui.h \
-qmp-commands.h qmp-commands.c \
+qapi/qapi-commands.h qapi/qapi-commands.c \
 qapi/qapi-commands-block-core.c qapi/qapi-commands-block-core.h \
 qapi/qapi-commands-block.c qapi/qapi-commands-block.h \
 qapi/qapi-commands-char.c qapi/qapi-commands-char.h \
@@ -640,7 +640,7 @@ qapi/qapi-commands-tpm.c qapi/qapi-commands-tpm.h \
 qapi/qapi-commands-trace.c qapi/qapi-commands-trace.h \
 qapi/qapi-commands-transaction.c qapi/qapi-commands-transaction.h \
 qapi/qapi-commands-ui.c qapi/qapi-commands-ui.h \
-qapi-event.c qapi-event.h \
+qapi/qapi-events.c qapi/qapi-events.h \
 qapi/qapi-events-block-core.c qapi/qapi-events-block-core.h \
 qapi/qapi-events-block.c qapi/qapi-events-block.h \
 qapi/qapi-events-char.c qapi/qapi-events-char.h \
@@ -657,16 +657,16 @@ qapi/qapi-events-tpm.c qapi/qapi-events-tpm.h \
 qapi/qapi-events-trace.c qapi/qapi-events-trace.h \
 qapi/qapi-events-transaction.c qapi/qapi-events-transaction.h \
 qapi/qapi-events-ui.c qapi/qapi-events-ui.h \
-qmp-introspect.h qmp-introspect.c \
-qapi-doc.texi: \
+qapi/qapi-introspect.h qapi/qapi-introspect.c \
+qapi/qapi-doc.texi: \
 qapi-gen-timestamp ;
 qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
 	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o "." -b $<, \
+		-o "qapi" -b $<, \
 		"GEN","$(@:%-timestamp=3D%)")
 	@>$@

-QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
+QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qapi-commands.h)
 $(qga-obj-y): $(QGALIB_GEN)

 qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
@@ -933,7 +933,7 @@ qemu-monitor-info.texi: $(SRC_PATH)/hmp-commands-info=
.hx $(SRC_PATH)/scripts/hxt
 qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxt=
ool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","=
$@")

-docs/interop/qemu-qmp-qapi.texi: qapi-doc.texi
+docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 	@cp -p $< $@

 docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
diff --git a/Makefile.objs b/Makefile.objs
index 149627b5890..d741134cc77 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -2,8 +2,8 @@
 # Common libraries for tools and emulators
 stub-obj-y =3D stubs/ crypto/
 util-obj-y =3D util/ qobject/ qapi/
-util-obj-y +=3D qapi-builtin-types.o
-util-obj-y +=3D qapi-types.o
+util-obj-y +=3D qapi/qapi-builtin-types.o
+util-obj-y +=3D qapi/qapi-types.o
 util-obj-y +=3D qapi/qapi-types-block-core.o
 util-obj-y +=3D qapi/qapi-types-block.o
 util-obj-y +=3D qapi/qapi-types-char.o
@@ -20,8 +20,8 @@ util-obj-y +=3D qapi/qapi-types-tpm.o
 util-obj-y +=3D qapi/qapi-types-trace.o
 util-obj-y +=3D qapi/qapi-types-transaction.o
 util-obj-y +=3D qapi/qapi-types-ui.o
-util-obj-y +=3D qapi-builtin-visit.o
-util-obj-y +=3D qapi-visit.o
+util-obj-y +=3D qapi/qapi-builtin-visit.o
+util-obj-y +=3D qapi/qapi-visit.o
 util-obj-y +=3D qapi/qapi-visit-block-core.o
 util-obj-y +=3D qapi/qapi-visit-block.o
 util-obj-y +=3D qapi/qapi-visit-char.o
@@ -38,7 +38,7 @@ util-obj-y +=3D qapi/qapi-visit-tpm.o
 util-obj-y +=3D qapi/qapi-visit-trace.o
 util-obj-y +=3D qapi/qapi-visit-transaction.o
 util-obj-y +=3D qapi/qapi-visit-ui.o
-util-obj-y +=3D qapi-event.o
+util-obj-y +=3D qapi/qapi-events.o
 util-obj-y +=3D qapi/qapi-events-block-core.o
 util-obj-y +=3D qapi/qapi-events-block.o
 util-obj-y +=3D qapi/qapi-events-char.o
@@ -55,7 +55,7 @@ util-obj-y +=3D qapi/qapi-events-tpm.o
 util-obj-y +=3D qapi/qapi-events-trace.o
 util-obj-y +=3D qapi/qapi-events-transaction.o
 util-obj-y +=3D qapi/qapi-events-ui.o
-util-obj-y +=3D qmp-introspect.o
+util-obj-y +=3D qapi/qapi-introspect.o

 chardev-obj-y =3D chardev/

@@ -131,7 +131,7 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
 ######################################################################
 # qapi

-common-obj-y +=3D qmp-commands.o
+common-obj-y +=3D qapi/qapi-commands.o
 common-obj-y +=3D qapi/qapi-commands-block-core.o
 common-obj-y +=3D qapi/qapi-commands-block.o
 common-obj-y +=3D qapi/qapi-commands-char.o
@@ -148,7 +148,7 @@ common-obj-y +=3D qapi/qapi-commands-tpm.o
 common-obj-y +=3D qapi/qapi-commands-trace.o
 common-obj-y +=3D qapi/qapi-commands-transaction.o
 common-obj-y +=3D qapi/qapi-commands-ui.o
-common-obj-y +=3D qmp-introspect.o
+common-obj-y +=3D qapi/qapi-introspect.o
 common-obj-y +=3D qmp.o hmp.o
 endif

@@ -171,8 +171,9 @@ target-obj-y +=3D trace/
 ######################################################################
 # guest agent

-# FIXME: a few definitions from qapi-types.o/qapi-visit.o are needed
-# by libqemuutil.a.  These should be moved to a separate .json schema.
+# FIXME: a few definitions from qapi/qapi-types.o and
+# qapi/qapi-visit.o are needed by libqemuutil.a.  These should be
+# extracted into a QAPI schema module, or perhaps a separate schema.
 qga-obj-y =3D qga/
 qga-vss-dll-obj-y =3D qga/

diff --git a/qapi/misc.json b/qapi/misc.json
index dabc987f7a7..a1702c90609 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1729,7 +1729,7 @@
 #
 # Emitted when background dump has completed
 #
-# @result: DumpQueryResult type described in qapi-schema.json.
+# @result: final dump status
 #
 # @error: human-readable error string that provides
 #         hint on why dump failed. Only presents on failure. The
@@ -2944,7 +2944,7 @@
 #
 # Emitted when guest executes ACPI _OST method.
 #
-# @info: ACPIOSTInfo type as described in qapi-schema.json
+# @info: OSPM Status Indication
 #
 # Since: 2.1
 #
diff --git a/qapi-schema.json b/qapi/qapi-schema.json
similarity index 85%
rename from qapi-schema.json
rename to qapi/qapi-schema.json
index 689d06c5304..25bce78352b 100644
--- a/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -76,20 +76,20 @@
 # included sub-schemas inserted at the first include directive
 # (subsequent include directives have no effect).  To get a sane and
 # stable order, it's best to include each sub-schema just once, or
-# include it first in qapi-schema.json.
+# include it first right here.

-{ 'include': 'qapi/common.json' }
-{ 'include': 'qapi/sockets.json' }
-{ 'include': 'qapi/run-state.json' }
-{ 'include': 'qapi/crypto.json' }
-{ 'include': 'qapi/block.json' }
-{ 'include': 'qapi/char.json' }
-{ 'include': 'qapi/net.json' }
-{ 'include': 'qapi/rocker.json' }
-{ 'include': 'qapi/tpm.json' }
-{ 'include': 'qapi/ui.json' }
-{ 'include': 'qapi/migration.json' }
-{ 'include': 'qapi/transaction.json' }
-{ 'include': 'qapi/trace.json' }
-{ 'include': 'qapi/introspect.json' }
-{ 'include': 'qapi/misc.json' }
+{ 'include': 'common.json' }
+{ 'include': 'sockets.json' }
+{ 'include': 'run-state.json' }
+{ 'include': 'crypto.json' }
+{ 'include': 'block.json' }
+{ 'include': 'char.json' }
+{ 'include': 'net.json' }
+{ 'include': 'rocker.json' }
+{ 'include': 'tpm.json' }
+{ 'include': 'ui.json' }
+{ 'include': 'migration.json' }
+{ 'include': 'transaction.json' }
+{ 'include': 'trace.json' }
+{ 'include': 'introspect.json' }
+{ 'include': 'misc.json' }
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 9e57508446e..5b2ed3f202a 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -15,7 +15,7 @@
 #ifndef QAPI_VISITOR_H
 #define QAPI_VISITOR_H

-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"

 /*
  * The QAPI schema defines both a set of C data types, and a QMP wire
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 953449171b3..21a7e0dbe61 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -232,13 +232,6 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularC=
Visitor):
         self._regy =3D ''
         self._visited_ret_types =3D {}

-    # Temporary HACK:
-    def _module_basename(self, what, name):
-        basename =3D QAPISchemaModularCVisitor._module_basename(self, wh=
at, name)
-        if name =3D=3D self._main_module:
-            return re.sub(r'qapi-commands', 'qmp-commands', basename)
-        return basename
-
     def _begin_module(self, name):
         self._visited_ret_types[self._genc] =3D set()
         commands =3D self._module_basename('qapi-commands', name)
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 5ad67084911..3dc523cf396 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -157,20 +157,13 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
         self._enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse=
)
         self._event_names =3D []

-    # Temporary HACK:
-    def _module_basename(self, what, name):
-        basename =3D QAPISchemaModularCVisitor._module_basename(self, wh=
at, name)
-        if name =3D=3D self._main_module:
-            return re.sub(r'qapi-events', 'qapi-event', basename)
-        return basename
-
     def _begin_module(self, name):
         types =3D self._module_basename('qapi-types', name)
         visit =3D self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "%(prefix)sqapi-event.h"
+#include "%(prefix)sqapi-events.h"
 #include "%(visit)s.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f571cc134cf..f66c397fb0e 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -44,7 +44,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolith=
icCVisitor):

     def __init__(self, prefix, unmask):
         QAPISchemaMonolithicCVisitor.__init__(
-            self, prefix, 'qmp-introspect',
+            self, prefix, 'qapi-introspect',
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask =3D unmask
         self._schema =3D None
@@ -53,7 +53,7 @@ class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolith=
icCVisitor):
         self._name_map =3D {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
-#include "%(prefix)sqmp-introspect.h"
+#include "%(prefix)sqapi-introspect.h"

 ''',
                              prefix=3Dprefix))
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 2a3c502cf6d..64d9c0fb370 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -177,8 +177,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
-#include "qapi-builtin-types.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-types.h"
+#include "qapi/qapi-builtin-visit.h"
 '''))
         self._genh.preamble_add(mcgen('''
 #include "qapi/util.h"
@@ -195,7 +195,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
 ''',
                                       types=3Dtypes, visit=3Dvisit))
         self._genh.preamble_add(mcgen('''
-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"
 '''))

     def visit_begin(self, schema):
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index de09966643d..5d72d8936cb 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -274,11 +274,11 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCV=
isitor):
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 '''))
         self._genh.preamble_add(mcgen('''
 #include "qapi/visitor.h"
-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"

 ''',
                                       prefix=3Dprefix))
@@ -295,7 +295,7 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
 ''',
                                       visit=3Dvisit, prefix=3Dself._pref=
ix))
         self._genh.preamble_add(mcgen('''
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "%(types)s.h"

 ''',
diff --git a/include/qapi/qmp/qobject.h b/include/qapi/qmp/qobject.h
index a2964fbf254..012439a2e3b 100644
--- a/include/qapi/qmp/qobject.h
+++ b/include/qapi/qmp/qobject.h
@@ -32,7 +32,7 @@
 #ifndef QOBJECT_H
 #define QOBJECT_H

-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"

 struct QObject {
     QType type;
diff --git a/include/qom/object.h b/include/qom/object.h
index 5b5c016d8fa..30db296af4c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_OBJECT_H
 #define QEMU_OBJECT_H

-#include "qapi-builtin-types.h"
+#include "qapi/qapi-builtin-types.h"
 #include "qemu/queue.h"

 struct TypeImpl;
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 74fc04a3621..f61093654e1 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -14,7 +14,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
 #include "qom/object_interfaces.h"
diff --git a/hmp.c b/hmp.c
index 8ea227dac4e..016cb5c4f1e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -28,7 +28,7 @@
 #include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-commands-migration.h"
diff --git a/monitor.c b/monitor.c
index fc9df6253ad..57957b3969b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -69,14 +69,14 @@
 #include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "qemu/option.h"
-#include "qmp-commands.h"
 #include "hmp.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
+#include "qapi/qapi-commands.h"
+#include "qapi/qapi-events.h"
 #include "qapi/error.h"
 #include "qapi/qmp-event.h"
-#include "qapi-event.h"
-#include "qmp-introspect.h"
+#include "qapi/qapi-introspect.h"
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 7c487629f92..f7265c50a8e 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -13,7 +13,7 @@
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
 #include "qom/object.h"

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 967061444a9..ac17d0d6cf8 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -17,7 +17,7 @@
 #include <sys/wait.h>
 #include <dirent.h>
 #include "qga/guest-agent-core.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/queue.h"
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index bedae329573..2d483947484 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -34,7 +34,7 @@

 #include "qga/guest-agent-core.h"
 #include "qga/vss-win32.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/queue.h"
diff --git a/qga/commands.c b/qga/commands.c
index 6d710dbb204..a64b34ccab7 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -12,7 +12,7 @@

 #include "qemu/osdep.h"
 #include "qga/guest-agent-core.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/base64.h"
diff --git a/qga/main.c b/qga/main.c
index cb434d8c464..f9c83050c5d 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -25,7 +25,7 @@
 #include "qapi/qmp/qstring.h"
 #include "qga/guest-agent-core.h"
 #include "qemu/module.h"
-#include "qga-qmp-commands.h"
+#include "qga-qapi-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
 #include "qga/channel.h"
diff --git a/qom/object.c b/qom/object.c
index 81b4f7ac482..f70a75c3084 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -18,7 +18,7 @@
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
-#include "qapi-builtin-visit.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 24660d0868c..5b1cee69122 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -3,12 +3,12 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
-#include "test-qmp-commands.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qapi/qobject-input-visitor.h"
 #include "tests/test-qapi-types.h"
 #include "tests/test-qapi-visit.h"
+#include "test-qapi-commands.h"

 static QmpCommandList qmp_commands;

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 5fbe7e551f7..31f35b3e66a 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -14,13 +14,13 @@
 #include "qemu/osdep.h"

 #include "qemu-common.h"
-#include "test-qapi-event.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
+#include "test-qapi-events.h"

 typedef struct TestEventData {
     QDict *expect;
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index d3a56bd0712..79b1a8cb175 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -24,8 +24,8 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qjson.h"
-#include "test-qmp-introspect.h"
-#include "qmp-introspect.h"
+#include "test-qapi-introspect.h"
+#include "qapi/qapi-introspect.h"

 typedef struct TestInputVisitorData {
     QObject *obj;
@@ -1376,7 +1376,7 @@ int main(int argc, char **argv)
                            NULL, test_visitor_in_fail_alternate);
     input_visitor_test_add("/visitor/input/fail/union-native-list",
                            NULL, test_visitor_in_fail_union_native_list)=
;
-    input_visitor_test_add("/visitor/input/qmp-introspect",
+    input_visitor_test_add("/visitor/input/qapi-introspect",
                            NULL, test_visitor_in_qmp_introspect);

     g_test_run();
diff --git a/tpm.c b/tpm.c
index 2db03a09b21..93031723ad7 100644
--- a/tpm.c
+++ b/tpm.c
@@ -181,8 +181,7 @@ int tpm_config_parse(QemuOptsList *opts_list, const c=
har *optarg)
 }

 /*
- * Walk the list of active TPM backends and collect information about th=
em
- * following the schema description in qapi-schema.json.
+ * Walk the list of active TPM backends and collect information about th=
em.
  */
 TPMInfoList *qmp_query_tpm(Error **errp)
 {
diff --git a/ui/vnc.c b/ui/vnc.c
index a25e408cf03..13c28cabb0c 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -35,10 +35,10 @@
 #include "qemu/timer.h"
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
+#include "qapi/qapi-events.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "ui/input.h"
-#include "qapi-event.h"
 #include "crypto/hash.h"
 #include "crypto/tlscredsanon.h"
 #include "crypto/tlscredsx509.h"
diff --git a/.gitignore b/.gitignore
index 7f162e862fe..dabfe6bea89 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,8 +29,8 @@
 /qga/qapi-generated
 /qapi-generated
 /qapi-gen-timestamp
-/qapi-builtin-types.[ch]
-/qapi-builtin-visit.[ch]
+/qapi/qapi-builtin-types.[ch]
+/qapi/qapi-builtin-visit.[ch]
 /qapi/qapi-commands-block-core.[ch]
 /qapi/qapi-commands-block.[ch]
 /qapi/qapi-commands-char.[ch]
@@ -47,6 +47,7 @@
 /qapi/qapi-commands-trace.[ch]
 /qapi/qapi-commands-transaction.[ch]
 /qapi/qapi-commands-ui.[ch]
+/qapi/qapi-commands.[ch]
 /qapi/qapi-events-block-core.[ch]
 /qapi/qapi-events-block.[ch]
 /qapi/qapi-events-char.[ch]
@@ -63,6 +64,8 @@
 /qapi/qapi-events-trace.[ch]
 /qapi/qapi-events-transaction.[ch]
 /qapi/qapi-events-ui.[ch]
+/qapi/qapi-events.[ch]
+/qapi/qapi-introspect.[ch]
 /qapi/qapi-types-block-core.[ch]
 /qapi/qapi-types-block.[ch]
 /qapi/qapi-types-char.[ch]
@@ -79,7 +82,7 @@
 /qapi/qapi-types-trace.[ch]
 /qapi/qapi-types-transaction.[ch]
 /qapi/qapi-types-ui.[ch]
-/qapi-types.[ch]
+/qapi/qapi-types.[ch]
 /qapi/qapi-visit-block-core.[ch]
 /qapi/qapi-visit-block.[ch]
 /qapi/qapi-visit-char.[ch]
@@ -96,11 +99,8 @@
 /qapi/qapi-visit-trace.[ch]
 /qapi/qapi-visit-transaction.[ch]
 /qapi/qapi-visit-ui.[ch]
-/qapi-visit.[ch]
-/qapi-event.[ch]
-/qapi-doc.texi
-/qmp-commands.[ch]
-/qmp-introspect.[ch]
+/qapi/qapi-visit.[ch]
+/qapi/qapi-doc.texi
 /qemu-doc.html
 /qemu-doc.info
 /qemu-doc.txt
diff --git a/qga/Makefile.objs b/qga/Makefile.objs
index 6151378ae42..ed08c5917c0 100644
--- a/qga/Makefile.objs
+++ b/qga/Makefile.objs
@@ -3,6 +3,6 @@ qga-obj-$(CONFIG_POSIX) +=3D commands-posix.o channel-pos=
ix.o
 qga-obj-$(CONFIG_WIN32) +=3D commands-win32.o channel-win32.o service-wi=
n32.o
 qga-obj-$(CONFIG_WIN32) +=3D vss-win32.o
 qga-obj-y +=3D qapi-generated/qga-qapi-types.o qapi-generated/qga-qapi-v=
isit.o
-qga-obj-y +=3D qapi-generated/qga-qmp-commands.o
+qga-obj-y +=3D qapi-generated/qga-qapi-commands.o

 qga-vss-dll-obj-$(CONFIG_QGA_VSS) +=3D vss-win32/
diff --git a/tests/.gitignore b/tests/.gitignore
index 2629cfc2f98..18e58b21832 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -60,7 +60,8 @@ test-keyval
 test-logging
 test-mul64
 test-opts-visitor
-test-qapi-event.[ch]
+test-qapi-commands.[ch]
+test-qapi-events.[ch]
 test-qapi-types.[ch]
 test-qapi-util
 test-qapi-visit.[ch]
@@ -71,11 +72,10 @@ test-qga
 test-qht
 test-qht-par
 test-qmp-cmds
-test-qmp-commands.[ch]
 test-qmp-event
 test-qobject-input-strict
 test-qobject-input-visitor
-test-qmp-introspect.[ch]
+test-qapi-introspect.[ch]
 test-qobject-output-visitor
 test-rcu-list
 test-replication
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2de46f8acb7..fdca0625911 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -570,8 +570,8 @@ qapi-schema +=3D unknown-expr-key.json
 check-qapi-schema-y :=3D $(addprefix tests/qapi-schema/, $(qapi-schema))

 GENERATED_FILES +=3D tests/test-qapi-types.h tests/test-qapi-visit.h \
-	tests/test-qmp-commands.h tests/test-qapi-event.h \
-	tests/test-qmp-introspect.h
+	tests/test-qapi-commands.h tests/test-qapi-events.h \
+	tests/test-qapi-introspect.h

 test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-qdic=
t.o \
 	tests/check-qlist.o tests/check-qnull.o tests/check-qobject.o \
@@ -596,7 +596,7 @@ QEMU_CFLAGS +=3D -I$(SRC_PATH)/tests
 test-util-obj-y =3D libqemuutil.a
 test-qom-obj-y =3D $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y =3D tests/test-qapi-visit.o tests/test-qapi-types.o \
-	tests/test-qapi-event.o tests/test-qmp-introspect.o \
+	tests/test-qapi-events.o tests/test-qapi-introspect.o \
 	$(test-qom-obj-y)
 benchmark-crypto-obj-y =3D $(crypto-obj-y) $(test-qom-obj-y)
 test-crypto-obj-y =3D $(crypto-obj-y) $(test-qom-obj-y)
@@ -660,9 +660,9 @@ tests/test-replication$(EXESUF): tests/test-replicati=
on.o $(test-util-obj-y) \

 tests/test-qapi-types.c tests/test-qapi-types.h \
 tests/test-qapi-visit.c tests/test-qapi-visit.h \
-tests/test-qmp-commands.h tests/test-qmp-commands.c \
-tests/test-qapi-event.c tests/test-qapi-event.h \
-tests/test-qmp-introspect.c tests/test-qmp-introspect.h: \
+tests/test-qapi-commands.h tests/test-qapi-commands.c \
+tests/test-qapi-events.c tests/test-qapi-events.h \
+tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
 tests/test-qapi-gen-timestamp ;
 tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema=
-test.json $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
@@ -683,7 +683,7 @@ tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o=
 $(test-qapi-obj-y)
 tests/test-qobject-output-visitor$(EXESUF): tests/test-qobject-output-vi=
sitor.o $(test-qapi-obj-y)
 tests/test-clone-visitor$(EXESUF): tests/test-clone-visitor.o $(test-qap=
i-obj-y)
 tests/test-qobject-input-visitor$(EXESUF): tests/test-qobject-input-visi=
tor.o $(test-qapi-obj-y)
-tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qmp-comma=
nds.o $(test-qapi-obj-y)
+tests/test-qmp-cmds$(EXESUF): tests/test-qmp-cmds.o tests/test-qapi-comm=
ands.o $(test-qapi-obj-y)
 tests/test-visitor-serialization$(EXESUF): tests/test-visitor-serializat=
ion.o $(test-qapi-obj-y)
 tests/test-opts-visitor$(EXESUF): tests/test-opts-visitor.o $(test-qapi-=
obj-y)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 90d9aa57eab..30888ca8fd6 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -32,7 +32,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qmp-commands.h"
+#include "qapi/qapi-commands.h"
 #include "sysemu/blockdev.h"
 #include "qemu-version.h"
 #include <Carbon/Carbon.h>
--=20
2.14.3
