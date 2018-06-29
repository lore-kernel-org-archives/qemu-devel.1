Received: from eggs.gnu.org ([2001:4830:134:3::10]:49657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6X-0003yr-7b
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6S-0003zI-OD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:44 +0200
Message-Id: <20180629140959.6690-15-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/29] block/crypto: Simplify block_crypto_{open,
 create}_opts_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

block_crypto_open_opts_init() and block_crypto_create_opts_init()
contain a virtual visit of QCryptoBlockOptions and
QCryptoBlockCreateOptions less member "format", respectively.

Change their callers to put member "format" in the QDict, so they can
use the generated visitors for these types instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.h |  8 ++---
 block/crypto.c | 99 +++++++++-------------------------------------------------
 block/qcow.c   |  5 ++-
 block/qcow2.c  | 10 +++---
 4 files changed, 22 insertions(+), 100 deletions(-)

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
diff --git a/block/crypto.c b/block/crypto.c
index 210c80d5c7..994172a3de 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -148,108 +148,36 @@ static QemuOptsList block_crypto_create_opts_luks = {
 
 
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
 
-    v = qobject_input_visitor_new_flat_confused(opts, &local_err);
+    v = qobject_input_visitor_new_flat_confused(opts, errp);
     if (!v) {
-        goto out;
-    }
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
+        return NULL;
     }
 
-    visit_end_struct(v, NULL);
+    visit_type_QCryptoBlockOpenOptions(v, NULL, &ret, errp);
 
- out:
-    if (local_err) {
-        error_propagate(errp, local_err);
-        qapi_free_QCryptoBlockOpenOptions(ret);
-        ret = NULL;
-    }
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
 
-    v = qobject_input_visitor_new_flat_confused(opts, &local_err);
+    v = qobject_input_visitor_new_flat_confused(opts, errp);
     if (!v) {
-        goto out;
-    }
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
+        return NULL;
     }
 
-    visit_end_struct(v, NULL);
+    visit_type_QCryptoBlockCreateOptions(v, NULL, &ret, errp);
 
- out:
-    if (local_err) {
-        error_propagate(errp, local_err);
-        qapi_free_QCryptoBlockCreateOptions(ret);
-        ret = NULL;
-    }
     visit_free(v);
     return ret;
 }
@@ -287,8 +215,9 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     }
 
     cryptoopts = qemu_opts_to_qdict(opts, NULL);
+    qdict_put_str(cryptoopts, "format", QCryptoBlockFormat_str(format));
 
-    open_opts = block_crypto_open_opts_init(format, cryptoopts, errp);
+    open_opts = block_crypto_open_opts_init(cryptoopts, errp);
     if (!open_opts) {
         goto cleanup;
     }
@@ -612,8 +541,8 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
                                              &block_crypto_create_opts_luks,
                                              true);
 
-    create_opts = block_crypto_create_opts_init(Q_CRYPTO_BLOCK_FORMAT_LUKS,
-                                                cryptoopts, errp);
+    qdict_put_str(cryptoopts, "format", "luks");
+    create_opts = block_crypto_create_opts_init(cryptoopts, errp);
     if (!create_opts) {
         ret = -EINVAL;
         goto fail;
diff --git a/block/qcow.c b/block/qcow.c
index 5532731b9f..8546fe5bb7 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -203,9 +203,8 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
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
index 2d190aa00b..78aeb1f9ea 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1040,9 +1040,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
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
@@ -1053,9 +1052,8 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
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
2.13.6
