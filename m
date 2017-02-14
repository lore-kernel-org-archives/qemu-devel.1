Received: from eggs.gnu.org ([2001:4830:134:3::10]:53882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdfBB-0007Gy-9A
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdfB9-0007rT-HT
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:38:09 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 16:37:55 +0100
Message-Id: <1487086676-24339-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487086676-24339-1-git-send-email-armbru@redhat.com>
References: <1487086676-24339-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 1/2] util/qemu-option: New
 opt_parse_qdict()
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

opt_parse_qdict() parses KEY=VALUE,... into a QDict.  Works like
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/option.h  |   3 ++
 tests/test-qemu-opts.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-option.c     | 131 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index 1f9e3f9..436a13c 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -132,4 +132,7 @@ void qemu_opts_print_help(QemuOptsList *list);
 void qemu_opts_free(QemuOptsList *list);
 QemuOptsList *qemu_opts_append(QemuOptsList *dst, QemuOptsList *list);
 
+QDict *opt_parse_qdict(const char *params, const char *implied_key,
+                       Error **errp);
+
 #endif
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index b9d5b7e..bbb821f 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -702,6 +702,137 @@ static void test_opts_parse_size(void)
     qemu_opts_reset(&opts_list_02);
 }
 
+static void test_opt_parse_qdict(void)
+{
+    Error *err = NULL;
+    QDict *qdict, *sub_qdict;
+    char long_key[129];
+    char *params;
+
+    /* Nothing */
+    qdict = opt_parse_qdict("", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 0);
+    QDECREF(qdict);
+
+    /* Empty key */
+    qdict = opt_parse_qdict("=val", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Empty key component */
+    qdict = opt_parse_qdict(".", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    qdict = opt_parse_qdict("key.", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Overlong key */
+    memset(long_key, 'a', 127);
+    long_key[127] = 'z';
+    long_key[128] = 0;
+    params = g_strdup_printf("k.%s=v", long_key);
+    qdict = opt_parse_qdict(params + 2, NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Overlong key component */
+    qdict = opt_parse_qdict(params, NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    g_free(params);
+
+    /* Long key */
+    params = g_strdup_printf("k.%s=v", long_key + 1);
+    qdict = opt_parse_qdict(params + 2, NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, long_key + 1), ==, "v");
+    QDECREF(qdict);
+
+    /* Long key component */
+    qdict = opt_parse_qdict(params, NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    sub_qdict = qdict_get_qdict(qdict, "k");
+    g_assert(sub_qdict);
+    g_assert_cmpuint(qdict_size(sub_qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(sub_qdict, long_key + 1), ==, "v");
+    QDECREF(qdict);
+    g_free(params);
+
+    /* Multiple keys, last one wins */
+    qdict = opt_parse_qdict("a=1,b=2,,x,a=3", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 2);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "a"), ==, "3");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "b"), ==, "2,x");
+    QDECREF(qdict);
+
+    /* Even when it doesn't in QemuOpts */
+    qdict = opt_parse_qdict("id=foo,id=bar", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "bar");
+    QDECREF(qdict);
+
+    /* Dotted keys */
+    qdict = opt_parse_qdict("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
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
+    qdict = opt_parse_qdict("a.b=1,a=2", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+    qdict = opt_parse_qdict("a.b=1,a.b.c=2", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Implied value */
+    qdict = opt_parse_qdict("an,noaus,noaus=", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 3);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "an"), ==, "on");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), ==, "");
+    QDECREF(qdict);
+
+    /* Implied key */
+    qdict = opt_parse_qdict("an,noaus,noaus=", "implied", &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 3);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "an");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "noaus"), ==, "");
+    QDECREF(qdict);
+
+    /* Trailing comma is ignored */
+    qdict = opt_parse_qdict("x=y,", NULL,  &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, "y");
+    QDECREF(qdict);
+
+    /* Except when it isn't */
+    qdict = opt_parse_qdict(",", NULL,  &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Value containing ,id= not misinterpreted as QemuOpts does */
+    qdict = opt_parse_qdict("x=,,id=bar", NULL,  &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, ",id=bar");
+    QDECREF(qdict);
+
+    /* Anti-social ID is left to caller */
+    qdict = opt_parse_qdict("id=666", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "666");
+    QDECREF(qdict);
+}
+
 int main(int argc, char *argv[])
 {
     register_opts();
@@ -720,6 +851,7 @@ int main(int argc, char *argv[])
     g_test_add_func("/qemu-opts/opts_parse/bool", test_opts_parse_bool);
     g_test_add_func("/qemu-opts/opts_parse/number", test_opts_parse_number);
     g_test_add_func("/qemu-opts/opts_parse/size", test_opts_parse_size);
+    g_test_add_func("/qemu-opts/opt_parse_qdict", test_opt_parse_qdict);
     g_test_run();
     return 0;
 }
diff --git a/util/qemu-option.c b/util/qemu-option.c
index c11ce93..49d2760 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1184,3 +1184,134 @@ QemuOptsList *qemu_opts_append(QemuOptsList *dst,
 
     return dst;
 }
+
+static QObject *opt_parse_put(QDict *qdict, const char *key, QString *value,
+                              Error **errp)
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
+static const char *opt_parse_one(QDict *qdict,
+                                 const char *params, const char *implied_key,
+                                 Error **errp)
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
+                next = opt_parse_put(cur, key_buf, NULL, errp);
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
+    if (!opt_parse_put(cur, key, val, errp)) {
+        return NULL;
+    }
+    return s;
+}
+
+QDict *opt_parse_qdict(const char *params, const char *implied_key,
+                         Error **errp)
+{
+    QDict *qdict = qdict_new();
+    const char *s;
+
+    s = params;
+    while (*s) {
+        s = opt_parse_one(qdict, s, implied_key, errp);
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
