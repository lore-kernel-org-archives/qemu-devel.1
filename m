Received: from eggs.gnu.org ([2001:4830:134:3::10]:57310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1d2i9a-0005bA-7d
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1d2i9W-0003VT-8a
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:52:02 -0400
Received: from mout.web.de ([212.227.15.3]:55515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gm.ijewski@web.de>) id 1d2i9V-0003Tl-SO
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:51:58 -0400
From: Geert Martin Ijewski <gm.ijewski@web.de>
Message-ID: <faa27752-45a9-e6f3-d6fc-cad8254c4f31@web.de>
Date: Mon, 24 Apr 2017 19:51:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] crypto_gen_random() now also works on
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

If no crypto library is included in the build QEMU uses 
qcrypto_random_bytes() to generate random data. That function tried to 
open /dev/urandom or /dev/random and if openeing neither file worked it 
errored out.

Those files obviously do not exist on windows, so there the code now 
uses CryptGenRandom().

Furthermore there was some refactoring and a new function 
qcrypto_random_init() was introduced, that initalizes (platform 
specific) handles that are used by qcrypto_random_bytes().

Signed-off-by: Geert Martin Ijewski <gm.ijewski@web.de>
---
  crypto/init.c            |  6 ++++++
  crypto/random-platform.c | 45 
+++++++++++++++++++++++++++++++++++++--------
  include/crypto/random.h  |  9 +++++++++
  3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/crypto/init.c b/crypto/init.c
index f65207e..f131c42
--- a/crypto/init.c
+++ b/crypto/init.c
@@ -32,6 +32,8 @@
  #include <gcrypt.h>
  #endif

+#include "crypto/random.h"
+
  /* #define DEBUG_GNUTLS */

  /*
@@ -146,5 +148,9 @@ int qcrypto_init(Error **errp)
      gcry_control(GCRYCTL_INITIALIZATION_FINISHED, 0);
  #endif

+    if (qcrypto_random_init(errp) < 0) {
+        return -1;
+    }
+
      return 0;
  }
diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 82b755a..49d7f80
@@ -22,14 +22,23 @@

  #include "crypto/random.h"

-int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
-                         size_t buflen G_GNUC_UNUSED,
-                         Error **errp)
-{
-    int fd;
-    int ret = -1;
-    int got;
+#ifdef _WIN32
+#include <Wincrypt.h>
+HCRYPTPROV hCryptProv;
+#else
+int fd; /* a file handle to either /dev/urandom or /dev/random */
+#endif

+int qcrypto_random_init(Error **errp)
+{
+#ifdef _WIN32
+    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL,
+                             CRYPT_SILENT | CRYPT_VERIFYCONTEXT)) {
+        error_setg_errno(errp, GetLastError(),
+                         "Unable to create cryptographic provider");
+        return -1;
+    }
+#else
      /* TBD perhaps also add support for BSD getentropy / Linux
       * getrandom syscalls directly */
      fd = open("/dev/urandom", O_RDONLY);
@@ -41,6 +50,18 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
          error_setg(errp, "No /dev/urandom or /dev/random found");
          return -1;
      }
+#endif
+
+    return 0;
+}
+
+int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
+                         size_t buflen G_GNUC_UNUSED,
+                         Error **errp)
+{
+#ifndef _WIN32
+    int ret = -1;
+    int got;

      while (buflen > 0) {
          got = read(fd, buf, buflen);
@@ -59,6 +80,14 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,

      ret = 0;
   cleanup:
-    close(fd);
      return ret;
+#else
+    if (!CryptGenRandom(hCryptProv, buflen, buf)) {
+        error_setg_errno(errp, GetLastError(),
+                         "Unable to read random bytes");
+        return -1;
+    }
+
+    return 0;
+#endif
  }
diff --git a/include/crypto/random.h b/include/crypto/random.h
index a101353..82a3209
--- a/include/crypto/random.h
+++ b/include/crypto/random.h
@@ -40,5 +40,14 @@ int qcrypto_random_bytes(uint8_t *buf,
                           size_t buflen,
                           Error **errp);

+/**
+ * qcrypto_random_init:
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Initalizes the handles used by qcrypto_random_bytes
+ *
+ * Returns 0 on success, -1 on error
+ */
+int qcrypto_random_init(Error **errp);

  #endif /* QCRYPTO_RANDOM_H */
-- 
1.9.1
