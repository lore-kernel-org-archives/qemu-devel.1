Received: from eggs.gnu.org ([2001:4830:134:3::10]:34828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTTG6-0008A9-9T
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTTG5-0004wC-4O
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:29:54 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 16:29:44 +0200
Message-Id: <20180614142944.10084-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] block/crypto: Simplify block_crypto_{open,
 create}_opts_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, berrange@redhat.com

block_crypto_open_opts_init() and block_crypto_create_opts_init()
contain a virtual visit of QCryptoBlockOptions and
QCryptoBlockCreateOptions less member "format", respectively.

Change their callers to put member "format" in the QDict, so they can
use the generated visitors for these types instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/crypto.c | 95 ++++++--------------------------------------------
 block/crypto.h |  8 ++---
 block/qcow.c   |  5 ++-
 block/qcow2.c  | 10 +++---
 4 files changed, 18 insertions(+), 100 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index bc322b50f5..ea3b4aeb34 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -148,102 +148,26 @@ static QemuOptsList block_crypto_create_opts_luks = {
 
 
 QCryptoBlockOpenOptions *
-block_crypto_open_opts_init(QCryptoBlockFormat format,
-                            QDict *opts,
-                            Error **errp)
+block_crypto_open_opts_init(QDict *opts, Error **errp)
 {
     Visitor *v;
-    QCryptoBlockOpenOptions *ret = NULL;
-    Error *local_err = NULL;
-
-    ret = g_new0(QCryptoBlockOpenOptions, 1);
-    ret->format = format;
+    QCryptoBlockOpenOptions *ret;
 
     v = qobject_input_visitor_new_keyval(QOBJECT(opts));
-
-    visit_start_struct(v, NULL, NULL, 0, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    switch (format) {
-    case Q_CRYPTO_BLOCK_FORMAT_LUKS:
-        visit_type_QCryptoBlockOptionsLUKS_members(
-            v, &ret->u.luks, &local_err);
-        break;
-
-    case Q_CRYPTO_BLOCK_FORMAT_QCOW:
-        visit_type_QCryptoBlockOptionsQCow_members(
-            v, &ret->u.qcow, &local_err);
-        break;
-
-    default:
-        error_setg(&local_err, "Unsupported block format %d", format);
-        break;
-    }
-    if (!local_err) {
-        visit_check_struct(v, &local_err);
-    }
-
-    visit_end_struct(v, NULL);
-
- out:
-    if (local_err) {
-        error_propagate(errp, local_err);
-        qapi_free_QCryptoBlockOpenOptions(ret);
-        ret = NULL;
-    }
+    visit_type_QCryptoBlockOpenOptions(v, NULL, &ret, errp);
     visit_free(v);
     return ret;
 }
 
 
 QCryptoBlockCreateOptions *
-block_crypto_create_opts_init(QCryptoBlockFormat format,
-                              QDict *opts,
-                              Error **errp)
+block_crypto_create_opts_init(QDict *opts, Error **errp)
 {
     Visitor *v;
-    QCryptoBlockCreateOptions *ret = NULL;
-    Error *local_err = NULL;
-
-    ret = g_new0(QCryptoBlockCreateOptions, 1);
-    ret->format = format;
+    QCryptoBlockCreateOptions *ret;
 
     v = qobject_input_visitor_new_keyval(QOBJECT(opts));
-
-    visit_start_struct(v, NULL, NULL, 0, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    switch (format) {
-    case Q_CRYPTO_BLOCK_FORMAT_LUKS:
-        visit_type_QCryptoBlockCreateOptionsLUKS_members(
-            v, &ret->u.luks, &local_err);
-        break;
-
-    case Q_CRYPTO_BLOCK_FORMAT_QCOW:
-        visit_type_QCryptoBlockOptionsQCow_members(
-            v, &ret->u.qcow, &local_err);
-        break;
-
-    default:
-        error_setg(&local_err, "Unsupported block format %d", format);
-        break;
-    }
-    if (!local_err) {
-        visit_check_struct(v, &local_err);
-    }
-
-    visit_end_struct(v, NULL);
-
- out:
-    if (local_err) {
-        error_propagate(errp, local_err);
-        qapi_free_QCryptoBlockCreateOptions(ret);
-        ret = NULL;
-    }
+    visit_type_QCryptoBlockCreateOptions(v, NULL, &ret, errp);
     visit_free(v);
     return ret;
 }
@@ -281,8 +205,9 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     }
 
     cryptoopts = qemu_opts_to_qdict(opts, NULL);
+    qdict_put_str(cryptoopts, "format", QCryptoBlockFormat_str(format));
 
-    open_opts = block_crypto_open_opts_init(format, cryptoopts, errp);
+    open_opts = block_crypto_open_opts_init(cryptoopts, errp);
     if (!open_opts) {
         goto cleanup;
     }
@@ -605,8 +530,8 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
                                              &block_crypto_create_opts_luks,
                                              true);
 
-    create_opts = block_crypto_create_opts_init(Q_CRYPTO_BLOCK_FORMAT_LUKS,
-                                                cryptoopts, errp);
+    qdict_put_str(cryptoopts, "format", "luks");
+    create_opts = block_crypto_create_opts_init(cryptoopts, errp);
     if (!create_opts) {
         ret = -EINVAL;
         goto fail;
diff --git a/block/crypto.h b/block/crypto.h
index 0f985ea4e2..dd7d47903c 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -89,13 +89,9 @@
     }
 
 QCryptoBlockCreateOptions *
-block_crypto_create_opts_init(QCryptoBlockFormat format,
-                              QDict *opts,
-                              Error **errp);
+block_crypto_create_opts_init(QDict *opts, Error **errp);
 
 QCryptoBlockOpenOptions *
-block_crypto_open_opts_init(QCryptoBlockFormat format,
-                            QDict *opts,
-                            Error **errp);
+block_crypto_open_opts_init(QDict *opts, Error **errp);
 
 #endif /* BLOCK_CRYPTO_H__ */
diff --git a/block/qcow.c b/block/qcow.c
index 1f866af0d3..7a90d0ef9a 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -202,9 +202,8 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
                 ret = -EINVAL;
                 goto fail;
             }
-            qdict_del(encryptopts, "format");
-            crypto_opts = block_crypto_open_opts_init(
-                Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
+            qdict_put_str(encryptopts, "format", "qcow");
+            crypto_opts = block_crypto_open_opts_init(encryptopts, errp);
             if (!crypto_opts) {
                 ret = -EINVAL;
                 goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 6fa5e1d71a..e4ce74f29d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1039,9 +1039,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
             ret = -EINVAL;
             goto fail;
         }
-        qdict_del(encryptopts, "format");
-        r->crypto_opts = block_crypto_open_opts_init(
-            Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
+        qdict_put_str(encryptopts, "format", "qcow");
+        r->crypto_opts = block_crypto_open_opts_init(encryptopts, errp);
         break;
 
     case QCOW_CRYPT_LUKS:
@@ -1052,9 +1051,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
             ret = -EINVAL;
             goto fail;
         }
-        qdict_del(encryptopts, "format");
-        r->crypto_opts = block_crypto_open_opts_init(
-            Q_CRYPTO_BLOCK_FORMAT_LUKS, encryptopts, errp);
+        qdict_put_str(encryptopts, "format", "luks");
+        r->crypto_opts = block_crypto_open_opts_init(encryptopts, errp);
         break;
 
     default:
-- 
2.17.1
