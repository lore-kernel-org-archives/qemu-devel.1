Received: from eggs.gnu.org ([2001:4830:134:3::10]:58206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1d38kT-0007s9-QU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gm.ijewski@web.de>) id 1d38kP-0001St-Lr
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:15:53 -0400
Received: from mout.web.de ([212.227.15.14]:65437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gm.ijewski@web.de>) id 1d38kP-0001Rw-AP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:15:49 -0400
From: Geert Martin Ijewski <gm.ijewski@web.de>
Date: Wed, 26 Apr 2017 00:15:01 +0200
Message-Id: <1493158501-22284-1-git-send-email-gm.ijewski@web.de>
Subject: [Qemu-devel] [PATCH v5] crypto: qcrypto_random_bytes() now works on
 windows w/o any other crypto libs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Geert Martin Ijewski <gm.ijewski@web.de>, "Daniel P. Berrange" <berrange@redhat.com>

If no crypto library is included in the build, QEMU uses
qcrypto_random_bytes() to generate random data. That function tried to open
/dev/urandom or /dev/random and if opening both files failed it errored out.

Those files obviously do not exist on windows, so there the code uses
CryptGenRandom().

Furthermore there was some refactoring and a new function
qcrypto_random_init() was introduced. If a proper crypto library (gnutls or
libgcrypt) is included in the build, this function does nothing. If neither
is included it initializes the (platform specific) handles that are used by
qcrypto_random_bytes().
Either:
* a handle to /dev/urandom | /dev/random on unix like systems
* a handle to a cryptographic service provider on windows

Signed-off-by: Geert Martin Ijewski <gm.ijewski@web.de>
---
 crypto/init.c            |  6 ++++++
 crypto/random-gcrypt.c   |  2 ++
 crypto/random-gnutls.c   |  3 +++
 crypto/random-platform.c | 45 +++++++++++++++++++++++++++++++++++++--------
 include/crypto/random.h  |  9 +++++++++
 5 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/crypto/init.c b/crypto/init.c
index f65207e..f131c42 100644
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
diff --git a/crypto/random-gcrypt.c b/crypto/random-gcrypt.c
index 0de9a09..9f1c9ee 100644
--- a/crypto/random-gcrypt.c
+++ b/crypto/random-gcrypt.c
@@ -31,3 +31,5 @@ int qcrypto_random_bytes(uint8_t *buf,
     gcry_randomize(buf, buflen, GCRY_STRONG_RANDOM);
     return 0;
 }
+
+int qcrypto_random_init(Error **errp G_GNUC_UNUSED) { return 0; }
diff --git a/crypto/random-gnutls.c b/crypto/random-gnutls.c
index 04b45a8..5350003 100644
--- a/crypto/random-gnutls.c
+++ b/crypto/random-gnutls.c
@@ -41,3 +41,6 @@ int qcrypto_random_bytes(uint8_t *buf,
 
     return 0;
 }
+
+
+int qcrypto_random_init(Error **errp G_GNUC_UNUSED) { return 0; }
diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 82b755a..0eddb91 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -22,14 +22,16 @@
 
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
+static HCRYPTPROV hCryptProv;
+#else
+static int fd; /* a file handle to either /dev/urandom or /dev/random */
+#endif
 
+int qcrypto_random_init(Error **errp)
+{
+#ifndef _WIN32
     /* TBD perhaps also add support for BSD getentropy / Linux
      * getrandom syscalls directly */
     fd = open("/dev/urandom", O_RDONLY);
@@ -41,6 +43,25 @@ int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
         error_setg(errp, "No /dev/urandom or /dev/random found");
         return -1;
     }
+#else
+    if (!CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL,
+                             CRYPT_SILENT | CRYPT_VERIFYCONTEXT)) {
+        error_setg_win32(errp, GetLastError(),
+                         "Unable to create cryptographic provider");
+        return -1;
+    }
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
+        error_setg_win32(errp, GetLastError(),
+                         "Unable to read random bytes");
+        return -1;
+    }
+
+    return 0;
+#endif
 }
diff --git a/include/crypto/random.h b/include/crypto/random.h
index a101353..a07229c 100644
--- a/include/crypto/random.h
+++ b/include/crypto/random.h
@@ -40,5 +40,14 @@ int qcrypto_random_bytes(uint8_t *buf,
                          size_t buflen,
                          Error **errp);
 
+/**
+ * qcrypto_random_init:
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Initializes the handles used by qcrypto_random_bytes
+ *
+ * Returns 0 on success, -1 on error
+ */
+int qcrypto_random_init(Error **errp);
 
 #endif /* QCRYPTO_RANDOM_H */
-- 
2.10.1.windows.1
