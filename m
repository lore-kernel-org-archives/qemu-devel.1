Received: from eggs.gnu.org ([2001:4830:134:3::10]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWquv-0000kj-KV
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWquu-0003vn-Md
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:45 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:40247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWquu-0003vN-Hi
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:49:44 -0500
Received: by mail-qk0-x244.google.com with SMTP id q14so3326151qke.7
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:49:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 18:49:24 -0300
Message-Id: <20180103214925.16677-4-f4bug@amsat.org>
In-Reply-To: <20180103214925.16677-1-f4bug@amsat.org>
References: <20180103214925.16677-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 3/4] libqos: implement sdbus QMP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/libqos/sdbus-qmp.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include   |   2 +-
 2 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 tests/libqos/sdbus-qmp.c

diff --git a/tests/libqos/sdbus-qmp.c b/tests/libqos/sdbus-qmp.c
new file mode 100644
index 0000000000..565e2481db
--- /dev/null
+++ b/tests/libqos/sdbus-qmp.c
@@ -0,0 +1,130 @@
+/*
+ * QTest SD/MMC Bus QMP driver
+ *
+ * Copyright (c) 2017 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qstring.h"
+
+#include "libqos/sdbus.h"
+#include "libqtest.h"
+
+typedef struct QMPSDBus {
+    SDBusAdapter parent;
+
+    const char *qom_path;
+} QMPSDBus;
+
+
+static const char *qmp_sdbus_getpath(const char *blkname)
+{
+    QDict *response, *minfo;
+    QList *list;
+    const QListEntry *le;
+    QString *qstr;
+    const char *mname;
+    QObject *qobj;
+
+    response = qmp("{ 'execute': 'query-block' }");
+    g_assert_nonnull(response);
+    list = qdict_get_qlist(response, "return");
+    g_assert_nonnull(list);
+
+    QLIST_FOREACH_ENTRY(list, le) {
+        QDict *response2;
+
+        minfo = qobject_to_qdict(qlist_entry_obj(le));
+        g_assert(minfo);
+        qobj = qdict_get(minfo, "qdev");
+        if (!qobj) {
+            continue;
+        }
+        qstr = qobject_to_qstring(qobj);
+        g_assert(qstr);
+        mname = qstring_get_str(qstr);
+
+        response2 = qmp("{ 'execute': 'qom-get',"
+                        "  'arguments': { 'path': %s,"
+                        "   'property': \"parent_bus\"}"
+                        "}", mname);
+        g_assert(response2);
+        g_assert(qdict_haskey(response2, "return"));
+        qobj = qdict_get(response2, "return");
+        qstr = qobject_to_qstring(qobj);
+        g_assert(qstr);
+        mname = qstring_get_str(qstr);
+
+        return mname;
+    }
+    return NULL;
+}
+
+static ssize_t qmp_mmc_do_cmd(SDBusAdapter *adapter, enum NCmd cmd, uint32_t arg,
+                              uint8_t **response)
+{
+    QMPSDBus *s = (QMPSDBus *)adapter;
+    QDict *response1;
+    QObject *qobj;
+
+    response1 = qmp("{ 'execute': 'x-debug-sdbus-command',"
+                    "  'arguments': { 'qom-path': %s,"
+                    "                 'command': %u, 'arg': %u}"
+                    "}",
+                    s->qom_path, cmd, arg);
+    g_assert(qdict_haskey(response1, "return"));
+    qobj = qdict_get(response1, "return");
+    //QDECREF(response);
+
+    if (!qobj) {
+        return -1;
+    }
+
+    {
+        QString *qstr;
+        const gchar *mname;
+        guchar *uc;
+        gsize out_len;
+        QDict *response2 = qobject_to_qdict(qobj);
+
+        if (!qdict_haskey(response2, "base64")) {
+            return 0;
+        }
+        qobj = qdict_get(response2, "base64");
+        qstr = qobject_to_qstring(qobj);
+        if (!qstr) {
+            puts("!qstr");
+            return 0;
+        }
+        mname = qstring_get_str(qstr);
+
+        uc = g_base64_decode(mname, &out_len);
+        if (response) {
+            *response = uc;
+        } else {
+            g_free(uc);
+        }
+        return out_len;
+
+    }
+
+    return 0;
+}
+
+SDBusAdapter *qmp_sdbus_create(const char *bus_name)
+{
+    QMPSDBus *s;
+    SDBusAdapter *mmc;
+
+    s = g_new(QMPSDBus, 1);
+    s->qom_path = qmp_sdbus_getpath(bus_name);
+    g_assert_nonnull(s->qom_path);
+
+    mmc = (SDBusAdapter *)s;
+    mmc->do_command = qmp_mmc_do_cmd;
+
+    return mmc;
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c22925d4db..409784a189 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -715,7 +715,7 @@ tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-obj-y)
 
 libqos-obj-y = tests/libqos/pci.o tests/libqos/fw_cfg.o tests/libqos/malloc.o
 libqos-obj-y += tests/libqos/i2c.o tests/libqos/libqos.o
-libqos-obj-y += tests/libqos/sdbus.o
+libqos-obj-y += tests/libqos/sdbus.o tests/libqos/sdbus-qmp.o
 libqos-spapr-obj-y = $(libqos-obj-y) tests/libqos/malloc-spapr.o
 libqos-spapr-obj-y += tests/libqos/libqos-spapr.o
 libqos-spapr-obj-y += tests/libqos/rtas.o
-- 
2.15.1
