Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOG-0007VA-D6
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOD-0006vS-GV
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOD-0006um-8L
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:17 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CCD5C04B954
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:07 +0100
Message-Id: <1480956313-31322-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] tests: Avoid qobject_from_jsonf("%"PRId64)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The qobject_from_jsonf() function implements a pseudo-printf
language for creating a QObject; however, it is hard-coded to
only parse a subset of formats understood by -Wformat, and is
not a straight synonym to bare printf().  In particular, any
use of an int64_t integer works only if the system's
definition of PRId64 matches what the parser expects; which
works on glibc (%lld or %ld depending on 32- vs. 64-bit) and
mingw (%I64d), but not on Mac OS (%qd).  Rather than enhance
the parser, it is just as easy to force the use of int (where
the value is small enough) or long long instead of int64_t,
which we know always works.

This should cover all remaining testsuite uses of
qobject_from_json[fv]() that were trying to rely on PRId64,
although my proof for that was done by adding in asserts and
checking that 'make check' still passed, where such asserts
are inappropriate during hard freeze.  A later series in 2.9
may remove all dynamic JSON parsing, but that's a bigger task.

Reported by: G 3 <programmingkidx@gmail.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <1479922617-4400-4-git-send-email-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Rename value64 to value_ll]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c                | 6 +++---
 tests/test-qobject-input-visitor.c | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 8595574..0b21a22 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -964,7 +964,7 @@ static void vararg_number(void)
     QInt *qint;
     QFloat *qfloat;
     int value = 0x2342;
-    int64_t value64 = 0x2342342343LL;
+    long long value_ll = 0x2342342343LL;
     double valuef = 2.323423423;
 
     obj = qobject_from_jsonf("%d", value);
@@ -976,12 +976,12 @@ static void vararg_number(void)
 
     QDECREF(qint);
 
-    obj = qobject_from_jsonf("%" PRId64, value64);
+    obj = qobject_from_jsonf("%lld", value_ll);
     g_assert(obj != NULL);
     g_assert(qobject_type(obj) == QTYPE_QINT);
 
     qint = qobject_to_qint(obj);
-    g_assert(qint_get_int(qint) == value64);
+    g_assert(qint_get_int(qint) == value_ll);
 
     QDECREF(qint);
 
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index 26c5012..945404a 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -83,10 +83,11 @@ static Visitor *visitor_input_test_init_raw(TestInputVisitorData *data,
 static void test_visitor_in_int(TestInputVisitorData *data,
                                 const void *unused)
 {
-    int64_t res = 0, value = -42;
+    int64_t res = 0;
+    int value = -42;
     Visitor *v;
 
-    v = visitor_input_test_init(data, "%" PRId64, value);
+    v = visitor_input_test_init(data, "%d", value);
 
     visit_type_int(v, NULL, &res, &error_abort);
     g_assert_cmpint(res, ==, value);
-- 
2.5.5
