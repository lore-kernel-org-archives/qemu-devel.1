Received: from eggs.gnu.org ([2001:4830:134:3::10]:38335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMu-0002s2-LI
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMm-0002lk-MB
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cktMm-0002lA-Cw
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:00 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6886C80465
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 14:11:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v26EBv77011891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 09:11:58 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 15:11:34 +0100
Message-Id: <1488809515-4047-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1488809515-4047-1-git-send-email-armbru@redhat.com>
References: <1488809515-4047-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 03/24] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

keyval_parse() parses KEY=VALUE,... into a QDict.  Works like
qemu_opts_parse(), except:

* Returns a QDict instead of a QemuOpts (d'oh).

* Supports nesting, unlike QemuOpts: a KEY is split into key
  fragments at '.' (dotted key convention; the block layer does
  something similar on top of QemuOpts).  The key fragments are QDict
  keys, and the last one's value is updated to VALUE.

* Each key fragment may be up to 127 bytes long.  qemu_opts_parse()
  limits the entire key to 127 bytes.

* Overlong key fragments are rejected.  qemu_opts_parse() silently
  truncates them.

* Empty key fragments are rejected.  qemu_opts_parse() happily
  accepts empty keys.

* It does not store the returned value.  qemu_opts_parse() stores it
  in the QemuOptsList.

* It does not treat parameter "id" specially.  qemu_opts_parse()
  ignores all but the first "id", and fails when its value isn't
  id_wellformed(), or duplicate (a QemuOpts with the same ID is
  already stored).  It also screws up when a value contains ",id=".

* Implied value is not supported.  qemu_opts_parse() desugars "foo" to
  "foo=on", and "nofoo" to "foo=off".

* An implied key's value can't be empty, and can't contain ','.

I intend to grow this into a saner replacement for QemuOpts.  It'll
take time, though.

Note: keyval_parse() provides no way to do lists, and its key syntax
is incompatible with the __RFQDN_ prefix convention for downstream
extensions, because it blindly splits at '.', even in __RFQDN_.  Both
issues will be addressed later in the series.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1488317230-26248-4-git-send-email-armbru@redhat.com>
---
 include/qemu/option.h  |   3 +
 tests/.gitignore       |   1 +
 tests/Makefile.include |   3 +
 tests/test-keyval.c    | 180 ++++++++++++++++++++++++++++++++++++++
 util/Makefile.objs     |   1 +
 util/keyval.c          | 231 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 419 insertions(+)
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
index b65c2b5..3c34295 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -94,6 +94,8 @@ check-unit-y += tests/check-qom-proplist$(EXESUF)
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
index 0000000..27f6625
--- /dev/null
+++ b/tests/test-keyval.c
@@ -0,0 +1,180 @@
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
+    /* Empty key (qemu_opts_parse() accepts this) */
+    qdict = keyval_parse("=val", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Empty key fragment */
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
+    /* Overlong key fragment */
+    qdict = keyval_parse(params, NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    g_free(params);
+
+    /* Long key (qemu_opts_parse() accepts and truncates silently) */
+    params = g_strdup_printf("k.%s=v", long_key + 1);
+    qdict = keyval_parse(params + 2, NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, long_key + 1), ==, "v");
+    QDECREF(qdict);
+
+    /* Long key fragment */
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
+    /* Even when it doesn't in qemu_opts_parse() */
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
+    /* Trailing comma is ignored */
+    qdict = keyval_parse("x=y,", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, "y");
+    QDECREF(qdict);
+
+    /* Except when it isn't */
+    qdict = keyval_parse(",", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Value containing ,id= not misinterpreted as qemu_opts_parse() does */
+    qdict = keyval_parse("x=,,id=bar", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, ",id=bar");
+    QDECREF(qdict);
+
+    /* Anti-social ID is left to caller (qemu_opts_parse() rejects it) */
+    qdict = keyval_parse("id=666", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "666");
+    QDECREF(qdict);
+
+    /* Implied value not supported (unlike qemu_opts_parse()) */
+    qdict = keyval_parse("an,noaus,noaus=", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Implied value, key "no" (qemu_opts_parse(): negated empty key) */
+    qdict = keyval_parse("no", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Implied key */
+    qdict = keyval_parse("an,aus=off,noaus=", "implied", &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 3);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "an");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), ==, "");
+    QDECREF(qdict);
+
+    /* Implied dotted key */
+    qdict = keyval_parse("val", "eins.zwei", &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    sub_qdict = qdict_get_qdict(qdict, "eins");
+    g_assert(sub_qdict);
+    g_assert_cmpuint(qdict_size(sub_qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(sub_qdict, "zwei"), ==, "val");
+    QDECREF(qdict);
+
+    /* Implied key with empty value (qemu_opts_parse() accepts this) */
+    qdict = keyval_parse(",", "implied", &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Likewise (qemu_opts_parse(): implied key with comma value) */
+    qdict = keyval_parse(",,,a=1", "implied", &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Empty key is not an implied key */
+    qdict = keyval_parse("=val", "implied", &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
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
index 0000000..990126f
--- /dev/null
+++ b/util/keyval.c
@@ -0,0 +1,231 @@
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
+/*
+ * KEY=VALUE,... syntax:
+ *
+ *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
+ *   key-val      = key '=' val
+ *   key          = key-fragment { '.' key-fragment }
+ *   key-fragment = / [^=,.]* /
+ *   val          = { / [^,]* / | ',,' }
+ *
+ * Semantics defined by reduction to JSON:
+ *
+ *   key-vals defines a tree of objects rooted at R
+ *   where for each key-val = key-fragment . ... = val in key-vals
+ *       R op key-fragment op ... = val'
+ *       where (left-associative) op is member reference L.key-fragment
+ *             val' is val with ',,' replaced by ','
+ *   and only R may be empty.
+ *
+ *   Duplicate keys are permitted; all but the last one are ignored.
+ *
+ *   The equations must have a solution.  Counter-example: a.b=1,a=2
+ *   doesn't have one, because R.a must be an object to satisfy a.b=1
+ *   and a string to satisfy a=2.
+ *
+ * The length of any key-fragment must be between 1 and 127.
+ *
+ * Design flaw: there is no way to denote an empty non-root object.
+ * While interpreting "key absent" as empty object seems natural
+ * (removing a key-val from the input string removes the member when
+ * there are more, so why not when it's the last), it doesn't work:
+ * "key absent" already means "optional object absent", which isn't
+ * the same as "empty object present".
+ *
+ * Additional syntax for use with an implied key:
+ *
+ *   key-vals-ik  = val-no-key [ ',' key-vals ]
+ *   val-no-key   = / [^=,]* /
+ *
+ * where no-key is syntactic sugar for implied-key=val-no-key.
+ *
+ * TODO support lists
+ * TODO support key-fragment with __RFQDN_ prefix (downstream extensions)
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qstring.h"
+#include "qemu/option.h"
+
+/*
+ * Ensure @cur maps @key_in_cur the right way.
+ * If @value is null, it needs to map to a QDict, else to this
+ * QString.
+ * If @cur doesn't have @key_in_cur, put an empty QDict or @value,
+ * respectively.
+ * Else, if it needs to map to a QDict, and already does, do nothing.
+ * Else, if it needs to map to this QString, and already maps to a
+ * QString, replace it by @value.
+ * Else, fail because we have conflicting needs on how to map
+ * @key_in_cur.
+ * In any case, take over the reference to @value, i.e. if the caller
+ * wants to hold on to a reference, it needs to QINCREF().
+ * Use @key up to @key_cursor to identify the key in error messages.
+ * On success, return the mapped value.
+ * On failure, store an error through @errp and return NULL.
+ */
+static QObject *keyval_parse_put(QDict *cur,
+                                 const char *key_in_cur, QString *value,
+                                 const char *key, const char *key_cursor,
+                                 Error **errp)
+{
+    QObject *old, *new;
+
+    old = qdict_get(cur, key_in_cur);
+    if (old) {
+        if (qobject_type(old) != (value ? QTYPE_QSTRING : QTYPE_QDICT)) {
+            error_setg(errp, "Parameters '%.*s.*' used inconsistently",
+                       (int)(key_cursor - key), key);
+            QDECREF(value);
+            return NULL;
+        }
+        if (!value) {
+            return old;         /* already QDict, do nothing */
+        }
+        new = QOBJECT(value);   /* replacement */
+    } else {
+        new = QOBJECT(value) ?: QOBJECT(qdict_new());
+    }
+    qdict_put_obj(cur, key_in_cur, new);
+    return new;
+}
+
+/*
+ * Parse one KEY=VALUE from @params, store result in @qdict.
+ * The first fragment of KEY applies to @qdict.  Subsequent fragments
+ * apply to nested QDicts, which are created on demand.  @implied_key
+ * is as in keyval_parse().
+ * On success, return a pointer to the next KEY=VALUE, or else to '\0'.
+ * On failure, return NULL.
+ */
+static const char *keyval_parse_one(QDict *qdict, const char *params,
+                                    const char *implied_key,
+                                    Error **errp)
+{
+    const char *key, *key_end, *s;
+    size_t len;
+    char key_in_cur[128];
+    QDict *cur;
+    QObject *next;
+    QString *val;
+
+    key = params;
+    len = strcspn(params, "=,");
+    if (implied_key && len && key[len] != '=') {
+        /* Desugar implied key */
+        key = implied_key;
+        len = strlen(implied_key);
+    }
+    key_end = key + len;
+
+    /*
+     * Loop over key fragments: @s points to current fragment, it
+     * applies to @cur.  @key_in_cur[] holds the previous fragment.
+     */
+    cur = qdict;
+    s = key;
+    for (;;) {
+        for (len = 0; s + len < key_end && s[len] != '.'; len++) {
+        }
+        if (!len) {
+            assert(key != implied_key);
+            error_setg(errp, "Invalid parameter '%.*s'",
+                       (int)(key_end - key), key);
+            return NULL;
+        }
+        if (len >= sizeof(key_in_cur)) {
+            assert(key != implied_key);
+            error_setg(errp, "Parameter%s '%.*s' is too long",
+                       s != key || s + len != key_end ? " fragment" : "",
+                       (int)len, s);
+            return NULL;
+        }
+
+        if (s != key) {
+            next = keyval_parse_put(cur, key_in_cur, NULL,
+                                    key, s - 1, errp);
+            if (!next) {
+                return NULL;
+            }
+            cur = qobject_to_qdict(next);
+            assert(cur);
+        }
+
+        memcpy(key_in_cur, s, len);
+        key_in_cur[len] = 0;
+        s += len;
+
+        if (*s != '.') {
+            break;
+        }
+        s++;
+    }
+
+    if (key == implied_key) {
+        assert(!*s);
+        s = params;
+    } else {
+        if (*s != '=') {
+            error_setg(errp, "Expected '=' after parameter '%.*s'",
+                       (int)(s - key), key);
+            return NULL;
+        }
+        s++;
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
+    if (!keyval_parse_put(cur, key_in_cur, val, key, key_end, errp)) {
+        return NULL;
+    }
+    return s;
+}
+
+/*
+ * Parse @params in QEMU's traditional KEY=VALUE,... syntax.
+ * If @implied_key, the first KEY= can be omitted.  @implied_key is
+ * implied then, and VALUE can't be empty or contain ',' or '='.
+ * On success, return a dictionary of the parsed keys and values.
+ * On failure, store an error through @errp and return NULL.
+ */
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
