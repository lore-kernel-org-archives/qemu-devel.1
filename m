Received: from eggs.gnu.org ([2001:4830:134:3::10]:40989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPF-0008SR-JF
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPD-0007dJ-Nh
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:41 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPD-0007d6-Gk
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:39 -0400
Received: by mail-wr0-x241.google.com with SMTP id y25so547367wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:45 +0200
Message-Id: <1497523981-38449-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/41] nbd: make nbd_drop public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Following commit will reuse it for nbd server too.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170602150150.258222-3-vsementsov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 nbd/client.c       | 26 --------------------------
 nbd/common.c       | 26 ++++++++++++++++++++++++++
 nbd/nbd-internal.h |  2 ++
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 17ac85f..b97143f 100644
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
index d6b719d..6b5c1b7 100644
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
index 753cb9d..39bfed1 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -153,4 +153,6 @@ struct NBDTLSHandshakeData {
 void nbd_tls_handshake(QIOTask *task,
                        void *opaque);
 
+int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
+
 #endif
-- 
1.8.3.1
