Received: from eggs.gnu.org ([2001:4830:134:3::10]:33052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dORNv-0003AT-9V
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dORNu-0000jP-6f
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:24:39 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 23 Jun 2017 17:24:01 +0100
Message-Id: <20170623162419.26068-3-berrange@redhat.com>
In-Reply-To: <20170623162419.26068-1-berrange@redhat.com>
References: <20170623162419.26068-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v10 02/20] block: add ability to set a prefix
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "Daniel P. Berrange" <berrange@redhat.com>

When integrating the crypto support with qcow/qcow2, we don't
want to use the bare LUKS option names "hash-alg", "key-secret",
etc. We need to namespace them to match the nested QAPI schema.

e.g. "encrypt.hash-alg", "encrypt.key-secret"

so that they don't clash with any general qcow options at a later
date.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 16 ++++++++--------
 block/crypto.h | 40 ++++++++++++++++++++--------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index ea40ba4..9df1e5d 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -129,7 +129,7 @@ static QemuOptsList block_crypto_runtime_opts_luks = {
     .name = "crypto",
     .head = QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.head),
     .desc = {
-        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET,
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),
         { /* end of list */ }
     },
 };
@@ -144,13 +144,13 @@ static QemuOptsList block_crypto_create_opts_luks = {
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
diff --git a/block/crypto.h b/block/crypto.h
index c0e9b54..3430dcd 100644
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
-- 
2.9.3
