Received: from eggs.gnu.org ([2001:4830:134:3::10]:42466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ar-0004R2-CN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ap-0006cL-Ug
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ap-0006bx-Pr
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F7EE407048A
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:00 +0200
Message-Id: <20180702162218.13678-15-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 14/32] qmp: Always free QMPRequest with
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
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

monitor_qmp_dispatch_one() frees a QMPRequest manually, because it
needs to keep a reference to ->id.  Premature optimization.  Take an
additional reference so we can use qmp_request_free().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 10991757f6..94f5660c3c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4181,8 +4181,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
     id = req_obj->id;
     need_resume = req_obj->need_resume;
 
-    g_free(req_obj);
-
     old_mon = cur_mon;
     cur_mon = mon;
 
@@ -4191,14 +4189,14 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
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
