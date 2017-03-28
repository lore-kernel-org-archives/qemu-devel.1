Received: from eggs.gnu.org ([2001:4830:134:3::10]:39874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvK-0000CX-6Z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvI-0008MW-Ir
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:18 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 10:56:02 +0200
Message-Id: <1490691368-32099-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490691368-32099-1-git-send-email-armbru@redhat.com>
References: <1490691368-32099-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.9 04/10] rbd: Clean up after the
 previous commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

This code in qemu_rbd_parse_filename()

    found_str = qemu_rbd_next_tok(p, '\0', &p);
    p = found_str;

has no effect.  Drop it, and simplify qemu_rbd_next_tok().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 0fea348..182a5a3 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -104,19 +104,17 @@ static char *qemu_rbd_next_tok(char *src, char delim, char **p)
 
     *p = NULL;
 
-    if (delim != '\0') {
-        for (end = src; *end; ++end) {
-            if (*end == delim) {
-                break;
-            }
-            if (*end == '\\' && end[1] != '\0') {
-                end++;
-            }
-        }
+    for (end = src; *end; ++end) {
         if (*end == delim) {
-            *p = end + 1;
-            *end = '\0';
+            break;
         }
+        if (*end == '\\' && end[1] != '\0') {
+            end++;
+        }
+    }
+    if (*end == delim) {
+        *p = end + 1;
+        *end = '\0';
     }
     return src;
 }
@@ -177,10 +175,6 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
         goto done;
     }
 
-    found_str = qemu_rbd_next_tok(p, '\0', &p);
-
-    p = found_str;
-
     /* The following are essentially all key/value pairs, and we treat
      * 'id' and 'conf' a bit special.  Key/value pairs may be in any order. */
     while (p) {
-- 
2.7.4
