Received: from eggs.gnu.org ([2001:4830:134:3::10]:46439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1Vw-0002AR-BQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1Vv-0007Ne-AL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:12:48 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 25 Jul 2017 17:12:31 +0200
Message-Id: <20170725151233.26077-2-mreitz@redhat.com>
In-Reply-To: <20170725151233.26077-1-mreitz@redhat.com>
References: <20170725151233.26077-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] qcow: fix memory leaks related to encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Fix leak of the 'encryptopts' string, which was mistakenly
declared const.

Fix leak of QemuOpts entry which should not have been deleted
from the opts array.

Reported by: coverity
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170714103105.5781-1-berrange@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow.c  | 5 +++--
 block/qcow2.c | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 66827d6..c08cdc4 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -768,7 +768,7 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     Error *local_err = NULL;
     int ret;
     BlockBackend *qcow_blk;
-    const char *encryptfmt = NULL;
+    char *encryptfmt = NULL;
     QDict *options;
     QDict *encryptopts = NULL;
     QCryptoBlockCreateOptions *crypto_opts = NULL;
@@ -793,7 +793,7 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
             goto cleanup;
         }
     } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
-        encryptfmt = "aes";
+        encryptfmt = g_strdup("aes");
     }
 
     ret = bdrv_create_file(filename, opts, &local_err);
@@ -908,6 +908,7 @@ exit:
     blk_unref(qcow_blk);
 cleanup:
     QDECREF(encryptopts);
+    g_free(encryptfmt);
     qcrypto_block_free(crypto);
     qapi_free_QCryptoBlockCreateOptions(crypto_opts);
     g_free(backing_file);
diff --git a/block/qcow2.c b/block/qcow2.c
index 90efa44..d7c600b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2905,7 +2905,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     int version;
     uint64_t refcount_bits;
     int refcount_order;
-    const char *encryptfmt = NULL;
+    char *encryptfmt = NULL;
     Error *local_err = NULL;
     int ret;
 
@@ -2916,14 +2916,14 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
     encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
     if (encryptfmt) {
-        if (qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT)) {
+        if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {
             error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
                        BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusive");
             ret = -EINVAL;
             goto finish;
         }
     } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
-        encryptfmt = "aes";
+        encryptfmt = g_strdup("aes");
     }
     cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
     if (local_err) {
@@ -2983,6 +2983,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 finish:
     g_free(backing_file);
     g_free(backing_fmt);
+    g_free(encryptfmt);
     g_free(buf);
     return ret;
 }
-- 
2.9.4
