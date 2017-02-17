Received: from eggs.gnu.org ([2001:4830:134:3::10]:58976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIU-0002YW-PI
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIS-0004OY-4n
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIR-0004OE-VV
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 121027FB77
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcQHe018312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:14 +0100
Message-Id: <1487363905-9480-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/14] check-qdict: Tighten
 qdict_crumple_test_recursive() some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Consistently check for unexpected QDict entries, and qdict_get_qdict()
success.  The latter doesn't tighten the test, it only makes it fail
more nicely.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qdict.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 14e942a..ded3a26 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -615,26 +615,31 @@ static void qdict_crumple_test_recursive(void)
 
     vnc = qdict_get_qdict(dst, "vnc");
     g_assert(vnc);
+    g_assert_cmpint(qdict_size(vnc), ==, 3);
 
     listen = qdict_get_qdict(vnc, "listen");
     g_assert(listen);
+    g_assert_cmpint(qdict_size(listen), ==, 2);
     g_assert_cmpstr("127.0.0.1", ==, qdict_get_str(listen, "addr"));
     g_assert_cmpstr("5901", ==, qdict_get_str(listen, "port"));
 
     acl = qdict_get_qdict(vnc, "acl");
     g_assert(acl);
+    g_assert_cmpint(qdict_size(acl), ==, 3);
 
     rules = qdict_get_qlist(acl, "rules");
     g_assert(rules);
     g_assert_cmpint(qlist_size(rules), ==, 2);
 
     rule = qobject_to_qdict(qlist_pop(rules));
+    g_assert(rule);
     g_assert_cmpint(qdict_size(rule), ==, 2);
     g_assert_cmpstr("fred", ==, qdict_get_str(rule, "match"));
     g_assert_cmpstr("allow", ==, qdict_get_str(rule, "policy"));
     QDECREF(rule);
 
     rule = qobject_to_qdict(qlist_pop(rules));
+    g_assert(rule);
     g_assert_cmpint(qdict_size(rule), ==, 2);
     g_assert_cmpstr("bob", ==, qdict_get_str(rule, "match"));
     g_assert_cmpstr("deny", ==, qdict_get_str(rule, "policy"));
-- 
2.7.4
