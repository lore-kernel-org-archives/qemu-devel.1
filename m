Received: from eggs.gnu.org ([2001:4830:134:3::10]:57090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPAj-0008OD-FD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPAi-0006WR-Gd
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPAi-0006Vh-BJ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60F5561E4B
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:25:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:24:47 +0200
Message-Id: <20170518172453.32599-4-quintela@redhat.com>
In-Reply-To: <20170518172453.32599-1-quintela@redhat.com>
References: <20170518172453.32599-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/18] hmp: Use visitor api for
 hmp_migrate_set_parameter()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We only use it for int64 at this point, I am not able to find a way to
parse an int with MiB units.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index 3dceaf8..83e45c8 100644
--- a/hmp.c
+++ b/hmp.c
@@ -29,6 +29,7 @@
 #include "monitor/qdev.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/util.h"
 #include "qapi-visit.h"
@@ -1524,8 +1525,9 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
 {
     const char *param = qdict_get_str(qdict, "parameter");
     const char *valuestr = qdict_get_str(qdict, "value");
+    Visitor *v = string_input_visitor_new(valuestr);
     uint64_t valuebw = 0;
-    long valueint = 0;
+    int64_t valueint = 0;
     Error *err = NULL;
     bool use_int_value = false;
     int i, ret;
@@ -1583,9 +1585,8 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
             }
 
             if (use_int_value) {
-                if (qemu_strtol(valuestr, NULL, 10, &valueint) < 0) {
-                    error_setg(&err, "Unable to parse '%s' as an int",
-                               valuestr);
+                visit_type_int(v, param, &valueint, &err);
+                if (err) {
                     goto cleanup;
                 }
                 /* Set all integers; only one has_FOO will be set, and
@@ -1609,6 +1610,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     }
 
  cleanup:
+    visit_free(v);
     if (err) {
         error_report_err(err);
     }
-- 
2.9.3
