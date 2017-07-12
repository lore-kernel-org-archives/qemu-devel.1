Received: from eggs.gnu.org ([2001:4830:134:3::10]:36539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKCq-0001R6-UI
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKCp-0003Be-So
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVKCp-0003AZ-M4
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96D208046E
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 16:09:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Jul 2017 18:09:35 +0200
Message-Id: <1499875776-12688-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1499875776-12688-1-git-send-email-armbru@redhat.com>
References: <1499875776-12688-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] qobject: Update coccinelle script to catch
 Q{INC, DEC}REF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The recent commit b097efc0 used qobject_decref(QOBJECT(E)), even
though we already have QDECREF(E) for that purpose.  We can update
our coccinelle script to catch any future relapses; with that in
place, the rest of the patch is generated with:
 spatch --sp-file scripts/coccinelle/qobject.cocci \
        --macro-file scripts/cocci-macro-file.h --dir . --in-place

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170624181008.25497-3-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c                        | 2 +-
 scripts/coccinelle/qobject.cocci | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index d8ac20f..61b7982 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3842,7 +3842,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 
     req_json = qobject_to_json(req);
     trace_handle_qmp_command(mon, qstring_get_str(req_json));
-    qobject_decref(QOBJECT(req_json));
+    QDECREF(req_json);
 
     rsp = qmp_dispatch(cur_mon->qmp.commands, req);
 
diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobject.cocci
index c3253de..c518caf 100644
--- a/scripts/coccinelle/qobject.cocci
+++ b/scripts/coccinelle/qobject.cocci
@@ -3,6 +3,12 @@
 expression Obj, Key, E;
 @@
 (
+- qobject_incref(QOBJECT(E));
++ QINCREF(E);
+|
+- qobject_decref(QOBJECT(E));
++ QDECREF(E);
+|
 - qdict_put_obj(Obj, Key, QOBJECT(E));
 + qdict_put(Obj, Key, E);
 |
-- 
2.7.5
