Received: from eggs.gnu.org ([2001:4830:134:3::10]:42639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52d-0000ZH-GE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1df52Y-0002Ko-GS
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:59:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  8 Aug 2017 15:58:38 +0200
Message-Id: <20170808135838.11525-19-kwolf@redhat.com>
In-Reply-To: <20170808135838.11525-1-kwolf@redhat.com>
References: <20170808135838.11525-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/18] block/nfs: fix mutex assertion in
 nfs_file_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Jeff Cody <jcody@redhat.com>

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

Cc: qemu-stable@nongnu.org
Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index d8db419957..bec16b72a6 100644
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
+    g_free(client->path);
+    qemu_mutex_destroy(&client->mutex);
+    qapi_free_NFSServer(client->server);
+    client->server = NULL;
 }
 
 static void nfs_file_close(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
     nfs_client_close(client);
-    qemu_mutex_destroy(&client->mutex);
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
2.13.4
