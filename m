Received: from eggs.gnu.org ([2001:4830:134:3::10]:46114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsZ-0004Gi-95
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsT-0004ng-FX
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:07 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 20:00:45 +0100
Message-Id: <1488826849-32384-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-1-git-send-email-armbru@redhat.com>
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/15] gluster: Don't duplicate
 qapi-util.c's qapi_enum_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Niels de Vos <ndevos@redhat.com>
---
 block/gluster.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 7236d59..6fbcf9e 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -12,6 +12,7 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/util.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
@@ -472,23 +473,6 @@ out:
     return NULL;
 }
 
-static int qapi_enum_parse(const char *opt)
-{
-    int i;
-
-    if (!opt) {
-        return GLUSTER_TRANSPORT__MAX;
-    }
-
-    for (i = 0; i < GLUSTER_TRANSPORT__MAX; i++) {
-        if (!strcmp(opt, GlusterTransport_lookup[i])) {
-            return i;
-        }
-    }
-
-    return i;
-}
-
 /*
  * Convert the json formatted command line into qapi.
 */
@@ -546,16 +530,20 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
         ptr = qemu_opt_get(opts, GLUSTER_OPT_TYPE);
         gsconf = g_new0(GlusterServer, 1);
-        gsconf->type = qapi_enum_parse(ptr);
+        gsconf->type = qapi_enum_parse(GlusterTransport_lookup, ptr,
+                                       GLUSTER_TRANSPORT__MAX,
+                                       GLUSTER_TRANSPORT__MAX,
+                                       &local_err);
         if (!ptr) {
             error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_TYPE);
             error_append_hint(&local_err, GERR_INDEX_HINT, i);
             goto out;
 
         }
-        if (gsconf->type == GLUSTER_TRANSPORT__MAX) {
-            error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE,
-                       GLUSTER_OPT_TYPE, "tcp or unix");
+        if (local_err) {
+            error_append_hint(&local_err,
+                              "Parameter '%s' may be 'tcp' or 'unix'\n",
+                              GLUSTER_OPT_TYPE);
             error_append_hint(&local_err, GERR_INDEX_HINT, i);
             goto out;
         }
-- 
2.7.4
