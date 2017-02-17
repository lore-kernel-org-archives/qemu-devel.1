Received: from eggs.gnu.org ([2001:4830:134:3::10]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIU-0002Ya-QA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIT-0004Pu-Jv
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIT-0004PF-Eu
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:29 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9612661BA6
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcSPL001082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:29 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:17 +0100
Message-Id: <1487363905-9480-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 06/14] test-qmp-event: Simplify and tighten
 event_test_emit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use qdict_get_qdict() and qdict_get_try_int() to simplify.

While there, add a sanity check for seconds.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-event.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 633dc87..7bb621b 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -95,24 +95,18 @@ static bool qdict_cmp_simple(QDict *a, QDict *b)
    correctness. */
 static void event_test_emit(test_QAPIEvent event, QDict *d, Error **errp)
 {
-    QObject *obj;
     QDict *t;
     int64_t s, ms;
 
     /* Verify that we have timestamp, then remove it to compare other fields */
-    obj = qdict_get(d, "timestamp");
-    g_assert(obj);
-    t = qobject_to_qdict(obj);
+    t = qdict_get_qdict(d, "timestamp");
     g_assert(t);
-    obj = qdict_get(t, "seconds");
-    g_assert(obj && qobject_type(obj) == QTYPE_QINT);
-    s = qint_get_int(qobject_to_qint(obj));
-    obj = qdict_get(t, "microseconds");
-    g_assert(obj && qobject_type(obj) == QTYPE_QINT);
-    ms = qint_get_int(qobject_to_qint(obj));
+    s = qdict_get_try_int(t, "seconds", -2);
+    ms = qdict_get_try_int(t, "microseconds", -2);
     if (s == -1) {
         g_assert(ms == -1);
     } else {
+        g_assert(s >= 0);
         g_assert(ms >= 0 && ms <= 999999);
     }
     g_assert(qdict_size(t) == 2);
-- 
2.7.4
