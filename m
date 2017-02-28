Received: from eggs.gnu.org ([2001:4830:134:3::10]:33662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDv-00057z-I5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciqDs-0000YW-F9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciqDs-0000Xh-9J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:26:20 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CA988047E
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 22:26:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1SMQJsQ029012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:26:20 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 23:26:04 +0100
Message-Id: <1488320775-9849-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1488320775-9849-1-git-send-email-armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 13/24] block: More detailed syntax error
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <1488317230-26248-14-git-send-email-armbru@redhat.com>
---
 block.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index af1014f..ca15e93 100644
--- a/block.c
+++ b/block.c
@@ -1200,9 +1200,14 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
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
