Received: from eggs.gnu.org ([2001:4830:134:3::10]:45304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8d-0001Ge-4b
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8b-0005sg-HM
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:18:43 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:10 +0000
Message-Id: <20170126101827.22378-2-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/18] block: expose crypto option names /
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The block/crypto.c defines a set of QemuOpts that provide
parameters for encryption. This will also be needed by
the qcow/qcow2 integration, so expose the relevant pieces
in a new block/crypto.h header.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 61 +++++++--------------------------------
 block/crypto.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 50 deletions(-)
 create mode 100644 block/crypto.h

diff --git a/block/crypto.c b/block/crypto.c
index 7aa7eb5..d281de6 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -26,14 +26,7 @@
 #include "qapi/opts-visitor.h"
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
 
@@ -135,11 +128,7 @@ static QemuOptsList block_crypto_runtime_opts_luks = {
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
@@ -154,47 +143,19 @@ static QemuOptsList block_crypto_create_opts_luks = {
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
                             QemuOpts *opts,
                             Error **errp)
@@ -240,7 +201,7 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
 }
 
 
-static QCryptoBlockCreateOptions *
+QCryptoBlockCreateOptions *
 block_crypto_create_opts_init(QCryptoBlockFormat format,
                               QemuOpts *opts,
                               Error **errp)
diff --git a/block/crypto.h b/block/crypto.h
new file mode 100644
index 0000000..e42f20e
--- /dev/null
+++ b/block/crypto.h
@@ -0,0 +1,91 @@
+/*
+ * QEMU block full disk encryption
+ *
+ * Copyright (c) 2015-2016 Red Hat, Inc.
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
+                              QemuOpts *opts,
+                              Error **errp);
+
+QCryptoBlockOpenOptions *
+block_crypto_open_opts_init(QCryptoBlockFormat format,
+                            QemuOpts *opts,
+                            Error **errp);
+
+#endif /* BLOCK_CRYPTO_H__ */
-- 
2.9.3
