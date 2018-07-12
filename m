Received: from eggs.gnu.org ([2001:4830:134:3::10]:47870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWO-00077g-5r
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZWL-0006pR-CP
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdZWL-0006oB-02
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:12:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2B5F34667
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:12:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 12 Jul 2018 13:12:06 +0200
Message-Id: <20180712111221.20326-6-armbru@redhat.com>
In-Reply-To: <20180712111221.20326-1-armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 05/20] qobject: Replace qobject_from_jsonf() by
 qobject_from_jsonf_nofail()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit ab45015a968 "qobject: Let qobject_from_jsonf() fail instead of
abort" removed only one of two ways qobject_from_jsonf() can abort.
Wrong.  Its rationale for letting it fail is that all remaining users
cope fine with failure.  Well, they're just fine with aborting, too;
it's what they do on failure.

Simply reverting the broken commit would bring back the unfortunate
asymmetry between qobject_from_jsonf() and qobject_from_jsonv(): one
aborts, the other returns null.  So also rename it to
qobject_from_jsonf_nofail().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qjson.h |  6 ++++--
 qobject/qjson.c          |  8 +++++++-
 tests/check-qjson.c      | 15 ++++++++-------
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index 43b2ce2f33..dc509d51ae 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -15,11 +15,13 @@
 #define QJSON_H
 
 QObject *qobject_from_json(const char *string, Error **errp);
-QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
 QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
     GCC_FMT_ATTR(1, 0);
 
-QDict *qdict_from_jsonf_nofail(const char *string, ...) GCC_FMT_ATTR(1, 2);
+QObject *qobject_from_jsonf_nofail(const char *string, ...)
+    GCC_FMT_ATTR(1, 2);
+QDict *qdict_from_jsonf_nofail(const char *string, ...)
+    GCC_FMT_ATTR(1, 2);
 
 QString *qobject_to_json(const QObject *obj);
 QString *qobject_to_json_pretty(const QObject *obj);
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 2f6a590e44..4a9dcff343 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -59,7 +59,12 @@ QObject *qobject_from_json(const char *string, Error **errp)
     return qobject_from_jsonv(string, NULL, errp);
 }
 
-QObject *qobject_from_jsonf(const char *string, ...)
+/*
+ * Parse @string as JSON value with %-escapes interpolated.
+ * Abort on error.  Do not use with untrusted @string.
+ * Return the resulting QObject.  It is never null.
+ */
+QObject *qobject_from_jsonf_nofail(const char *string, ...)
 {
     QObject *obj;
     va_list ap;
@@ -68,6 +73,7 @@ QObject *qobject_from_jsonf(const char *string, ...)
     obj = qobject_from_jsonv(string, &ap, &error_abort);
     va_end(ap);
 
+    assert(obj);
     return obj;
 }
 
diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index da582df3e9..eaf5d20663 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -865,7 +865,8 @@ static void vararg_string(void)
         QString *str;
 
         str = qobject_to(QString,
-                         qobject_from_jsonf("%s", test_cases[i].decoded));
+                         qobject_from_jsonf_nofail("%s",
+                                                   test_cases[i].decoded));
         g_assert(str);
         g_assert(strcmp(qstring_get_str(str), test_cases[i].decoded) == 0);
 
@@ -998,17 +999,17 @@ static void vararg_number(void)
     double valuef = 2.323423423;
     int64_t val;
 
-    qnum = qobject_to(QNum, qobject_from_jsonf("%d", value));
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%d", value));
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, value);
     qobject_unref(qnum);
 
-    qnum = qobject_to(QNum, qobject_from_jsonf("%lld", value_ll));
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%lld", value_ll));
     g_assert(qnum_get_try_int(qnum, &val));
     g_assert_cmpint(val, ==, value_ll);
     qobject_unref(qnum);
 
-    qnum = qobject_to(QNum, qobject_from_jsonf("%f", valuef));
+    qnum = qobject_to(QNum, qobject_from_jsonf_nofail("%f", valuef));
     g_assert(qnum_get_double(qnum) == valuef);
     qobject_unref(qnum);
 }
@@ -1042,13 +1043,13 @@ static void keyword_literal(void)
 
     qobject_unref(qbool);
 
-    qbool = qobject_to(QBool, qobject_from_jsonf("%i", false));
+    qbool = qobject_to(QBool, qobject_from_jsonf_nofail("%i", false));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == false);
     qobject_unref(qbool);
 
     /* Test that non-zero values other than 1 get collapsed to true */
-    qbool = qobject_to(QBool, qobject_from_jsonf("%i", 2));
+    qbool = qobject_to(QBool, qobject_from_jsonf_nofail("%i", 2));
     g_assert(qbool);
     g_assert(qbool_get_bool(qbool) == true);
     qobject_unref(qbool);
@@ -1298,7 +1299,7 @@ static void simple_varargs(void)
     embedded_obj = qobject_from_json("[32, 42]", &error_abort);
     g_assert(embedded_obj != NULL);
 
-    obj = qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
+    obj = qobject_from_jsonf_nofail("[%d, 2, %p]", 1, embedded_obj);
     g_assert(qlit_equal_qobject(&decoded, obj));
 
     qobject_unref(obj);
-- 
2.17.1
