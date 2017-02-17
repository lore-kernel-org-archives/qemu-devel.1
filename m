Received: from eggs.gnu.org ([2001:4830:134:3::10]:58991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIU-0002Yg-SU
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIT-0004QI-OL
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIT-0004PV-Hf
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:29 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8F4861D2C
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcSTL008001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:29 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:24 +0100
Message-Id: <1487363905-9480-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 13/14] monitor: Clean up handle_hmp_command() a
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
