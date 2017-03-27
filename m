Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfW-00026x-WB
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfQ-0006Pk-LU
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csUfQ-0006OW-9y
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C6D8C0641EA
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 13:26:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Mar 2017 15:26:34 +0200
Message-Id: <1490621195-2228-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-1-git-send-email-armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 for-2.9 10/11] Revert "rbd: add support
 for getting password from QCryptoSecret object"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, "Daniel P . Berrange" <berrange@redhat.com>

This reverts commit 60390a2192e7b38aee18db6ce7fb740498709737.

The commit's rationale

    Currently RBD passwords must be provided on the command line
    via

      $QEMU -drive file=rbd:pool/image:id=myname:\
                   key=QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=:\
                   auth_supported=cephx

    This is insecure because the key is visible in the OS process
    listing.

is invalid.  You can easily avoid passing keys on the command line by
using "keyfile" instead of "key".  In fact, the Ceph documentation
calls use of key "not recommended".  But the most common way to
provide keys is a keyring.  The default keyrings should be just fine
for most users.  When they aren't, you can configure your own keyrings
with "keyring" or override the key with "keyfile".

The commit adds parameter password-secret to -drive.  Support for it
was included in -blockdev, but reverted in the previous commit due to
concerns about the QMP interface.  Revert it from -drive, too.

Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/rbd.c | 47 -----------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 103ce44..5a58d3e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -16,7 +16,6 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "block/block_int.h"
-#include "crypto/secret.h"
 #include "qemu/cutils.h"
 #include "qapi/qmp/qstring.h"
 
@@ -225,26 +224,6 @@ done:
     return;
 }
 
-
-static int qemu_rbd_set_auth(rados_t cluster, const char *secretid,
-                             Error **errp)
-{
-    if (secretid == 0) {
-        return 0;
-    }
-
-    gchar *secret = qcrypto_secret_lookup_as_base64(secretid,
-                                                    errp);
-    if (!secret) {
-        return -1;
-    }
-
-    rados_conf_set(cluster, "key", secret);
-    g_free(secret);
-
-    return 0;
-}
-
 static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs,
                                  Error **errp)
 {
@@ -322,11 +301,6 @@ static QemuOptsList runtime_opts = {
         /*
          * server.* extracted manually, see qemu_rbd_array_opts()
          */
-        {
-            .name = "password-secret",
-            .type = QEMU_OPT_STRING,
-            .help = "ID of secret providing the password",
-        },
 
         /*
          * Keys for qemu_rbd_parse_filename(), not in the QAPI schema
@@ -366,14 +340,11 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
     int64_t objsize;
     int obj_order = 0;
     const char *pool, *name, *conf, *clientname, *keypairs;
-    const char *secretid;
     rados_t cluster;
     rados_ioctx_t io_ctx;
     QDict *options = NULL;
     int ret = 0;
 
-    secretid = qemu_opt_get(opts, "password-secret");
-
     /* Read out options */
     bytes = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                      BDRV_SECTOR_SIZE);
@@ -426,11 +397,6 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
         goto shutdown;
     }
 
-    if (qemu_rbd_set_auth(cluster, secretid, errp) < 0) {
-        ret = -EIO;
-        goto shutdown;
-    }
-
     ret = rados_connect(cluster);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error connecting");
@@ -596,7 +562,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVRBDState *s = bs->opaque;
     const char *pool, *snap, *conf, *clientname, *name, *keypairs;
-    const char *secretid;
     QemuOpts *opts;
     Error *local_err = NULL;
     char *mon_host = NULL;
@@ -618,8 +583,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_opts;
     }
 
-    secretid = qemu_opt_get(opts, "password-secret");
-
     pool           = qemu_opt_get(opts, "pool");
     conf           = qemu_opt_get(opts, "conf");
     snap           = qemu_opt_get(opts, "snapshot");
@@ -661,11 +624,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    if (qemu_rbd_set_auth(s->cluster, secretid, errp) < 0) {
-        r = -EIO;
-        goto failed_shutdown;
-    }
-
     /*
      * Fallback to more conservative semantics if setting cache
      * options fails. Ignore errors from setting rbd_cache because the
@@ -1105,11 +1063,6 @@ static QemuOptsList qemu_rbd_create_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "RBD object size"
         },
-        {
-            .name = "password-secret",
-            .type = QEMU_OPT_STRING,
-            .help = "ID of secret providing the password",
-        },
         { /* end of list */ }
     }
 };
-- 
2.7.4
