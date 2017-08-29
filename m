Received: from eggs.gnu.org ([2001:4830:134:3::10]:49170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCz-0001xs-Jp
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCw-0006M9-7q
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58301
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCv-0006La-Va
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8nu099508
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:41 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmr22ykt5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:41 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:40 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:53 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-79-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 78/79] block/nfs: fix mutex assertion in
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
Cc: qemu-stable@nongnu.org, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

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
(cherry picked from commit 113fe792fd4931dd0538f03859278b8719ee4fa2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 344186f..7e1bea1 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -434,19 +434,23 @@ static void nfs_client_close(NFSClient *client)
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
@@ -499,6 +503,7 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
     struct stat st;
     char *file = NULL, *strp = NULL;
 
+    qemu_mutex_init(&client->mutex);
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -661,7 +666,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
     if (ret < 0) {
         return ret;
     }
-    qemu_mutex_init(&client->mutex);
+
     bs->total_sectors = ret;
     ret = 0;
     return ret;
-- 
2.7.4
