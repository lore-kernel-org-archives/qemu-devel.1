Received: from eggs.gnu.org ([2001:4830:134:3::10]:38763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHZO-0005EP-M4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgHZM-0006eG-VX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:01:58 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 21 Feb 2017 22:01:45 +0100
Message-Id: <1487710908-26356-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487710908-26356-1-git-send-email-armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 2/5] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com

keyval_parse() parses KEY=VALUE,... into a QDict.  Works like
qemu_opts_parse(), except:

* Returns a QDict instead of a QemuOpts (d'oh).

* It supports nesting, unlike QemuOpts: a KEY is split into key
  components at '.' (dotted key convention; the block layer does
  something similar on top of QemuOpts).  The key components are QDict
  keys, and the last one's value is updated to VALUE.

* Each key component may be up to 127 bytes long.  qemu_opts_parse()
  limits the entire key to 127 bytes.

* Overlong key components are rejected.  qemu_opts_parse() silently
  truncates them.

* Empty key components are rejected.  qemu_opts_parse() happily
  accepts empty keys.

* It does not store the returned value.  qemu_opts_parse() stores it
  in the QemuOptsList.

* It does not treat parameter "id" specially.  qemu_opts_parse()
  ignores all but the first "id", and fails when its value isn't
  id_wellformed(), or duplicate (a QemuOpts with the same ID is
  already stored).  It also screws up when a value contains ",id=".

I intend to grow this into a saner replacement for QemuOpts.  It'll
take time, though.

TODO Support lists

TODO Function comment is missing.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/option.h  |   3 +
 tests/.gitignore       |   1 +
 tests/Makefile.include |   3 +
 tests/test-keyval.c    | 154 +++++++++++++++++++++++++++++++++++++++++++++++++
 util/Makefile.objs     |   1 +
 util/keyval.c          | 150 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 312 insertions(+)
 create mode 100644 tests/test-keyval.c
 create mode 100644 util/keyval.c

diff --git a/include/qemu/option.h b/include/qemu/option.h
index e786df0..f7338db 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -141,4 +141,7 @@ void qemu_opts_print_help(QemuOptsList *list);
 void qemu_opts_free(QemuOptsList *list);
 QemuOptsList *qemu_opts_append(QemuOptsList *dst, QemuOptsList *list);
 
+QDict *keyval_parse(const char *params, const char *implied_key,
+                    Error **errp);
+
 #endif
diff --git a/tests/.gitignore b/tests/.gitignore
index dc37519..30b7740 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -47,6 +47,7 @@ test-io-channel-file.txt
 test-io-channel-socket
 test-io-channel-tls
 test-io-task
+test-keyval
 test-logging
 test-mul64
 test-opts-visitor
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5591f60..5b66651 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -95,6 +95,8 @@ check-unit-y += tests/check-qom-proplist$(EXESUF)
 gcov-files-check-qom-proplist-y = qom/object.c
 check-unit-y += tests/test-qemu-opts$(EXESUF)
 gcov-files-test-qemu-opts-y = util/qemu-option.c
+check-unit-y += tests/test-keyval$(EXESUF)
+gcov-files-test-keyval-y = util/keyval.c
 check-unit-y += tests/test-write-threshold$(EXESUF)
 gcov-files-test-write-threshold-y = block/write-threshold.c
 check-unit-y += tests/test-crypto-hash$(EXESUF)
@@ -720,6 +722,7 @@ tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(chardev-obj-y)
 tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
 tests/test-qemu-opts$(EXESUF): tests/test-qemu-opts.o $(test-util-obj-y)
+tests/test-keyval$(EXESUF): tests/test-keyval.o $(test-util-obj-y)
 tests/test-write-threshold$(EXESUF): tests/test-write-threshold.o $(test-block-obj-y)
 tests/test-netfilter$(EXESUF): tests/test-netfilter.o $(qtest-obj-y)
 tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-y)
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
new file mode 100644
index 0000000..91b4391
--- /dev/null
+++ b/tests/test-keyval.c
@@ -0,0 +1,154 @@
+/*
+ * Unit tests for parsing of KEY=VALUE,... strings
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+
+static void test_keyval_parse(void)
+{
+    Error *err = NULL;
+    QDict *qdict, *sub_qdict;
+    char long_key[129];
+    char *params;
+
+    /* Nothing */
+    qdict = keyval_parse("", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 0);
+    QDECREF(qdict);
+
+    /* Empty key */
+    qdict = keyval_parse("=val", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Empty key component */
+    qdict = keyval_parse(".", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    qdict = keyval_parse("key.", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Overlong key */
+    memset(long_key, 'a', 127);
+    long_key[127] = 'z';
+    long_key[128] = 0;
+    params = g_strdup_printf("k.%s=v", long_key);
+    qdict = keyval_parse(params + 2, NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Overlong key component */
+    qdict = keyval_parse(params, NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    g_free(params);
+
+    /* Long key */
+    params = g_strdup_printf("k.%s=v", long_key + 1);
+    qdict = keyval_parse(params + 2, NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, long_key + 1), ==, "v");
+    QDECREF(qdict);
+
+    /* Long key component */
+    qdict = keyval_parse(params, NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    sub_qdict = qdict_get_qdict(qdict, "k");
+    g_assert(sub_qdict);
+    g_assert_cmpuint(qdict_size(sub_qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(sub_qdict, long_key + 1), ==, "v");
+    QDECREF(qdict);
+    g_free(params);
+
+    /* Multiple keys, last one wins */
+    qdict = keyval_parse("a=1,b=2,,x,a=3", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 2);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "a"), ==, "3");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "b"), ==, "2,x");
+    QDECREF(qdict);
+
+    /* Even when it doesn't in QemuOpts */
+    qdict = keyval_parse("id=foo,id=bar", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "bar");
+    QDECREF(qdict);
+
+    /* Dotted keys */
+    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 2);
+    sub_qdict = qdict_get_qdict(qdict, "a");
+    g_assert(sub_qdict);
+    g_assert_cmpuint(qdict_size(sub_qdict), ==, 1);
+    sub_qdict = qdict_get_qdict(sub_qdict, "b");
+    g_assert(sub_qdict);
+    g_assert_cmpuint(qdict_size(sub_qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(sub_qdict, "c"), ==, "2");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "d"), ==, "3");
+    QDECREF(qdict);
+
+    /* Inconsistent dotted keys */
+    qdict = keyval_parse("a.b=1,a=2", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    qdict = keyval_parse("a.b=1,a.b.c=2", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Implied value */
+    qdict = keyval_parse("an,noaus,noaus=", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 3);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "an"), ==, "on");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), ==, "");
+    QDECREF(qdict);
+
+    /* Implied key */
+    qdict = keyval_parse("an,noaus,noaus=", "implied", &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 3);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "an");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), ==, "");
+    QDECREF(qdict);
+
+    /* Trailing comma is ignored */
+    qdict = keyval_parse("x=y,", NULL,  &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, "y");
+    QDECREF(qdict);
+
+    /* Except when it isn't */
+    qdict = keyval_parse(",", NULL,  &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Value containing ,id= not misinterpreted as QemuOpts does */
+    qdict = keyval_parse("x=,,id=bar", NULL,  &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, ",id=bar");
+    QDECREF(qdict);
+
+    /* Anti-social ID is left to caller */
+    qdict = keyval_parse("id=666", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "666");
+    QDECREF(qdict);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/keyval/keyval_parse", test_keyval_parse);
+    g_test_run();
+    return 0;
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index bc629e2..06366b5 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -24,6 +24,7 @@ util-obj-y += error.o qemu-error.o
 util-obj-y += id.o
 util-obj-y += iov.o qemu-config.o qemu-sockets.o uri.o notify.o
 util-obj-y += qemu-option.o qemu-progress.o
+util-obj-y += keyval.o
 util-obj-y += hexdump.o
 util-obj-y += crc32c.o
 util-obj-y += uuid.o
diff --git a/util/keyval.c b/util/keyval.c
new file mode 100644
index 0000000..c6cdd22
--- /dev/null
+++ b/util/keyval.c
@@ -0,0 +1,150 @@
+/*
+ * Parsing KEY=VALUE,... strings
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qstring.h"
+#include "qemu/option.h"
+
+/* TODO Support lists */
+
+static QObject *keyval_parse_put(QDict *qdict, const char *key, QString *value,
+                                 Error **errp)
+{
+    QObject *old, *new;
+
+    old = qdict_get(qdict, key);
+    if (old) {
+        if (qobject_type(old) != (value ? QTYPE_QSTRING : QTYPE_QDICT)) {
+            error_setg(errp, "Option key '%s' used inconsistently", key);
+            return NULL;
+        }
+        if (!value) {
+            return old;
+        }
+        new = QOBJECT(value);
+    } else {
+        new = QOBJECT(value) ?: QOBJECT(qdict_new());
+    }
+    qdict_put_obj(qdict, key, new);
+    return new;
+}
+
+static const char *keyval_parse_one(QDict *qdict, const char *params,
+                                    const char *implied_key,
+                                    Error **errp)
+{
+    QDict *cur = qdict;
+    QObject *next;
+    const char *s, *key;
+    size_t len;
+    char key_buf[128];
+    QString *val;
+
+    s = params;
+    len = strcspn(s, ".=,");
+    if (implied_key && (s[len] == ',' || !s[len])) {
+        /* Desugar implied key */
+        key = implied_key;
+    } else {
+        key_buf[0] = 0;
+        for (;;) {
+            if (!len) {
+                error_setg(errp, "Invalid option key");
+                return NULL;
+            }
+            if (len >= sizeof(key_buf)) {
+                error_setg(errp, "Option key component '%.*s' is too long",
+                           (int)len, s);
+                return NULL;
+            }
+
+            if (key_buf[0]) {
+                next = keyval_parse_put(cur, key_buf, NULL, errp);
+                if (!next) {
+                    return NULL;
+                }
+                cur = qobject_to_qdict(next);
+                assert(cur);
+            }
+
+            memcpy(key_buf, s, len);
+            key_buf[len] = 0;
+            s += len;
+            if (*s != '.') {
+                break;
+            }
+            s++;
+            len = strcspn(s, ".=,");
+        }
+        key = key_buf;
+
+        if (*s == '=') {
+            s++;
+        } else {
+            /*
+             * Desugar implied value: it's "on", except when @key
+             * starts with "no", it's "off".  Thus, key "novocaine"
+             * gets desugard to "vocaine=off", not to "novocaine=on".
+             * If sugar isn't bad enough for you, make it ambiguous...
+             */
+            if (*s == ',')
+                s++;
+            if (!strncmp(key, "no", 2)) {
+                key += 2;
+                val = qstring_from_str("off");
+            } else {
+                val = qstring_from_str("on");
+            }
+            goto got_val;
+        }
+    }
+
+    val = qstring_new();
+    for (;;) {
+        if (!*s) {
+            break;
+        } else if (*s == ',') {
+            s++;
+            if (*s != ',') {
+                break;
+            }
+        }
+        qstring_append_chr(val, *s++);
+    }
+
+got_val:
+    if (!keyval_parse_put(cur, key, val, errp)) {
+        return NULL;
+    }
+    return s;
+}
+
+/* TODO function comment */
+QDict *keyval_parse(const char *params, const char *implied_key,
+                    Error **errp)
+{
+    QDict *qdict = qdict_new();
+    const char *s;
+
+    s = params;
+    while (*s) {
+        s = keyval_parse_one(qdict, s, implied_key, errp);
+        if (!s) {
+            QDECREF(qdict);
+            return NULL;
+        }
+        implied_key = NULL;
+    }
+
+    return qdict;
+}
-- 
2.7.4
