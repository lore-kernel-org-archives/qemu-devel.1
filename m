Received: from eggs.gnu.org ([2001:4830:134:3::10]:34675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOp-0005NG-8C
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOo-0000CA-7n
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:35 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:19 -0600
Message-Id: <20181215135324.152629-18-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/22] nbd/client: Pull out oldstyle size
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Another refactoring creating nbd_negotiate_finish_oldstyle()
for further reuse during 'qemu-nbd --list'.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
v2: new patch [Vladimir]
---
 nbd/client.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 8b0ae20fae8..4bdfba43068 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -811,7 +811,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
  * Start the handshake to the server.  After a positive return, the server
  * is ready to accept additional NBD_OPT requests.
  * Returns: negative errno: failure talking to server
- *          0: server is oldstyle, client must still parse export size
+ *          0: server is oldstyle, must call nbd_negotiate_finish_oldstyle
  *          1: server is newstyle, but can only accept EXPORT_NAME
  *          2: server is newstyle, but lacks structured replies
  *          3: server is newstyle and set up for structured replies
@@ -916,6 +916,36 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     }
 }

+/*
+ * nbd_negotiate_finish_oldstyle:
+ * Populate @info with the size and export flags from an oldstyle server,
+ * but does not consume 124 bytes of reserved zero padding.
+ * Returns 0 on success, -1 with @errp set on failure
+ */
+static int nbd_negotiate_finish_oldstyle(QIOChannel *ioc, NBDExportInfo *info,
+                                         Error **errp)
+{
+    uint32_t oldflags;
+
+    if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
+        error_prepend(errp, "Failed to read export length: ");
+        return -EINVAL;
+    }
+    info->size = be64_to_cpu(info->size);
+
+    if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
+        error_prepend(errp, "Failed to read export flags: ");
+        return -EINVAL;
+    }
+    oldflags = be32_to_cpu(oldflags);
+    if (oldflags & ~0xffff) {
+        error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
+        return -EINVAL;
+    }
+    info->flags = oldflags;
+    return 0;
+}
+
 /*
  * nbd_receive_negotiate:
  * Connect to server, complete negotiation, and move into transmission phase.
@@ -929,7 +959,6 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     int result;
     bool zeroes = true;
     bool base_allocation = info->base_allocation;
-    uint32_t oldflags;

     assert(info->name);
     trace_nbd_receive_negotiate_name(info->name);
@@ -1002,23 +1031,9 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             error_setg(errp, "Server does not support non-empty export names");
             return -EINVAL;
         }
-
-        if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
-            error_prepend(errp, "Failed to read export length: ");
+        if (nbd_negotiate_finish_oldstyle(ioc, info, errp) < 0) {
             return -EINVAL;
         }
-        info->size = be64_to_cpu(info->size);
-
-        if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
-            error_prepend(errp, "Failed to read export flags: ");
-            return -EINVAL;
-        }
-        oldflags = be32_to_cpu(oldflags);
-        if (oldflags & ~0xffff) {
-            error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
-            return -EINVAL;
-        }
-        info->flags = oldflags;
         break;
     default:
         return result;
-- 
2.17.2
