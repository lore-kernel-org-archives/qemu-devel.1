Received: from eggs.gnu.org ([2001:4830:134:3::10]:55404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3XJQ-0005Lb-Ik
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 21:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3XJP-0001lL-Lc
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 21:01:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 20:01:31 -0500
Message-Id: <20171015010131.12172-9-eblake@redhat.com>
In-Reply-To: <20171015010131.12172-1-eblake@redhat.com>
References: <20171015010131.12172-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 8/8] nbd: Move nbd_read() to common header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

An upcoming change to block/nbd-client.c will want to read the
tail of a structured reply chunk directly from the wire.  Move
this function to make it easier.

Based on a patch from Vladimir Sementsov-Ogievskiy.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h | 10 ++++++++++
 nbd/nbd-internal.h  |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 2ee1578420..da6e305dd5 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -264,6 +264,16 @@ void nbd_client_put(NBDClient *client);
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       Error **errp);

+
+/* nbd_read
+ * Reads @size bytes from @ioc. Returns 0 on success.
+ */
+static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
+                           Error **errp)
+{
+    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
+}
+
 static inline bool nbd_reply_is_simple(NBDReply *reply)
 {
     return reply->magic == NBD_SIMPLE_REPLY_MAGIC;
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 4f24d6e57d..b64eb1cc9b 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -82,15 +82,6 @@ static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
     return ret;
 }

-/* nbd_read
- * Reads @size bytes from @ioc. Returns 0 on success.
- */
-static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
-                           Error **errp)
-{
-    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
-}
-
 /* nbd_write
  * Writes @size bytes to @ioc. Returns 0 on success.
  */
-- 
2.13.6
