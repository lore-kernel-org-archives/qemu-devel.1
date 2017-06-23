Received: from eggs.gnu.org ([2001:4830:134:3::10]:33040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dORNu-00039R-9F
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dORNs-0000hD-R2
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:24:38 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 23 Jun 2017 17:24:00 +0100
Message-Id: <20170623162419.26068-2-berrange@redhat.com>
In-Reply-To: <20170623162419.26068-1-berrange@redhat.com>
References: <20170623162419.26068-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v10 01/20] block: expose crypto option names /
 defs to other drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "Daniel P. Berrange" <berrange@redhat.com>

The block/crypto.c defines a set of QemuOpts that provide
parameters for encryption. This will also be needed by
the qcow/qcow2 integration, so expose the relevant pieces
in a new block/crypto.h header. Some helper methods taking
QemuOpts are changed to take QDict to simplify usage in
other places.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 82 +++++++++++++++++-----------------------------------
 block/crypto.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 56 deletions(-)
 create mode 100644 block/crypto.h

diff --git a/block/crypto.c b/block/crypto.c
index 10e5ddc..ea40ba4 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -24,16 +24,10 @@
 #include "sysemu/block-backend.h"
 #include "crypto/block.h"
 #include "qapi/opts-visitor.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qapi-visit.h"
 #include "qapi/error.h"
-
-#define BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET "key-secret"
-#define BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG "cipher-alg"
-#define BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE "cipher-mode"
-#define BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG "ivgen-alg"
-#define BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG "ivgen-hash-alg"
-#define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
-#define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
+#include "block/crypto.h"
 
 typedef struct BlockCrypto BlockCrypto;
 
@@ -135,11 +129,7 @@ static QemuOptsList block_crypto_runtime_opts_luks = {
     .name = "crypto",
     .head = QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.head),
     .desc = {
-        {
-            .name = BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,
-            .type = QEMU_OPT_STRING,
-            .help = "ID of the secret that provides the encryption key",
-        },
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET,
         { /* end of list */ }
     },
 };
@@ -154,49 +144,21 @@ static QemuOptsList block_crypto_create_opts_luks = {
             .type = QEMU_OPT_SIZE,
             .help = "Virtual disk size"
         },
-        {
-            .name = BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,
-            .type = QEMU_OPT_STRING,
-            .help = "ID of the secret that provides the encryption key",
-        },
-        {
-            .name = BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG,
-            .type = QEMU_OPT_STRING,
-            .help = "Name of encryption cipher algorithm",
-        },
-        {
-            .name = BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE,
-            .type = QEMU_OPT_STRING,
-            .help = "Name of encryption cipher mode",
-        },
-        {
-            .name = BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG,
-            .type = QEMU_OPT_STRING,
-            .help = "Name of IV generator algorithm",
-        },
-        {
-            .name = BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG,
-            .type = QEMU_OPT_STRING,
-            .help = "Name of IV generator hash algorithm",
-        },
-        {
-            .name = BLOCK_CRYPTO_OPT_LUKS_HASH_ALG,
-            .type = QEMU_OPT_STRING,
-            .help = "Name of encryption hash algorithm",
-        },
-        {
-            .name = BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,
-            .type = QEMU_OPT_NUMBER,
-            .help = "Time to spend in PBKDF in milliseconds",
-        },
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME,
         { /* end of list */ }
     },
 };
 
 
-static QCryptoBlockOpenOptions *
+QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QCryptoBlockFormat format,
-                            QemuOpts *opts,
+                            QDict *opts,
                             Error **errp)
 {
     Visitor *v;
@@ -206,7 +168,7 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
     ret = g_new0(QCryptoBlockOpenOptions, 1);
     ret->format = format;
 
-    v = opts_visitor_new(opts);
+    v = qobject_input_visitor_new_keyval(QOBJECT(opts));
 
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
@@ -240,9 +202,9 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
 }
 
 
-static QCryptoBlockCreateOptions *
+QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QCryptoBlockFormat format,
-                              QemuOpts *opts,
+                              QDict *opts,
                               Error **errp)
 {
     Visitor *v;
@@ -252,7 +214,7 @@ block_crypto_create_opts_init(QCryptoBlockFormat format,
     ret = g_new0(QCryptoBlockCreateOptions, 1);
     ret->format = format;
 
-    v = opts_visitor_new(opts);
+    v = qobject_input_visitor_new_keyval(QOBJECT(opts));
 
     visit_start_struct(v, NULL, NULL, 0, &local_err);
     if (local_err) {
@@ -299,6 +261,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     int ret = -EINVAL;
     QCryptoBlockOpenOptions *open_opts = NULL;
     unsigned int cflags = 0;
+    QDict *cryptoopts = NULL;
 
     bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
                                false, errp);
@@ -313,7 +276,9 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         goto cleanup;
     }
 
-    open_opts = block_crypto_open_opts_init(format, opts, errp);
+    cryptoopts = qemu_opts_to_qdict(opts, NULL);
+
+    open_opts = block_crypto_open_opts_init(format, cryptoopts, errp);
     if (!open_opts) {
         goto cleanup;
     }
@@ -337,6 +302,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 
     ret = 0;
  cleanup:
+    QDECREF(cryptoopts);
     qapi_free_QCryptoBlockOpenOptions(open_opts);
     return ret;
 }
@@ -356,8 +322,11 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
         .opts = opts,
         .filename = filename,
     };
+    QDict *cryptoopts;
+
+    cryptoopts = qemu_opts_to_qdict(opts, NULL);
 
-    create_opts = block_crypto_create_opts_init(format, opts, errp);
+    create_opts = block_crypto_create_opts_init(format, cryptoopts, errp);
     if (!create_opts) {
         return -1;
     }
@@ -375,6 +344,7 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
 
     ret = 0;
  cleanup:
+    QDECREF(cryptoopts);
     qcrypto_block_free(crypto);
     blk_unref(data.blk);
     qapi_free_QCryptoBlockCreateOptions(create_opts);
diff --git a/block/crypto.h b/block/crypto.h
new file mode 100644
index 0000000..c0e9b54
--- /dev/null
+++ b/block/crypto.h
@@ -0,0 +1,91 @@
+/*
+ * QEMU block full disk encryption
+ *
+ * Copyright (c) 2015-2017 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef BLOCK_CRYPTO_H__
+#define BLOCK_CRYPTO_H__
+
+#define BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET "key-secret"
+#define BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG "cipher-alg"
+#define BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE "cipher-mode"
+#define BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG "ivgen-alg"
+#define BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG "ivgen-hash-alg"
+#define BLOCK_CRYPTO_OPT_LUKS_HASH_ALG "hash-alg"
+#define BLOCK_CRYPTO_OPT_LUKS_ITER_TIME "iter-time"
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET                            \
+    {                                                                   \
+        .name = BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET,                       \
+        .type = QEMU_OPT_STRING,                                        \
+        .help = "ID of the secret that provides the keyslot passphrase", \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG               \
+    {                                                      \
+        .name = BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG,          \
+        .type = QEMU_OPT_STRING,                           \
+        .help = "Name of encryption cipher algorithm",     \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE         \
+    {                                                 \
+        .name = BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE,    \
+        .type = QEMU_OPT_STRING,                      \
+        .help = "Name of encryption cipher mode",     \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG           \
+    {                                                 \
+        .name = BLOCK_CRYPTO_OPT_LUKS_IVGEN_ALG,      \
+        .type = QEMU_OPT_STRING,                      \
+        .help = "Name of IV generator algorithm",     \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG                \
+    {                                                           \
+        .name = BLOCK_CRYPTO_OPT_LUKS_IVGEN_HASH_ALG,           \
+        .type = QEMU_OPT_STRING,                                \
+        .help = "Name of IV generator hash algorithm",          \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG               \
+    {                                                    \
+        .name = BLOCK_CRYPTO_OPT_LUKS_HASH_ALG,          \
+        .type = QEMU_OPT_STRING,                         \
+        .help = "Name of encryption hash algorithm",     \
+    }
+
+#define BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME                   \
+    {                                                         \
+        .name = BLOCK_CRYPTO_OPT_LUKS_ITER_TIME,              \
+        .type = QEMU_OPT_NUMBER,                              \
+        .help = "Time to spend in PBKDF in milliseconds",     \
+    }
+
+QCryptoBlockCreateOptions *
+block_crypto_create_opts_init(QCryptoBlockFormat format,
+                              QDict *opts,
+                              Error **errp);
+
+QCryptoBlockOpenOptions *
+block_crypto_open_opts_init(QCryptoBlockFormat format,
+                            QDict *opts,
+                            Error **errp);
+
+#endif /* BLOCK_CRYPTO_H__ */
-- 
2.9.3
