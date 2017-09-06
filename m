Received: from eggs.gnu.org ([2001:4830:134:3::10]:41657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpeTp-0000EX-VC
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpeTl-0005pB-2i
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:51:14 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:41489)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpeTk-0005oB-Id
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 13:51:08 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 20:50:57 +0300
Message-Id: <150472025751.24907.6133235993130047929.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 07/20] instrument: [qapi] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 instrument/Makefile.objs |    1=20
 instrument/load.h        |    4 ++
 instrument/qmp.c         |   88 ++++++++++++++++++++++++++++++++++++++++=
++
 qapi-schema.json         |    3 +
 qapi/instrument.json     |   96 ++++++++++++++++++++++++++++++++++++++++=
++++++
 5 files changed, 192 insertions(+)
 create mode 100644 instrument/qmp.c
 create mode 100644 qapi/instrument.json

diff --git a/instrument/Makefile.objs b/instrument/Makefile.objs
index 5ea5c77245..13a8f60431 100644
--- a/instrument/Makefile.objs
+++ b/instrument/Makefile.objs
@@ -2,3 +2,4 @@
=20
 target-obj-y +=3D cmdline.o
 target-obj-$(CONFIG_INSTRUMENT) +=3D load.o
+target-obj-y +=3D qmp.o
diff --git a/instrument/load.h b/instrument/load.h
index 2ddb2c6c19..f8a02e6849 100644
--- a/instrument/load.h
+++ b/instrument/load.h
@@ -25,6 +25,8 @@
  * @INSTR_LOAD_DLERROR: Error with libdl (see dlerror).
  *
  * Error codes for instr_load().
+ *
+ * NOTE: Keep in sync with QAPI's #InstrLoadCode.
  */
 typedef enum {
     INSTR_LOAD_OK,
@@ -40,6 +42,8 @@ typedef enum {
  * @INSTR_UNLOAD_DLERROR: Error with libdl (see dlerror).
  *
  * Error codes for instr_unload().
+ *
+ * NOTE: Keep in sync with QAPI's #InstrUnloadCode.
  */
 typedef enum {
     INSTR_UNLOAD_OK,
diff --git a/instrument/qmp.c b/instrument/qmp.c
new file mode 100644
index 0000000000..c36960c12f
--- /dev/null
+++ b/instrument/qmp.c
@@ -0,0 +1,88 @@
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
+#include "qemu-common.h"
+#include "qapi/qmp/qerror.h"
+#include "qmp-commands.h"
+
+#include <dlfcn.h>
+
+#include "instrument/load.h"
+
+
+
+InstrLoadResult *qmp_instr_load(const char * path,
+                                bool have_args, strList * args,
+                                Error **errp)
+{
+    InstrLoadResult *res =3D g_malloc0(sizeof(*res));
+
+#if defined(CONFIG_INSTRUMENT)
+    int argc =3D 0;
+    const char **argv =3D NULL;
+
+    strList *entry =3D have_args ? args : NULL;
+    while (entry !=3D NULL) {
+        argv =3D realloc(argv, sizeof(*argv) * (argc + 1));
+        argv[argc] =3D entry->value;
+        argc++;
+        entry =3D entry->next;
+    }
+
+    InstrLoadError code =3D instr_load(path, argc, argv, &res->handle);
+    switch (code) {
+    case INSTR_LOAD_OK:
+        res->code =3D INSTR_LOAD_CODE_OK;
+        res->has_handle =3D true;
+        break;
+    case INSTR_LOAD_TOO_MANY:
+        res->code =3D INSTR_LOAD_CODE_TOO_MANY;
+        break;
+    case INSTR_LOAD_ERROR:
+        res->code =3D INSTR_LOAD_CODE_ERROR;
+        break;
+    case INSTR_LOAD_DLERROR:
+        res->has_msg =3D true;
+        res->msg =3D dlerror();
+        res->code =3D INSTR_LOAD_CODE_DLERROR;
+        break;
+    }
+#else
+    res->code =3D INSTR_LOAD_CODE_UNAVAILABLE;
+#endif
+
+    return res;
+}
+
+InstrUnloadResult *qmp_instr_unload(int64_t handle, Error **errp)
+{
+    InstrUnloadResult *res =3D g_malloc0(sizeof(*res));
+
+#if defined(CONFIG_INSTRUMENT)
+    InstrUnloadError code =3D instr_unload(handle);
+    switch (code) {
+    case INSTR_UNLOAD_OK:
+        res->code =3D INSTR_UNLOAD_CODE_OK;
+        break;
+    case INSTR_UNLOAD_INVALID:
+        res->code =3D INSTR_UNLOAD_CODE_INVALID;
+        break;
+    case INSTR_UNLOAD_DLERROR:
+        res->has_msg =3D true;
+        res->msg =3D dlerror();
+        break;
+        res->code =3D INSTR_UNLOAD_CODE_DLERROR;
+    }
+#else
+    res->code =3D INSTR_UNLOAD_CODE_UNAVAILABLE;
+#endif
+
+    return res;
+}
diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53d00..5e343be9ff 100644
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
index 0000000000..ea63fae309
--- /dev/null
+++ b/qapi/instrument.json
@@ -0,0 +1,96 @@
+# *-*- Mode: Python -*-*
+#
+# QAPI instrumentation control commands.
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
+# @too-many: Tried to load too many instrumentation libraries.
+# @error: The library's main() function returned a non-zero value.
+# @dlerror: Error with libdl (see 'msg').
+# @unavailable: Service not available.
+#
+# Since: 2.11
+##
+{ 'enum': 'InstrLoadCode',
+  'data': [ 'ok', 'too-many', 'error', 'dlerror', 'unavailable' ] }
+
+##
+# @InstrLoadResult:
+#
+# Result of an 'instr-load' command.
+#
+# @code: Result code.
+# @msg: Additional error message (for human consumption only; present on=
ly in
+#       case of error).
+# @handle: Instrumentation library identifier (present only if successfu=
l).
+#
+# Since: 2.11
+##
+{ 'struct': 'InstrLoadResult',
+  'data': { 'code': 'InstrLoadCode', '*msg': 'str', '*handle': 'int' } }
+
+##
+# @instr-load:
+#
+# Load an instrumentation library.
+#
+# @path: path to the dynamic instrumentation library
+# @args: arguments to the dynamic instrumentation library
+#
+# Since: 2.11
+##
+{ 'command': 'instr-load',
+  'data':    { 'path': 'str', '*args': ['str'] },
+  'returns': 'InstrLoadResult' }
+
+
+##
+# @InstrUnloadCode:
+#
+# Result code of an 'instr-unload' command.
+#
+# @ok: Correctly unloaded.
+# @invalid: Invalid handle.
+# @dlerror: Error with libdl (see 'msg').
+# @unavailable: Service not available.
+#
+# Since: 2.11
+##
+{ 'enum': 'InstrUnloadCode',
+  'data': [ 'ok', 'invalid', 'dlerror', 'unavailable' ] }
+
+##
+# @InstrUnloadResult:
+#
+# Result of an 'instr-unload' command.
+#
+# @code: Result code.
+# @msg: Additional error message (for human consumption only; present on=
ly in
+#       case of error).
+#
+# Since: 2.11
+##
+{ 'struct': 'InstrUnloadResult',
+  'data': { 'code': 'InstrUnloadCode', '*msg': 'str' } }
+
+##
+# @instr-unload:
+#
+# Unload an instrumentation library.
+#
+# @handle: Instrumentation library identifier (see #InstrLoadResult).
+#
+# Since: 2.11
+##
+{ 'command': 'instr-unload',
+  'data': { 'handle': 'int' },
+  'returns': 'InstrUnloadResult' }
