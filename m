Received: from eggs.gnu.org ([2001:4830:134:3::10]:37974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtL-0006LP-Ez
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehCtH-0004yf-JP
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehCtH-0004xe-9C
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 06:18:51 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  1 Feb 2018 12:18:36 +0100
Message-Id: <20180201111846.21846-10-armbru@redhat.com>
In-Reply-To: <20180201111846.21846-1-armbru@redhat.com>
References: <20180201111846.21846-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/19] qdict qlist: Make most helper macros
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, eblake@redhat.com, f4bug@amsat.org

The macro expansions of qdict_put_TYPE() and qlist_append_TYPE() need
qbool.h, qnull.h, qnum.h and qstring.h to compile.  We include qnull.h
and qnum.h in the headers, but not qbool.h and qstring.h.  Works,
because we include those wherever the macros get used.

Open-coding these helpers is of dubious value.  Turn them into
functions and drop the includes from the headers.

This cleanup makes the number of objects depending on qapi/qmp/qnum.h
from 4551 (out of 4743) to 46 in my "build everything" tree.  For
qapi/qmp/qnull.h, the number drops from 4552 to 21.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/qapi.c                        |  1 +
 blockdev.c                          |  1 +
 hw/i386/acpi-build.c                |  1 +
 hw/ppc/spapr_drc.c                  |  1 +
 include/qapi/qmp/qdict.h            | 16 ++++------------
 include/qapi/qmp/qlist.h            | 15 ++++-----------
 migration/migration.c               |  1 +
 monitor.c                           |  1 +
 qapi/qapi-dealloc-visitor.c         |  1 +
 qapi/qobject-input-visitor.c        |  2 ++
 qapi/qobject-output-visitor.c       |  2 ++
 qobject/json-parser.c               |  2 ++
 qobject/qdict.c                     | 21 +++++++++++++++++++++
 qobject/qjson.c                     |  1 +
 qobject/qlist.c                     | 24 ++++++++++++++++++++++++
 qobject/qlit.c                      |  1 +
 qobject/qobject.c                   |  2 ++
 qom/object.c                        |  1 +
 target/ppc/translate.c              |  1 +
 tests/check-qdict.c                 |  1 +
 tests/check-qjson.c                 |  2 ++
 tests/check-qobject.c               |  2 ++
 tests/test-qmp-commands.c           |  1 +
 tests/test-qmp-event.c              |  1 +
 tests/test-qobject-input-visitor.c  |  2 ++
 tests/test-qobject-output-visitor.c |  2 ++
 util/qemu-option.c                  |  1 +
 27 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 1ab4372519..1e0cb2743d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/block-backend.h"
 #include "qemu/cutils.h"
diff --git a/blockdev.c b/blockdev.c
index 8a47459937..c487cf0e4b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -40,6 +40,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index dc4b2b9ffe..7ff62de52f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -22,6 +22,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qnum.h"
 #include "acpi-build.h"
 #include "qemu-common.h"
 #include "qemu/bitmap.h"
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index e3b122968e..aa251133de 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -12,6 +12,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qnull.h"
 #include "cpu.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_drc.h"
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index d0c298114e..3c1def00f7 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -15,8 +15,6 @@
=20
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
 #include "qemu/queue.h"
=20
 #define QDICT_BUCKET_MAX 512
@@ -55,17 +53,11 @@ void qdict_destroy_obj(QObject *obj);
 #define qdict_put(qdict, key, obj) \
         qdict_put_obj(qdict, key, QOBJECT(obj))
=20
-/* Helpers for int, bool, null, and string */
-#define qdict_put_int(qdict, key, value) \
-        qdict_put(qdict, key, qnum_from_int(value))
-#define qdict_put_bool(qdict, key, value) \
-        qdict_put(qdict, key, qbool_from_bool(value))
-#define qdict_put_str(qdict, key, value) \
-        qdict_put(qdict, key, qstring_from_str(value))
-#define qdict_put_null(qdict, key) \
-        qdict_put(qdict, key, qnull())
+void qdict_put_bool(QDict *qdict, const char *key, bool value);
+void qdict_put_int(QDict *qdict, const char *key, int64_t value);
+void qdict_put_null(QDict *qdict, const char *key);
+void qdict_put_str(QDict *qdict, const char *key, const char *value);
=20
-/* High level helpers */
 double qdict_get_double(const QDict *qdict, const char *key);
 int64_t qdict_get_int(const QDict *qdict, const char *key);
 bool qdict_get_bool(const QDict *qdict, const char *key);
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index 632b7ef2c1..5fd976a398 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -14,8 +14,6 @@
 #define QLIST_H
=20
 #include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qnull.h"
 #include "qemu/queue.h"
=20
 typedef struct QListEntry {
@@ -31,15 +29,10 @@ struct QList {
 #define qlist_append(qlist, obj) \
         qlist_append_obj(qlist, QOBJECT(obj))
=20
-/* Helpers for int, bool, and string */
-#define qlist_append_int(qlist, value) \
-        qlist_append(qlist, qnum_from_int(value))
-#define qlist_append_bool(qlist, value) \
-        qlist_append(qlist, qbool_from_bool(value))
-#define qlist_append_str(qlist, value) \
-        qlist_append(qlist, qstring_from_str(value))
-#define qlist_append_null(qlist) \
-        qlist_append(qlist, qnull())
+void qlist_append_bool(QList *qlist, bool value);
+void qlist_append_int(QList *qlist, int64_t value);
+void qlist_append_null(QList *qlist);
+void qlist_append_str(QList *qlist, const char *value);
=20
 #define QLIST_FOREACH_ENTRY(qlist, var)             \
         for ((var) =3D ((qlist)->head.tqh_first);     \
diff --git a/migration/migration.c b/migration/migration.c
index 79ec88dba2..26865dc6df 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -32,6 +32,7 @@
 #include "block/block.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qnull.h"
 #include "qemu/rcu.h"
 #include "block.h"
 #include "postcopy-ram.h"
diff --git a/monitor.c b/monitor.c
index f38640c1e4..20f7b159b3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -54,6 +54,7 @@
 #include "sysemu/tpm.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index c7d5f80302..fd23803166 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -14,6 +14,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
+#include "qapi/qmp/qnull.h"
 #include "qemu/queue.h"
 #include "qemu-common.h"
 #include "qapi/visitor-impl.h"
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 8fb34c472e..31183dcb62 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -22,6 +22,8 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
=20
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
index 60398765df..f0cc46b3cf 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -18,6 +18,8 @@
 #include "qemu/queue.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
=20
 typedef struct QStackEntry {
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 30dfb9dc41..8f4badc6d9 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -16,6 +16,8 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-lexer.h"
diff --git a/qobject/qdict.c b/qobject/qdict.c
index e8f15f1132..7e7ac24cf7 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -14,6 +14,7 @@
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnull.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/error.h"
@@ -143,6 +144,26 @@ void qdict_put_obj(QDict *qdict, const char *key, QO=
bject *value)
     }
 }
=20
+void qdict_put_int(QDict *qdict, const char *key, int64_t value)
+{
+    qdict_put(qdict, key, qnum_from_int(value));
+}
+
+void qdict_put_bool(QDict *qdict, const char *key, bool value)
+{
+    qdict_put(qdict, key, qbool_from_bool(value));
+}
+
+void qdict_put_str(QDict *qdict, const char *key, const char *value)
+{
+    qdict_put(qdict, key, qstring_from_str(value));
+}
+
+void qdict_put_null(QDict *qdict, const char *key)
+{
+    qdict_put(qdict, key, qnull());
+}
+
 /**
  * qdict_get(): Lookup for a given 'key'
  *
diff --git a/qobject/qjson.c b/qobject/qjson.c
index fe89213247..7fbb68b6ba 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -18,6 +18,7 @@
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnum.h"
 #include "qemu/unicode.h"
=20
 typedef struct JSONParsingState
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 3ef57d31d1..268e46c8f0 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -11,8 +11,12 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qstring.h"
 #include "qemu/queue.h"
 #include "qemu-common.h"
=20
@@ -64,6 +68,26 @@ void qlist_append_obj(QList *qlist, QObject *value)
     QTAILQ_INSERT_TAIL(&qlist->head, entry, next);
 }
=20
+void qlist_append_int(QList *qlist, int64_t value)
+{
+    qlist_append(qlist, qnum_from_int(value));
+}
+
+void qlist_append_bool(QList *qlist, bool value)
+{
+    qlist_append(qlist, qbool_from_bool(value));
+}
+
+void qlist_append_str(QList *qlist, const char *value)
+{
+    qlist_append(qlist, qstring_from_str(value));
+}
+
+void qlist_append_null(QList *qlist)
+{
+    qlist_append(qlist, qnull());
+}
+
 /**
  * qlist_iter(): Iterate over all the list's stored values.
  *
diff --git a/qobject/qlit.c b/qobject/qlit.c
index dbf19225c8..c2d0303425 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -17,6 +17,7 @@
=20
 #include "qapi/qmp/qlit.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
=20
diff --git a/qobject/qobject.c b/qobject/qobject.c
index 9b61ece06b..5bbcd04812 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -10,6 +10,8 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
=20
diff --git a/qom/object.c b/qom/object.c
index c58c52d518..d97f09c1fb 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -27,6 +27,7 @@
 #include "qom/qom-qobject.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
=20
 #define MAX_INTERFACES 32
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4132f67bb1..eeaad9e91f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -24,6 +24,7 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
+#include "qapi/qmp/qnull.h"
 #include "qemu/host-utils.h"
 #include "exec/cpu_ldst.h"
=20
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 35405778cc..1b1173634f 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 7881009f1c..26f5d4401e 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -17,6 +17,8 @@
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlit.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qemu-common.h"
=20
 static void escaped_string(void)
diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 06b9c6ec34..9e1e82045f 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -9,6 +9,8 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu-common.h"
=20
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 4794d1a9d8..b5a3d88775 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "test-qmp-commands.h"
 #include "qapi/error.h"
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index b197dff453..cad94778c7 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -18,6 +18,7 @@
 #include "test-qapi-event.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inpu=
t-visitor.c
index 96405991bb..20bf9a5414 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -18,6 +18,8 @@
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qjson.h"
 #include "test-qmp-introspect.h"
 #include "qmp-introspect.h"
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-out=
put-visitor.c
index a0b7fe6add..4a24e12121 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -17,6 +17,8 @@
 #include "qapi/qobject-output-visitor.h"
 #include "test-qapi-visit.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qnull.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qjson.h"
=20
 typedef struct TestOutputVisitorData {
diff --git a/util/qemu-option.c b/util/qemu-option.c
index d790c1b85a..a401e936da 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/option_int.h"
--=20
2.13.6
