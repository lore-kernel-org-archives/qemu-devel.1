Received: from eggs.gnu.org ([2001:4830:134:3::10]:38200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMq-0002pc-GU
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cktMn-0002mh-05
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cktMm-0002lT-R1
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:12:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12F7981226
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 14:12:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v26EBxdc008412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 09:12:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 15:11:44 +0100
Message-Id: <1488809515-4047-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1488809515-4047-1-git-send-email-armbru@redhat.com>
References: <1488809515-4047-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 13/24] block: More detailed syntax error
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
index 5ef5c7c..fe7bddb 100644
--- a/block.c
+++ b/block.c
@@ -1262,9 +1262,14 @@ static QDict *parse_json_filename(const char *filename, Error **errp)
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
