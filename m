Received: from eggs.gnu.org ([2001:4830:134:3::10]:51944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXK-0008Lp-SR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXJ-0006mc-FL
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkXJ-0006kn-7D
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58C2783F40
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 21:37:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:43 +0100
Message-Id: <20180111213250.16511-45-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 44/51] build-sys: add a target schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This schema is going to contain target-specific commands/events &
types, that can be conditionnally guarded with poisoned defines.

And new rules to compile the schema generated files per-target, using
the 'target' unit name filter.

This new schema is now the top-level schema to generate the
documentation (to include also target-specific commands/types).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/target.json |  5 +++++
 monitor.c        |  2 ++
 Makefile         | 45 +++++++++++++++++++++++++++++++++++++--------
 Makefile.target  |  2 ++
 4 files changed, 46 insertions(+), 8 deletions(-)
 create mode 100644 qapi/target.json

diff --git a/qapi/target.json b/qapi/target.json
new file mode 100644
index 0000000000..6cac484f68
--- /dev/null
+++ b/qapi/target.json
@@ -0,0 +1,5 @@
+# -*- Mode: Python -*-
+
+{ 'include': '../qapi-schema.json' }
+
+{ 'pragma': { 'unit': 'target' } }
diff --git a/monitor.c b/monitor.c
index f5ffffa786..8a4fbdd09b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -67,6 +67,7 @@
 #include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "qmp-commands.h"
+#include "target-qmp-commands.h"
 #include "hmp.h"
 #include "qemu/thread.h"
 #include "block/qapi.h"
@@ -1003,6 +1004,7 @@ void monitor_init_qmp_commands(void)
=20
     QTAILQ_INIT(&qmp_commands);
     qmp_init_marshal(&qmp_commands);
+    target_qmp_init_marshal(&qmp_commands);
=20
     qmp_register_command(&qmp_commands, "query-qmp-schema",
                          qmp_query_qmp_schema,
diff --git a/Makefile b/Makefile
index d86ecd2dd4..8a8ae4ce3c 100644
--- a/Makefile
+++ b/Makefile
@@ -87,6 +87,8 @@ include $(SRC_PATH)/rules.mak
 GENERATED_FILES =3D qemu-version.h config-host.h qemu-options.def
 GENERATED_FILES +=3D qmp-commands.h qapi-types.h qapi-visit.h qapi-event=
.h
 GENERATED_FILES +=3D qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.=
c
+GENERATED_FILES +=3D target-qmp-commands.h target-qapi-types.h target-qa=
pi-visit.h target-qapi-event.h
+GENERATED_FILES +=3D target-qmp-marshal.c target-qapi-types.c target-qap=
i-visit.c target-qapi-event.c
 GENERATED_FILES +=3D qmp-introspect.h
 GENERATED_FILES +=3D qmp-introspect.c
=20
@@ -485,7 +487,7 @@ $(SRC_PATH)/qga/qapi-schema.json $(SRC_PATH)/scripts/=
qapi-commands.py $(qapi-py)
 		$(gen-out-type) -o qga/qapi-generated -p "qga-" $<, \
 		"GEN","$@")
=20
-qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.js=
on \
+common-qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/co=
mmon.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
@@ -500,30 +502,57 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC=
_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
=20
+target-qapi-modules =3D $(SRC_PATH)/qapi/target.json \
+               $(common-qapi-modules)
+
 qapi-types.c qapi-types.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
+$(common-qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
 		$(gen-out-type) -o "." -b $<, \
 		"GEN","$@")
 qapi-visit.c qapi-visit.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
+$(common-qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
 		$(gen-out-type) -o "." -b $<, \
 		"GEN","$@")
 qapi-event.c qapi-event.h :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
+$(common-qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
 		$(gen-out-type) -o "." $<, \
 		"GEN","$@")
 qmp-commands.h qmp-marshal.c :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
+$(common-qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
 		$(gen-out-type) -o "." $<, \
 		"GEN","$@")
+
+target-qapi-types.c target-qapi-types.h :\
+$(target-qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
+		-i qapi-types.h \
+		$(gen-out-type) -p target- -u target $<, \
+		"GEN","$@")
+target-qapi-visit.c target-qapi-visit.h :\
+$(target-qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
+		-i qapi-visit.h \
+		$(gen-out-type) -p target- -u target $<, \
+		"GEN","$@")
+target-qapi-event.c target-qapi-event.h :\
+$(target-qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
+		$(gen-out-type) -p target- -u target  $<, \
+		"GEN","$@")
+target-qmp-commands.h target-qmp-marshal.c :\
+$(target-qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
+		$(gen-out-type) -p target- -u target $<, \
+		"GEN","$@")
+
 qmp-introspect.h qmp-introspect.c :\
-$(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
+$(target-qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
-		$(gen-out-type) -o "." $<, \
+		$(gen-out-type) -o "." -u all $<, \
 		"GEN","$@")
=20
 QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
@@ -791,7 +820,7 @@ qemu-img-cmds.texi: $(SRC_PATH)/qemu-img-cmds.hx $(SR=
C_PATH)/scripts/hxtool
=20
 docs/interop/qemu-qmp-qapi.texi docs/interop/qemu-ga-qapi.texi: $(SRC_PA=
TH)/scripts/qapi2texi.py $(qapi-py)
=20
-docs/interop/qemu-qmp-qapi.texi: $(qapi-modules)
+docs/interop/qemu-qmp-qapi.texi: $(target-qapi-modules)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi2texi.py $< > $@=
,"GEN","$@")
=20
 docs/interop/qemu-ga-qapi.texi: $(SRC_PATH)/qga/qapi-schema.json
diff --git a/Makefile.target b/Makefile.target
index 35108c6caf..110d4a9911 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -150,6 +150,8 @@ endif
=20
 GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
+obj-y +=3D target-qapi-types.o target-qapi-visit.o
+obj-y +=3D target-qapi-event.o target-qmp-marshal.o
 obj-y +=3D qmp-introspect.o
=20
 endif # CONFIG_SOFTMMU
--=20
2.16.0.rc1.1.gef27df75a1
