Received: from eggs.gnu.org ([2001:4830:134:3::10]:45328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8e-0001I6-Ic
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8d-0005up-3K
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:18:44 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:11 +0000
Message-Id: <20170126101827.22378-3-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/18] block: add ability to set a prefix
 for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

When integrating the crypto support with qcow/qcow2, we don't
want to use the bare LUKS option names "hash-alg", "key-secret",
etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
so that they don't clash with any general qcow options at a later
date.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 block/crypto.h |  42 +++++++++++-----------
 2 files changed, 119 insertions(+), 34 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index d281de6..876eabc 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -27,6 +27,7 @@
 #include "qapi-visit.h"
 #include "qapi/error.h"
 #include "block/crypto.h"
+#include "qemu/cutils.h"
 
 typedef struct BlockCrypto BlockCrypto;
 
@@ -128,7 +129,7 @@ static QemuOptsList block_crypto_runtime_opts_luks = {
     .name = "crypto",
     .head = QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.head),
     .desc = {
-        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),
         { /* end of list */ }
     },
 };
@@ -143,31 +144,101 @@ static QemuOptsList block_crypto_create_opts_luks = {
             .type = QEMU_OPT_SIZE,
             .help = "Virtual disk size"
         },
-        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG,
-        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(""),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(""),
         { /* end of list */ }
     },
 };
 
+static QemuOptsList empty_opts = {
+    .name = "crypto-empty",
+    .merge_lists = false,
+    .head = QTAILQ_HEAD_INITIALIZER(empty_opts.head),
+    .desc = {
+        /* no elements => accept any params */
+        { /* end of list */ }
+    },
+};
+
+
+struct BlockCryptoCopyData {
+    QemuOpts *opts;
+    const char *prefix;
+};
+
+static int block_crypto_copy_value(void *opaque, const char *name,
+                                   const char *value, Error **errp)
+{
+    struct BlockCryptoCopyData *data = opaque;
+    const char *newname;
+
+    if (strstart(name, data->prefix, &newname)) {
+        Error *local_err = NULL;
+
+        qemu_opt_set(data->opts, newname, value, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+/*
+ * Create a copy of @opts containing only the fields with
+ * a prefix of @prefix, stripping the prefix in the returned
+ * opts
+ */
+static QemuOpts *
+block_crypto_copy_opts(QemuOpts *opts,
+                       const char *prefix,
+                       Error **errp)
+{
+    struct BlockCryptoCopyData data = {
+        .opts = qemu_opts_create(&empty_opts, NULL, false, errp),
+        .prefix = prefix
+    };
+    if (!data.opts) {
+        return NULL;
+    }
+
+    if (qemu_opt_foreach(opts, block_crypto_copy_value, &data, errp) < 0) {
+        qemu_opts_del(data.opts);
+        return NULL;
+    }
+
+    return data.opts;
+}
 
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QCryptoBlockFormat format,
                             QemuOpts *opts,
+                            const char *prefix,
                             Error **errp)
 {
-    Visitor *v;
+    Visitor *v = NULL;
     QCryptoBlockOpenOptions *ret = NULL;
     Error *local_err = NULL;
+    QemuOpts *newopts = NULL;
 
     ret = g_new0(QCryptoBlockOpenOptions, 1);
     ret->format = format;
 
-    v = opts_visitor_new(opts);
+    if (prefix != NULL) {
+        newopts = block_crypto_copy_opts(opts, prefix, &local_err);
+        if (local_err) {
+            goto out;
+        }
+        v = opts_visitor_new(newopts);
+    } else {
+        v = opts_visitor_new(opts);
+    }
 
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
@@ -196,6 +267,7 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
         qapi_free_QCryptoBlockOpenOptions(ret);
         ret = NULL;
     }
+    qemu_opts_del(newopts);
     visit_free(v);
     return ret;
 }
@@ -204,16 +276,26 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
 QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QCryptoBlockFormat format,
                               QemuOpts *opts,
+                              const char *prefix,
                               Error **errp)
 {
-    Visitor *v;
+    Visitor *v = NULL;
     QCryptoBlockCreateOptions *ret = NULL;
     Error *local_err = NULL;
+    QemuOpts *newopts = NULL;
 
     ret = g_new0(QCryptoBlockCreateOptions, 1);
     ret->format = format;
 
-    v = opts_visitor_new(opts);
+    if (prefix != NULL) {
+        newopts = block_crypto_copy_opts(opts, prefix, &local_err);
+        if (local_err) {
+            goto out;
+        }
+        v = opts_visitor_new(newopts);
+    } else {
+        v = opts_visitor_new(opts);
+    }
 
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
@@ -242,6 +324,7 @@ block_crypto_create_opts_init(QCryptoBlockFormat format,
         qapi_free_QCryptoBlockCreateOptions(ret);
         ret = NULL;
     }
+    qemu_opts_del(newopts);
     visit_free(v);
     return ret;
 }
@@ -268,7 +351,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         goto cleanup;
     }
 
-    open_opts = block_crypto_open_opts_init(format, opts, errp);
+    open_opts = block_crypto_open_opts_init(format, opts, NULL, errp);
     if (!open_opts) {
         goto cleanup;
     }
@@ -312,7 +395,7 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
         .filename = filename,
     };
 
-    create_opts = block_crypto_create_opts_init(format, opts, errp);
+    create_opts = block_crypto_create_opts_init(format, opts, NULL, errp);
     if (!create_opts) {
         return -1;
     }
diff --git a/block/crypto.h b/block/crypto.h
index e42f20e..e70e2f0 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -29,51 +29,51 @@
 #define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET                            \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(prefix)                    \
     {                                                                   \
-        .name = BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,                       \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,                \
         .type = QEMU_OPT_STRING,                                        \
         .help = "ID of the secret that provides the keyslot passphrase", \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG               \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG(prefix)       \
     {                                                      \
-        .name = BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG,          \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG,   \
         .type = QEMU_OPT_STRING,                           \
         .help = "Name of encryption cipher algorithm",     \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE         \
-    {                                                 \
-        .name = BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE,    \
-        .type = QEMU_OPT_STRING,                      \
-        .help = "Name of encryption cipher mode",     \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE(prefix)      \
+    {                                                      \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE,  \
+        .type = QEMU_OPT_STRING,                           \
+        .help = "Name of encryption cipher mode",          \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG           \
-    {                                                 \
-        .name = BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG,      \
-        .type = QEMU_OPT_STRING,                      \
-        .help = "Name of IV generator algorithm",     \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG(prefix)     \
+    {                                                   \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG, \
+        .type = QEMU_OPT_STRING,                        \
+        .help = "Name of IV generator algorithm",       \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG                \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG(prefix)        \
     {                                                           \
-        .name = BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG,           \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG,    \
         .type = QEMU_OPT_STRING,                                \
         .help = "Name of IV generator hash algorithm",          \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG               \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG(prefix)       \
     {                                                    \
-        .name = BLOCK_CRYPTO_OPT_LUKS_HASH_ALG,          \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_HASH_ALG,   \
         .type = QEMU_OPT_STRING,                         \
         .help = "Name of encryption hash algorithm",     \
     }
 
-#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME                   \
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME(prefix)           \
     {                                                         \
-        .name = BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,              \
+        .name = prefix BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,       \
         .type = QEMU_OPT_NUMBER,                              \
         .help = "Time to spend in PBKDF in milliseconds",     \
     }
@@ -81,11 +81,13 @@
 QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QCryptoBlockFormat format,
                               QemuOpts *opts,
+                              const char *prefix,
                               Error **errp);
 
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QCryptoBlockFormat format,
                             QemuOpts *opts,
+                            const char *prefix,
                             Error **errp);
 
 #endif /* BLOCK_CRYPTO_H__ */
-- 
2.9.3
