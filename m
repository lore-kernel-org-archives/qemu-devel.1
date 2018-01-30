Received: from eggs.gnu.org ([2001:4830:134:3::10]:59397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3K-00046T-F0
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egT3H-0000aA-JS
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egT3H-0000Z6-9n
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:22:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79D58C03675C
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC1407089E
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 10:22:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Jan 2018 11:21:51 +0100
Message-Id: <20180130102202.28519-8-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-1-armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/18] Eliminate qapi/qmp/types.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qapi/qmp/types.h is a convenience header to include a number of
qapi/qmp/ headers.  Since we rarely need all of the headers
qapi/qmp/types.h includes, we bypass it most of the time.  Most of the
places that use it don't need all the headers, either.

Include the necessary headers directly, and drop qapi/qmp/types.h.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/qapi.c                        |  3 ++-
 block/qcow2.c                       |  3 ++-
 blockdev.c                          |  2 +-
 hw/pci/pcie_aer.c                   |  1 -
 hw/watchdog/watchdog.c              |  1 -
 include/qapi/qmp/types.h            | 24 ------------------------
 monitor.c                           |  2 +-
 qapi/qapi-dealloc-visitor.c         |  1 -
 qapi/qmp-dispatch.c                 |  1 -
 qapi/qobject-input-visitor.c        |  2 +-
 qapi/qobject-output-visitor.c       |  3 ++-
 qobject/json-parser.c               |  3 ++-
 qobject/qjson.c                     |  2 +-
 qobject/qlit.c                      |  4 +++-
 qobject/qobject.c                   |  4 +++-
 scripts/qapi-commands.py            |  1 -
 target/i386/cpu.c                   |  1 -
 tests/check-qjson.c                 |  2 +-
 tests/check-qobject.c               |  3 ++-
 tests/cpu-plug-test.c               |  1 -
 tests/qom-test.c                    |  1 -
 tests/test-clone-visitor.c          |  1 -
 tests/test-qmp-commands.c           |  3 ++-
 tests/test-qmp-event.c              |  3 ++-
 tests/test-qobject-input-visitor.c  |  2 +-
 tests/test-qobject-output-visitor.c |  2 +-
 tests/test-string-input-visitor.c   |  1 -
 tests/test-string-output-visitor.c  |  1 -
 tests/test-visitor-serialization.c  |  1 -
 ui/vnc.c                            |  1 -
 util/qemu-option.c                  |  4 +++-
 31 files changed, 30 insertions(+), 54 deletions(-)
 delete mode 100644 include/qapi/qmp/types.h

diff --git a/block/qapi.c b/block/qapi.c
index 4fc9fd8082..1ab4372519 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -31,7 +31,8 @@
 #include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qstring.h"
 #include "sysemu/block-backend.h"
 #include "qemu/cutils.h"
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 7645b3c6ae..700c06245b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -32,7 +32,8 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi-event.h"
 #include "trace.h"
 #include "qemu/option_int.h"
diff --git a/blockdev.c b/blockdev.c
index ad82dbbeee..8a47459937 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -40,7 +40,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index b009be7f17..071e5e9bbb 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
-#include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
 #include "monitor/monitor.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 25dcb25ff1..98a5dd6689 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -24,7 +24,6 @@
 #include "qemu/config-file.h"
 #include "qemu/queue.h"
 #include "qapi/error.h"
-#include "qapi/qmp/types.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/watchdog.h"
 #include "qapi-event.h"
diff --git a/include/qapi/qmp/types.h b/include/qapi/qmp/types.h
deleted file mode 100644
index 749ac44dcb..0000000000
--- a/include/qapi/qmp/types.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Include all QEMU objects.
- *
- * Copyright (C) 2009 Red Hat Inc.
- *
- * Authors:
- *  Luiz Capitulino <lcapitulino@redhat.com>
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING.LIB file in the top-level directory.
- */
-
-#ifndef QAPI_QMP_TYPES_H
-#define QAPI_QMP_TYPES_H
-
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-
-#endif /* QAPI_QMP_TYPES_H */
diff --git a/monitor.c b/monitor.c
index 2de69f648f..f38640c1e4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -53,7 +53,7 @@
 #include "qemu/acl.h"
 #include "sysemu/tpm.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index ed70a0158b..c7d5f80302 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -16,7 +16,6 @@
 #include "qapi/dealloc-visitor.h"
 #include "qemu/queue.h"
 #include "qemu-common.h"
-#include "qapi/qmp/types.h"
 #include "qapi/visitor-impl.h"
 
 struct QapiDeallocVisitor
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 8829c4a45a..92f957f40e 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/types.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qjson.h"
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index ee9e47d911..8fb34c472e 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -20,7 +20,7 @@
 #include "qemu/queue.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index d325163e55..60398765df 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -17,7 +17,8 @@
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
 #include "qemu-common.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qstring.h"
 
 typedef struct QStackEntry {
     QObject *value;
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 724ca240e4..30dfb9dc41 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -15,7 +15,8 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-lexer.h"
 #include "qapi/qmp/json-streamer.h"
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 2e0930884e..fe89213247 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -17,7 +17,7 @@
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/qjson.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
 #include "qemu/unicode.h"
 
 typedef struct JSONParsingState
diff --git a/qobject/qlit.c b/qobject/qlit.c
index 3c4882c784..dbf19225c8 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -16,7 +16,9 @@
 #include "qemu/osdep.h"
 
 #include "qapi/qmp/qlit.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
 
 static bool qlit_equal_qdict(const QLitObject *lhs, const QDict *qdict)
 {
diff --git a/qobject/qobject.c b/qobject/qobject.c
index b2a536041d..9b61ece06b 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -9,7 +9,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
 
 static void (*qdestroy[QTYPE__MAX])(QObject *) = {
     [QTYPE_NONE] = NULL,               /* No such object exists */
diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
index dc7c418923..26c56c5062 100644
--- a/scripts/qapi-commands.py
+++ b/scripts/qapi-commands.py
@@ -293,7 +293,6 @@ fdef.write(mcgen('''
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/module.h"
-#include "qapi/qmp/types.h"
 #include "qapi/visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ae44c9d8ad..6627e98bdf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -32,7 +32,6 @@
 #include "qemu/config-file.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/types.h"
 
 #include "qapi-visit.h"
 #include "qapi/visitor.h"
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 59227934ce..7881009f1c 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlit.h"
 #include "qemu-common.h"
diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 710f9e6b0a..06b9c6ec34 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -8,7 +8,8 @@
  */
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qstring.h"
 #include "qemu-common.h"
 
 #include <math.h>
diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 05d82f76c4..65456c9e37 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -11,7 +11,6 @@
 
 #include "qemu-common.h"
 #include "libqtest.h"
-#include "qapi/qmp/types.h"
 
 struct PlugTestData {
     char *machine;
diff --git a/tests/qom-test.c b/tests/qom-test.c
index ab0595dc75..0ee990710c 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -12,7 +12,6 @@
 #include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
-#include "qapi/qmp/types.h"
 
 static const char *blacklist_x86[] = {
     "xenfv", "xenpv", NULL
diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
index 6b6d4aaeba..9aeaf86a07 100644
--- a/tests/test-clone-visitor.c
+++ b/tests/test-clone-visitor.c
@@ -12,7 +12,6 @@
 #include "qemu-common.h"
 #include "qapi/clone-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/types.h"
 
 static void test_clone_struct(void)
 {
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 52c1802eaf..4794d1a9d8 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
 #include "test-qmp-commands.h"
 #include "qapi/error.h"
 #include "qapi/qmp/dispatch.h"
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 5be2d8efcf..b197dff453 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -17,8 +17,9 @@
 #include "test-qapi-visit.h"
 #include "test-qapi-event.h"
 #include "qapi/error.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qobject.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
 
 typedef struct TestEventData {
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index ade6062e2c..96405991bb 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -17,7 +17,7 @@
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
 #include "test-qmp-introspect.h"
 #include "qmp-introspect.h"
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-output-visitor.c
index 1cff769b15..a0b7fe6add 100644
--- a/tests/test-qobject-output-visitor.c
+++ b/tests/test-qobject-output-visitor.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "qapi/qobject-output-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qjson.h"
 
 typedef struct TestOutputVisitorData {
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 4473944f3f..88e0e1aa9a 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -16,7 +16,6 @@
 #include "qapi/error.h"
 #include "qapi/string-input-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/types.h"
 
 typedef struct TestInputVisitorData {
     Visitor *v;
diff --git a/tests/test-string-output-visitor.c b/tests/test-string-output-visitor.c
index facb76ffc3..fa4b4ca288 100644
--- a/tests/test-string-output-visitor.c
+++ b/tests/test-string-output-visitor.c
@@ -16,7 +16,6 @@
 #include "qapi/error.h"
 #include "qapi/string-output-visitor.h"
 #include "test-qapi-visit.h"
-#include "qapi/qmp/types.h"
 
 typedef struct TestOutputVisitorData {
     Visitor *ov;
diff --git a/tests/test-visitor-serialization.c b/tests/test-visitor-serialization.c
index a3407d205d..928a82b2e6 100644
--- a/tests/test-visitor-serialization.c
+++ b/tests/test-visitor-serialization.c
@@ -17,7 +17,6 @@
 #include "qemu-common.h"
 #include "test-qapi-visit.h"
 #include "qapi/error.h"
-#include "qapi/qmp/types.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index 9bcc2c0db9..8458e6d9fe 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -35,7 +35,6 @@
 #include "qemu/acl.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
-#include "qapi/qmp/types.h"
 #include "qmp-commands.h"
 #include "ui/input.h"
 #include "qapi-event.h"
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 553d3dc552..d790c1b85a 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -28,7 +28,9 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/types.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
-- 
2.13.6
