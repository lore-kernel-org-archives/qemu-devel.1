Received: from eggs.gnu.org ([2001:4830:134:3::10]:42625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1au-0004TJ-SV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1as-0006gK-5j
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ar-0006es-Jw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C58B402315B
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:14 +0200
Message-Id: <20180702162218.13678-29-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 28/32] qmp: Switch timestamp_put() to
 qdict_from_jsonf_nofail()
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

There's just one use of qobject_from_jsonf() to parse a JSON object
left: timestamp_put().  Switch it to qdict_from_jsonf_nofail().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qmp-event.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 9d7e88e84a..5b8854043e 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -34,15 +34,15 @@ QMPEventFuncEmit qmp_event_get_func_emit(void)
 static void timestamp_put(QDict *qdict)
 {
     int err;
-    QObject *obj;
+    QDict *ts;
     qemu_timeval tv;
 
     err = qemu_gettimeofday(&tv);
     /* Put -1 to indicate failure of getting host time */
-    obj = qobject_from_jsonf("{ 'seconds': %lld, 'microseconds': %lld }",
-                             err < 0 ? -1LL : (long long)tv.tv_sec,
-                             err < 0 ? -1LL : (long long)tv.tv_usec);
-    qdict_put_obj(qdict, "timestamp", obj);
+    ts = qdict_from_jsonf_nofail("{ 'seconds': %lld, 'microseconds': %lld }",
+                                 err < 0 ? -1LL : (long long)tv.tv_sec,
+                                 err < 0 ? -1LL : (long long)tv.tv_usec);
+    qdict_put(qdict, "timestamp", ts);
 }
 
 /*
-- 
2.17.1
