Received: from eggs.gnu.org ([2001:4830:134:3::10]:40801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhRf-0003hH-H3
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhRc-0004Ay-DS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:47:03 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:35543)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZhRc-0004Al-11
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:47:00 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 24 Jul 2017 20:46:50 +0300
Message-Id: <150091841019.30739.3661641061220051037.stgit@frigg.lan>
In-Reply-To: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/13] instrument: [qapi] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 instrument/Makefile.objs |    1 +
 instrument/qmp.c         |   71 ++++++++++++++++++++++++++++++++++++
 qapi-schema.json         |    3 ++
 qapi/instrument.json     |   92 ++++++++++++++++++++++++++++++++++++++++=
++++++
 4 files changed, 167 insertions(+)
 create mode 100644 instrument/qmp.c
 create mode 100644 qapi/instrument.json

diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index aa6db29ff4..757a247321 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -44,3 +44,4 @@ $(obj)/qemu-instr/events.h-timestamp: $(BUILD_DIR)/trac=
e-events-all $(BUILD_DIR)
=20
 target-obj-y +=3D control.o
 target-obj-y +=3D cmdline.o
+target-obj-y +=3D qmp.o
diff --git a/instrument/qmp.c b/instrument/qmp.c
new file mode 100644
index 0000000000..3f577e0c78
--- /dev/null
+++ b/instrument/qmp.c
@@ -0,0 +1,71 @@
+/*
+ * QMP interface for dynamic trace instrumentation control commands.
+ *
+ * Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/qmp/qerror.h"
+#include "qmp-commands.h"
+
+#include <dlfcn.h>
+
+#include "instrument/control.h"
+
+
+
+InstrLoadResult *qmp_instr_load(const char * path,
+                                bool have_args, StringList * args,
+                                Error **errp)
+{
+    int argc =3D 0;
+    const char **argv =3D NULL;
+
+    StringList *entry =3D have_args ? args : NULL;
+    while (entry !=3D NULL) {
+        argv =3D realloc(argv, sizeof(*argv) * (argc + 1));
+        argv[argc] =3D entry->value->str;
+        argc++;
+        entry =3D entry->next;
+    }
+
+    InstrLoadResult *res =3D g_malloc0(sizeof(*res));
+    res->code =3D instr_load(path, argc, argv, &res->handle);
+    switch (res->code) {
+    case INSTR_LOAD_CODE_OK:
+    case INSTR_LOAD_CODE_UNAVAILABLE:
+        break;
+    case INSTR_LOAD_CODE_ERROR:
+        res->msg =3D dlerror();
+        break;
+    default:
+        fprintf(stderr, "Unknown instrumentation load code: %d", res->co=
de);
+        exit(1);
+        break;
+    }
+    return res;
+}
+
+InstrUnloadResult *qmp_instr_unload(int64_t handle, Error **errp)
+{
+    InstrUnloadResult *res =3D g_malloc0(sizeof(*res));
+    res->code =3D instr_unload(handle);
+    switch (res->code) {
+    case INSTR_UNLOAD_OK:
+    case INSTR_UNLOAD_UNAVAILABLE:
+    case INSTR_UNLOAD_INVALID:
+        break;
+    case INSTR_UNLOAD_CODE_ERROR:
+        res->msg =3D dlerror();
+        break;
+    default:
+        fprintf(stderr, "Unknown instrumentation unload code: %d", res->=
code);
+        exit(1);
+        break;
+    }
+    return res;
+}
diff --git a/qapi-schema.json b/qapi-schema.json
index ab438ead70..6c4f237af8 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -90,6 +90,9 @@
 # QAPI introspection
 { 'include': 'qapi/introspect.json' }
=20
+# Instrumentation commands
+{ 'include': 'qapi/instrument.json' }
+
 ##
 # =3D QMP commands
 ##
diff --git a/qapi/instrument.json b/qapi/instrument.json
new file mode 100644
index 0000000000..f0d725e9a9
--- /dev/null
+++ b/qapi/instrument.json
@@ -0,0 +1,92 @@
+# *-*- Mode: Python -*-*
+#
+# QAPI trace instrumentation control commands.
+#
+# Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+
+##
+# @InstrLoadCode:
+#
+# Result code of an 'instr-load' command.
+#
+# @ok: Correctly loaded.
+# @unavailable: Service not available.
+# @error: Error with libdl (see 'msg').
+#
+# Since: 2.10
+##
+{ 'enum': 'InstrLoadCode',
+  'data': [ 'ok', 'unavailable', 'error' ] }
+
+##
+# @InstrLoadResult:
+#
+# Result of an 'instr-load' command.
+#
+# @code: Result code.
+# @msg: Additional error message.
+# @handle: Instrumentation library identifier (undefined in case of erro=
r).
+#
+# Since: 2.10
+##
+{ 'struct': 'InstrLoadResult',
+  'data': { 'code': 'InstrLoadCode', 'msg': 'str', 'handle': 'int' } }
+
+##
+# @instr-load:
+#
+# Load an instrumentation library.
+#
+# @path: path to the dynamic instrumentation library
+# @args: arguments to the dynamic instrumentation library
+#
+# Since: 2.10
+##
+{ 'command': 'instr-load',
+  'data':    { 'path': 'str', '*args': ['String'] },
+  'returns': 'InstrLoadResult' }
+
+
+##
+# @InstrUnloadCode:
+#
+# Result code of an 'instr-unload' command.
+#
+# @ok: Correctly unloaded.
+# @unavailable: Service not available.
+# @invalid: Invalid handle.
+# @error: Error with libdl (see 'msg').
+#
+# Since: 2.10
+##
+{ 'enum': 'InstrUnloadCode',
+  'data': [ 'ok', 'unavailable', 'invalid', 'error' ] }
+
+##
+# @InstrUnloadResult:
+#
+# Result of an 'instr-unload' command.
+#
+# @code: Result code.
+# @msg: Additional error message.
+#
+# Since: 2.10
+##
+{ 'struct': 'InstrUnloadResult',
+  'data': { 'code': 'InstrUnloadCode', 'msg': 'str' } }
+
+##
+# @instr-unload:
+#
+# Unload an instrumentation library.
+#
+# @handle: Instrumentation library identifier (see #InstrLoadResult).
+#
+# Since: 2.10
+##
+{ 'command': 'instr-unload',
+  'data': { 'handle': 'int' },
+  'returns': 'InstrUnloadResult' }
