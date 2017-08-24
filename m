Received: from eggs.gnu.org ([2001:4830:134:3::10]:37139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmO-0003PJ-HS
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmM-0000Ns-2T
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmL-0000N0-Sh
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:18 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:46:05 +0200
Message-Id: <1503564371-26090-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 10/16] qapi: Use qapi_enum_parse() in
 input_type_enum()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qapi-visit-core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index ed6d2af..ec83ff6 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu-common.h"
 #include "qapi/qmp/qobject.h"
 #include "qapi/qmp/qerror.h"
@@ -353,7 +354,7 @@ static void input_type_enum(Visitor *v, const char *name, int *obj,
                             const char *const strings[], Error **errp)
 {
     Error *local_err = NULL;
-    int64_t value = 0;
+    int64_t value;
     char *enum_str;
 
     visit_type_str(v, name, &enum_str, &local_err);
@@ -362,14 +363,8 @@ static void input_type_enum(Visitor *v, const char *name, int *obj,
         return;
     }
 
-    while (strings[value] != NULL) {
-        if (strcmp(strings[value], enum_str) == 0) {
-            break;
-        }
-        value++;
-    }
-
-    if (strings[value] == NULL) {
+    value = qapi_enum_parse(strings, enum_str, -1, NULL);
+    if (value < 0) {
         error_setg(errp, QERR_INVALID_PARAMETER, enum_str);
         g_free(enum_str);
         return;
-- 
2.7.5
