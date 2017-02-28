Received: from eggs.gnu.org ([2001:4830:134:3::10]:33795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDy-0005AZ-GX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDs-0000Yb-F0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDs-0000Xd-78
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:20 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A8B237F1F
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SMQI7a017516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:26:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:25:56 +0100
Message-Id: <1488320775-9849-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 05/24] test-keyval: Cover use with qobject input
 visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-6-git-send-email-armbru@redhat.com>
---
 tests/test-keyval.c | 312 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 27f6625..1c2aeea 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -12,6 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qemu/cutils.h"
 #include "qemu/option.h"
 
 static void test_keyval_parse(void)
@@ -171,10 +173,320 @@ static void test_keyval_parse(void)
     g_assert(!qdict);
 }
 
+static void test_keyval_visit_bool(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    bool b;
+
+    qdict = keyval_parse("bool1=on,bool2=off", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_bool(v, "bool1", &b, &error_abort);
+    g_assert(b);
+    visit_type_bool(v, "bool2", &b, &error_abort);
+    g_assert(!b);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    qdict = keyval_parse("bool1=offer", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_bool(v, "bool1", &b, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
+static void test_keyval_visit_number(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    uint64_t u;
+
+    /* Lower limit zero */
+    qdict = keyval_parse("number1=0", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &error_abort);
+    g_assert_cmpuint(u, ==, 0);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Upper limit 2^64-1 */
+    qdict = keyval_parse("number1=18446744073709551615,number2=-1",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &error_abort);
+    g_assert_cmphex(u, ==, UINT64_MAX);
+    visit_type_uint64(v, "number2", &u, &error_abort);
+    g_assert_cmphex(u, ==, UINT64_MAX);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Above upper limit */
+    qdict = keyval_parse("number1=18446744073709551616",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Below lower limit */
+    qdict = keyval_parse("number1=-18446744073709551616",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Hex and octal */
+    qdict = keyval_parse("number1=0x2a,number2=052",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &error_abort);
+    g_assert_cmpuint(u, ==, 42);
+    visit_type_uint64(v, "number2", &u, &error_abort);
+    g_assert_cmpuint(u, ==, 42);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Trailing crap */
+    qdict = keyval_parse("number1=3.14,number2=08",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_uint64(v, "number1", &u, &err);
+    error_free_or_abort(&err);
+    visit_type_uint64(v, "number2", &u, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
+static void test_keyval_visit_size(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    uint64_t sz;
+
+    /* Lower limit zero */
+    qdict = keyval_parse("sz1=0", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmpuint(sz, ==, 0);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Note: precision is 53 bits since we're parsing with strtod() */
+
+    /* Around limit of precision: 2^53-1, 2^53, 2^53+1 */
+    qdict = keyval_parse("sz1=9007199254740991,"
+                         "sz2=9007199254740992,"
+                         "sz3=9007199254740993",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x1fffffffffffff);
+    visit_type_size(v, "sz2", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x20000000000000);
+    visit_type_size(v, "sz3", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x20000000000000);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
+    qdict = keyval_parse("sz1=9223372036854774784," /* 7ffffffffffffc00 */
+                         "sz2=9223372036854775295", /* 7ffffffffffffdff */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x7ffffffffffffc00);
+    visit_type_size(v, "sz2", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0x7ffffffffffffc00);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
+    qdict = keyval_parse("sz1=18446744073709549568," /* fffffffffffff800 */
+                         "sz2=18446744073709550591", /* fffffffffffffbff */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0xfffffffffffff800);
+    visit_type_size(v, "sz2", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 0xfffffffffffff800);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Beyond limits */
+    qdict = keyval_parse("sz1=-1,"
+                         "sz2=18446744073709550592", /* fffffffffffffc00 */
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &err);
+    error_free_or_abort(&err);
+    visit_type_size(v, "sz2", &sz, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Suffixes */
+    qdict = keyval_parse("sz1=8b,sz2=1.5k,sz3=2M,sz4=0.1G,sz5=16777215T",
+                         NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &error_abort);
+    g_assert_cmpuint(sz, ==, 8);
+    visit_type_size(v, "sz2", &sz, &error_abort);
+    g_assert_cmpuint(sz, ==, 1536);
+    visit_type_size(v, "sz3", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 2 * M_BYTE);
+    visit_type_size(v, "sz4", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, G_BYTE / 10);
+    visit_type_size(v, "sz5", &sz, &error_abort);
+    g_assert_cmphex(sz, ==, 16777215 * T_BYTE);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Beyond limit with suffix */
+    qdict = keyval_parse("sz1=16777216T", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    /* Trailing crap */
+    qdict = keyval_parse("sz1=16E,sz2=16Gi", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_type_size(v, "sz1", &sz, &err);
+    error_free_or_abort(&err);
+    visit_type_size(v, "sz2", &sz, &err);
+    error_free_or_abort(&err);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
+static void test_keyval_visit_dict(void)
+{
+    Error *err = NULL;
+    Visitor *v;
+    QDict *qdict;
+    int64_t i;
+
+    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_start_struct(v, "a", NULL, 0, &error_abort);
+    visit_start_struct(v, "b", NULL, 0, &error_abort);
+    visit_type_int(v, "c", &i, &error_abort);
+    g_assert_cmpint(i, ==, 2);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_type_int(v, "d", &i, &error_abort);
+    g_assert_cmpint(i, ==, 3);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+
+    qdict = keyval_parse("a.b=", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_start_struct(v, "a", NULL, 0, &error_abort);
+    visit_type_int(v, "c", &i, &err);   /* a.c missing */
+    error_free_or_abort(&err);
+    visit_check_struct(v, &err);
+    error_free_or_abort(&err);          /* a.b unexpected */
+    visit_end_struct(v, NULL);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
+static void test_keyval_visit_optional(void)
+{
+    Visitor *v;
+    QDict *qdict;
+    bool present;
+    int64_t i;
+
+    qdict = keyval_parse("a.b=1", NULL, &error_abort);
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    QDECREF(qdict);
+    visit_start_struct(v, NULL, NULL, 0, &error_abort);
+    visit_optional(v, "b", &present);
+    g_assert(!present);         /* b missing */
+    visit_optional(v, "a", &present);
+    g_assert(present);          /* a present */
+    visit_start_struct(v, "a", NULL, 0, &error_abort);
+    visit_optional(v, "b", &present);
+    g_assert(present);          /* a.b present */
+    visit_type_int(v, "b", &i, &error_abort);
+    g_assert_cmpint(i, ==, 1);
+    visit_optional(v, "a", &present);
+    g_assert(!present);         /* a.a missing */
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_check_struct(v, &error_abort);
+    visit_end_struct(v, NULL);
+    visit_free(v);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/keyval/keyval_parse", test_keyval_parse);
+    g_test_add_func("/keyval/visit/bool", test_keyval_visit_bool);
+    g_test_add_func("/keyval/visit/number", test_keyval_visit_number);
+    g_test_add_func("/keyval/visit/size", test_keyval_visit_size);
+    g_test_add_func("/keyval/visit/dict", test_keyval_visit_dict);
+    g_test_add_func("/keyval/visit/optional", test_keyval_visit_optional);
     g_test_run();
     return 0;
 }
-- 
2.7.4
