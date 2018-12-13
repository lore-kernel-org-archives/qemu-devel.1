Received: from eggs.gnu.org ([2001:4830:134:3::10]:53114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxj-0005ci-8R
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxe-0001jU-So
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxc-0001JK-Mk
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AE825D5EA
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:12 +0100
Message-Id: <20181213184340.24037-5-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 04/32] qapi: Use qemu_strtod_finite() in
 qobject-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's use the new function. Just as current behavior, we have to
consume the whole string (now it's just way clearer what's going on).

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181121164421.20780-5-david@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 3e88b27f9e..07465f9947 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -562,19 +562,20 @@ static void qobject_input_type_number_keyval(Visitor *v, const char *name,
 {
     QObjectInputVisitor *qiv = to_qiv(v);
     const char *str = qobject_input_get_keyval(qiv, name, errp);
-    char *endp;
+    double val;
 
     if (!str) {
         return;
     }
 
-    errno = 0;
-    *obj = strtod(str, &endp);
-    if (errno || endp == str || *endp || !isfinite(*obj)) {
+    if (qemu_strtod_finite(str, NULL, &val)) {
         /* TODO report -ERANGE more nicely */
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                    full_name(qiv, name), "number");
+        return;
     }
+
+    *obj = val;
 }
 
 static void qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
-- 
2.17.2
