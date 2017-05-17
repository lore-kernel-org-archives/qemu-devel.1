Received: from eggs.gnu.org ([2001:4830:134:3::10]:38476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB11r-0000l1-A9
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB11o-0004q7-94
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB11o-0004pu-34
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11FBE8535D
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 15:38:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 17 May 2017 17:38:08 +0200
Message-Id: <20170517153812.21993-2-quintela@redhat.com>
In-Reply-To: <20170517153812.21993-1-quintela@redhat.com>
References: <20170517153812.21993-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] hmp: Use visitor api for
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, eblake@redhat.com, armbru@redhat.com

We only use it for int64 at this point, I am not able to find a way to
parse an int with MiB units.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index b9dd933..acbbc5c 100644
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
@@ -1523,8 +1524,9 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
@@ -1582,9 +1584,8 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
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
@@ -1608,6 +1609,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     }
 
  cleanup:
+    visit_free(v);
     if (err) {
         error_report_err(err);
     }
-- 
2.9.3
