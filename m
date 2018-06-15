Received: from eggs.gnu.org ([2001:4830:134:3::10]:59163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbY-00066Q-Qs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbX-0003iv-Qb
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:20:59 +0200
Message-Id: <20180615142108.27814-18-kwolf@redhat.com>
In-Reply-To: <20180615142108.27814-1-kwolf@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/26] block-qdict: Simplify qdict_is_list() some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qobject/block-qdict.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 36cf58acc8..e51a3d2c0f 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -317,27 +317,22 @@ static int qdict_is_list(QDict *maybe_list, Error **errp)
 
     for (ent = qdict_first(maybe_list); ent != NULL;
          ent = qdict_next(maybe_list, ent)) {
+        int is_index = !qemu_strtoi64(ent->key, NULL, 10, &val);
 
-        if (qemu_strtoi64(ent->key, NULL, 10, &val) == 0) {
-            if (is_list == -1) {
-                is_list = 1;
-            } else if (!is_list) {
-                error_setg(errp,
-                           "Cannot mix list and non-list keys");
-                return -1;
-            }
+        if (is_list == -1) {
+            is_list = is_index;
+        }
+
+        if (is_index != is_list) {
+            error_setg(errp, "Cannot mix list and non-list keys");
+            return -1;
+        }
+
+        if (is_index) {
             len++;
             if (val > max) {
                 max = val;
             }
-        } else {
-            if (is_list == -1) {
-                is_list = 0;
-            } else if (is_list) {
-                error_setg(errp,
-                           "Cannot mix list and non-list keys");
-                return -1;
-            }
         }
     }
 
-- 
2.13.6
