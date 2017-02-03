Received: from eggs.gnu.org ([2001:4830:134:3::10]:36723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nv-T1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5j-00081q-45
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:22640 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007zl-Na
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:45 +0300
Message-Id: <20170203154757.36140-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 06/18] nbd/client: refactor drop_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Return 0 on success to simplify success checking.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 351731bc63..1c274f3012 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -86,31 +86,34 @@ static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
 
 */
 
-/* Discard length bytes from channel.  Return -errno on failure, or
- * the amount of bytes consumed. */
-static ssize_t drop_sync(QIOChannel *ioc, size_t size)
+/* Discard length bytes from channel.
+ * Return 0 on success and -errno on fail.
+ */
+static int drop_sync(QIOChannel *ioc, size_t size)
 {
-    ssize_t ret = 0;
+    ssize_t ret;
     char small[1024];
     char *buffer;
 
     buffer = sizeof(small) > size ? small : g_malloc(MIN(65536, size));
     while (size > 0) {
-        ssize_t count = read_sync(ioc, buffer, MIN(65536, size));
-
-        if (count <= 0) {
-            goto cleanup;
+        ret = read_sync(ioc, buffer, MIN(65536, size));
+        if (ret == 0) {
+            ret = -EIO;
+        }
+        if (ret < 0) {
+            break;
         }
-        assert(count <= size);
-        size -= count;
-        ret += count;
+
+        assert(ret <= size);
+        size -= ret;
     }
 
- cleanup:
     if (buffer != small) {
         g_free(buffer);
     }
-    return ret;
+
+    return ret < 0 ? ret : 0;
 }
 
 /* Send an option request.
@@ -334,7 +337,7 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
         return -1;
     }
     if (namelen != strlen(want)) {
-        if (drop_sync(ioc, len) != len) {
+        if (drop_sync(ioc, len) < 0) {
             error_setg(errp, "failed to skip export name with wrong length");
             nbd_send_opt_abort(ioc);
             return -1;
@@ -350,7 +353,7 @@ static int nbd_receive_list(QIOChannel *ioc, const char *want, bool *match,
     }
     name[namelen] = '\0';
     len -= namelen;
-    if (drop_sync(ioc, len) != len) {
+    if (drop_sync(ioc, len) < 0) {
         error_setg(errp, "failed to read export description");
         nbd_send_opt_abort(ioc);
         return -1;
@@ -635,7 +638,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
     }
 
     TRACE("Size is %" PRIu64 ", export flags %" PRIx16, *size, *flags);
-    if (zeroes && drop_sync(ioc, 124) != 124) {
+    if (zeroes && drop_sync(ioc, 124) < 0) {
         error_setg(errp, "Failed to read reserved block");
         goto fail;
     }
-- 
2.11.0
