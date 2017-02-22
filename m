Received: from eggs.gnu.org ([2001:4830:134:3::10]:40671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgcNW-0004du-7r
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgcNU-0000g1-Aw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgcNU-0000fY-4k
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:04 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61A997FB76
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 19:15:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 27F60B122B
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 19:15:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Feb 2017 20:14:57 +0100
Message-Id: <1487790898-24921-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1487790898-24921-1-git-send-email-armbru@redhat.com>
References: <1487790898-24921-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 15/16] monitor: Clean up handle_hmp_command() a
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Leave checking qobject_type(req) to qmp_check_input_obj().  Rework
handling of json_parser_parse_err() failing without setting an error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1487363905-9480-14-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 493bed9..1e352a6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3735,10 +3735,11 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     Error *err = NULL;
 
     req = json_parser_parse_err(tokens, NULL, &err);
-    if (err || !req || qobject_type(req) != QTYPE_QDICT) {
-        if (!err) {
-            error_setg(&err, QERR_JSON_PARSING);
-        }
+    if (!req && !err) {
+        /* json_parser_parse_err() sucks: can fail without setting @err */
+        error_setg(&err, QERR_JSON_PARSING);
+    }
+    if (err) {
         goto err_out;
     }
 
-- 
2.7.4
