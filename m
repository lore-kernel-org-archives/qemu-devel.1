Received: from eggs.gnu.org ([2001:4830:134:3::10]:47549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4o6-0002le-QM
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4o3-0003tu-KJ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:22:10 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:33779)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4o3-0003tR-4h
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:22:07 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 13:21:56 +0300
Message-Id: <150529811657.10902.9901177197371496398.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 07/22] instrument: [qapi] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 MAINTAINERS              |    1 +
 Makefile                 |    1 +
 instrument/Makefile.objs |    1 +
 instrument/qmp.c         |   82 ++++++++++++++++++++++++++++++++++++++++=
++++++
 monitor.c                |    4 ++
 qapi-schema.json         |    3 ++
 qapi/instrument.json     |   49 +++++++++++++++++++++++++++
 stubs/instrument.c       |   22 ++++++++++++
 8 files changed, 163 insertions(+)
 create mode 100644 instrument/qmp.c
 create mode 100644 qapi/instrument.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c0b12a69a..edddab0502 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1492,6 +1492,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
 S: Maintained
 F: docs/instrument.txt
 F: instrument/
+F: qapi/instrument.json
=20
 TPM
 S: Orphan
diff --git a/Makefile b/Makefile
index 337a1f6f9b..3861b3f49c 100644
--- a/Makefile
+++ b/Makefile
@@ -412,6 +412,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
                $(SRC_PATH)/qapi/block.json $(SRC_PATH)/qapi/block-core.j=
son \
                $(SRC_PATH)/qapi/char.json \
                $(SRC_PATH)/qapi/crypto.json \
+               $(SRC_PATH)/qapi/instrument.json \
                $(SRC_PATH)/qapi/introspect.json \
                $(SRC_PATH)/qapi/migration.json \
                $(SRC_PATH)/qapi/net.json \
diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index 71994a4c85..7bf4e27e3c 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -2,3 +2,4 @@
=20
 target-obj-$(CONFIG_INSTRUMENT) +=3D cmdline.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D load.o
+target-obj-$(CONFIG_INSTRUMENT) +=3D qmp.o
diff --git a/instrument/qmp.c b/instrument/qmp.c
new file mode 100644
index 0000000000..e4464aa5eb
--- /dev/null
+++ b/instrument/qmp.c
@@ -0,0 +1,82 @@
+/*
+ * QMP interface for instrumentation control commands.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <dlfcn.h>
+
+#include "instrument/load.h"
+#include "qemu-common.h"
+#include "qapi/qmp/qerror.h"
+#include "qmp-commands.h"
+
+
+InstrLoadResult *qmp_instr_load(const char *path,
+                                bool has_id, const char *id,
+                                bool have_args, strList *args,
+                                Error **errp)
+{
+    InstrLoadResult *res =3D g_malloc0(sizeof(*res));
+    int argc =3D 0;
+    const char **argv =3D NULL;
+    InstrLoadError code;
+
+    if (!has_id) {
+        id =3D NULL;
+    }
+
+    strList *entry =3D have_args ? args : NULL;
+    while (entry !=3D NULL) {
+        argv =3D realloc(argv, sizeof(*argv) * (argc + 1));
+        argv[argc] =3D entry->value;
+        argc++;
+        entry =3D entry->next;
+    }
+
+    code =3D instr_load(path, argc, argv, &id);
+    switch (code) {
+    case INSTR_LOAD_OK:
+        res->id =3D g_strdup(id);
+        break;
+    case INSTR_LOAD_ID_EXISTS:
+        error_setg(errp, "Library ID exists");
+        break;
+    case INSTR_LOAD_TOO_MANY:
+        error_setg(errp, "Tried to load too many libraries");
+        break;
+    case INSTR_LOAD_ERROR:
+        error_setg(errp, "Library initialization returned non-zero");
+        break;
+    case INSTR_LOAD_DLERROR:
+        error_setg(errp, "Error loading library: %s",
+                   dlerror());
+        break;
+    }
+
+    if (*errp) {
+        g_free(res);
+        res =3D NULL;
+    }
+
+    return res;
+}
+
+void qmp_instr_unload(const char *id, Error **errp)
+{
+    InstrUnloadError code =3D instr_unload(id);
+    switch (code) {
+    case INSTR_UNLOAD_OK:
+        break;
+    case INSTR_UNLOAD_INVALID:
+        error_setg(errp, "Unknown library ID");
+        break;
+    case INSTR_UNLOAD_DLERROR:
+        error_setg(errp, "Error unloading library: %s", dlerror());
+        break;
+    }
+}
diff --git a/monitor.c b/monitor.c
index 9239f7adde..e031aa2687 100644
--- a/monitor.c
+++ b/monitor.c
@@ -978,6 +978,10 @@ static void qmp_unregister_commands_hack(void)
     qmp_unregister_command(&qmp_commands, "query-xen-replication-status"=
);
     qmp_unregister_command(&qmp_commands, "xen-colo-do-checkpoint");
 #endif
+#ifndef CONFIG_INSTRUMENT
+    qmp_unregister_command(&qmp_commands, "instr-load");
+    qmp_unregister_command(&qmp_commands, "instr-unload");
+#endif
 #ifndef TARGET_I386
     qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
 #endif
diff --git a/qapi-schema.json b/qapi-schema.json
index f3af2cb851..706c64659f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -93,6 +93,9 @@
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
=20
+# Instrumentation commands
+{ 'include': 'qapi/instrument.json' }
+
 ##
 # =3D Miscellanea
 ##
diff --git a/qapi/instrument.json b/qapi/instrument.json
new file mode 100644
index 0000000000..c59bee74cb
--- /dev/null
+++ b/qapi/instrument.json
@@ -0,0 +1,49 @@
+# *-*- Mode: Python -*-*
+#
+# Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+
+##
+# QAPI instrumentation control commands.
+##
+
+##
+# @InstrLoadResult:
+#
+# Result of an 'instr-load' command.
+#
+# @id: instrumentation library ID
+#
+# Since: 2.11
+##
+{ 'struct': 'InstrLoadResult',
+  'data': { 'id': 'str' } }
+
+##
+# @instr-load:
+#
+# Load an instrumentation library.
+#
+# @path: path to the dynamic instrumentation library
+# @id: unique ID for the loaded library
+# @args: arguments to the dynamic instrumentation library
+#
+# Since: 2.11
+##
+{ 'command': 'instr-load',
+  'data':    { 'path': 'str', '*id': 'str', '*args': ['str'] },
+  'returns': 'InstrLoadResult' }
+
+##
+# @instr-unload:
+#
+# Unload an instrumentation library.
+#
+# @id: unique ID passed to instr-load().
+#
+# Since: 2.11
+##
+{ 'command': 'instr-unload',
+  'data': { 'id': 'str' } }
diff --git a/stubs/instrument.c b/stubs/instrument.c
index 7d66f75454..292a2cdf26 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -7,7 +7,11 @@
  * See the COPYING file in the top-level directory.
  */
=20
+#include "qemu/osdep.h"
+
 #include "instrument/cmdline.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
=20
=20
 void instr_init(const char *path, int argc, const char **argv)
@@ -16,3 +20,21 @@ void instr_init(const char *path, int argc, const char=
 **argv)
 void instr_fini(void)
 {
 }
+
+InstrLoadResult *qmp_instr_load(const char *path,
+                                bool has_id, const char *id,
+                                bool have_args, strList *args,
+                                Error **errp);
+InstrLoadResult *qmp_instr_load(const char *path,
+                                bool has_id, const char *id,
+                                bool have_args, strList *args,
+                                Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+void qmp_instr_unload(const char *id, Error **errp);
+void qmp_instr_unload(const char *id, Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+}
