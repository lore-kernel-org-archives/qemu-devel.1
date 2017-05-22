Received: from eggs.gnu.org ([2001:4830:134:3::10]:44685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqPV-0000wr-QJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dCqPS-0001KB-Nk
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dCqPS-0001Jv-Hb
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FFEB80C31
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:42:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 22 May 2017 18:42:12 +0200
Message-Id: <1495471335-23707-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1495471335-23707-1-git-send-email-armbru@redhat.com>
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] qobject-input-visitor: Reject non-finite
 numbers with keyval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mlureau@redhat.com

The QObject input visitor can produce only finite numbers when its
input comes out of the JSON parser, because the the JSON parser
implements RFC 7159, which provides no syntax for infinity and NaN.

However, it can produce infinity and NaN when its input comes out of
keyval_parse(), because we parse with strtod() then.

The keyval variant should not be able to express things the JSON
variant can't.  Rejecting non-finite numbers there is the conservative
fix.  It's also minimally invasive.

We could instead extend our JSON dialect to provide for infinity and
NaN.  Not today.

Note that the JSON formatter can emit non-finite numbers (marked FIXME
in commit 6e8e5cb).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qobject-input-visitor.c       | 3 ++-
 tests/test-qobject-input-visitor.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index d0f0002..eac40f6 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <math.h>
 #include "qapi/error.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor-impl.h"
@@ -568,7 +569,7 @@ static void qobject_input_type_number_keyval(Visitor *v, const char *name,
 
     errno = 0;
     *obj = strtod(str, &endp);
-    if (errno || endp == str || *endp) {
+    if (errno || endp == str || *endp || !isfinite(*obj)) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "number");
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index f965743..e2aabbe 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -278,11 +278,17 @@ static void test_visitor_in_number_str_keyval(TestInputVisitorData *data,
 {
     double res = 0, value = 3.14;
     Visitor *v;
+    Error *err = NULL;
 
     v = visitor_input_test_init_full(data, true, "\"3.14\"");
 
     visit_type_number(v, NULL, &res, &error_abort);
     g_assert_cmpfloat(res, ==, value);
+
+    v = visitor_input_test_init_full(data, true, "\"inf\"");
+
+    visit_type_number(v, NULL, &res, &err);
+    error_free_or_abort(&err);
 }
 
 static void test_visitor_in_number_str_fail(TestInputVisitorData *data,
-- 
2.7.4
