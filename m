Received: from eggs.gnu.org ([2001:4830:134:3::10]:34529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iY-00027o-LP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iV-0008FG-VY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gA7iV-0007dZ-Mq
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82688127AD
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E30AF77DD8
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 10 Oct 2018 08:11:12 +0200
Message-Id: <20181010061113.6057-5-armbru@redhat.com>
In-Reply-To: <20181010061113.6057-1-armbru@redhat.com>
References: <20181010061113.6057-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] libqtest: Inline g_assert_no_errno()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Macro g_assert_no_errno() intrudes into GLib's namespace.  It's also
pretty pointless.  Inline.

At one call site, its redundancy is now obvious.  Delete it there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180926122933.3858-1-armbru@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2cd5736642..44ce118cfc 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -48,10 +48,6 @@ struct QTestState
 static GHookList abrt_hooks;
 static struct sigaction sigact_old;
 
-#define g_assert_no_errno(ret) do { \
-    g_assert_cmpint(ret, !=, -1); \
-} while (0)
-
 static int qtest_query_target_endianness(QTestState *s);
 
 static int init_socket(const char *socket_path)
@@ -61,7 +57,7 @@ static int init_socket(const char *socket_path)
     int ret;
 
     sock = socket(PF_UNIX, SOCK_STREAM, 0);
-    g_assert_no_errno(sock);
+    g_assert_cmpint(sock, !=, -1);
 
     addr.sun_family = AF_UNIX;
     snprintf(addr.sun_path, sizeof(addr.sun_path), "%s", socket_path);
@@ -70,9 +66,9 @@ static int init_socket(const char *socket_path)
     do {
         ret = bind(sock, (struct sockaddr *)&addr, sizeof(addr));
     } while (ret == -1 && errno == EINTR);
-    g_assert_no_errno(ret);
+    g_assert_cmpint(ret, !=, -1);
     ret = listen(sock, 1);
-    g_assert_no_errno(ret);
+    g_assert_cmpint(ret, !=, -1);
 
     return sock;
 }
@@ -325,7 +321,6 @@ static void socket_send(int fd, const char *buf, size_t size)
             continue;
         }
 
-        g_assert_no_errno(len);
         g_assert_cmpint(len, >, 0);
 
         offset += len;
-- 
2.17.1
