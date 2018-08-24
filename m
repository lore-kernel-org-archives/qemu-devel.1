Received: from eggs.gnu.org ([2001:4830:134:3::10]:56833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft85C-0008A5-GN
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft85A-0005xR-UZ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ft85A-0005x9-P0
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:08:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E45D87A74
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 09:08:40 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 24 Aug 2018 17:08:24 +0800
Message-Id: <20180824090826.21370-2-peterx@redhat.com>
In-Reply-To: <20180824090826.21370-1-peterx@redhat.com>
References: <20180824090826.21370-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 1/3] chardev: introduce chardev contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Introduce contexts in chardev layer.  Normally chardevs are running with
the main context except the monitors.  Let's create the first standalone
context for the monitors.  Note that this does not mean the chardev
backend will depend on the monitor code, but it's just a naming that let
people know this context should only be used by monitors.

This patch itself should not have any functional change (we'll create a
new iothread that managed by chardev module, but no one is currently
using it), however after this patch we should be able to specify the
context for a chardev by using a qemu_opt_set_number() onto the QemuOps
before the chardev backend is created.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char.c         | 73 +++++++++++++++++++++++++++++++++++++++---
 gdbstub.c              |  2 +-
 hw/bt/hci-csr.c        |  2 +-
 include/chardev/char.h | 15 ++++++++-
 tests/test-char.c      |  4 +--
 5 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 76d866e6fe..c98d245ef7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -41,6 +41,13 @@
 /***********************************************************/
 /* character device */
 
+typedef struct {
+    IOThread *iothread;
+    GMainContext *gcontext;
+} ChardevContextMap;
+
+static ChardevContextMap *chr_context_table;
+
 static Object *get_chardevs_root(void)
 {
     return container_get(object_get_root(), "/chardevs");
@@ -623,6 +630,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
     const char *name = chardev_alias_translate(qemu_opt_get(opts, "backend"));
     const char *id = qemu_opts_id(opts);
     char *bid = NULL;
+    ChardevContext context;
 
     if (name && is_help_option(name)) {
         GString *str = g_string_new("");
@@ -634,6 +642,8 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
+    context = qemu_opt_get_number(opts, "context", CHR_CONTEXT_MAIN);
+
     if (id == NULL) {
         error_setg(errp, "chardev: no id specified");
         return NULL;
@@ -655,7 +665,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
 
     chr = qemu_chardev_new(bid ? bid : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
-                           backend, errp);
+                           backend, context, errp);
 
     if (chr == NULL) {
         goto out;
@@ -668,7 +678,8 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
         backend->type = CHARDEV_BACKEND_KIND_MUX;
         backend->u.mux.data = g_new0(ChardevMux, 1);
         backend->u.mux.data->chardev = g_strdup(bid);
-        mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, errp);
+        mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX,
+                               backend, CHR_CONTEXT_MAIN, errp);
         if (mux == NULL) {
             object_unparent(OBJECT(chr));
             chr = NULL;
@@ -876,6 +887,10 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "logappend",
             .type = QEMU_OPT_BOOL,
+        },{
+            /* TODO: should only be used internally */
+            .name = "context",
+            .type = QEMU_OPT_NUMBER,
         },
         { /* end of list */ }
     },
@@ -893,8 +908,42 @@ void qemu_chr_set_feature(Chardev *chr,
     return set_bit(feature, chr->features);
 }
 
+static void qemu_chr_context_init(void)
+{
+    if (!chr_context_table) {
+        ChardevContext i;
+        ChardevContextMap *map;
+
+        chr_context_table = g_new0(ChardevContextMap, CHR_CONTEXT_MAX);
+
+        /* This stands for the main context */
+        chr_context_table[0].iothread = NULL;
+        chr_context_table[0].gcontext = NULL;
+
+        for (i = 1; i < CHR_CONTEXT_MAX; i++) {
+            map = &chr_context_table[i];
+            map->iothread = iothread_create("chr_iothread", &error_abort);
+            map->gcontext = iothread_get_g_main_context(map->iothread);
+        }
+    }
+}
+
+IOThread *qemu_chr_iothread_get(ChardevContext context)
+{
+    assert(context >= 0 && context < CHR_CONTEXT_MAX);
+    qemu_chr_context_init();
+    return chr_context_table[context].iothread;
+}
+
+GMainContext *qemu_chr_context_get(ChardevContext context)
+{
+    assert(context >= 0 && context < CHR_CONTEXT_MAX);
+    qemu_chr_context_init();
+    return chr_context_table[context].gcontext;
+}
+
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-                          ChardevBackend *backend,
+                          ChardevBackend *backend, ChardevContext context,
                           Error **errp)
 {
     Object *obj;
@@ -907,6 +956,7 @@ Chardev *qemu_chardev_new(const char *id, const char *typename,
     obj = object_new(typename);
     chr = CHARDEV(obj);
     chr->label = g_strdup(id);
+    chr->gcontext = qemu_chr_context_get(context);
 
     qemu_char_open(chr, backend, &be_opened, &local_err);
     if (local_err) {
@@ -951,7 +1001,7 @@ ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend,
     }
 
     chr = qemu_chardev_new(id, object_class_get_name(OBJECT_CLASS(cc)),
-                           backend, errp);
+                           backend, CHR_CONTEXT_MAIN, errp);
     if (!chr) {
         return NULL;
     }
@@ -1009,7 +1059,7 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
     }
 
     chr_new = qemu_chardev_new(NULL, object_class_get_name(OBJECT_CLASS(cc)),
-                               backend, errp);
+                               backend, CHR_CONTEXT_MAIN, errp);
     if (!chr_new) {
         return NULL;
     }
@@ -1102,6 +1152,19 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
 void qemu_chr_cleanup(void)
 {
     object_unparent(get_chardevs_root());
+
+    if (chr_context_table) {
+        ChardevContext i;
+        ChardevContextMap *map;
+        for (i = 1; i < CHR_CONTEXT_MAX; i++) {
+            map = &chr_context_table[i];
+            map->gcontext = NULL;
+            iothread_destroy(map->iothread);
+            map->iothread = NULL;
+        }
+        g_free(chr_context_table);
+        chr_context_table = NULL;
+    }
 }
 
 static void register_types(void)
diff --git a/gdbstub.c b/gdbstub.c
index d6ab95006c..777cb257d7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2052,7 +2052,7 @@ int gdbserver_start(const char *device)
 
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
-                                   NULL, &error_abort);
+                                   NULL, CHR_CONTEXT_MAIN, &error_abort);
         monitor_init(mon_chr, 0);
     } else {
         qemu_chr_fe_deinit(&s->chr, true);
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 0341ded50c..0e36b63301 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -501,7 +501,7 @@ static const TypeInfo char_hci_type_info = {
 Chardev *uart_hci_init(void)
 {
     return qemu_chardev_new(NULL, TYPE_CHARDEV_HCI,
-                            NULL, &error_abort);
+                            NULL, CHR_CONTEXT_MAIN, &error_abort);
 }
 
 static void register_types(void)
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 6f0576e214..e83b93e707 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -5,6 +5,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
+#include "sysemu/iothread.h"
 
 #define IAC_EOR 239
 #define IAC_SE 240
@@ -67,6 +68,15 @@ struct Chardev {
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
 };
 
+/* This decides the customized context to run the chardev */
+typedef enum {
+    /* Run the chardev in the main context (NULL) */
+    CHR_CONTEXT_MAIN,
+    /* Run the chardev in the monitor specific context */
+    CHR_CONTEXT_MONITOR,
+    CHR_CONTEXT_MAX,
+} ChardevContext;
+
 /**
  * @qemu_chr_new_from_opts:
  *
@@ -262,7 +272,10 @@ typedef struct ChardevClass {
 } ChardevClass;
 
 Chardev *qemu_chardev_new(const char *id, const char *typename,
-                          ChardevBackend *backend, Error **errp);
+                          ChardevBackend *backend, ChardevContext context,
+                          Error **errp);
+IOThread *qemu_chr_iothread_get(ChardevContext context);
+GMainContext *qemu_chr_context_get(ChardevContext context);
 
 extern int term_escape_char;
 
diff --git a/tests/test-char.c b/tests/test-char.c
index 5905d31441..ae95e1e3b7 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -593,7 +593,7 @@ static void char_file_fifo_test(void)
     g_assert_cmpint(ret, ==, 8);
 
     chr = qemu_chardev_new("label-file", TYPE_CHARDEV_FILE, &backend,
-                           &error_abort);
+                           CHR_CONTEXT_MAIN, &error_abort);
 
     qemu_chr_fe_init(&be, chr, &error_abort);
     qemu_chr_fe_set_handlers(&be,
@@ -647,7 +647,7 @@ static void char_file_test_internal(Chardev *ext_chr, const char *filepath)
         out = g_build_filename(tmp_path, "out", NULL);
         file.out = out;
         chr = qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
-                               &error_abort);
+                               CHR_CONTEXT_MAIN, &error_abort);
     }
     ret = qemu_chr_write_all(chr, (uint8_t *)"hello!", 6);
     g_assert_cmpint(ret, ==, 6);
-- 
2.17.1
