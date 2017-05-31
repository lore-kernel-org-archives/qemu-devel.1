Received: from eggs.gnu.org ([2001:4830:134:3::10]:57001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG6uV-0007q0-RH
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG6uR-000410-TC
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:51 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:12885 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dG6uR-00040B-Gp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:55:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 31 May 2017 19:55:31 +0300
Message-Id: <20170531165541.47338-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170531165541.47338-1-vsementsov@virtuozzo.com>
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 02/12] nbd: make nbd_drop public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Following commit will reuse it for nbd server too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c       | 26 --------------------------
 nbd/common.c       | 26 ++++++++++++++++++++++++++
 nbd/nbd-internal.h |  2 ++
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 08050c39b3..215857f65d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -86,32 +86,6 @@ static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
 
 */
 
-/* Discard length bytes from channel.  Return -errno on failure and 0 on
- * success*/
-static int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
-{
-    ssize_t ret = 0;
-    char small[1024];
-    char *buffer;
-
-    buffer = sizeof(small) >= size ? small : g_malloc(MIN(65536, size));
-    while (size > 0) {
-        ssize_t count = MIN(65536, size);
-        ret = nbd_read(ioc, buffer, MIN(65536, size), errp);
-
-        if (ret < 0) {
-            goto cleanup;
-        }
-        size -= count;
-    }
-
- cleanup:
-    if (buffer != small) {
-        g_free(buffer);
-    }
-    return ret;
-}
-
 /* Send an option request.
  *
  * The request is for option @opt, with @data containing @len bytes of
diff --git a/nbd/common.c b/nbd/common.c
index d6b719ddaa..6b5c1b7b02 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -65,6 +65,32 @@ ssize_t nbd_rwv(QIOChannel *ioc, struct iovec *iov, size_t niov, size_t length,
     return done;
 }
 
+/* Discard length bytes from channel.  Return -errno on failure and 0 on
+ * success */
+int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
+{
+    ssize_t ret = 0;
+    char small[1024];
+    char *buffer;
+
+    buffer = sizeof(small) >= size ? small : g_malloc(MIN(65536, size));
+    while (size > 0) {
+        ssize_t count = MIN(65536, size);
+        ret = nbd_read(ioc, buffer, MIN(65536, size), errp);
+
+        if (ret < 0) {
+            goto cleanup;
+        }
+        size -= count;
+    }
+
+ cleanup:
+    if (buffer != small) {
+        g_free(buffer);
+    }
+    return ret;
+}
+
 
 void nbd_tls_handshake(QIOTask *task,
                        void *opaque)
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 630f553134..d1c2bed471 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -153,4 +153,6 @@ struct NBDTLSHandshakeData {
 void nbd_tls_handshake(QIOTask *task,
                        void *opaque);
 
+int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
+
 #endif
-- 
2.11.1
