Received: from eggs.gnu.org ([2001:4830:134:3::10]:38209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSO4-000727-K0
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSNz-00010K-Kp
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drSNz-0000zp-68
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:20:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51747C0C0567
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:20:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:19:51 -0500
Message-Id: <20170911172022.4738-8-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 07/38] libqtest: Inline
 qtest_query_target_endianness()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com

There was only one caller; it's easier to inline things.  (It
trades one forward declaration for two others, but it's not
worth the additional churn of topological sorting, even though
that would be possible.)

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: Drop the topological sorting
---
 tests/libqtest.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 95d4159b38..1710d63276 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -49,7 +49,9 @@ static struct sigaction sigact_old;
     g_assert_cmpint(ret, !=, -1); \
 } while (0)

-static int qtest_query_target_endianness(QTestState *s);
+static void qtest_sendf(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
+static gchar **qtest_rsp(QTestState *s, int expected_args);

 static int init_socket(const char *socket_path)
 {
@@ -158,6 +160,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     gchar *qmp_socket_path;
     gchar *command;
     const char *qemu_binary;
+    gchar **args;

     qemu_binary = getenv("QTEST_QEMU_BINARY");
     if (!qemu_binary) {
@@ -221,8 +224,11 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     }

     /* ask endianness of the target */
-
-    s->big_endian = qtest_query_target_endianness(s);
+    qtest_sendf(s, "endianness\n");
+    args = qtest_rsp(s, 1);
+    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
+    s->big_endian = strcmp(args[1], "big") == 0;
+    g_strfreev(args);

     return s;
 }
@@ -367,20 +373,6 @@ redo:
     return words;
 }

-static int qtest_query_target_endianness(QTestState *s)
-{
-    gchar **args;
-    int big_endian;
-
-    qtest_sendf(s, "endianness\n");
-    args = qtest_rsp(s, 1);
-    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
-    big_endian = strcmp(args[1], "big") == 0;
-    g_strfreev(args);
-
-    return big_endian;
-}
-
 typedef struct {
     JSONMessageParser parser;
     QDict *response;
-- 
2.13.5
