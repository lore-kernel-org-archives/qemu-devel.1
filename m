Received: from eggs.gnu.org ([2001:4830:134:3::10]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfU-00026o-Rh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfO-0006Nf-Cd
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csUfO-0006NH-5k
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 413178E682
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 13:26:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Mar 2017 15:26:28 +0200
Message-Id: <1490621195-2228-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-1-git-send-email-armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 for-2.9 04/11] rbd: Clean up after the
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
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

This code in qemu_rbd_parse_filename()

    found_str = qemu_rbd_next_tok(p, '\0', &p);
    p = found_str;

has no effect.  Drop it, and simplify qemu_rbd_next_tok().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
