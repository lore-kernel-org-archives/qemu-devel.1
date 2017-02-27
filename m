Received: from eggs.gnu.org ([2001:4830:134:3::10]:44578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMV-00065O-2C
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciJMS-0000za-3z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:21:03 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Feb 2017 12:20:39 +0100
Message-Id: <1488194450-28056-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-1-git-send-email-armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 13/24] block: More detailed syntax error
 reporting for JSON filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index aa6790c..de7d530 100644
--- a/block.c
+++ b/block.c
@@ -1163,9 +1163,14 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
     ret = strstart(filename, "json:", &filename);
     assert(ret);
 
-    options_obj = qobject_from_json(filename, NULL);
+    options_obj = qobject_from_json(filename, errp);
     if (!options_obj) {
-        error_setg(errp, "Could not parse the JSON options");
+        /* Work around qobject_from_json() lossage TODO fix that */
+        if (errp && !*errp) {
+            error_setg(errp, "Could not parse the JSON options");
+            return NULL;
+        }
+        error_prepend(errp, "Could not parse the JSON options: ");
         return NULL;
     }
 
-- 
2.7.4
