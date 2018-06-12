Received: from eggs.gnu.org ([2001:4830:134:3::10]:50232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisZ-0007GV-H4
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisX-0003Bh-Sl
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:31 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 12 Jun 2018 14:58:16 +0200
Message-Id: <20180612125821.4229-14-armbru@redhat.com>
In-Reply-To: <20180612125821.4229-1-armbru@redhat.com>
References: <20180612125821.4229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 13/18] block-qdict: Simplify qdict_is_list()
 some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/block-qdict.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 35e9052816..f24bea30e1 100644
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
2.17.1
