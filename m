Received: from eggs.gnu.org ([2001:4830:134:3::10]:46466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fezWL-00065p-Ga
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fezWI-0005o5-Ae
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:10:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fezWI-0005nr-5T
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAC287A7E8
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 09:10:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 11:10:12 +0200
Message-Id: <20180716091012.29510-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] monitor: Fix tracepoint crash on JSON syntax
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, eblake@redhat.com, peterx@redhat.com

When tracepoint handle_qmp_command is enabled, we crash on JSON syntax
errors.  Broken in commit 1cc37471525.  Fix by skipping the tracepoint
on JSON syntax error.  Before the flawed commit, we skipped it by
returning early.

Fixes: CID 1394216
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 7af1f18d13..be29634a00 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4224,7 +4224,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         qdict_del(qdict, "id");
     } /* else will fail qmp_dispatch() */
 
-    if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
+    if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
         QString *req_json = qobject_to_json(req);
         trace_handle_qmp_command(mon, qstring_get_str(req_json));
         qobject_unref(req_json);
-- 
2.17.1
