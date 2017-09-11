Received: from eggs.gnu.org ([2001:4830:134:3::10]:43724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZu-0006ic-05
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZs-0007JD-LP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMZs-0007Iv-CY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A402231E04
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:08:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:06:17 +0200
Message-Id: <20170911110623.24981-45-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 44/50] build-sys: add a target schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

This schema is going to contain target-specific commands/events &
types, that can be conditionnally guarded with poisoned defines. To
filter it out by default, set the unit name to 'target'.

And new rules to compile this unit generated files per-target.

Use the "-u all" options for the introspection schema, since it is
generated as a single file and must contain all definitions.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json |  1 +
 qapi/target.json |  3 +++
 monitor.c        |  2 ++
 Makefile         | 29 ++++++++++++++++++++++++++++-
 Makefile.target  |  2 ++
 5 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 qapi/target.json

diff --git a/qapi-schema.json b/qapi-schema.json
index f3af2cb851..42b6aebddb 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -92,6 +92,7 @@
 { 'include': 'qapi/transaction.json' }
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
+{ 'include': 'qapi/target.json' }
=20
 ##
 # =3D Miscellanea
diff --git a/qapi/target.json b/qapi/target.json
new file mode 100644
index 0000000000..e9644f52c2
--- /dev/null
+++ b/qapi/target.json
@@ -0,0 +1,3 @@
+# -*- Mode: Python -*-
+
+{ 'pragma': { 'unit': 'target' } }
diff --git a/monitor.c b/monitor.c
index bf8a7685bf..af4eaeca5e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -68,6 +68,7 @@
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
index 337a1f6f9b..7356b4e7b7 100644
--- a/Makefile
+++ b/Makefile
@@ -54,6 +54,8 @@ include $(SRC_PATH)/rules.mak
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
@@ -418,6 +420,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
                $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
+               $(SRC_PATH)/qapi/target.json \
                $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
@@ -443,10 +446,34 @@ $(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.p=
y $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
 		$(gen-out-type) -o "." $<, \
 		"GEN","$@")
+
+target-qapi-types.c target-qapi-types.h :\
+$(qapi-modules) $(SRC_PATH)/scripts/qapi-types.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-types.py \
+		-i qapi-types.h \
+		$(gen-out-type) -p target- -u target $<, \
+		"GEN","$@")
+target-qapi-visit.c target-qapi-visit.h :\
+$(qapi-modules) $(SRC_PATH)/scripts/qapi-visit.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-visit.py \
+		-i qapi-visit.h \
+		$(gen-out-type) -p target- -u target $<, \
+		"GEN","$@")
+target-qapi-event.c target-qapi-event.h :\
+$(qapi-modules) $(SRC_PATH)/scripts/qapi-event.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-event.py \
+		$(gen-out-type) -p target- -u target  $<, \
+		"GEN","$@")
+target-qmp-commands.h target-qmp-marshal.c :\
+$(qapi-modules) $(SRC_PATH)/scripts/qapi-commands.py $(qapi-py)
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-commands.py \
+		$(gen-out-type) -p target- -u target $<, \
+		"GEN","$@")
+
 qmp-introspect.h qmp-introspect.c :\
 $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
 	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-introspect.py \
-		$(gen-out-type) -o "." $<, \
+		$(gen-out-type) -o "." -u all $<, \
 		"GEN","$@")
=20
 QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qmp-commands.h)
diff --git a/Makefile.target b/Makefile.target
index 0d28ed1df0..e44a3847d3 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -157,6 +157,8 @@ endif
=20
 GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
=20
+obj-y +=3D target-qapi-types.o target-qapi-visit.o
+obj-y +=3D target-qapi-event.o target-qmp-marshal.o
 obj-y +=3D qmp-introspect.o
=20
 endif # CONFIG_SOFTMMU
--=20
2.14.1.146.gd35faa819
