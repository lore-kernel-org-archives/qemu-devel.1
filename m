Received: from eggs.gnu.org ([2001:4830:134:3::10]:46556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gP2I6-0004pe-S4
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gP2I6-0002Ek-0T
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:25:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gP2I5-0002AL-QT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:25:53 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 20 Nov 2018 10:25:36 +0100
Message-Id: <20181120092542.13102-4-david@redhat.com>
In-Reply-To: <20181120092542.13102-1-david@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/9] qapi: Fix string-input-visitor to
 reject NaN and infinities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>

The string-input-visitor happily accepts NaN and inifities when parsing
numbers (doubles). They shouldn't. Fix that.

Also, add two test cases, testing if "NaN" and "inf" is properly
rejected.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 qapi/string-input-visitor.c       |  6 ++----
 tests/test-string-input-visitor.c | 13 +++++++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index b3fdd0827d..b89c6c4e06 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -20,6 +20,7 @@
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qemu/range.h"
+#include "qemu/cutils.h"
 
 
 struct StringInputVisitor
@@ -313,12 +314,9 @@ static void parse_type_number(Visitor *v, const char *name, double *obj,
                               Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
-    char *endp = (char *) siv->string;
     double val;
 
-    errno = 0;
-    val = strtod(siv->string, &endp);
-    if (errno || endp == siv->string || *endp) {
+    if (qemu_strtod_finite(siv->string, NULL, &val)) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
                    "number");
         return;
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 88e0e1aa9a..1efba06948 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -252,6 +252,19 @@ static void test_visitor_in_number(TestInputVisitorData *data,
     visit_type_number(v, NULL, &res, &err);
     g_assert(!err);
     g_assert_cmpfloat(res, ==, value);
+
+    /* NaN and infinity has to be rejected */
+
+    v = visitor_input_test_init(data, "NaN");
+
+    visit_type_number(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+
+    v = visitor_input_test_init(data, "inf");
+
+    visit_type_number(v, NULL, &res, &err);
+    error_free_or_abort(&err);
+
 }
 
 static void test_visitor_in_string(TestInputVisitorData *data,
-- 
2.17.2
