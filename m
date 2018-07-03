Received: from eggs.gnu.org ([2001:4830:134:3::10]:34458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNN1-0002Oe-2k
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMy-0005Mh-Gc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNMy-0005L9-68
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B11A740776E4
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CCCE215688A
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 17:37:21 +0200
Message-Id: <20180703153728.2175-26-armbru@redhat.com>
In-Reply-To: <20180703153728.2175-1-armbru@redhat.com>
References: <20180703153728.2175-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 25/32] qmp: Replace get_qmp_greeting() by
 qmp_greeting()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

get_qmp_greeting() returns a QDict * as QObject *.  It's caller
converts it right back.

Return QDict * instead.  While there, rename to qmp_greeting().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-26-armbru@redhat.com>
---
 monitor.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 50dc57c82e..e5e9f496c2 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4382,7 +4382,7 @@ void monitor_resume(Monitor *mon)
     trace_monitor_suspend(mon, -1);
 }
 
-static QObject *get_qmp_greeting(Monitor *mon)
+static QDict *qmp_greeting(Monitor *mon)
 {
     QList *cap_list = qlist_new();
     QObject *ver = NULL;
@@ -4398,8 +4398,9 @@ static QObject *get_qmp_greeting(Monitor *mon)
         qlist_append_str(cap_list, QMPCapability_str(cap));
     }
 
-    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': %p}}",
-                              ver, cap_list);
+    return qdict_from_jsonf_nofail(
+        "{'QMP': {'version': %p, 'capabilities': %p}}",
+        ver, cap_list);
 }
 
 static void monitor_qmp_caps_reset(Monitor *mon)
@@ -4409,15 +4410,15 @@ static void monitor_qmp_caps_reset(Monitor *mon)
 
 static void monitor_qmp_event(void *opaque, int event)
 {
-    QObject *data;
+    QDict *data;
     Monitor *mon = opaque;
 
     switch (event) {
     case CHR_EVENT_OPENED:
         mon->qmp.commands = &qmp_cap_negotiation_commands;
         monitor_qmp_caps_reset(mon);
-        data = get_qmp_greeting(mon);
-        qmp_queue_response(mon, qobject_to(QDict, data));
+        data = qmp_greeting(mon);
+        qmp_queue_response(mon, data);
         qobject_unref(data);
         mon_refcount++;
         break;
-- 
2.17.1
