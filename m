Received: from eggs.gnu.org ([2001:4830:134:3::10]:52411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBm-0006fh-6X
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fnNBi-0008Sj-VP
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fnNBi-0008RM-Nh
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:03:38 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed,  8 Aug 2018 14:02:53 +0200
Message-Id: <20180808120334.10970-16-armbru@redhat.com>
In-Reply-To: <20180808120334.10970-1-armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 15/56] check-qjson: Cover interpolation more
 thoroughly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 141 ++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 33bd5854fc..fda2b014a3 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -845,30 +845,6 @@ static void utf8_string(void)
     }
 }
 
-static void vararg_string(void)
-{
-    int i;
-    struct {
-        const char *decoded;
-    } test_cases[] = {
-        { "hello world" },
-        { "the quick brown fox jumped over the fence" },
-        {}
-    };
-
-    for (i = 0; test_cases[i].decoded; i++) {
-        QString *str;
-
-        str = qobject_to(QString,
-                         qobject_from_jsonf_nofail("%s",
-                                                   test_cases[i].decoded));
-        g_assert(str);
-        g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
-
-        qobject_unref(str);
-    }
-}
-
 static void simple_number(void)
 {
     int i;
@@ -986,29 +962,6 @@ static void float_number(void)
     }
 }
 
-static void vararg_number(void)
-{
-    QNum *qnum;
-    int value = 0x2342;
-    long long value_ll = 0x2342342343LL;
-    double valuef = 2.323423423;
-    int64_t val;
-
-    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%d", value));
-    g_assert(qnum_get_try_int(qnum, &val));
-    g_assert_cmpint(val, ==, value);
-    qobject_unref(qnum);
-
-    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%lld", value_ll));
-    g_assert(qnum_get_try_int(qnum, &val));
-    g_assert_cmpint(val, ==, value_ll);
-    qobject_unref(qnum);
-
-    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%f", valuef));
-    g_assert(qnum_get_double(qnum) == valuef);
-    qobject_unref(qnum);
-}
-
 static void keyword_literal(void)
 {
     QObject *obj;
@@ -1038,17 +991,6 @@ static void keyword_literal(void)
 
     qobject_unref(qbool);
 
-    qbool = qobject_to(QBool, qobject_from_jsonf_nofail("%i", false));
-    g_assert(qbool);
-    g_assert(qbool_get_bool(qbool) == false);
-    qobject_unref(qbool);
-
-    /* Test that non-zero values other than 1 get collapsed to true */
-    qbool = qobject_to(QBool, qobject_from_jsonf_nofail("%i", 2));
-    g_assert(qbool);
-    g_assert(qbool_get_bool(qbool) == true);
-    qobject_unref(qbool);
-
     obj = qobject_from_json("null", &error_abort);
     g_assert(obj != NULL);
     g_assert(qobject_type(obj) == QTYPE_QNULL);
@@ -1060,6 +1002,78 @@ static void keyword_literal(void)
     qobject_unref(null);
 }
 
+static void interpolation(void)
+{
+    long long value_lld = 0x123456789abcdefLL;
+    long value_ld = (long)value_lld;
+    int value_d = (int)value_lld;
+    unsigned long long value_llu = 0xfedcba9876543210ULL;
+    unsigned long value_lu = (unsigned long)value_llu;
+    unsigned value_u = (unsigned)value_llu;
+    double value_f = 2.323423423;
+    const char *value_s = "hello world";
+    QObject *value_p = QOBJECT(qnull());
+    QBool *qbool;
+    QNum *qnum;
+    QString *qstr;
+    QObject *qobj;
+
+    /* bool */
+
+    qbool = qobject_to(QBool, qobject_from_jsonf_nofail("%i", false));
+    g_assert(qbool);
+    g_assert(qbool_get_bool(qbool) == false);
+    qobject_unref(qbool);
+
+    /* Test that non-zero values other than 1 get collapsed to true */
+    qbool = qobject_to(QBool, qobject_from_jsonf_nofail("%i", 2));
+    g_assert(qbool);
+    g_assert(qbool_get_bool(qbool) == true);
+    qobject_unref(qbool);
+
+    /* number */
+
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%d", value_d));
+    g_assert_cmpint(qnum_get_int(qnum), ==, value_d);
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%ld", value_ld));
+    g_assert_cmpint(qnum_get_int(qnum), ==, value_ld);
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%lld", value_lld));
+    g_assert_cmpint(qnum_get_int(qnum), ==, value_lld);
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%u", value_u));
+    g_assert_cmpuint(qnum_get_uint(qnum), ==, value_u);
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%lu", value_lu));
+    g_assert_cmpuint(qnum_get_uint(qnum), ==, value_lu);
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%llu", value_llu));
+    g_assert_cmpuint(qnum_get_uint(qnum), ==, value_llu);
+    qobject_unref(qnum);
+
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%f", value_f));
+    g_assert(qnum_get_double(qnum) == value_f);
+    qobject_unref(qnum);
+
+    /* string */
+
+    qstr = qobject_to(QString,
+                     qobject_from_jsonf_nofail("%s", value_s));
+    g_assert_cmpstr(qstring_get_try_str(qstr), ==, value_s);
+    qobject_unref(qstr);
+
+    /* object */
+
+    qobj = qobject_from_jsonf_nofail("%p", value_p);
+    g_assert(qobj == value_p);
+}
+
 static void simple_dict(void)
 {
     int i;
@@ -1278,7 +1292,7 @@ static void simple_whitespace(void)
     }
 }
 
-static void simple_varargs(void)
+static void simple_interpolation(void)
 {
     QObject *embedded_obj;
     QObject *obj;
@@ -1470,22 +1484,21 @@ int main(int argc, char **argv)
 
     g_test_add_func("/literals/string/escaped", escaped_string);
     g_test_add_func("/literals/string/utf8", utf8_string);
-    g_test_add_func("/literals/string/vararg", vararg_string);
 
     g_test_add_func("/literals/number/simple", simple_number);
     g_test_add_func("/literals/number/large", large_number);
     g_test_add_func("/literals/number/float", float_number);
-    g_test_add_func("/literals/number/vararg", vararg_number);
 
     g_test_add_func("/literals/keyword", keyword_literal);
 
+    g_test_add_func("/literals/interpolation", interpolation);
+
     g_test_add_func("/dicts/simple_dict", simple_dict);
     g_test_add_func("/dicts/large_dict", large_dict);
     g_test_add_func("/lists/simple_list", simple_list);
 
-    g_test_add_func("/whitespace/simple_whitespace", simple_whitespace);
-
-    g_test_add_func("/varargs/simple_varargs", simple_varargs);
+    g_test_add_func("/mixed/simple_whitespace", simple_whitespace);
+    g_test_add_func("/mixed/interpolation", simple_interpolation);
 
     g_test_add_func("/errors/empty", empty_input);
     g_test_add_func("/errors/blank", blank_input);
-- 
2.17.1
