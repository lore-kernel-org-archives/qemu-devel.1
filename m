Received: from eggs.gnu.org ([2001:4830:134:3::10]:45016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deqWd-0000yq-5j
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 18:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deqWY-00041n-37
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 18:29:27 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  7 Aug 2017 18:29:09 -0400
Message-Id: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] block/nfs: fix mutex assertion in
 nfs_file_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pl@kamp.de, kwolf@redhat.com

Commit c096358e747e88fc7364e40e3c354ee0bb683960 introduced assertion
checks for when qemu_mutex() functions are called without the
corresponding qemu_mutex_init() having initialized the mutex.

This uncovered a latent bug in qemu's nfs driver - in
nfs_client_close(), the NFSClient structure is overwritten with zeros,
prior to the mutex being destroyed.

Go ahead and destroy the mutex in nfs_client_close(), and change where
we call qemu_mutex_init() so that it is correctly balanced.

There are also a couple of memory leaks obscured by the memset, so this
fixes those as well.

Finally, we should be able to get rid of the memset(), as it isn't
necessary.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/nfs.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index d8db419..bec16b7 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -433,19 +433,23 @@ static void nfs_client_close(NFSClient *client)
     if (client->context) {
         if (client->fh) {
             nfs_close(client->context, client->fh);
+            client->fh = NULL;
         }
         aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
                            false, NULL, NULL, NULL, NULL);
         nfs_destroy_context(client->context);
+        client->context = NULL;
     }
-    memset(client, 0, sizeof(NFSClient));
-}
-
-static void nfs_file_close(BlockDriverState *bs)
-{
-    NFSClient *client = bs->opaque;
-    nfs_client_close(client);
+    g_free(client->path);
     qemu_mutex_destroy(&client->mutex);
+    qapi_free_NFSServer(client->server);
+    client->server = NULL;
+}
+
+static void nfs_file_close(BlockDriverState *bs)
+{
+    NFSClient *client = bs->opaque;
+    nfs_client_close(client);
 }
 
 static NFSServer *nfs_config(QDict *options, Error **errp)
@@ -498,6 +502,7 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
     struct stat st;
     char *file = NULL, *strp = NULL;
 
+    qemu_mutex_init(&client->mutex);
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -660,7 +665,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
     if (ret < 0) {
         return ret;
     }
-    qemu_mutex_init(&client->mutex);
+
     bs->total_sectors = ret;
     ret = 0;
     return ret;
-- 
2.9.4
