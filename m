Received: from eggs.gnu.org ([2001:4830:134:3::10]:60577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNq-0000Cr-2h
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNm-0004eu-Gf
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:34 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:46 -0500
Message-Id: <20170804012551.2714-18-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 17/22] libqtest: Add qmp_args() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, John Snow <jsnow@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, "open list:IDE" <qemu-block@nongnu.org>

Similar to the previous helper, we can reduce the boilerplate
of most callers by passing the command name separately from
the interpolated arguments.  Adjust the majority of the callers
that can use the new helpers; in the process, fixing a few
places where we would have failed -Wformat-nonliteral.  The
new helper function already uses GCC_FMT_ATTR to match the
underlying use of qobject_from_jsonv().

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               |  20 ++++++
 tests/libqtest.c               |  29 +++++++++
 tests/ahci-test.c              |  19 +++---
 tests/device-introspect-test.c |   4 +-
 tests/drive_del-test.c         |  10 +--
 tests/fdc-test.c               |   8 +--
 tests/libqos/libqos.c          |   7 +--
 tests/libqos/pci-pc.c          |   8 +--
 tests/pc-cpu-test.c            |   8 +--
 tests/postcopy-test.c          |  30 +++------
 tests/qom-test.c               |   9 +--
 tests/test-netfilter.c         | 139 ++++++++++++++++-------------------------
 tests/test-x86-cpuid-compat.c  |   6 +-
 tests/tmp105-test.c            |   9 +--
 tests/usb-hcd-uhci-test.c      |  14 ++---
 tests/usb-hcd-xhci-test.c      |  25 ++------
 tests/vhost-user-test.c        |  12 +---
 tests/virtio-blk-test.c        |  12 +---
 tests/virtio-scsi-test.c       |  13 +---
 tests/virtio-serial-test.c     |  12 +---
 20 files changed, 167 insertions(+), 227 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index e0d87d035a..86ca7fa581 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -499,6 +499,26 @@ QDict *qmp_cmd(const char *cmd);
 void qmp_cmd_async(const char *cmd);

 /**
+ * qmp_args:
+ * @cmd: QMP command to send to QEMU.
+ * @fmt...: Arguments for the command; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
+ *
+ * Sends a QMP message to QEMU and returns the response.
+ */
+QDict *qmp_args(const char *cmd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+
+/**
+ * qmp_args_async:
+ * @cmd: QMP command to send to QEMU.
+ * @fmt...: Arguments for the command; formats arguments through
+ * json-lexer.c (only understands '%(PRI[ud]64|(l|ll)?[du]|[ipsf%])').
+ *
+ * Sends a QMP message to QEMU and leaves the response in the stream.
+ */
+void qmp_args_async(const char *cmd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+
+/**
  * qmp_discard_response:
  *
  * Read and discard a QMP response, typically after qmp_async().
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3926a4d481..49786cf2d7 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -869,6 +869,35 @@ void qmp_cmd_async(const char *cmd)
     qtest_qmp_send(global_qtest, "{'execute':%s}", cmd);
 }

+static void qmp_args_dict_async(const char *cmd, QDict *args)
+{
+    assert(args);
+    qtest_qmp_send(global_qtest, "{'execute':%s, 'arguments':%p}", cmd, args);
+}
+
+QDict *qmp_args(const char *cmd, const char *fmt, ...)
+{
+    va_list ap;
+    QObject *obj;
+
+    va_start(ap, fmt);
+    obj = qobject_from_jsonv(fmt, ap);
+    va_end(ap);
+    qmp_args_dict_async(cmd, qobject_to_qdict(obj));
+    return qtest_qmp_receive(global_qtest);
+}
+
+void qmp_args_async(const char *cmd, const char *fmt, ...)
+{
+    va_list ap;
+    QObject *obj;
+
+    va_start(ap, fmt);
+    obj = qobject_from_jsonv(fmt, ap);
+    va_end(ap);
+    qmp_args_dict_async(cmd, qobject_to_qdict(obj));
+}
+
 void qmp_discard_response(void)
 {
     QDict *response = qtest_qmp_receive(global_qtest);
diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 63d52edfca..ee8a539cf6 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1588,14 +1588,12 @@ static void test_atapi_tray(void)
     atapi_wait_tray(false);

     /* Remove media */
-    qmp_async("{'execute': 'blockdev-open-tray', "
-               "'arguments': {'device': 'drive0'}}");
+    qmp_args_async("blockdev-open-tray", "{'device': 'drive0'}");
     atapi_wait_tray(true);
     rsp = qmp_receive();
     QDECREF(rsp);

-    qmp_async("{'execute': 'x-blockdev-remove-medium', "
-              "'arguments': {'device': 'drive0'}}");
+    qmp_args_async("x-blockdev-remove-medium", "{'device': 'drive0'}");
     qmp_discard_response();

     /* Test the tray without a medium */
@@ -1606,17 +1604,16 @@ static void test_atapi_tray(void)
     atapi_wait_tray(true);

     /* Re-insert media */
-    qmp_async("{'execute': 'blockdev-add', 'arguments': {"
-              "  'node-name': 'node0', 'driver': 'raw', "
-              "  'file': { 'driver': 'file', 'filename': %s }}}", iso);
+    qmp_args_async("blockdev-add", "{'node-name': 'node0', "
+                   "'driver': 'raw', "
+                   "'file': { 'driver': 'file', 'filename': %s }}", iso);
     qmp_discard_response();
-    qmp_async("{'execute': 'x-blockdev-insert-medium',"
-              "'arguments': { 'device': 'drive0', 'node-name': 'node0' }}");
+    qmp_args_async("x-blockdev-insert-medium",
+                   "{ 'device': 'drive0', 'node-name': 'node0' }");
     qmp_discard_response();

     /* Again, the event shows up first */
-    qmp_async("{'execute': 'blockdev-close-tray', "
-               "'arguments': {'device': 'drive0'}}");
+    qmp_args_async("blockdev-close-tray", "{'device': 'drive0'}");
     atapi_wait_tray(false);
     rsp = qmp_receive();
     QDECREF(rsp);
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index f7162c023f..e1fcd3b6c6 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -105,9 +105,7 @@ static void test_one_device(const char *type)
     QDict *resp;
     char *help, *qom_tree;

-    resp = qmp("{'execute': 'device-list-properties',"
-               " 'arguments': {'typename': %s}}",
-               type);
+    resp = qmp_args("device-list-properties", "{'typename': %s}", type);
     QDECREF(resp);

     help = hmp("device_add \"%s,help\"", type);
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 834a634da3..442eb35c2b 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -34,8 +34,7 @@ static void device_del(void)
     QDict *response;

     /* Complication: ignore DEVICE_DELETED event */
-    qmp_async("{'execute': 'device_del',"
-              " 'arguments': { 'id': 'dev0' } }");
+    qmp_args_async("device_del", "{ 'id': 'dev0' }");
     qmp_discard_response();
     response = qmp_receive();
     g_assert(response);
@@ -69,11 +68,8 @@ static void test_after_failed_device_add(void)
     /* Make device_add fail.  If this leaks the virtio-blk-pci device then a
      * reference to drive0 will also be held (via qdev properties).
      */
-    response = qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': 'virtio-blk-pci',"
-                   "   'drive': 'drive0'"
-                   "}}");
+    response = qmp_args("device_add",
+                        "{'driver': 'virtio-blk-pci', 'drive': 'drive0'}");
     g_assert(response);
     error = qdict_get_qdict(response, "error");
     g_assert_cmpstr(qdict_get_try_str(error, "class"), ==, "GenericError");
diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index ab61a82873..9999e5f5c4 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -298,9 +298,9 @@ static void test_media_insert(void)

     /* Insert media in drive. DSKCHK should not be reset until a step pulse
      * is sent. */
-    qmp_async("{'execute':'blockdev-change-medium', 'arguments':{"
-              " 'id':'floppy0', 'filename': %s, 'format': 'raw' }}",
-              test_image);
+    qmp_args_async("blockdev-change-medium",
+                   "{'id':'floppy0', 'filename': %s, 'format': 'raw' }",
+                   test_image);
     qmp_discard_response();

     dir = inb(FLOPPY_BASE + reg_dir);
@@ -330,7 +330,7 @@ static void test_media_change(void)

     /* Eject the floppy and check that DSKCHG is set. Reading it out doesn't
      * reset the bit. */
-    qmp_async("{'execute':'eject', 'arguments':{ 'id':'floppy0' }}");
+    qmp_args_async("eject", "{ 'id':'floppy0' }");
     qmp_discard_response();

     dir = inb(FLOPPY_BASE + reg_dir);
diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 246a04d6e6..ba2707f89e 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -87,7 +87,6 @@ void set_context(QOSState *s)
 void migrate(QOSState *from, QOSState *to, const char *uri)
 {
     const char *st;
-    char *s;
     QDict *rsp, *sub;
     bool running;

@@ -102,11 +101,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     QDECREF(rsp);

     /* Issue the migrate command. */
-    s = g_strdup_printf("{ 'execute': 'migrate',"
-                        "'arguments': { 'uri': '%s' } }",
-                        uri);
-    rsp = qmp(s);
-    g_free(s);
+    rsp = qmp_args("migrate", "{'uri': %s}", uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 02ce49927a..b4790650ab 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -159,14 +159,8 @@ void qpci_free_pc(QPCIBus *bus)
 void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
 {
     QDict *response;
-    char *cmd;

-    cmd = g_strdup_printf("{'execute': 'device_del',"
-                          " 'arguments': {"
-                          "   'id': '%s'"
-                          "}}", id);
-    response = qmp(cmd);
-    g_free(cmd);
+    response = qmp_args("device_del", "{'id': %s}", id);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/pc-cpu-test.c b/tests/pc-cpu-test.c
index c4211a4e85..d4ea7ec612 100644
--- a/tests/pc-cpu-test.c
+++ b/tests/pc-cpu-test.c
@@ -37,8 +37,7 @@ static void test_pc_with_cpu_add(gconstpointer data)
     qtest_start(args);

     for (i = s->sockets * s->cores * s->threads; i < s->maxcpus; i++) {
-        response = qmp("{ 'execute': 'cpu-add',"
-                       "  'arguments': { 'id': %d } }", i);
+        response = qmp_args("cpu-add", "{ 'id': %d }", i);
         g_assert(response);
         g_assert(!qdict_haskey(response, "error"));
         QDECREF(response);
@@ -60,9 +59,8 @@ static void test_pc_without_cpu_add(gconstpointer data)
                            s->sockets, s->cores, s->threads, s->maxcpus);
     qtest_start(args);

-    response = qmp("{ 'execute': 'cpu-add',"
-                   "  'arguments': { 'id': %d } }",
-                   s->sockets * s->cores * s->threads);
+    response = qmp_args("cpu-add", "{ 'id': %d }",
+                        s->sockets * s->cores * s->threads);
     g_assert(response);
     g_assert(qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 6f7f81eccd..4e585006a8 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -358,7 +358,7 @@ static void test_migrate(void)
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *global = global_qtest, *from, *to;
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
-    gchar *cmd, *cmd_src, *cmd_dst;
+    gchar *cmd_src, *cmd_dst;
     QDict *rsp;

     char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
@@ -408,20 +408,16 @@ static void test_migrate(void)
     g_free(cmd_dst);

     global_qtest = from;
-    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
-                  "'arguments': { "
-                      "'capabilities': [ {"
-                          "'capability': 'postcopy-ram',"
-                          "'state': true } ] } }");
+    rsp = qmp_args("migrate-set-capabilities",
+                   "{'capabilities': ["
+                   "  {'capability': 'postcopy-ram', 'state': true } ] }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

     global_qtest = to;
-    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
-                  "'arguments': { "
-                      "'capabilities': [ {"
-                          "'capability': 'postcopy-ram',"
-                          "'state': true } ] } }");
+    rsp = qmp_args("migrate-set-capabilities",
+                   "{'capabilities': ["
+                   "  {'capability': 'postcopy-ram', 'state': true } ] }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

@@ -430,14 +426,12 @@ static void test_migrate(void)
      * machine, so also set the downtime.
      */
     global_qtest = from;
-    rsp = qmp("{ 'execute': 'migrate_set_speed',"
-              "'arguments': { 'value': 100000000 } }");
+    rsp = qmp_args("migrate_set_speed", "{ 'value': 100000000 }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

     /* 1ms downtime - it should never finish precopy */
-    rsp = qmp("{ 'execute': 'migrate_set_downtime',"
-              "'arguments': { 'value': 0.001 } }");
+    rsp = qmp_args("migrate_set_downtime", "{ 'value': 0.001 }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

@@ -445,11 +439,7 @@ static void test_migrate(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");

-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp = qmp(cmd);
-    g_free(cmd);
+    rsp = qmp_args("migrate", "{'uri':%s}", uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

diff --git a/tests/qom-test.c b/tests/qom-test.c
index 369972629a..3c315cf864 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -51,8 +51,7 @@ static void test_properties(const char *path, bool recurse)
     QListEntry *entry;

     g_test_message("Obtaining properties of %s", path);
-    response = qmp("{ 'execute': 'qom-list',"
-                   "  'arguments': { 'path': %s } }", path);
+    response = qmp_args("qom-list", "{ 'path': %s }", path);
     g_assert(response);

     if (!recurse) {
@@ -75,10 +74,8 @@ static void test_properties(const char *path, bool recurse)
         } else {
             const char *prop = qdict_get_str(tuple, "name");
             g_test_message("Testing property %s.%s", path, prop);
-            tmp = qmp("{ 'execute': 'qom-get',"
-                      "  'arguments': { 'path': %s,"
-                      "                 'property': %s } }",
-                      path, prop);
+            tmp = qmp_args("qom-get", "{ 'path': %s, 'property': %s }",
+                           path, prop);
             /* qom-get may fail but should not, e.g., segfault. */
             g_assert(tmp);
             QDECREF(tmp);
diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
index 8b5a9b21b5..736abc26ec 100644
--- a/tests/test-netfilter.c
+++ b/tests/test-netfilter.c
@@ -16,24 +16,20 @@ static void add_one_netfilter(void)
 {
     QDict *response;

-    response = qmp("{'execute': 'object-add',"
-                   " 'arguments': {"
-                   "   'qom-type': 'filter-buffer',"
-                   "   'id': 'qtest-f0',"
-                   "   'props': {"
-                   "     'netdev': 'qtest-bn0',"
-                   "     'queue': 'rx',"
-                   "     'interval': 1000"
-                   "}}}");
+    response = qmp_args("object-add",
+                        "{ 'qom-type': 'filter-buffer',"
+                        "  'id': 'qtest-f0',"
+                        "  'props': {"
+                        "     'netdev': 'qtest-bn0',"
+                        "     'queue': 'rx',"
+                        "     'interval': 1000"
+                        "}}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'object-del',"
-                   " 'arguments': {"
-                   "   'id': 'qtest-f0'"
-                   "}}");
+    response = qmp_args("object-del", "{'id': 'qtest-f0'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
@@ -44,34 +40,26 @@ static void remove_netdev_with_one_netfilter(void)
 {
     QDict *response;

-    response = qmp("{'execute': 'object-add',"
-                   " 'arguments': {"
-                   "   'qom-type': 'filter-buffer',"
-                   "   'id': 'qtest-f0',"
-                   "   'props': {"
-                   "     'netdev': 'qtest-bn0',"
-                   "     'queue': 'rx',"
-                   "     'interval': 1000"
-                   "}}}");
+    response = qmp_args("object-add",
+                        "{ 'qom-type': 'filter-buffer',"
+                        "  'id': 'qtest-f0',"
+                        "  'props': {"
+                        "     'netdev': 'qtest-bn0',"
+                        "     'queue': 'rx',"
+                        "     'interval': 1000"
+                        "}}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'netdev_del',"
-                   " 'arguments': {"
-                   "   'id': 'qtest-bn0'"
-                   "}}");
+    response = qmp_args("netdev_del", "{'id': 'qtest-bn0'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

     /* add back the netdev */
-    response = qmp("{'execute': 'netdev_add',"
-                   " 'arguments': {"
-                   "   'type': 'user',"
-                   "   'id': 'qtest-bn0'"
-                   "}}");
+    response = qmp_args("netdev_add", "{'type': 'user', 'id': 'qtest-bn0'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
@@ -82,46 +70,38 @@ static void add_multi_netfilter(void)
 {
     QDict *response;

-    response = qmp("{'execute': 'object-add',"
-                   " 'arguments': {"
-                   "   'qom-type': 'filter-buffer',"
-                   "   'id': 'qtest-f0',"
-                   "   'props': {"
-                   "     'netdev': 'qtest-bn0',"
-                   "     'queue': 'rx',"
-                   "     'interval': 1000"
-                   "}}}");
+    response = qmp_args("object-add",
+                        "{ 'qom-type': 'filter-buffer',"
+                        "  'id': 'qtest-f0',"
+                        "  'props': {"
+                        "     'netdev': 'qtest-bn0',"
+                        "     'queue': 'rx',"
+                        "     'interval': 1000"
+                        "}}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'object-add',"
-                   " 'arguments': {"
-                   "   'qom-type': 'filter-buffer',"
-                   "   'id': 'qtest-f1',"
-                   "   'props': {"
-                   "     'netdev': 'qtest-bn0',"
-                   "     'queue': 'rx',"
-                   "     'interval': 1000"
-                   "}}}");
+    response = qmp_args("object-add",
+                        "{ 'qom-type': 'filter-buffer',"
+                        "  'id': 'qtest-f1',"
+                        "  'props': {"
+                        "     'netdev': 'qtest-bn0',"
+                        "     'queue': 'rx',"
+                        "     'interval': 1000"
+                        "}}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'object-del',"
-                   " 'arguments': {"
-                   "   'id': 'qtest-f0'"
-                   "}}");
+    response = qmp_args("object-del", "{'id': 'qtest-f0'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'object-del',"
-                   " 'arguments': {"
-                   "   'id': 'qtest-f1'"
-                   "}}");
+    response = qmp_args("object-del", "{'id': 'qtest-f1'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
@@ -132,48 +112,39 @@ static void remove_netdev_with_multi_netfilter(void)
 {
     QDict *response;

-    response = qmp("{'execute': 'object-add',"
-                   " 'arguments': {"
-                   "   'qom-type': 'filter-buffer',"
-                   "   'id': 'qtest-f0',"
-                   "   'props': {"
-                   "     'netdev': 'qtest-bn0',"
-                   "     'queue': 'rx',"
-                   "     'interval': 1000"
-                   "}}}");
+    response = qmp_args("object-add",
+                        "{ 'qom-type': 'filter-buffer',"
+                        "  'id': 'qtest-f0',"
+                        "  'props': {"
+                        "     'netdev': 'qtest-bn0',"
+                        "     'queue': 'rx',"
+                        "     'interval': 1000"
+                        "}}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'object-add',"
-                   " 'arguments': {"
-                   "   'qom-type': 'filter-buffer',"
-                   "   'id': 'qtest-f1',"
-                   "   'props': {"
-                   "     'netdev': 'qtest-bn0',"
-                   "     'queue': 'rx',"
-                   "     'interval': 1000"
-                   "}}}");
+    response = qmp_args("object-add",
+                        "{ 'qom-type': 'filter-buffer',"
+                        "  'id': 'qtest-f1',"
+                        "  'props': {"
+                        "     'netdev': 'qtest-bn0',"
+                        "     'queue': 'rx',"
+                        "     'interval': 1000"
+                        "}}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'netdev_del',"
-                   " 'arguments': {"
-                   "   'id': 'qtest-bn0'"
-                   "}}");
+    response = qmp_args("netdev_del", "{'id': 'qtest-bn0'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

     /* add back the netdev */
-    response = qmp("{'execute': 'netdev_add',"
-                   " 'arguments': {"
-                   "   'type': 'user',"
-                   "   'id': 'qtest-bn0'"
-                   "}}");
+    response = qmp_args("netdev_add", "{'type': 'user', 'id': 'qtest-bn0'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index f29df9b9df..536e1cae2c 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -25,10 +25,8 @@ static char *get_cpu0_qom_path(void)

 static QObject *qom_get(const char *path, const char *prop)
 {
-    QDict *resp = qmp("{ 'execute': 'qom-get',"
-                      "  'arguments': { 'path': %s,"
-                      "                 'property': %s } }",
-                      path, prop);
+    QDict *resp = qmp_args("qom-get", "{ 'path': %s, 'property': %s }",
+                           path, prop);
     QObject *ret = qdict_get(resp, "return");
     qobject_incref(ret);
     QDECREF(resp);
diff --git a/tests/tmp105-test.c b/tests/tmp105-test.c
index a7940a4639..28e6f300bc 100644
--- a/tests/tmp105-test.c
+++ b/tests/tmp105-test.c
@@ -69,8 +69,8 @@ static int qmp_tmp105_get_temperature(const char *id)
     QDict *response;
     int ret;

-    response = qmp("{ 'execute': 'qom-get', 'arguments': { 'path': %s, "
-                   "'property': 'temperature' } }", id);
+    response = qmp_args("qom-get", "{ 'path': %s, 'property': 'temperature' }",
+                        id);
     g_assert(qdict_haskey(response, "return"));
     ret = qdict_get_int(response, "return");
     QDECREF(response);
@@ -81,8 +81,9 @@ static void qmp_tmp105_set_temperature(const char *id, int value)
 {
     QDict *response;

-    response = qmp("{ 'execute': 'qom-set', 'arguments': { 'path': %s, "
-                   "'property': 'temperature', 'value': %d } }", id, value);
+    response = qmp_args("qom-set",
+                        "{'path':%s, 'property':'temperature', 'value':%d}",
+                        id, value);
     g_assert(qdict_haskey(response, "return"));
     QDECREF(response);
 }
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index 0fb7f8d223..b45c0d7ac0 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -50,20 +50,14 @@ static void test_usb_storage_hotplug(void)
 {
     QDict *response;

-    response = qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': 'usb-storage',"
-                   "   'drive': 'drive0',"
-                   "   'id': 'usbdev0'"
-                   "}}");
+    response = qmp_args("device_add",
+                        "{ 'driver': 'usb-storage', 'drive': 'drive0',"
+                        "   'id': 'usbdev0'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'device_del',"
-                           " 'arguments': {"
-                           "   'id': 'usbdev0'"
-                           "}}");
+    response = qmp_args("device_del", "{'id': 'usbdev0'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index c05a339894..408e819a61 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -25,21 +25,14 @@ static void test_usb_uas_hotplug(void)
 {
     QDict *response;

-    response = qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': 'usb-uas',"
-                   "   'id': 'uas'"
-                   "}}");
+    response = qmp_args("device_add", "{'driver': 'usb-uas', 'id': 'uas'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': 'scsi-hd',"
-                   "   'drive': 'drive0',"
-                   "   'id': 'scsi-hd'"
-                   "}}");
+    response = qmp_args("device_add",
+                        "{'driver': 'scsi-hd', 'drive': 'drive0',"
+                        "  'id': 'scsi-hd'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
@@ -49,20 +42,14 @@ static void test_usb_uas_hotplug(void)
         added disk is visible after BUS rescan
     */

-    response = qmp("{'execute': 'device_del',"
-                           " 'arguments': {"
-                           "   'id': 'scsi-hd'"
-                           "}}");
+    response = qmp_args("device_del", "{'id': 'scsi-hd'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

     qmp_eventwait("DEVICE_DELETED");

-    response = qmp("{'execute': 'device_del',"
-                           " 'arguments': {"
-                           "   'id': 'uas'"
-                           "}}");
+    response = qmp_args("device_del", "{'id': 'uas'}");
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index d4da09f147..7c00f4b527 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -657,16 +657,11 @@ static void test_migrate(void)

     /* slow down migration to have time to fiddle with log */
     /* TODO: qtest could learn to break on some places */
-    rsp = qmp("{ 'execute': 'migrate_set_speed',"
-              "'arguments': { 'value': 10 } }");
+    rsp = qmp_args("migrate_set_speed", "{ 'value': 10 }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp = qmp(cmd);
-    g_free(cmd);
+    rsp = qmp_args("migrate", "{'uri':%s}", uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

@@ -681,8 +676,7 @@ static void test_migrate(void)
     munmap(log, size);

     /* speed things up */
-    rsp = qmp("{ 'execute': 'migrate_set_speed',"
-              "'arguments': { 'value': 0 } }");
+    rsp = qmp_args("migrate_set_speed", "{ 'value': 0 }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index fe966c0606..649ba03c92 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -409,9 +409,7 @@ static void pci_config(void)

     qvirtio_set_driver_ok(&dev->vdev);

-    qmp_async("{ 'execute': 'block_resize', "
-              " 'arguments': { 'device': 'drive0', "
-              " 'size': %d } }", n_size);
+    qmp_args_async("block_resize", "{'device': 'drive0', 'size': %d}", n_size);
     qmp_discard_response();
     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);

@@ -460,9 +458,7 @@ static void pci_msix(void)

     qvirtio_set_driver_ok(&dev->vdev);

-    qmp_async("{ 'execute': 'block_resize', "
-              " 'arguments': { 'device': 'drive0', "
-              " 'size': %d } }", n_size);
+    qmp_args_async("block_resize", "{'device': 'drive0', 'size': %d}", n_size);
     qmp_discard_response();

     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);
@@ -702,9 +698,7 @@ static void mmio_basic(void)

     test_basic(&dev->vdev, alloc, vq);

-    qmp_async("{ 'execute': 'block_resize', "
-              " 'arguments': { 'device': 'drive0', "
-              " 'size': %d } }", n_size);
+    qmp_args_async("block_resize", "{'device': 'drive0', 'size': %d}", n_size);
     qmp_discard_response();

     qvirtio_wait_queue_isr(&dev->vdev, vq, QVIRTIO_BLK_TIMEOUT_US);
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 87a3b6e81a..126a6225f0 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -197,21 +197,14 @@ static void hotplug(void)

     qs = qvirtio_scsi_start(
             "-drive id=drv1,if=none,file=null-co://,format=raw");
-    response = qmp("{\"execute\": \"device_add\","
-                   " \"arguments\": {"
-                   "   \"driver\": \"scsi-hd\","
-                   "   \"id\": \"scsi-hd\","
-                   "   \"drive\": \"drv1\""
-                   "}}");
+    response = qmp_args("device_add",
+                        "{'driver':'scsi-hd', 'id':'scsi-hd', 'drive':'drv1'}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{\"execute\": \"device_del\","
-                   " \"arguments\": {"
-                   "   \"id\": \"scsi-hd\""
-                   "}}");
+    response = qmp_args("device_del", "{'id':'scsi-hd'}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index b14d943ada..f47c343a2f 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -19,20 +19,14 @@ static void hotplug(void)
 {
     QDict *response;

-    response = qmp("{\"execute\": \"device_add\","
-                   " \"arguments\": {"
-                   "   \"driver\": \"virtserialport\","
-                   "   \"id\": \"hp-port\""
-                   "}}");
+    response = qmp_args("device_add",
+                        "{'driver':'virtserialport', 'id':'hp-port'}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);

-    response = qmp("{\"execute\": \"device_del\","
-                   " \"arguments\": {"
-                   "   \"id\": \"hp-port\""
-                   "}}");
+    response = qmp_args("device_del", "{'id':'hp-port'}");

     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
-- 
2.13.3
