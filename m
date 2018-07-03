Received: from eggs.gnu.org ([2001:4830:134:3::10]:50312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxu-00083t-E7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxr-00069T-Jz
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxr-00068d-DR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDC895BCDD
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C63301C5BE
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:38 +0200
Message-Id: <20180703213556.20619-15-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 14/32] qmp: Always free QMPRequest with
 qmp_request_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

monitor_qmp_dispatch_one() frees a QMPRequest manually, because it
needs to keep a reference to ->id.  Premature optimization.  Take an
additional reference so we can use qmp_request_free().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-15-armbru@redhat.com>
---
 monitor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 3cc4b07788..875647f992 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4182,8 +4182,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
     id = req_obj->id;
     need_resume = req_obj->need_resume;
 
-    g_free(req_obj);
-
     old_mon = cur_mon;
     cur_mon = mon;
 
@@ -4192,14 +4190,14 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
     cur_mon = old_mon;
 
     /* Respond if necessary */
-    monitor_qmp_respond(mon, rsp, NULL, id);
+    monitor_qmp_respond(mon, rsp, NULL, qobject_ref(id));
 
     /* This pairs with the monitor_suspend() in handle_qmp_command(). */
     if (need_resume) {
         monitor_resume(mon);
     }
 
-    qobject_unref(req);
+    qmp_request_free(req_obj);
 }
 
 /*
-- 
2.17.1
