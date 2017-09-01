Received: from eggs.gnu.org ([2001:4830:134:3::10]:55791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIV-00078p-4k
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIP-0001Z7-Eo
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIP-0001YT-9y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:03:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EFF3883DE
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:03:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:19 -0500
Message-Id: <20170901180340.30009-9-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 08/29] libqtest: Let socket_send() compute
 length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

Rather than make multiple callers call strlen(), it's easier if
socket_send() itself can compute a length via strlen() if none
was provided (caller passes -1).  Callers that can get at the
length more efficiently are left that way.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3f956f09fc..a6ce21d7f9 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -251,10 +251,13 @@ void qtest_quit(QTestState *s)
     g_free(s);
 }

-static void socket_send(int fd, const char *buf, size_t size)
+static void socket_send(int fd, const char *buf, ssize_t size)
 {
     size_t offset;

+    if (size < 0) {
+        size = strlen(buf);
+    }
     offset = 0;
     while (offset < size) {
         ssize_t len;
@@ -274,9 +277,8 @@ static void socket_send(int fd, const char *buf, size_t size)
 static void socket_sendf(int fd, const char *fmt, va_list ap)
 {
     gchar *str = g_strdup_vprintf(fmt, ap);
-    size_t size = strlen(str);

-    socket_send(fd, str, size);
+    socket_send(fd, str, -1);
     g_free(str);
 }

@@ -858,7 +860,7 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)

     bdata = g_base64_encode(data, size);
     qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
-    socket_send(s->fd, bdata, strlen(bdata));
+    socket_send(s->fd, bdata, -1);
     socket_send(s->fd, "\n", 1);
     qtest_rsp(s, 0);
     g_free(bdata);
-- 
2.13.5
