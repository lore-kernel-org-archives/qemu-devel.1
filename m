Received: from eggs.gnu.org ([2001:4830:134:3::10]:38271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96a-0004hF-Oj
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96W-00037P-QX
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:32 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96W-00034t-Iz
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:28 -0400
Received: by mail-wr0-x229.google.com with SMTP id a12-v6so10656909wro.1
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:37 +0200
Message-Id: <20180630061040.6018-45-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 44/47] tests/crypto: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -n '[<>][<>]= ?[1-5]0'

and modified manually.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-45-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/benchmark-crypto-cipher.c | 6 +++---
 tests/benchmark-crypto-hash.c   | 5 +++--
 tests/benchmark-crypto-hmac.c   | 6 +++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cipher.c
index cf98443..f5a0d0b 100644
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
index 122bfb6..9b6f7a9 100644
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
index c30250d..f1dfa24 100644
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
1.8.3.1
