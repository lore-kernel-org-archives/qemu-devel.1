Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQrx-0002sh-8O
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXQru-0008Pn-I5
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 08:45:21 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 25 Jun 2018 09:42:36 -0300
Message-Id: <20180625124238.25339-45-f4bug@amsat.org>
In-Reply-To: <20180625124238.25339-1-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 44/46] tests/crypto: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/benchmark-crypto-cipher.c | 6 +++---
 tests/benchmark-crypto-hash.c   | 5 +++--
 tests/benchmark-crypto-hmac.c   | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cipher.c
index cf98443468..f5a0d0bc32 100644
--- a/tests/benchmark-crypto-cipher.c
+++ b/tests/benchmark-crypto-cipher.c
@@ -11,6 +11,7 @@
  * top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "crypto/init.h"
 #include "crypto/cipher.h"
 
@@ -56,8 +57,7 @@ static void test_cipher_speed(const void *opaque)
         total += chunk_size;
     } while (g_test_timer_elapsed() < 5.0);
 
-    total /= 1024 * 1024; /* to MB */
-
+    total /= MiB;
     g_print("cbc(aes128): ");
     g_print("Testing chunk_size %zu bytes ", chunk_size);
     g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
@@ -78,7 +78,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     g_assert(qcrypto_init(NULL) == 0);
 
-    for (i = 512; i <= (64 * 1204); i *= 2) {
+    for (i = 512; i <= 64 * KiB; i *= 2) {
         memset(name, 0 , sizeof(name));
         snprintf(name, sizeof(name), "/crypto/cipher/speed-%zu", i);
         g_test_add_data_func(name, (void *)i, test_cipher_speed);
diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.c
index 122bfb6b85..9b6f7a9155 100644
--- a/tests/benchmark-crypto-hash.c
+++ b/tests/benchmark-crypto-hash.c
@@ -11,6 +11,7 @@
  * top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "crypto/init.h"
 #include "crypto/hash.h"
 
@@ -39,7 +40,7 @@ static void test_hash_speed(const void *opaque)
         total += chunk_size;
     } while (g_test_timer_elapsed() < 5.0);
 
-    total /= 1024 * 1024; /* to MB */
+    total /= MiB;
     g_print("sha256: ");
     g_print("Testing chunk_size %zu bytes ", chunk_size);
     g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
@@ -57,7 +58,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     g_assert(qcrypto_init(NULL) == 0);
 
-    for (i = 512; i <= (64 * 1204); i *= 2) {
+    for (i = 512; i <= 64 * KiB; i *= 2) {
         memset(name, 0 , sizeof(name));
         snprintf(name, sizeof(name), "/crypto/hash/speed-%zu", i);
         g_test_add_data_func(name, (void *)i, test_hash_speed);
diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.c
index c30250df3e..f1dfa240cb 100644
--- a/tests/benchmark-crypto-hmac.c
+++ b/tests/benchmark-crypto-hmac.c
@@ -11,6 +11,7 @@
  * top-level directory.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "crypto/init.h"
 #include "crypto/hmac.h"
 
@@ -53,8 +54,7 @@ static void test_hmac_speed(const void *opaque)
         total += chunk_size;
     } while (g_test_timer_elapsed() < 5.0);
 
-    total /= 1024 * 1024; /* to MB */
-
+    total /= MiB;
     g_print("hmac(sha256): ");
     g_print("Testing chunk_size %zu bytes ", chunk_size);
     g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
@@ -72,7 +72,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     g_assert(qcrypto_init(NULL) == 0);
 
-    for (i = 512; i <= (64 * 1204); i *= 2) {
+    for (i = 512; i <= 64 * KiB; i *= 2) {
         memset(name, 0 , sizeof(name));
         snprintf(name, sizeof(name), "/crypto/hmac/speed-%zu", i);
         g_test_add_data_func(name, (void *)i, test_hmac_speed);
-- 
2.18.0
