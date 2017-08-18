Received: from eggs.gnu.org ([2001:4830:134:3::10]:59497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dioca-000723-LT
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocZ-0000vm-L4
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diocZ-0000ta-6s
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D308C04B94A
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 21:15:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 18 Aug 2017 16:15:42 -0500
Message-Id: <20170818211542.5380-14-eblake@redhat.com>
In-Reply-To: <20170818211542.5380-1-eblake@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 13/13] numa-test: Use hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Don't open-code something that has a convenient helper available.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 tests/numa-test.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 3f636840b1..e1b6152244 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -17,21 +17,6 @@ static char *make_cli(const char *generic_cli, const char *test_cli)
     return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
 }

-static char *hmp_info_numa(void)
-{
-    QDict *resp;
-    char *s;
-
-    resp = qmp("{ 'execute': 'human-monitor-command', 'arguments': "
-                      "{ 'command-line': 'info numa '} }");
-    g_assert(resp);
-    g_assert(qdict_haskey(resp, "return"));
-    s = g_strdup(qdict_get_str(resp, "return"));
-    g_assert(s);
-    QDECREF(resp);
-    return s;
-}
-
 static void test_mon_explicit(const void *data)
 {
     char *s;
@@ -42,7 +27,7 @@ static void test_mon_explicit(const void *data)
                    "-numa node,nodeid=1,cpus=4-7 ");
     qtest_start(cli);

-    s = hmp_info_numa();
+    s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
     g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
     g_free(s);
@@ -59,7 +44,7 @@ static void test_mon_default(const void *data)
     cli = make_cli(data, "-smp 8 -numa node -numa node");
     qtest_start(cli);

-    s = hmp_info_numa();
+    s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
     g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
     g_free(s);
@@ -78,7 +63,7 @@ static void test_mon_partial(const void *data)
                    "-numa node,nodeid=1,cpus=4-5 ");
     qtest_start(cli);

-    s = hmp_info_numa();
+    s = hmp("info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
     g_assert(strstr(s, "node 1 cpus: 4 5"));
     g_free(s);
-- 
2.13.5
