Received: from eggs.gnu.org ([2001:4830:134:3::10]:46185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BY-0002If-4o
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BW-0004aT-2q
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:08 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 25 Jul 2017 16:15:19 -0500
Message-Id: <20170725211523.3998-9-eblake@redhat.com>
In-Reply-To: <20170725211523.3998-1-eblake@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/12] qtests: convert tests to use qmp_cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, armbru@redhat.com, John Snow <jsnow@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

Now that we have the qmp_cmd() helper, we can further simplify
some of the tests by using it.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/device-introspect-test.c |  3 +--
 tests/ide-test.c               |  2 +-
 tests/libqos/libqos.c          |  5 +++--
 tests/libqos/pci-pc.c          |  4 ++--
 tests/libqos/usb.c             | 18 +++++++++---------
 tests/pc-cpu-test.c            | 10 +++++-----
 tests/postcopy-test.c          |  9 +++++----
 tests/vhost-user-test.c        | 12 ++++++------
 8 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index f7162c023f..fc6d559e14 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -36,8 +36,7 @@ static QList *qom_list_types(const char *implements, bool abstract)
     if (implements) {
         qdict_put_str(args, "implements", implements);
     }
-    resp = qmp("{'execute': 'qom-list-types',"
-               " 'arguments': %p }", args);
+    resp = qmp_cmd("qom-list-types", QOBJECT(args));
     g_assert(qdict_haskey(resp, "return"));
     ret = qdict_get_qlist(resp, "return");
     QINCREF(ret);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index ea2657d3d1..75dc472e6a 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -651,7 +651,7 @@ static void test_retry_flush(const char *machine)
     qmp_eventwait("STOP");

     /* Complete the command */
-    qmp_discard_response("{'execute':'cont' }");
+    qmp_cmd_discard_response("cont", NULL);

     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 42c5315423..18844617ae 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -4,6 +4,7 @@
 #include "libqtest.h"
 #include "libqos/libqos.h"
 #include "libqos/pci.h"
+#include "qapi/qmp/qjson.h"

 /*** Test Setup & Teardown ***/

@@ -86,7 +87,7 @@ void set_context(QOSState *s)

 static QDict *qmp_execute(const char *command)
 {
-    return qmp("{ 'execute': %s }", command);
+    return qmp_cmd(command, NULL);
 }

 void migrate(QOSState *from, QOSState *to, const char *uri)
@@ -106,7 +107,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     QDECREF(rsp);

     /* Issue the migrate command. */
-    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
+    rsp = qmp_cmd("migrate", qobject_from_jsonf("{ 'uri': %s }", uri));
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index d40aa9dffd..8494671290 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -17,6 +17,7 @@
 #include "hw/pci/pci_regs.h"

 #include "qemu-common.h"
+#include "qapi/qmp/qjson.h"


 #define ACPI_PCIHP_ADDR         0xae00
@@ -160,8 +161,7 @@ void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
 {
     QDict *response;

-    response = qmp("{'execute': 'device_del', 'arguments': {'id': %s}}",
-                   id);
+    response = qmp_cmd("device_del", qobject_from_jsonf("{'id': %s}", id));
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
index f88d4a6a3a..a96f5ebd6a 100644
--- a/tests/libqos/usb.c
+++ b/tests/libqos/usb.c
@@ -15,6 +15,7 @@
 #include "libqtest.h"
 #include "hw/usb/uhci-regs.h"
 #include "libqos/usb.h"
+#include "qapi/qmp/qjson.h"

 void qusb_pci_init_one(QPCIBus *pcibus, struct qhc *hc, uint32_t devfn, int bar)
 {
@@ -46,13 +47,13 @@ void usb_test_hotplug(const char *hcd_id, const int port,

     sprintf(id, "usbdev%d", port);
     bus = g_strdup_printf("%s.0", hcd_id);
-    response = qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': 'usb-tablet',"
-                   "   'port': %s,"
-                   "   'bus': %s,"
-                   "   'id': %s"
-                   " }}", id + 6, bus, id);
+    response = qmp_cmd("device_add",
+                       qobject_from_jsonf("{"
+                                          "   'driver': 'usb-tablet',"
+                                          "   'port': %s,"
+                                          "   'bus': %s,"
+                                          "   'id': %s"
+                                          "}", id + 6, bus, id));
     g_free(bus);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
@@ -62,8 +63,7 @@ void usb_test_hotplug(const char *hcd_id, const int port,
         port_check();
     }

-    response = qmp("{'execute': 'device_del', 'arguments': { 'id': %s }}",
-                   id);
+    response = qmp_cmd("device_del", qobject_from_jsonf("{ 'id': %s }", id));
     g_assert(response);
     g_assert(qdict_haskey(response, "event"));
     g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
index c4211a4e85..9eb4c16965 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/pc-cpu-test.c
@@ -12,6 +12,7 @@
 #include "qemu-common.h"
 #include "libqtest.h"
 #include "qapi/qmp/types.h"
+#include "qapi/qmp/qjson.h"

 struct PCTestData {
     char *machine;
@@ -37,8 +38,7 @@ static void test_pc_with_cpu_add(gconstpointer data)
     qtest_start(args);

     for (i = s->sockets * s->cores * s->threads; i < s->maxcpus; i++) {
-        response = qmp("{ 'execute': 'cpu-add',"
-                       "  'arguments': { 'id': %d } }", i);
+        response = qmp_cmd("cpu-add", qobject_from_jsonf("{'id':%u}", i));
         g_assert(response);
         g_assert(!qdict_haskey(response, "error"));
         QDECREF(response);
@@ -60,9 +60,9 @@ static void test_pc_without_cpu_add(gconstpointer data)
                            s->sockets, s->cores, s->threads, s->maxcpus);
     qtest_start(args);

-    response = qmp("{ 'execute': 'cpu-add',"
-                   "  'arguments': { 'id': %d } }",
-                   s->sockets * s->cores * s->threads);
+    response = qmp_cmd("cpu-add",
+                       qobject_from_jsonf("{'id':%u}",
+                                          s->sockets * s->cores * s->threads));
     g_assert(response);
     g_assert(qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index e2ead875a8..f6e7340a6a 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -19,6 +19,7 @@
 #include "chardev/char.h"
 #include "sysemu/sysemu.h"
 #include "hw/nvram/chrp_nvram.h"
+#include "qapi/qmp/qjson.h"

 #define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */

@@ -252,7 +253,7 @@ static uint64_t get_migration_pass(void)
     QDict *rsp, *rsp_return, *rsp_ram;
     uint64_t result;

-    rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+    rsp = return_or_event(qmp_cmd("query-migrate", NULL));
     rsp_return = qdict_get_qdict(rsp, "return");
     if (!qdict_haskey(rsp_return, "ram")) {
         /* Still in setup */
@@ -273,7 +274,7 @@ static void wait_for_migration_complete(void)
     do {
         const char *status;

-        rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+        rsp = return_or_event(qmp_cmd("query-migrate", NULL));
         rsp_return = qdict_get_qdict(rsp, "return");
         status = qdict_get_str(rsp_return, "status");
         completed = strcmp(status, "completed") == 0;
@@ -445,13 +446,13 @@ static void test_migrate(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");

-    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
+    rsp = qmp_cmd("migrate", qobject_from_jsonf("{ 'uri': %s }", uri));
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

     wait_for_migration_pass();

-    rsp = return_or_event(qmp("{ 'execute': 'migrate-start-postcopy' }"));
+    rsp = return_or_event(qmp_cmd("migrate-start-postcopy", NULL));
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index f2a2b6cad9..88e1e20f99 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -9,6 +9,10 @@
  */

 #include "qemu/osdep.h"
+#include <linux/vhost.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_net.h>
+#include <sys/vfs.h>

 #include "libqtest.h"
 #include "qapi/error.h"
@@ -22,15 +26,11 @@
 #include "libqos/pci-pc.h"
 #include "libqos/virtio-pci.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qjson.h"

 #include "libqos/malloc-pc.h"
 #include "hw/virtio/virtio-net.h"

-#include <linux/vhost.h>
-#include <linux/virtio_ids.h>
-#include <linux/virtio_net.h>
-#include <sys/vfs.h>
-
 /* GLIB version compatibility flags */
 #if !GLIB_CHECK_VERSION(2, 26, 0)
 #define G_TIME_SPAN_SECOND              (G_GINT64_CONSTANT(1000000))
@@ -662,7 +662,7 @@ static void test_migrate(void)
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

-    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
+    rsp = qmp_cmd("migrate", qobject_from_jsonf("{ 'uri': %s }", uri));
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

-- 
2.13.3
