Received: from eggs.gnu.org ([2001:4830:134:3::10]:52741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGo-0005bk-AX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGj-0004Le-Ow
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNIGj-0004L5-K2
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:17 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 15 Nov 2018 15:04:55 +0100
Message-Id: <20181115140501.7872-4-david@redhat.com>
In-Reply-To: <20181115140501.7872-1-david@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/9] qapi: use qemu_strtod_finite() in
 string-input-visitor
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

Let's use the new function. "NaN" and "inf" are now properly rejected.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 qapi/string-input-visitor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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
-- 
2.17.2
