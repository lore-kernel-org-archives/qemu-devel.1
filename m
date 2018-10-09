Received: from eggs.gnu.org ([2001:4830:134:3::10]:59651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xnB-0001b5-Kb
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xn7-0007Hb-MF
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:39 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  9 Oct 2018 21:35:23 +0200
Message-Id: <20181009193524.19052-4-kwolf@redhat.com>
In-Reply-To: <20181009193524.19052-1-kwolf@redhat.com>
References: <20181009193524.19052-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] nbd: Support auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If read-only=off, but auto-read-only=on are given, open a read-write NBD
connection if the server provides a read-write export, but instead of
erroring out for read-only exports, just degrade to read-only.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nbd-client.h |  1 +
 block/nbd-client.c | 14 +++++++++++---
 block/nbd.c        |  4 +++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index cfc90550b9..1d14e78e92 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -46,6 +46,7 @@ int nbd_client_init(BlockDriverState *bs,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
                     const char *x_dirty_bitmap,
+                    bool auto_readonly,
                     Error **errp);
 void nbd_client_close(BlockDriverState *bs);
 
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9686ecbd5e..6a1e634bec 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -971,6 +971,7 @@ int nbd_client_init(BlockDriverState *bs,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
                     const char *x_dirty_bitmap,
+                    bool auto_readonly,
                     Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
@@ -994,9 +995,16 @@ int nbd_client_init(BlockDriverState *bs,
     }
     if (client->info.flags & NBD_FLAG_READ_ONLY &&
         !bdrv_is_read_only(bs)) {
-        error_setg(errp,
-                   "request for write access conflicts with read-only export");
-        return -EACCES;
+        if (auto_readonly) {
+            ret = bdrv_set_read_only(bs, true, errp);
+            if (ret < 0) {
+                return ret;
+            }
+        } else {
+            error_setg(errp, "request for write access conflicts with "
+                             "read-only export");
+            return -EACCES;
+        }
     }
     if (client->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags = BDRV_REQ_FUA;
diff --git a/block/nbd.c b/block/nbd.c
index e87699fb73..8c352a45cd 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -445,7 +445,9 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* NBD handshake */
     ret = nbd_client_init(bs, sioc, s->export, tlscreds, hostname,
-                          qemu_opt_get(opts, "x-dirty-bitmap"), errp);
+                          qemu_opt_get(opts, "x-dirty-bitmap"),
+                          (flags & BDRV_O_AUTO_RDONLY),
+                          errp);
  error:
     if (sioc) {
         object_unref(OBJECT(sioc));
-- 
2.13.6
