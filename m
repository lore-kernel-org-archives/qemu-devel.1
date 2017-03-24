Received: from eggs.gnu.org ([2001:4830:134:3::10]:36590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTGb-0006sb-0J
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTGZ-0001he-3a
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crTGY-0001hF-TF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE82BC05AA48
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 17:44:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Mar 2017 18:44:42 +0100
Message-Id: <1490377482-13337-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-1-git-send-email-armbru@redhat.com>
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 9/9] rbd: Reject invalid authentication
 methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/rbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index e962641..19fd820 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -15,6 +15,7 @@
 
 #include <rbd/librbd.h>
 #include "qapi/error.h"
+#include "qapi/util.h"
 #include "qemu/error-report.h"
 #include "block/block_int.h"
 #include "crypto/secret.h"
@@ -506,11 +507,17 @@ static char *qemu_rbd_auth(QDict *options, Error **errp)
         }
 
         vals[i] = qstring_get_str(qobject_to_qstring(val));
+        if (qapi_enum_parse(RbdAuthSupport_lookup, vals[i],
+                            RBD_AUTH_SUPPORT__MAX, -1, errp) < 0) {
+            rados_str = NULL;
+            goto out;
+        }
         qdict_del(options, keybuf);
     }
     vals[i] = NULL;
 
     rados_str = i ? g_strjoinv(";", (char **)vals) : NULL;
+out:
     g_free(vals);
     return rados_str;
 }
-- 
2.7.4
