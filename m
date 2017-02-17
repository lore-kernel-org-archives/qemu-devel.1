Received: from eggs.gnu.org ([2001:4830:134:3::10]:58975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIU-0002YU-Od
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIS-0004OX-5E
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIR-0004OC-Vc
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:28 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E97F81241
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcQ68007984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:13 +0100
Message-Id: <1487363905-9480-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 02/14] check-qdict: Simplify
 qdict_crumple_test_recursive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Use qdict_get_qdict(), qdict_get_qlist() instead of qdict_get()
followed by qobject_to_qdict(), qobject_to_qlist().

While there, drop some redundant code.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qdict.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 07b1c79..14e942a 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -591,7 +591,7 @@ static void qdict_join_test(void)
 static void qdict_crumple_test_recursive(void)
 {
     QDict *src, *dst, *rule, *vnc, *acl, *listen;
-    QObject *child, *res;
+    QObject *res;
     QList *rules;
 
     src = qdict_new();
@@ -613,23 +613,19 @@ static void qdict_crumple_test_recursive(void)
 
     g_assert_cmpint(qdict_size(dst), ==, 1);
 
-    child = qdict_get(dst, "vnc");
-    g_assert_cmpint(qobject_type(child), ==, QTYPE_QDICT);
-    vnc = qobject_to_qdict(child);
+    vnc = qdict_get_qdict(dst, "vnc");
+    g_assert(vnc);
 
-    child = qdict_get(vnc, "listen");
-    g_assert_cmpint(qobject_type(child), ==, QTYPE_QDICT);
-    listen = qobject_to_qdict(child);
+    listen = qdict_get_qdict(vnc, "listen");
+    g_assert(listen);
     g_assert_cmpstr("127.0.0.1", ==, qdict_get_str(listen, "addr"));
     g_assert_cmpstr("5901", ==, qdict_get_str(listen, "port"));
 
-    child = qdict_get(vnc, "acl");
-    g_assert_cmpint(qobject_type(child), ==, QTYPE_QDICT);
-    acl = qobject_to_qdict(child);
+    acl = qdict_get_qdict(vnc, "acl");
+    g_assert(acl);
 
-    child = qdict_get(acl, "rules");
-    g_assert_cmpint(qobject_type(child), ==, QTYPE_QLIST);
-    rules = qobject_to_qlist(child);
+    rules = qdict_get_qlist(acl, "rules");
+    g_assert(rules);
     g_assert_cmpint(qlist_size(rules), ==, 2);
 
     rule = qobject_to_qdict(qlist_pop(rules));
@@ -646,9 +642,6 @@ static void qdict_crumple_test_recursive(void)
 
     /* With recursive crumpling, we should see all names unescaped */
     g_assert_cmpstr("acl0", ==, qdict_get_str(vnc, "acl.name"));
-    child = qdict_get(vnc, "acl");
-    g_assert_cmpint(qobject_type(child), ==, QTYPE_QDICT);
-    acl = qdict_get_qdict(vnc, "acl");
     g_assert_cmpstr("acl0", ==, qdict_get_str(acl, "rule.name"));
 
     QDECREF(src);
-- 
2.7.4
