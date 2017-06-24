Received: from eggs.gnu.org ([2001:4830:134:3::10]:45548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dOpVn-0007zN-Da
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 14:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dOpVm-0006Kh-FJ
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 14:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dOpVm-0006K1-8X
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 14:10:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BBD6C057FAD
	for <qemu-devel@nongnu.org>; Sat, 24 Jun 2017 18:10:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Sat, 24 Jun 2017 12:10:08 -0600
Message-Id: <20170624181008.25497-3-eblake@redhat.com>
In-Reply-To: <20170624181008.25497-1-eblake@redhat.com>
References: <20170624181008.25497-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qobject: Update coccinelle script to
 catch Q{INC, DEC}REF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The recent commit b097efc0 used qobject_decref(QOBJECT(E)), even
though we already have QDECREF(E) for that purpose.  We can update
our coccinelle script to catch any future relapses; with that in
place, the rest of the patch is generated with:
 spatch --sp-file scripts/coccinelle/qobject.cocci \
        --macro-file scripts/cocci-macro-file.h --dir . --in-place

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: fix a misuse that crept in since v1
---
 monitor.c                        | 2 +-
 scripts/coccinelle/qobject.cocci | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 3c369f4..b0fde7f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3829,7 +3829,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)

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
2.9.4
